Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C63933.871BF8D9"
Subject: RE: [Bluez-users] ISSC USB dongle can't ping with size 1000
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011B0A@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-users@lists.sourceforge.net>
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
Date: Fri, 24 Feb 2006 19:14:49 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C63933.871BF8D9
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi, Marcel:
=20
     Frankly I don't know much about ISSC chip's internals since I work =
mainly=20
at application level. Your comments and information are highly =
appriciated and
I will pass them to ASIC and System team to see if I can get some =
feedbacks.
=20
     In the mean time, I wonder if there is a work-around solution to =
this problem.
For example, set MTU to 1000 or refrain BlueZ HCI to send smaller packet =
size.
Also, can you tell a bit more about the buffer size you mentioned? Where =
I can
modify for a quick test and what's the current buffer size?
=20
Best Regards,
=20
Al  =20

	-----Original Message-----=20
	From: bluez-users-admin@lists.sourceforge.net =A5N=B2z Marcel Holtmann=20
	Sent: 2006/2/23 [=ACP=B4=C1=A5|] =A4U=A4=C8 07:23=20
	To: bluez-users@lists.sourceforge.net=20
	Cc:=20
	Subject: Re: [Bluez-users] ISSC USB dongle can't ping with size 1000
=09
=09

	Hi Al,
=09
	> >     I have the same problem as below which was posted last month.
	> >
	> > >   I started to play with the ping size. 'ping -s 900' works, =
'ping -s 1000'
	> > > kills the PAN connection. There was hope! Then I played with MTU =
(on both
	> > > sides): 'ifconfig bnep0 mtu 1000' solves all my problems (default =
is
	> > > 1500)!!! With this setting I've a rock solid 75 kByte/s transfer =
rate over
	> > > ftp. A mtu of 1017 still works, 1018 definitely kills the =
connection.
	> >
	> >      I wonder if there is other solutions to this problem cause the =
above solution needs to set MTU to 1000 on both sides.
	> >
	> >      I try ISSC dongle with IVT software as NAP on Windows XP. Ping =
with size
	> > 1500 works fine. It seems ISSC chip has some problems to work with =
BlueZ, in
	> > addition to adding HCI_RESET.
	>
	> I am pretty sure that your chip is at fault here. I have no internals
	> about your chip, but whatever buffer size you tell us, we will use. =
And
	> BlueZ will use it as fast as possible. The latency is very low and =
the
	> HCI flow control works fine. So I assume there exists a race =
condition
	> in your side of the HCI flow control implementation which triggers a
	> problem. You can verify with hcidump that we do everything right. The
	> faulty application is actually not BNEP here. I think you can =
reproduce
	> it with any program sending big L2CAP packets. So a test setup with
	> l2test and different MTU might trigger it more easily.
=09
	and I just did a quick search through the mailing list archive and
	actually I found these four version:
=09
	ACL MTU: 678:12  SCO MTU: 48:5   LMP Ver: 1.1  LMP Subver: 0x172
	ACL MTU: 678:8   SCO MTU: 48:5   LMP Ver: 1.1  LMP Subver: 0x1a4
	ACL MTU: 678:8   SCO MTU: 48:10  LMP Ver: 1.2  LMP Subver: 0x1ae
	ACL MTU: 678:8   SCO MTU: 48:10  LMP Ver: 1.2  LMP Subver: 0x1f4
=09
	The LMP Subver must somehow decode into the version number of your
	firmware, but I have no idea how. However you see the different ACL MTU
	sizes the chip offers and BlueZ is simply using them.
=09
	Regards
=09
	Marcel
=09
=09
=09
=09
	-------------------------------------------------------
	This SF.Net email is sponsored by xPML, a groundbreaking scripting =
language
	that extends applications into web and mobile media. Attend the live =
webcast
	and join the prime developer group breaking into this new coding =
territory!
	=
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
	_______________________________________________
	Bluez-users mailing list
	Bluez-users@lists.sourceforge.net
	https://lists.sourceforge.net/lists/listinfo/bluez-users
=09


------_=_NextPart_001_01C63933.871BF8D9
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjMLAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAPAAAAFJFOiBbQmx1ZXotdXNlcnNd
IElTU0MgVVNCIGRvbmdsZSBjYW4ndCBwaW5nIHdpdGggc2l6ZSAxMDAwAFITAQWAAwAOAAAA1gcC
ABgAEwAOADEABQBOAQEggAMADgAAANYHAgAYABMADgAyAAUATwEBCYABACEAAABBODNFQ0JFOEZB
OEU3MjRBOEVFMzI3MzRFQkRENkI1QgCYBwEDkAYAmBoAADgAAAADADYAAAAAAEAAOQDZ+BuHMznG
AR4APQABAAAABQAAAFJFOiAAAAAAAgFHAAEAAAAvAAAAYz11czthPSA7cD11bmltaXM7bD1ORVRC
RTAxLTA2MDIyNDExMTQ0OVotODU0NAAAHgBJAAEAAAA8AAAAUmU6IFtCbHVlei11c2Vyc10gSVNT
QyBVU0IgZG9uZ2xlIGNhbid0IHBpbmcgd2l0aCBzaXplIDEwMDAAQABOAAAZcJdrOMYBHgBaAAEA
AAAoAAAAYmx1ZXotdXNlcnMtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AAIBWwABAAAAbQAA
AAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAGJsdWV6LXVzZXJzLWFkbWluQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldABTTVRQAGJsdWV6LXVzZXJzLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAAC
AVwAAQAAAC0AAABTTVRQOkJMVUVaLVVTRVJTLUFETUlOQExJU1RTLlNPVVJDRUZPUkdFLk5FVAAA
AAAeAF0AAQAAABAAAABNYXJjZWwgSG9sdG1hbm4AAgFeAAEAAABBAAAAAAAAAIErH6S+oxAZnW4A
3QEPVAIAAAAATWFyY2VsIEhvbHRtYW5uAFNNVFAAbWFyY2VsQGhvbHRtYW5uLm9yZwAAAAACAV8A
AQAAABkAAABTTVRQOk1BUkNFTEBIT0xUTUFOTi5PUkcAAAAAHgBmAAEAAAAFAAAAU01UUAAAAAAe
AGcAAQAAACgAAABibHVlei11c2Vycy1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAHgBoAAEA
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
Q3LI03AFIBe0kB6wNYBiHeB4UE1eTL1wK8ApkEiyYh6wYdJrKiJzYxDQcPrgQ8L9KSBnSCAHIOv/
7Q/krBHz5+9P8F9ytGV4NRAqAAdR7xyYyPC1gxJAYjVTN5AqYCcNYDZw8zBpYb7wQXT//BJDI+SA
RJH9kRBwPtD2L5/3Pz1/+W/6f3Klam/kkB9DIw0gySASUb9BbG9w/79h9BLHsPR3tYUdQeSgtPB3
tTEqIjUQchDQtaAS0CHPAG8Bf+Svprs8QQSEJgAhQsBlZj0iqAB0cEg6Ly9CQGwuN/AtpcmALhmQ
bGsLQC4MsAJ0D/I/Y21kPWx9H0AmKbCnwPSwEbALYDA4OTQ0EgMqYBGwMjS1ZYEwEgNkHOASgDIL
cFg0MiIL2aiBadlgZB0DwmYV4AygPtB7SFkAUEVSTElOSyA/D48QnxGlElkTSRQ5fX0PqIEV4MgQ
cnBcY2Yx/Fx18nAM+Bd/GI8Rs6aP+xISp+gmDPgSWCBPIV8NFv8TSCOPJJ8NFhQ4p/eduSoPyeVe
OTILkC9BC9AKn/sLrwy8XzDfMe8yui3fLu/7DLzIgnoeocgCA68Ev3K030N6M8803zXvNvZAQ/Ie
wO+0kEwA2VBIoHL2ABjiOs/vO98Mvw3PDt5zHhE+jxjjz0VTRUNB4EigL2I22BTf/xXvFvpFH0Yv
Rz9IQBwPHR73Sz9MT01fcytPKx9Cfy0/L0BPQV9V71hCNViRL0b4T05UWOlUb1lgOHJVqL9Z6Dhj
We9yNmWQV0FQV44CMEOxL0JMT0NLYFFVT1RFXB9gP2dPVPE4j2XPcmM1OGLST7xEWVeNVzBnT2nR
N1dBLEhU87BY4H1sAAAAHgA1EAEAAAA8AAAAPEU2NEJBRDVBOEFENDY3NDA4MjgwNjlBNjc4RDlE
RDczMDExQjBBQG5ldGJlMDEubmV0LnVuaW1pcz4AHgBHEAEAAAAPAAAAbWVzc2FnZS9yZmM4MjIA
AAsA8hABAAAAHwDzEAEAAACEAAAAUgBFACUAMwBBACAAWwBCAGwAdQBlAHoALQB1AHMAZQByAHMA
XQAgAEkAUwBTAEMAIABVAFMAQgAgAGQAbwBuAGcAbABlACAAYwBhAG4AJwB0ACAAcABpAG4AZwAg
AHcAaQB0AGgAIABzAGkAegBlACAAMQAwADAAMAAuAEUATQBMAAAACwD0EAAAAAALAPUQAAAAAAsA
9hAAAAAAQAAHMNtILYEzOcYBQAAIMEPhZYczOcYBAwDeP7YDAAADAPE/BAQAAB4A+D8BAAAAAwAA
AEFsAAACAfk/AQAAAF0AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAAL089VU5JTUlTL09V
PUZJUlNUIEFETUlOSVNUUkFUSVZFIEdST1VQL0NOPVJFQ0lQSUVOVFMvQ049QUwuSVNTQwAAAAAe
APo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBC
EBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T+2AwAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAe
QAAAAAAeADBAAQAAAAgAAABBTC5JU1NDAB4AMUABAAAACAAAAEFMLklTU0MAHgAyQAEAAAAoAAAA
Ymx1ZXotdXNlcnMtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AB4AM0ABAAAAFAAAAG1hcmNl
bEBob2x0bWFubi5vcmcAHgA4QAEAAAAIAAAAQUwuSVNTQwAeADlAAQAAAAIAAAAuAAAACwApAAAA
AAALACMAAAAAAAMABhCjH9ZfAwAHEBgKAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAASEks
TUFSQ0VMOkZSQU5LTFlJRE9OVEtOT1dNVUNIQUJPVVRJU1NDQ0hJUFNJTlRFUk5BTFNTSU5DRUlX
T1JLTUFJTkxZQVRBUFBMSUNBVElPTkxFVkVMWU9VUkNPTU1FTlRTQQAAAAACAX8AAQAAADwAAAA8
RTY0QkFENUE4QUQ0Njc0MDgyODA2OUE2NzhEOURENzMwMTFCMEFAbmV0YmUwMS5uZXQudW5pbWlz
PgBFdA==

------_=_NextPart_001_01C63933.871BF8D9--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
