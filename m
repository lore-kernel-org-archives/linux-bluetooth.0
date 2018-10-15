Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8962AC28CF8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 06:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEE92086A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 06:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEE92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJOOcc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:32:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50515 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeJOOcc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Oct 2018 10:32:32 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id ED733CF35B;
        Mon, 15 Oct 2018 08:55:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] Bluetooth: Rockchip: Give nodes for registering in the
 device tree
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a83b2172-0a83-988e-d09f-ad5a39720cc9@davidjohnsummers.uk>
Date:   Mon, 15 Oct 2018 08:48:34 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F459D7EE-8AEF-404E-9572-004FCA8180B2@holtmann.org>
References: <20181014125014.3976-1-beagleboard@davidjohnsummers.uk>
 <F8F77105-FF67-4A23-BABE-7B0D70BD4DF5@holtmann.org>
 <a83b2172-0a83-988e-d09f-ad5a39720cc9@davidjohnsummers.uk>
To:     David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

>>> This patch adds the compatbility flags, so the Rockchip Bluetooth can
>>> be referenced in the device tree
>>> 
>>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>>> ---
>>> drivers/bluetooth/btrtl.c | 17 +++++++++++++++++
>>> 1 file changed, 17 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>>> index 7f9ea8e4c1b2..4cc89c9fe371 100644
>>> --- a/drivers/bluetooth/btrtl.c
>>> +++ b/drivers/bluetooth/btrtl.c
>>> @@ -20,6 +20,8 @@
>>> #include <asm/unaligned.h>
>>> #include <linux/usb.h>
>>> 
>>> +#include <linux/of.h>
>>> +
>>> #include <net/bluetooth/bluetooth.h>
>>> #include <net/bluetooth/hci_core.h>
>>> 
>>> @@ -743,6 +745,21 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>>> }
>>> EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
>>> 
>>> +static const struct of_device_id hci_rtl_of_match[] = {
>>> +	{ .compatible = "realtek,rtl8723a" },
>>> +	{ .compatible = "realtek,rtl8723bs" },
>>> +	{ .compatible = "realtek,rtl8723b" },
>>> +	{ .compatible = "realtek,rtl8723d" },
>>> +	{ .compatible = "realtek,rtl8723ds" },
>>> +	{ .compatible = "realtek,rtl8821a" },
>>> +	{ .compatible = "realtek,rtl8821c" },
>>> +	{ .compatible = "realtek,rtl8761a" },
>>> +	{ .compatible = "realtek,rtl8822b" },
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, hci_rtl_of_match);
>> this makes no sense in btrtl.c driver. This needs to be in hci_h5.c and bound to h5_serdev_driver.
>> 
>> Regards
>> 
>> Marcel
>> 
> Now I'm confused. hci_h5.c looks like the general 3 wire uart connection to bluetooth, which probably covers sdio devices like the 8723bs which uses sdio.
> 
> But what of the 8723b, which looks like a typo earlier in the code for the 8723bu which is usb device. Or say the 8723be which is PCIe.

the cards might be PCIe or SDIO for WiFi, but normally the Bluetooth part is connected either via USB or UART. I have not seen a PCIe Bluetooth card and the SDIO Bluetooth ones are existed only in the early Bluetooth 1.1 days.

> So if all sdio hci blue tooth cards should be specified with the hci_h5.c driver, and that is general 3 wire uart, then how should this be specified in the device tree?  Surely that should need a specification that says "hci uart", rather than a specific chip.

The hci_h5.c was actually a hack to support Realtek devices. I was against it, but it seems nobody wanted to actually work on my bt3wire.c proposal that I send around. The bt3wire.c was suppose to be a clean serdev based driver for all 3-Wire UART cards.

> The btrtl.c code looks like it loads drivers, so is it that drivers aren't needed in the hci uart devices made by realtek?

The btrtl.c is for common Realtek code shared between USB and UART. The same applies to btbcm.c, btintel.c etc. These modules will be loaded by dependencies on the drivers using them.

Regards

Marcel

