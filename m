Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Justin Karneges <justin-qt-dated-1058334576.aa81a3@affinix.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200307011438.34033.justin-qt@affinix.com>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<200306301314.25320.justin-qt@affinix.com>
	<1057064408.15797.20.camel@pegasus>
	<200307011438.34033.justin-qt@affinix.com>
Message-Id: <1057105614.8261.67.camel@pegasus>
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
Date: 02 Jul 2003 02:26:48 +0200
Content-Type: text/plain

Hi Justin,

> > the two big parts with BlueZ are the kernel modules and the userspace
> > stuff. The kernel stuff is the essential and the most problematic part.
> > And I think that we should have a package which only contains the BlueZ
> > kernel modules. Maybe we need different builds from the same source for
> > Sharp Kernel 2.4.6, 2.4.18 and OpenZaurus Kernel 2.4.18, 2.4.19.
> 
> This would be nice, if indeed we can support this on 2.4.6.  Although, I 
> believe the earlier Sharp ROM has similar suspending issues related to 
> cardmgr (this is what Max told me in January).  For bluetooth to work 
> reliably here, we may need to offer a cardmgr upgrade.

let us first get a BlueZ kernel package, before we talk about updating
or replacing other daemons or tools.

> > I don't have a Zaurus, so I can't help here. Who wants to volunteer for
> > the Zaurus kernel package maintainer?
> 
> I would like to volunteer for this, when I get a build setup working (I will 
> try Stephen's soon).

Ok.

> > The BlueZ CVS module "kernel" contains a build system for building the
> > BlueZ kernel modules outside a kernel source tree. I am willing to
> > extend this as needed.
> 
> What extensions do you suppose are needed?

I hope that you don't need any extensions. Have you tried it?

> > > Also, I think I found a bug in dtl1_cs and/or bluez itself:  the card
> > > cannot survive a suspend.  Turning off / on the Zaurus, or simply running
> > > "cardctl suspend ; cardctl resume" will leave the driver in an unusable
> > > state. Running "cardctl eject ; cardctl insert" fixes the problem.  I'm
> > > willing to hack on the driver and remedy this, if I could just figure out
> > > how to cross-compile the modules...
> >
> > This is a known problem, but I don't have a Zaurus and so I can't test
> > it. On my development machine is this working without any problems.
> 
> Do you have any hint about where it may be?  Maybe the Zaurus does not send 
> appropriate signals to the driver that it is shutting down?  I'd like to look 
> into this, but I need some direction first.  For instance, if it affects all 
> drivers, not just dtl1_cs, then either all drivers have the same "bug", or 
> the bug is in the bluez core, right?
> 
> What is significant about cardctl suspend?  This will break the driver also, 
> and perhaps it easier to look into this than the full pda suspend.

As I know, that happen to all cards with a special driver (dtl1_cs and
bluecard_cs) and I don't know why.

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
