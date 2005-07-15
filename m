Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050715210239.76018.qmail@web33502.mail.mud.yahoo.com>
From: Vinod <geekvinod@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42D69FBB.6040702@cc.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Re:  files from ipaq 3870 to desktop with bluetooth
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
Date: Fri, 15 Jul 2005 14:02:39 -0700 (PDT)

Still having problems, now with setting up pand.

>If you got blue diode flashing after this, you got
> it right... Bluetooth
> is on after that...
> try this:
> 
> # hcitool dev

This is fine. i can find it.

>If other devices is found then you just need pairing
> and pand connection
> stuff.

I think it is the pairing which is giving me problems
but am not certain.
i did

killall hciattach
hciattach /dev/ttySB0 bcsp 230400
hciconfig hci0 up
rfcomm bind all
pand --listen GW
pand --connect 00:00:00:00:00:00

This seemed fine till here, but it did not ask any pin
on the desktop(i beleive it should based on my
knowledge of bluetooth) where i was making the
connection to from my ipaq. /var/log/messages gives
this

------------------------------------------------------
Oct 22 17:24:09 h3600 daemon.info hcid[1295]:
Bluetooth HCI daemon
Oct 22 17:24:09 h3600 daemon.info sdpd[1299]:
Bluetooth SDP daemon
Oct 22 17:24:30 h3600 daemon.info hcid[1295]: HCI dev
0 registered
Oct 22 17:24:31 h3600 daemon.info hcid[1295]: HCI dev
0 up
Oct 22 17:24:31 h3600 daemon.info hcid[1295]: Starting
security manager 0
Oct 22 17:26:34 h3600 daemon.info pand[1348]:
Bluetooth PAN daemon version 2.14
Oct 22 17:26:59 h3600 daemon.info pand[1350]:
Bluetooth PAN daemon version 2.14
Oct 22 17:26:59 h3600 daemon.info pand[1350]:
Connecting to 00:0B:0D:34:6F:C7
Oct 22 17:26:59 h3600 daemon.err pand[1350]: Connect
to 00:00:00:00:00:00 failed
. Permission denied(13)

----------------------------------------------------

I have set up my rfcomm.conf and hcid.conf exactly as
described in
http://opie.handhelds.org/cgi-bin/moin.cgi/BluetoothGprs
with pin_helper /etc/bluetooth/givepin, security auto
and 'commented out' auth enable and encrypt enable

I want to add that the desktop is a windows machine
with usb dongle, if that can help explain any pairing
problems.

Thanks,
Vinod



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
