Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSDo8NuRQuEa0vX2cw9jKiaDRQ0ypY5H+31pQCwWRUSbQ@mail.gmail.com>
References: <CAJCQCtSDo8NuRQuEa0vX2cw9jKiaDRQ0ypY5H+31pQCwWRUSbQ@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 17 Aug 2017 17:28:01 +0800
Message-ID: <CAAd53p62-yeNc248c3aFjBExD9LmuGiAJ4BEC9gO_M_wKuXohQ@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225 _request_firmware+0x329/0x890
To: Chris Murphy <chris@colorremedies.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 16, 2017 at 11:26 PM, Chris Murphy <chris@colorremedies.com> wrote:
> Found this thread google searching.
>
>
> 4.13.0-0.rc4.git1.1.fc27.x86_64  Problem sometimes happens with this kernel.
> This translates to git 623ce3456671.
>
> 4.13.0-0.rc3.git0.1.fc27.x86_64 But not this kernel, which translates
> to the actual rc3 release (clean).
>
> It seems to be a regression between those two. The problem only
> happens when waking from suspend to RAM, but it doesn't always happen.

My theory is that if you request firmware when firmware_class is in
cache mode consecutively, and the device is changed, you will hit this
issue.
Can you give this patch a try?

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index bfbe1e154128..910dce498f53 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -1177,6 +1177,9 @@ _request_firmware_prepare(struct firmware
**firmware_p, const char *name,

        ret = fw_lookup_and_allocate_buf(name, &fw_cache, &buf, dbuf, size);

+       if (!firmware_enabled() && device && (ret == 0 || ret == 1))
+               fw_add_devm_name(device, buf->fw_id);
+
        /*
         * bind with 'buf' now to avoid warning in failure path
         * of requesting firmware.


>
>
>     Product Name: HP Spectre Notebook
>     SKU Number: W2K28UA#ABA
>
>
> dmesg, with bluetooth firmware warning and call trace only
> https://drive.google.com/open?id=0B_2Asp8DGjJ9eDFsbHNMelVzelE
>
> dmesg, normal boot
> https://drive.google.com/open?id=0B_2Asp8DGjJ9X3gzYTdTNE4ydm8
>
>
> --
> Chris Murphy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
