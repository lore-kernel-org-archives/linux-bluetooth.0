Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <345ED8A3-63AC-4F6A-8D42-D1CCA6532D97@holtmann.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
 <1376089954-13639-4-git-send-email-andre.guedes@openbossa.org>
 <FE070485-AC61-4229-851F-9537CA50AB99@holtmann.org> <CACJA=fVmvqJu0YxfAZ9A8a-08z6NUvT-J97O3db9ii0vQVKsFg@mail.gmail.com>
 <345ED8A3-63AC-4F6A-8D42-D1CCA6532D97@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Thu, 22 Aug 2013 17:01:55 -0300
Message-ID: <CACJA=fW-QnfkGkkUvrTS4z7t0+2ziQFYhgAoxBC9KLVrCSUAbA@mail.gmail.com>
Subject: Re: [PATCH 3/6] Bluetooth: Set discovery parameters
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Aug 21, 2013 at 7:56 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>>>> This patch adds support for setting discovery parameters through
>>>> debugfs filesystem.
>>>>
>>>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>>>> ---
>>>> net/bluetooth/hci_sysfs.c | 45 +++++++++++++++++++++++++++++++++++++++=
+++++-
>>>> 1 file changed, 44 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
>>>> index 90cb53b..17ebc4a 100644
>>>> --- a/net/bluetooth/hci_sysfs.c
>>>> +++ b/net/bluetooth/hci_sysfs.c
>>>> @@ -553,9 +553,52 @@ static int discovery_parameters_open(struct inode=
 *inode, struct file *file)
>>>>      return single_open(file, discovery_parameters_show, inode->i_priv=
ate);
>>>> }
>>>>
>>>> +static ssize_t discovery_parameters_write(struct file *file,
>>>> +                                       const char __user *data,
>>>> +                                       size_t count, loff_t *offset)
>>>> +{
>>>> +     struct seq_file *sfile =3D file->private_data;
>>>> +     struct hci_dev *hdev =3D sfile->private;
>>>> +     struct discovery_param param;
>>>> +     char *buf;
>>>> +     int n;
>>>> +     ssize_t res =3D 0;
>>>> +
>>>> +     /* We don't allow partial writes */
>>>> +     if (*offset !=3D 0)
>>>> +             return 0;
>>>> +
>>>> +     buf =3D kzalloc(count, GFP_KERNEL);
>>>> +     if (!buf)
>>>> +             return 0;
>>>> +
>>>> +     if (copy_from_user(buf, data, count))
>>>> +             goto out;
>>>> +
>>>> +     memset(&param, 0, sizeof(param));
>>>> +
>>>> +     n =3D sscanf(buf, "%hhx %hx %hx %u %u %hhx %hhx",
>>>> +                &param.scan_type, &param.scan_interval, &param.scan_w=
indow,
>>>> +                &param.le_scan_duration, &param.interleaved_scan_dura=
tion,
>>>> +                &param.interleaved_inquiry_length,
>>>> +                &param.bredr_inquiry_length);
>>>
>>> I am not a huge fan of this crazy. I need a manual to know exactly what=
 to do here. That is just silly. Unless things are a bit self-explanatory o=
n how you can tweak things, I am not really interested here.
>>
>> What do you think about having the following hierarchy:
>>
>> hciX/
>> |
>> |--> discovery_param/
>> |     |--> scan_type
>> |     |--> scan_window
>> |     |--> scan_interval
>> |     |--> le_scan_timeout
>> |     |--> interleaved_scan_timeout
>> |     |--> interleaved_inquiry_length
>> |     |--> bredr_inquiry_length
>> |
>> |--> le_conn_param/
>>       |--> scan_window
>>       |--> scan_interval
>>       |--> min_conn_interval
>>       |--> max_conn_interval
>>       |--> min_ce_length
>>       |--> max_ce_length
>>       |--> supervision_timeout
>>       |--> conn_latency
>>
>> It sounds much self-explanatory to me.
>
> don't go crazy with the nesting here. Toplevel directory entries are just=
 fine. The one tricky part you will run into is that things like the scan_w=
indow for connections suppose to be per device and not just global. Since y=
ou can learn many of these parameters from AD or GATT. And when connecting =
to one specific device, you suppose to use these ones and not some global c=
ommon value.

Ok, so I'll place them all in hciX/ and add the prefix "discov_" for
the discovery files and "le_conn_" for the LE connection ones.

About scan_window and scan_interval parameters, you are right, they
are supposed to be per device. That feature should be addressed in the
new LE connection approach we've discussed a while ago (which, BTW, I
already started the implementation). These exported parameters, on the
other hand, are the default values the kernel uses in case specific
parameters were not set for a given device.

The idea behind exporting LE connection parameters via debugfs is to
facilitate the implementation of experiments. Today the parameters are
hard coded in kernel and we have to recompile it each time we want
experiment new values. IMO, we should export scan_window and
scan_interval since they are very useful for running experiments.

>>> Also intermixing LE with BR/EDR is a bit pointless here. I would prefer=
 if they are separate and not that BR/EDR only controller exports LE knobs =
and and LE only controller exports BR/EDR knobs.
>>
>> Sure. I'll fix this in the v2 patchset. We can also extend this to
>> others debugfs entries (e.g. inquiry_cache and auto_accept_delay files
>> should not be exported if controller is LE-only).
>
> Of course they should be separated.

I'll fix it.

>> In the current code, hdev is exported during device registration
>> (hci_register_dev). However, in hci_register_dev(), hdev has not been
>> initialized yet so we are not able to know is controller is BR/EDR, LE
>> or dual mode. In order to fix this, we need to postpone exporting hdev
>> by moving hci_add_sysfs call from hci_register_dev() to
>> hci_dev_open().
>>
>> As a side effect, the hciX/ directory will be added to debugfs once
>> the adapter is powered on and it will be removed once the adapter is
>> powered off. Do you see any problem with that?
>
> That is not acceptable and also not how the kernel actually works. We are=
 initializing the adapter no matter what. So the information is available b=
efore power on.

Fair enough, let's forget about this approach.

I just realized we can fix this by exporting BR/EDR and LE specific
information once hdev is initialized. All we need to do is checking if
HCI_SETUP flag is set just after __hci_init call in hci_open_dev().

Thanks for your feedback,

Andre
