Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D37064.9070206@palmsource.com>
Date: Fri, 04 Aug 2006 18:05:56 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>	<44D0350A.8090904@xmission.com>	<3837d8b10608020729i5bab5ea6vbc18b0ad502b11de@mail.gmail.com>	<44D17895.6050001@xmission.com>	<3837d8b10608030747v551aa4a7t719aa57aa5ffc986@mail.gmail.com>	<44D24BD3.4010404@xmission.com>	<44D30F07.4050509@palmsource.com>
	<44D35F70.7070101@xmission.com>
In-Reply-To: <44D35F70.7070101@xmission.com>
Subject: Re: [Bluez-devel] Bluetooth Headset Error
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

Hi Brad,

>then you have the perfect job... embedded linux
>hacking without management telling you to optimize, optimize :)
>  =

>
Don't hesitate to optimize a2dpd :D
What are your harware requirements?

>In any case, I thought ALP was already going to use gstreamer, so the
>difference is in effect just the size/overhead of alsa?
>  =

>
Yes, but without alsa, who will write to the device ? And really, is it =

not possible to strip code out of alsa ?

>choosing the headset should also be easy and not require typing in an
>address (and usually not a pin! they're all 0000 or 8888)
>  =

>
Are there not some already sort of graphical discovery available? The =

gnome bluetooth does this, doesn't it?
A tool that does a discovery pairing and write address to stdout would =

be nice. Easy to use in a wide variety of projects.

>There are distro people and others using the older code in btsco. I want
>to have a new project that does not have to include and build btsco. It
>should be maintained independently. I could just do a different cvs
>project within bluetooth-alsa maybe.
>  =

>
The same project, but you could reorganize folders :
- alsa-plugins
- gstreamer-stuff
- playground
- sbc
    -fixed
    -floating
-...

add configure script options to enable/disable by folder what is needed.

>btw, are you basing on avsnd or avrecv? (ie are you listening for
>connections or making them or both)
>  =

>
avrecv.c, I just looked at avsnd it seems to sends volume control =

messages? Can you set arbitrary values? This would be useful to the =

plugin! However, I do not receive volume changes from the headset, any =

ideas?

>The hybrid is
>what's in btsco/sbc and the fixed-only is in the separate sbc project.
>messy.
>  =

>
Ok, that's why it worked nicely on arm : it already used fixed version. =

It may explain my other problems with different bitpool values.
At least, try to provide a link to libsbc. So that it can be easily =

found and downloaded.
As always, the best being configure --enable-fixed or --enable-floating

I'm on week end see u on monday!

Fr=E9d=E9ric



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
