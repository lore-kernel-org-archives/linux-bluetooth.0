Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jan 2014 10:13:07 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Rename adapter_remove_device to btd_adapter_remove_device
Message-ID: <20140127181307.GB7831@x220.p-661hnu-f1>
References: <20140125005506.7AD85100900@puck.mtv.corp.google.com>
 <20140125221329.GB14531@x220.p-661hnu-f1>
 <CAGXr9JHEe+9gu-giUF=iH4LAv=FAAutYPeFY483DQU2r40wmkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXr9JHEe+9gu-giUF=iH4LAv=FAAutYPeFY483DQU2r40wmkg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Sun, Jan 26, 2014, Petri Gynther wrote:
> I would need this for the IR-assist device discovery plugin that I'm
> writing. Basically, I have a HID remote control which is not
> discoverable (but it is connectable). When this HID remote is in
> unpaired state, it sends its BD address to the host via IR. The plugin
> will get the BD address and do the following:
> 
> device = btd_adapter_find_device(adapter, &device_bdaddr);
> if (device) {
>     /* remove old pairing and device info */
>     btd_device_set_temporary(device, TRUE);
>     btd_adapter_remove_device(adapter, device);
> }

If the device is only discoverable through IR why would there be an
existing device object for it? And if there does exist a device object
doesn't it mean it's already paired and you don't need to repair?

Johan
