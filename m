Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A160.74F943A0"
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A8D@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Aug 2005 14:13:30 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A160.74F943A0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

     "hciconfig -a hci0" results the same.
-------------------------------------------------
/> new USB device :801aaa04-174d60
hub.c: new USB device 1, assigned address 2
usb.c: USB device 2 (vend/prod 0x1131/0x1001) is not claimed by any =
active driv.                                                             =
                  =20
/>
/> hciconfig -a hci0
                                                                         =
      =20
Can't get device info: No such device
pid 9: failed 256
/>

---------------------------------------------------
      I think bluetooth drivers are not integrated to kernel correctly. =
hci_usb_init() in hci_usb.c is not run since I can't read the printout =
in embedded linux while the printout can be read in PC RH9 linux.

int hci_usb_init(void)
{
	int err;

	BT_INFO("BlueZ HCI USB driver ver %s Copyright (C) 2000,2001 Qualcomm =
Inc", =20
		VERSION);
	BT_INFO("Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>");

	if ((err =3D usb_register(&hci_usb_driver)) < 0)
		BT_ERR("Failed to register HCI USB driver");

	return err;
}

-----Original Message-----
From:	bluez-devel-admin@lists.sourceforge.net on behalf of Paul Webster
Sent:	Mon 8/15/2005 1:38 PM
To:	bluez-devel@lists.sourceforge.net
Cc:=09
Subject:	Re: [Bluez-devel] Porting BlueZ on embedded uClinux
>      You are right about BlueZ was not initilized. After I force =
define MODULE in
> af_bluetooth.c , creating bluetooth socket using hciconfig is OK. But =
command "hciconfig
> -a" still can't read the bluetooth USB dongle information.

What about "hciconfig -a hci0"?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle =
Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & =
QA
Security * Process Improvement & Measurement * =
http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel




------_=_NextPart_001_01C5A160.74F943A0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+Ih8GAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEANAAAAFJFOiBbQmx1ZXotZGV2ZWxd
IFBvcnRpbmcgQmx1ZVogb24gZW1iZWRkZWQgdUNsaW51eAA8EgEFgAMADgAAANUHCAAPAA4ADQAe
AAEALQEBIIADAA4AAADVBwgADwAOAA0AHgABAC0BAQmAAQAhAAAANUE2MEE0NzU5QkYxNzM0MkFE
MTlBMkNFRkJCM0MzOUMAWAcBA5AGABANAAA3AAAAAwAmAAAAAAADADYAAAAAAEAAOQCgQ/l0YKHF
AR4APQABAAAABQAAAFJFOiAAAAAAAgFHAAEAAAAvAAAAYz11czthPSA7cD11bmltaXM7bD1ORVRC
RTAxLTA1MDgxNTA2MTMzMFotMTAzNwAAHgBJAAEAAAA0AAAAUmU6IFtCbHVlei1kZXZlbF0gUG9y
dGluZyBCbHVlWiBvbiBlbWJlZGRlZCB1Q2xpbnV4AEAATgCA0vuSW6HFAR4AWgABAAAAKAAAAGJs
dWV6LWRldmVsLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAACAVsAAQAAAG0AAAAAAAAAgSsf
pL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQA
U01UUABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAAAgFcAAEAAAAt
AAAAU01UUDpCTFVFWi1ERVZFTC1BRE1JTkBMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAAAAHgBdAAEA
AAANAAAAUGF1bCBXZWJzdGVyAAAAAAIBXgABAAAAPgAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAA
AFBhdWwgV2Vic3RlcgBTTVRQAHBqd2Vic3RlckBnbWFpbC5jb20AAAACAV8AAQAAABkAAABTTVRQ
OlBKV0VCU1RFUkBHTUFJTC5DT00AAAAAHgBmAAEAAAAFAAAAU01UUAAAAAAeAGcAAQAAACgAAABi
bHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAHgBoAAEAAAAFAAAAU01UUAAA
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
dC51bmltaXM+AB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAdAAA
AFIARQAlADMAQQAgAFsAQgBsAHUAZQB6AC0AZABlAHYAZQBsAF0AIABQAG8AcgB0AGkAbgBnACAA
QgBsAHUAZQBaACAAbwBuACAAZQBtAGIAZQBkAGQAZQBkACAAdQBDAGwAaQBuAHUAeAAuAEUATQBM
AAAACwD2EAAAAABAAAcwUt80cV+hxQFAAAgw+MwCdWChxQEDAN4/5AQAAAMA8T8JBAAAHgD4PwEA
AAADAAAAQWwAAAIB+T8BAAAAXQAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAvTz1VTklN
SVMvT1U9RklSU1QgQURNSU5JU1RSQVRJVkUgR1JPVVAvQ049UkVDSVBJRU5UUy9DTj1BTC5JU1ND
AAAAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8BAAAAHgAAAAAAAADc
p0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlAAAAAAAMAGkAAAAAAAwAdQAAA
AAADAB5AAAAAAB4AMEABAAAACAAAAEFMLklTU0MAHgAxQAEAAAAIAAAAQUwuSVNTQwAeADJAAQAA
ACgAAABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAHgAzQAEAAAAUAAAA
cGp3ZWJzdGVyQGdtYWlsLmNvbQAeADhAAQAAAAgAAABBTC5JU1NDAB4AOUABAAAAAgAAAC4AAAAL
ACkAAAAAAAsAIwAAAAAAAwAGEG/6Z3UDAAcQEAYAAAMAEBAAAAAAAwAREAAAAAAeAAgQAQAAAGUA
AABISSwiSENJQ09ORklHLUFIQ0kwIlJFU1VMVFNUSEVTQU1FLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS9ORVdVU0JERVZJQ0U6ODAxAAAAAAIBfwABAAAA
PAAAADxFNjRCQUQ1QThBRDQ2NzQwODI4MDY5QTY3OEQ5REQ3MzAxMUE4REBuZXRiZTAxLm5ldC51
bmltaXM+AJep

------_=_NextPart_001_01C5A160.74F943A0--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
