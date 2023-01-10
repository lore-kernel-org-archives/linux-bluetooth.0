Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D7CC54EBE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 20:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjAJULZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 15:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjAJUKt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 15:10:49 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F611800
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 12:10:48 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bu8so20211379lfb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 12:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0R/LBfFE0HSvHDrU1k/2RiBYzLnn4RzijPsdnOhv98k=;
        b=pLubp87QQsPouUgGIKfMDimKvLLVTsFfcqjzsQpXXETO8vVL5desv4UrZSSmmNZIol
         4ThJkMahjAQIWWeP9u7jeAo6VCrLc55eupdgbDMaNF7aahL1y7qFE7rnjsxcqfmgcSAp
         atAWtgDl8WuCG6dVUXp9ODGZvrvEI2Y5LVaUJHsplpgQT0RvW9QeWjF90O3Bk8tPdzs+
         1GzMtYDVe2bT1S6J7xz2W927LhYnNNUhOkhNtTu6kAtB/wWyjl/TJ0nk9KWfUmd+fOTY
         M/l83DMPzonQKE8smUnlyR+tIorS+4z2d5VykXlXRMXkzHDWWqtkStGDxPyPYVHkKVqd
         z5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0R/LBfFE0HSvHDrU1k/2RiBYzLnn4RzijPsdnOhv98k=;
        b=3B2DJcVhynVBN5WXk33bWWFT00LsC7eHwIad9ZqYQu5i49ZLUskn4qsY5d6Kpjys1U
         btqehY8LBgDS4BaAY1a766aC2zmkspH1SwJNipuyxaCNKhHwtmW8/AKV+7xx7Rqo0ku+
         /eQp/UYwXL+/IgWAEncR4LsX9Mvk2ztUmEQo3UZjzN9NDaTcGvSXp4VQuW8haJpTnJRD
         1YWqppxZRVgbJ+88spBTZzGXK8c6MPKPbLXmG0akLVvxTIzoAwHLYGB4eBhEXpMsXF8H
         XKGIKjjlRGLdmqYpFgrBhE+h/x5sS+15F846etJUwsLx1X3AQ/lEaaWGMbwJoYHTmawO
         1c/w==
X-Gm-Message-State: AFqh2kpNyaMjLCJ3ctvpf78nW3RGnzzKrRyhlpYNzThJYUeVtynAFebH
        Kn8LTdkwJdJx0UK+wLwtOPyTZNRfZ8MOTKC4uB4=
X-Google-Smtp-Source: AMrXdXtIUh84tjHvYF7PwalTuRL+77Ae2YOvDR8Q4HKiYRlU0FeNdkYSI5119QMxz6cZra5Ovra+crlXdv7kUjMIK1U=
X-Received: by 2002:a05:6512:2617:b0:4cb:5a1:2bde with SMTP id
 bt23-20020a056512261700b004cb05a12bdemr4377284lfb.57.1673381446723; Tue, 10
 Jan 2023 12:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20230110155905.18203-1-kiran.k@intel.com>
In-Reply-To: <20230110155905.18203-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Jan 2023 12:10:37 -0800
Message-ID: <CABBYNZLr6=OT93Znf7F92Ds9DEOBM9NLynyk4TadZQ1ueiRK7A@mail.gmail.com>
Subject: Re: [PATCH v1] btintel: Add recovery when secure verification of
 firmware fails
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Tue, Jan 10, 2023 at 7:52 AM Kiran K <kiran.k@intel.com> wrote:
>
> On warm reboot stress test case, firmware download failure
> has been observed with failure in secure verification of firmware
> and BT becomes completely inaccessible. This can happen due to a race
> condition in TOP registers when Wifi driver is also getting loaded
> at the same time. This patch adds a work around to load the BT firmware
> again when secure verify failure is observed.

In other words we can't trust the controller will be able to verify
the firmware?

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 20 ++++++++++++++++----
>  drivers/bluetooth/btintel.h |  1 +
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index d4e2cb9a4eb4..3f2976fb056a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1700,6 +1700,11 @@ static int btintel_download_wait(struct hci_dev *hdev, ktime_t calltime, int mse
>                 return -ETIMEDOUT;
>         }
>
> +       if (btintel_test_flag(hdev, INTEL_FIRMWARE_VERIFY_FAILED)) {
> +               bt_dev_err(hdev, "Firmware secure verification failed");
> +               return -EAGAIN;
> +       }
> +
>         if (btintel_test_flag(hdev, INTEL_FIRMWARE_FAILED)) {
>                 bt_dev_err(hdev, "Firmware loading failed");
>                 return -ENOEXEC;
> @@ -1961,7 +1966,7 @@ static int btintel_download_fw(struct hci_dev *hdev,
>          * of this device.
>          */
>         err = btintel_download_wait(hdev, calltime, 5000);
> -       if (err == -ETIMEDOUT)
> +       if (err == -ETIMEDOUT || err == -EAGAIN)
>                 btintel_reset_to_bootloader(hdev);
>
>  done:
> @@ -2153,7 +2158,7 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
>          * of this device.
>          */
>         err = btintel_download_wait(hdev, calltime, 5000);
> -       if (err == -ETIMEDOUT)
> +       if (err == -ETIMEDOUT || err == -EAGAIN)
>                 btintel_reset_to_bootloader(hdev);
>
>  done:
> @@ -2644,8 +2649,15 @@ void btintel_secure_send_result(struct hci_dev *hdev,
>         if (len != sizeof(*evt))
>                 return;
>
> -       if (evt->result)
> -               btintel_set_flag(hdev, INTEL_FIRMWARE_FAILED);
> +       if (evt->result) {
> +               bt_dev_err(hdev, "Intel Secure Send Results event result: %u status: %u",
> +                          evt->result, evt->status);
> +
> +               if (evt->result == 3)
> +                       btintel_set_flag(hdev, INTEL_FIRMWARE_VERIFY_FAILED);

The result 3 is what exactly? If it returns the same value for both
the race condition and when the firmware is actually invalid that
means the later will cause a look since we don't have any counter of
how many times we would be attempting to reload the firmware, so we
better limit the number of times we attempt to reload e.g. 1-2 times
at most, or we have the firmware provide a different result when it
busy loading the wifi side.

> +               else
> +                       btintel_set_flag(hdev, INTEL_FIRMWARE_FAILED);
> +       }
>
>         if (btintel_test_and_clear_flag(hdev, INTEL_DOWNLOADING) &&
>             btintel_test_flag(hdev, INTEL_FIRMWARE_LOADED))
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index e0060e58573c..10e5be7e451a 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -147,6 +147,7 @@ enum {
>         INTEL_BOOTLOADER,
>         INTEL_DOWNLOADING,
>         INTEL_FIRMWARE_LOADED,
> +       INTEL_FIRMWARE_VERIFY_FAILED,
>         INTEL_FIRMWARE_FAILED,
>         INTEL_BOOTING,
>         INTEL_BROKEN_INITIAL_NCMD,
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
