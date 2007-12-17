Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0712162252v4cabae88md549ef651cbef5ad@mail.gmail.com>
Date: Mon, 17 Dec 2007 07:52:23 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
Sender: jaap.haitsma@gmail.com
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] Bluez build system
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1197853211.8050.55.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8a8adccc0709020615m38389d6axe49041f8fbe18c4b@mail.gmail.com>
	 <1188768824.24968.9.camel@violet>
	 <8a8adccc0712161246y3f435aefwdb6c92c464d19f96@mail.gmail.com>
	 <1197841752.8050.42.camel@aeonflux>
	 <8a8adccc0712161449r135b552ct39f2cb9bcdeb543d@mail.gmail.com>
	 <1197853211.8050.55.camel@aeonflux>
List-ID: <bluez-devel.lists.sourceforge.net>

On Dec 17, 2007 2:00 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaap,
>
> > > > With a couple of months delay but here it is.
> > > >
> > > > Attached you find autogen.sh. Just put this file in the gnome
> > > > directory of bluez and gnome-bluetooth can be build with jhbuild. NOTE
> > > > you need to have the package gnome-common installed. gnome-common
> > > > contains common scripts and macros to make developing GNOME apps
> > > > easier
> > >
> > > that is not gonna happen since even if it is called bluez-gnome, it can
> > > be build and used without GNOME. Its only dependency is GTK+. So
> > > depending on gnome-common is not an option.
> >
> > It's a build time dependency only. There is no run time dependency.
>
> I am making no difference in build or runtime dependency here. Every
> extra dependency is bad. Especially if they are useless.
>
> > > > The files bootstrap and bootstrap-configure can be removed because
> > > > autogen.sh is now doing that job.
> > >
> > > I actually like bootstrap and bootstrap-configure, because they do
> > > exactly the right job for the developers.
> > >
> > I'd like to have autogen.sh because then bluez gnome can get build with jhbuild
> > I then see two options
> > 1) Add autogen.sh as is and also leave the bootstrap files in CVS
> > 2) I'll need to hack up an autogen.sh which doesn't need gnome-common.
> > I'm not an autofoo expert but I guess that can be done
>
> Is it a modified autogen.sh or a standard one? Do it have to be inside
> the tarball or is CVS enough?
>
Just needs to be in CVS. It won't be part of the tarball. I guess it's
just a standard one, but as I said I'm not an expert at it. I'll look
into other projects which use autogen.sh but don't use gnome-common

Jaap
