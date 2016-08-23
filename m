Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOsEZogZpPu7NBgVnp=eamwMp-jn8_9hTuK9PEua=2Pme9v5Eg@mail.gmail.com>
References: <CAOsEZohrTsrZuLxpfRQ37mVcXGDqO+rV6TzfzR1ELbSHe0jtng@mail.gmail.com>
 <8CD08159-2E3B-4663-9C49-56131BB77AFA@holtmann.org> <CABBYNZ+cLHkDYH+L78oAr1P6Uua_TrbA02DE_tE0LoNq7wv=7A@mail.gmail.com>
 <CAOsEZogZpPu7NBgVnp=eamwMp-jn8_9hTuK9PEua=2Pme9v5Eg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Aug 2016 15:24:20 +0300
Message-ID: <CABBYNZLeHE9Xp1mAPCXXJexnpBu2cNSqKYQkRmx1NdCd8ci55w@mail.gmail.com>
Subject: Re: BLE Hexiwear connection fail
To: Jay Aurabind <jay.aurabind@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jay,

On Tue, Aug 23, 2016 at 9:18 AM, Jay Aurabind <jay.aurabind@gmail.com> wrote:
> On 22 August 2016 at 16:27, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Hi Jay, Marcel,
>>
>> On Mon, Aug 22, 2016 at 11:51 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>> Hi Jay,
>>>
>>>> I have the IoT device Hexiwear[1], which connects through BLE. They
>>>> have an android app which can take data from it. I want to use from my
>>>> linux machine. Its BLE API is provided at their github[2] page.
>>>
>>> does it work on Android? If so, then enable Bluetooth HCI tracing/logging in Android and send around the /sdcard/btsnoop_hci.log file. You can read that wit btmon by yourself and compare.
>>>
>>> I would also propose you start using btmon instead of hcidump.
>>
>
>> The D-Bus GATT should be able to handle those, if we are able to
>> connect, but there seems to be something wrong with the specification
>> as it does seems to use UUID range reserved by the SIG instead of
>> using proper 128 bits UUIDs.
>>
>
> Since I do not know about much bluez stack, are you telling that some
> changes needs to be done within the bluez stack so as to connect/pair
> to such BLE devices which use  UUIDs reserved by SIG rather than
> private ones? And could you please clarify about "something wrong with
> the specification" ?

The 16 Bits UUIDs used for the custom service (0x2000-0x2040) are
reserved to be used by the SIG:

https://www.bluetooth.com/specifications/assigned-numbers/16-bit-UUIDs-for-SDOs

Alternatively if you really want to use 16 Bits UUIDs:

https://www.bluetooth.com/specifications/assigned-numbers/16-bit-UUIDs-for-Members

Note: this has nothing to do with the connection problem, but it is
perhaps even worst problem because you won't be able to pass Bluetooth
qualification.


-- 
Luiz Augusto von Dentz
