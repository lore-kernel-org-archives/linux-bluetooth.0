Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C75664.0AD88E92"
Date: Thu, 22 Feb 2007 10:29:14 +0100
Message-ID: <7FEBB30F0CE41B419B38295024A58EE3A10D46@oxygen.mail.telnet.tunis>
From: "Asma Tebessi" <asma.tebessi@telnet.com.tn>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] RE :  modprobe snd-bt-sco
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75664.0AD88E92
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=20

where can I do make modules?? I tried to do it under =
/lib/modules/2.6.12-12mdk but I got :=20

make: *** Pas de r=E8gle pour fabriquer la cible =AB modules_install =
=BB. Arr=EAt




-------- Message d'origine--------
De: bluez-users-bounces@lists.sourceforge.net de la part de Paulo =
Gon=E7alves
Date: jeu. 22/02/2007 10:20
=C0: BlueZ users
Objet : Re: [Bluez-users] modprobe snd-bt-sco
=20
Hi !

On 2/22/07, Asma Tebessi <asma.tebessi@telnet.com.tn> wrote:

>  Hi all,
>
> I've installed the latest versions of bluez 'bluez-utils-3.9,
> bluez-libs-3.9, bluez-hcidump-1.33 and bluez-firmware-1.2' under =
Mandriva
> 2006 and I can establish a connection between my pc and my nokia N70. =
I want
> to have the handsfree option available so I add it with : sdptool add
> --channel=3D2 HF (the channel for handsfree on N70 is the number 1) =
and the
> test seems to work since I had an icon on my nokia when I launch :
>  rfcomm connect /dev/rfcomm0 00:16:4E:D9:20:98 2
> The connection lasts only few secondes then terminate. So I make : =
rfcomm
> listen /dev/rfcomm0  2 and try to call the nokia N70 from another =
phone. The
> N7O contact the pc via bluetooth and I enter the PIN in both sides and =
the
> connection is done but when I hangup the sound doesn't came from the =
pc's
> headspeaker but from N70's one.
> I thought I need to install the bluetooth-alsa to make it work. So I =
do, I
> installed btsco-0.5, plugz and sbc and I've got no errors. I followed =
the
> instructions within this document "
> http://www.linux.ie/articles/bluetoothheadset.php" but when I made
> modprobe snd-bt-sco I got :
>
> [root@localhost confhandsfree]# modprobe snd-bt-sco
> FATAL: Module snd-bt-sco not found.
>
> I dont understand how to make it work since I got no errors while
> compiling the btsco and processing the
> "cd kernel - make - make install - depmod -e - make clean"
>

try "make modules"

 Otherwise, I tried to connect my bluetooth dongle 'belkin' and I got :
>
> [root@localhost confhandsfree]# btsco 00:0A:3A:50:27:84   2
> Error: hwdep next device (hw:0): Operation not permitted
> Error: control open (hw:1): No such device
> Error: Can't find device. Bail
>
> I hope that you'll help me I need to make this work as soon as =
possible
> and I'm lost :(
>
> Thanks a lot.
>
> =
-------------------------------------------------------------------------=

> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to =
share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> =
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
Paulo Gon=E7alves


------_=_NextPart_001_01C75664.0AD88E92
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgkJAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAJwAAAFJFIDogW0JsdWV6LXVzZXJz
XSBtb2Rwcm9iZSBzbmQtYnQtc2NvAHwNAQWAAwAOAAAA1wcCABYACgAdAA4ABAAvAQEggAMADgAA
ANcHAgAWAAoAHgAIAAQAKgEBCYABACEAAAAwMkM4N0VCOEVERDM0QjQyQjVBMkEzQUVBNTMyNEE3
RABeBwEDkAYAVA8AADgAAAADACYAAAAAAAMANgAAAAAAQAA5APyPCutjVscBHgA9AAEAAAABAAAA
AAAAAAIBRwABAAAANgAAAGM9RlI7YT0gO3A9R3JvdXBlIFRlbG5ldDtsPU9YWUdFTi0wNzAyMjIw
OTMwMDhaLTExNDY5AAAAHgBJAAEAAAAmAAAAUmU6IFtCbHVlei11c2Vyc10gbW9kcHJvYmUgc25k
LWJ0LXNjbwAAAEAATgAAOebCYlbHAR4AWgABAAAAKgAAAGJsdWV6LXVzZXJzLWJvdW5jZXNAbGlz
dHMuc291cmNlZm9yZ2UubmV0AAAAAgFbAAEAAABxAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAA
Ymx1ZXotdXNlcnMtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01UUABibHVlei11c2Vy
cy1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAACAVwAAQAAAC8AAABTTVRQOkJMVUVa
LVVTRVJTLUJPVU5DRVNATElTVFMuU09VUkNFRk9SR0UuTkVUAAAeAF0AAQAAABAAAABQYXVsbyBH
b27nYWx2ZXMAAgFeAAEAAABFAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAUGF1bG8gR29u52Fs
dmVzAFNNVFAAcGFmLmdvbmNhbHZlc0BnbWFpbC5jb20AAAAAAgFfAAEAAAAdAAAAU01UUDpQQUYu
R09OQ0FMVkVTQEdNQUlMLkNPTQAAAAAeAGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAAKgAAAGJs
dWV6LXVzZXJzLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgBoAAEAAAAFAAAAU01U
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
v55BemEO0WBRDeAe0CiswNWqoCkkIE93kHIqME2i/5MSrnFlsAJACYCr3W1SA2C/AyBSIE4xreJZ
gCQgTh9g3nMbcKVhrYOr3UMAcHVx70lAdPKtgymwQlKxk79sAKd3kEMBKjAgeQhgJylB/R6gbHRg
dcF6WB+DhSNbg/8lsTCQUmIEICagPWEn4UA2z4EEX6AYUEOROihBPWLA/QBwa3Ehu6E+0EE9LDa/
T9/AX8FvwlxiRx+SUwhwM2C6eYJRRQrAErElsGhPwe+O8ApBW/JDEkYjkAhwUgHJRGBJVEA2Sm9w
YWYw/TCyRjEGeME9IBDgLPBOcf8AcFchSKK3BS0QbbRVssXi/7IhEPFaF7cBJhBARVIgC4DjRAQf
EVQgJiNxW9Es0fsg4ZlgY1iyA2B6ASNwCIH/RGCyQMRTfEBIsSogBKEe8P9M4IYfhyAOsMkjPuJg
QSbwmyAAiVM/CrAtED1qx6ERiWImcD0wmSZDSWBEPURFVtYxQDZf/9cf2C/Y+kA2OEkfcZl0MDLf
2g8REDAvMTPRinOG0d1P/zFC34TfgwuAAhCIUy81QTwvHdQyfzOFHdR95cAAAB4ANRABAAAAQgAA
ADw3RkVCQjMwRjBDRTQxQjQxOUIzODI5NTAyNEE1OEVFM0ExMEQ0NkBveHlnZW4ubWFpbC50ZWxu
ZXQudHVuaXM+AAAAHgBHEAEAAAAPAAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDzEAEAAABa
AAAAUgBFACAAJQAzAEEAIABbAEIAbAB1AGUAegAtAHUAcwBlAHIAcwBdACAAbQBvAGQAcAByAG8A
YgBlACAAcwBuAGQALQBiAHQALQBzAGMAbwAuAEUATQBMAAAAAAALAPYQAAAAAEAABzCiLQjrY1bH
AUAACDCgtd8KZFbHAQMA3j+vbwAAAwDxPwwEAAAeAPg/AQAAAA0AAABBc21hIFRlYmVzc2kAAAAA
AgH5PwEAAABuAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPUdST1VQRSBURUxORVQv
T1U9UFJFTUlFUiBHUk9VUEUgRCdBRE1JTklTVFJBVElPTi9DTj1SRUNJUElFTlRTL0NOPUFTTUEu
VEVCRVNTSQAAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8BAAAAHgAA
AAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlAAAAAAAMAGkAAAAAA
AwAdQAAAAAADAB5AAAAAAB4AMEABAAAADQAAAEFTTUEuVEVCRVNTSQAAAAAeADFAAQAAAA0AAABB
U01BLlRFQkVTU0kAAAAAHgAyQAEAAAAqAAAAYmx1ZXotdXNlcnMtYm91bmNlc0BsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQAAAAeADNAAQAAABgAAABwYWYuZ29uY2FsdmVzQGdtYWlsLmNvbQAeADhAAQAA
AA0AAABBU01BLlRFQkVTU0kAAAAAHgA5QAEAAAACAAAALgAAAAMAdkD/////CwApAAAAAAALACMA
AAAAAAMABhAInBOFAwAHEIMIAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAASEksV0hFUkVD
QU5JRE9NQUtFTU9EVUxFUz8/SVRSSUVEVE9ET0lUVU5ERVIvTElCL01PRFVMRVMvMjYxMi0xMk1E
S0JVVElHT1Q6TUFLRToqKipQQVNERVLoR0xFUE9VUkZBQgAAAAACAX8AAQAAAEIAAAA8N0ZFQkIz
MEYwQ0U0MUI0MTlCMzgyOTUwMjRBNThFRTNBMTBENDZAb3h5Z2VuLm1haWwudGVsbmV0LnR1bmlz
PgAAANB/

------_=_NextPart_001_01C75664.0AD88E92
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C75664.0AD88E92
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------_=_NextPart_001_01C75664.0AD88E92--
