Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Xavier Garreau <x.garreau@prim-time.fr>
Cc: Justin Karneges <justin-qt-dated-1058334576.aa81a3@affinix.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <005b01c34067$f5469a80$0181a8c0@zaz1>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<200306301314.25320.justin-qt@affinix.com>
	<1057064408.15797.20.camel@pegasus>
	<200307011438.34033.justin-qt@affinix.com>
	<005b01c34067$f5469a80$0181a8c0@zaz1>
Content-Type: text/plain
Message-Id: <1057135055.8782.3.camel@pegasus>
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
Date: 02 Jul 2003 10:37:28 +0200

Hi Xavier,

> > Do you have any hint about where it may be?  Maybe the Zaurus does not
> send
> > appropriate signals to the driver that it is shutting down?  I'd like to
> look
> > into this, but I need some direction first.  For instance, if it affects
> all
> > drivers, not just dtl1_cs, then either all drivers have the same "bug", or
> > the bug is in the bluez core, right?
> 
> Laptops are affected as well, at least those using bc3c_cs...

the bt3c_cs is another story due the needed firmware load :(

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
