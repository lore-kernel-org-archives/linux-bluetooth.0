Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA3CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 09:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445909AbiDVJVN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445951AbiDVJVE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 05:21:04 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DBBC194;
        Fri, 22 Apr 2022 02:17:59 -0700 (PDT)
Received: from smtpclient.apple (p4fefc32f.dip0.t-ipconnect.de [79.239.195.47])
        by mail.holtmann.org (Postfix) with ESMTPSA id B14AACECD5;
        Fri, 22 Apr 2022 11:17:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220413125415.20293-1-ismael@iodev.co.uk>
Date:   Fri, 22 Apr 2022 11:17:58 +0200
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <79CCD62B-056A-4135-BB70-EAC840249434@holtmann.org>
References: <20220413125415.20293-1-ismael@iodev.co.uk>
To:     Ismael Luceno <ismael@iodev.co.uk>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ismael,

> Identifies as just "Realtek Semiconductor Corp."; it's used in many
> adapters, e.g.:
> 
> - UGREEN CM390
> - C-TECH BTD-01
> - Orico BTA-508
> 
> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> ---
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2afbd87d77c9..07db720baaa0 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -490,6 +490,10 @@ MODULE_DEVICE_TABLE(usb, btusb_table);
> 	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
> 						     BTUSB_WIDEBAND_SPEECH },
> 
> +	/* Additional Realtek 8761BUV Bluetooth devices */
> +	{ USB_DEVICE(0x0bda, 0x8771), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +
> 	/* Additional Realtek 8821AE Bluetooth devices */
> 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
> 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },

please include /sys/kernel/debug/usb/devices part of this device in your commit message.

Regards

Marcel

