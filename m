Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D49C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46B206DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgAHVZS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:25:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55704 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHVZR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:25:17 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id CF0E3CECFB;
        Wed,  8 Jan 2020 22:34:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 10/10] Bluetooth: btusb: Detect if an ACL packet is in
 fact an ISO packet
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200107074056.25453-11-luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 22:25:16 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DD158910-1335-4EAF-BDDD-8C0252C3B564@holtmann.org>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
 <20200107074056.25453-11-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Fix up the packet type if ISO packets are sent over the bulk endpoint.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ded0ba83bcce..c1e030fc272f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -663,11 +663,18 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> 		hci_skb_expect(skb) -= len;
> 
> 		if (skb->len == HCI_ACL_HDR_SIZE) {
> +			__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
> 			__le16 dlen = hci_acl_hdr(skb)->dlen;
> +			__u8 type;
> 
> 			/* Complete ACL header */
> 			hci_skb_expect(skb) = __le16_to_cpu(dlen);
> 
> +			type = hci_conn_lookup_type(data->hdev,
> +						    hci_handle(handle));
> +			if (type == ISO_LINK)
> +				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
> +
> 			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
> 				kfree_skb(skb);
> 				skb = NULL;

is this a local hack for development. We can not just look up the connection type on every packet we receive.

Regards

Marcel

