Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] add bluez to uClinux
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <BAY2-DAV86A65907A8E43A1F50F36D4000@phx.gbl>
References: <BAY2-DAV86A65907A8E43A1F50F36D4000@phx.gbl>
Content-Type: text/plain
Message-Id: <1117287913.12036.144.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 28 May 2005 15:45:13 +0200

Hi Fahah,

> I'm new to this list. I am trying to integrate Bluez into uClinux for
> a school project. I have read the previous discussion on this topic
> here (like the fork() and vfork() limitation, exit() and _exit() stuff
> and the likes). I have made all of those changes to the
> bluez-utilities. I am using the latest uClinux distro downloaded from
> the uclinux website (www.uclinux.org) which has the source code for
> the 2.4 kernel version.
>  
> I see bluetooth stuff in it (under drivers>bluetooth and
> net>bluetooth). When I do make xconfig, I select:
>  
> 1) my target architecture type (uCsimm by Arcturus),
> 2) uClibc as the library,
> 3) 2.4.x as the kernel version to use and
> 4) the option to modify kernel configuration which then presents me
> with a window customise the kernel options.
>  
> But my problem is that I can't find any bluetooth related stuff
> in this kernel configuration window even though the files are present
> as I mentioned earlier.
>  
> I will be grateful if somebody could guide me as to how I can get the
> bluetooth options in the kernel configuration options. I believe then
> I should be able to statically compile bluez into uClinux and
> thereafter get on with cross compiling the utilities.

maybe the uClinux architecture does not include the Bluetooth config
file and thus no config options are presented.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
