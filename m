Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0801161329i7e1aec72waab8d732e49041e7@mail.gmail.com>
Date: Wed, 16 Jan 2008 22:29:47 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1200512872.7978.87.camel@aeonflux>
MIME-Version: 1.0
References: <1200489349.26259.29.camel@cookie.hadess.net>
	<1200497567.7978.51.camel@aeonflux>
	<1200497718.26259.38.camel@cookie.hadess.net>
	<1200498238.7978.59.camel@aeonflux>
	<1200498782.26259.41.camel@cookie.hadess.net>
	<1200511043.7978.65.camel@aeonflux>
	<1200511695.26259.56.camel@cookie.hadess.net>
	<1200512872.7978.87.camel@aeonflux>
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

On Jan 16, 2008 8:47 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Bastien,
>
> > > > > I don't see the need and especially since the long-term goal is to move
> > > > > to git, it will become useless.
> > > >
> > > > I thought we wanted to move bluez-gnome to GNOME's SVN...
> > >
> > > personally I think that Subversion is as worse as CVS and I don't see
> > > any advantage for a switch to that. Convincing me that GNOME's
> > > infrastructure makes sense is different, but from a pure technical
> > > standpoint of the SCM, Subversion is not an argument I am gonna buy
> > > into.
> >
> > I'm not getting into SCM discussions, if GNOME was still using CVS, I'd
> > still be using CVS (and so forth). What I meant was using the GNOME
> > infrastructure to get translators, documentation writers, and plenty of
> > pairs of eyeballs for the code.
>
> for me it really boils down to the SCM in the end. I am not a big fan of
> CVS, but switching to SVN is not an option. Best would be if GNOME would
> support GIT, because then we can switch right now.
>
Marcel,

You can use git-svn on SVN repositories to get almost full git
functionality [1]. Quite some GNOME developers already use that for
modules in GNOME SVN.

Jaap

[1] http://live.gnome.org/GitForGnomeDevelopers

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
