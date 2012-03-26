Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v4 3/3] GATT: Profile support for EnableGatt
Date: Mon, 26 Mar 2012 09:34:53 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B461138@DNCE02.ent.ti.com>
References: <1332169073-15885-1-git-send-email-chen.ganir@ti.com>
 <1332169073-15885-4-git-send-email-chen.ganir@ti.com>
 <20120326092120.GA322@x220>
In-Reply-To: <20120326092120.GA322@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,

I'll check for a way to cleanly do that, and send patches.

Thanks,
Chen Ganir


> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Monday, March 26, 2012 11:21 AM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v4 3/3] GATT: Profile support for EnableGatt
> 
> Hi Chen,
> 
> On Mon, Mar 19, 2012, chen.ganir@ti.com wrote:
> > --- a/alert/main.c
> > +++ b/alert/main.c
> > @@ -28,6 +28,7 @@
> >
> >  #include <stdint.h>
> >  #include <glib.h>
> > +#include <errno.h>
> >
> >  #include "plugin.h"
> >  #include "hcid.h"
> > @@ -37,8 +38,8 @@
> >  static int alert_init(void)
> >  {
> >  	if (!main_opts.gatt_enabled) {
> > -		DBG("Attribute server is disabled");
> > -		return -1;
> > +		DBG("GATT is disabled");
> > +		return -ENOTSUP;
> >  	}
> 
> I've applied all three patches, but I think it'd be cleaner to have the
> check for main_opts.gatt_enabled in a single central place instead of
> each plugin having to do it by themselves (in general any access to
> main_opts from plugins should imo be avoided).
> 
> The first idea that comes to mind is that gatt_service_add() should be
> the one checking for this conf-option and plugins should check for
> failure of that function.
> 
> Johan
