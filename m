Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKmaE2VMNxa4oNcByGmjS2FcH3UXLD1N0m3rsUce6GOeA@mail.gmail.com>
References: <CAD0=r8wfL1TYghMk2wHYrZFZ9D=sz49_1fNPVsPvgqOUVdbuCQ@mail.gmail.com>
	<CABBYNZ+JoqhDtH_ZN9bVafMnDYgyjsmwKnTssA8_QFJ1js9kQA@mail.gmail.com>
	<CAD0=r8wDGKw4DRnEAsZqNvMc05CGnjz7HVFc6MTQZi74L9xC1Q@mail.gmail.com>
	<20150531025505.GA23991@t440s>
	<CAD0=r8xVzep5nu5=J4Hz5FkpSTo03csYt2=wtXRF6vmydR6q1g@mail.gmail.com>
	<CABBYNZKmaE2VMNxa4oNcByGmjS2FcH3UXLD1N0m3rsUce6GOeA@mail.gmail.com>
Date: Mon, 1 Jun 2015 14:42:31 -0700
Message-ID: <CAHrH25TsFBte0TazmN6AeeWFQ2eQimVCsSDrV3JXGLNaJ3BYJA@mail.gmail.com>
Subject: Re: [RFC] Add new method to DBus API: DiscoverServiceByUUID
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Mon, Jun 1, 2015 at 11:22 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Mon, Jun 1, 2015 at 8:25 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Hi Johan, Luiz
>>
>> On Sat, May 30, 2015 at 7:55 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> Hi Jakub,
>>>
>>> On Thu, May 28, 2015, Jakub Pawlowski wrote:
>>>> > 1. Instead of just 1 method there is at least 2, but Connect depends
>>>> > on what has been discovered first so you are adding a D-Bus round
>>>> > trips.
>>>>
>>>> Yes, I'm probably adding one round trip. It might hovewer be avoided.
>>>> To avoid additional roundtrip there should be two methods:
>>>> Connect() that just works right now, and ConnectToUUID(uuid) that
>>>> would connect, and then do "Find By Type Value Request". I think that
>>>> this solution wouldn't be that clean, and would be problematic to
>>>> discover rest of services.
>>>
>>> We already have this "ConnectToUUID" method in the form of
>>> Device1.ConnectProfile, don't we? It was originally designed for BR/EDR,
>>> but seems to have at least some code for LE as well. If it's not working
>>> as desired for LE it's probably something worth fixing.
>>>
>>
>> "ConnectToUUID" method is what I was looking for. It doesn't work for
>> LE devices as far as I tested, so I'll fix it. It creates connection,
>> but then stops (no MTU exchange, or service discovery).
>>
>> Here's merged (to show time order) output of btmon and bluetoothd
>> together when calling ConnectToUUID right now:
>> http://pastebin.com/s76bT3jx
>>
>> When I looked into source, it looks like it still want to do full
>> service discvery, not just one service. Can I modify it to do ""Find
>> By Type Value Request" for LE devices ?
>>
>>
>> I modified bluez a little bit to test timing, and show why I want to
>> have "Find By Type Value Request":
>>
>> Right after connecting and negotiating MTU, instead of doing Primary
>> and Secondary Service Discovery, I made BlueZ do "Find By Type Value
>> Request" for service with UUID "babe", and then auto discover it's
>> included services, characteristics, descriptors.
>>
>> First I tested against Android phone with three Primary Services
>> (GATT, GAP, and one with UUID "babe"), and total of 4 characteristic,
>> one in "babe" service. MTU=517.
>> Doing regular discovery took 2.38s from "Read By Group Type Request"
>> to last request, http://pastebin.com/pgrfAJM9
>> Doing just one service discovery took 0,84s from "Find By Type Value
>> Request" to last request, http://pastebin.com/V1WZERfw
>
> They are not doing the same thing, you are not looking for GAP, GATT
> and DIS services for example, so the device will not have any of these
> discovered, so no long names, no appearance, no service changed and no
> device information. Also Im not sure you got my point about the
> ConnectUUID, let say it is just discover the UUID requested, you will
> have to do it every single time you connnect because it cannot be
> cached without service changed, also this is per UUID, if the
> peripheral just have one being advertised that might work in favor of
> this but there could be many as well then doing ConnectUUID separately
> don't make any sense.
>
>> Then I tested against iPhone with 5 services and total of 12
>> characteristics (one with UUID "babe", having one characteristic).
>> MTU=158. Sample iPhone app I used for tests started automatically
>> discovering services on the laptop, which also impacted discovery
>> time.
>> Doing regular discovery took 9.7s from "Read By Group Type Request" to
>> last request, http://pastebin.com/aycMWZ4w
>> Doing just one service discovery took 2s from "Find By Type Value
>> Request" to last request, http://pastebin.com/C9Jp28WM
>>
>> My use case is to quickly connect, and use one service, then
>> disconnect. 2.3s vs 0.8s is big gain for me, not talking about 9.7 vs
>> 2s. Some controllers designed for coin-battery scenarios have MTU
>> fixed on 23, which should also make all service discovery slow, and
>> yield big difference.
>
> Service changed, the lower is your requirement to reconnect the more
> it will be required, but you got to pair to make it persistent across
> reconnections but the first time you connect is always going to be
> time consuming since you got to discover so it does not matter much if
> the first time takes 9.7s to discover all services since the next time
> it would not spend any time doing it again, that is the only reason
> HoG can reconnect very fast.
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm late to the discussion, but wasn't this kind of functionality the
whole point behind adding the org.bluez.GattProfile1 interface defined
in doc/gatt-api.txt? Can't we do this through that?

-Arman
