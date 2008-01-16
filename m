Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1200498238.7978.59.camel@aeonflux>
References: <1200489349.26259.29.camel@cookie.hadess.net>
	<1200497567.7978.51.camel@aeonflux>
	<1200497718.26259.38.camel@cookie.hadess.net>
	<1200498238.7978.59.camel@aeonflux>
Date: Wed, 16 Jan 2008 15:53:02 +0000
Message-Id: <1200498782.26259.41.camel@cookie.hadess.net>
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


On Wed, 2008-01-16 at 16:43 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > First "patch" is to add some cvsignore files, cleaning up patches:
> > > > http://bugzilla.gnome.org/attachment.cgi?id=101355&action=view
> > > > 
> > > > Just untar in the root directory of the checkout. BZ:
> > > > http://bugzilla.gnome.org/show_bug.cgi?id=504745
> > > 
> > > I never bothered with the .cvsignore stuff, because the way CVS uses it
> > > is totally stupid and calling "make maintainer-clean" will give you a
> > > complete clean repository.
> > 
> > So not going to apply that patch/tarball?
> 
> I don't see the need and especially since the long-term goal is to move
> to git, it will become useless.

I thought we wanted to move bluez-gnome to GNOME's SVN...


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
