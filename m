Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225
 _request_firmware+0x329/0x890
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAd53p62-yeNc248c3aFjBExD9LmuGiAJ4BEC9gO_M_wKuXohQ@mail.gmail.com>
Date: Mon, 28 Aug 2017 16:17:37 +0200
Cc: Chris Murphy <chris@colorremedies.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <DA6048A2-E325-4CFA-A908-9534373E1B9B@holtmann.org>
References: <CAJCQCtSDo8NuRQuEa0vX2cw9jKiaDRQ0ypY5H+31pQCwWRUSbQ@mail.gmail.com>
 <CAAd53p62-yeNc248c3aFjBExD9LmuGiAJ4BEC9gO_M_wKuXohQ@mail.gmail.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kai-Heng,

>> Found this thread google searching.
>> 
>> 
>> 4.13.0-0.rc4.git1.1.fc27.x86_64  Problem sometimes happens with this kernel.
>> This translates to git 623ce3456671.
>> 
>> 4.13.0-0.rc3.git0.1.fc27.x86_64 But not this kernel, which translates
>> to the actual rc3 release (clean).
>> 
>> It seems to be a regression between those two. The problem only
>> happens when waking from suspend to RAM, but it doesn't always happen.
> 
> My theory is that if you request firmware when firmware_class is in
> cache mode consecutively, and the device is changed, you will hit this
> issue.
> Can you give this patch a try?
> 
> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> index bfbe1e154128..910dce498f53 100644
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -1177,6 +1177,9 @@ _request_firmware_prepare(struct firmware
> **firmware_p, const char *name,
> 
>        ret = fw_lookup_and_allocate_buf(name, &fw_cache, &buf, dbuf, size);
> 
> +       if (!firmware_enabled() && device && (ret == 0 || ret == 1))
> +               fw_add_devm_name(device, buf->fw_id);
> +
>        /*
>         * bind with 'buf' now to avoid warning in failure path
>         * of requesting firmware.

if a fix in firmware_class can handle this, then I assume we also do not need all the per driver / hardware workarounds for firmware caching? Or are these other patches also needed?

Regards

Marcel

