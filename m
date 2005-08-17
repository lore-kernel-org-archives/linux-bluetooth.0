Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A2EA.C067BDCA"
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A93@netbe01.net.unimis>
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
Date: Wed, 17 Aug 2005 13:15:58 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A2EA.C067BDCA
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi, durai:
=20
      Yes, vfork() works ok.
      I also found it at =
http://www.uclinux.org/pub/uClinux/FAQ.shtml#2-5
     "uClinux does not implement fork();  instead it implements =
vfork()."
              =20
     For the HCI utility on user space part, I first have /hci-lib and =
/hcid
compiled to hcid. Then have /hci-lib and /hciconfig compiled to =
hciconfig.
Copy two applications, hcid and hciconfig, to ramdisk. Also I have =
hcid.conf
copied to ramdisk /etc/bluetooth/
=20
     After boot up, run hcid, then hciconfig hci0 up to bring up the =
device.
MAC address is read correctly. But when running hciconfig -a, it can't =
read local name correctly.
Did I miss something?
=20
thanks,
=20
Al
=20
---------------------------------------------------------------

/> hcid
/> hciconfig hci0 up
/> hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:67:03:DB:62 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:323 acl:0 sco:0 events:9 errors:0
        TX bytes:33 acl:0 sco:0 commands:9 errors:0
        Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT


Can't read local name on hci0: Connection timed out (110)
pid 17: failed 256
/>
-------------------------------------------------------------------------=
------------------

	-----Original Message-----=20
	From: bluez-devel-admin@lists.sourceforge.net =A5N=B2z durai=20
	Sent: 2005/8/17 [=ACP=B4=C1=A4T] =A4U=A4=C8 12:32=20
	To: bluez-devel@lists.sourceforge.net=20
	Cc:=20
	Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
=09
=09


	Hi Al,
	In uClinux there is no fork, only vfork is available. You have to =
change
	your fork to vfork in uClinux.
	Please refer
	http://www.ucdot.org/article.pl?sid=3D03/12/12/0317219&mode=3Dthread.
	regards
	durai
=09


------_=_NextPart_001_01C5A2EA.C067BDCA
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjsFAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEANAAAAFJFOiBbQmx1ZXotZGV2ZWxd
IFBvcnRpbmcgQmx1ZVogb24gZW1iZWRkZWQgdUNsaW51eAA8EgEFgAMADgAAANUHCAARAA0ADwA6
AAMATgEBIIADAA4AAADVBwgAEQANAA8AOgADAE4BAQmAAQAhAAAARjFGMkE1MjFBOUE2RUE0MTk3
RkU4MUE0MzgwQjZCMjQAOAcBA5AGADgWAAA2AAAAAwA2AAAAAABAADkAyr1nwOqixQEeAD0AAQAA
AAUAAABSRTogAAAAAAIBRwABAAAALwAAAGM9dXM7YT0gO3A9dW5pbWlzO2w9TkVUQkUwMS0wNTA4
MTcwNTE1NThaLTExMzcAAB4ASQABAAAANAAAAFJlOiBbQmx1ZXotZGV2ZWxdIFBvcnRpbmcgQmx1
ZVogb24gZW1iZWRkZWQgdUNsaW51eABAAE4AgDWUvOSixQEeAFoAAQAAACgAAABibHVlei1kZXZl
bC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAgFbAAEAAABtAAAAAAAAAIErH6S+oxAZnW4A
3QEPVAIAAAAAYmx1ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1
ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALQAAAFNNVFA6
QkxVRVotREVWRUwtQURNSU5ATElTVFMuU09VUkNFRk9SR0UuTkVUAAAAAB4AXQABAAAABgAAAGR1
cmFpAAAAAgFeAAEAAAA3AAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAZHVyYWkAU01UUABkdXJh
aUBpc29mdHRlY2guY29tAAACAV8AAQAAABkAAABTTVRQOkRVUkFJQElTT0ZUVEVDSC5DT00AAAAA
HgBmAAEAAAAFAAAAU01UUAAAAAAeAGcAAQAAACgAAABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkAAQAAABQAAABkdXJhaUBpc29m
dHRlY2guY29tAB4AcAABAAAAMAAAAFtCbHVlei1kZXZlbF0gUG9ydGluZyBCbHVlWiBvbiBlbWJl
ZGRlZCB1Q2xpbnV4AAIBcQABAAAAGwAAAAHFouT/ILWqFTdCukIHvJnRXiD642YAAQJzngAeAHQA
AQAAACIAAABibHVlei1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeABoMAQAAAAMAAABB
bAAAHgAdDgEAAAAwAAAAW0JsdWV6LWRldmVsXSBQb3J0aW5nIEJsdWVaIG9uIGVtYmVkZGVkIHVD
bGludXgAAgEJEAEAAAARDwAADQ8AAMA+AABMWkZ1J5fjlIMACgByY3BnOTUC0cEDYWh0bWwxAzAB
A58B9wqAAqQD4wIAY2gKwMBzZXQxMzYF0AuA8GdMaXUCgA/zAFAEVu0RnDIC4xDHMgYABsMSBeYz
BEYQxzAgCFUHsgKAFxITCO8J9zsYvzI1NfsSAgxgYwBQCwkBZBFgFvDJC6U0IA/yKlwOogGQXmcU
4AqjEhMd2DQU4DwAIURPQ1RZUEUAIEhUTUwgUFUAQkxJQyAiLS8QL1czQyFwRFREESCEMy4yIXBF
TiLOPh7dHn8jsTE4H+Agkjci/yQPJoAzHXAlYEVBvkQlvQ7hJt8pXyTkNg7goDxNRVRBB7BBLFCY
PSJHCfAEkGF0BbCiIhcAT05UIsBULOBZBeFFeBDhEbBlBlJ2DxdhLzEAkAIgIDYuMIAuNjQ4Ny4x
Iu4TKr8k8zc3H+BUSVQUTEUlvjQO4FJlOsggW0IKQXotAQAvMFxsXSDQGGERoSA1Alo6IC/BZQbQ
CYABAGQgSHVDbAuAdXgkXjX9H+AvMz8xbyY1NIE5ACg/DyaPPNQOMB/gQk9EWaAgZGlyPTzwcjxA
zzyzACEDMD9RZG8A4D9R+QqxXHEYoD9REOADMD+1PxbwPGsc4T1vDhARcDxE/ElWP4kAAEHHPIkw
MET/cUISSGksPwAIcAtwOn88iQHAP5cKoj+XCnEkbDD/KAEh0ETLSqhCT0NfRG9FfxdGj1FLPGs4
HXAmbmIcc3ACgFL5FcEnYTD/TXlJD0ofSy9MP01PTl9Pb/9Qf1bfUp9b/1S/Vc9iD2Mf/2QvZT9m
T2dfaG9pf2qPa59nbK9tv27HIFkHkEiAdoECEHJrKCkgd3MB8QQgb2suV29Yf1mPWp//W69cv13P
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
eIIvgz+ET/+Q35Hvkv8AD4mPQD4u8DMX/yueMQ8yH5YPlBYvAZTMLT//O388jz2fCO+gjkFvQn9D
j4tEnw0+SF2AQWwsk687lL+VzEkSoJA1xCBoZW0RkCB10BIwbxmAVWBrwiwSgWx5IHaw8rCCp42/
op9TFGF2GaFhU3B5VZAgWVUAErC0sBJwdH+w0DpQEUBH0KyPrZ+VzHnfVQGw47XisaWvly62j7ef
5ZXMUBnAYXMScLI/s0/7UxQRkGawULtvvH+Vz4VcdkEa5HTgaMFRN6DDEHQgcDovL3fHEC51oGNk
b3QuVWEvGxBFE4BjtSFwbD+qAGToPTAzaSAyyQLI4BlQcDIxOSYSUFtQ/TI9p7AwEZI43GZpVABk
wcIOZsvww7A3UHtIWVDIRVJMOABLIMafx69nyL/Jwco6fX1cEcvwcqJzWqBcY2ZqYHU6mnfNj86f
z685Wh/J8lt4Jr/ECMo5nV+mup3viLpBwuAvu1/Cr8O9EZBnGxBkc//d397vw8xdQ+FP4l/Dz5bf
/5fvKp8rr6V/5z8u35xKNihf6Q/tL6JP8n+/FzUwYkL4T0RZL170LzASaUDooCk4YE1M5dB9+PAA
AAAeADUQAQAAADwAAAA8RTY0QkFENUE4QUQ0Njc0MDgyODA2OUE2NzhEOURENzMwMTFBOTNAbmV0
YmUwMS5uZXQudW5pbWlzPgAeAEcQAQAAAA8AAABtZXNzYWdlL3JmYzgyMgAACwDyEAEAAAAfAPMQ
AQAAAHQAAABSAEUAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQAZQB2AGUAbABdACAAUABvAHIAdABp
AG4AZwAgAEIAbAB1AGUAWgAgAG8AbgAgAGUAbQBiAGUAZABkAGUAZAAgAHUAQwBsAGkAbgB1AHgA
LgBFAE0ATAAAAAsA9hAAAAAAQAAHMObk7AjposUBQAAIMCJHccDqosUBAwDeP7YDAAADAPE/BAQA
AB4A+D8BAAAAAwAAAEFsAAACAfk/AQAAAF0AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAA
L089VU5JTUlTL09VPUZJUlNUIEFETUlOSVNUUkFUSVZFIEdST1VQL0NOPVJFQ0lQSUVOVFMvQ049
QUwuSVNTQwAAAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4A
AAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T+2AwAAAwAZQAAAAAADABpAAAAA
AAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAAAgAAABBTC5JU1NDAB4AMUABAAAACAAAAEFMLklTU0MA
HgAyQAEAAAAoAAAAYmx1ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AB4AM0AB
AAAAFAAAAGR1cmFpQGlzb2Z0dGVjaC5jb20AHgA4QAEAAAAIAAAAQUwuSVNTQwAeADlAAQAAAAIA
AAAuAAAACwApAAAAAAALACMAAAAAAAMABhCaH43zAwAHEHoFAAADABAQAAAAAAMAERAAAAAAHgAI
EAEAAABlAAAASEksRFVSQUk6WUVTLFZGT1JLKClXT1JLU09LSUFMU09GT1VORElUQVRIVFRQOi8v
V1dXVUNMSU5VWE9SRy9QVUIvVUNMSU5VWC9GQVFTSFRNTCMyLTUiVUNMSU5VWERPRVNOTwAAAAAC
AX8AAQAAADwAAAA8RTY0QkFENUE4QUQ0Njc0MDgyODA2OUE2NzhEOURENzMwMTFBOTNAbmV0YmUw
MS5uZXQudW5pbWlzPgDsYQ==

------_=_NextPart_001_01C5A2EA.C067BDCA--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
