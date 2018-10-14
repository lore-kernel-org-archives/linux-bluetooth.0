Return-Path: <SRS0=msOO=M2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E8C71122
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 20:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C640F20835
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 20:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="QgI4s7Ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C640F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJOD7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Oct 2018 23:59:41 -0400
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.82]:60544 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbeJOD7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Oct 2018 23:59:41 -0400
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id ADE1F60C4624
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Oct 2018 21:17:26 +0100 (BST)
X-ASG-Debug-ID: 1539548223-055413120b1d90cf0001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id qyTUUq1K5mVE8zaq (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO) for <linux-bluetooth@vger.kernel.org>; Sun, 14 Oct 2018 21:17:03 +0100 (BST)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E3FLm9W2NdeyOHc5OCjIRZHOJaGtdyJFr9cfYs4W/ug=; b=QgI4s7CeRef1sv1AZk4ySZThot
        smzJ/Wl6lTsQzB+tmjacTyQ+gJopiRIGvxTTyTJSr3Th3gwvmo7C2sblemcOGyc021JOvBIak9MgE
        /rPlxt3YWZJlnMPgz6KWGiUpC6h1FRRcE9aXsVRFQRgDp51SU0WffpXOTnuyU8wSlYhuBSvyJ2DMP
        RryVNF0Q4KZPJL2CDo/k/8SqXFksBVjpxElwcdVy4KfijVk+b8zvj6ad1mFNVHt2OBTtX936GJDvG
        roZeptu6r0XFFJBK7tjFe7e7gT6z9DeYJlMQloXvRbJMxX0z68YRt9q/NMVpT+msr3Gq9KepVpU0b
        BZmK/U8g==;
Received: from [84.93.99.3] (port=42806 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gBmow-003gx6-M3; Sun, 14 Oct 2018 21:17:02 +0100
Subject: Re: [PATCH] Bluetooth: Rockchip: Give nodes for registering in the
 device tree
To:     Marcel Holtmann <marcel@holtmann.org>
X-ASG-Orig-Subj: Re: [PATCH] Bluetooth: Rockchip: Give nodes for registering in the
 device tree
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20181014125014.3976-1-beagleboard@davidjohnsummers.uk>
 <F8F77105-FF67-4A23-BABE-7B0D70BD4DF5@holtmann.org>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <a83b2172-0a83-988e-d09f-ad5a39720cc9@davidjohnsummers.uk>
Date:   Sun, 14 Oct 2018 21:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <F8F77105-FF67-4A23-BABE-7B0D70BD4DF5@holtmann.org>
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
X-Barracuda-Start-Time: 1539548223
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 2317
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.59723
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 14/10/2018 18:51, Marcel Holtmann wrote:
> Hi David,
>
>> This patch adds the compatbility flags, so the Rockchip Bluetooth can
>> be referenced in the device tree
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> ---
>> drivers/bluetooth/btrtl.c | 17 +++++++++++++++++
>> 1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>> index 7f9ea8e4c1b2..4cc89c9fe371 100644
>> --- a/drivers/bluetooth/btrtl.c
>> +++ b/drivers/bluetooth/btrtl.c
>> @@ -20,6 +20,8 @@
>> #include <asm/unaligned.h>
>> #include <linux/usb.h>
>>
>> +#include <linux/of.h>
>> +
>> #include <net/bluetooth/bluetooth.h>
>> #include <net/bluetooth/hci_core.h>
>>
>> @@ -743,6 +745,21 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>> }
>> EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
>>
>> +static const struct of_device_id hci_rtl_of_match[] = {
>> +	{ .compatible = "realtek,rtl8723a" },
>> +	{ .compatible = "realtek,rtl8723bs" },
>> +	{ .compatible = "realtek,rtl8723b" },
>> +	{ .compatible = "realtek,rtl8723d" },
>> +	{ .compatible = "realtek,rtl8723ds" },
>> +	{ .compatible = "realtek,rtl8821a" },
>> +	{ .compatible = "realtek,rtl8821c" },
>> +	{ .compatible = "realtek,rtl8761a" },
>> +	{ .compatible = "realtek,rtl8822b" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, hci_rtl_of_match);
> this makes no sense in btrtl.c driver. This needs to be in hci_h5.c and bound to h5_serdev_driver.
>
> Regards
>
> Marcel
>
Now I'm confused. hci_h5.c looks like the general 3 wire uart connection 
to bluetooth, which probably covers sdio devices like the 8723bs which 
uses sdio.

But what of the 8723b, which looks like a typo earlier in the code for 
the 8723bu which is usb device. Or say the 8723be which is PCIe.

So if all sdio hci blue tooth cards should be specified with the 
hci_h5.c driver, and that is general 3 wire uart, then how should this 
be specified in the device tree?  Surely that should need a 
specification that says "hci uart", rather than a specific chip.

The btrtl.c code looks like it loads drivers, so is it that drivers 
aren't needed in the hci uart devices made by realtek?

Sorry if I'm being stupid here, but I'm confused ...

Thanks,

David.

