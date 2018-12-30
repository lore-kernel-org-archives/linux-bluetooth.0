Return-Path: <SRS0=iDKf=PH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41EFC43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Dec 2018 10:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAF6206BB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Dec 2018 10:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeL3K3b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Dec 2018 05:29:31 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53674 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbeL3K3a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Dec 2018 05:29:30 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 79788CEE81;
        Sun, 30 Dec 2018 11:37:11 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: Fix flow bugs in H5 so the protocol doesn't
 stall
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1527256763-13474-1-git-send-email-emil.lenngren@gmail.com>
Date:   Sun, 30 Dec 2018 11:29:28 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A73D99C8-7E66-49CF-8B85-E8879308A5F8@holtmann.org>
References: <1527256763-13474-1-git-send-email-emil.lenngren@gmail.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

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

do you have interest in working on the bt3wire.c driver that is a pure serdev driver and make it fully H:5 compliant. I think it would be good to move away from hci_h5.c since it is too much entangled with the line discipline.

> ---
> drivers/bluetooth/hci_h5.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index abee221..6fca22c 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -238,16 +238,19 @@ static int h5_close(struct hci_uart *hu)
> 	return 0;
> }
> 
> -static void h5_pkt_cull(struct h5 *h5)
> +static void h5_pkt_cull(struct hci_uart *hu)
> {
> +	struct h5 *h5 = hu->priv;
> 	struct sk_buff *skb, *tmp;
> 	unsigned long flags;
> 	int i, to_remove;
> +	bool was_full;
> 	u8 seq;
> 
> 	spin_lock_irqsave(&h5->unack.lock, flags);
> 
> 	to_remove = skb_queue_len(&h5->unack);
> +	was_full = to_remove == h5->tx_win;

I would really add a comment here.

> 	if (to_remove == 0)
> 		goto unlock;
> 
> @@ -278,6 +281,8 @@ static void h5_pkt_cull(struct h5 *h5)
> 
> unlock:
> 	spin_unlock_irqrestore(&h5->unack.lock, flags);
> +	if (was_full && to_remove > 0 && !skb_queue_empty(&h5->rel))
> +		hci_uart_tx_wakeup(hu);

And here as well. it should be commented on why this is the right expression. Especially since it is rather complex. Can we not check all the conditions up-front?

> }
> 
> static void h5_handle_internal_rx(struct hci_uart *hu)
> @@ -354,7 +359,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
> 
> 	h5->rx_ack = H5_HDR_ACK(hdr);
> 
> -	h5_pkt_cull(h5);
> +	h5_pkt_cull(hu);
> 
> 	switch (H5_HDR_PKT_TYPE(hdr)) {
> 	case HCI_EVENT_PKT:
> @@ -419,6 +424,8 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
> 	if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) != h5->tx_ack) {
> 		BT_ERR("Out-of-order packet arrived (%u != %u)",
> 		       H5_HDR_SEQ(hdr), h5->tx_ack);
> +		set_bit(H5_TX_ACK_REQ, &h5->flags);
> +		hci_uart_tx_wakeup(hu);
> 		h5_reset_rx(h5);

I really wonder if these are actually two independent patches fixing two independent things.

Regards

Marcel

