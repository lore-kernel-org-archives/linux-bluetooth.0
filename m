Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F841DF.5000008@gmail.com>
Date: Wed, 14 Mar 2007 11:41:35 -0700
From: Xamindar <junkxamindar@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bluetooth seemed to stop working for me recently...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I am on a Gentoo system with bluez-libs-3.9 and bluez-utils-3.9 
installed.  It had been working perfectly up until a few days ago.  I 
haven't changed the kernel but may have updated other system packages.  
I just tried recompiling and installing the bluez stuff but it is still 
doing the same thing.  Below is the output of the system log showing 
what is printed when I start the bluetooth services and the output on 
the console when I try to do a bluetooth scan.  I had been using that 
little gnome bluetooth applet version 0.6 to take care of paring and a 
few bluetooth options.  It used to be able to set my computer 
discoverable settings but now once I change the setting in that applet, 
the setting is right back to where it used to be when I look at it again.

Does anyone know what could be wrong here?  Is the dbus communication 
somehow broken?


Mar 14 11:31:33 [hcid] Bluetooth HCI daemon
Mar 14 11:31:33 [hcid] HCI dev 0 registered
Mar 14 11:31:33 [hcid] HCI dev 0 already up
Mar 14 11:31:33 [hcid] Device hci0 has been added
Mar 14 11:31:33 [hcid] Starting security manager 0
Mar 14 11:31:33 [hcid] Can't write inquiry mode for hci0: Input/output 
error (5)
Mar 14 11:31:33 [hcid] Getting name failed with status 0x0c
Mar 14 11:31:33 [hcid] Default passkey agent (:1.20, /org/bluez/applet) 
registered
Mar 14 11:31:33 [hcid] Getting scan enable failed with status 0x0c
White-Rabbit layman # hcitool dev
Devices:
        hci0    00:16:CF:D7:AE:62
White-Rabbit layman # hcitool scan
Scanning ...
Inquiry failed: Connection timed out
White-Rabbit layman #


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
