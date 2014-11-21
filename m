Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B3953F7E-C8F3-45A2-A0E5-A24848E299DF@holtmann.org>
References: <1412938157-70760-1-git-send-email-marcel@holtmann.org>
	<CAD0=r8zAKR_iGcqyeRotDoshhAp=5U8SCcKJrr+GUsAsy-4TLQ@mail.gmail.com>
	<B3953F7E-C8F3-45A2-A0E5-A24848E299DF@holtmann.org>
Date: Fri, 21 Nov 2014 11:49:32 -0800
Message-ID: <CAD0=r8wEVPdgEZAUKxD7eS2r0XzitRaSYFe9J4FhE320YCMg6w@mail.gmail.com>
Subject: Re: [PATCH] doc: Add commands for Start Service Discovery and Stop
 Service Discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 20, 2014 at 11:06 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Jakub,
>
>> I think that RSSI_Threshold should be per UUID:
>>
>> +       Command Parameters:     Address_Type (1 Octet)
>> +                               Num_Filters (1 Octet)
>> +                               Filter1 {
>> +                                   RSSI_Threshold (1 Octet)
>> +                                   UUID[i] (16 Octets)
>> +                               }
>> +                               Filter2 {}
>> +                               ...
>
> I need a bit more reason for this. Stating it does not convince me ;)
>
> My take is that it is not needed for this one-shot discovering. Just sele=
ct some good enough RSSI threshold and filter the rest later when you get T=
X power information. Like with Start Discovery it will stop once it is done=
 with the search. So next time around you can select a different RSSI thres=
hold.
>
> Regards
>
> Marcel
>

Let's say I'm scanning for two kinds services:
- some security token, that needs to be very close to my machine
- temperature sensor, with no particular interest in range
- controller receives one packet from security token that advertise at
very high TX power and is very close, so I specify very high rssi
threshold
- then the temperature sensor, that advertises on low power will not be rep=
orted

If I had rssi specified per UUID that won't be the case.

I can also set the RSSI threshold at very low value to get notified
about temperature sensor, but the I'll get a lot of  device found
events about security token that will wake my application unnecessary.
We want to avoid that, and that's why we're doing scan in kernel, and
plan to move it to controller.

So my patches right now define rssi threshold per UUID this like that:

struct mgmt_uuid_filter {
__s8 rssi;
__u8 uuid[16];
} __packed;

struct mgmt_cp_start_service_discovery {
__u8 type;
__le16 filter_count;
struct mgmt_uuid_filter filter[0];
} __packed;
