Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Feb 2008 22:40:29 +0100
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080210214029.GD2605@esaurito.net>
References: <20080210183344.GA2605@esaurito.net>
	<1202669869.7664.102.camel@violet>
	<20080210195148.GC2605@esaurito.net>
	<1202675082.7664.111.camel@violet>
MIME-Version: 1.0
In-Reply-To: <1202675082.7664.111.camel@violet>
Subject: Re: [Bluez-devel] [PATCH] account for non-existant	update-*-database
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

On Sun, Feb 10, 2008 at 09:24:42PM +0100, Marcel Holtmann wrote:
> Hi Filippo,
> 
> > > > I've noticed a bug in bluez-gnome when update-*-database programs are not
> > > > present (i.e. $UPDATE_*_DATABASE is "" thus install-data-hook fails), the
> > > > following patch (or something similar) should work:
> > > 
> > > call --disable-*-update should be a good thing for packages. And then
> > > have some post-install routines. Not doing the update is really a
> > > problem, because it limits the functionality. So producing an error
> > > seems fine to me.
> > 
> > I agree, note though that in this case the error is "permission denied" since
> > make will try to execute a directory (e.g. $(DESTDIR)$(datadir)/mime) when
> > UPDATE_*_DATABASE is "" which is not much straightforward.
> 
> I put something in the CVS now that should fix it. Please test it.

typo:

AM_CONDITIONAL([MIME_UPDATE], [test -n "$UPDATE_DESKTOP_DATABASE"])
												^^^^^^^

the rest looks good, thanks
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

What a strange illusion it is to suppose that beauty is goodness.
-- Lev Tolstoj

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
