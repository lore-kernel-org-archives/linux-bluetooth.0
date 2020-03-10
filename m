Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C455FC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E1920873
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOudf/Nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCJPNR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:13:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41926 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgCJPNR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 11:13:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id o10so7819134ljc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Twlj9MHkzBY6DdkI/gne6oQUJzKoq7n7a5H7cHGS6i4=;
        b=VOudf/NqcNhu9/Ob6m86j2u7lSUU8s9RXQlzHIdMWX/rzhy91kGjRwKNBjG5kYkIZe
         ipBL3ixnzvZMHxk/jp6EheLTAwImIXueXUuXYW/KhHN76J6rkziHDJEJqgksTcFnG0U9
         og0zByWuN7R1GLysxCnXnT8zfaQ1MV7tmiqZCJqJTs3s3Ju7ktj3IuhzP2jsKyI9tePL
         R2TEm4oJO8PH94kaRv+pVl9PJiXZ3H61WrgMFE4ERTt99ia/iGaozFZ13nxcDkpuYY4P
         Ntz5Hu12dRbweeBizth+F8MYBqfxrvkcS5B6nKIbKI2kh03ZhcQRSRHofT5c+do8S7Do
         riTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Twlj9MHkzBY6DdkI/gne6oQUJzKoq7n7a5H7cHGS6i4=;
        b=NnEnE4VBTMKiIfHQQfQy/a9FPHStnVCLAcV4cPjANajO4d5Xo41H/0MVeqbbKSDlS/
         FrQY8sLUL5Pp3boLDZU9lzq7q/5RoUX3KqSdp69f8s+BBVOqOyaQxn5V/W+UjAKAS2q5
         tyjov7j6ELk6q7YbloHgBTR3e/1b+gzscsVCSPtg/CCwbZfG5XWzuC5UEXLuYNtdscjf
         etzRPhDijhacKTRl29bGaRLp2a0eKLcidf/xjwz1IL/UkH5L7uEJSUzokfLSS7UZGRlO
         z6seXqPdT3/Tsfc2jy3YLvUsxXk/8HjV7K29umPFH2t8NMYukstPFX5BlfLCq3Zk2hMc
         hfoA==
X-Gm-Message-State: ANhLgQ2Dq0DTbkp+BuwNsXOWysyN8x8vQAHIGuop09Q4cgpLa0dGSJrS
        5H5HcJj54xtPFqTMsPsUCGAJCU1pKZ2ST/Up9tVPH3KX
X-Google-Smtp-Source: ADFU+vsXeRqjpfPDDmRj/CJrj3szbipaN1PvbVH1rDfRLMBy2riPKNep5uHX3FUKcM9PYcjExMgEcMLDnVwuMnyqCus=
X-Received: by 2002:a2e:890b:: with SMTP id d11mr13608651lji.79.1583853193448;
 Tue, 10 Mar 2020 08:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200309215723.442701-1-marcel@holtmann.org>
In-Reply-To: <20200309215723.442701-1-marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Mar 2020 11:13:02 -0400
Message-ID: <CALWDO_VHMT3xyTosjDmokwkfWG_PewF292ien9+HMTRiNOgxEA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: Switch from BT_ERR to bt_dev_err where possible
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Mar 9, 2020 at 5:57 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> All HCI device specific error messages shall use bt_dev_err to indicate
> the device name in the message.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_h5.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 812a5e975ec1..106c110efe56 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -178,7 +178,7 @@ static void h5_peer_reset(struct hci_uart *hu)
>  {
>         struct h5 *h5 = hu->priv;
>
> -       BT_ERR("Peer device has reset");
> +       bt_dev_err(hu->hdev, "Peer device has reset");
>
>         h5->state = H5_UNINITIALIZED;
>
> @@ -438,21 +438,21 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
>                H5_HDR_LEN(hdr));
>
>         if (((hdr[0] + hdr[1] + hdr[2] + hdr[3]) & 0xff) != 0xff) {
> -               BT_ERR("Invalid header checksum");
> +               bt_dev_err(hu->hdev, "Invalid header checksum");
>                 h5_reset_rx(h5);
>                 return 0;
>         }
>
>         if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) != h5->tx_ack) {
> -               BT_ERR("Out-of-order packet arrived (%u != %u)",
> -                      H5_HDR_SEQ(hdr), h5->tx_ack);
> +               bt_dev_err(hu->hdev, "Out-of-order packet arrived (%u != %u)",
> +                          H5_HDR_SEQ(hdr), h5->tx_ack);
>                 h5_reset_rx(h5);
>                 return 0;
>         }
>
>         if (h5->state != H5_ACTIVE &&
>             H5_HDR_PKT_TYPE(hdr) != HCI_3WIRE_LINK_PKT) {
> -               BT_ERR("Non-link packet received in non-active state");
> +               bt_dev_err(hu->hdev, "Non-link packet received in non-active state");
>                 h5_reset_rx(h5);
>                 return 0;
>         }
> @@ -475,7 +475,7 @@ static int h5_rx_pkt_start(struct hci_uart *hu, unsigned char c)
>
>         h5->rx_skb = bt_skb_alloc(H5_MAX_LEN, GFP_ATOMIC);
>         if (!h5->rx_skb) {
> -               BT_ERR("Can't allocate mem for new packet");
> +               bt_dev_err(hu->hdev, "Can't allocate mem for new packet");
>                 h5_reset_rx(h5);
>                 return -ENOMEM;
>         }
> @@ -551,7 +551,7 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
>
>                 if (h5->rx_pending > 0) {
>                         if (*ptr == SLIP_DELIMITER) {
> -                               BT_ERR("Too short H5 packet");
> +                               bt_dev_err(hu->hdev, "Too short H5 packet");
>                                 h5_reset_rx(h5);
>                                 continue;
>                         }
> @@ -578,13 +578,13 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>         struct h5 *h5 = hu->priv;
>
>         if (skb->len > 0xfff) {
> -               BT_ERR("Packet too long (%u bytes)", skb->len);
> +               bt_dev_err(hu->hdev, "Packet too long (%u bytes)", skb->len);
>                 kfree_skb(skb);
>                 return 0;
>         }
>
>         if (h5->state != H5_ACTIVE) {
> -               BT_ERR("Ignoring HCI data in non-active state");
> +               bt_dev_err(hu->hdev, "Ignoring HCI data in non-active state");
>                 kfree_skb(skb);
>                 return 0;
>         }
> @@ -601,7 +601,7 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>                 break;
>
>         default:
> -               BT_ERR("Unknown packet type %u", hci_skb_pkt_type(skb));
> +               bt_dev_err(hu->hdev, "Unknown packet type %u", hci_skb_pkt_type(skb));
>                 kfree_skb(skb);
>                 break;
>         }
> @@ -657,7 +657,7 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
>         int i;
>
>         if (!valid_packet_type(pkt_type)) {
> -               BT_ERR("Unknown packet type %u", pkt_type);
> +               bt_dev_err(hu->hdev, "Unknown packet type %u", pkt_type);
>                 return NULL;
>         }
>
> @@ -734,7 +734,7 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
>                 }
>
>                 skb_queue_head(&h5->unrel, skb);
> -               BT_ERR("Could not dequeue pkt because alloc_skb failed");
> +               bt_dev_err(hu->hdev, "Could not dequeue pkt because alloc_skb failed");
>         }
>
>         spin_lock_irqsave_nested(&h5->unack.lock, flags, SINGLE_DEPTH_NESTING);
> @@ -754,7 +754,7 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
>                 }
>
>                 skb_queue_head(&h5->rel, skb);
> -               BT_ERR("Could not dequeue pkt because alloc_skb failed");
> +               bt_dev_err(hu->hdev, "Could not dequeue pkt because alloc_skb failed");
>         }
>
>  unlock:
> --
> 2.24.1
>

LGTM.
