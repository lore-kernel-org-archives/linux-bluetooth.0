Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFGVEfDdoP17uEBvU3FoYj5FV2cF5ig4nYxgEy_ofV==ihoYWA@mail.gmail.com>
References: <CAFGVEfDdoP17uEBvU3FoYj5FV2cF5ig4nYxgEy_ofV==ihoYWA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Feb 2018 09:59:45 -0200
Message-ID: <CABBYNZKqy=YQghqNa4Wj-55C+1Dx+uPce1ERm-1EFP0z4ri21g@mail.gmail.com>
Subject: Re: Configuring scan behaviour of bluez
To: Matthias Schuh <m.schuh.jr@googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On Thu, Feb 8, 2018 at 11:14 AM, Matthias Schuh
<m.schuh.jr@googlemail.com> wrote:
> Dear bluez-mailingslist,
>
> thanks for taking the time to read this:
>
> Setup:
>
> bluez-5.48, kernel 4.14.16
>
> bluetoothctl and btmgmt to scan, setup and configure bt 4.2 enabled sensor nodes
>
> The requirement is to keep up uninterrupted scanning as long as
> possible, since the sensor nodes dynamically modify their Manufacturer
> Data enhancing it with sensor information.
>
> In general turning on discovery via bluetoothctl  "scan on" delivers:
>
> - Information on devices in the vincinity
> - Updates of devices that changed their manufacturer payload
>
> Monitoring the scan activity via btmgmt delivers the following loop behaviour:
>
> - After issueing "scan on" via bluetoothctl shows:  "hci0 type 7 discovering on"
> - After exactly 10 seconds I get the info: "hci0 type7 discovering off"
> - After exactly 5 seconds I get the info: "hci0 type 7 discovering on"
>
> Analyzing the packages I scan with wireshark I noticed that I'm
> missing out on several broadcast from the sensor nodes. One
> explanation is that discovery seems to be automatically turned off in
> the described interval. This interval is the same on different
> bluetooth hardware so i guess this is somehow defined by bluez.

This is because by default BlueZ employs an interleaved scanning so
both LE and BR/EDR devices can be found if you don't want that you
will need to use discovery filters (bluetoothctl> menu scan).

> In the official documentation I could not find any clue on how to
> influence this behaviour.
> Is there a way to define these  interval parameters?

You can find the documentation here about the discovery filters here:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n48

>
> Thanks ahead and all the best,
>
> Matthias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
