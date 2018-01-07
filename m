Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLfhge87-FWv_Pj6Da-NFdJU8EUV_ytzG_50u9FAxB=iw@mail.gmail.com>
References: <CAFmMashE1ReOhQFe9OD2BrXooNGz_Gxa9gHLYfB+BgHLQsT5HA@mail.gmail.com>
 <CABBYNZLfhge87-FWv_Pj6Da-NFdJU8EUV_ytzG_50u9FAxB=iw@mail.gmail.com>
From: Alfonso Acosta <alfonso.acosta@gmail.com>
Date: Sun, 7 Jan 2018 17:48:19 +0100
Message-ID: <CAFmMashO+g9qkd+-8WybQaDfC+AhJk_NM9a3O_9wkQpiwPuVkg@mail.gmail.com>
Subject: Re: Overhead reduction in LE connection establishment
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks a lot for the detailed answer.

>> At #7 there is an MTU exchange request, which, for this particular
>> peripheral is not really necessary since I know it only supports 23
>> bytes. Is there a way to disable that? After reading the gatt client
>> initialization code, it seems that no exchange is attempted if the MTU
>> of the central is also 23 bytes, but I don=E2=80=99t know if the default=
 MTU
>> is configurable. Is it?
>
> In theory the stacks does not have to hold on to the same MTU on every
> connection, this is important especially for devices where services
> can be registered dynamically

Yes, I understand that. That's why I was asking whether there was a
way to configure the default MTU of the central. Setting it to 23
should prevent the exchange from happening.

This is admittedly a workaround. The configuration should probably be
per device/connection, and I think would be useful for use-cases other
than mine. BlueZ tries to use the maximum ATT MTU (517), but that may
not be desirable in high-noise environments in which you want to have
small MTUs to mitigate the effect of retransmissions.

> so what you are asking probably require
> a blacklist of devices that don't require MTU negotiation which is
> something hard to maintain.

Not necessarily. We could add the MTU to the device info file (much
like it's done for the connection parameters
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/settings-storag=
e.txt#n287).


>> Finally, at #18, I get the notification from the peripheral.
>
> And here is the real explanation why we do all this, GATT/ATT
> notification do no share the same queue as request/response, so all of
> this shall not stop your peripheral to send the notification upfront
> regardless if there are any requests outstanding, so perhaps the
> problem is really the peripheral which expects the central to be quiet
> while it notifies?

Really good point! I will double check the device's firmware, which
fortunately I have full control of. It may even be that the device
doesn't either respect CCC persistence (which validates why BlueZ
doesn't trust the persistence-handling of devices :) ).

Let's assume I get the peripheral to send the first notification right
after the encryption is established. Even if I call StartNotify()
right after the characteristic object is created, won't I risk missing
the notification if StartNotify() isn't called and served before the
notification is received?

>From what I have observed, the D-Bus GattCharacteristic objects are
destroyed regularly (at least across bluetoothd restarts), they only
seem to be re-created when doing service-discovery and the Notifying
property is not persisted across creations.


>>  I am happy to try to provide some patches if we agree that at least
>> some of these operations are not necessary and there is no way to
>> disable them through configuration.
>
> Except if you want to maintain database of devices with various
> invalid behaviors I don't think we can do much better, especially
> because GATT/ATT on the OSes like iOS and Android do come with drivers
> in a form of applications which does things in their own way we have
> to deal with these nuances smartly or end up reproducing the same
> procedures each and every app does which imo is not maintainable.

I agree that creating a blacklist database is probably unfeasible at
this point, at least without breaking unintentionally breaking
compatibility with faulty devices which slip through the cracks (which
I understand we want to avoid).

However, we could use add another option to the info file, say
"RespectsBondingPersistence" which indicates whether attributes and
CCC values are properly persisted across connection with bonded
devices.
