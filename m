Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "g.starre" <info@microllix.nl>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <421F0517.17219.330641@localhost>
Content-type: text/plain; charset=US-ASCII
Subject: [Bluez-users] connecting 2 linux pc's
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
Date: Fri, 25 Feb 2005 10:59:35 +0100

Hi all,
  
After a long time trying, I still cannot connect
2 linux PC's together using usb-bluetooth sticks
with rfcomm.

I'm using among others :
knoppix 3.7 CD boot (bootoption knoppix26)
debian PC (2.6.11-rc4-bk10 kernel, unstable dist)
debian laptop (2.6.11-rc4 kernel, unstable dist)

All the modules like
- hci_usb
- rfcomm
- bluetooth
- l2cap
are loaded either by the kernel (/etc/modules) or
by hand using modprobe.

These command's are used to try to setup
a connection :

hciconfig hci0 up
sdptool add sp
rfcomm bind 0 <bdaddr> 1
rfcomm connect 0

While on the "receiving" debian laptop these command's
were issued :

hciconfig hci0 up
sdptool add sp
rfcomm listen /dev/rfcomm0 1

To check connection I use cat/echo (or minicom)
-> echo "hello world" > /dev/rfcomm0

This way I can connect to a pc with some proprietary OS,
but I cannot build a connection between 2 linux pc's.

Yesterday I was able to start a connection between
a debian PC and debian laptop but immedeatily after
pressing the return button on the debian PC the
laptop responded with (rfcomm listen /dev/rfcomm0) :

 Press control-c to disconnect
 Disconnected


It's probably one bit I have to toggle ;-)

Some settings in hcid.conf :
pairing multi;
lm accept;
lp rswitch,hold,sniff,park;

My rfcomm.conf on the debian PC is
modified like this :
rfcomm0 {
  bind yes;
  device <bd-address of debian laptop connected BT dongle>;
  channel 1;
}

The service was restarted each time the config
was altered with /etc/init.d/bluez-utils stop
and then ..... start

In all the howto's/archives there is a lot of
info how to connect to a phone or some device,
but there's no info how to connect 2 pc's.
Can anyone help ?

Thanks in advance.


grt, geert




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
