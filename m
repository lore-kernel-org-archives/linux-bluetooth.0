Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0DC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798EA61244
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhGVNXP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:23:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51693 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhGVNXP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 09:23:15 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id ACF84CECDC;
        Thu, 22 Jul 2021 16:03:48 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v4 2/2] Bluetooth: btusb: Support Bluetooth Reset for
 Mediatek Chip(MT7921)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210701194243.5449-2-mark-yw.chen@mediatek.com>
Date:   Thu, 22 Jul 2021 16:03:48 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com,
        apusaka@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <0FDB7895-4ABF-4975-AF61-FCFA86597254@holtmann.org>
References: <20210701194243.5449-1-mark-yw.chen@mediatek.com>
 <20210701194243.5449-2-mark-yw.chen@mediatek.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> When the firmware hang or command no response, driver can reset the
> bluetooth mcu via USB to recovery it. The reset steps as follows.
> 
> 1. Cancel USB transfer requests before reset.
> 2. It use speicific USB HW Register to reset Bluetooth MCU, at the
>   same time, the USB Endpoint0 still keep alive.
> 3. Poll the USB HW register until reset is completed by Endpoint0.
> 4. To recovery unexpected USB state and behavior during resetting the
>   Bluetooth MCU, the driver need to reset the USB device for MT7921.
> 5. After the reset is completed, the Bluetooth MCU need to re-setup,
>   such as download patch, power-on sequence and etc.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 127 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 127 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b1249b664981..122a928ebcb5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3076,6 +3076,17 @@ static int btusb_shutdown_intel_new(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +/* UHW CR mapping */
> +#define BT_MISC			0x70002510
> +#define BT_SUBSYS_RST		0x70002610
> +#define UDMA_INT_STA_BT		0x74000024
> +#define UDMA_INT_STA_BT1	0x74000308
> +#define BT_WDT_STATUS		0x740003A0
> +#define EP_RST_OPT		0x74011890
> +#define EP_RST_IN_OUT_OPT	0x00010001
> +#define BT_RST_DONE		0x00000100
> +#define BT_RESET_WAIT_MS	100
> +#define BT_RESET_NUM_TRIES	10

you need to prefix these with MTK since otherwise we get confused.

And we need to work towards abstracting the vendor specific position out of btusb.c (and I include the Intel part here as well). The btusb.c is getting overloaded with vendor stuff.

Regards

Marcel

