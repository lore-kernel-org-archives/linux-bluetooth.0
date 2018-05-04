Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: BLE ad discoverability flags - missing when ads are generated,
 but needed when scanning
From: David Llewellyn-Jones <david@flypig.co.uk>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <68cc4a9b-5bbb-6dd0-3560-4de1594b8271@flypig.co.uk>
 <CABBYNZJ08UMN8-0LfuWpgpELKLmjvSTdcjDUvQqdsQhp3N9xBw@mail.gmail.com>
 <1100eedc-ec4f-e798-9ca7-511a9030c9b6@flypig.co.uk>
Message-ID: <4a59a008-4595-8530-cd22-6a4a1cf4520f@flypig.co.uk>
Date: Fri, 4 May 2018 11:34:20 +0100
MIME-Version: 1.0
In-Reply-To: <1100eedc-ec4f-e798-9ca7-511a9030c9b6@flypig.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Forgive me for following up my own post, this is an addendum.

On 03/05/18 19:15, David Llewellyn-Jones wrote:
> Hi Luiz,
> 
> Thanks for the prompt reply.
> 
> On 03/05/18 18:58, Luiz Augusto von Dentz wrote:
>> Hi David,
>>
>> On Thu, May 3, 2018 at 7:42 PM David Llewellyn-Jones <david@flypig.co.uk>
>> wrote:
>>
>>> Hi,
>>
>>> I've been using bluez on a combination of an Ubuntu laptop running bluez
>>> 5.49 compiled from source and a Sailfish OS phone running the default
>>> install bluez 5.47. On the laptop I'm using DBUS to interact with bluez;
>>> on the phone I'm going via the QTBluetoothDiscoveryAgent interface,
>>> running QT 5.6.
>>
>>> The difficulty I've been experiencing is that BLE advertisements sent
>>> from the laptop in peripheral mode aren't being discovered by the phone.
>>
>>> I can see the advertisements being picked up by btmon on the phone, but
>>> it doesn't filter up to the QT wrapper. Looking through the bluez source
>>> code, it appears that the reason is because in the case of unfiltered
>>> discovery, bluez ignores adverts that don't have either EIR_LIM_DISC or
>>> EIR_GEN_DISC flags set, as in the following code:
>>
>>
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c?h=5.47#n5658
>>
>>> However, as far as I can tell (I could easily be wrong), bluez never
>>> adds these flags into the advertising data. I was expecting to see them
>>> added in the following bit of code:
>>
>>
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/shared/ad.c#n423
>>
>>> As a result, I can't figure out a way to produce advertisements from my
>>> laptop that can be picked up by my phone.
>>
>>> Adding the flags by calling the following function within
>>> bt_ad_generate() with a value of 0x06 fixed the issue (i.e. allowed my
>>> phone to discover my laptop).
>>
>>> static void serialize_flags(uint8_t value, uint8_t *buf, uint8_t *pos)
>>> {
>>>          if (value == 0)
>>>                  return;
>>
>>>          buf[(*pos)++] = sizeof(value) + 1;
>>>          buf[(*pos)++] = EIR_FLAGS;
>>>          buf[(*pos)++] = value;
>>> }
>>
>>> My question is therefore whether there's a way for bluez to produce BLE
>>> advertisements (on my laptop) that can be picked up by a non-filtered
>>> scan using bluez (on my phone). I searched the Web and the list archives
>>> but didn't find anything that seemed to help answer.
>>
>> It is actually added if you have marked the adapter as Discoverable:
>>
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/advertising.c#n740
> 
> From what I can make out, the flag is registered, but never actually
> added to the advert payload data. At least, this is what I could make
> out from the 5.49 code, and running experiments matched this behaviour
> (i.e. marking the adapter discoverable and running the scan still
> yielded no results).
> 
> I also noticed that making the adapter discoverable turns on visibility
> for Bluetooth Classic, which I was hoping to avoid. There would be
> definite value for me in separating the two (e.g. being able to
> explicitly set the flags in the advert).
> 
>> There has been some debate if we should have this per instance but that
>> would probably require some changes in the way we deal with whitelist
>> devices since currently we only allow unknown devices to connect when
>> discoverable.
> 
> I'm afraid I don't understand the issue as I'm not sure what you mean by
> whitelist devices, and I must have missed this discussing when searching
> the archives. I'll dig a bit further to try to understand better.

I had a look through the archives but couldn't find the debate you're
referring to. However, I had a look at references to whitelisting in the
code, which I hope has allowed the following better understanding:

If a device is sending adverts with the 'discoverable' flag set, but the
adapter isn't in discoverable mode, then any recipient of the
advertisement will be rejected if it tries to connect and isn't
whitelisted (bonded). This is undesirable behaviour.

Is this a correct interpretation of the problem?

For my particular use case I'd like the phone to be able to receive the
advert, then read/write GATT characteristics without the adapter being
in BR/EDR discoverable mode. When I use iOS to connect to the same bluez
peripheral it works seamlessly and I'm trying to match the same
behaviour. Unlike bluez 5.47, iOS doesn't filter out the adverts with no
'discoverable' flag.

So I think there are two issues here:

1. Should the flags be added to the ad data payload? As far as I can
tell the current implementation never includes them, but there are
circumstances when they should be. I'd be very happy if I'm wrong!

2. If the 'discoverable' flag can be set in the ad independent of the
adapter, how to tackle unknown devices that then try to connect?

I can put together a patch that, even if it's of no use, might better
illustrate 1 if that would be helpful? For 2, I'd value any suggestions
for the correct way to allow a central to access the peripheral
characteristics as seamlessly as possible.

David
-- 
Website: http://www.flypig.co.uk
