Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 10 Nov 2006 14:50:38 +0100
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061110135038.GA25972@physik.fu-berlin.de>
References: <200611091102.54282.marcel@hilzinger.hu>
	<20061109104245.GB7085@physik.fu-berlin.de>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA2@eumonex01.palmsource.com>
Mime-Version: 1.0
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA2@eumonex01.palmsource.com>
From: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [Bluez-devel] RE :  Quality of a2dp sound
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello Frederic,

> I've been using a2dpd for days with xmms.
> I've pretty good quality and the latest patch make it possible to select encoding parameter so sound is better.
> There is still some gain loss but it is enough to make you deaf.

Maybe I should go for the latest patches then, too. Though I think my
version (30 Oct) is quite recent.

> 
> > the quality is set to telephone quality only (8kHz, Mono) though my headset can do up to
> > 44,1kHz Stereo (SONY VGP-BRM1D) and a2dpd even displays 44,1kHz. 
> 8khz is when you use heasetd and sco, isn't it?
> a2dpd will be 44,1 khz but you may have choppy sound.

I have 8kHz and choppy sound :(. But as I said before, sound is almost
perfect with "a2play" except for some noise and the speed-problems.

> 
> > Also the sound is chopped very often with a2dpd, so this is no use for me
> at the moment :(.
> Which player are you using? I have to agree that some player are giving us trouble, but I had success with xmms,vlc and mpg321.

I tried "xmms" (latest Debian ETCH) for a2dpd and mpg123 for a2play.

Greetings,

Adrian

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
