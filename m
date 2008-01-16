Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1200497567.7978.51.camel@aeonflux>
References: <1200489349.26259.29.camel@cookie.hadess.net>
	<1200497567.7978.51.camel@aeonflux>
Date: Wed, 16 Jan 2008 15:35:18 +0000
Message-Id: <1200497718.26259.38.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Ignore built files
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


On Wed, 2008-01-16 at 16:32 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > First "patch" is to add some cvsignore files, cleaning up patches:
> > http://bugzilla.gnome.org/attachment.cgi?id=101355&action=view
> > 
> > Just untar in the root directory of the checkout. BZ:
> > http://bugzilla.gnome.org/show_bug.cgi?id=504745
> 
> I never bothered with the .cvsignore stuff, because the way CVS uses it
> is totally stupid and calling "make maintainer-clean" will give you a
> complete clean repository.

So not going to apply that patch/tarball?

> > I'd need an opinion on another bug:
> > http://bugzilla.gnome.org/show_bug.cgi?id=505605
> > 
> > I think that it would be a good idea to move the adapter name to the top
> > of the dialogue, as it is rather more important than the mode of
> > operation.
> 
> Actually I think the mode is more important. You might change your name
> once, but the mode change (especially with the visible timeout) is the
> one that you use more often.

OK, fair enough.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
