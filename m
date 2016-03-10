Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878u1qi4zf.fsf@intel.com>
References: <1457626604-5656-1-git-send-email-luiz.dentz@gmail.com>
	<878u1qi4zf.fsf@intel.com>
Date: Thu, 10 Mar 2016 20:58:15 +0200
Message-ID: <CABBYNZLs8_dmD0VNC4zgmV_BAFiLSpnQXSZ+qy1tzWvq9ZN3LQ@mail.gmail.com>
Subject: Re: [RFC BlueZ] doc/device-api: Replace GattServices with Discovering property
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Mar 10, 2016 at 8:04 PM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi Luiz,
>
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> GattServices is not really doing was it was meant to do which was to
>> track progress of service discovery since it only worked for the very
>> first time a device is connected but since we no longer remove the
>> attributes an application would have the false impression the service are
>> all resolved by the time it reconnects when in fact the service may have
>> changed.
>>
>> Futhermore object tracking like it is doing has been obsolete by
>> ObjectManager so this propose to replace the service discovery tracking
>> with a boolean property which works both with SDP as well as GATT
>> discovery.
>> ---
>>  doc/device-api.txt |  9 +++------
>>  src/device.c       | 58 +++++++++++-------------------------------------------
>>  2 files changed, 14 insertions(+), 53 deletions(-)
>>
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index a8076a2..9e58664 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -212,10 +212,7 @@ Properties       string Address [readonly]
>>                       Service advertisement data. Keys are the UUIDs in
>>                       string format followed by its byte array value.
>>
>> -             array{object} GattServices [readonly, optional]
>> +             bool Discovering [readonly, optional, experimental]
>>
>> -                     List of GATT service object paths. Each referenced
>> -                     object exports the org.bluez.GattService1 interface and
>> -                     represents a remote GATT service. This property will be
>> -                     updated once all remote GATT services of this device
>> -                     have been discovered and exported over D-Bus.
>> +                     Indicate whether or not service discovery is in
>> +                     progress.
>
> I wonder how useful it's going to be.
>
> What I expect from a client is that it made a GetManagedObjects() call
> when it entered the bus and added listeners to the InterfacesAdded(),
> InterfacesRemoved() and PropertiesChanged() signals, I am not seeing
> what kind of value this property is adding to that kind of client.
>
> But yeah, it is better than GattServices.

I have fight this over in Web Bluetooth, but the design there is
different since it does not expect the stacks to build a cache of the
attributes so they end up with something like a GetPrimaryServices
method which would return the current list of services, but it turn
out they could be outdated if the device database has changed:

https://github.com/thegecko/web-bluetooth-dfu/issues/12#issuecomment-194973956

That said there is this problem that if an application start using the
current objects as soon as it reconnects it may get errors if they are
outdated, I still thing this is better than having to wait the
discovery to complete and not being able to do any access to
attributes before that happens, also which objects not being removed
on disconnect we can persist notifications which is something I
believe is not possible with other stacks, it is probably racy to do
in the applications because by the time you have a new connection
comes in it has to react to that to subscribe again but in the
meantime it can loose notification that had happened quickly enough.

-- 
Luiz Augusto von Dentz
