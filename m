Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] UDEV data missing after hid2hci
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1137164677.7780.10.camel@pc-05.ycom.ch>
References: <1137164677.7780.10.camel@pc-05.ycom.ch>
Content-Type: text/plain; charset=utf-8
Message-Id: <1137402066.8173.0.camel@pc-05.ycom.ch>
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
Date: Mon, 16 Jan 2006 10:01:06 +0100

No one ?

Le vendredi 13 janvier 2006 =C3=A0 16:04 +0100, Alexandre Ghisoli a =C3=A9=
crit :
> Hi,=20
>=20
> I've a bug with my DiNovo keyb and mice.
>=20
> I cannot force the device name in udev to link against xorg
> configuration.
>=20
> Fixed device name is required for the Xorg configuration, since kernel
> and udev change device numbers at reconnect, after a Bluetooth stop to
> save batteries.
>=20
> Example :
>=20
> /dev/input/event0	-> mouse at startup (in usb mode)
> /dev/input/event1	-> keyboard (in usb mode)=20
> /dev/input/event3	-> mouse in BT mode, if I touch mice first
> /dev/input/event4	-> keyboard in BT mode
>=20
> After a while without using mouse, hidd will stop session with device.
> Touching the mouse re-enable the link, but device number could be
> event5 !
>=20
>=20
> So, I want to fix the device name with a udev script. Testing :=20
> KERNEL=3D=3D"event[0-9]*"  SYSFS{idVendor}=3D=3D"046d",
> SYSFS{idProduct}=3D=3D"b001", NAME=3D=3D"input/ev-mx900", MODE=3D=3D"06=
64"
>=20
> Not working !!
>=20
>=20
> /proc/bus/input/devices gives :=20
> I: Bus=3D0005 Vendor=3D046d Product=3Db001 Version=3D2200
> N: Name=3D"Bluetooth HID Boot Protocol Device"
> P: Phys=3D
> S: Sysfs=3D/class/input/input3
> H: Handlers=3Dmouse1 event3
> B: EV=3D7
> B: KEY=3D1f0000 0 0 0 0 0 0 0 0
> B: REL=3D103
>=20
>=20
>=20
> So both vendor and device ID are correct.
>=20
> I check by udev :=20
> udevinfo -a -p /sys/class/input/event3
>=20
> device '/sys/class/input/input3/event3' has major:minor 13:67
>   looking at class device '/sys/class/input/input3/event3':
>     KERNEL=3D=3D"event3"
>     SUBSYSTEM=3D=3D"input"
>     SYSFS{dev}=3D=3D"13:67"
>=20
>=20
>=20
>=20
>=20
> This mean that the udev struct is not filled with all needed infos to
> match udev rules.
>=20
> Any help to make it working ?
>=20
> Oh, BTW, tested with linux-2.6.15
>=20
> Thanks
>=20
>=20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
