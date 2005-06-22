Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: David Wuertele <dave-gnus@bfnet.com>
Message-ID: <m3psuelq3x.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Pairing in FC4 without gnome or kde?
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
Date: 22 Jun 2005 02:04:18 -0700

I've done a complete install of FC4 but I do not run Gnome or KDE
(they just drive me nuts).  Now I'm trying to pair my headset.  I
think there is this gnome-bluetooth-manager thingie that is supposed
to prompt you for your pin when it gets a message on the dbus, but it
isn't working for me, and I suspect it is because I'm not running
Gnome or KDE.

So I tried writing my own pin script:

  #!/bin/sh
  # leave a trace so I know what's going on
  echo $@ >> /tmp/zeropin.log
  # return the pin for my headset
  echo "PIN:0000"

I changed my /etc/bluetooth/hcid.conf to comment out the dbus system
and use my script, like this:

	# D-Bus PIN helper
	#dbus_pin_helper;
	pin_helper /usr/local/bin/zeropin;

I then did "service stop bluetooth" and "service start bluetooth", and
then put my headset in pairing mode.  But nothing happens.

Can someone give this poor non-gnome non-kde user a clue?

FWIW, here's what bluez I have installed:

  # rpm -qa | grep -i bluez
  bluez-libs-devel-2.15-1
  bluez-libs-2.15-1
  bluez-utils-2.15-7
  bluez-pin-0.24-2
  bluez-utils-cups-2.15-7
  bluez-hcidump-1.18-1

  # hciconfig -a
  hci0:	Type: USB
          BD Address: 00:20:E0:75:D6:F6 ACL MTU: 192:8 SCO MTU: 64:8
          UP RUNNING PSCAN ISCAN 
          RX bytes:879 acl:0 sco:0 events:54 errors:0
          TX bytes:1454 acl:0 sco:0 commands:45 errors:0
          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
          Link policy: RSWITCH HOLD SNIFF PARK 
          Link mode: SLAVE ACCEPT 
          Name: 'localhost.localdomain-0'
          Class: 0x120104
          Service Classes: Networking
          Device Class: Computer, Desktop workstation
          HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
          Manufacturer: Cambridge Silicon Radio (10)

  # hciconfig hci0 revision
  hci0:	Type: USB
          BD Address: 00:20:E0:75:D6:F6 ACL MTU: 192:8 SCO MTU: 64:8
          Build 546
          Chip version: BlueCore02-External
          Max key size: 128 bit
          SCO mapping:  HCI

Thanks,
Dave



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
