Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1077206432.17056.7.camel@pc-04.ycom.ch>
Mime-Version: 1.0
Subject: [Bluez-users] hid2usb error
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
Date: Thu, 19 Feb 2004 17:00:32 +0100

Hi there, 

I've the Logitech diNovo Bluetooth kit, and try to use it as BT device.
So, i've bluez-libs2 & bluez-utils2 to use the hid2hci tool to pass my
Logitech USB HUB to an Bluetooth HUB.

Kernel 2.6.2-mh
hid module loaded.

Running the hid2usb give :
Invalid argument ...

After some investigations, it appear that the following line return the
error (around line 240) :

err = send_report(fd, rep1, sizeof(rep1))

at the 2nd byte send (0xff 0x80)
Anyone can help me, plz ?

Regards

	--Alexandre




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
