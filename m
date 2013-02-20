Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <87r4kby93b.fsf@randy.site>
References: <87r4kby93b.fsf@randy.site>
From: Ash K <ashoksarf@gmail.com>
Date: Wed, 20 Feb 2013 12:04:05 +0530
Message-ID: <CAMhHtTy=Qd=xabZLO0Dqs6VnOEkAKVyAEa8DWdok6mKC+RX8Sw@mail.gmail.com>
Subject: Re: Setting Link Level Security Mode
To: Randy Yates <yates@digitalsignallabs.com>
Cc: Bluez Mailing List <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

As far I can understand you security mode is has been removed from
specification since Bluetooth 2.1, it is mandatory to encrypt link
before service level connection.

On Wed, Feb 20, 2013 at 8:39 AM, Randy Yates
<yates@digitalsignallabs.com> wrote:
> We have a requirement to set Link Level Security mode 1. How can this be
> done with the bluez stack?
>
> The mgmt-api allows the following bit-mapped modes to be
> configured:
>
>                 1       Powered
>                 2       Connectable
>                 3       Fast Connectable
>                 4       Discoverable
>                 5       Pairable
>                 6       Link Level Security (Sec. mode 3)
>                 7       Secure Simple Pairing
>                 8       Basic Rate/Enhanced Data Rate
>                 9       High Speed
>                 10      Low Energy
>
> Note that although you can set Link Level Security mode 3 on or off,
> there is no general way to set the link level security mode, which
> according to Huang's "Bluetooth Essentials for Programmer" (p.31)
> consists of three different modes (mode 1, mode 2, and mode 3).
> --
> Randy Yates
> Digital Signal Labs
> http://www.digitalsignallabs.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Ash
