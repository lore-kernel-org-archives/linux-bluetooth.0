Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLR2coVgyuV-7YtSB+B9U8YGUE-SsUBJvSZbvH21_GOAg@mail.gmail.com>
References: <CAPuY=zMC+MX=a-HisNnUSJ9zuORUtqukALj9hhv3EKHpTaGDEg@mail.gmail.com>
	<CAPuY=zODx6jR_QrtLmy5TqeDTavMBcm=Y7J6mQRZu4QKHgsE3Q@mail.gmail.com>
	<CABBYNZLR2coVgyuV-7YtSB+B9U8YGUE-SsUBJvSZbvH21_GOAg@mail.gmail.com>
Date: Thu, 26 Mar 2015 13:33:12 +0200
Message-ID: <CAPuY=zPoZTdod8uNxPXyPp8Hi0hz3SPoGVMi+r__4A_w3CmJyw@mail.gmail.com>
Subject: Re: bluez: using "service data" in BLE advertisement packets
From: Alon Ziv <nolaviz@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ah... Yes, this looks good (or at least much better :) )

In our specific case the service data changes relatively frequently,
on the order of once per minute. And we usually need the most
up-to-date data when an application actually inspects the device (as I
mentioned above, the devices aren't connectable, so the only way to
receive any data from them is through the advertisement packets).

In terms of filtering, we also see cases where we will need to filter
on the contents of the service data (i.e. when many devices of the
same type are in the same area, we will want to only receive
notifications on a subset of them). Think e.g. of iBeacons - an
application may want to only be notified on beacons that belong to the
app's developer (iPhones use this method to achieve low-power scanning
of BLE beacons).
-- Alon Ziv


On Thu, Mar 26, 2015 at 11:37 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Alon,
>
> On Wed, Mar 25, 2015 at 4:21 PM, Alon Ziv <nolaviz@google.com> wrote:
>> Hi all,
>>
>> We are developing some applications with non-connectable BLE
>> advertisers that broadcast data in a "service data" element of the
>> advertisement packet. So far we have used these devices with Android
>> and with iOS, both of which can easily support these devices as the
>> entire advertisement packet payload is exposed to scanning
>> applications.
>>
>> Looking at the bluez DBus API, it appears that no equivalent
>> functionality exists: in particular, when the advertisement packets
>> are parsed (eir_parse() called from
>> src/adapter.c:update_found_devices()) any service-data elements are
>> simply discarded. Even worse (for us), if the devices' advertisements
>> are not marked "discoverable" they are simply dropped outright. And
>> even if the device is discoverable, it looks like we'd get only a
>> single notification when the device is first seen - but we won't be
>> able to verify it is still in range (i.e. continued reception of
>> advertisement packets).
>>
>> Is the above summarization correct?
>
> We working on adding advertising support right, perhaps you should
> take a look at my proposal:
> [RFC BlueZ] doc/device-api: Add ServiceData and ManufacturerData
>
> Do expect the service data to change frequently? I guess we are
> programming the controller to filter duplicates, but we are working
> (actually most of the work is coming from your colleague Jakub
> Pawlowski) SetDiscoveryFilter:
>
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapter-api.txt
>
>> (The API documentation claims to support "observer" mode, but these
>> limitations actually put the lie to this statement - an observer is
>> supposed to see _all_ advertisement packets, including non-first ones
>> and those from non-discoverable devices...)
>>
>> Regards
>> -- Alon Ziv
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
