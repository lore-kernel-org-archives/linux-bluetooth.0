Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <bluez@thomae-privat.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40CE96A8.3020407@thomae-privat.de>
References: <40CDE18C.70703@thomae-privat.de>
	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>
Content-Type: text/plain
Message-Id: <1087284859.13792.67.camel@pegasus>
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
Date: Tue, 15 Jun 2004 09:34:19 +0200

Hi Matthias,

> Yes, the mouse works perfectly.
> The keyboard does work with WinXP.

it is a problem of the HID parser. If you enable debugging with "#define
DEBUG" in net/bluetooth/hidp/hid.h then you should see those lines with
dmesg:

net/bluetooth/hidp/hid.c: usage index exceeded
net/bluetooth/hidp/hid.c: hid_add_usage failed
net/bluetooth/hidp/hid.c: item 0 2 2 2 parsing failed

Do you see it, too?

> >> > hcitool info 00:04:61:XX:XX:XX
> >>Requesting information ...
> >>	BD Address:  00:04:61:XX:XX:XX
> >>	Device Name: Bluetooth-Keyboard 817324
> >>	LMP Version: 1.1 (0x1) LMP Subversion: 0x356
> >>	Manufacturer: Cambridge Silicon Radio (10)
> >>	Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
> >>		<3-slot packets> <5-slot packets> <encryption> <slot offset>
> >>		<timing accuracy> <role switch> <hold mode> <sniff mode>
> >>		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
> >>		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
> >>		<transparent SCO>
> > 
> > 
> > Mine is much older, when do you bought it?
> 
> I bought it about 3 weeks ago, from www.bauers.com

Please send me the output of your mouse too and use

	sdptest records 00:04:61:xx:xx:xx > file

from the utils2 CVS to get the full SDP record information.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
