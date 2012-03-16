Return-Path: <cyrus@holtmann.org>
Message-ID: <1331931060.14217.190.camel@aeonflux>
Subject: Re: [RFC 1/1] HID: User-space I/O driver support for HID subsystem
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, jprvita@openbossa.org,
	linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com
Date: Fri, 16 Mar 2012 13:51:00 -0700
In-Reply-To: <CANq1E4ROxW_XfkP8=s9FsHuxXMYGXomqRhsuAc4Ow5uBSAE6Gg@mail.gmail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	 <1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
	 <1331913615.14217.152.camel@aeonflux>
	 <CANq1E4ROxW_XfkP8=s9FsHuxXMYGXomqRhsuAc4Ow5uBSAE6Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> >> new file mode 100644
> >> index 0000000..1a7df0d
> >> --- /dev/null
> >> +++ b/include/linux/uhid.h
> >> @@ -0,0 +1,71 @@
> >> +#ifndef __UHID_H_
> >> +#define __UHID_H_
> >> +
> >> +/*
> >> + * User-space I/O driver support for HID subsystem
> >> + * Copyright (c) 2012 David Herrmann
> >> + */
> >> +
> >> +/*
> >> + * This program is free software; you can redistribute it and/or modify it
> >> + * under the terms of the GNU General Public License as published by the Free
> >> + * Software Foundation; either version 2 of the License, or (at your option)
> >> + * any later version.
> >> + */
> >> +
> >> +#include <linux/input.h>
> >> +#include <linux/types.h>
> >> +
> >> +enum uhid_event_type {
> >> +     UHID_CREATE,
> >> +     UHID_DESTROY,
> >> +     UHID_START,
> >> +     UHID_STOP,
> >> +     UHID_OPEN,
> >> +     UHID_CLOSE,
> >> +     UHID_OUTPUT,
> >> +     UHID_OUTPUT_EV,
> >> +     UHID_INPUT,
> >> +};
> >> +
> >> +struct uhid_create_req {
> >> +     __u8 __user name[128];
> >> +     __u8 __user *rd_data;
> >> +     __u16 rd_size;
> >> +
> >
> > we need the bus here as well. With HIDP it was implicit, but here it is
> > no longer implicit.
> 
> Uh, yeah, I will add that, thanks. I also need to find a proper way to
> get a hid->dev.parent pointer.
> 
> >> +     __u16 vendor;
> >> +     __u16 product;
> >> +     __u16 version;
> >> +     __u8 country;
> >
> > What are we using country for these days?
> 
> I copied it from HIDP. If we don't need this, I can remove it. USBHID
> doesn't use it as far as I can see.

in USB it is the hdesc->bCountryCode. And in Bluetooth BR/EDR it comes
from the SDP record. So it makes sense to keep it.

Regards

Marcel


