Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: "Xavier Garreau" <x.garreau@prim-time.fr>, "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
Cc: "Stephen Crane" <steve.crane@rococosoft.com>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<200306282117.57840.justin-qt@affinix.com>
	<007101c33f05$99e146d0$0181a8c0@zaz1>
In-Reply-To: <007101c33f05$99e146d0$0181a8c0@zaz1>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200306301314.25320.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 30 Jun 2003 13:14:25 -0700

> > By the way, you may see my GUI package here:
> >   http://www.affinix.com/~justin/zaurus-bluetooth-0.6.tar.gz
>
> This can be added in the utils package. I think we need a kernel package, a
> libs package and a utils package. But it can be further discussed...

What I'd like is to have an official "zaurus bluetooth" CVS for all of this 
stuff, that can be periodically sync'ed with bluez.  Then we can generate 
packages however we wish.  Personally, I just want one package that has 
everything.  A newbie should be able to install the "Zaurus Bluetooth 
package" and be up and running, without touching the command line.

I'm willing to create builds too, as soon as I can figure out how to actually 
do it.  It seems I'm able to build the libs / utils by hand (running 
arm-linux-gcc on each file and taking what i need.  can't seem to use 
autotools correctly ...), but I've had no luck with building kernel modules 
(they just crash when used).  What is your secret?  Got any URLs?

Also, I think I found a bug in dtl1_cs and/or bluez itself:  the card cannot 
survive a suspend.  Turning off / on the Zaurus, or simply running "cardctl 
suspend ; cardctl resume" will leave the driver in an unusable state.  
Running "cardctl eject ; cardctl insert" fixes the problem.  I'm willing to 
hack on the driver and remedy this, if I could just figure out how to 
cross-compile the modules...

-Justin


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
