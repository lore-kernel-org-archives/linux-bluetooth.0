Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 9 Jan 2007 09:40:58 -0800
Message-ID: <D8CE9CFA707C894180BAC8CDD154F8460AB04336@msiexch01.marvell.com>
From: "Quinton Yuan" <qyuan@marvell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel]  RE :2 plugz issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Frederic
Thanks for your reply, sounds still not right on headset side, below are .a=
2dprc file, attached is a2dpd log

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

If it doesn't fix the problem, then provide us your .a2dprc and what adapte=
r you are using.

Fr?d?ric



[Shuangqing (Quinton) Yuan] =

[a2dpd]
#
# Rate
# use 32000 if your headset seems to not support 44100 (HP works well at 44=
100, Sonorix at 32000)
# However, 44100 is mandatory
#
rate=3D44100
sbcbitpool=3D32
#rate=3D32000

#
# plugin-rate default is the rate used between the plugin and the daemon
# if this value is 0 then =

# if this value is not 0 then alsa will convert all stream to the specified=
 rate and then send it to the daemon
# if this value is 0, then alsa will do no conversion at all, the daemon wi=
ll do it's own resampling.
# This "features" is disabled because of the crappy quality of the daemon r=
esampler
# To test a2dpd resampling from 32000 to 44100 use plugin-rate=3D32000 and =
rate=3D44100
#plugin-rate=3D32000
plugin-rate=3D0

# Recommended
enablereversestereo=3D1

#
# AVRCP Commands to run
# If these entries are emptied, then some keyboard entry will be sent to /d=
ev/uinput
#
cmdplay=3Dxmms --play
cmdpause=3Dxmms --pause
cmdprev=3Dxmms --rew
cmdnext=3Dxmms --fwd
cmdnew=3Dxmms --play
# Put to 0 to ignore AVRCP (if your computer freezes when commands are rece=
ived)
enableavrcp=3D1

#
# Audio routing
#
# If set to 1 (at a2dp startup only) a2dp will reread configuration file
#=C2=A0for audio routing changes each second
enablerereadconfig=3D1

# 0 =3D> Bluetooth A2DP Sink
# 1 =3D> Alsa
enableredirectalsa=3D0

# Your bluetooth headset address
#Belkin TuneStage
#address=3D00:08:1b:8a:40:95 =

#motorola S805
address=3D00:0C:55:D1:D0:D6
#BlueJay with A2DP demo program
#address=3D00:50:43:20:6c:62
# Address of your alsa output (default : plughw:0,0) you have to know what =
to do
alsaoutput=3D

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
