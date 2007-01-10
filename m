Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7346B.FBDDDBE5"
Date: Wed, 10 Jan 2007 05:01:19 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EB9@eumonex01.palmsource.com>
References: <D8CE9CFA707C894180BAC8CDD154F8460AB04336@msiexch01.marvell.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :   RE :2 plugz issues
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

------_=_NextPart_001_01C7346B.FBDDDBE5
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Now get back to :
sbcbitpool=3D32
rate=3D44100
plugin-rate=3D44100
also add
flags=3D1 to display bandwith
With a bitpool of 32 you should see bandwith around 26703 b/s.

Here are a few tests.
Add enabledebug=3D0 in .a2dprc see if it is better (remove all traces)
Try a2dpd from btsco-0.5.tgz (not the cvs head) instead of plugz.
you could also test other bitpool values (53 is the only mandatory =
value, 64 or 16 or 8 can work too, but quality can suffer)
or another media player known to work, like xine or vlc.

with xmms Start streaming one minute then press stop on the player, does =
it continue playing?

Fr=E9d=E9ric




-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de Quinton Yuan
Date: mar. 09/01/2007 18:40
=C0: bluez-devel@lists.sourceforge.net
Objet : [Bluez-devel]  RE :2 plugz issues
=20
Frederic
Thanks for your reply, sounds still not right on headset side, below are =
.a2dprc file, attached is a2dpd log

Regards/Quinton

From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
Subject: [Bluez-devel] RE :  1. Re: 2 plugz issues (Brad Midgley)
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Message-ID:
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EB6@eumonex01.palmsource.com>
Content-Type: text/plain; charset=3D"iso-8859-1"

Try to add the following in .a2dprc
sbcbitpool=3D32
rate=3D44100
plugin-rate=3D0

If it doesn't fix the problem, then provide us your .a2dprc and what =
adapter you are using.

Fr?d?ric



[Shuangqing (Quinton) Yuan]=20
[a2dpd]
#
# Rate
# use 32000 if your headset seems to not support 44100 (HP works well at =
44100, Sonorix at 32000)
# However, 44100 is mandatory
#
rate=3D44100
sbcbitpool=3D32
#rate=3D32000

#
# plugin-rate default is the rate used between the plugin and the daemon
# if this value is 0 then=20
# if this value is not 0 then alsa will convert all stream to the =
specified rate and then send it to the daemon
# if this value is 0, then alsa will do no conversion at all, the daemon =
will do it's own resampling.
# This "features" is disabled because of the crappy quality of the =
daemon resampler
# To test a2dpd resampling from 32000 to 44100 use plugin-rate=3D32000 =
and rate=3D44100
#plugin-rate=3D32000
plugin-rate=3D0

# Recommended
enablereversestereo=3D1

#
# AVRCP Commands to run
# If these entries are emptied, then some keyboard entry will be sent to =
/dev/uinput
#
cmdplay=3Dxmms --play
cmdpause=3Dxmms --pause
cmdprev=3Dxmms --rew
cmdnext=3Dxmms --fwd
cmdnew=3Dxmms --play
# Put to 0 to ignore AVRCP (if your computer freezes when commands are =
received)
enableavrcp=3D1

#
# Audio routing
#
# If set to 1 (at a2dp startup only) a2dp will reread configuration file
#=C2 for audio routing changes each second
enablerereadconfig=3D1

# 0 =3D> Bluetooth A2DP Sink
# 1 =3D> Alsa
enableredirectalsa=3D0

# Your bluetooth headset address
#Belkin TuneStage
#address=3D00:08:1b:8a:40:95=20
#motorola S805
address=3D00:0C:55:D1:D0:D6
#BlueJay with A2DP demo program
#address=3D00:50:43:20:6c:62
# Address of your alsa output (default : plughw:0,0) you have to know =
what to do
alsaoutput=3D

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


------_=_NextPart_001_01C7346B.FBDDDBE5
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhQEAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAJwAAAFJFIDogW0JsdWV6LWRldmVs
XSAgUkUgOjIgcGx1Z3ogaXNzdWVzAHkMAQWAAwAOAAAA1wcBAAoABQABABMAAwAFAQEggAMADgAA
ANcHAQAKAAUAAQATAAMABQEBCYABACEAAAAzOTBCNTRDMzdDNDU5NjQ0OTQ0RkM0MkM1NzBEQzgx
MAAGBwEDkAYAlBEAADkAAAADACYAAAAAAAMANgAAAAAAQAA5AOXb3ftrNMcBHgA9AAEAAAABAAAA
AAAAAAIBRwABAAAANQAAAGM9dXM7YT0gO3A9UGFsbVNvdXJjZTtsPUVVTU9ORVgwMS0wNzAxMTAw
NDAxMTlaLTY4MjMAAAAAHgBJAAEAAAAiAAAAW0JsdWV6LWRldmVsXSAgUkUgOjIgcGx1Z3ogaXNz
dWVzAAAAQABOAADxHVIVNMcBHgBaAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVl
ei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRldmVsLWJv
dW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxVRVotREVW
RUwtQk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAB4AXQABAAAADQAAAFF1aW50b24gWXVh
bgAAAAACAV4AAQAAADwAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABRdWludG9uIFl1YW4AU01U
UABxeXVhbkBtYXJ2ZWxsLmNvbQACAV8AAQAAABcAAABTTVRQOlFZVUFOQE1BUlZFTEwuQ09NAAAe
AGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMu
c291cmNlZm9yZ2UubmV0AAAAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkAAQAAABIAAABxeXVhbkBt
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
bx9WSQ9icw+hGk9Pwm8cZBxjLQDfEC9NeSl6fQEgQAAAHgA1EAEAAABCAAAAPDdBNkRBNTQ1RDdG
RENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RUI5QGV1bW9uZXgwMS5wYWxtc291cmNlLmNvbT4AAAAe
ADkQAQAAAEEAAAA8RDhDRTlDRkE3MDdDODk0MTgwQkFDOENERDE1NEY4NDYwQUIwNDMzNkBtc2ll
eGNoMDEubWFydmVsbC5jb20+AAAAAB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAA
AB8A8xABAAAAXgAAAFIARQAgACUAMwBBACAAWwBCAGwAdQBlAHoALQBkAGUAdgBlAGwAXQAgACAA
UgBFACAAJQAzAEEAMgAgAHAAbAB1AGcAegAgAGkAcwBzAHUAZQBzAC4ARQBNAEwAAAAAAAsA9hAA
AAAAQAAHMHAiqg9oNMcBQAAIMKLH6ftrNMcBAwDeP69vAAADAPE/DAQAAB4A+D8BAAAAEQAAAEZy
ZWRlcmljIERhbGxlYXUAAAAAAgH5PwEAAABbAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAA
AC9PPVBBTE1TT1VSQ0UvT1U9TU9OVFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5E
QUxMRUFVAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAA
AAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMA
HUAAAAAAAwAeQAAAAAAeADBAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAA
AEZSRURFUklDLkRBTExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQAAAAeADNAAQAAABIAAABxeXVhbkBtYXJ2ZWxsLmNvbQAAAB4AOEAB
AAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgA5QAEAAAACAAAALgAAAAMAdkD/////CwApAAAA
AAALACMAAAAAAAMABhB4G7B5AwAHEFsLAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAATk9X
R0VUQkFDS1RPOlNCQ0JJVFBPT0w9MzJSQVRFPTQ0MTAwUExVR0lOLVJBVEU9NDQxMDBBTFNPQURE
RkxBR1M9MVRPRElTUExBWUJBTkRXSVRIV0lUSEFCSVRQT09MT0YzMgAAAAACAX8AAQAAAEIAAAA8
N0E2REE1NDVEN0ZEQ0M0QjkzREI2NTFGREJDMUVEREU0RTZFQjlAZXVtb25leDAxLnBhbG1zb3Vy
Y2UuY29tPgAAAMxv

------_=_NextPart_001_01C7346B.FBDDDBE5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C7346B.FBDDDBE5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C7346B.FBDDDBE5--
