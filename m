Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF47C433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDCD207E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgG1HWt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:22:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48954 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG1HWs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 03:22:48 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id C8441CECCD;
        Tue, 28 Jul 2020 09:32:48 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC] Bluetooth: L2CAP: Fix to handling fragmented header
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200728070428.1754257-1-luiz.dentz@gmail.com>
Date:   Tue, 28 Jul 2020 09:22:46 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <80073DFD-564E-4B4E-9F23-02ED4075321D@holtmann.org>
References: <20200728070428.1754257-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Bluetooth Core Specification v5.2, Vol. 3, Part A, section 1.4, table
> 1.1:
> 
> 'Start Fragments always either begin with the first octet of the Basic
>  L2CAP header of a PDU or they have a length of zero (see [Vol 2] Part
>  B, Section 6.6.2).'
> 
> This text has been changed recently as it previously stated:
> 
> 'Start Fragments always begin with the Basic L2CAP header of a PDU.'
> 
> Apparently this was changed by the following errata:
> 
> https://www.bluetooth.org/tse/errata_view.cfm?errata_id=10216
> 
> In past this has not been a problem but it seems new controllers are
> apparently doing it as it has been reported in Zephyr:
> 
> https://github.com/zephyrproject-rtos/zephyr/issues/26900
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 104 +++++++++++++++++++++++++++++--------
> 1 file changed, 83 insertions(+), 21 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ade83e224567..193bea314222 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -8269,6 +8269,63 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
> 	mutex_unlock(&conn->chan_lock);
> }
> 
> +/* Append fragment into frame respecting the maximum len of rx_skb */
> +static int l2cap_recv_frag(struct l2cap_conn *conn, struct sk_buff *skb,
> +			   u16 len)
> +{
> +	if (!conn->rx_skb) {
> +		/* Allocate skb for the complete frame (with header) */
> +		conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);
> +		if (!conn->rx_skb)
> +			return -ENOMEM;
> +		/* Init rx_len */
> +		conn->rx_len = len;
> +	}
> +
> +	/* Copy as much as the rx_skb can hold */
> +	len = min_t(u16, len, skb->len);
> +	skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, len), len);
> +	skb_pull(skb, len);
> +	conn->rx_len -= len;
> +
> +	return len;
> +}
> +
> +static int l2cap_recv_header(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	struct l2cap_hdr *hdr;
> +	struct sk_buff *rx_skb;
> +	int len;
> +
> +	/* Append just enough to complete the header */
> +	len = l2cap_recv_frag(conn, skb, L2CAP_HDR_SIZE - conn->rx_skb->len);
> +
> +	/* If header could not be read just continue */
> +	if (len < 0 || conn->rx_skb->len < L2CAP_HDR_SIZE)
> +		return len;
> +
> +	rx_skb = conn->rx_skb;
> +	conn->rx_skb = NULL;
> +
> +	hdr = (struct l2cap_hdr *) rx_skb->data;

so I think it is pointless to insist on getting the complete header. We really just need the first 2 octets.

struct l2cap_hdr {                                                               
        __le16     len;                                                          
        __le16     cid;                                                          
} __packed;

Once we have received at least 2 octets, we can get_unaligned_le16(rx_skb->data) and then just continue.

Regards

Marcel

