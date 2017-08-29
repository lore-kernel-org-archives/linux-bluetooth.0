Return-Path: <kai.heng.feng@canonical.com>
MIME-Version: 1.0
In-Reply-To: <DA6048A2-E325-4CFA-A908-9534373E1B9B@holtmann.org>
References: <CAJCQCtSDo8NuRQuEa0vX2cw9jKiaDRQ0ypY5H+31pQCwWRUSbQ@mail.gmail.com>
 <CAAd53p62-yeNc248c3aFjBExD9LmuGiAJ4BEC9gO_M_wKuXohQ@mail.gmail.com> <DA6048A2-E325-4CFA-A908-9534373E1B9B@holtmann.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 29 Aug 2017 17:59:20 +0800
Message-ID: <CAAd53p7L0X5vnUcKRKjpBY+d1MULyUbzXkw_9DfEgsTEGKqXZA@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225 _request_firmware+0x329/0x890
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Chris Murphy <chris@colorremedies.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 28, 2017 at 10:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Kai-Heng,
>
>>
>> My theory is that if you request firmware when firmware_class is in
>> cache mode consecutively, and the device is changed, you will hit this
>> issue.
>> Can you give this patch a try?
>>
>> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
>> index bfbe1e154128..910dce498f53 100644
>> --- a/drivers/base/firmware_class.c
>> +++ b/drivers/base/firmware_class.c
>> @@ -1177,6 +1177,9 @@ _request_firmware_prepare(struct firmware
>> **firmware_p, const char *name,
>>
>>        ret = fw_lookup_and_allocate_buf(name, &fw_cache, &buf, dbuf, size);
>>
>> +       if (!firmware_enabled() && device && (ret == 0 || ret == 1))
>> +               fw_add_devm_name(device, buf->fw_id);
>> +
>>        /*
>>         * bind with 'buf' now to avoid warning in failure path
>>         * of requesting firmware.
>
> if a fix in firmware_class can handle this, then I assume we also do not need all the per driver / hardware workarounds for firmware caching? Or are these other patches also needed?

There are two issues:
The first one, which can be quite easily to reproduce after a warm
boot, is similar to this one.

The driver checks the update status of the device which is always on
during reboot, finds that it's already updated hence no need for
firmware, happily ends the setup function after that.
In this case, request_firmware() never gets called, so firmware_class
doesn't know the firmware is required for caching.
My patches for btusb.c/ath3k.c is to address this issue.
I just find out that btusb_setup_intel_new() also skips calling
request_firmware(), so I should send new patches to address the issue.


The second case [1], which is a corner case, is found when I ran some
stress tests for the first case. The scenario is like this:
1. The driver called request_firmware(). firmware_request() calls
fw_add_devm_name() to add the firmware name to device's revres.
2. After system suspends/resumes, the device might be treated as a new device.
3. request_firmware() can find the firmware because it's in the cache.
But fw_add_devm_name() for the new 'device' is not being called.
4. The second time system suspends, the firmware will not be cached
because the firmware name is not in the devres list anymore.
5. The system resumes, request_firmware() cannot find firmware in the
cache, hit the WARN_ON.

So these two patches are for separate issues.

[1] https://lkml.org/lkml/2017/8/22/123

>
> Regards
>
> Marcel
>
