Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <68cc4a9b-5bbb-6dd0-3560-4de1594b8271@flypig.co.uk>
 <CABBYNZJ08UMN8-0LfuWpgpELKLmjvSTdcjDUvQqdsQhp3N9xBw@mail.gmail.com>
 <1100eedc-ec4f-e798-9ca7-511a9030c9b6@flypig.co.uk> <4a59a008-4595-8530-cd22-6a4a1cf4520f@flypig.co.uk>
 <CABBYNZ+rmXvnMpkkP-wkmGs07S2EA=Pum9j=LFxFJzYJm45C-A@mail.gmail.com>
In-Reply-To: <CABBYNZ+rmXvnMpkkP-wkmGs07S2EA=Pum9j=LFxFJzYJm45C-A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 04 May 2018 11:14:43 +0000
Message-ID: <CABBYNZLkkcSWns5R4U8fmxQFJ2A9RccYxqvrEVVF_rGY668fDA@mail.gmail.com>
Subject: Re: BLE ad discoverability flags - missing when ads are generated,
 but needed when scanning
To: david@flypig.co.uk
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Szymon Janc <szymon.janc@codecoup.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,
On Fri, May 4, 2018 at 2:13 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com>
wrote:

> Hi David,
> On Fri, May 4, 2018 at 1:34 PM David Llewellyn-Jones <david@flypig.co.uk>
> wrote:

> > Hi Luiz,

> > Forgive me for following up my own post, this is an addendum.

> > On 03/05/18 19:15, David Llewellyn-Jones wrote:
> > > Hi Luiz,
> > >
> > > Thanks for the prompt reply.
> > >
> > > On 03/05/18 18:58, Luiz Augusto von Dentz wrote:
> > >> Hi David,
> > >>
> > >> On Thu, May 3, 2018 at 7:42 PM David Llewellyn-Jones <
> david@flypig.co.uk>
> > >> wrote:
> > >>
> > >>> Hi,
> > >>
> > >>> I've been using bluez on a combination of an Ubuntu laptop running
> bluez
> > >>> 5.49 compiled from source and a Sailfish OS phone running the
default
> > >>> install bluez 5.47. On the laptop I'm using DBUS to interact with
> bluez;
> > >>> on the phone I'm going via the QTBluetoothDiscoveryAgent interface,
> > >>> running QT 5.6.
> > >>
> > >>> The difficulty I've been experiencing is that BLE advertisements
sent
> > >>> from the laptop in peripheral mode aren't being discovered by the
> phone.
> > >>
> > >>> I can see the advertisements being picked up by btmon on the phone,
> but
> > >>> it doesn't filter up to the QT wrapper. Looking through the bluez
> source
> > >>> code, it appears that the reason is because in the case of
unfiltered
> > >>> discovery, bluez ignores adverts that don't have either EIR_LIM_DISC
> or
> > >>> EIR_GEN_DISC flags set, as in the following code:
> > >>
> > >>
> > >>

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c?h=5.47#n5658
> > >>
> > >>> However, as far as I can tell (I could easily be wrong), bluez never
> > >>> adds these flags into the advertising data. I was expecting to see
> them
> > >>> added in the following bit of code:
> > >>
> > >>
> > >>

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/shared/ad.c#n423
> > >>
> > >>> As a result, I can't figure out a way to produce advertisements from
> my
> > >>> laptop that can be picked up by my phone.
> > >>
> > >>> Adding the flags by calling the following function within
> > >>> bt_ad_generate() with a value of 0x06 fixed the issue (i.e. allowed
my
> > >>> phone to discover my laptop).
> > >>
> > >>> static void serialize_flags(uint8_t value, uint8_t *buf, uint8_t
*pos)
> > >>> {
> > >>>          if (value == 0)
> > >>>                  return;
> > >>
> > >>>          buf[(*pos)++] = sizeof(value) + 1;
> > >>>          buf[(*pos)++] = EIR_FLAGS;
> > >>>          buf[(*pos)++] = value;
> > >>> }
> > >>
> > >>> My question is therefore whether there's a way for bluez to produce
> BLE
> > >>> advertisements (on my laptop) that can be picked up by a
non-filtered
> > >>> scan using bluez (on my phone). I searched the Web and the list
> archives
> > >>> but didn't find anything that seemed to help answer.
> > >>
> > >> It is actually added if you have marked the adapter as Discoverable:
> > >>
> > >>

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/advertising.c#n740
> > >
> > > From what I can make out, the flag is registered, but never actually
> > > added to the advert payload data. At least, this is what I could make
> > > out from the 5.49 code, and running experiments matched this behaviour
> > > (i.e. marking the adapter discoverable and running the scan still
> > > yielded no results).
> > >
> > > I also noticed that making the adapter discoverable turns on
visibility
> > > for Bluetooth Classic, which I was hoping to avoid. There would be
> > > definite value for me in separating the two (e.g. being able to
> > > explicitly set the flags in the advert).
> > >
> > >> There has been some debate if we should have this per instance but
that
> > >> would probably require some changes in the way we deal with whitelist
> > >> devices since currently we only allow unknown devices to connect when
> > >> discoverable.
> > >
> > > I'm afraid I don't understand the issue as I'm not sure what you mean
by
> > > whitelist devices, and I must have missed this discussing when
searching
> > > the archives. I'll dig a bit further to try to understand better.

> > I had a look through the archives but couldn't find the debate you're
> > referring to. However, I had a look at references to whitelisting in the
> > code, which I hope has allowed the following better understanding:

> > If a device is sending adverts with the 'discoverable' flag set, but the
> > adapter isn't in discoverable mode, then any recipient of the
> > advertisement will be rejected if it tries to connect and isn't
> > whitelisted (bonded). This is undesirable behaviour.

> > Is this a correct interpretation of the problem?

> Yes, and that is why we are not setting the flags since devices would not
> be able to connect if the adapter is not set discoverable.

> > For my particular use case I'd like the phone to be able to receive the
> > advert, then read/write GATT characteristics without the adapter being
> > in BR/EDR discoverable mode. When I use iOS to connect to the same bluez
> > peripheral it works seamlessly and I'm trying to match the same
> > behaviour. Unlike bluez 5.47, iOS doesn't filter out the adverts with no
> > 'discoverable' flag.

> > So I think there are two issues here:

> > 1. Should the flags be added to the ad data payload? As far as I can
> > tell the current implementation never includes them, but there are
> > circumstances when they should be. I'd be very happy if I'm wrong!

> It seems to be working properly and I can find the advertising instance:

> > HCI Event: LE Meta Event (0x3e) plen 15
>         LE Advertising Report (0x02)
>           Num reports: 1
>           Event type: Connectable undirected - ADV_IND (0x00)
>           Address type: Public (0x00)
>           Address: 00:1B:DC:08:E4:FD (Vencer Co., Ltd.)
>           Data length: 3
>           Flags: 0x02
>             LE General Discoverable Mode
>           RSSI: -28 dBm (0xe4)
> @ MGMT Event: Device Found (0x0012) plen 17
>           LE Address: 00:1B:DC:08:E4:FD (Vencer Co., Ltd.)
>           RSSI: -28 dBm (0xe4)
>           Flags: 0x00000000
>           Data length: 3
>           Flags: 0x02
>             LE General Discoverable Mode

> > 2. If the 'discoverable' flag can be set in the ad independent of the
> > adapter, how to tackle unknown devices that then try to connect?

> We would have to change the kernel policy regarding discoverable, it would
> have to check if there is any instance advertising with Discoverable mode,
> we may restrict it to just the address of that instance though.

> > I can put together a patch that, even if it's of no use, might better
> > illustrate 1 if that would be helpful? For 2, I'd value any suggestions
> > for the correct way to allow a central to access the peripheral
> > characteristics as seamlessly as possible.

> I guess the real problem here is that by only allowing connecting with
> discoverable set that means we would leak the public address over BR/EDR
> when using LE privacy, so I guess we really need to allow discoverable
> setting per ad instance but will have to change this policy in the kernel.
> In terms of API probably nothing has to be changed but the kernel will
need
> to be aware of the instances discoverable flag in order to allow
connection
> even if the global discoverable flag is not set.

Thoughts?

-- 
Luiz Augusto von Dentz
