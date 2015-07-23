Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAASrBQ=8icxs8ZyW56CXObZH7DFuPf0XDGz=uQPXB1SsQsuimw@mail.gmail.com>
References: <CAASrBQ=8icxs8ZyW56CXObZH7DFuPf0XDGz=uQPXB1SsQsuimw@mail.gmail.com>
Date: Thu, 23 Jul 2015 11:11:15 +0300
Message-ID: <CABBYNZL7x4GpgC+JRU=owGmOfs5JdVRHaiCXOe_5oC+oY9BbNg@mail.gmail.com>
Subject: Re: bluetoothctl list-attributes command
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Rages <markrages@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Thu, Jul 23, 2015 at 2:20 AM, Mark Rages <markrages@gmail.com> wrote:
> Hi,
>
> I am trying to interact with a low-energy device using bluetoothctl:
>
> $ bluetoothctl
> [NEW] Controller 00:02:72:C8:B1:AD qountdown-0 [default]
> [NEW] Device F1:4A:78:BD:9C:9F DfuTarg
> [bluetooth]# connect F1:4A:78:BD:9C:9F
> Attempting to connect to F1:4A:78:BD:9C:9F
> [CHG] Device F1:4A:78:BD:9C:9F Connected: yes
> Connection successful
> [DfuTarg]# info
> Device F1:4A:78:BD:9C:9F
>     Name: DfuTarg
>     Alias: DfuTarg
>     Paired: no
>     Trusted: no
>     Blocked: no
>     Connected: yes
>     LegacyPairing: no
>     UUID: Vendor specific           (00001530-1212-efde-1523-785feabcd123)
>     UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>     UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>     RSSI: -57
> [DfuTarg]# list-attributes
> (hangs forever)

Does it hangs or just doesn't print anything?

> Is list-attributes meant to do something here?
>
> Alternately, can anyone supply an example of select-attribute that
> would allow me to interact with an attribute on this device?  I was
> hoping the output of "list-attributes" would be the clue I need.

I suspect something else is going on, perhaps bluetoothd could not
find any attributes or maybe it is connected over classic?

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
