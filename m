Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABuKQihPRJFU9yVKbfSu1qTfVA3cjhabJzs4VTDQ82S-Kqa7Yw@mail.gmail.com>
References: <CABuKQihPRJFU9yVKbfSu1qTfVA3cjhabJzs4VTDQ82S-Kqa7Yw@mail.gmail.com>
Date: Tue, 17 Nov 2015 11:26:01 +0200
Message-ID: <CABBYNZJzocX8rTLSVr2Y6+Hhwj9Jd5r69yBWKCb9QYt0hAEvsg@mail.gmail.com>
Subject: Re: How to access services on my bluetooth device
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: John WW <wrxzzj@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Tue, Nov 17, 2015 at 10:56 AM, John WW <wrxzzj@gmail.com> wrote:
> Hi
>
>     recently, I bought a microsoft bluetooth 4.0 mouse, connect and
> work very well on bluez-5.36.
>
>    I found this device have five profile
>         UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>         UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>         UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
>         UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
>         UUID: Human Interface Device    (00001812-0000-1000-8000-00805f9b34fb)
>
>   How can I access Battery Service, I want to known the battery status.
> Is't possible to get the battery status by bluez utils ?

iirc the plan is to create a battery using upower module, but in the
meantime you can use the D-Bus GATT APIs and write an application to
subscribe to the notifications.


-- 
Luiz Augusto von Dentz
