Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD55C04AA5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F145208E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 17:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F145208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJPBJb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:09:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58426 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeJPBJb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Oct 2018 21:09:31 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id EF22DCF361;
        Mon, 15 Oct 2018 19:30:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] Bluetooth: Rockchip: Give nodes for registering in the
 device tree
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <484e4a9f-1a58-1441-59b8-702152be12ea@davidjohnsummers.uk>
Date:   Mon, 15 Oct 2018 19:23:20 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DCBC7737-B449-4065-A81A-2B96FE0877F9@holtmann.org>
References: <20181014125014.3976-1-beagleboard@davidjohnsummers.uk>
 <F8F77105-FF67-4A23-BABE-7B0D70BD4DF5@holtmann.org>
 <a83b2172-0a83-988e-d09f-ad5a39720cc9@davidjohnsummers.uk>
 <F459D7EE-8AEF-404E-9572-004FCA8180B2@holtmann.org>
 <484e4a9f-1a58-1441-59b8-702152be12ea@davidjohnsummers.uk>
To:     David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

>>>>> This patch adds the compatbility flags, so the Rockchip Bluetooth can
>>>>> be referenced in the device tree
>>>>> 
>>>>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>>>>> ---
>>>>> drivers/bluetooth/btrtl.c | 17 +++++++++++++++++
>>>>> 1 file changed, 17 insertions(+)
>>>>> 
>>>>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>>>>> index 7f9ea8e4c1b2..4cc89c9fe371 100644
>>>>> --- a/drivers/bluetooth/btrtl.c
>>>>> +++ b/drivers/bluetooth/btrtl.c
>>>>> @@ -20,6 +20,8 @@
>>>>> #include <asm/unaligned.h>
>>>>> #include <linux/usb.h>
>>>>> 
>>>>> +#include <linux/of.h>
>>>>> +
>>>>> #include <net/bluetooth/bluetooth.h>
>>>>> #include <net/bluetooth/hci_core.h>
>>>>> 
>>>>> @@ -743,6 +745,21 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>>>>> }
>>>>> EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
>>>>> 
>>>>> +static const struct of_device_id hci_rtl_of_match[] = {
>>>>> +	{ .compatible = "realtek,rtl8723a" },
>>>>> +	{ .compatible = "realtek,rtl8723bs" },
>>>>> +	{ .compatible = "realtek,rtl8723b" },
>>>>> +	{ .compatible = "realtek,rtl8723d" },
>>>>> +	{ .compatible = "realtek,rtl8723ds" },
>>>>> +	{ .compatible = "realtek,rtl8821a" },
>>>>> +	{ .compatible = "realtek,rtl8821c" },
>>>>> +	{ .compatible = "realtek,rtl8761a" },
>>>>> +	{ .compatible = "realtek,rtl8822b" },
>>>>> +	{},
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, hci_rtl_of_match);
>>>> this makes no sense in btrtl.c driver. This needs to be in hci_h5.c and bound to h5_serdev_driver.
>>>> 
>>>> Regards
>>>> 
>>>> Marcel
>>>> 
>>> Now I'm confused. hci_h5.c looks like the general 3 wire uart connection to bluetooth, which probably covers sdio devices like the 8723bs which uses sdio.
>>> 
>>> But what of the 8723b, which looks like a typo earlier in the code for the 8723bu which is usb device. Or say the 8723be which is PCIe.
>> the cards might be PCIe or SDIO for WiFi, but normally the Bluetooth part is connected either via USB or UART. I have not seen a PCIe Bluetooth card and the SDIO Bluetooth ones are existed only in the early Bluetooth 1.1 days.
>> 
>>> So if all sdio hci blue tooth cards should be specified with the hci_h5.c driver, and that is general 3 wire uart, then how should this be specified in the device tree?  Surely that should need a specification that says "hci uart", rather than a specific chip.
>> The hci_h5.c was actually a hack to support Realtek devices. I was against it, but it seems nobody wanted to actually work on my bt3wire.c proposal that I send around. The bt3wire.c was suppose to be a clean serdev based driver for all 3-Wire UART cards.
>> 
>>> The btrtl.c code looks like it loads drivers, so is it that drivers aren't needed in the hci uart devices made by realtek?
>> The btrtl.c is for common Realtek code shared between USB and UART. The same applies to btbcm.c, btintel.c etc. These modules will be loaded by dependencies on the drivers using them.
>> 
>> Regards
>> 
>> Marcel
>> 
> Marcel,
> 
> Thank you for the reply. To give some background on why the patch was sent in. On Arch Arm we have two users who are using Asus Tinker Board (S) single board computers. The Tinker Board comes with AzureWave AW-NB177NF installed, and this has an internal Realtek RTL8723BS, which in turn has a UART Bluetooth device, with hci.
> 
> Currently these users can't use bluetooth. Now ideally we set up patches to mainline to correct problems like this. Once mainlined the solution is easy to maintain, and so arch arm would automatically support the devices.
> 
> Now the tinker boards being arm based (rk3288), they are device tree only for modern kernels. So how to set up the device tree for the bluetooth devices. The uart is attached to uart0 on the rk3288, ideally the RTL8723BS bluetooth would be on the serdev bus. A device tree extraction would look like:
> 
> &uart0 {
>         status = "okay";
>         pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
>         bluetooth {
>                 compatible = "realtek,rtl8723bs";
>         }
> };
> 
> So the bluetooth is connected via uart0 on a serdev bus.
> 
> However the kernel has no compatible = "realtek,rtl8723bs" to which to match.
> 
> The current /drivers/bluetooth has compatible for:
> 
> Marvell
> Mediatek
> Qcom
> TI
> Nokia
> 
> So it has nothing offering support for the Realtek rtl8723bs.
> 
> Now you say we should use hci_h5, which is a generic three wire UART HCI driver. This we could do via:
> 
>                 compatible = "realtek,rtl8723bs","bluetooth,hci_h5";
> 
> Or some similar generic name for the driver. However hci_h5 advertises nothing to the device tree for use in compatible.
> 
> The realtek device can only be detected by specification in the device tree, but this is not possible in the current kernel.
> 
> I'm not an expert in the kernel bluetooth code, so I'm happy to accept advice. I'm happy to try and code solutions. But would ask you what is the best way to reference realtek bluetooth devices in the kernel, and what code changes need to be written.
> 
> The AzureWave AW-NB177NF is a device that exists, it is used on modern hardware, like the Asus Tinke Board (S). All I see is how to support it?

you need to add DT matching support to h5_serdev_driver in hci_h5.c like this:

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..f9f80edc89ed 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -925,6 +925,14 @@ static struct h5_vnd rtl_vnd = {
 };
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id h5_of_match[] = {
+       { .compatible = "realtek,rtl8723bs-bluetoooth"},
+       { }
+};
+MODULE_DEVICE_TABLE(of, h5_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
@@ -940,6 +948,7 @@ static struct serdev_device_driver h5_serdev_driver = {
        .remove = h5_serdev_remove,
        .driver = {
                .name = "hci_uart_h5",
+               .of_match_table = of_match_ptr(h5_of_match),
                .acpi_match_table = ACPI_PTR(h5_acpi_match),
        },
 };

Note that you might need to use rtl8723bs-bluetooth in your DT description to differentiate between the WiFi and Bluetooth devices.

You most likely need also the #ifdef CONFIG_BT_HCIUART_RTL like for the OBDA8723 ACPI device so that it can map to rtl_vnd for the Realtek specific parts of the driver.

After that you also need to make sure you have the Enable GPIO and Device Wake GPIO set up in your DT description.

Regards

Marcel

