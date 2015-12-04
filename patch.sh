if ls patches/*.patch >/dev/null 2>&1 ; then
echo =============== begin to patch source code ===============
for i in patches/*.patch
do
	echo -ne "\033[01;33mapply $i...\033[00m"
	patch -f -p1 <$i >/dev/null 2>&1
	res=$?
	if [ $res -ne 0 ]; then
		echo -e "\033[01;31mfailed\033[00m"
		echo -ne " \033[01;33mtry to reverse apply $i...\033[00m"
		patch -f -p1 -R <$i >/dev/null 2>&1 && patch -f -p1 <$i >/dev/null 2>&1
		res1=$?
		if [ $res1 -ne 0 ]; then
			echo -e " \033[01;31mfailed, please check your patch: [$i]\033[00m"
			exit -1
		else
			echo -e " \033[01;32msuccess\033[00m"
		fi
	else
		echo -e "\033[01;32msuccess\033[00m"
	fi
done
echo =============== finished patch source code ===============
fi
