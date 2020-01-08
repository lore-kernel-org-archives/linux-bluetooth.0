Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3591FC282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CA320705
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgAHVWH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:22:07 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51458 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgAHVWH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:22:07 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id EA636CECFB;
        Wed,  8 Jan 2020 22:31:21 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 09/10] Bluetooth: btusb: Add support for ISO packets
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200107074056.25453-10-luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 22:22:05 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EA23917D-86E4-4C03-A74B-007E0EC691A4@holtmann.org>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
 <20200107074056.25453-10-luiz.dentz@gmail.com>
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

I am failing to see where it says to use bulk endpoints.

Regards

Marcel

