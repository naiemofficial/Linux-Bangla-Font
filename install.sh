#!/bin/bash
#-------------------------------
#	Developed by "**Abdullah Al Naiem**" (inspo: Fahad Ahmed)
# 	Facebook	: https://facebook.com/naiemofficial
# 	Instagram	: https://instagram.com/naiemofficial
# 	Web			: https//naiem.info
#-------------------------------


echo -e "
╔═════════════════════════════════════════════════╗
║   ___________________________________________   ║
║  |_____ _____ _____  ______________ ____ ____|  ║
║      /   |  | |   / _ \            | |  | |     ║
║     /    |  | |  | |_| |           | |  | |     ║
║    /  /| |  | |   \___/    ____  __| |  | |     ║
║   |  | | |  | |    __     / __ \/    |  | |     ║
║    \ \ | |  | |   |_ |   / /  \__/\`| |  | |     ║
║     \ \| |  | |     \ \  \  \`-     | |  | |     ║
║      \___|  |_|      \_\  *---^    |_|  |_|     ║
║                                                 ║
║                                                 ║
║      Visit http://www.naiem.info ...!           ║
║                                                 ║
╚═════════════════════════════════════════════════╝
\n\n"

echo -e "[[**DISCLAIMER**]]: You're excuting script to install Bengali Fonts in Linux operating system. Be aware that all scripts are run at your own risk and while every script has been written with the intention of minimising the potential for unintended consequences, the owners, hosting providers and contributers cannot be held responsible for any misuse or script problems.\n"


read -p 'Do you want to continue? [Y/n]: ' confirm




if [ $confirm = "Y" ] || [ $confirm = "y" ] || [ $confirm = "YES" ] || [ $confirm = "yes" ]; 
then
	spinner () {
		sleep 3 & perl -e '$|=@s=qw('$@'-⏺⊙⊙⊙⊙ '$@'\⊙⏺⊙⊙⊙ '$@'|⊙⊙⏺⊙⊙ '$@'/⊙⊙⊙⏺⊙ '$@'-⊙⊙⊙⊙⏺ '$@'\⊙⊙⊙⏺⊙ '$@'|⊙⊙⏺⊙⊙ '$@'/⊙⏺⊙⊙⊙);
		while(kill 0,'$!'){
			print "\r",$s[$t++%($#s+1)];
			select(undef,undef,undef,0.2);
		}';
		 
		# -----------------------
		#Alternative loading spinner
		#qw('$connecting'-Ooooo '$connecting'\oOooo '$connecting'|ooOoo '$connecting'/oooOo '$connecting'-ooooO '$connecting'\oooOo '$connecting'|ooOoo '$connecting'/oOooo);
		# ------------------------
	}

	echo
	# Connecting to server loading spinner
	spinner "Checking_internet.........."
	wget -q --tries=10 --timeout=20 --spider https://8.8.8.8
	if [[ $? -eq 0 ]]; 
	then
		echo -e "\nIntertnet connection: OK\n"
		# File url and mirror
		downloadUrls=("https://naiem.info/files/archive/LinuxBanglaFonts.tar.gz" "https://raw.githubusercontent.com/naiemofficial/Linux-Bangla-Font/master/LinuxBanglaFonts.tar.gz")
		pURL="" # it will select lowest latency mirror


		# Get arrays of latency and plain urls.
		pingURL=()
		pointPlus=()
		pURL=()


		for i in ${downloadUrls[@]};do 
			# Get domain name -------- #####
			getDomain=$(echo $i | sed 's|http://||g' | sed 's|https://||g' | cut -d '/' -f -1)

			# Connecting to server loading spinner
			spinner "Connecting_to_server.........."


			# Get Ping --------------- #####
			getPing=$(ping -c 5 "$getDomain" | tail -1 | awk '{print $4}' | cut -d '/' -f 2)

			# Slice ping and get Integer value
			pingURL=${getPing%.*}

			# Ping Point value
			pingPoint+=("$pingURL")

			# Point value+ and domain name
			pointPlus+=("$pingURL,$getDomain")

			# Ping + URL
			pURL+=("$pingURL,$i")
		done

		echo -e "\nSuccessfully connected ✓✓✓\n"


		# Calculate Minimum Latency
		xPing=${pingPoint[0]}
		nPing=${pingPoint[0]}

		# Loop through all elements in the array
		for i in "${pURL[@]}"
		do
		    pingf=$(echo $i | cut -d ',' -f 1)

		    # Update xPing if applicable
		    if [[ "$pingf" -gt "$xPing" ]]; then
		        xPing="$i"
		    fi

		    # Update nPing if applicable
		    if [[ "$pingf" -lt "$nPing" ]]; then
		        nPing="$i"
		    fi
		done
		pURL=$(echo $nPing | cut -d ',' -f 2)





		# Directory Location
		folder="LinuxBanglaFonts" #folder_name

		if [ $USER = "root" ]; then
		  directoy="/root/.fonts/$folder"
		fi
		if [ $USER != "root" ]; then
		  directoy="/home/$USER/.fonts/$folder"
		fi


		# Finalize
		if [ ! -d "$directoy" ]; then
		  mkdir -p $directoy
		else
		  echo -e "Upgrading Bengali fonts provided by https://naiem.info";
		  rm -r $directoy;
		fi

		spinner "Downloading_fonts.........."

		echo -e "\n"
		echo $pURL
		wget -v -P $directoy"/" $pURL

		cd $directoy"/"
		compressed="LinuxBanglaFonts.tar.gz"
		tar -zxvf $compressed
		rm $compressed

		cd

		echo -e "\n"
		spinner "Initiating_Bengali_fonts.........."
		echo
		fc-cache -f -v
		echo -e "\n\n"

		spinner "Installing.........."
		echo
		echo -e "Bangla fonts for Linux has been successfully installed\n"

		echo -e "
            ╔═════════════════════════════════════════════════════════════════════╗ 
            ║                                                                     ║
            ║   Develope by \"Abdullah Al Naiem\" (inspo: Fahad Ahmed)              ║
            ║   Facebook  : http://facebook.com/naiemofficial                     ║
            ║   Instagram : http://instagram.com/naiemofficial                    ║
            ║   E-mail    : mail@naiem.info                                       ║
            ║                                                                     ║
            ╚═════════════════════════════════════════════════════════════════════╝
		"
	else
		echo -e "Sorry..!! ⓧ Your computer isn\'t connected with internet or maybe not having speed from connected internet..!!\n"
	fi

elif [ $confirm = "N" ] || [ $confirm = "n" ];
then
	echo -e "ⓧ Bengali fonts for Linux installation has been cancelled\n"
else
	echo -e "Sorry..!! ⓧ Wrong input entered. Bengali font for Linux installation has been aborted. Please try again.\n"
fi







