Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAvkfd_baAUHfnO9JX3h2rc4BYQBzjBeWqf2tiGBMJQMG2yseA@mail.gmail.com>
References: <CAAvkfd_baAUHfnO9JX3h2rc4BYQBzjBeWqf2tiGBMJQMG2yseA@mail.gmail.com>
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Thu, 29 Mar 2018 10:10:55 +0200
Message-ID: <CAOT_U5bOS63BbqoyLPhTQ_z4ve0u+obLFg8HENyMYxik00+oWA@mail.gmail.com>
Subject: Re: Support adapter without HCI
To: David Frey <dpfrey@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I didn't get through you question what are the actual commands
that are being passed via SPI to the controller once HCI has been removed?

You want to use the API provided by the library on the controller and invoke it
directly from the host via SPI?

I saw something kind of similar from Nordic:
    https://github.com/NordicSemiconductor/pc-ble-driver

Would be willing to bet that they just invented something
that replaces HCI, but it's still a intermediate protocol that glues
together the host and controller, can't see how that can be avoided.

Be Well,
Alan





On Wed, Mar 28, 2018 at 8:02 PM, David Frey <dpfrey@gmail.com> wrote:
> Is it possible to support a bluetooth adapter in the Linux kernel in
> the case where the adapter doesn't present a HCI interface?  The
> adapter in question was originally envisioned as a standalone host,
> but I am interested in using it as an adapter (over SPI) controlled by
> another CPU running Linux.  The BLE implementation on the target is a
> closed source binary that provides GAP and GATT APIs.  Details of the
> APIs are here: http://labs.mediatek.com/api/mt7697/group___bluetooth.html
>
> If it *is* possible to support adapters which don't offer an HCI
> interface, then I'm hoping that someone can point me at an example or
> an interface definition so I can get an idea of what is required.
>
> Thanks,
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
