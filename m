Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ5D56npnh0kvdFNMbP7AS0kYVWytxM9QkmZquNO2s5pg@mail.gmail.com>
References: <1314020739-15376-1-git-send-email-dmitriy.paliy@nokia.com>
	<1314020739-15376-2-git-send-email-dmitriy.paliy@nokia.com>
	<CABBYNZJ5D56npnh0kvdFNMbP7AS0kYVWytxM9QkmZquNO2s5pg@mail.gmail.com>
Date: Mon, 22 Aug 2011 17:06:24 +0300
Message-ID: <CAHMBquUoCRqO8z_dPKH0R38bRifh+VuLY-c0ZX_wG6-j056C-Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] Fix remove temporary link key for No Bonding
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Aug 22, 2011 at 5:02 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Dmitriy,
>
> On Mon, Aug 22, 2011 at 4:45 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
>> This fixes regression caused by 33cdfcb0fabcfb5260953a13ae277b5abe9a322d.
>> Temporary link key should be removed after device is disconnected if
>> bonding information is not stored in file system.
>>
>> Currently, the key is deleted only when paired device is removed, or
>> adapter is powered off. In case of No Bonding authentication, device is
>> not paired after disconnection, which results in link key left in memory.
>>
>> On the other hand, device is not necessarily removed after disconnection
>> that also leaves unneeded temporary link key in memory. Therefore,
>> btd_adapter_remove_bonding is moved to device_set_paired(device, FALSE)
>> covering both cases.
>> ---
>>  src/device.c |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 9dd657c..96e798f 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -993,7 +993,6 @@ static void device_remove_stored(struct btd_device *device)
>>                delete_entry(&src, "aliases", addr);
>>                device_set_bonded(device, FALSE);
>>                device_set_paired(device, FALSE);
>> -               btd_adapter_remove_bonding(device->adapter, &device->bdaddr);
>>        }
>>        delete_entry(&src, "profiles", addr);
>>        delete_entry(&src, "trusts", addr);
>> @@ -2038,6 +2037,9 @@ void device_set_paired(struct btd_device *device, gboolean value)
>>        if (device->paired == value)
>>                return;
>>
>> +       if (!value)
>> +               btd_adapter_remove_bonding(device->adapter, &device->bdaddr);
>> +
>>        device->paired = value;
>>
>>        emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Paired",
>> --
>> 1.7.4.1
>
> There is one more place where we use btd_adapter_remove_bonding see
> device_remove_stored.

Yes, I removed it from there, since it is in device_set_paired. Could
you elaborate more?

Dmitriy
