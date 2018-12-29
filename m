Return-Path: <SRS0=rkTY=PG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFABAC43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 16:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A54120449
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="KILhWlr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeL2Q5M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Dec 2018 11:57:12 -0500
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.84]:55975 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbeL2Q5L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Dec 2018 11:57:11 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Dec 2018 11:57:11 EST
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id E82DA62C676C
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Dec 2018 16:51:31 +0000 (GMT)
X-ASG-Debug-ID: 1546102291-055413120c642cc90001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id d9Gy3BFhNFmZvHf6 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO) for <linux-bluetooth@vger.kernel.org>; Sat, 29 Dec 2018 16:51:31 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7MXD+ztR+FtTB/RkKDaq2mL5feL/v7vSreZCl8OzH9U=; b=KILhWlr12xv+V30G1egXbKjLie
        TgOFt0jrUO8WwcYqqFqvNzgbL3O8D75mRnXLFJlyi3pFRlzZt7SI2QZRoigro4RScR7o/Cwv96T6D
        lhrlV8/nVgqfE7QMr0h1vpnmcQxffkeXX+hOJQCB8izV8BDZMIX5NqQ1l3Tlcl7PKraUGmeMJnG8y
        DWFnKm+nbKNXR+qyk4j5hp1UIKNkJxVmhLcJJbS4GpBMsi5zgac2nIm9L2oTeaG23OAWph28Kyb4z
        o8WE7symQTcIQ94VTabkYB5bktIHhzdmb7pInipK5TAc2yV+OpvZ4uSqURs+eAesiqB3UtPSTOTGT
        dyt0cBkQ==;
Received: from [87.112.196.180] (port=35718 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gdHph-003Lfu-TN; Sat, 29 Dec 2018 16:51:30 +0000
Subject: Re: [PATCH] bluetooth: realtek: devicetree: Add device tree
 description to bluetooth rtl drivers
To:     Marcel Holtmann <marcel@holtmann.org>
X-ASG-Orig-Subj: Re: [PATCH] bluetooth: realtek: devicetree: Add device tree
 description to bluetooth rtl drivers
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <40484b38-efbb-4a05-23af-c9ec6920c0df@davidjohnsummers.uk>
Date:   Sat, 29 Dec 2018 16:51:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-PH
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
X-Barracuda-Start-Time: 1546102291
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 2667
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.64738
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

And just looking at my patch, I remember I wrote this a month or so ago, 
thought it had been checked - but a couple of changes didn't make it in:

1) "bluetoooth" is spelled "bluetooth"
2) The realtek compatible should be wrapped in a "#ifdef 
CONFIG_BT_HCIUART_RTL" as hci_h5 needs that to have the realtek links in

I'll make these changes in a few days, but leave this patch here - in 
case there are any other comments.

Would hope to get basic nod by next week (yes know bad time for people 
over Christmas), as its free time I have to do the device tree that 
needs these in ...

Regards,

David.

On 29/12/2018 11:55, David Summers wrote:
> This patch add the relevent device tree handles to the bluetooth driver
> for serial realtek devices.
>
> Specifically it takes all devices listed in btrtk.c identifes from the
> realtek web site which are serial devices (this invariably means
> devices that end with and "s" in the device name).
>
> Most of these devices are dual wifi and bluetooth, with wifi on and
> sdio connection, and bluetooth on a serial uart. As these two
> interfaces will need independent listings in the device tree, the
> nodes here have "-bluetooth" added. The only exception is the
> rtl8761atv device, which is bluetooth only - and only has a uart
> interface.
>
> Can devicetree people revive the naming scheme used here, and confirm
> it is acceptable.
>
> Marcel, if the device tree people are happy can you apply to the
> bluetooth tree.
>
> Thanks,
>
> David.
>
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>   drivers/bluetooth/hci_h5.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..61c9e729efc1 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -925,6 +925,20 @@ static struct h5_vnd rtl_vnd = {
>   };
>   #endif
>   
> +#ifdef CONFIG_OF
> +static const struct of_device_id h5_of_match[] = {
> +       { .compatible = "realtek,rtl8723as-bluetoooth"},
> +       { .compatible = "realtek,rtl8723bs-bluetoooth"},
> +       { .compatible = "realtek,rtl8723ds-bluetoooth"},
> +       { .compatible = "realtek,rtl8761atv"},
> +       { .compatible = "realtek,rtl8821as-bluetoooth"},
> +       { .compatible = "realtek,rtl8821cs-bluetoooth"},
> +       { .compatible = "realtek,rtl8822bs-bluetoooth"},
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, h5_of_match);
> +#endif
> +
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id h5_acpi_match[] = {
>   #ifdef CONFIG_BT_HCIUART_RTL


