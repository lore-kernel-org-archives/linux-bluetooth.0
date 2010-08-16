Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Aug 2010 19:22:38 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] IrMC sync server support
Message-ID: <20100816172238.GA27814@joshua.mesa.nl>
References: <201008121013.o7CADR8r004125@joshua.mesa.nl> <1281613299.12579.266.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset*=utf-8''%E2%80%9Cus-ascii
In-Reply-To: <1281613299.12579.266.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 12, 2010 at 07:41:39AM -0400, Marcel Holtmann wrote:
> Hi Marcel,
> 
> > A reasonable working IrMC SYNC server (only full phonebook sync support)
> > Support for cal and note by just returning nothing.
> > ---
> >  Makefile.am    |    3 +
> >  plugins/irmc.c |  488 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/main.c     |   12 ++-
> >  src/obex.h     |    1 +
> >  4 files changed, 502 insertions(+), 2 deletions(-)
> >  create mode 100644 plugins/irmc.c
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index 73e2f28..ce8c675 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -58,6 +58,9 @@ builtin_sources += plugins/pbap.c plugins/phonebook.h \
> >  builtin_modules += syncevolution
> >  builtin_sources += plugins/syncevolution.c
> >  
> > +builtin_modules += irmc
> > +builtin_sources += plugins/irmc.c plugins/phonebook.h
> > +
> >  builtin_nodist += plugins/phonebook.c
> >  
> >  libexec_PROGRAMS += src/obexd
> > diff --git a/plugins/irmc.c b/plugins/irmc.c
> > new file mode 100644
> > index 0000000..96fd807
> > --- /dev/null
> > +++ b/plugins/irmc.c
> > @@ -0,0 +1,488 @@
> > +/*
> > + *
> > + *  OBEX IrMC Sync Server
> > ...
> > +#include "dbus.h"
> > +
> > +#define IRMC_CHANNEL	17
> 
> we did have a list of defined RFCOMM channels for various protocols, but
> just don't remember where it is.
> 
> Johan, we should put that into the doc/ directory actually. Can you dig
> up that list and commit it as text file.
> 

Any news on this one? Is 17 the correct channel for IrMC?

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
