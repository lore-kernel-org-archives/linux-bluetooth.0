Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2a737c7472be1df26a5d570f609cf377@labapart.com>
References: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
 <9c9da882-fd5b-dfa1-447e-a6f05b341f97@scs.ch> <a4919190d5de8c7c3d25f1ea81772513@labapart.com>
 <CABBYNZLp-1gxGftHQBT_q5pdrxW_fdBoKYMQSmMOS+bZWwk=NQ@mail.gmail.com>
 <1dd40da57a55b3c36be7c5a52c99bbaf@labapart.com> <CABBYNZ+4=VSb9=wjWj+uRYLDYGSWJm7HiNEYjpL+d3B-2O+QyQ@mail.gmail.com>
 <2a737c7472be1df26a5d570f609cf377@labapart.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 14 Jul 2017 10:49:54 +0300
Message-ID: <CABBYNZ+Y_b+-nm+Msg1nQvCbtqbFXk=BMF4gpYXrzFsPCeQAMA@mail.gmail.com>
Subject: Re: DBUS API: Retrieve current MTU used by remote device
To: Olivier MARTIN <olivier@labapart.com>
Cc: Felix Schulthess <felix.schulthess@scs.ch>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Olivier,

On Fri, Jul 14, 2017 at 1:47 AM, Olivier MARTIN <olivier@labapart.com> wrote:
> Hi Luiz,
>
> On 13.07.2017 13:18, Luiz Augusto von Dentz wrote:
>>
>> Hi Olivier,
>>
>> On Tue, Jul 11, 2017 at 7:31 PM, Olivier MARTIN <olivier@labapart.com>
>> wrote:
>>>
>>> Hi Luiz,
>>>
>>> Ubuntu 16.04 LTS is shipped with bluez v5.37. You could argue Bluez v5.37
>>> does not officially support GATT over DBus as the support is still
>>> experimental which is true. And because v5.37 does not support GATT Long
>>> Write, developers should not use Bluez prior to v5.42 (date when GATT
>>> D-Bus
>>> API is marked as not experimental anymore).
>>>
>>> As the GATT client might also send packet longer than 20 bytes, the
>>> client
>>> also needs to support Long Read/Write (same as GATT server).
>>> From my quick search, it looks Long Read/Write support is not well
>>> supported
>>> by all GATT server/client. I do not know whether it is a correct
>>> assumption
>>> or developers are not aware of its support.
>>>
>>> At the moment I am using a protocol on top of GATT to send my payload in
>>> chunk. I sometimes send payloads as large as 200 bytes. By sending 19
>>> bytes
>>> (+ 1 bytes for the application protocol to support chunk) I need 11 GATT
>>> characteristic writes while I could send only 1 packet if I knew the ATT
>>> MTU
>>> could have been increased to 203 bytes or more.
>>> Throughput is not critical but it has a high importance in my use case
>>> (Human Machine interface).
>>>
>>> By increasing my hardcoded payload from 20 bytes to 200 bytes (because I
>>> know the negociated ATT MTU is 512 bytes), my application test time
>>> execution dereases from 32sec to 11sec. If I knew the ATT MTU (for
>>> instance
>>> from D-Bus Bluez), I could replace the hardcoded value by the negociated
>>> one.
>>
>>
>> So it is 22 sec of round trips, not only over the air but also D-Bus
>> message round trips between processes.
>>
>>> If I had some confidence Long Read/Write feature was well supported, I
>>> will
>>> be happy to use it. But I am worry it is not - but I could be wrong. What
>>> do
>>> you think?
>>
>>
>> If you control both GATT server and client why not use write without
>> response and notifications, then you can use AcquireWrite and
>> AcquireNotify and write/read using the given fd and MTU.
>>
>
> I can see AcquireWrite and AcquireNotify are marked as experimental in the
> current Bluez. So it means it will not be supported by current
> distributions.

It hasn't been released yet, but at first all API are marked experimental.

> Unfortunately I do not control the GATT server and client. My project is a
> software protocol that I aim to deploy on various Bluetooth software
> stack/firmware from various vendors (Bluez, Windows, Apple, Android +
> different firmware vendor, MCU such as Nordic).
> I am a bit concern if I use Long Write/Read, I will spend a lot of time
> supporting Bluetooth stack variations.

Read again, I did not suggest you to use Long Write, and when I said
control the server I mean control the attribute/characteristic
definition so you can define it to use write without response and
notifications since that is indicated in the characteristic
properties.

> I would be happy to use Long Write/Read if the feature could be probed to
> know if it is supported by the BLE device and fallback to the application
> protocol if not supported. But I guess by specification, it is assumed the
> feature is always be present and supported.
> I am considering to use my application packet protocol by default and use a
> mechanism to let know the GATT server and client Long Write/Read are
> supported by both devices to then switch to use them.

There is nothing to detect that Long Write is supported upfront, so
you would have to actually write to see if that works, but then again
why would like to go this way if you can use write without response
and notifications?

> Exposing the ATT MTU through Bluez D-BUS API would solve my issue even if it
> is a workaround in term of GATT specification. For diagnostic purpose, it
> might still be helpful to have the MTU exposed in D-BUS API.
> I am happy to have a try to add the support for ATT MTU to Bluez D-BUS
> Device API myself if you think it is feasible and the patches will be
> accepted (obviously after being approved on the mailing-list).

It would have the same treatment as AcquireWrite and AcquireNotify so
at the start it would probably be marked as experimental. Note that

-- 
Luiz Augusto von Dentz
