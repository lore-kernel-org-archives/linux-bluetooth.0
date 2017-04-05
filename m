Return-Path: <sudeepta.bhuyan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+pj_rpchfYs37Sj0Goddi1CL6VMU=C9wuh7=QxTHFnJA@mail.gmail.com>
References: <CA+TC0NoAX-B362BS=s-kk3bhi4k75ygYV_Lix6F9vDoJsTMS-w@mail.gmail.com>
 <5A0CB2AD-B99B-4929-A641-423CF8C7799C@holtmann.org> <CABBYNZ+pj_rpchfYs37Sj0Goddi1CL6VMU=C9wuh7=QxTHFnJA@mail.gmail.com>
From: sudeepta bhuyan <sudeepta.bhuyan@gmail.com>
Date: Wed, 5 Apr 2017 16:55:26 +0530
Message-ID: <CA+TC0NpPLOJ=CVNdxHD+uRE7QBZ9X=hY6LDSN_VZQqPRYgC_Kg@mail.gmail.com>
Subject: Re: Re-connect to BLE device in response to ADV_DIRECT_IND
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Marcel and  Luiz
My application was always in active discovery mode. After disabling
active discovery, auto connect started to work. I have read that this
is an issue with linux kernel version < 3.17.


Sudeepta

On Wed, Apr 5, 2017 at 4:46 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Sudeepta,
>
> On Wed, Apr 5, 2017 at 4:14 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Sudeepta,
>>
>>> I'm a BlueZ newbie and wanted your help regarding a problem that I'm
>>> facing with a BLE project.
>>>
>>> I'm running BlueZ 5.42 in my linux machine and have written a
>>> bluetooth application which communicates with a BLE device.
>>> The application uses bluez dbus APIs for pairing and connecting to the
>>> BLE device (device-api.txt and adapter-api.txt).
>>> The BLE device is programmed to disconnect if left idle and send
>>> ADV_DIRECT_IND if woken up.
>>>
>>> Using hcidump tool, I see that bluetoothd on my machine indeed
>>> receives the ADV_DIRECT_IND message from the BLE device. However I'm
>>> not able to figure out how my application can be made aware that such
>>> an advertisement has been received and it should now reconnect to the
>>> BLE device.
>>>
>>> I do not see any dbus API or signal using which the application can be
>>> made aware of this event.
>>>
>>> Could you suggest me a solution to this? Are there any low level
>>> settings/configuration which would make bluetoothd automatically
>>> reconnect to the BLE device if it receives an ADV_DIRECT_IND?
>>
>> the kernel will auto-connect that device if it is in its auto-connect list. I think there are options via D-Bus to enable the auto-connect feature for certain devices.
>
> The applications needs to register itself with RegisterApplication and
> have a matching GattProfile in order for bluetoothd to add a device to
> the auto-connect list:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt
>
> Note, if device.Disconnect is called it will remove the device from
> the auto-connect list, in that case device.Connect has to be called
> manually in order to add the device back.
>
>
>
> --
> Luiz Augusto von Dentz
