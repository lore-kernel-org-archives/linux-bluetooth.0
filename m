Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAASrBQ=XtvLXLp7xJuUN7pfN6ZN3sEZGU-6LtBhz-isdmpujxQ@mail.gmail.com>
References: <CAASrBQ=XtvLXLp7xJuUN7pfN6ZN3sEZGU-6LtBhz-isdmpujxQ@mail.gmail.com>
Date: Wed, 6 Jan 2016 11:37:10 -0300
Message-ID: <CABBYNZJP3n8w9e2xzuA_cLYdk-9nPXTFMkxrZcpdhQaP=B5JbQ@mail.gmail.com>
Subject: Re: Failed to obtain handles for "Service Changed" characteristic, etc.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Rages <markrages@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Mon, Jan 4, 2016 at 3:16 PM, Mark Rages <markrages@gmail.com> wrote:
> Hi,
>
> I'm trying to use git bluetoothd in Ubuntu.  When I start it I get the
> following errors:
>
> root@qountdown:~/src/bluez/src# ./bluetoothd -En
> bluetoothd[23921]: Bluetooth daemon 5.37
> bluetoothd[23921]: Starting SDP server
> bluetoothd[23921]: Bluetooth management interface 1.6 initialized
> bluetoothd[23921]: Failed to obtain handles for "Service Changed" characteristic
> bluetoothd[23921]: Not enough free handles to register service
> bluetoothd[23921]: Error adding Link Loss service
> bluetoothd[23921]: Not enough free handles to register service
> bluetoothd[23921]: Not enough free handles to register service
> bluetoothd[23921]: Not enough free handles to register service
> bluetoothd[23921]: Current Time Service could not be registered
> bluetoothd[23921]: gatt-time-server: Input/output error (5)
> bluetoothd[23921]: Not enough free handles to register service
> bluetoothd[23921]: Not enough free handles to register service

These are plugins using deprecated API, we should be disable/removing
them in favor or external support via GATT D-Bus APIs.

> bluetoothd[23921]: Failed to read advertising features: Unknown Command (0x01)
> bluetoothd[23921]: hci0 Load Connection Parameters failed: Unknown
> Command (0x01)

These are more serious, it seems your kernel is too old and does not
support the command above which are quite important if you plan to
support peripheral role.

>
> Where should I look to diagnose these?
> --
> Regards,
> Mark
> markrages@gmail
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
