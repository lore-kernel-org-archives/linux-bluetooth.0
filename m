Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080210214029.GD2605@esaurito.net>
References: <20080210183344.GA2605@esaurito.net>
	<1202669869.7664.102.camel@violet> <20080210195148.GC2605@esaurito.net>
	<1202675082.7664.111.camel@violet> <20080210214029.GD2605@esaurito.net>
Date: Sun, 10 Feb 2008 22:56:22 +0100
Message-Id: <1202680582.7664.121.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] account for	non-existant	update-*-database
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

Hi Filippo,

> > > > > I've noticed a bug in bluez-gnome when update-*-database programs are not
> > > > > present (i.e. $UPDATE_*_DATABASE is "" thus install-data-hook fails), the
> > > > > following patch (or something similar) should work:
> > > > 
> > > > call --disable-*-update should be a good thing for packages. And then
> > > > have some post-install routines. Not doing the update is really a
> > > > problem, because it limits the functionality. So producing an error
> > > > seems fine to me.
> > > 
> > > I agree, note though that in this case the error is "permission denied" since
> > > make will try to execute a directory (e.g. $(DESTDIR)$(datadir)/mime) when
> > > UPDATE_*_DATABASE is "" which is not much straightforward.
> > 
> > I put something in the CVS now that should fix it. Please test it.
> 
> typo:
> 
> AM_CONDITIONAL([MIME_UPDATE], [test -n "$UPDATE_DESKTOP_DATABASE"])

has been fixed now. Thanks.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
