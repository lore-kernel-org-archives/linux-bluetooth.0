Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD71C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 10:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E3821773
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 10:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfDXK0w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:26:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53204 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDXK0v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 06:26:51 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3EDABCF351;
        Wed, 24 Apr 2019 12:35:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Bluetooth: btintel: improvement: mask vendor events from
 controller
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1556097059-31577-1-git-send-email-amit.k.bag@intel.com>
Date:   Wed, 24 Apr 2019 12:26:50 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <1F2562C9-0C63-410E-957C-1C79CA86A02E@holtmann.org>
References: <1556097059-31577-1-git-send-email-amit.k.bag@intel.com>
To:     Amit K Bag <amit.k.bag@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

> This patch mask unnecessary event notifications from controller to host
> 
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
> drivers/bluetooth/btintel.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5270d5513201..7e5cdd37cc1f 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -313,7 +313,7 @@ EXPORT_SYMBOL_GPL(btintel_load_ddc_config);
> 
> int btintel_set_event_mask(struct hci_dev *hdev, bool debug)
> {
> -	u8 mask[8] = { 0x87, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> +	u8 mask[8] = { 0x01, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> 	struct sk_buff *skb;
> 	int err;

so I enabled actually many more events to ensure we get proper output in btmon in case something happens. So you need to be more specific why we want to not enable these events for our hardware.

Regards

Marcel

