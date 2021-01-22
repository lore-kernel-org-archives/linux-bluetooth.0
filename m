Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D7C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 02:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64AC223C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 02:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbhAVCZk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jan 2021 21:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhAVCZh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jan 2021 21:25:37 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B78C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 18:24:57 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 186so2226528vsz.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 18:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAhkXR3v/Trmg98rGb282YEmEKWvpDJKR5OuaxfB1LU=;
        b=favjwhbGx3cxHQQ1FjgoCMzHl6Icuq/kfdcJ/JMLXT0e783mb1Hi3KQKC/p69oQjpQ
         YDAhnyijcUL0oN68cufZr2uHr4Mv/XJaUo6Y6/cOoAWLkNchUc/hFVNjosrZqk/toala
         0qRC037nk9trBeKYUokbtdlmkhmXldKOAYSM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAhkXR3v/Trmg98rGb282YEmEKWvpDJKR5OuaxfB1LU=;
        b=Wv9web9Ab/NQnsWuftWtdo+l+vkg6puPjGMLeeWXWDDLlagWdCY3jnExEYH4+3Y01s
         skHL/potZmDjN7PMWJLCL8ZX10FmMRLflxe4YaM7i5TgitB8Fn3muSsMSmXieuQp4/sv
         CWAVIOH/s5p1MBQC3P0spr02evqBifmeIOtYzs9NWMBBQIOZuG59LMQn+J4HZuHvcpIa
         7DsxRyzptqgUTb9O0/LRPOW8XSZX8DqZG64kMS/mxVIsQls6WLBj9n9zPePYEMEa6UTd
         RWFkzjY6/hYi4c6Ki+nFzdNxRXz+3thEEpgY0hmy54uCarDLV6O5n9lROeYKIwfahgcj
         4zxQ==
X-Gm-Message-State: AOAM5337huxrLWLfFCafOf0yBpQiyv7uoVKIwBlXut/0EXpSGcOiKEjj
        FKF0vTkulITt5nO+R5xKSZDxvsWLbfVBeHOGmpZkN0UmEMI=
X-Google-Smtp-Source: ABdhPJy3N81AwAeHgosVgfd1HSZoRdxFSTyOEeOQQu+1V7AqchmE9OiuddnrJRg/M54GiyEhjtpx2uPSU/7YgrO3B5I=
X-Received: by 2002:a67:e353:: with SMTP id s19mr358563vsm.53.1611282296505;
 Thu, 21 Jan 2021 18:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20210122015938.964-1-max.chou@realtek.com>
In-Reply-To: <20210122015938.964-1-max.chou@realtek.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 21 Jan 2021 18:24:43 -0800
Message-ID: <CANFp7mWj+7Gq9hYUZodBaqyK-M0NSFLXEtvOVmPbT175vTm9zg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btrtl: Enable WBS for the specific Realtek devices
To:     max.chou@realtek.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Lu <alex_lu@realsil.com.cn>, hildawu@realtek.com,
        kidman@realtek.com, Shyh-In Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Max. Patch v3 looks good to me.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

On Thu, Jan 21, 2021 at 5:59 PM <max.chou@realtek.com> wrote:
>
> From: Max Chou <max.chou@realtek.com>
>
> By this change, it will enable WBS supported on the specific Realtek BT
> devices, such as RTL8822C and RTL8852A.
> In the future, it's able to maintain what the Realtek devices support WBS
> here.
>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Max Chou <max.chou@realtek.com>
>
> ---
> change in v3
>  -remove the null check due to unnecessary
> ---
>  drivers/bluetooth/btrtl.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 24f03a1f8d57..a21d6abc93c4 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -38,6 +38,19 @@
>         .hci_ver = (hciv), \
>         .hci_bus = (bus)
>
> +enum  btrtl_chip_id {
> +       CHIP_ID_8723A,          /* index  0 for RTL8723A*/
> +       CHIP_ID_8723B,          /* index  1 for RTL8723B*/
> +       CHIP_ID_8821A,          /* index  2 for RTL8821A*/
> +       CHIP_ID_8761A,          /* index  3 for RTL8761A*/
> +       CHIP_ID_8822B = 8,      /* index  8 for RTL8822B */
> +       CHIP_ID_8723D,          /* index  9 for RTL8723D */
> +       CHIP_ID_8821C,          /* index 10 for RTL8821C */
> +       CHIP_ID_8822C = 13,     /* index 13 for RTL8822C */
> +       CHIP_ID_8761B,          /* index 14 for RTL8761B */
> +       CHIP_ID_8852A = 18,     /* index 18 for RTL8852A */
> +};
> +
>  struct id_table {
>         __u16 match_flags;
>         __u16 lmp_subver;
> @@ -58,6 +71,7 @@ struct btrtl_device_info {
>         u8 *cfg_data;
>         int cfg_len;
>         bool drop_fw;
> +       int project_id;
>  };
>
>  static const struct id_table ic_id_table[] = {
> @@ -307,8 +321,10 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>
>         /* Find project_id in table */
>         for (i = 0; i < ARRAY_SIZE(project_id_to_lmp_subver); i++) {
> -               if (project_id == project_id_to_lmp_subver[i].id)
> +               if (project_id == project_id_to_lmp_subver[i].id) {
> +                       btrtl_dev->project_id = project_id;
>                         break;
> +               }
>         }
>
>         if (i >= ARRAY_SIZE(project_id_to_lmp_subver)) {
> @@ -719,18 +735,19 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
>          */
>         set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>
> -       if (!btrtl_dev->ic_info)
> -               goto done;
> -
>         /* Enable central-peripheral role (able to create new connections with
>          * an existing connection in slave role).
>          */
> -       switch (btrtl_dev->ic_info->lmp_subver) {
> -       case RTL_ROM_LMP_8822B:
> +       /* Enable WBS supported for the specific Realtek devices. */
> +       switch (btrtl_dev->project_id) {
> +       case CHIP_ID_8822C:
> +       case CHIP_ID_8852A:
>                 set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +               set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>                 break;
>         default:
>                 rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
> +               rtl_dev_dbg(hdev, "WBS supported not enabled.");
>                 break;
>         }
>
> --
> 2.17.1
>
