Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Mar 2014 21:59:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v0] attrib: Remove unneeded sdp.h header include
Message-ID: <20140324195918.GA31654@t440s.P-661HNU-F1>
References: <1395336359-16138-1-git-send-email-claudio.takahasi@openbossa.org>
 <CAKT1EBcB90ZUE4Za3oxf5SCfUiQPr=YbHsTBq295ZNpKhL9GrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKT1EBcB90ZUE4Za3oxf5SCfUiQPr=YbHsTBq295ZNpKhL9GrQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Mar 24, 2014, Claudio Takahasi wrote:
> On Thu, Mar 20, 2014 at 2:25 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
> > ---
> >  attrib/gatt-service.c | 1 -
> >  attrib/utils.c        | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
> > index 227d4d4..d15536c 100644
> > --- a/attrib/gatt-service.c
> > +++ b/attrib/gatt-service.c
> > @@ -27,7 +27,6 @@
> >  #endif
> >
> >  #include <glib.h>
> > -#include <bluetooth/sdp.h>
> >
> >  #include "src/adapter.h"
> >  #include "lib/uuid.h"
> > diff --git a/attrib/utils.c b/attrib/utils.c
> > index 17f02be..8f9a4c07 100644
> > --- a/attrib/utils.c
> > +++ b/attrib/utils.c
> > @@ -31,7 +31,6 @@
> >  #include <bluetooth/bluetooth.h>
> >  #include <bluetooth/hci.h>
> >  #include <bluetooth/hci_lib.h>
> > -#include <bluetooth/sdp.h>
> >
> >  #include "lib/uuid.h"
> >  #include "btio/btio.h"
> > --
> > 1.8.3.1
> >
> 
> 
> ping ...

Sorry, must have missed this one. It's now applied.

Johan
