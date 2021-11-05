Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EECA60F9E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhKEVd0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhKEVdZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:33:25 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64447C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:30:45 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id o26so19534884uab.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0H7Yf8v9+WjTVCbsLiWPDs0u/XfwUThv6qSNtpRkRA=;
        b=bP3wKEIE2UlRJn5/NBheHhl1UsEsiZSC3D6woCh5K7TNuMwPJKS7hORhxoPWcDHuWX
         cx8CuuXj/6NdP/PMkUXsJbNcEnH7CZ6eV//ivs/s/6kJCayGWxoonG0+Z8ou6F/MXh9w
         9gwTdIVso5xRA9sr13d6mCtwIb7s2bLKHhNsbE3kArCaAESDDpuuxNq9fpGKrk0e8pwq
         EW4koRD4uYHz+/+RsCxD7a5t7orpxmUiu5Kg8U5z7rgNfBqONbm2bPBYcOp4PXKlKK3y
         YyXY/siO5Jvqf3LAWHwKy91TB6hLkf83u3KzBIKBawAM7c+QF/k41vvsr+yPIoV4AYnB
         j9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0H7Yf8v9+WjTVCbsLiWPDs0u/XfwUThv6qSNtpRkRA=;
        b=RhBHqKaWW/26zA8Pe3hzk6+sqQihwbxmO6A+lIw4yp2v7wtPYLUdApn7K2tI9D9Dgz
         ZTnKtLqU/mEpcL2hUgxWQfbzdHbONFuxosa6evGnC0y1HVS/32wgWd/4mzXDtfm7KVhk
         w/uOVJxU3t/MeU+77TCYZ2tH4HPD6y2ff5vy33YRLWPjgj2p6JQHgWE6uYi/o8m5eKHk
         KZOkTL2jHsQ5CJn2jrRC9UfdcVvL6qg5xn8qsavOPp3V48F2bMAWQj/CmFcX6b1tbt8H
         leIKIREXvJQMh03rTaIoxWYf4SNHVmbWhyNVAXgc5DH8RBo8lExqSSINclvVJ3YgNxpT
         886g==
X-Gm-Message-State: AOAM531ObiQzPgd2ILW3JfpsdWKnkGZEeen5HoGCh0G80zuPBGj01Zy0
        xCi5JWCodeST/pCjxnpVIYci1cQ615UB9KoS9As=
X-Google-Smtp-Source: ABdhPJwAjbHOtODJjUzPtBOiCDOInqU63ltSJSUVl84yWgRNfli8vHyik2YSfAujtRvpmuUF+eFw9og+VfChkrTXuPs=
X-Received: by 2002:a05:6102:94a:: with SMTP id a10mr58888360vsi.39.1636147844384;
 Fri, 05 Nov 2021 14:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211105011331.288326-1-hj.tedd.an@gmail.com>
In-Reply-To: <20211105011331.288326-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Nov 2021 14:30:33 -0700
Message-ID: <CABBYNZKiLKfQgAnCayJxfyZAfvbJVbPOFD99o29-GGG6Zs2vog@mail.gmail.com>
Subject: Re: [RFC PATCH V3] Bluetooth: vhci: Add support creating extended
 device mode
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Nov 4, 2021 at 6:34 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch adds new opcode(0x03) for HCI Vendor packet to support
> creating extended device mode. In order to avoid the conflict with the
> legacy opcode, it has to be 0x03 only and all other bits must be set to
> zero.
>
> Then, it is followed by the extended configuration data that contains
> the device type and the flags to be used.
>
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/hci_vhci.c | 156 +++++++++++++++++++++++++++++++++--
>  1 file changed, 150 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 49ac884d996e..d1177a079f98 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -30,6 +30,24 @@
>
>  static bool amp;
>
> +/* This is the struct for extended device configuration.
> + * The opcode 0x03 is used for creating an extended device and followed by
> + * the configuration data below.
> + * dev_type is Primay or AMP.
> + * flag_len is the lenght or flag array
> + * flag array contains the flag to use/set while creating the device.
> + */
> +struct vhci_ext_config {
> +       __u8    dev_type;
> +       __u8    flag_len;
> +       __u8    flag[0];
> +};
> +
> +#define VHCI_EXT_FLAG_ENABLE_AOSP              0x01
> +#define VHCI_EXT_FLAG_QUIRK_RAW_DEVICE         0x02
> +#define VHCI_EXT_FLAG_QUIARK_EXTERNAL_CONFIG   0x03
> +#define VHCI_EXT_FLAG_QUIRK_INVALID_BDADDR     0x04
> +
>  struct vhci_data {
>         struct hci_dev *hdev;
>
> @@ -375,6 +393,124 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
>         return err;
>  }
>
> +static int __vhci_create_extended_device(struct vhci_data *data,
> +                                                       struct sk_buff *skb)
> +{
> +       struct hci_dev *hdev;
> +       struct sk_buff *resp;
> +       struct vhci_ext_config *config;
> +       int i;
> +       __u8 flag;
> +
> +       if (data->hdev)
> +               return -EBADFD;
> +
> +       /* Make sure the skb has a minimum vaild length */
> +       if (skb->len < sizeof(*config))
> +               return -EINVAL;
> +
> +       config = (void *)(skb->data);
> +       if (skb->len < sizeof(*config) + config->flag_len)
> +               return -EINVAL;
> +
> +       if (config->dev_type != HCI_PRIMARY && config->dev_type != HCI_AMP)
> +               return -EINVAL;
> +
> +       resp = bt_skb_alloc(4, GFP_KERNEL);
> +       if (!resp)
> +               return -ENOMEM;
> +
> +       hdev = hci_alloc_dev();
> +       if (!hdev) {
> +               kfree_skb(resp);
> +               return -ENOMEM;
> +       }
> +
> +       data->hdev = hdev;
> +
> +       hdev->bus = HCI_VIRTUAL;
> +       hdev->dev_type = config->dev_type;
> +       hci_set_drvdata(hdev, data);
> +
> +       hdev->open  = vhci_open_dev;
> +       hdev->close = vhci_close_dev;
> +       hdev->flush = vhci_flush;
> +       hdev->send  = vhci_send_frame;
> +       hdev->get_data_path_id = vhci_get_data_path_id;
> +       hdev->get_codec_config_data = vhci_get_codec_config_data;
> +       hdev->wakeup = vhci_wakeup;
> +       hdev->setup = vhci_setup;
> +       set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +
> +       for (i = 0; i < config->flag_len; i++) {
> +               flag = config->flag[i];
> +               switch(flag) {
> +               case VHCI_EXT_FLAG_ENABLE_AOSP:
> +                       data->aosp_capable = 1;
> +                       break;
> +               case VHCI_EXT_FLAG_QUIRK_RAW_DEVICE:
> +                       set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
> +                       break;
> +               case VHCI_EXT_FLAG_QUIARK_EXTERNAL_CONFIG:
> +                       set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
> +                       break;
> +               case VHCI_EXT_FLAG_QUIRK_INVALID_BDADDR:
> +                       set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +                       break;
> +               default:
> +                       BT_ERR("Invalid flag");
> +                       hci_free_dev(hdev);
> +                       data->hdev = NULL;
> +                       kfree_skb(resp);
> +                       return -EINVAL;
> +               }
> +       }

We can probably move the code below to a common function e.g.
vhci_register_dev since it should be the same for both old and new
commands, so that would take care of calling hci_register_dev and
registering the debugfs entries.

> +       if (hci_register_dev(hdev) < 0) {
> +               BT_ERR("Can't register HCI device");
> +               hci_free_dev(hdev);
> +               data->hdev = NULL;
> +               kfree_skb(resp);
> +               return -EBUSY;
> +       }
> +
> +       debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> +                           &force_suspend_fops);
> +
> +       debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> +                           &force_wakeup_fops);
> +
> +       if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> +               debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> +                                   &msft_opcode_fops);
> +
> +       if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> +               debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> +                                   &aosp_capable_fops);
> +
> +       hci_skb_pkt_type(resp) = HCI_VENDOR_PKT;
> +
> +       skb_put_u8(resp, 0xff);
> +       skb_put_u8(resp, 0x03);
> +       put_unaligned_le16(hdev->id, skb_put(resp, 2));
> +       skb_queue_tail(&data->readq, resp);
> +
> +       wake_up_interruptible(&data->read_wait);
> +       return 0;
> +}
> +
> +static int vhci_create_extended_device(struct vhci_data *data,
> +                                                       struct sk_buff *skb)
> +{
> +       int err;
> +
> +       mutex_lock(&data->open_mutex);
> +       err = __vhci_create_extended_device(data, skb);
> +       mutex_unlock(&data->open_mutex);
> +
> +       return err;
> +}
> +
>  static inline ssize_t vhci_get_user(struct vhci_data *data,
>                                     struct iov_iter *from)
>  {
> @@ -419,14 +555,22 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
>                 opcode = *((__u8 *) skb->data);
>                 skb_pull(skb, 1);
>
> -               if (skb->len > 0) {
> -                       kfree_skb(skb);
> -                       return -EINVAL;
> +               /* The dev_type 3 is used as an escape opcode for extension
> +               * handling. If dev_type is set to 3 all other bits must be
> +               * set to zero.
> +               */
> +               if (opcode == 0x03) {
> +                       if (skb->len < 1)
> +                               ret = -EINVAL;
> +                       else
> +                               ret = vhci_create_extended_device(data, skb);
> +               } else {
> +                       if (skb->len > 0)
> +                               ret = -EINVAL;
> +                       else
> +                               ret = vhci_create_device(data, opcode);
>                 }
> -
>                 kfree_skb(skb);
> -
> -               ret = vhci_create_device(data, opcode);
>                 break;
>
>         default:
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
