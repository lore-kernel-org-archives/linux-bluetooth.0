Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FE070485-AC61-4229-851F-9537CA50AB99@holtmann.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
	<1376089954-13639-4-git-send-email-andre.guedes@openbossa.org>
	<FE070485-AC61-4229-851F-9537CA50AB99@holtmann.org>
Date: Wed, 21 Aug 2013 17:41:19 -0300
Message-ID: <CACJA=fVmvqJu0YxfAZ9A8a-08z6NUvT-J97O3db9ii0vQVKsFg@mail.gmail.com>
Subject: Re: [PATCH 3/6] Bluetooth: Set discovery parameters
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Aug 10, 2013 at 1:09 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch adds support for setting discovery parameters through
>> debugfs filesystem.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_sysfs.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
>> index 90cb53b..17ebc4a 100644
>> --- a/net/bluetooth/hci_sysfs.c
>> +++ b/net/bluetooth/hci_sysfs.c
>> @@ -553,9 +553,52 @@ static int discovery_parameters_open(struct inode *inode, struct file *file)
>>       return single_open(file, discovery_parameters_show, inode->i_private);
>> }
>>
>> +static ssize_t discovery_parameters_write(struct file *file,
>> +                                       const char __user *data,
>> +                                       size_t count, loff_t *offset)
>> +{
>> +     struct seq_file *sfile = file->private_data;
>> +     struct hci_dev *hdev = sfile->private;
>> +     struct discovery_param param;
>> +     char *buf;
>> +     int n;
>> +     ssize_t res = 0;
>> +
>> +     /* We don't allow partial writes */
>> +     if (*offset != 0)
>> +             return 0;
>> +
>> +     buf = kzalloc(count, GFP_KERNEL);
>> +     if (!buf)
>> +             return 0;
>> +
>> +     if (copy_from_user(buf, data, count))
>> +             goto out;
>> +
>> +     memset(&param, 0, sizeof(param));
>> +
>> +     n = sscanf(buf, "%hhx %hx %hx %u %u %hhx %hhx",
>> +                &param.scan_type, &param.scan_interval, &param.scan_window,
>> +                &param.le_scan_duration, &param.interleaved_scan_duration,
>> +                &param.interleaved_inquiry_length,
>> +                &param.bredr_inquiry_length);
>
> I am not a huge fan of this crazy. I need a manual to know exactly what to do here. That is just silly. Unless things are a bit self-explanatory on how you can tweak things, I am not really interested here.

What do you think about having the following hierarchy:

hciX/
|
|--> discovery_param/
|	|--> scan_type
|	|--> scan_window
|	|--> scan_interval
|	|--> le_scan_timeout
|	|--> interleaved_scan_timeout
|	|--> interleaved_inquiry_length
|	|--> bredr_inquiry_length
|
|--> le_conn_param/
	|--> scan_window
	|--> scan_interval
	|--> min_conn_interval
	|--> max_conn_interval
	|--> min_ce_length
	|--> max_ce_length
	|--> supervision_timeout
	|--> conn_latency

It sounds much self-explanatory to me.

> Also intermixing LE with BR/EDR is a bit pointless here. I would prefer if they are separate and not that BR/EDR only controller exports LE knobs and and LE only controller exports BR/EDR knobs.

Sure. I'll fix this in the v2 patchset. We can also extend this to
others debugfs entries (e.g. inquiry_cache and auto_accept_delay files
should not be exported if controller is LE-only).

In the current code, hdev is exported during device registration
(hci_register_dev). However, in hci_register_dev(), hdev has not been
initialized yet so we are not able to know is controller is BR/EDR, LE
or dual mode. In order to fix this, we need to postpone exporting hdev
by moving hci_add_sysfs call from hci_register_dev() to
hci_dev_open().

As a side effect, the hciX/ directory will be added to debugfs once
the adapter is powered on and it will be removed once the adapter is
powered off. Do you see any problem with that?

BR,

Andre
