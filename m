Return-Path: <SRS0=MOIW=P3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A739FC61CE8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDB2087E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 13:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="N6O4McOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfASNTE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:19:04 -0500
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.84]:58932 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727965AbfASNTE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Jan 2019 08:19:04 -0500
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id 8DE706046C50
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jan 2019 13:18:58 +0000 (GMT)
X-ASG-Debug-ID: 1547903937-0554135c625f9a830001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id aGvPC87c5ATCMuVr (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 19 Jan 2019 13:18:57 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KK/nm8qlolgtyPfVa1duixwaxfI3jCY0YzBZYMtaqSo=; b=N6O4McODhz6WLFfrNyzy+BC/yZ
        l8aWfhfexyfwJPU56vko19mKg9eGwGBou70V8A+a1ufhXXk1SwKUigVpimlkuci/s422QKDSf+e6j
        8l5mhzfOJSxSbuOFPLVN2Su/ITNskYIHE3VrGzJc0iU0/33X1gaJ1uqG7hTtozT1fbN8SGHp97CBb
        kf6JoXO/lGR6om7sLP/xt11JWigqWlAMoKCQRk6lE1m8Y8CbSnyLT6MyRIMoDY5zx2JRKs6gA4A6v
        V6N5L6/0gb8g5Rxc6AZKJ6piHLMLbKWj8l8NU0fj2Ke7ieDV/X35h3b44uFWzpEQroUGfk1K+dmlm
        +yLk2lLA==;
Received: from [87.112.215.184] (port=55780 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gkqWX-000Ta4-Bu; Sat, 19 Jan 2019 13:18:57 +0000
Subject: Re: [PATCHv2] Patch to add the realtek bluetooth device tree refs to
 the code
To:     Marcel Holtmann <marcel@holtmann.org>
X-ASG-Orig-Subj: Re: [PATCHv2] Patch to add the realtek bluetooth device tree refs to
 the code
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-2-beagleboard@davidjohnsummers.uk>
 <510BE8B9-76BD-4A64-86C2-ACA1D50819DF@holtmann.org>
From:   beagleboard@davidjohnsummers.uk
Message-ID: <4b098970-9644-12b4-c6f1-2e66ffbe24fa@davidjohnsummers.uk>
Date:   Sat, 19 Jan 2019 13:18:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <510BE8B9-76BD-4A64-86C2-ACA1D50819DF@holtmann.org>
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
X-Barracuda-Start-Time: 1547903937
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 2041
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=NO_REAL_NAME
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65955
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 NO_REAL_NAME           From: does not include a real name
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Yes have been having an email conversation with Rob on the device tree 
email list.

he wants minor changes to the naming, which i agree with. So have much 
of a revised patch set read to send in. Just need to check some things.

Hopefully be able to send later this weekend, and it will replace the 
patch below.

Thanks,

David.

On 18/01/2019 10:57, Marcel Holtmann wrote:
> Hi David,
>
>> This patch adds the necessary device tree hooks to the realtek
>> bluetooth driver for serial connections.
>>
>> The realtek devices that are listed btrtl.c are searched on the
>> realtek web site for the version that have serial connections.
>>
>> Most of these devices also have wi-fi connected via sdio, that is not
>> covered by the bluetooth driver - but as that interface will also be
>> needed in the device tree, the hocks here have "-bluetooth" added. The
>> exception to this is the rtl8761atv, which only has a serial
>> bluetooth.
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> ---
>> drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
>> 1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
>> index 8eede1197cd2..2fec7ff2ce7c 100644
>> --- a/drivers/bluetooth/hci_h5.c
>> +++ b/drivers/bluetooth/hci_h5.c
>> @@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
>> };
>> #endif
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id h5_of_match[] = {
>> +#ifdef CONFIG_BT_HCIUART_RTL
>> +       { .compatible = "realtek,rtl8723as-bluetooth"},
>> +       { .compatible = "realtek,rtl8723bs-bluetooth"},
>> +       { .compatible = "realtek,rtl8723ds-bluetooth"},
>> +       { .compatible = "realtek,rtl8761atv"},
>> +       { .compatible = "realtek,rtl8821as-bluetooth"},
>> +       { .compatible = "realtek,rtl8821cs-bluetooth"},
>> +       { .compatible = "realtek,rtl8822bs-bluetooth"},
>> +#endif
> I really need an Ack from Rob on the naming here.
>
> Regards
>
> Marcel
>

