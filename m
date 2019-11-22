Return-Path: <SRS0=qr/Y=ZO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF736C432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 12:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A5020718
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 12:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKVMC0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:02:26 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51918 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKVMC0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Nov 2019 07:02:26 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8A1EECED1E;
        Fri, 22 Nov 2019 13:11:31 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v3] bluetooth: bcm: Use the BDADDR_PROPERTY quirk for
 Orange Pi 3
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191122100449.1994340-1-a.heider@gmail.com>
Date:   Fri, 22 Nov 2019 13:02:24 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Transfer-Encoding: 7bit
Message-Id: <8DC66A76-B77D-4088-86EC-5182128D0220@holtmann.org>
References: <20191122100449.1994340-1-a.heider@gmail.com>
To:     Andre Heider <a.heider@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andre,

> Some devices ship with the controller default address, like the
> Orange Pi 3 (BCM4345C5).
> 
> Allow the bootloader to set a valid address through the device tree.
> 
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
> drivers/bluetooth/btbcm.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 2d2e6d862068..e20e7da45377 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -8,6 +8,7 @@
> 
> #include <linux/module.h>
> #include <linux/firmware.h>
> +#include <linux/of.h>
> #include <asm/unaligned.h>
> 
> #include <net/bluetooth/bluetooth.h>
> @@ -440,6 +441,12 @@ int btbcm_finalize(struct hci_dev *hdev)
> 
> 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 
> +	/* Some devices ship with the controller default address.
> +	 * Allow the bootloader to set a valid address through the device tree.
> +	 */
> +	if (of_machine_is_compatible("xunlong,orangepi-3"))
> +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +

just make it unconditional. I think this will be just fine.

Regards

Marcel

