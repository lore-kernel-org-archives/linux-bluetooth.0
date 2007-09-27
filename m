Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20070927154804.17487b20@gondolin.boeblingen.de.ibm.com>
References: <46F92586.5070402@idlum.be> <200709271429.09910.rjw@sisk.pl>
	<46FBA4A7.70200@idlum.be>
	<20070927154804.17487b20@gondolin.boeblingen.de.ibm.com>
Date: Fri, 28 Sep 2007 01:04:51 +0200
Message-Id: <1190934291.6484.76.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, BlueZ@sc8-sf-spam2.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] Warnings and Bug on 2.6.23-rc6 closing
	rfcomm	links (device_move() API ?)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Cornelia,

> > >> Yet another report, once again while putting rfcomm system under load. 
> > >> Several USB adapters, several links.
> > > 
> > > Is this a regression or does it happen with 2.6.22 too?
> > 
> > I've not tested with 2.6.22, but have done it a few days ago with 
> > 2.6.21-2-486 (stock debian package), and got the 2 Oops below. Maybe 
> > that's a different problem, or maybe not?
> > 
> > 
> > kobject_add failed for rfcomm1 with -EEXIST, don't try to register 
> > things with the same name in the same directory.
> 
> There's something wrong with rfcomm trying to create objects with
> duplicate names...

that should have been fixed.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
