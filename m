Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C73A05.9E407E95"
Date: Wed, 17 Jan 2007 08:03:40 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>
References: <200701150326.46855.bluez-devel@huitl.de>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : a2dpd and mplayer - any chance to get it working?
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

------_=_NextPart_001_01C73A05.9E407E95
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Robert,
The sound is ok in mplayer! But the movie is a bit slow :D ...
If you plugin is the pcm.!default, then you can workaround the problem =
by outputting audio to esound instead of alsa (see mplayer preferences).
Not the best, but worked for me. +/- helped having perfect =
synchronisation with movie.


Brad,
 I was wondering about alsa plugins :
xmms relies on alsa timing to play, so in the plugin, there is a sleep() =
call, this will wait a little bit until it is time to retievre new data.
But it seems some players (like mplayer) wants to do their own timing or =
at least don't want to sleep. They need to use that time to do some =
decoding instead. If you sleep too long, the decoding will be defered =
and the sound or movie will be broken.

Is there a rule to distinguish? Or some magic value to sleep?

Fr=E9d=E9ric


-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de Robert Huitl
Date: lun. 15/01/2007 03:26
=C0: bluez-devel@lists.sourceforge.net
Objet : [Bluez-devel] a2dpd and mplayer - any chance to get it working?
=20
Hi,

I was wondering whether it is possible to make the a2dp alsa plugin =
supply=20
correct audio timing to applications like MPlayer. Right now, MPlayer =
does=20
not work with a2dpd because it relies on the audio driver to report =
accurate=20
audio timing information (or something like that).

If a2dpd could measure the delay introduced on the wireless transport, =
it=20
might be possible to supply timing information to media players. The =
player=20
could then sync the video to the audio data, so there should be no delay =
at=20
all between audio and video playback.

Is there something I am missing?
What changes to the alsa plugin would be necessary?

Even if the delay can't be determined exactly, we could just fake that=20
information MPlayer is missing, so that a2dpd at least worked together =
with=20
MPlayer (with a small delay, maybe)?

Regards,
  Robert

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


------_=_NextPart_001_01C73A05.9E407E95
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IikHAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEARQAAAFJFIDogW0JsdWV6LWRldmVs
XSBhMmRwZCBhbmQgbXBsYXllciAtIGFueSBjaGFuY2UgdG8gZ2V0IGl0IHdvcmtpbmc/AFcXAQWA
AwAOAAAA1wcBABEACAADACgAAwAmAQEggAMADgAAANcHAQARAAgAAwAoAAMAJgEBCYABACEAAAAx
RUVGQzBGQTY1QzlCQjQzOUQxMzI2MkU5RDdCMzBDRABtBwEDkAYAAA8AADkAAAADACYAAAAAAAMA
NgAAAAAAQAA5AJV+QJ4FOscBHgA9AAEAAAABAAAAAAAAAAIBRwABAAAANQAAAGM9dXM7YT0gO3A9
UGFsbVNvdXJjZTtsPUVVTU9ORVgwMS0wNzAxMTcwNzAzNDBaLTk3MjIAAAAAHgBJAAEAAABAAAAA
W0JsdWV6LWRldmVsXSBhMmRwZCBhbmQgbXBsYXllciAtIGFueSBjaGFuY2UgdG8gZ2V0IGl0IHdv
cmtpbmc/AEAATgAAd0GaTDjHAR4AWgABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMu
c291cmNlZm9yZ2UubmV0AAAAAgFbAAEAAABxAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAYmx1
ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01UUABibHVlei1kZXZlbC1i
b3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAACAVwAAQAAAC8AAABTTVRQOkJMVUVaLURF
VkVMLUJPVU5DRVNATElTVFMuU09VUkNFRk9SR0UuTkVUAAAeAF0AAQAAAA0AAABSb2JlcnQgSHVp
dGwAAAAAAgFeAAEAAAA/AAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAUm9iZXJ0IEh1aXRsAFNN
VFAAYmx1ZXotZGV2ZWxAaHVpdGwuZGUAAAIBXwABAAAAGgAAAFNNVFA6QkxVRVotREVWRUxASFVJ
VEwuREUAAAAeAGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5j
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
b6O/pM+l37em7x4Fa0JTCHBZYHmEoe5FCsASsTNgaEkReMAKQTtlcx5xRiAwfPIpcUlUqR4ESm8f
YVNak0Za9uonBCBUBZBoKcAnIAqw7z5QAyBMciLRJzsxZeIgYn9lSFFQCsAegCLRVDAeE2+ecAuA
b6MwcatwICYswfePwX9DsRFjI5Il8XDwTlH/CJAisHzhqOJk05ahqVIlYA9RUB4EcQAnYDovL3ct
tkAuDrCtgy4FoG0vcSRFLnBoU0AKsFcAPUZqrAG3siZwPVqJJoBDSUQ9REVWugH9HgRfus+737yq
MhVY+FIBfwMQehQpEL2/YK9hubXSc7+2EcC/WzLC1MLTeLIvWOkFVQp9xrAAAAAeADUQAQAAAEIA
AAA8N0E2REE1NDVEN0ZEQ0M0QjkzREI2NTFGREJDMUVEREU0RTZFQkZAZXVtb25leDAxLnBhbG1z
b3VyY2UuY29tPgAAAB4AORABAAAAKgAAADwyMDA3MDExNTAzMjYuNDY4NTUuYmx1ZXotZGV2ZWxA
aHVpdGwuZGU+AAAAHgBHEAEAAAAPAAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDzEAEAAACa
AAAAUgBFACAAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQAZQB2AGUAbABdACAAYQAyAGQAcABkACAA
YQBuAGQAIABtAHAAbABhAHkAZQByACAALQAgAGEAbgB5ACAAYwBoAGEAbgBjAGUAIAB0AG8AIABn
AGUAdAAgAGkAdAAgAHcAbwByAGsAaQBuAGcAJQAzAEYALgBFAE0ATAAAAAAACwD2EAAAAABAAAcw
hjs5PgQ6xwFAAAgwUmpMngU6xwEDAN4/r28AAAMA8T8MBAAAHgD4PwEAAAARAAAARnJlZGVyaWMg
RGFsbGVhdQAAAAACAfk/AQAAAFsAAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAAL089UEFM
TVNPVVJDRS9PVT1NT05UUEVMTElFUi9DTj1SRUNJUElFTlRTL0NOPUZSRURFUklDLkRBTExFQVUA
AB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8BAAAAHgAAAAAAAADcp0DI
wEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlAAAAAAAMAGkAAAAAAAwAdQAAAAAAD
AB5AAAAAAB4AMEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAxQAEAAAARAAAARlJFREVS
SUMuREFMTEVBVQAAAAAeADJAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldAAAAB4AM0ABAAAAFQAAAGJsdWV6LWRldmVsQGh1aXRsLmRlAAAAAB4AOEABAAAA
EQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgA5QAEAAAACAAAALgAAAAMAdkD/////CwApAAAAAAAL
ACMAAAAAAAMABhAMVXw+AwAHEJsHAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAAUk9CRVJU
LFRIRVNPVU5ESVNPS0lOTVBMQVlFUkJVVFRIRU1PVklFSVNBQklUU0xPVzpESUZZT1VQTFVHSU5J
U1RIRVBDTURFRkFVTFQsVEhFTllPVUNBTldPUktBUk9VTkRUSAAAAAACAX8AAQAAAEIAAAA8N0E2
REE1NDVEN0ZEQ0M0QjkzREI2NTFGREJDMUVEREU0RTZFQkZAZXVtb25leDAxLnBhbG1zb3VyY2Uu
Y29tPgAAAMJF

------_=_NextPart_001_01C73A05.9E407E95
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C73A05.9E407E95
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C73A05.9E407E95--
