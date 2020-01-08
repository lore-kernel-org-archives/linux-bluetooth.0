Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B6C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EDC20705
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAHVX1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:23:27 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56137 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHVX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:23:27 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8B246CECFB;
        Wed,  8 Jan 2020 22:32:42 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 08/10] Bluetooth: hci_h4: Add support for ISO packets
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200107074056.25453-9-luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 22:23:25 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F1F4DBA5-9A69-4C09-9359-02DAE70C7403@holtmann.org>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
 <20200107074056.25453-9-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This enabled H4 driver to properly handle ISO packets.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/hci_h4.c   | 1 +
> drivers/bluetooth/hci_uart.h | 7 +++++++
> 2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> index 19ba52005009..6dc1fbeb564b 100644
> --- a/drivers/bluetooth/hci_h4.c
> +++ b/drivers/bluetooth/hci_h4.c
> @@ -103,6 +103,7 @@ static const struct h4_recv_pkt h4_recv_pkts[] = {
> 	{ H4_RECV_ACL,   .recv = hci_recv_frame },
> 	{ H4_RECV_SCO,   .recv = hci_recv_frame },
> 	{ H4_RECV_EVENT, .recv = hci_recv_frame },
> +	{ H4_RECV_ISO,   .recv = hci_recv_frame },
> };
> 
> /* Recv data */
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 6ab631101019..4e039d7a16f8 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -143,6 +143,13 @@ struct h4_recv_pkt {
> 	.lsize = 1, \
> 	.maxlen = HCI_MAX_EVENT_SIZE
> 
> +#define H4_RECV_ISO \
> +	.type = HCI_ISODATA_PKT, \
> +	.hlen = HCI_ISO_HDR_SIZE, \
> +	.loff = 2, \
> +	.lsize = 2, \
> +	.maxlen = HCI_MAX_FRAME_SIZE \
> +
> struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
> 			    const unsigned char *buffer, int count,
> 			    const struct h4_recv_pkt *pkts, int pkts_count);

there are a bunch of drivers that should be able to handle packet type 5. We should fix them all.

Regards

Marcel

