Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Justin Karneges <justin-qt@affinix.com>
Cc: Xavier Garreau <x.garreau@prim-time.fr>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>, Stephen Crane <steve.crane@rococosoft.com>
In-Reply-To: <200306301314.25320.justin-qt@affinix.com>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<200306282117.57840.justin-qt@affinix.com>
	<007101c33f05$99e146d0$0181a8c0@zaz1>
	<200306301314.25320.justin-qt@affinix.com>
Content-Type: text/plain
Message-Id: <1057064408.15797.20.camel@pegasus>
Mime-Version: 1.0
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
Date: 01 Jul 2003 15:00:01 +0200

Hi Justin,

> What I'd like is to have an official "zaurus bluetooth" CVS for all of this 
> stuff, that can be periodically sync'ed with bluez.  Then we can generate 
> packages however we wish.  Personally, I just want one package that has 
> everything.  A newbie should be able to install the "Zaurus Bluetooth 
> package" and be up and running, without touching the command line.

the two big parts with BlueZ are the kernel modules and the userspace
stuff. The kernel stuff is the essential and the most problematic part.
And I think that we should have a package which only contains the BlueZ
kernel modules. Maybe we need different builds from the same source for
Sharp Kernel 2.4.6, 2.4.18 and OpenZaurus Kernel 2.4.18, 2.4.19.

I don't have a Zaurus, so I can't help here. Who wants to volunteer for
the Zaurus kernel package maintainer?

The BlueZ CVS module "kernel" contains a build system for building the
BlueZ kernel modules outside a kernel source tree. I am willing to
extend this as needed.

> Also, I think I found a bug in dtl1_cs and/or bluez itself:  the card cannot 
> survive a suspend.  Turning off / on the Zaurus, or simply running "cardctl 
> suspend ; cardctl resume" will leave the driver in an unusable state.  
> Running "cardctl eject ; cardctl insert" fixes the problem.  I'm willing to 
> hack on the driver and remedy this, if I could just figure out how to 
> cross-compile the modules...

This is a known problem, but I don't have a Zaurus and so I can't test
it. On my development machine is this working without any problems.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
