Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E2C33CB2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCA324680
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgANOS3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:18:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50070 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgANOS3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:18:29 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6BCF8CECDE;
        Tue, 14 Jan 2020 15:27:45 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v2 09/10] Bluetooth: btusb: Add support for ISO packets
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200111022216.30842-10-luiz.dentz@gmail.com>
Date:   Tue, 14 Jan 2020 15:18:27 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <72D263C0-CFEA-4E0A-B0B0-F409D3606068@holtmann.org>
References: <20200111022216.30842-1-luiz.dentz@gmail.com>
 <20200111022216.30842-10-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This enabled btusb driver to properly transmit ISO packets.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btusb.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f5924f3e8b8d..ded0ba83bcce 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1463,6 +1463,13 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 		hdev->stat.sco_tx++;
> 		return submit_tx_urb(hdev, urb);
> +
> +	case HCI_ISODATA_PKT:
> +		urb = alloc_bulk_urb(hdev, skb);
> +		if (IS_ERR(urb))
> +			return PTR_ERR(urb);
> +
> +		return submit_or_queue_tx_urb(hdev, urb);
> 	}
> 
> 	return -EILSEQ;
> @@ -2123,6 +2130,13 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 		hdev->stat.sco_tx++;
> 		return submit_tx_urb(hdev, urb);
> +
> +	case HCI_ISODATA_PKT:
> +		urb = alloc_bulk_urb(hdev, skb);
> +		if (IS_ERR(urb))
> +			return PTR_ERR(urb);
> +
> +		return submit_or_queue_tx_urb(hdev, urb);
> 	}

please scrap this patch since there is no standard for this.

Also we should require a flag from the driver indicating support for ISO packets. If we are running on a system that requires ISO over HCI and we have a transport that doesn’t support it, we should not offer ISO support. We most likely should have been doing the same for SCO/eSCO packets. If the transport is not set correctly for these packets types, just disable the feature.

Regards

Marcel

