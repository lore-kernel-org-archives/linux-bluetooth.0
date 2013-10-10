Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 16:27:01 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 08/15] android: Add adapter and device struct for BlueZ
 daemon
Message-ID: <20131010132659.GQ23879@aemeltch-MOBL1>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABD6X-+RLquYcRhyMiO9N4j+HsmfvQrDN+CwKEaRri2qzqAaFA@mail.gmail.com>
 <20131010123020.GK23879@aemeltch-MOBL1>
 <CABD6X-LdPThJwG+G8LiUpNqO_hFT3bXdoVPiN_hcziCv0KqBdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABD6X-LdPThJwG+G8LiUpNqO_hFT3bXdoVPiN_hcziCv0KqBdw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Oct 10, 2013 at 03:18:14PM +0200, Marcin Kraglak wrote:
> Hi Andrei,
> 
> On 10 October 2013 14:30, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > Hi Marcin,
> >
> > On Thu, Oct 10, 2013 at 11:07:00AM +0200, Marcin Kraglak wrote:
> >> Hi Andrei,
> >>
> >> On 8 October 2013 16:51, Andrei Emeltchenko
> >> <Andrei.Emeltchenko.news@gmail.com> wrote:
> >> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >> >
> >> > Adapter structure in BlueZ daemon keeps track of default adapter
> >> > and device structure keeps track about found devices.
> >> > ---
> >> >  android/bt_adapter.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++
> >> >  android/bt_adapter.h |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >> >  2 files changed, 116 insertions(+)
> >> >  create mode 100644 android/bt_adapter.c
> >> >  create mode 100644 android/bt_adapter.h
> >> >
> >> > diff --git a/android/bt_adapter.c b/android/bt_adapter.c
> >> > new file mode 100644
> >> > index 0000000..e21d50c
> >> > --- /dev/null
> >> > +++ b/android/bt_adapter.c
> >> > @@ -0,0 +1,56 @@
> >> > +/*
> >> > + *
> >> > + *  BlueZ - Bluetooth protocol stack for Linux
> >> > + *
> >> > + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> >> > + *
> >> > + *
> >> > + *  This program is free software; you can redistribute it and/or modify
> >> > + *  it under the terms of the GNU General Public License as published by
> >> > + *  the Free Software Foundation; either version 2 of the License, or
> >> > + *  (at your option) any later version.
> >> > + *
> >> > + *  This program is distributed in the hope that it will be useful,
> >> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> > + *  GNU General Public License for more details.
> >> > + *
> >> > + *  You should have received a copy of the GNU General Public License
> >> > + *  along with this program; if not, write to the Free Software
> >> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >> > + *
> >> > + */
> >> > +
> >> > +#include "bt_adapter.h"
> >> > +#include "log.h"
> >> > +#include "src/shared/mgmt.h"
> >> > +
> >> > +struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
> >> > +{
> >> > +       struct bt_adapter *adapter;
> >> > +
> >> > +       adapter = g_try_new0(struct bt_adapter, 1);
> >> > +       if (!adapter)
> >> > +               return NULL;
> >> > +
> >> > +       adapter->dev_id = index;
> >> > +       adapter->mgmt = mgmt_ref(mgmt_if);
> >> > +
> >> > +       return adapter;
> >> > +}
> >> > +
> >> > +void adapter_start(struct bt_adapter *adapter)
> >> > +{
> >> > +       DBG("enabled %u", adapter->dev_id);
> >> > +
> >> > +       /* TODO: CB: report scan mode */
> >> > +
> >> > +       /* TODO: SDP start here */
> >> > +
> >> > +       /* TODO: CB: report state on */
> >> > +}
> >> > +
> >> > +void adapter_stop(struct bt_adapter *adapter)
> >> > +{
> >> > +       DBG("disabled %u", adapter->dev_id);
> >> > +}
> >> > diff --git a/android/bt_adapter.h b/android/bt_adapter.h
> >> > new file mode 100644
> >> > index 0000000..6877cc7
> >> > --- /dev/null
> >> > +++ b/android/bt_adapter.h
> >> > @@ -0,0 +1,60 @@
> >> > +/*
> >> > + *
> >> > + *  BlueZ - Bluetooth protocol stack for Linux
> >> > + *
> >> > + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> >> > + *
> >> > + *
> >> > + *  This program is free software; you can redistribute it and/or modify
> >> > + *  it under the terms of the GNU General Public License as published by
> >> > + *  the Free Software Foundation; either version 2 of the License, or
> >> > + *  (at your option) any later version.
> >> > + *
> >> > + *  This program is distributed in the hope that it will be useful,
> >> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> > + *  GNU General Public License for more details.
> >> > + *
> >> > + *  You should have received a copy of the GNU General Public License
> >> > + *  along with this program; if not, write to the Free Software
> >> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >> > + *
> >> > + */
> >> > +
> >> > +#include <stdio.h>
> >> > +#include <stdlib.h>
> >> > +#include <unistd.h>
> >> > +#include <glib.h>
> >> > +
> >> > +#include "lib/bluetooth.h"
> >> > +
> >> > +struct bt_device {
> >> > +       int refcnt;
> >> > +
> >> > +       bdaddr_t bdaddr;
> >> > +       uint8_t bdaddr_type;
> >> > +       uint32_t cod;
> >> > +       char *name;
> >> > +};
> >>
> >> I'm not sure if we need struct bt_device. Shouldn't we just use bdaddr_t?
> >> All data from this struct will be cached in upper layers, so we don't need to
> >> store it in daemon.
> >
> > which upper layer?
> >
> > Best regards
> > Andrei Emeltchenko
> >
> 
> I mean java layer in android framework.

I am not sure that we do not need these parameters. Let's try to have
this as minimal as possible.

Best regards 
Andrei Emeltchenko 
