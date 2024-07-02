Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C3E1DFFC;
	Tue,  2 Jul 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719944546; cv=none; b=NStfx7gbkZPRY+E+hm8TrEfEYWK3oYW6katXCV56H/Txw34ZJcpUzfFmhU2Xgpsk8Pcr8+/O+lJK2UJM94zZkqtd4a5Nozob1+yrPjvio/wxRVsgyiovBNogw2HwMYl30DJdgIKySTsrfoHb+5NPOZfhZwaEvqvcbFpMTXyCMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719944546; c=relaxed/simple;
	bh=hfPAsWrO3Z1LSDEoITHVHfdBidFgLqt0hfu9orFGOpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2ZM5zg/1qwB9tJjIBF/ROETIb6LR68XI/3dsBlIQjQxrsxKSjnLQ3rxmzN5TO+/0NcPWWZ2EPQN2Vt00dTczuQ1XoPM8/5GRkvDaodwzWdyyIPg1cVuxNJFqF3jpQZ5uU3mq1JpX+8is9yMxRoMDWwYeCPI5OrPBtJ6Agpe8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr2HywLK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr2HywLK"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so13485081fa.3;
        Tue, 02 Jul 2024 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719944542; x=1720549342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAkARPiE60H67zAE3xCd/upoGQUcWCg0GCFc7cruia4=;
        b=Gr2HywLKgiNFNrLa2Oxykk0vL0by08Hntqp6rYzI+1JTY4UlBBrMsKr7u2xJfVSpxw
         4HlaptH/tpYAhzHOz29+jXlo3Fkd4tkEwsuOW+qA7oN2yJeKzbAPckmyLI+cuEbu1k3H
         3/mtPJouJ6KChA3IwSkcNxm/l/Bs/zLlUXdmMn6Lx6OjP6J5vToInPfn7LhQOigPHzvk
         kK2AS3uuN/vRcWUVBFloMrUpULnKTK8zzXC/9L11dEqmUfbfOkM7PSegkBQysM/gFPqI
         VSNY0UKiAARnliETJ3IiyvMmxy7Kfl+xe4xW9pLwlJo7L3XhxdS1V+pRJAuW6UHHMxql
         9r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719944542; x=1720549342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAkARPiE60H67zAE3xCd/upoGQUcWCg0GCFc7cruia4=;
        b=tb/nBsOg7h6RYDZANUJmGscc1mNT95V98LK3Wn0YNJlq3977f5rK/CJjQ9yJfkbRkO
         Jcj9HiqVlbYtyOgOG7SCo9o9NQ+7vXdVtIZrqwgs9XVzXv2AIaDXsxSwfFXrDmI5smkm
         dxPx790EwaML7mpTSi1DOIm1+S05joQ+Zhzh9FnX+mDCExqLH9dcFOgX77No2IzpQtVB
         2rh8St5FzEO7FxfTPcTq5chEL916606rgRBvLtvdVdfPmmIowiNFxcvDcfwq69WZtMpi
         wXYThbXzm1F+v5/8zSA/k5No4DWgzM8yfCj8gm4xzTdy6Hzc3fPuDs2Xnp+ENLxoRBEg
         4ANQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8cxzKBqCN9HbPurv+gayTv4ZD6KtAMOEcEG2wSBKujqVV35l94xGAOm/9NEuMdSLvkRCtCGUx51E1eKzQn1HndV5VosSRLJgYdVW6MOlHzyR/DGKWKJOTESBYbHJp0ocwpPzQNUkTq0PLo3qd
X-Gm-Message-State: AOJu0YyK1w9ioZaBxYeYFL5XMKERN5wkS86y86W/IDTqrmILUq19jNlX
	DlPGnL4GhC7Q4bKQkp99p5LmTeYlI0MChO2CPy3bElgCRdcw/MdK3KIQ78hw1hih5u0aKNU7kyg
	JocFVLD+zEZuJPo6HDVbCX6g6Wlo=
X-Google-Smtp-Source: AGHT+IGORH7mGBvmPfrdUNWLahcVIlm4zguXloZZqqjEH7cCsIVp9LQWPmzSHEqLAxhWtfLrxUogIBUmd2cCswsciW0=
X-Received: by 2002:a05:651c:1546:b0:2ee:4cd8:94b6 with SMTP id
 38308e7fff4ca-2ee5e3937bbmr87401581fa.15.1719944542060; Tue, 02 Jul 2024
 11:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702113051.24372-1-chris.lu@mediatek.com> <20240702113051.24372-9-chris.lu@mediatek.com>
In-Reply-To: <20240702113051.24372-9-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jul 2024 14:22:09 -0400
Message-ID: <CABBYNZ+cxK0DOFGv3WqU+q7p7gM3qk6t6NCF_d7Tq7Vys0HZGw@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, Jul 2, 2024 at 7:31=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wro=
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
> the setup in btusb_mtk_shutdown. These flow can't move to btmtk.c due to
> btusb_driver is only defined in btusb.c when claiming/relaesing interface=
.
> ISO packet anchor stops when driver suspending and resubmit interrupt urb
> for ISO data when driver resuming.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 303 ++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btmtk.h |  36 +++++
>  drivers/bluetooth/btusb.c |  68 +++++++++
>  3 files changed, 407 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index fe3b892f6c6e..dfeae9c283a9 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -22,6 +22,9 @@
>  #define MTK_SEC_MAP_COMMON_SIZE        12
>  #define MTK_SEC_MAP_NEED_SEND_SIZE     52
>
> +/* It is for mt79xx iso data transmission setting */
> +#define MTK_ISO_THRESHOLD      264
> +
>  struct btmtk_patch_header {
>         u8 datetime[16];
>         u8 platform[4];
> @@ -963,6 +966,300 @@ int btmtk_usb_recv_acl(struct hci_dev *hdev, struct=
 sk_buff *skb)
>  }
>  EXPORT_SYMBOL_GPL(btmtk_usb_recv_acl);
>
> +static int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
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
> +
> +static int __set_mtk_intr_interface(struct hci_dev *hdev)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +       struct usb_interface *intf =3D btmtk_data->isopkt_intf;
> +       int i, err;
> +
> +       if (!btmtk_data->isopkt_intf)
> +               return -ENODEV;
> +
> +       err =3D usb_set_interface(btmtk_data->udev, MTK_ISO_IFNUM, 1);
> +       if (err < 0) {
> +               bt_dev_err(hdev, "setting interface failed (%d)", -err);
> +               return err;
> +       }
> +
> +       btmtk_data->isopkt_tx_ep =3D NULL;
> +       btmtk_data->isopkt_rx_ep =3D NULL;
> +
> +       for (i =3D 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) =
{
> +               struct usb_endpoint_descriptor *ep_desc;
> +
> +               ep_desc =3D &intf->cur_altsetting->endpoint[i].desc;
> +
> +               if (!btmtk_data->isopkt_tx_ep &&
> +                   usb_endpoint_is_int_out(ep_desc)) {
> +                       btmtk_data->isopkt_tx_ep =3D ep_desc;
> +                       continue;
> +               }
> +
> +               if (!btmtk_data->isopkt_rx_ep &&
> +                   usb_endpoint_is_int_in(ep_desc)) {
> +                       btmtk_data->isopkt_rx_ep =3D ep_desc;
> +                       continue;
> +               }
> +       }
> +
> +       if (!btmtk_data->isopkt_tx_ep ||
> +           !btmtk_data->isopkt_rx_ep) {
> +               bt_dev_err(hdev, "invalid interrupt descriptors");
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb=
,
> +                              usb_complete_t tx_complete)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +       struct urb *urb;
> +       unsigned int pipe;
> +
> +       if (!btmtk_data->isopkt_tx_ep)
> +               return ERR_PTR(-ENODEV);
> +
> +       urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +       if (!urb)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (btmtk_isopkt_pad(hdev, skb))
> +               return ERR_PTR(-EINVAL);
> +
> +       pipe =3D usb_sndintpipe(btmtk_data->udev,
> +                             btmtk_data->isopkt_tx_ep->bEndpointAddress)=
;
> +
> +       usb_fill_int_urb(urb, btmtk_data->udev, pipe,
> +                        skb->data, skb->len, tx_complete,
> +                        skb, btmtk_data->isopkt_tx_ep->bInterval);
> +
> +       skb->dev =3D (void *)hdev;
> +
> +       return urb;
> +}
> +EXPORT_SYMBOL_GPL(alloc_mtk_intr_urb);
> +
> +static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int cou=
nt)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +       struct sk_buff *skb;
> +       unsigned long flags;
> +       int err =3D 0;
> +
> +       spin_lock_irqsave(&btmtk_data->isorxlock, flags);
> +       skb =3D btmtk_data->isopkt_skb;
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
> +                       __le16 dlen =3D ((struct hci_iso_hdr *)skb->data)=
->dlen;
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
> +       btmtk_data->isopkt_skb =3D skb;
> +       spin_unlock_irqrestore(&btmtk_data->isorxlock, flags);
> +
> +       return err;
> +}
> +
> +static void btmtk_intr_complete(struct urb *urb)
> +{
> +       struct hci_dev *hdev =3D urb->context;
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +       int err;
> +
> +       BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->stat=
us,
> +              urb->actual_length);
> +
> +       if (!test_bit(HCI_RUNNING, &hdev->flags))
> +               return;
> +
> +       if (hdev->suspended)
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
> +       usb_mark_last_busy(btmtk_data->udev);
> +       usb_anchor_urb(urb, &btmtk_data->isopkt_anchor);
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
> +static int btmtk_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +       unsigned char *buf;
> +       unsigned int pipe;
> +       struct urb *urb;
> +       int err, size;
> +
> +       BT_DBG("%s", hdev->name);
> +
> +       if (!btmtk_data->isopkt_rx_ep)
> +               return -ENODEV;
> +
> +       urb =3D usb_alloc_urb(0, mem_flags);
> +       if (!urb)
> +               return -ENOMEM;
> +       size =3D le16_to_cpu(btmtk_data->isopkt_rx_ep->wMaxPacketSize);
> +
> +       buf =3D kmalloc(size, mem_flags);
> +       if (!buf) {
> +               usb_free_urb(urb);
> +               return -ENOMEM;
> +       }
> +
> +       pipe =3D usb_rcvintpipe(btmtk_data->udev,
> +                             btmtk_data->isopkt_rx_ep->bEndpointAddress)=
;
> +
> +       usb_fill_int_urb(urb, btmtk_data->udev, pipe, buf, size,
> +                        btmtk_intr_complete, hdev,
> +                        btmtk_data->isopkt_rx_ep->bInterval);
> +
> +       urb->transfer_flags |=3D URB_FREE_BUFFER;
> +
> +       usb_mark_last_busy(btmtk_data->udev);
> +       usb_anchor_urb(urb, &btmtk_data->isopkt_anchor);
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
> +static int btmtk_usb_isointf_init(struct hci_dev *hdev)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +       u8 iso_param[2] =3D { 0x08, 0x01 };
> +       struct sk_buff *skb;
> +       int err;
> +
> +       init_usb_anchor(&btmtk_data->isopkt_anchor);
> +       spin_lock_init(&btmtk_data->isorxlock);
> +
> +       __set_mtk_intr_interface(hdev);
> +
> +       err =3D btmtk_submit_intr_urb(hdev, GFP_KERNEL);
> +       if (err < 0) {
> +               btmtk_usb_isopkt_stop(hdev);
> +               bt_dev_err(hdev, "ISO intf not support (%d)", err);
> +               return err;
> +       }
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
> +
> +int btmtk_usb_isopkt_start(struct hci_dev *hdev)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +
> +       if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags)) {
> +               if (btmtk_submit_intr_urb(hdev, GFP_NOIO) < 0)
> +                       clear_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flag=
s);
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_usb_isopkt_start);
> +
> +int btmtk_usb_isopkt_stop(struct hci_dev *hdev)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +
> +       usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_usb_isopkt_stop);
> +
>  int btmtk_usb_setup(struct hci_dev *hdev)
>  {
>         struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> @@ -1064,6 +1361,12 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>                 hci_set_msft_opcode(hdev, 0xFD30);
>                 hci_set_aosp_capable(hdev);
>
> +               /* Set up ISO interface after protocol enabled */
> +               if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags))=
 {
> +                       if (!btmtk_usb_isointf_init(hdev))
> +                               set_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data=
->flags);
> +               }
> +
>                 goto done;
>         default:
>                 bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 47193b867b9f..b88b599018fa 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -40,6 +40,9 @@
>  #define MTK_BT_RESET_REG_CONNV3        0x70028610
>  #define MTK_BT_READ_DEV_ID     0x70010200
>
> +/* MediaTek ISO Interface */
> +#define MTK_ISO_IFNUM          2
> +
>  enum {
>         BTMTK_WMT_PATCH_DWNLD =3D 0x1,
>         BTMTK_WMT_TEST =3D 0x2,
> @@ -142,6 +145,8 @@ enum {
>         BTMTK_TX_WAIT_VND_EVT,
>         BTMTK_FIRMWARE_LOADED,
>         BTMTK_HW_RESET_ACTIVE,
> +       BTMTK_ISOPKT_OVER_INTR,
> +       BTMTK_ISOPKT_RUNNING,
>  };
>
>  typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
> @@ -164,6 +169,14 @@ struct btmtk_data {
>         struct usb_interface *intf;
>         struct usb_anchor *ctrl_anchor;
>         struct sk_buff *evt_skb;
> +       struct usb_endpoint_descriptor *isopkt_tx_ep;
> +       struct usb_endpoint_descriptor *isopkt_rx_ep;
> +       struct usb_interface *isopkt_intf;
> +       struct usb_anchor isopkt_anchor;
> +       struct sk_buff *isopkt_skb;
> +
> +       /* spinlock for ISO data transmission */
> +       spinlock_t isorxlock;
>  };
>
>  typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
> @@ -193,6 +206,13 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32=
 dev_id);
>
>  int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
>
> +struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb=
,
> +                              usb_complete_t tx_complete);
> +
> +int btmtk_usb_isopkt_start(struct hci_dev *hdev);
> +
> +int btmtk_usb_isopkt_stop(struct hci_dev *hdev);
> +
>  int btmtk_usb_setup(struct hci_dev *hdev);
>
>  int btmtk_usb_shutdown(struct hci_dev *hdev);
> @@ -246,6 +266,22 @@ static int btmtk_usb_recv_acl(struct hci_dev *hdev, =
struct sk_buff *skb)
>         return -EOPNOTSUPP;
>  }
>
> +static struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_bu=
ff *skb,
> +                                     usb_complete_t tx_complete)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static int btmtk_usb_isopkt_start(struct hci_dev *hdev)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int btmtk_usb_isopkt_stop(struct hci_dev *hdev)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static int btmtk_usb_setup(struct hci_dev *hdev)
>  {
>         return -EOPNOTSUPP;
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5de50c835964..590602dce3f8 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2641,6 +2641,40 @@ static int btusb_recv_event_realtek(struct hci_dev=
 *hdev, struct sk_buff *skb)
>         return hci_recv_frame(hdev, skb);
>  }
>
> +static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(data->hdev);
> +       int err;
> +
> +       err =3D usb_driver_claim_interface(&btusb_driver,
> +                                        btmtk_data->isopkt_intf, data);
> +       if (err < 0) {
> +               btmtk_data->isopkt_intf =3D NULL;
> +               bt_dev_err(data->hdev, "Failed to claim iso interface");
> +               return;
> +       }
> +
> +       set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
> +}
> +
> +static void btusb_mtk_release_iso_intf(struct btusb_data *data)
> +{
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(data->hdev);
> +
> +       if (btmtk_data->isopkt_intf) {
> +               btmtk_usb_isopkt_stop(data->hdev);
> +               clear_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags);
> +
> +               dev_kfree_skb_irq(btmtk_data->isopkt_skb);
> +               btmtk_data->isopkt_skb =3D NULL;
> +               usb_set_intfdata(btmtk_data->isopkt_intf, NULL);
> +               usb_driver_release_interface(&btusb_driver,
> +                                            btmtk_data->isopkt_intf);
> +       }
> +
> +       clear_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
> +}
> +
>  static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -2657,6 +2691,9 @@ static int btusb_mtk_reset(struct hci_dev *hdev, vo=
id *rst_data)
>         if (err < 0)
>                 return err;
>
> +       if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
> +               btusb_mtk_release_iso_intf(data);
> +
>         btusb_stop_traffic(data);
>         usb_kill_anchored_urbs(&data->tx_anchor);
>
> @@ -2668,6 +2705,23 @@ static int btusb_mtk_reset(struct hci_dev *hdev, v=
oid *rst_data)
>         return err;
>  }
>
> +static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *sk=
b)
> +{
> +       struct urb *urb;
> +
> +       BT_DBG("%s", hdev->name);
> +
> +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ISODATA_PKT) {
> +               urb =3D alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
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
> @@ -2682,11 +2736,22 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>         btmtk_data->ctrl_anchor =3D &data->ctrl_anchor;
>         btmtk_data->reset_sync =3D btusb_mtk_reset;
>
> +       /* Claim ISO data interface and endpoint */
> +       btmtk_data->isopkt_intf =3D usb_ifnum_to_if(data->udev, MTK_ISO_I=
FNUM);
> +       if (btmtk_data->isopkt_intf)
> +               btusb_mtk_claim_iso_intf(data);
> +
>         return btmtk_usb_setup(hdev);
>  }
>
>  static int btusb_mtk_shutdown(struct hci_dev *hdev)
>  {
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +
> +       if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
> +               btusb_mtk_release_iso_intf(data);
> +
>         return btmtk_usb_shutdown(hdev);
>  }
>
> @@ -3793,9 +3858,12 @@ static int btusb_probe(struct usb_interface *intf,
>                 hdev->manufacturer =3D 70;
>                 hdev->cmd_timeout =3D btmtk_reset_sync;
>                 hdev->set_bdaddr =3D btmtk_set_bdaddr;
> +               hdev->send =3D btusb_send_frame_mtk;
>                 set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev-=
>quirks);
>                 set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>                 data->recv_acl =3D btmtk_usb_recv_acl;
> +               data->suspend =3D btmtk_usb_isopkt_stop;
> +               data->resume =3D btmtk_usb_isopkt_start;

Small nitpick, although it is just cleaning up the iso endpoint the
suspend and resume shall probably be named more generically, e.g:
btmtk_usb_suspend, etc, so later if you need to add more code we don't
need to rename the function names.

>         }
>
>         if (id->driver_info & BTUSB_SWAVE) {
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
