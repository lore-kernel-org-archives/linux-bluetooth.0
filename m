Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] blue-fw not working for USB Belkin F8T001 in
	Gentoo Linux
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex Holland <ah160@york.ac.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FFBFC34.3050509@york.ac.uk>
References: <3FFBFC34.3050509@york.ac.uk>
Content-Type: text/plain
Message-Id: <1073479827.2508.143.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 07 Jan 2004 13:50:27 +0100

Hi Alex,

> I'm a Gentoo user, and my kernel and bluetooth modules are all compiled 
> using the latest Gentoo Sources, 2.4.22-r2.
> 
> When I was using 2.4.20-r9, hci_usb wouldn't see my USB bluetooth dongle 
> until after bluefw had run. Since I upgraded to 2.4.22-r2, my dongle is 
> detected as part of the standard USB bus scan during boot, although it 
> brings up a lot of insmod errors. Further on during the boot, bluefw 
> always fails, saying that my device has timed out. This leaves my 
> bluetooth device invisible to hciconfig.
> 
> Everything works fine if I boot into Windows XP and let the Belkin 
> software load the firmware, then reboot into Linux without powering 
> down. I still get the insmod errors, but bluefw brings up no error 
> messages and all bluetooth things work wonderfully.
> 
> I realise this may look more like a Gentoo query than a bluez query, but 
> there don't seem to be many bluetooth users on the Gentoo forums, so I 
> thought this might be the best place to ask.

I never got the bluefw working fine with my Broadcom based dongles. So I
wrote a kernel driver for loading the firmware. My -mh2 patch for 2.6.0
contains this bcm203x driver, but I haven't one for the 2.4 series.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
