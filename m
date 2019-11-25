Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E8C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 18:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991C620748
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 18:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BKBQL8S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfKYSOR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:14:17 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43115 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfKYSOQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 13:14:16 -0500
Received: by mail-qv1-f68.google.com with SMTP id cg2so6114986qvb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 10:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lifq7rlkhN8DDjDxz8g2eqEQ9IL7TbQm7yDoGDvSi0U=;
        b=BKBQL8S5znAgq3xwtWnJicfD/xkpk2KVs2+fvMWlOrL3G4Hccd6X2KLuBg8HWDkx3a
         FeYR91DsaRI4YzIJJLjFTyjrQmEDPsh3zIPQqggf5mhYgSv0JNRMBpopyUHPk9bCIhcV
         wlTiEg8QIz0J7gVXIMo7laSQz3uLJBPF5Cxmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lifq7rlkhN8DDjDxz8g2eqEQ9IL7TbQm7yDoGDvSi0U=;
        b=mH0KKyy5KBJMXEvdrsL8xIUBImlyD8uOBPjcDOnRtd3T7QE/hg43dX0ZzRSBKgHtcM
         xH69vRsxIvYkkAkquMQaxQBlzQp6wDkb00vOrdhwNXQZ423pB8TeqfPMzcYrASrtS67a
         g/GkCrZcaQsYEI021JbWyTD4g/yNHc7Mr698E7I/vmiBUZHXUVkfe31aams/eYc1hdWg
         Wzfjct4vepCyxsAXnoVVoM+Ddib+q22tyciLQGvXrFRFBtQaq8KrD9tYDIAskIJTMkq0
         xxVz15P+K3sQ7juRGovwBHVi9fpIaLkbJUs/LFA1bXf+HXU3OHOI7vujqa7hbV7OtBZv
         kqwA==
X-Gm-Message-State: APjAAAXyl0XEP4Sdke5+RO4ZZmmzW61CrJQzm8H6CdCPU+L/AV/FE6eZ
        kjxOAEc8n+L2kwSDXXk3mHqiQPCSzcRBGTPwlMAyZn/7
X-Google-Smtp-Source: APXvYqyZEGxABAaGlCStP1ni7OiPhWYH+cPOPM+oHXRDZWYyZzYCxeCrg4EIu50hTg/a4RGaYMZ8NYSad7V21RwEWHc=
X-Received: by 2002:a0c:d09b:: with SMTP id z27mr28709989qvg.168.1574705655332;
 Mon, 25 Nov 2019 10:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20191123100111.219190-2-marcel@holtmann.org>
In-Reply-To: <20191123100111.219190-2-marcel@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 25 Nov 2019 10:14:04 -0800
Message-ID: <CANFp7mWT-Yz_AHKMDSWKnRSUsCNx6bf7RULPmfW+M5FyMqj=xQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: btbcm: Support pcm configuration
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Nov 23, 2019 at 2:01 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Add BCM vendor specific command to configure PCM parameters. The new
> vendor opcode allows us to set the sco routing, the pcm interface rate,
> and a few other pcm specific options (frame sync, sync mode, and clock
> mode). See broadcom-bluetooth.txt in Documentation for more information
> about valid values for those settings.
>
> Here is an example trace where this opcode was used to configure
> a BCM4354:
>
>         < HCI Command: Vendor (0x3f|0x001c) plen 5
>                 01 02 00 01 01
>         > HCI Event: Command Complete (0x0e) plen 4
>         Vendor (0x3f|0x001c) ncmd 1
>                 Status: Success (0x00)
>
> We can read back the values as well with ocf 0x001d to confirm the
> values that were set:
>         $ hcitool cmd 0x3f 0x001d
>         < HCI Command: ogf 0x3f, ocf 0x001d, plen 0
>         > HCI Event: 0x0e plen 9
>         01 1D FC 00 01 02 00 01 01
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btbcm.c | 46 +++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btbcm.h | 16 ++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 8e05706fe5d9..0795a49edfae 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -107,6 +107,52 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
>
> +int btbcm_read_pcm_int_params(struct hci_dev *hdev,
> +                             struct bcm_set_pcm_int_params *params)
> +{
> +       struct sk_buff *skb;
> +       int err = 0;
> +
> +       skb = __hci_cmd_sync(hdev, 0xfc1d, 0, NULL, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               err = PTR_ERR(skb);
> +               bt_dev_err(hdev, "BCM: Read PCM int params failed (%d)", err);
> +               return err;
> +       }
> +
> +       if (skb->len != 6 || skb->data[0]) {
> +               bt_dev_err(hdev, "BCM: Read PCM int params length mismatch");
> +               kfree_skb(skb);
> +               return -EIO;
> +       }
> +
> +       if (params)
> +               memcpy(params, skb->data + 1, 5);
> +
> +       kfree_skb(skb);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btbcm_read_pcm_int_params);
> +
> +int btbcm_write_pcm_int_params(struct hci_dev *hdev,
> +                              const struct bcm_set_pcm_int_params *params)
> +{
> +       struct sk_buff *skb;
> +       int err;
> +
> +       skb = __hci_cmd_sync(hdev, 0xfc1c, 5, params, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               err = PTR_ERR(skb);
> +               bt_dev_err(hdev, "BCM: Write PCM int params failed (%d)", err);
> +               return err;
> +       }
> +       kfree_skb(skb);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btbcm_write_pcm_int_params);
> +
>  int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
>  {
>         const struct hci_command_hdr *cmd;
> diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
> index d204be8a84bf..3c7dd0765837 100644
> --- a/drivers/bluetooth/btbcm.h
> +++ b/drivers/bluetooth/btbcm.h
> @@ -54,6 +54,10 @@ struct bcm_set_pcm_format_params {
>  int btbcm_check_bdaddr(struct hci_dev *hdev);
>  int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>  int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
> +int btbcm_read_pcm_int_params(struct hci_dev *hdev,
> +                             struct bcm_set_pcm_int_params *params);
> +int btbcm_write_pcm_int_params(struct hci_dev *hdev,
> +                              const struct bcm_set_pcm_int_params *params);
>
>  int btbcm_setup_patchram(struct hci_dev *hdev);
>  int btbcm_setup_apple(struct hci_dev *hdev);
> @@ -74,6 +78,18 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>         return -EOPNOTSUPP;
>  }
>
> +int btbcm_read_pcm_int_params(struct hci_dev *hdev,
> +                             struct bcm_set_pcm_int_params *params)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +int btbcm_write_pcm_int_params(struct hci_dev *hdev,
> +                              const struct bcm_set_pcm_int_params *params)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
>  {
>         return -EOPNOTSUPP;
> --
> 2.23.0
>
Looks good to me.
