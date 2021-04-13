Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2996FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 22:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F338961220
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 22:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhDMWCe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhDMWCe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 18:02:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2662C061574;
        Tue, 13 Apr 2021 15:02:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so11655351oti.9;
        Tue, 13 Apr 2021 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ybh5lMw7ytGMB8oywa2weGNquC0EMKd0LjMJhApjhWQ=;
        b=XJTKyoPdziE6mvXs45eB3BdWFVMq+5QRU7J3/0Ce5HWUpahyu9FHrYtNXqXP7Nqi/o
         YQ6tZtPXhYN11qnEDxPj0YmDyyjy6+BcXt2tPv5ghYVTN8V0XhgbB3MZ3s8QtaWsTdnP
         UXVajDmwngKOZNUCsatw+3e1SUK8+JCgkTQiZTnCExXBwvJ4UU58zFfmdUXcr6FiqLcf
         mg30Pye8p77WhOix8HAu3zTAAMT8OnQDQdSt/DuJ3wLGqtAUYL3JJlACbZPlEh25VMu1
         U8PK6HgjQGU4PWNX0jSCYyAC6eluUN/34AO3qV0YLaQ3hnEStvBZ2v+mpDtj9GWS3US0
         3AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ybh5lMw7ytGMB8oywa2weGNquC0EMKd0LjMJhApjhWQ=;
        b=rAWiwxAnHoqBr7FgZZ9RebjBaqSdY2NjNLoNycdwtuqUBwT7GhWHTNTo4quMkl7Rxh
         cwVmDXaA9Mj/R8GAM1Iesb82NgX+Zn7ZZ4MVuQ5nYDLy98wLUGE1bCOr9OBwMFG+4CxL
         Xmp2f+/VcCbVS6n3KVzur39XWZO/32S6Ntf/NOm3528lDiL8Swyqw8rErvFFsSnUU3tK
         tqRk2DEWFwx5EVOP0DYGyLQQOPokscxm/vFAjKmC66wNe2TSvGIhjUlM38m+SPvb+rK8
         ZITjgg394i5Iezl9P+WgZcMOWAcI96JmHfLQz0iXgNoQ1/IfRwvNuuyCxVnMjPhhL/so
         SI4A==
X-Gm-Message-State: AOAM533Ow4VP0JWyfpwLnI7MwLUe5vP5+OEU7q/mhEqmN2clFNOyH6ml
        1F4cxmS5+eRO2Cn7kHo/6fXF+p5shqRiKhQoy44HaUZKjhk=
X-Google-Smtp-Source: ABdhPJzi6C3xrMFS1nf5KDGcNG0bfKfli9L044rPA0XCoyZmh/015zLbLLrlyNr146ZGH2CX5MR7aSCJXuocnpmNWrQ=
X-Received: by 2002:a9d:63d0:: with SMTP id e16mr14391797otl.44.1618351333277;
 Tue, 13 Apr 2021 15:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210413074521.264802-1-josephsih@chromium.org>
In-Reply-To: <20210413074521.264802-1-josephsih@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Apr 2021 15:02:02 -0700
Message-ID: <CABBYNZKv2fdOR2GxvNMiTFByzB4m1Ljbb-X-Wxeyqmyt=x6S8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: support link statistics
 telemetry events
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Tue, Apr 13, 2021 at 12:45 AM Joseph Hwang <josephsih@chromium.org> wrote:
>
> From: Chethan T N <chethan.tumkur.narayan@intel.com>
>
> This patch supports the link statistics telemetry events for
> Intel controllers
>
> To avoid the overhead, this debug feature is disabled by default.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
>
> Changes in v2:
> - take care of intel_newgen as well as intel_new
> - fix the long-line issue
>
>  drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
>  drivers/bluetooth/btusb.c   | 18 ------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e44b6993cf91..de1dbdc01e5a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1248,8 +1248,10 @@ EXPORT_SYMBOL_GPL(btintel_read_debug_features);
>  int btintel_set_debug_features(struct hci_dev *hdev,
>                                const struct intel_debug_features *features)
>  {
> -       u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
> +       u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
>                         0x00, 0x00, 0x00 };
> +       u8 period[5] = { 0x04, 0x91, 0x02, 0x01, 0x00 };
> +       u8 trace_enable = 0x02;
>         struct sk_buff *skb;

Instead of using a byte array and custo opcode I would recommend we
start adding proper defines for Intel vendor opcodes with structs for
them, similar opcodes and structs are also very useful for adding
support for btmon, in fact I would start with btmon first and only
when we have proper decoding support start changing the kernel parts
so you can actually add btmon output to the patch description here.

>         if (!features)
> @@ -1266,8 +1268,24 @@ int btintel_set_debug_features(struct hci_dev *hdev,
>                            PTR_ERR(skb));
>                 return PTR_ERR(skb);
>         }
> +       kfree_skb(skb);
> +
> +       skb = __hci_cmd_sync(hdev, 0xfc8b, 5, period, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Setting periodicity for link statistics traces failed (%ld)",
> +                          PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +       kfree_skb(skb);
>
> +       skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Enable tracing of link statistics events failed (%ld)",
> +                          PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
>         kfree_skb(skb);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(btintel_set_debug_features);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 192cb8c191bc..f29946f15f59 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2811,7 +2811,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>         u32 boot_param;
>         char ddcname[64];
>         int err;
> -       struct intel_debug_features features;
>
>         BT_DBG("%s", hdev->name);
>
> @@ -2865,14 +2864,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>                 btintel_load_ddc_config(hdev, ddcname);
>         }
>
> -       /* Read the Intel supported features and if new exception formats
> -        * supported, need to load the additional DDC config to enable.
> -        */
> -       btintel_read_debug_features(hdev, &features);
> -
> -       /* Set DDC mask for available debug features */
> -       btintel_set_debug_features(hdev, &features);
> -
>         /* Read the Intel version information after loading the FW  */
>         err = btintel_read_version(hdev, &ver);
>         if (err)
> @@ -2911,7 +2902,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
>         u32 boot_param;
>         char ddcname[64];
>         int err;
> -       struct intel_debug_features features;
>         struct intel_version_tlv version;
>
>         bt_dev_dbg(hdev, "");
> @@ -2961,14 +2951,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
>          */
>         btintel_load_ddc_config(hdev, ddcname);
>
> -       /* Read the Intel supported features and if new exception formats
> -        * supported, need to load the additional DDC config to enable.
> -        */
> -       btintel_read_debug_features(hdev, &features);
> -
> -       /* Set DDC mask for available debug features */
> -       btintel_set_debug_features(hdev, &features);
> -
>         /* Read the Intel version information after loading the FW  */
>         err = btintel_read_version_tlv(hdev, &version);
>         if (err)
> --
> 2.31.1.295.g9ea45b61b8-goog
>


-- 
Luiz Augusto von Dentz
