Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5313C81C;
	Thu,  6 Jun 2024 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707988; cv=none; b=WdRnCyULUiEUNgMgsKWA1PmJojcpa1r0QrMCbRfqNVnlVdK+1rPHUUmXhVTxM6fNkJsJDX3PFBOC5thWAEziW9y5HonxEWuRE/Ym/c8fwIWIPVrryCN+Hmk7VLgLcDKMj5P6vlzJFlidVAc9Zf+40s+1FNRKSRx/lV7fCiSzPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707988; c=relaxed/simple;
	bh=QMOr0godD31izaLZ93d/PbRu2A/tqyole7CMvfQZz5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DV8w8FELnhaFrVLACtwZ1NJaJLEBf+vclDYQINkRBH3r81M6VPo4e/xFjaUKDbj0MY8//18ilCvj5wCrH9I8K3noZdePLhMQD5bjG9PgGCHPrlNe+1NqS6pljYlhe3U+g6kxrX1uPvfyuM+kFfRP6jKbSi7RotfufsJ7eX83N4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2SwxT36; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2SwxT36"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso14763751fa.2;
        Thu, 06 Jun 2024 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717707985; x=1718312785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAK7Wl00Ln42614n7iZrgFDpbdIlmOxaHyugBgnfZVY=;
        b=I2SwxT36IrXHdgjV1S816UG/dAV6abjtbcGi9OCaVNoO2VWh1KlLgsu/5OJrYzNukE
         SiblQrgMo7psY+6CBd64jqsWbANruRUdzWfTvWQcbST2NMHRC4hU7igG+tUptmtoKBg/
         LBPRAqhjYfgRdIAbil7M8b6G/Fx84HV6J9CUyDSS7696tjuYgqHzP5+MUO+den767Lja
         6EuwiXs9/QqqDjichLLbE4dzCfVOSgB9A4qiS11fPvIF8WN8iFW2sLQejmjGtPMUaJGH
         lv7vebLv96z5R/OFh88CEg40JGJwbNceqhl4kGSD7QE+rKFBc/coQc/wwOeUjqIE7t/A
         FxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717707985; x=1718312785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAK7Wl00Ln42614n7iZrgFDpbdIlmOxaHyugBgnfZVY=;
        b=W9/bDj1wx3H0s3oQfrHDGDDhaFC4CuvZU2Rn18CnJ70dAYg3W2XsduWA6x496p63n6
         qF3yn8jgeFmb6xt6U35I5nHQKMHmi91f0aFiDFga6tGnrRCHQnBBCEmZ8ZSegA0C2MoP
         n62q5D/TQ3+FFbGu93jbuEouqAfgBVyCz7fxBV1T9nMsg9+12GnQtDvRHLb03ce4LpGx
         JkG8UgMvMCKlVeygRKOASbRRoUpbv7qQUF83wquC9oW3WYzLz59dSrFc0NV+9DDO8hyq
         mCmf6aNPnLr8J5dodJ5kn/n+6FecqV3K8YIlxbiFM4ywHrCnxLuKeP3+qLyLF2ZsNNsu
         Y/LA==
X-Forwarded-Encrypted: i=1; AJvYcCVX8eY6dfOoJbJlNu9UxcZ4VKaNNfKoajHN6FAlzN1zUvIZWsCUJ8Yv2Ofrcz7EqJOVbYY3gyI+2UG2caUznUfVOr/eP/DnGqghzSpYAzYE7yXM7cTRZw5tCCTUDHeX/c4YY1GjIuaIJuRVaL4U
X-Gm-Message-State: AOJu0YwWAGu3dP0OvU9+NKf5oaT5bjPjJx3PJFUv6Pr/Y6WsAIoYPjtB
	0AH3PxMFbAMScOTXY94PryTy8DuEZ2m4VzVyjAw1IgY7AkA4Qdazo0jPa0KtBB+dbdGsGkTfl+7
	V4UgvMj0gZUNQuF6H4R8idjvQKeRP5ujWC1g=
X-Google-Smtp-Source: AGHT+IGYoFmx8Vak8kfOQ/ad4xyipv/li+lZLsWd3osdmG6OBMu4ma7xXWtW8rM9O24U/VzIvHcIHAuJGZ8n3iAiG6M=
X-Received: by 2002:a2e:a786:0:b0:2e0:c689:f8cd with SMTP id
 38308e7fff4ca-2eadce37783mr5960181fa.29.1717707984378; Thu, 06 Jun 2024
 14:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606114321.30515-1-chris.lu@mediatek.com> <20240606114321.30515-5-chris.lu@mediatek.com>
In-Reply-To: <20240606114321.30515-5-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Jun 2024 17:06:11 -0400
Message-ID: <CABBYNZKhafMLdygNw-+CU8m3gXzq=28qfgQGBVrxh_wLLbq8aQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Jun 6, 2024 at 7:43=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wro=
te:
>
> This patch implements functions for ISO data send and receive in btusb
> driver for MediaTek's controller.
>
> MediaTek defines a specific interrupt endpoint for ISO data transmissin
> because the characteristics of interrupt endpoint are similar to the
> application of ISO data which can support guaranteed transmissin
> bandwidth, enough maximum data length and error checking mechanism.
>
> Driver sets up ISO interface and endpoints in btusb_mtk_setup and clears
> the setup in btusb_mtk_shutdown. ISO packet anchor stops when driver
> suspend and resubmit iso urb in driver resume.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c |  94 ++++++++++++++
>  drivers/bluetooth/btmtk.h |  38 ++++++
>  drivers/bluetooth/btusb.c | 267 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 399 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index a27c251bf56e..07d27724d915 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -19,6 +19,9 @@
>  #define MTK_SEC_MAP_COMMON_SIZE        12
>  #define MTK_SEC_MAP_NEED_SEND_SIZE     52
>
> +/* It is for mt79xx iso data transmission setting */
> +#define MTK_ISO_THRESHOLD      264
> +
>  struct btmtk_patch_header {
>         u8 datetime[16];
>         u8 platform[4];
> @@ -431,6 +434,97 @@ int btmtk_process_coredump(struct hci_dev *hdev, str=
uct sk_buff *skb)
>  }
>  EXPORT_SYMBOL_GPL(btmtk_process_coredump);
>
> +int btmtk_isointf_setup(struct hci_dev *hdev)
> +{
> +       u8 iso_param[2] =3D { 0x08, 0x01 };
> +       struct sk_buff *skb;
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfd98, sizeof(iso_param), iso_param=
,
> +                            HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Failed to apply iso setting (%ld)", PTR=
_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +       kfree_skb(skb);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_isointf_setup);
> +
> +int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       if (skb->len > MTK_ISO_THRESHOLD)
> +               return -EINVAL;
> +
> +       if (skb_pad(skb, MTK_ISO_THRESHOLD - skb->len))
> +               return -ENOMEM;
> +
> +       __skb_put(skb, MTK_ISO_THRESHOLD - skb->len);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_isopkt_pad);
> +
> +int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
> +{
> +       struct btmediatek_data *btmtk_data =3D hci_get_priv(hdev);
> +       struct sk_buff *skb;
> +       unsigned long flags;
> +       int err =3D 0;
> +
> +       spin_lock_irqsave(&btmtk_data->isopkt_info.isorxlock, flags);
> +       skb =3D btmtk_data->isopkt_info.isopkt_skb;
> +
> +       while (count) {
> +               int len;
> +
> +               if (!skb) {
> +                       skb =3D bt_skb_alloc(HCI_MAX_ISO_SIZE, GFP_ATOMIC=
);
> +                       if (!skb) {
> +                               err =3D -ENOMEM;
> +                               break;
> +                       }
> +
> +                       hci_skb_pkt_type(skb) =3D HCI_ISODATA_PKT;
> +                       hci_skb_expect(skb) =3D HCI_ISO_HDR_SIZE;
> +               }
> +
> +               len =3D min_t(uint, hci_skb_expect(skb), count);
> +               skb_put_data(skb, buffer, len);
> +
> +               count -=3D len;
> +               buffer +=3D len;
> +               hci_skb_expect(skb) -=3D len;
> +
> +               if (skb->len =3D=3D HCI_ISO_HDR_SIZE) {
> +                       __le16 dlen =3D hci_iso_hdr(skb)->dlen;
> +
> +                       /* Complete ISO header */
> +                       hci_skb_expect(skb) =3D __le16_to_cpu(dlen);
> +
> +                       if (skb_tailroom(skb) < hci_skb_expect(skb)) {
> +                               kfree_skb(skb);
> +                               skb =3D NULL;
> +
> +                               err =3D -EILSEQ;
> +                               break;
> +                       }
> +               }
> +
> +               if (!hci_skb_expect(skb)) {
> +                       /* Complete frame */
> +                       hci_recv_frame(hdev, skb);
> +                       skb =3D NULL;
> +               }
> +       }
> +
> +       btmtk_data->isopkt_info.isopkt_skb =3D skb;
> +       spin_unlock_irqrestore(&btmtk_data->isopkt_info.isorxlock, flags)=
;
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_recv_isopkt);
> +
>  MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
>  MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
>  MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION=
);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 6a0697a22b16..cb9dc4ccc266 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -1,6 +1,8 @@
>  /* SPDX-License-Identifier: ISC */
>  /* Copyright (C) 2021 MediaTek Inc. */
>
> +#include <linux/usb.h>
> +
>  #define FIRMWARE_MT7622                "mediatek/mt7622pr2h.bin"
>  #define FIRMWARE_MT7663                "mediatek/mt7663pr2h.bin"
>  #define FIRMWARE_MT7668                "mediatek/mt7668pr2h.bin"
> @@ -129,6 +131,9 @@ struct btmtk_hci_wmt_params {
>  typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
>
>  enum {
> +       BTMTK_ISOPKT_OVER_INTR,
> +       BTMTK_ISOPKT_RUNNING,
> +
>         __BTMTK_NUM_FLAGS,
>  };
>
> @@ -139,12 +144,24 @@ struct btmtk_coredump_info {
>         int state;
>  };
>
> +struct btmtk_isopkt_info {
> +       struct usb_endpoint_descriptor *isopkt_tx_ep;
> +       struct usb_endpoint_descriptor *isopkt_rx_ep;
> +       struct usb_interface *isopkt_intf;
> +       struct usb_anchor isopkt_anchor;
> +       struct sk_buff *isopkt_skb;
> +
> +       /* spinlock for ISO data transmission */
> +       spinlock_t isorxlock;
> +};
> +
>  struct btmediatek_data {
>         DECLARE_BITMAP(flags, __BTMTK_NUM_FLAGS);
>
>         u32 dev_id;
>         btmtk_reset_sync_func_t reset_sync;
>         struct btmtk_coredump_info cd_info;
> +       struct btmtk_isopkt_info isopkt_info;
>  };
>
>  #define btmtk_set_flag(hdev, nr)                                        =
       \
> @@ -186,6 +203,12 @@ int btmtk_process_coredump(struct hci_dev *hdev, str=
uct sk_buff *skb);
>
>  void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ve=
r,
>                            u32 fw_flavor);
> +
> +int btmtk_isointf_setup(struct hci_dev *hdev);
> +
> +int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb);
> +
> +int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count);
>  #else
>
>  static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
> @@ -225,4 +248,19 @@ static void btmtk_fw_get_filename(char *buf, size_t =
size, u32 dev_id,
>                                   u32 fw_ver, u32 fw_flavor)
>  {
>  }
> +
> +static int btmtk_isointf_setup(struct hci_dev *hdev)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int cou=
nt)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 83765c0c14b4..e297dcb6a8e2 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2653,6 +2653,8 @@ static int btusb_recv_event_realtek(struct hci_dev =
*hdev, struct sk_buff *skb)
>  #define MTK_BT_RESET_REG_CONNV3        0x70028610
>  #define MTK_BT_READ_DEV_ID     0x70010200
>
> +/* MediaTek ISO Interface */
> +#define MTK_ISO_IFNUM          2
>
>  static void btusb_mtk_wmt_recv(struct urb *urb)
>  {
> @@ -3129,6 +3131,239 @@ static int btusb_mtk_reset(struct hci_dev *hdev, =
void *rst_data)
>         return err;
>  }
>
> +static void btusb_mtk_intr_complete(struct urb *urb)
> +{
> +       struct hci_dev *hdev =3D urb->context;
> +       struct btmediatek_data *btmtk_data =3D hci_get_priv(hdev);
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       int err;
> +
> +       BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->stat=
us,
> +              urb->actual_length);
> +
> +       if (!test_bit(HCI_RUNNING, &hdev->flags))
> +               return;
> +
> +       if (urb->status =3D=3D 0) {
> +               hdev->stat.byte_rx +=3D urb->actual_length;
> +
> +               if (btmtk_recv_isopkt(hdev, urb->transfer_buffer,
> +                                     urb->actual_length) < 0) {
> +                       bt_dev_err(hdev, "corrupted iso packet");
> +                       hdev->stat.err_rx++;
> +               }
> +       } else if (urb->status =3D=3D -ENOENT) {
> +               /* Avoid suspend failed when usb_kill_urb */
> +               return;
> +       }
> +
> +       if (!btmtk_test_flag(hdev, BTMTK_ISOPKT_RUNNING))
> +               return;
> +
> +       usb_mark_last_busy(data->udev);
> +       usb_anchor_urb(urb, &btmtk_data->isopkt_info.isopkt_anchor);
> +
> +       err =3D usb_submit_urb(urb, GFP_ATOMIC);
> +       if (err < 0) {
> +               /* -EPERM: urb is being killed;
> +                * -ENODEV: device got disconnected
> +                */
> +               if (err !=3D -EPERM && err !=3D -ENODEV)
> +                       bt_dev_err(hdev, "urb %p failed to resubmit (%d)"=
,
> +                                  urb, -err);
> +               if (err !=3D -EPERM)
> +                       hci_cmd_sync_cancel(hdev, -err);
> +               usb_unanchor_urb(urb);
> +       }
> +}
> +
> +static int btusb_mtk_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_fla=
gs)
> +{
> +       struct btmediatek_data *btmtk_data =3D hci_get_priv(hdev);
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       unsigned char *buf;
> +       unsigned int pipe;
> +       struct urb *urb;
> +       int err, size;
> +
> +       BT_DBG("%s", hdev->name);
> +
> +       if (!btmtk_data->isopkt_info.isopkt_rx_ep)
> +               return -ENODEV;
> +
> +       urb =3D usb_alloc_urb(0, mem_flags);
> +       if (!urb)
> +               return -ENOMEM;
> +       size =3D le16_to_cpu(btmtk_data->isopkt_info.isopkt_rx_ep->wMaxPa=
cketSize);
> +
> +       buf =3D kmalloc(size, mem_flags);
> +       if (!buf) {
> +               usb_free_urb(urb);
> +               return -ENOMEM;
> +       }
> +
> +       pipe =3D usb_rcvintpipe(data->udev,
> +                             btmtk_data->isopkt_info.isopkt_rx_ep->bEndp=
ointAddress);
> +
> +       usb_fill_int_urb(urb, data->udev, pipe, buf, size,
> +                        btusb_mtk_intr_complete, hdev,
> +                        btmtk_data->isopkt_info.isopkt_rx_ep->bInterval)=
;
> +
> +       urb->transfer_flags |=3D URB_FREE_BUFFER;
> +
> +       usb_mark_last_busy(data->udev);
> +       usb_anchor_urb(urb, &btmtk_data->isopkt_info.isopkt_anchor);
> +
> +       err =3D usb_submit_urb(urb, mem_flags);
> +       if (err < 0) {
> +               if (err !=3D -EPERM && err !=3D -ENODEV)
> +                       bt_dev_err(hdev, "urb %p submission failed (%d)",
> +                                  urb, -err);
> +               usb_unanchor_urb(urb);
> +       }
> +
> +       usb_free_urb(urb);
> +
> +       return err;
> +}
> +
> +static inline int __set_mtk_intr_interface(struct hci_dev *hdev, unsigne=
d int ifnum)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       struct btmediatek_data *btmtk_data =3D hci_get_priv(hdev);
> +       struct usb_interface *intf =3D btmtk_data->isopkt_info.isopkt_int=
f;
> +       int i, err;
> +
> +       if (!btmtk_data->isopkt_info.isopkt_intf)
> +               return -ENODEV;
> +
> +       err =3D usb_set_interface(data->udev, ifnum, 1);
> +       if (err < 0) {
> +               bt_dev_err(hdev, "setting interface failed (%d)", -err);
> +               return err;
> +       }
> +
> +       btmtk_data->isopkt_info.isopkt_tx_ep =3D NULL;
> +       btmtk_data->isopkt_info.isopkt_rx_ep =3D NULL;
> +
> +       for (i =3D 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) =
{
> +               struct usb_endpoint_descriptor *ep_desc;
> +
> +               ep_desc =3D &intf->cur_altsetting->endpoint[i].desc;
> +
> +               if (!btmtk_data->isopkt_info.isopkt_tx_ep &&
> +                   usb_endpoint_is_int_out(ep_desc)) {
> +                       btmtk_data->isopkt_info.isopkt_tx_ep =3D ep_desc;
> +                       continue;
> +               }
> +
> +               if (!btmtk_data->isopkt_info.isopkt_rx_ep &&
> +                   usb_endpoint_is_int_in(ep_desc)) {
> +                       btmtk_data->isopkt_info.isopkt_rx_ep =3D ep_desc;
> +                       continue;
> +               }
> +       }
> +
> +       if (!btmtk_data->isopkt_info.isopkt_tx_ep ||
> +           !btmtk_data->isopkt_info.isopkt_rx_ep) {
> +               bt_dev_err(hdev, "invalid interrupt descriptors");
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int btusb_mtk_isopkt_stop(struct hci_dev *hdev)
> +{
> +       struct btmediatek_data *btmtk_data =3D hci_get_priv(hdev);
> +
> +       usb_kill_anchored_urbs(&btmtk_data->isopkt_info.isopkt_anchor);
> +
> +       return 0;
> +}
> +
> +static int btusb_mtk_isopkt_start(struct hci_dev *hdev)
> +{
> +       if (btmtk_test_flag(hdev, BTMTK_ISOPKT_RUNNING)) {
> +               if (btusb_mtk_submit_intr_urb(hdev, GFP_NOIO) < 0)
> +                       btmtk_clear_flag(hdev, BTMTK_ISOPKT_RUNNING);
> +       }
> +
> +       return 0;
> +}
> +
> +static int btusb_mtk_claim_iso_intf(struct btusb_data *data, struct usb_=
interface *intf)
> +{
> +       struct btmediatek_data *btmtk_data =3D hci_get_priv(data->hdev);
> +       int err;
> +
> +       err =3D usb_driver_claim_interface(&btusb_driver, intf, data);
> +       if (err < 0)
> +               return err;
> +
> +       init_usb_anchor(&btmtk_data->isopkt_info.isopkt_anchor);
> +       spin_lock_init(&btmtk_data->isopkt_info.isorxlock);
> +
> +       __set_mtk_intr_interface(data->hdev, MTK_ISO_IFNUM);
> +
> +       err =3D btusb_mtk_submit_intr_urb(data->hdev, GFP_KERNEL);
> +       if (err < 0) {
> +               btusb_mtk_isopkt_stop(data->hdev);
> +               bt_dev_err(data->hdev, "ISO intf not support (%d)", err);
> +               return err;
> +       }
> +
> +       btmtk_set_flag(data->hdev, BTMTK_ISOPKT_OVER_INTR);
> +
> +       return 0;
> +}
> +
> +static struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_bu=
ff *skb)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       struct btmediatek_data *btmtk_data =3D hci_get_priv(hdev);
> +       unsigned int pipe;
> +       struct urb *urb;
> +
> +       if (!btmtk_data->isopkt_info.isopkt_tx_ep)
> +               return ERR_PTR(-ENODEV);
> +
> +       urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +       if (!urb)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (btmtk_isopkt_pad(hdev, skb))
> +               return ERR_PTR(-EINVAL);
> +
> +       pipe =3D usb_sndintpipe(data->udev,
> +                             btmtk_data->isopkt_info.isopkt_tx_ep->bEndp=
ointAddress);
> +
> +       usb_fill_int_urb(urb, data->udev, pipe,
> +                        skb->data, skb->len, btusb_tx_complete,
> +                        skb, btmtk_data->isopkt_info.isopkt_tx_ep->bInte=
rval);
> +
> +       skb->dev =3D (void *)hdev;
> +
> +       return urb;
> +}
> +
> +static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *sk=
b)
> +{
> +       struct urb *urb;
> +
> +       BT_DBG("%s", hdev->name);
> +
> +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ISODATA_PKT) {
> +               urb =3D alloc_mtk_intr_urb(hdev, skb);
> +               if (IS_ERR(urb))
> +                       return PTR_ERR(urb);
> +
> +               return submit_or_queue_tx_urb(hdev, urb);
> +       } else {
> +               return btusb_send_frame(hdev, skb);
> +       }
> +}
> +
>  static int btusb_mtk_setup(struct hci_dev *hdev)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -3213,6 +3448,12 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>                 /* It's Device EndPoint Reset Option Register */
>                 btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_=
IN_OUT_OPT);
>
> +               /* Claim ISO data interface and endpoint */
> +               mediatek->isopkt_info.isopkt_intf =3D usb_ifnum_to_if(dat=
a->udev, MTK_ISO_IFNUM);
> +               err =3D btusb_mtk_claim_iso_intf(data, mediatek->isopkt_i=
nfo.isopkt_intf);
> +               if (err < 0)
> +                       mediatek->isopkt_info.isopkt_intf =3D NULL;
> +
>                 /* Enable Bluetooth protocol */
>                 param =3D 1;
>                 wmt_params.op =3D BTMTK_WMT_FUNC_CTRL;
> @@ -3229,6 +3470,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>
>                 hci_set_msft_opcode(hdev, 0xFD30);
>                 hci_set_aosp_capable(hdev);
> +
> +               /* Set up ISO interface after protocol enabled */
> +               if (btmtk_test_flag(hdev, BTMTK_ISOPKT_OVER_INTR)) {
> +                       btmtk_isointf_setup(hdev);
> +                       btmtk_set_flag(data->hdev, BTMTK_ISOPKT_RUNNING);
> +               }
> +
>                 goto done;
>         default:
>                 bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
> @@ -3321,6 +3569,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>  static int btusb_mtk_shutdown(struct hci_dev *hdev)
>  {
>         struct btmtk_hci_wmt_params wmt_params;
> +       struct btmediatek_data *btmtk_data =3D hci_get_priv(hdev);
>         u8 param =3D 0;
>         int err;
>
> @@ -3337,6 +3586,21 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev=
)
>                 return err;
>         }
>
> +       if (btmtk_test_flag(hdev, BTMTK_ISOPKT_RUNNING)) {
> +               btusb_mtk_isopkt_stop(hdev);
> +               btmtk_clear_flag(hdev, BTMTK_ISOPKT_RUNNING);
> +
> +               if (btmtk_data->isopkt_info.isopkt_intf) {
> +                       usb_set_intfdata(btmtk_data->isopkt_info.isopkt_i=
ntf, NULL);
> +                       usb_driver_release_interface(&btusb_driver,
> +                                                    btmtk_data->isopkt_i=
nfo.isopkt_intf);
> +                       dev_kfree_skb_irq(btmtk_data->isopkt_info.isopkt_=
skb);
> +                       btmtk_data->isopkt_info.isopkt_skb =3D NULL;
> +
> +                       btmtk_clear_flag(hdev, BTMTK_ISOPKT_OVER_INTR);
> +               }
> +       }

There is still an awful lot of code into btusb that is actually not
part of the standard interface, for instance the above could also
possible be done in btmtk as well, in fact I'm not really sure why we
need the likes of btusb_mtk_shutdown or btusb_mtk_setup, etc, inside
btusb.c?

>         return 0;
>  }
>
> @@ -4475,9 +4739,12 @@ static int btusb_probe(struct usb_interface *intf,
>                 hdev->manufacturer =3D 70;
>                 hdev->cmd_timeout =3D btmtk_reset_sync;
>                 hdev->set_bdaddr =3D btmtk_set_bdaddr;
> +               hdev->send =3D btusb_send_frame_mtk;
>                 set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev-=
>quirks);
>                 set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>                 data->recv_acl =3D btusb_recv_acl_mtk;
> +               data->dev_suspend =3D btusb_mtk_isopkt_stop;
> +               data->dev_resume =3D btusb_mtk_isopkt_start;
>         }
>
>         if (id->driver_info & BTUSB_SWAVE) {
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
