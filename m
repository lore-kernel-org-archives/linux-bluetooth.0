Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
From: Stephen Crane <steve.crane@rococosoft.com>
To: Justin Karneges <justin-qt@affinix.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>, marcel@rvs.uni-bielefeld.de
In-Reply-To: <200307010227.38094.justin-qt@affinix.com>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<200306301314.25320.justin-qt@affinix.com>
	<1057050737.523.26.camel@baroque.rococosoft.com>
	<200307010227.38094.justin-qt@affinix.com>
Content-Type: text/plain
Message-Id: <1057059939.523.34.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 01 Jul 2003 12:45:39 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

See http://www.holtmann.org/linux/bluetooth/dtl1.html

It was only merged in 2.4.20 and 2.5.30. Perhaps Marcel needs to provide
it in his BlueZ patch for 2.4.18 and 2.4.19?

On Tue, 2003-07-01 at 10:27, Justin Karneges wrote:
> Excellent, Stephen. :)
> 
> What about the kernel modules?  By the way, is dtl1_cs meant to be separated 
> from the kernel?  I didn't see it in 2.4.18 even after applying 
> patch-2.4.18-mh7.
> 
> -Justin
> 
> On Tuesday 01 July 2003 02:12 am, Stephen Crane wrote:
> > Justin,
> > You can cross-compile the user-space parts of BlueZ as follows:
> >
> > export CC=arm-linux-gcc
> > export LD=arm-linux-ld
> > export NM=arm-linux-nm
> > export RANLIB=arm-linux-ranlib
> > export PATH=/opt/Embedix/tools/bin:$PATH
> > ./configure --prefix=/opt/Embedix/tools/arm-linux --host=arm-linux
> > make
> >
> > (This is how I do it anyway.)
> >
> > On Mon, 2003-06-30 at 21:14, Justin Karneges wrote:
> > > > > By the way, you may see my GUI package here:
> > > > >   http://www.affinix.com/~justin/zaurus-bluetooth-0.6.tar.gz
> > > >
> > > > This can be added in the utils package. I think we need a kernel
> > > > package, a libs package and a utils package. But it can be further
> > > > discussed...
> > >
> > > What I'd like is to have an official "zaurus bluetooth" CVS for all of
> > > this stuff, that can be periodically sync'ed with bluez.  Then we can
> > > generate packages however we wish.  Personally, I just want one package
> > > that has everything.  A newbie should be able to install the "Zaurus
> > > Bluetooth package" and be up and running, without touching the command
> > > line.
> >
> > I disagree about the need for an official Zaurus CVS. We can put the
> > scripts to build the Zaurus packages in the normal place (as is done for
> > the rpm spec files).
> >
> > > I'm willing to create builds too, as soon as I can figure out how to
> > > actually do it.  It seems I'm able to build the libs / utils by hand
> > > (running arm-linux-gcc on each file and taking what i need.  can't seem
> > > to use autotools correctly ...), but I've had no luck with building
> > > kernel modules (they just crash when used).  What is your secret?  Got
> > > any URLs?
> > >
> > > Also, I think I found a bug in dtl1_cs and/or bluez itself:  the card
> > > cannot survive a suspend.  Turning off / on the Zaurus, or simply running
> > > "cardctl suspend ; cardctl resume" will leave the driver in an unusable
> > > state. Running "cardctl eject ; cardctl insert" fixes the problem.  I'm
> > > willing to hack on the driver and remedy this, if I could just figure out
> > > how to cross-compile the modules...
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
