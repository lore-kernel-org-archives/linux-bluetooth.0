Return-Path: <SRS0=K0Cw=M5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB8AECDE32
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 07:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C66921526
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 07:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C66921526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJQO7z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:59:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33332 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeJQO7z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 10:59:55 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4E048CEEAD;
        Wed, 17 Oct 2018 09:13:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v1] Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME
 device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BYAPR04MB4824479589D351B829CF3391C0FF0@BYAPR04MB4824.namprd04.prod.outlook.com>
Date:   Wed, 17 Oct 2018 09:05:39 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5BDD6490-7BE9-45FE-8DFA-6343294BEF9B@holtmann.org>
References: <BYAPR04MB4824479589D351B829CF3391C0FF0@BYAPR04MB4824.namprd04.prod.outlook.com>
To:     Owen Lin <olin@rivetnetworks.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Owen,

> From 83372e39753124ab1afbe651a45e3416bede25a6 Mon Sep 17 00:00:00 2001
> From: Owen Lin <olin@rivetnetworks.com>
> Date: Wed, 17 Oct 2018 11:36:03 +0800
> Subject: [PATCH v1] Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME device

please include the content from /sys/kernel/debug/usb/devices for this hardware in the commit message.

> 
> Signed-off-by: Owen Lin <olin@rivetnetworks.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index cd2e5cf14ea5..838af7dd5b73 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -264,6 +264,7 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
> 
> 	/* QCA ROME chipset */
> +	{ USB_DEVICE(0x0cf3, 0x535b), .driver_info = BTUSB_QCA_ROME },
> 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
> 	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME },
> 	{ USB_DEVICE(0x0cf3, 0xe010), .driver_info = BTUSB_QCA_ROME },

Regards

Marcel

