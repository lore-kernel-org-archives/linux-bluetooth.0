Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6067CC04AA5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A3E208AE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 16:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="0F4cicYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A3E208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJOXtJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:49:09 -0400
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.84]:35334 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbeJOXtJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Oct 2018 19:49:09 -0400
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id 28208600B200
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Oct 2018 17:03:17 +0100 (BST)
X-ASG-Debug-ID: 1539619396-055413120a1e84c00001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id zaS27vLA1ypgGS5w (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO) for <linux-bluetooth@vger.kernel.org>; Mon, 15 Oct 2018 17:03:16 +0100 (BST)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X/UW5HvJqClWfvfQooQXW1xbR0meLLfwPquEPoCBk8g=; b=0F4cicYr4l9tNt+6WtgQPI0dlv
        /QCthVx5ZKPkwcvWbMJ4wwGk+yLr0e6zJ1K7PA1TrONYm7Qm6JN2i9qWy19MMad+9wY4Rg6bGhEM5
        IxNKCrBbxEgY0A/vYA3YhKxIGQzkAwTZCEfG/wA6poTpYNa2ln18vzAsQgGR0Y5yYmGf3ZSvz8lr2
        DQ8fmBL3hbGmSoYKpeRHmTSbMkhlLSOuauvdu1IKpYeHyR2E6Mt9l8jMxeCloYjgaNmjhCKpaKztr
        m0fvjNUZYlH/LD5AKjw3X9+rJ1fhyH+VfVHs+04FtOgL7rCnIxFD8uB9b9E/VUykFrnf/HIF4XgSk
        w3WzS4ew==;
Received: from 173.81.112.87.dyn.plus.net ([87.112.81.173]:47498 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gC5Kt-005zEV-8i; Mon, 15 Oct 2018 17:03:15 +0100
Subject: Re: [PATCH] Bluetooth: Rockchip: Give nodes for registering in the
 device tree
To:     Marcel Holtmann <marcel@holtmann.org>,
        David Summers <beagleboard@davidjohnsummers.uk>
X-ASG-Orig-Subj: Re: [PATCH] Bluetooth: Rockchip: Give nodes for registering in the
 device tree
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20181014125014.3976-1-beagleboard@davidjohnsummers.uk>
 <F8F77105-FF67-4A23-BABE-7B0D70BD4DF5@holtmann.org>
 <a83b2172-0a83-988e-d09f-ad5a39720cc9@davidjohnsummers.uk>
 <F459D7EE-8AEF-404E-9572-004FCA8180B2@holtmann.org>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <484e4a9f-1a58-1441-59b8-702152be12ea@davidjohnsummers.uk>
Date:   Mon, 15 Oct 2018 17:03:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <F459D7EE-8AEF-404E-9572-004FCA8180B2@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud706.unlimitedwebhosting.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - davidjohnsummers.uk
X-Get-Message-Sender-Via: cloud706.unlimitedwebhosting.co.uk: authenticated_id: davidjoh/from_h
X-Authenticated-Sender: cloud706.unlimitedwebhosting.co.uk: beagleboard@davidjohnsummers.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Barracuda-Connect: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Start-Time: 1539619396
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 5347
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.59782
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 15/10/2018 07:48, Marcel Holtmann wrote:
> Hi David,
>
>>>> This patch adds the compatbility flags, so the Rockchip Bluetooth can
>>>> be referenced in the device tree
>>>>
>>>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>>>> ---
>>>> drivers/bluetooth/btrtl.c | 17 +++++++++++++++++
>>>> 1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>>>> index 7f9ea8e4c1b2..4cc89c9fe371 100644
>>>> --- a/drivers/bluetooth/btrtl.c
>>>> +++ b/drivers/bluetooth/btrtl.c
>>>> @@ -20,6 +20,8 @@
>>>> #include <asm/unaligned.h>
>>>> #include <linux/usb.h>
>>>>
>>>> +#include <linux/of.h>
>>>> +
>>>> #include <net/bluetooth/bluetooth.h>
>>>> #include <net/bluetooth/hci_core.h>
>>>>
>>>> @@ -743,6 +745,21 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>>>> }
>>>> EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
>>>>
>>>> +static const struct of_device_id hci_rtl_of_match[] = {
>>>> +	{ .compatible = "realtek,rtl8723a" },
>>>> +	{ .compatible = "realtek,rtl8723bs" },
>>>> +	{ .compatible = "realtek,rtl8723b" },
>>>> +	{ .compatible = "realtek,rtl8723d" },
>>>> +	{ .compatible = "realtek,rtl8723ds" },
>>>> +	{ .compatible = "realtek,rtl8821a" },
>>>> +	{ .compatible = "realtek,rtl8821c" },
>>>> +	{ .compatible = "realtek,rtl8761a" },
>>>> +	{ .compatible = "realtek,rtl8822b" },
>>>> +	{},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, hci_rtl_of_match);
>>> this makes no sense in btrtl.c driver. This needs to be in hci_h5.c and bound to h5_serdev_driver.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>> Now I'm confused. hci_h5.c looks like the general 3 wire uart connection to bluetooth, which probably covers sdio devices like the 8723bs which uses sdio.
>>
>> But what of the 8723b, which looks like a typo earlier in the code for the 8723bu which is usb device. Or say the 8723be which is PCIe.
> the cards might be PCIe or SDIO for WiFi, but normally the Bluetooth part is connected either via USB or UART. I have not seen a PCIe Bluetooth card and the SDIO Bluetooth ones are existed only in the early Bluetooth 1.1 days.
>
>> So if all sdio hci blue tooth cards should be specified with the hci_h5.c driver, and that is general 3 wire uart, then how should this be specified in the device tree?  Surely that should need a specification that says "hci uart", rather than a specific chip.
> The hci_h5.c was actually a hack to support Realtek devices. I was against it, but it seems nobody wanted to actually work on my bt3wire.c proposal that I send around. The bt3wire.c was suppose to be a clean serdev based driver for all 3-Wire UART cards.
>
>> The btrtl.c code looks like it loads drivers, so is it that drivers aren't needed in the hci uart devices made by realtek?
> The btrtl.c is for common Realtek code shared between USB and UART. The same applies to btbcm.c, btintel.c etc. These modules will be loaded by dependencies on the drivers using them.
>
> Regards
>
> Marcel
>
Marcel,

Thank you for the reply. To give some background on why the patch was 
sent in. On Arch Arm we have two users who are using Asus Tinker Board 
(S) single board computers. The Tinker Board comes with AzureWave 
AW-NB177NF installed, and this has an internal Realtek RTL8723BS, which 
in turn has a UART Bluetooth device, with hci.

Currently these users can't use bluetooth. Now ideally we set up patches 
to mainline to correct problems like this. Once mainlined the solution 
is easy to maintain, and so arch arm would automatically support the 
devices.

Now the tinker boards being arm based (rk3288), they are device tree 
only for modern kernels. So how to set up the device tree for the 
bluetooth devices. The uart is attached to uart0 on the rk3288, ideally 
the RTL8723BS bluetooth would be on the serdev bus. A device tree 
extraction would look like:

&uart0 {
         status = "okay";
         pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
         bluetooth {
                 compatible = "realtek,rtl8723bs";
         }
};

So the bluetooth is connected via uart0 on a serdev bus.

However the kernel has no compatible = "realtek,rtl8723bs" to which to 
match.

The current /drivers/bluetooth has compatible for:

Marvell
Mediatek
Qcom
TI
Nokia

So it has nothing offering support for the Realtek rtl8723bs.

Now you say we should use hci_h5, which is a generic three wire UART HCI 
driver. This we could do via:

                 compatible = "realtek,rtl8723bs","bluetooth,hci_h5";

Or some similar generic name for the driver. However hci_h5 advertises 
nothing to the device tree for use in compatible.

The realtek device can only be detected by specification in the device 
tree, but this is not possible in the current kernel.

I'm not an expert in the kernel bluetooth code, so I'm happy to accept 
advice. I'm happy to try and code solutions. But would ask you what is 
the best way to reference realtek bluetooth devices in the kernel, and 
what code changes need to be written.

The AzureWave AW-NB177NF is a device that exists, it is used on modern 
hardware, like the Asus Tinke Board (S). All I see is how to support it?

Any advice you have would be welcome.

Regards,

David.

