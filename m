Return-Path: <SRS0=rkTY=PG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D95C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED962087F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 15:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md7I5/xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeL2PS7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Dec 2018 10:18:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42336 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeL2PS7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Dec 2018 10:18:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so11174171pga.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Dec 2018 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=C3WNpp+nDF5d+UJxz/XcyKEAJImunIOHlTMRVX3ctew=;
        b=md7I5/xZHQX5ZWoiYQRYllyqkydYWJoT4vnrLvQtPPFGaMECgN56CSBHjp5kmc4rFN
         9cj67f708TJPwRZZL5PL0y/Az6gqt2tFVSBth/4V7OiV8MjUisqIdfDp+FiStuqyRmFI
         NdWeTK1CqlI6c+xYuZRC5GSCHSrVoG7qBSI/J3Zx6ffU1N8VlbQqwZ01+Jkdprzgj4rM
         pjq3Qp9eRXQH2qOU58thVkonBVkQhhi6rzVLnLKlfWagD9l23/3k/mckRyjFy7tUMKaI
         F6a5L7LtBOppuEgXKU1BLx41HxUNLZ+Yk0VNT/MjsS32vZ1emefkoEDmNsbYr/pZJO/e
         AE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=C3WNpp+nDF5d+UJxz/XcyKEAJImunIOHlTMRVX3ctew=;
        b=NQhVKn/B3roBlpN+S/7W0JLsRBmXIKWFg1roAPHLjcLhtPANtQpz191R2hORgjPf0N
         oexAC1H7u8E7bT623LZTotboaHi2JQSo7EP8bN0dWjw3WxKqfJ+fIKfuKUStos4mDzWI
         EN/1cmKhFo2kwcaageeIGoUvXWoaGJm7FhDw9doc2ea1CHRahljxa92aq7h9uNwczzK1
         AQ+VicBG8N1YdJb64x8hqnZVeAWfxE7dvaXfW3QvZ+8KIe5ioT1OovjMEWfRHpw3sWyO
         w+2Ws8SZwxQ9WDHyrYvXgQVTLwuWYZ8//TYo9AVrj1dPpXe1vR9vI498RC2emWKl1a9U
         6ybg==
X-Gm-Message-State: AA+aEWbHBxjhhqgiSrKeEHm3CsfR4TzDBQv0DV2wWW+/TtKjtiJ6syiu
        JN7OoRk8CsD9NPZ1tCkpK/oG1n19azaPW9svd1D9fQ==
X-Google-Smtp-Source: AFSGD/Wt5dTQnuwRKnxPQuuiILSXDlHSr2OE1PY3eOwempqgegxq1w8ul88SRkQ4xQCFB4NgxfuNLB6EV9DsTxm+t24=
X-Received: by 2002:a62:938f:: with SMTP id r15mr31862701pfk.27.1546096738043;
 Sat, 29 Dec 2018 07:18:58 -0800 (PST)
MIME-Version: 1.0
References: <1527256763-13474-1-git-send-email-emil.lenngren@gmail.com>
In-Reply-To: <1527256763-13474-1-git-send-email-emil.lenngren@gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Sat, 29 Dec 2018 16:18:46 +0100
Message-ID: <CAO1O6scVvRyhMrfiCPKkH7fOtjh4XwJZJiq_Reh4Kvr8EPoJzg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix flow bugs in H5 so the protocol doesn't stall
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Den fre 25 maj 2018 kl 15:59 skrev Emil Lenngren <emil.lenngren@gmail.com>:
>
> 1. If more than tx_win packets are enqueued, so that the unack queue
> gets full, then when packets are later acked, uart tx is not woken up,
> meaning that the flow will be stalled unless uart tx is not later
> woken up for some other reason (e.g. packet is received so an ack
> needs to be sent).
>
> 2. If remote peer sends tx_win packets to us and our ack(s) are
> incorrectly received by the remote device, it will first resend the
> tx_win packets and wait for their ack before it can send the next
> packets. However, we only send ack if a NEW packet (not a resent packet)
> is arrived. Therefore, we will never send ack and the remote device
> will keep resend the packets (and wait for the acks) forever, until
> we send a new tx packet.
> ---
>  drivers/bluetooth/hci_h5.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index abee221..6fca22c 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -238,16 +238,19 @@ static int h5_close(struct hci_uart *hu)
>         return 0;
>  }
>
> -static void h5_pkt_cull(struct h5 *h5)
> +static void h5_pkt_cull(struct hci_uart *hu)
>  {
> +       struct h5 *h5 = hu->priv;
>         struct sk_buff *skb, *tmp;
>         unsigned long flags;
>         int i, to_remove;
> +       bool was_full;
>         u8 seq;
>
>         spin_lock_irqsave(&h5->unack.lock, flags);
>
>         to_remove = skb_queue_len(&h5->unack);
> +       was_full = to_remove == h5->tx_win;
>         if (to_remove == 0)
>                 goto unlock;
>
> @@ -278,6 +281,8 @@ static void h5_pkt_cull(struct h5 *h5)
>
>  unlock:
>         spin_unlock_irqrestore(&h5->unack.lock, flags);
> +       if (was_full && to_remove > 0 && !skb_queue_empty(&h5->rel))
> +               hci_uart_tx_wakeup(hu);
>  }
>
>  static void h5_handle_internal_rx(struct hci_uart *hu)
> @@ -354,7 +359,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
>
>         h5->rx_ack = H5_HDR_ACK(hdr);
>
> -       h5_pkt_cull(h5);
> +       h5_pkt_cull(hu);
>
>         switch (H5_HDR_PKT_TYPE(hdr)) {
>         case HCI_EVENT_PKT:
> @@ -419,6 +424,8 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
>         if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) != h5->tx_ack) {
>                 BT_ERR("Out-of-order packet arrived (%u != %u)",
>                        H5_HDR_SEQ(hdr), h5->tx_ack);
> +               set_bit(H5_TX_ACK_REQ, &h5->flags);
> +               hci_uart_tx_wakeup(hu);
>                 h5_reset_rx(h5);
>                 return 0;
>         }
> --
> 2.7.4
>


Any comments on this?
