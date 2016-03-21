Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAASrBQkO4oNjR9j+Yz6CcmjhDChkABwKHR_-hgZoQCcTPnaWPA@mail.gmail.com>
References: <CAASrBQkO4oNjR9j+Yz6CcmjhDChkABwKHR_-hgZoQCcTPnaWPA@mail.gmail.com>
Date: Mon, 21 Mar 2016 16:42:14 +0200
Message-ID: <CABBYNZJJZG7guG9h8Gvp75ONbO1WO=6EKpc7E1cfG-y-CgA0FA@mail.gmail.com>
Subject: Re: Crash in src/gatt-client.c (was Re: setting indication on
 GattCharacteristic1 interface)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Rages <markrages@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Sun, Mar 20, 2016 at 4:34 AM, Mark Rages <markrages@gmail.com> wrote:
> bluetoothd crashes when I attempt to close the connection and
> reconnect through d-bus interface.
>
> bluez @ 4d7b1d2b347423a7a79647e51b31744f3e044612
>
> I've put the trace and btmon log here:
>
> https://www.dropbox.com/sh/ddo9kuux9lixj4l/AAB-dWv3aZhfi27KXMMBkoHxa?dl=0

The crash should now be fixed upstream, thanks for the logs.

>
> And here is the script that reliably triggers it.  It is an
> implementation of the Nordic Semiconductor nRF51 DFU bootloader.
> Unfortunately you need appropriate nRF51 hardware to duplicate this.
>
> https://github.com/markrages/ble/blob/master/example_dfu.py
>
> If there's any more information that would be useful, please let me
> know, preferably with the exact command-line to gather the
> information.
>
> Regards,
> Mark
> markrages@gmail



-- 
Luiz Augusto von Dentz
