Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKuP3BwGTUt_t1h8XqrbXbt+RGzzTCKhxG-NvHSBStwuw@mail.gmail.com>
References: <1314006934-4953-1-git-send-email-dmitriy.paliy@nokia.com>
	<1314006934-4953-2-git-send-email-dmitriy.paliy@nokia.com>
	<CABBYNZKuP3BwGTUt_t1h8XqrbXbt+RGzzTCKhxG-NvHSBStwuw@mail.gmail.com>
Date: Mon, 22 Aug 2011 15:44:28 +0300
Message-ID: <CAHMBquVjum9xZHu4NGzNEpyDPVd0bHXgyBEBPtLvUa-Zq-Ec0g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] Fix remove temporary link key for No Bonding
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Aug 22, 2011 at 3:04 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Dmitriy,
>
> On Mon, Aug 22, 2011 at 12:55 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
>> This fixes regression caused by 33cdfcb0fabcfb5260953a13ae277b5abe9a322d.
>> Temporary link key should be removed after device is disconnected if
>> bonding information is not stored in file system.
>>
>> Currently, the key is deleted only when paired device is removed, or
>> adapter is powered off. In case of No Bonding authentication, device is
>> not paired after disconnection, which results in link key left in memory.
>>
>> On the other hand, device is not necessarily removed after disconnection
>> that also leaves unneeded temporary link key in memory.
>> ---
>>  src/device.c |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 9dd657c..f323bf8 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -855,8 +855,10 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
>>                device->disconnects = g_slist_remove(device->disconnects, msg);
>>        }
>>
>> -       if (device_is_paired(device) && !device_is_bonded(device))
>> +       if (device_is_paired(device) && !device_is_bonded(device)) {
>> +               btd_adapter_remove_bonding(device->adapter, &device->bdaddr);
>>                device_set_paired(device, FALSE);
>> +       }
>
> How about move btd_adapter_remove_bonding to device_set_paired e.g. if
> (!value) btd_adapter_remove_bonding?

Since btd_adapter_remove_bonding is used only together with
device_set_paired(device, FALSE), it makes sense code-wise. However,
downside is that one may start thinking that device_set_paired(device,
TRUE) creates bonding, which is not so. Therefore, it looks a bit
questionable.

I will submit new proposal.

Dmitriy
