Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sebastian Henschel <linux@kodeaffe.de>
To: bluez-users@sf.net
Message-ID: <20040422135845.GA1931@fuchi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Subject: [Bluez-users] BT stops working after firmware upgrade to 1.1 on alu powerbook
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
Date: Thu, 22 Apr 2004 15:58:45 +0200


--4SFOXa2GPu3tIq4H
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello folks...

yesterday, i upgraded to the new bluetooth firmware 1.1 from apple.
afterwards, bluetooth still worked on OS X, but not in linux anymore.
the months before, bluetooth worked just fine with hci-usb, thank you.
now, hci_usb is not even loaded automatically and when it is loaded
manually, there is no device hci0.
by chance, i found out, that the values in /proc/bus/usb/devices show
other values now:

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D 44/900 us ( 5%), #Int=3D  2, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.5-rc3-ben0-mh3 ohci_hcd
S:  Product=3DPCI device 106b:003f (Apple Computer Inc.)
S:  SerialNumber=3D0001:01:1a.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D05ac ProdID=3D1000 Rev=3D12.41
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driver=
=3Dhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Driver=
=3Dhid
E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms


look at the device in lev 01 which used to be the bluetooth device.
interestingly, the release notes of the firmware talk about improvements
when handling mice and keyboards (see class + proto above).
this is the output of the old /proc/bus/usb/devices:


T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D 43/900 us ( 5%), #Int=3D  1, #Iso=3D  2
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.5-spring ohci_hcd
S:  Product=3DPCI device 106b:003f (Apple Computer Inc.)
S:  SerialNumber=3D0001:01:1a.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D05ac ProdID=3D8203 Rev=3D 5.26
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driver=
=3D(none)

very strange, indeed.
i attached the info i could gather from OS X and the relevant output of
"lsusb -vv" for both firmwares.

my question now is, if there is any hope to fix this. i worked a little
on hci_usb.c. first, i added the device id statically to bluetooth_ids,
then i tried to hardcode the endpoint data into husb->*_ep which i could
not complete yet due to some missing data. but will this be enuff? is
there more to do? do you need more info?

luckily, i found a way to use the old firmware, simply overwriting the
new one does not work for some reason. you have to force the firmware
updater to load the old firmware in OS X, then warm-boot into linux. the
next time you boot into linux, the new firmware superposes the old one again
and you have to load the old firmware under OS X again. weird and it
does not always work.

thanks in advance,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--jRHKVT23PllUwdXP
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="lsusb.new.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWXEzNBkAAxtfgH/+QGV/8D5vXwA/79/wUAQePJoNBQCkMqh5Rpk0GRk0NAGI
0aBoYgABzAJgJkYARiYmEwmCGmJpgcwCYCZGAEYmJhMJghpiaYCKKKfojVGYh6oP1AABPQQD
0jAAIpBAmRpNpTTaamaJPUY0mR6IGQ9QzSbg2IomnUc/gT8/UdZd03lhYSaM4sZNW3xPCC9t
bq/G47HkzbX2vwf8c2rcbCC0wKlhQ7jIrl253kxte6Sd15IOW2QKDqEt55GuPNOoXwqgzCiL
aoZXXYP9KQaCsAND4NVArBKUISoIIGu4q7i8ksVLWWIsYCAthqk5zOUG2uBKwkJcbTOQhiSk
JK+/URL4kyI+VbiwzNhJyYDUYEir0mh5y+2PcYGDOmo+Z2GJow7ikX6xJKLwWCqGqYZDCaoC
xCF3g8UiAOF+AxK6IrIvPbWC66YZQNT6nHfJikNPumsqUpTVsy/FiWqbHROZuq+8xLTYQYc3
qKGsi0NZYbM9PVU13nMXbdZPKjXKNPfTSb6TTAxCyTQ22zdmnC1kZFd7MkXM1licQa3evj4n
J73QmnyJHAonWnkUPEgoWkH7jyf0qD5FRbD1FA1FBknOyatTiVD+CCCExczKWA2F7LVecpUD
YfFktKZHIyVoZnQ4LQzMCqTPE5ihR50hKnc6yHMWaF5BN9xMteR7kHwSDwfJyLD/ToMnxPpw
Bz/VzbALF8jewnE0G4kUetmMMgYZEMybQoEEmZMmQVMWhY9uaWPzxOmXoGtCCbBDAQBBAwQw
EEmEmbU3iuIUOl2wHcF5BB/bcYKbDIY6Nb7Nx7C2GkSwwMHzIU7WKEI4MJrMJkYcOPrPQfQA
+p5nA9J2OJIhBuIQyIIIHUK2P2SrtoAeUiqDvNrtA6IeDABwAxAMnrO16h1Lt5wCYbkLnihA
FgruTBKJkmuCZ5CcTCp1Nh8DoTeLgNCDF7yR2t57EJvmgCGYBItZjYq3EmZ7DDmTMxDNDaky
4dp9WYEz6HcXitwbC0+xqS87/aG9UuMENCRzmibBXvKhrIAgFyagb6Ei9ko5puFZOSENw5sm
pyJEByICRQkyVsyxiJfkwKy0bipgS8yuI+AUbikEtqTZkNS4qg9jAyTc+sA1toFyahWaWpg6
JiZfkdS7g2Fx0IVIcTcczmBrOBW4zMEscqBnM7wloY91S9YtLdVwVLnZT3F3JFOFCQcTM0GQ

--jRHKVT23PllUwdXP
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="lsusb.old.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWT1/O9IAB7JfgH/+QGd/8D9n34C/7//wUAYeADQAAAAADjJkyYjEwAmTBMgB
owjAEMA1KA8SPU9TRpkGEAGgeoZBoaAADjJkyYjEwAmTBMgBowjAEMBxkyZMRiYATJgmQA0Y
RgCGAKkiCEyYU8iYhiCGpo9TaaamGpoepsSb1JxTakkidXa6ZPj+Nuzud7T36mTzKsKk0YsK
vVRnC6aMMO2H5Z+En5X+cmyGiaNWrVux2fqlV9QYBzBqD7vfVVVVVVVVT9A530pVD/ja2txN
QU5Nzjx46trh4mdNM+22mvsr7dfTdHqUhA0yTyb7LXRnUiQLVEiQxhN4bQp8VpUlC5Cf8Swq
fSG/ViCZZTNa1pExxv8njWmYStEoVSTOpUGioXtJPuXBlhpWxWkTNxeNuJdDa2Yse1YusxR/
3ne7Lnuq/wWvLK8KWJQ/bZ06BnOhyWh4gpuY4hf6Dc8rUmeb3unZjJi4MhsyDmDoDks3Dag+
FI5r47fr+vG/fllfLLK6TOoEwxVyXjnXCJJSEQnKFZgDBLqhIAGcKhNDOB54Ln0OvamNJ53m
pioVdSyqXpdo22kwwsnCyVaLZY5Z4tdbuf75IrZaXpLe+S91hxTHj+BODQ0/a2N7yOjOTOuC
pLbHBq6crKnBaOWbfvTfvb8zS01hWDBjJ4t4xX9+OOnDQw0JUmaY0nf4nlxYK54aezzc4s68
lvLocM9GkNLlTTOq+ehlj1BktS+s6KTGRgxY+LPsqrV2xJlr9f97vF9H2BhD8eaYIfFYa3a/
rnD1ClTGfRS7Q9b0hhEmESe5ZpVdKD6gsGcLyPhUk0w4QxIYtiwUT2rRJlk8AuzbIbAvE54Z
yfqFeQim5qYyLjb8lMGEOSGNpHrDKTnWDriTEJpftJaYB7GC8NWoOz1PbCTrQp8h7w+ngGlp
fu3B+7h5Ej9A38IZHpozI8H3dcLSO50qXh/YLpQWIUFlBdeFyoWWPn6YXYhwQxD87bJrvf8P
QXvjJKWhUqFSoUpClQpSwf5Jj58ELyOtEm0uyGJwmhSny+YbMxnIjkHMdemDAP5DW1RJgoKh
QKnVKJ8Q4aPr0MZJLwqRni3qHsd/LWO1/EkmQwhTuc3oCllQk0qiTWoHeiTeMw+aGsZwticq
h8M2cJM24Ovog8YVJJYa5IbA7fDruTueeHlS+wjlt5epJkZYjXDVCPHyF4akSfUP46kNjUhx
1SKI+9I809CK6nohi+Y/N3IYpH2aNU3VFqWh7paSfuGCPdCLidsLySWSawuDKRCoWe5aHnJ0
yNR2cIRxkcZnJhJP/BcZEwZjrUiT+Ho2jKR6Se06N3KJDybzXCOwyc6JNc6ENikikSc4Yjx9
GLMeUYtQYSJOCHQiTK8N57CVIs4qDxyaSUhyVBdSqrTCgtTBSTkFIksxDqJcTnSOLYYgwQwD
gqqhnMISeaFIWQ6QxHskk2QzheRoGpEmCGiF4dKHM7PB1yOg2v5FDS73mSObobxztxMmbdO5
C2YaEntD1u7Saun0RDpIroHEO+JDnDtQ/+LuSKcKEgev53pA

--jRHKVT23PllUwdXP
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="osx.info.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWQZJEuQAAMffgAAQRGf+W71v3oo/7//gUAO6k15YzMmamEpqTJqYCYJMKep+
pNqPTKZMnlDynqABIkENTJpqNTJtEeo00ep6jQAGjQ0Gp6KaZNTaQ01MTAQAwCYExMg5gEwA
mAAEwABMAASIk0Ck2pvUeqP1BqNBoaaYABMmmLqyT50btmRkSOfOpc7aSYFDrmClitcxKBFB
LCs5bo5IoEORCYKOaH7XRh1/L+108y59Gjvz00J3bDsVs40SwnwLMiyKv9XFopMxtfuggVhZ
LxS0NezrKSjUyJRIQ6Q4o2H1YBEeD6bM5cr0SPt4tfICDKQrk8slABYMsjIRDNwu7qpjMfEr
eQVVFWyQpUO8xd7/YSOqr/wm3XuPHaOOKEtyJSUc5FEdd/GnXJB73xguNXFY5aD2tts6Sdga
5/QdkT4tdz+4384mw1x2pBWdgI+KQSIG9zfOAGxMHTPyZgpjN5Z5NcXdsDV1Z088qLm8bPKu
Us2d0UAwul6Um4Xisq7ABS8l2gxsG4OdoBiDCmtqO6EcDYy9ILrNfvmp52yc8af/LovMbnzM
LEGfS/zLSrwoYInr1dziOAENerXUN9v4punCW3NXBzTv0J1Z1J0u8L5MKp7spEjiUMc0EZV2
bCJmIZY4vB841KDdLln3U63Q/1a0an7r4VAGnIMICjk2MnCPYU10rBpLbTpqsKWdcs+G+ayF
WztYjCcGgISC7GwzosHtaCyCYS9ZxIZ6Z+ldzNfHMNuSFeMhGOkArQNoCmoX2An1YfBkNsjg
ONm/NUdmkatTj2JtWm3Ru4ESm6w2npyaxiOkTIvdyuLXz6jCK15OxSdshJ/e/3CRinYtGVmD
Jt0sjzVikDy5BWuoGHk19WM5S2T48hfVM9eZBW8CFEnE4nLOjRN50KKiUwTOaV/qQ55WukVS
C0tV0QavAFhfXianXsqUwx3BuRZWsFID2YNNgFZFRYRpYfJONBedlKRHIYLMG0UCmntkPQST
XF/rLSi1pspyGgy4K1KDNgRiNDbaQiSBpNWKMIqTrqUqVAmTDUbKQbhJNlpeNNcmWrf/GW1r
DKIGq6S3FTxadqKZ4bVkOtAOi4nwHpOK420xbqahYhQymGtACRFGBQoQXtsyebLosFmPFEDV
MHPHsJ0MUsrahgiVSsXNX8vgLelfJM1WGi7YYvzqlzM970NIDDW+vHoSs7XJBNhQx+5DNnVt
tv/F3JFOFCQBkkS5AA==

--jRHKVT23PllUwdXP--

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAh8+VreHfL3pi+bQRApAdAKCWTFbZG0ttbOY9fN5/DlbOZlDeVQCfcEzn
XcGT1Gj7jzYNB05xrE3QzKM=
=WH48
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
