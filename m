Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A6AC388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 11:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E803D2072C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 11:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgKKLHQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:07:16 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37586 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgKKLHQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 06:07:16 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id 43AA6CECFD;
        Wed, 11 Nov 2020 12:14:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 3/3] Bluetooth: hci_bcm: Ignore deprecated command fail
 case
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201014054746.2507-1-amitesh.chandra@gmail.com>
Date:   Wed, 11 Nov 2020 12:07:13 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        amitesh.chandra@broadcom.com, ravi.nagarajan@broadcom.com,
        cheneyni@google.com, Manoj Babulal <manoj.babulal@broadcom.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <53807E62-2444-46EA-A2C8-30442263B101@holtmann.org>
References: <20201014054746.2507-1-amitesh.chandra@gmail.com>
To:     Amitesh Chandra <amitesh.chandra@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amitesh,

> Broadcom VSC uart_clock_setting is deprecated in
> newer controllers. Ignore error if the controller
> returns invalid or bad request error code.
> 
> Signed-off-by: Amitesh Chandra <amitesh.chandra@broadcom.com>
> Signed-off-by: Manoj Babulal <manoj.babulal@broadcom.com>
> ---
> drivers/bluetooth/hci_bcm.c | 15 +++++++++------
> 1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 680478f..d316788 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -158,15 +158,18 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> 		skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
> 		if (IS_ERR(skb)) {
> 			int err = PTR_ERR(skb);
> -			bt_dev_err(hdev, "BCM: failed to write clock (%d)",
> -				   err);
> -			return err;
> +			/* Ignore err if command is deprecated in controller */
> +			if (err != -EBADRQC) {
> +				bt_dev_err(hdev, "BCM: failed to write "
> +						"clock (%d)", err);
> +				return err;
> +			}
> +		} else {
> +			kfree_skb(skb);
> 		}
> -
> -		kfree_skb(skb);
> 	}

So I really disliked try-and-error of HCI commands. Can we know up-front
somehow if the controller supports a command or not. It is a total waste of
time to send a command that might fail. So we better know this before
sending it.

Regards

Marcel

