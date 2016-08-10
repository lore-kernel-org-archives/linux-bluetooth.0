Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APYkYEcoO-BG87HYC+Vp5Ke=h2MtWjDJKe-9+e2CG=bg+w@mail.gmail.com>
References: <CAAu3APYkYEcoO-BG87HYC+Vp5Ke=h2MtWjDJKe-9+e2CG=bg+w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Aug 2016 17:45:58 +0300
Message-ID: <CABBYNZL+mSH4vZh2XDn+Yf7hHPg1HQaEMFAxdFSZUP4ABwGhwg@mail.gmail.com>
Subject: Re: Eddystone URL beacon and Peripheral
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Tue, Aug 9, 2016 at 4:37 PM, Barry Byford <31baz66@gmail.com> wrote:
> Hello,
>
> I am looking to have a Linux single board computer advertising as a
> beacon and as a peripheral at the same time through the DBus API.
>
> The use case is that the beacon is a Eddystone URL. That destination
> of URL will then use web bluetooth to connect back to the peripheral
> service being advertised on the board.

This advertisement instances are not that great in practice, to be
able to follow exactly what is going on it would require us to scan in
the same intervals which we don't know upfront which leaves us just
with very aggressive scanning? Also from the eddsystone spec it seems
that each slot represents a different entity using the same address
which complicates things ever further.

> In the BlueZ documentation it states that currently only one
> advertisement at a time is supported,
> So while it appears multiple UUIDs can be advertised under interface
> LEAdvertisement1 it can not be a beacon and a peripheral.

Possible, but a beacon is not connectable and a peripheral shall be
connectable so having those with the same address may not gonna work,
in the other hand we maybe able to advertise the beacon with a random
address since it is not suppose to be connectable it doesn't matter
but then the URL will not be correlated with peripheral, so while the
intentions of eddystone were good the idea that multiple advertisement
instances based on Android interface just don't work that well in
practice and we might need to increase the advertisement payload so we
can combine those things together.

> Or am I missing something?
>
> This use case seems like it might become more common with web
> bluetooth coming along.
> Is it possible to support this under the DBus API?
>
> Thanks,
> Barry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
