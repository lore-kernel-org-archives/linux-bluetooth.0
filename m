Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B0C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0D82468B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgANOTN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:19:13 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51854 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgANOTM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:19:12 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 635E6CECDE;
        Tue, 14 Jan 2020 15:28:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v2 10/10] Bluetooth: btusb: Detect if an ACL packet is in
 fact an ISO packet
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200111022216.30842-11-luiz.dentz@gmail.com>
Date:   Tue, 14 Jan 2020 15:19:11 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <36A77D9E-63AC-427A-919C-DBF448D4C94A@holtmann.org>
References: <20200111022216.30842-1-luiz.dentz@gmail.com>
 <20200111022216.30842-11-luiz.dentz@gmail.com>
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
> drivers/bluetooth/btusb.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ded0ba83bcce..4b5172c785ce 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -663,11 +663,21 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
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
> +			/* Detect if ISO packet has been sent over bulk */
> +			if (hci_conn_num(data->hdev, ISO_LINK)) {
> +				type = hci_conn_lookup_type(data->hdev,
> +							    hci_handle(handle));
> +				if (type == ISO_LINK)
> +					hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
> +			}
> +

lets scrap this patch as well.

Regards

Marcel

