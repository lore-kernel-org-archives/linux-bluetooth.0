Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45C36CE5.90205@access-company.com>
Date: Fri, 02 Feb 2007 17:55:01 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150326.46855.bluez-devel@huitl.de>	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>	<200701282030.14289.bluez-devel@huitl.de>
	<45BD6370.4050005@xmission.com>
In-Reply-To: <45BD6370.4050005@xmission.com>
Subject: Re: [Bluez-devel] a2dpd and mplayer - any chance to get it working?
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

Hi,

I've been trying some things and just uploaded an *a2dpd2* plugin.
Tested the plugin with =

aplay,xmms,amarok,vlc,mocp,kaffeine,mplayer,beep-media-player.
This gave good sound on all except mplayer :( but at least the movie =

speed is now correct. This may be worth a try on another computer.
Not had time to try any gst based player.

reports appreciated.

Fr=E9d=E9ric
PS: Note the type plug/slave.pcm trick is not well supported by =

vlc,mocp,bmp. I used alsa-libs 1.0.13 but this should not be required.

> Frederic is the one who is writing this. He has had some trouble getting
> xmms to play without the sleep() call and it may be related to the pcm
> status.
>   =

>>>  I was wondering about alsa plugins :
>>> xmms relies on alsa timing to play, so in the plugin, there is a sleep()
>>> call, this will wait a little bit until it is time to retievre new data.
>>> But it seems some players (like mplayer) wants to do their own timing o=
r at
>>> least don't want to sleep. They need to use that time to do some decodi=
ng
>>> instead. If you sleep too long, the decoding will be defered and the so=
und
>>> or movie will be broken.
>>>
>>> Is there a rule to distinguish? Or some magic value to sleep?
-- =

Frederic

Without the wind, the grass does not move.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
