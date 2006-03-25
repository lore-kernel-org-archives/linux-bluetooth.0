Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Doug <doug@hbs.edu>
Message-ID: <loom.20060325T174822-928@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] logitech bluetooth mouse on fc3
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
Date: Sat, 25 Mar 2006 16:57:01 +0000 (UTC)

I'm having some problems getting, or should I say keeping, a logitech v270
bluetooth mouse working on my ibm t42p laptop running 2.6.11-1.35_FC3.

I can get it to connect by doing:
sudo hidd --connect 00:07:61:48:CB:7F

And this appears in the log:
Mar 25 11:45:14 dswanson hidd: New HID device 00:07:61:48:CB:7F (Logitech
Bluetooth Mouse)
Mar 25 11:45:14 dswanson hal.hotplug[10064]: DEVPATH is not set

Mouse works, after some random? amount of time the below line appears in the
/var/log/messages:
Mar 25 11:46:34 dswanson hal.hotplug[10124]: DEVPATH is not set
Now the mouse doesn't work.

Here's the status of it when its connected:
Connections:
        < ACL 00:07:61:48:CB:7F handle 42 state 1 lm MASTER

Here's the bluetooth packages installed:
gnome-bluetooth-0.5.1-5.FC3.1
bluez-hcidump-1.11-1
bluez-utils-2.10-2
bluez-libs-2.10-2
bluez-pin-0.23-3
bluez-bluefw-1.0-6

Any help is much appreciated!
Thanks
-Doug




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
