Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <402D07B8.8030504@handgranat.org>
From: Sunnan <sunnan@handgranat.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin usb)
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
Date: Fri, 13 Feb 2004 18:22:00 +0100

Hello, would you please help me?

I'm trying to get an apple wireless mouse working on the apple ibook 
(g4, builtin usb).

I've got the debian bluez packages installed, actually

sudo apt-get install `apt-cache search bluez |cut -f1 -d' '`

(yeah, lazy maybe..)

and I've also got libs2 and utils2 installed from cvs.

Until I ran hid2hci I didn't see anything with hcitool, but hid2hci 
seemed to work fine.

Now running hcitool dev gives me
Devices:
         hci0    00:0D:93:04:19:15

I'm experimenting with running bthid (from bluez cvs utils2).
/var/log/daemon.log has
Feb 13 17:42:20 slowstorm bthid[980]: Bluetooth HID service started

but little else.
Once it got
Feb 13 17:25:20 slowstorm bthid[890]: Bluetooth HID service started
Feb 13 17:26:49 slowstorm bthid[890]: Connected: HID device (ffff:0000)
Feb 13 17:26:49 slowstorm bthid[890]: Connection failed: Connection 
timed out (110)

..but that's all.

I'm also repeatedly grepping ps aux for bthid and it only appears for a 
couple of minutes after starting it, then it's not there (so I usually 
restart it).

I don't see any cursor movement or anything. I don't know so much about 
bluetooth or about computers in general.

For a kernel, I use Linux 2.6.3-rc2-ben1 (on ppc).

lsmod indicates that uinput, hci_usb,rfcomm,l2cap and bluetooth are 
loaded. I've created /dev/input/uinput with mknod as per 
http://www.bueche.ch/comp/mx900/mx900.html

I had the mouse working under Mac OS X before I installed Debian.

What are the other steps I need to take before I can start using the mouse?

Thanks very much in advance, Sunnan


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
