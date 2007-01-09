Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C733CB.6F3FDE75"
Date: Tue, 9 Jan 2007 09:47:49 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EB6@eumonex01.palmsource.com>
References: <D8CE9CFA707C894180BAC8CDD154F8460AB03AE5@msiexch01.marvell.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  1. Re: 2 plugz issues (Brad Midgley)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C733CB.6F3FDE75
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Try to add the following in .a2dprc
sbcbitpool=3D32
rate=3D44100
plugin-rate=3D0

If it doesn't fix the problem, then provide us your .a2dprc and what =
adapter you are using.

Fr=E9d=E9ric




-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de Quinton Yuan
Date: mar. 09/01/2007 00:41
=C0: bluez-devel@lists.sourceforge.net
Objet : [Bluez-devel] 1. Re: 2 plugz issues (Brad Midgley)
=20
Hi, there

I am new to the Bluez thing, thanks for the great work you guys have
done !
By following your documentation on project home page, I just installed
latest plugz package on Fedora Core 6 (kernel 2.6.18-1.2869), basically
both mono and stereo headset up running, except

1. For mono headset, need to apply Kevin's change to make it work (will
patch kernel later, but same question as Kevin, which kernel version
this patch can be applied ?)

2. For A2DP thing, audio quality sounds weird, I got lots of message as:
  A2DPD[805.068]: a2dp_handler: Sound System dry!,=20

no matter what sample rate I use, audio seems being played back at very
lower rate, however, same setup a2play works fine, any hint on this ?=20

Here is my system information
bluez-libs-3.7-1
bluez-libs-devel-3.7-1
bluez-hcidump-1.32-1
bluez-gnome-0.6-1.fc6
bluez-utils-cups-3.7-2
bluez-utils-3.7-2

gnome-bluetooth-libs-0.7.0-11.fc6
gnome-bluetooth-0.7.0-11.fc6
nautilus-sendto-bluetooth-0.7.5.fc6

alsa-lib-1.0.12-2.fc6
alsa-lib-devel-1.0.12-2.fc6
alsa-utils-1.0.12-3.fc6

xmms 1.2.10

Thanks in advance.

Regards/Quinton

-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


------_=_NextPart_001_01C733CB.6F3FDE75
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgUIAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAOAAAAFJFIDogW0JsdWV6LWRldmVs
XSAxLiBSZTogMiBwbHVneiBpc3N1ZXMgKEJyYWQgTWlkZ2xleSkAzREBBYADAA4AAADXBwEACQAJ
AC8AMQACAFMBASCAAwAOAAAA1wcBAAkACQA0AAQAAgArAQEJgAEAIQAAADQ5NzFEMTA0M0E3REMx
NEJCOEUwNUNENDVBREQzQjlEAFYHAQOQBgBYDgAAOQAAAAMAJgAAAAAAAwA2AAAAAABAADkAGJSC
18ozxwEeAD0AAQAAAAEAAAAAAAAAAgFHAAEAAAA1AAAAYz11czthPSA7cD1QYWxtU291cmNlO2w9
RVVNT05FWDAxLTA3MDEwOTA4NTIwNFotNjMwMgAAAAAeAEkAAQAAADMAAABbQmx1ZXotZGV2ZWxd
IDEuIFJlOiAyIHBsdWd6IGlzc3VlcyAoQnJhZCBNaWRnbGV5KQAAQABOAIDrq3d+M8cBHgBaAAEA
AAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAA
AHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxVRVotREVWRUwtQk9VTkNFU0BMSVNUUy5TT1VSQ0VG
T1JHRS5ORVQAAB4AXQABAAAADQAAAFF1aW50b24gWXVhbgAAAAACAV4AAQAAADwAAAAAAAAAgSsf
pL6jEBmdbgDdAQ9UAgAAAABRdWludG9uIFl1YW4AU01UUABxeXVhbkBtYXJ2ZWxsLmNvbQACAV8A
AQAAABcAAABTTVRQOlFZVUFOQE1BUlZFTEwuQ09NAAAeAGYAAQAAAAUAAABTTVRQAAAAAB4AZwAB
AAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgBoAAEA
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
DrCZEy4FoG0vAQFe0IBsdC5waHA/R3KMPWqXkaNCJnA9MXkAJkNJRD1ERVb7pZEfxF+mX6dvqDpE
FS/o/zTBAxAe4jeiqU83nzipoWJ/YgChsKxPMiKuZK5jcYIvCy/ZIyp9skAAHgA1EAEAAABCAAAA
PDdBNkRBNTQ1RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RUI2QGV1bW9uZXgwMS5wYWxtc291
cmNlLmNvbT4AAAAeADkQAQAAAEEAAAA8RDhDRTlDRkE3MDdDODk0MTgwQkFDOENERDE1NEY4NDYw
QUIwM0FFNUBtc2lleGNoMDEubWFydmVsbC5jb20+AAAAAB4ARxABAAAADwAAAG1lc3NhZ2UvcmZj
ODIyAAALAPIQAQAAAB8A8xABAAAAgAAAAFIARQAgACUAMwBBACAAWwBCAGwAdQBlAHoALQBkAGUA
dgBlAGwAXQAgADEALgAgAFIAZQAlADMAQQAgADIAIABwAGwAdQBnAHoAIABpAHMAcwB1AGUAcwAg
ACgAQgByAGEAZAAgAE0AaQBkAGcAbABlAHkAKQAuAEUATQBMAAAACwD2EAAAAABAAAcwGJSC18oz
xwFAAAgw2WdJb8szxwEDAN4/r28AAAMA8T8MBAAAHgD4PwEAAAARAAAARnJlZGVyaWMgRGFsbGVh
dQAAAAACAfk/AQAAAFsAAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAAL089UEFMTVNPVVJD
RS9PVT1NT05UUEVMTElFUi9DTj1SRUNJUElFTlRTL0NOPUZSRURFUklDLkRBTExFQVUAAB4A+j8B
AAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5
CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlAAAAAAAMAGkAAAAAAAwAdQAAAAAADAB5AAAAA
AB4AMEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAxQAEAAAARAAAARlJFREVSSUMuREFM
TEVBVQAAAAAeADJAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldAAAAB4AM0ABAAAAEgAAAHF5dWFuQG1hcnZlbGwuY29tAAAAHgA4QAEAAAARAAAARlJFREVS
SUMuREFMTEVBVQAAAAAeADlAAQAAAAIAAAAuAAAAAwB2QP////8LACkAAAAAAAsAIwAAAAAAAwAG
EMuoH0ADAAcQbwYAAAMAEBAAAAAAAwAREAAAAAAeAAgQAQAAAGUAAABUUllUT0FERFRIRUZPTExP
V0lOR0lOQTJEUFJDU0JDQklUUE9PTD0zMlJBVEU9NDQxMDBQTFVHSU4tUkFURT0wSUZJVERPRVNO
VEZJWFRIRVBST0JMRU0sVEhFTlBST1ZJREVVAAAAAAIBfwABAAAAQgAAADw3QTZEQTU0NUQ3RkRD
QzRCOTNEQjY1MUZEQkMxRURERTRFNkVCNkBldW1vbmV4MDEucGFsbXNvdXJjZS5jb20+AAAA2gg=

------_=_NextPart_001_01C733CB.6F3FDE75
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C733CB.6F3FDE75
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C733CB.6F3FDE75--
