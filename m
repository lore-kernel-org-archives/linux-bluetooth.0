Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] Add Battery Service GATT Client
Date: Wed, 14 Mar 2012 12:06:06 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B44EC4E@DNCE02.ent.ti.com>
References: <1331725078-27485-1-git-send-email-chen.ganir@ti.com>
	<1331725078-27485-3-git-send-email-chen.ganir@ti.com>
 <CAJdJm_Nye9fDtz1QMjg+mzGYqoqKQ=ZJADgDCVEyBAf7g43yuA@mail.gmail.com>
In-Reply-To: <CAJdJm_Nye9fDtz1QMjg+mzGYqoqKQ=ZJADgDCVEyBAf7g43yuA@mail.gmail.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo,

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Wednesday, March 14, 2012 1:55 PM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v6 2/2] Add Battery Service GATT Client
> 
> Hi Chen,
> 
> On Wed, Mar 14, 2012 at 7:37 AM,  <chen.ganir@ti.com> wrote:
> > diff --git a/batterystate/batterystate.c
> b/batterystate/batterystate.c
> > new file mode 100644
> > index 0000000..3f79978
> > --- /dev/null
> > +++ b/batterystate/batterystate.c
> > @@ -0,0 +1,90 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2012 Texas Instruments, Inc.
> > + *
> > + *  This program is free software; you can redistribute it and/or
> modify
> > + *  it under the terms of the GNU General Public License as
> published by
> > + *  the Free Software Foundation; either version 2 of the License,
> or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public
> License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>  02110-1301  USA
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <glib.h>
> > +#include <errno.h>
> > +#include <bluetooth/uuid.h>
> > +
> > +#include "adapter.h"
> > +#include "device.h"
> > +#include "gattrib.h"
> > +#include "attio.h"
> > +#include "att.h"
> > +#include "gatt.h"
> > +#include "batterystate.h"
> 
> Please add only the headers you currently need for building the
> current code. Then include other headers as necessary on future
> patches (unless they are dependencies for other necessary headers).
> 
> E.g. I don't think attio.h. gatt.h and gattrib.h are needed here (but
> check that compilation is ok).
> 
I will check that again, I might have missed that.


> > diff --git a/batterystate/main.c b/batterystate/main.c
> > new file mode 100644
> > index 0000000..5dc5d18
> > --- /dev/null
> > +++ b/batterystate/main.c
> > @@ -0,0 +1,56 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2012 Texas Instruments, Inc.
> > + *
> > + *  This program is free software; you can redistribute it and/or
> modify
> > + *  it under the terms of the GNU General Public License as
> published by
> > + *  the Free Software Foundation; either version 2 of the License,
> or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public
> License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>  02110-1301  USA
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <stdint.h>
> > +#include <glib.h>
> > +#include <errno.h>
> > +#include <gdbus.h>
> 
> Is gdbus.h needed here?
> 
No, it will be removed. 

> > +
> > +#include "hcid.h"
> > +#include "plugin.h"
> > +#include "manager.h"
> > +#include "log.h"
> > +
> > +static int batterystate_init(void)
> > +{
> > +       if (!main_opts.gatt_enabled) {
> > +               DBG("GATT is disabled");
> > +               return -ENOTSUP;
> > +       }
> > +
> > +       return batterystate_manager_init();
> > +}
> > +
> > +static void batterystate_exit(void)
> > +{
> > +       if (!main_opts.gatt_enabled)
> > +               return;
> > +
> > +       batterystate_manager_exit();
> > +}
> > +
> > +BLUETOOTH_PLUGIN_DEFINE(batterystate, VERSION,
> BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
> > +                                       batterystate_init,
> batterystate_exit)
> 
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
