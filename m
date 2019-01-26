Return-Path: <SRS0=qwpb=QC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFDC282C7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958FD218B0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="2cl4ygWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfAZO3C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 09:29:02 -0500
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.88]:38108 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfAZO3C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 09:29:02 -0500
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id B1F6A602D3DF
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 14:29:00 +0000 (GMT)
X-ASG-Debug-ID: 1548512940-055413120a7707fa0001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id 5GyKw09K3j3GPGjL (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 26 Jan 2019 14:29:00 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1scTvgr80A23xIvV/8ok55Ux9jO4CmLVyK/zv9BSDCs=; b=2cl4ygWUBoO2cps3vwKu+hOSyy
        /6iELXTqoq/vtEbGg6MLwot0B2bz4p/9pWWE1XEQkK/VdNR2qjOaBLq1O7wAzTr37xiKPFyAhRcUS
        jfrBeysGr+9pDCmaiFj2wx1DOGnrA+eg4z+i4IS1HG0Fhyw8pnR05vxh92CglfGqFqxslacp9A4Ug
        9hh8fdWSH0unuknQ4nzGh48wt136iWCSyuICPFTOYKbR42Zc4VHOCFSmu3p1G+p32r2lytsH2Rayk
        yfrP55OPcPVxZU5KxldCgL7gdDW8HmVcjzMKV86RY0bUnf6zEUOmzLX0Rh0Oa6oTRvFjFa5f6EfSu
        xasESMaw==;
Received: from [87.113.131.230] (port=39488 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gnOx9-000Clr-1X; Sat, 26 Jan 2019 14:28:59 +0000
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_h5: Add the Realtek compatible
 flags for the device tree
To:     David Summers <beagleboard@davidjohnsummers.uk>,
        robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com
X-ASG-Orig-Subj: Re: [PATCH v4 1/2] Bluetooth: hci_h5: Add the Realtek compatible
 flags for the device tree
Cc:     linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
References: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <5a99337a-c33b-7dd6-dbdb-6945ec976ea4@davidjohnsummers.uk>
Date:   Sat, 26 Jan 2019 14:28:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
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
X-Barracuda-Start-Time: 1548512940
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 1331
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=BSF_SC0_SA_TO_FROM_ADDR_MATCH
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.66440
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_SC0_SA_TO_FROM_ADDR_MATCH Sender Address Matches Recipient
                                   Address
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch has been withdrawn.

On 21/01/2019 20:39, David Summers wrote:
> With the changes requested by Marcel Holtmann and Rob Herring.
>
> The patch is unchanged, but subject changed to the norm.
>
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>   drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..056ab2decccc 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
>   };
>   #endif
>   
> +#ifdef CONFIG_OF
> +static const struct of_device_id h5_of_match[] = {
> +#ifdef CONFIG_BT_HCIUART_RTL
> +       { .compatible = "realtek,rtl8723as-bt"},
> +       { .compatible = "realtek,rtl8723bs-bt"},
> +       { .compatible = "realtek,rtl8723ds-bt"},
> +       { .compatible = "realtek,rtl8761atv"},
> +       { .compatible = "realtek,rtl8821as-bt"},
> +       { .compatible = "realtek,rtl8821cs-bt"},
> +       { .compatible = "realtek,rtl8822bs-bt"},
> +#endif
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, h5_of_match);
> +#endif
> +
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id h5_acpi_match[] = {
>   #ifdef CONFIG_BT_HCIUART_RTL


