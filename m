Return-Path: <SRS0=msOO=M2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F15C71122
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073112064E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 17:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073112064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeJOBd3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:33:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50152 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOBd2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Oct 2018 21:33:28 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0A37ACF355;
        Sun, 14 Oct 2018 19:59:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] Bluetooth: Rockchip: Give nodes for registering in the
 device tree
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181014125014.3976-1-beagleboard@davidjohnsummers.uk>
Date:   Sun, 14 Oct 2018 19:51:40 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F8F77105-FF67-4A23-BABE-7B0D70BD4DF5@holtmann.org>
References: <20181014125014.3976-1-beagleboard@davidjohnsummers.uk>
To:     David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

> This patch adds the compatbility flags, so the Rockchip Bluetooth can
> be referenced in the device tree
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
> drivers/bluetooth/btrtl.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 7f9ea8e4c1b2..4cc89c9fe371 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -20,6 +20,8 @@
> #include <asm/unaligned.h>
> #include <linux/usb.h>
> 
> +#include <linux/of.h>
> +
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> 
> @@ -743,6 +745,21 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
> }
> EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
> 
> +static const struct of_device_id hci_rtl_of_match[] = {
> +	{ .compatible = "realtek,rtl8723a" },
> +	{ .compatible = "realtek,rtl8723bs" },
> +	{ .compatible = "realtek,rtl8723b" },
> +	{ .compatible = "realtek,rtl8723d" },
> +	{ .compatible = "realtek,rtl8723ds" },
> +	{ .compatible = "realtek,rtl8821a" },
> +	{ .compatible = "realtek,rtl8821c" },
> +	{ .compatible = "realtek,rtl8761a" },
> +	{ .compatible = "realtek,rtl8822b" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, hci_rtl_of_match);

this makes no sense in btrtl.c driver. This needs to be in hci_h5.c and bound to h5_serdev_driver.

Regards

Marcel

