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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A662C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489EF60FED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 18:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhHLSAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhHLSAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 14:00:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE47C0613D9;
        Thu, 12 Aug 2021 10:59:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k11so13419043ybf.6;
        Thu, 12 Aug 2021 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnuUAU/QTfJ5Th8agjt5w1+nhW9QiiYUW0wxJH/GzBU=;
        b=tFe1jyp+RK6ctD3P+R+SeRWA42UZ6gsmO/xzsFmNsJnDQ3K8fK78FxD4HxweylsV6H
         97xBsATgnEIIXp1XxxVKuSJoeWvnRvJhdH/YJsMfu/y19K2b+P0dZHgxC68+BWols8dP
         hdKEAQc5lBH5IV5kiorXNgrL6GtCMjju/PkBlSc9Om4RPY89ZZG0dvjmP7HT0jMlXWfh
         +/tflf8Tjf53wqXd8EgfdVBpadOgy/97VuAGAcjFt8jTOAOfVFh77yTjuB7BWjhxDIF6
         EAW5wxmTdi5AiuAxau1tzNyumHLIRBl6DTaWMm3chvk/PVMb32wXh9Kz1WG+A9da7ZKp
         p2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnuUAU/QTfJ5Th8agjt5w1+nhW9QiiYUW0wxJH/GzBU=;
        b=GdjuDUgcAI8OWfnHm627sY9JHu8L6QGZD/xJdpEd3BYT0rn3A9IkdDwljMKuugBSJi
         mLAjKVILnj/JspdG4d0vQOKIspK2anEPscTNB1wPNum4juNgPbYTsYrP1NNog8bB5kXC
         9x3FzPHiSHTAIEsFlDrK/o+rwca8G/dKFbmANHi8QM1fQIRdcglBcYP9NqjjWI5r9uvq
         3gey+N3zGaGlvxIjes7ZaW1XypFDIxRZLO2XLl2lMva+dn8aPpq8Ir78XeXxY7ro20TD
         Rexb7BUihCIhmChLimHPJNpt2NK4XXkYgB8ThBwtH88EFsi4iWJu52f1Np4keXOWYALN
         WT5g==
X-Gm-Message-State: AOAM53310o8aShT9pyFosRR54YtRFXzJ+EZOC1Pjh1dcFwhoqhZdPh52
        pM184fQ1vKrriDepQTH/CgkFMRULfVDycGtg0fg=
X-Google-Smtp-Source: ABdhPJzwadAgsGCCMz+o4oViNV5UnhTlsbjAjCK0S5Xmt/j+bFV/f72dqYPJ9NfCZla93pkGGkpY6+OL2M2rVwF31t0=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr6532628ybu.282.1628791198089;
 Thu, 12 Aug 2021 10:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210812171533.v7.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
 <20210812171533.v7.3.I50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid>
In-Reply-To: <20210812171533.v7.3.I50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 12 Aug 2021 10:59:46 -0700
Message-ID: <CABBYNZJKaFmoNAOOXROSNGtpqLtuaXDs7Fq_LjR8--Cmu38Zjw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] Bluetooth: set quality report callback for Intel
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Thu, Aug 12, 2021 at 2:16 AM Joseph Hwang <josephsih@chromium.org> wrote:
>
> This patch sets up set_quality_report callback for Intel to
> set and reset the debug features.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
>
> Changes in v7:
> - Rebase on Tedd's patches that moved functionality from btusb to
>   btintel.
>
> Changes in v5:
> - Removed CONFIG_BT_FEATURE_QUALITY_REPORT since there was no
>   large size impact.
>
>  drivers/bluetooth/btintel.c | 81 ++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel.h |  6 +++
>  2 files changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 643e2194ca01..611c3ea5425f 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1291,8 +1291,10 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
>         u8 trace_enable = 0x02;
>         struct sk_buff *skb;
>
> -       if (!features)
> +       if (!features) {
> +               bt_dev_warn(hdev, "Debug features not read");
>                 return -EINVAL;
> +       }
>
>         if (!(features->page1[0] & 0x3f)) {
>                 bt_dev_info(hdev, "Telemetry exception format not supported");
> @@ -1323,9 +1325,77 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
>         }
>         kfree_skb(skb);
>
> +       bt_dev_info(hdev, "set debug features: trace_enable 0x%02x mask 0x%02x",
> +                   trace_enable, mask[3]);
> +
>         return 0;
>  }
>
> +static int btintel_reset_debug_features(struct hci_dev *hdev,
> +                                const struct intel_debug_features *features)
> +{
> +       u8 mask[11] = { 0x0a, 0x92, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                       0x00, 0x00, 0x00 };
> +       u8 trace_enable = 0x00;
> +       struct sk_buff *skb;
> +
> +       if (!features) {
> +               bt_dev_warn(hdev, "Debug features not read");
> +               return -EINVAL;
> +       }
> +
> +       if (!(features->page1[0] & 0x3f)) {
> +               bt_dev_info(hdev, "Telemetry exception format not supported");
> +               return 0;
> +       }
> +
> +       /* Should stop the trace before writing ddc event mask. */
> +       skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Stop tracing of link statistics events failed (%ld)",
> +                          PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +       kfree_skb(skb);
> +
> +       skb = __hci_cmd_sync(hdev, 0xfc8b, 11, mask, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Setting Intel telemetry ddc write event mask failed (%ld)",
> +                          PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +       kfree_skb(skb);
> +
> +       bt_dev_info(hdev, "reset debug features: trace_enable 0x%02x mask 0x%02x",
> +                   trace_enable, mask[3]);
> +
> +       return 0;
> +}
> +
> +int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
> +{
> +       struct intel_debug_features features;
> +       int err;
> +
> +       bt_dev_dbg(hdev, "enable %d", enable);
> +
> +       /* Read the Intel supported features and if new exception formats
> +        * supported, need to load the additional DDC config to enable.
> +        */
> +       err = btintel_read_debug_features(hdev, &features);
> +       if (err)
> +               return err;
> +
> +       /* Set or reset the debug features. */
> +       if (enable)
> +               err = btintel_set_debug_features(hdev, &features);
> +       else
> +               err = btintel_reset_debug_features(hdev, &features);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(btintel_set_quality_report);
> +
>  static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
>                                                struct intel_version *ver)
>  {
> @@ -1951,6 +2021,9 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
>                 btintel_load_ddc_config(hdev, ddcname);
>         }
>
> +       hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
> +       bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");

I would remove such debugs since I don't think they have any value
here, besides it doesn't seem HCI_QUALITY_REPORT is ever set anyway
which perhaps should be done by the core itself after calling the
callback.

>         /* Read the Intel version information after loading the FW  */
>         err = btintel_read_version(hdev, &new_ver);
>         if (err)
> @@ -2132,6 +2205,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>          */
>         btintel_load_ddc_config(hdev, ddcname);
>
> +       hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
> +       bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");

Ditto.

>         /* Read the Intel version information after loading the FW  */
>         err = btintel_read_version_tlv(hdev, &new_ver);
>         if (err)
> @@ -2230,6 +2306,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>         set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>         set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
>
> +       /* Set up the quality report callback for Intel devices */
> +       hdev->set_quality_report = btintel_set_quality_report;
> +
>         /* For Legacy device, check the HW platform value and size */
>         if (skb->len == sizeof(ver) && skb->data[1] == 0x37) {
>                 bt_dev_dbg(hdev, "Read the legacy Intel version information");
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index aa64072bbe68..fe02cb9ac96c 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -204,6 +204,7 @@ int btintel_configure_setup(struct hci_dev *hdev);
>  void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
>  void btintel_secure_send_result(struct hci_dev *hdev,
>                                 const void *ptr, unsigned int len);
> +int btintel_set_quality_report(struct hci_dev *hdev, bool enable);
>  #else
>
>  static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> @@ -294,4 +295,9 @@ static inline void btintel_secure_send_result(struct hci_dev *hdev,
>                                 const void *ptr, unsigned int len)
>  {
>  }
> +
> +static inline int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
> +{
> +       return -ENODEV;
> +}
>  #endif
> --
> 2.32.0.605.g8dce9f2422-goog
>


-- 
Luiz Augusto von Dentz
