Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815E6C282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9832073D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="CS8P/R/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfBDUgj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:36:39 -0500
Received: from mail-gw.unlimitedwebhosting.co.uk ([149.255.60.82]:52908 "EHLO
        mail-gw.unlimitedwebhosting.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbfBDUgj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 15:36:39 -0500
Received: from uwhbsf01.unlimitedwebhosting.co.uk (mail-gw.unlimitedwebhosting.co.uk [149.255.60.72])
        by mail-gw.unlimitedwebhosting.co.uk (Postfix) with ESMTPS id 1D8B5612C139
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Feb 2019 20:36:33 +0000 (GMT)
X-ASG-Debug-ID: 1549312592-055413020b1cecc30001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by uwhbsf01.unlimitedwebhosting.co.uk with ESMTP id Y1UKnTNx8Y5jCVh1 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO) for <linux-bluetooth@vger.kernel.org>; Mon, 04 Feb 2019 20:36:32 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yN3Cb6ejnp03/HY+MhbwwPVTTNRV3YgJeZmXzfe6SXo=; b=CS8P/R/zziAlY7PL7cGiSLx5Et
        f2+BMLAeYeRB6wbirH+fvndQ/ZIi0VqNXAAxb/odWyRFkuqwbO4KmkM7PaN9v4JJbr4X1EJ5K++s8
        sTjGToKz9t253PYfejCiHI/ZzSGzYyLn5p+mmEOSZh3NNSUCOtuFm2hBFD+m3EbGQX5tX+Hfk+beJ
        hUQE3yY6bAZoHPmhrB948Vdy17KoJkNiKULr8C1t+DebpNa68IRImtVoXuh5EhcjwhLNnDFDMMNmd
        E+8khKJZoJJrEnwD7u/RYwJt98w3HQs30kgmRmHDW8dW4mGROiX8LOaSYTMN7TGafgE3cARmb7J02
        b3HXFCeQ==;
Received: from [87.112.136.206] (port=54156 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gqkyl-000CqJ-LS; Mon, 04 Feb 2019 20:36:31 +0000
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Subject: drivers/bluetooth/Kconfig BT_HCIUART_RTL depends on ACPI
Message-ID: <9d693bec-56c7-58a1-67b8-ba9edd63989d@davidjohnsummers.uk>
X-ASG-Orig-Subj: drivers/bluetooth/Kconfig BT_HCIUART_RTL depends on ACPI
Date:   Mon, 4 Feb 2019 20:36:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Barracuda-Start-Time: 1549312592
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at unlimitedwebhosting.co.uk
X-Barracuda-Scan-Msg-Size: 750
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.66987
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Arch Linux Arm, have a couple of people helping with the Tinker Board 
Patches - think we are close to something that may get passed.

Now testing it far more, and a snag, drivers/bluetooth/Kconfig contains:

config BT_HCIUART_RTL
     bool "Realtek protocol support"
     depends on BT_HCIUART
     depends on BT_HCIUART_SERDEV
     depends on GPIOLIB
     depends on ACPI
     select BT_HCIUART_3WIRE
     select BT_RTL

But why does it depend on ACPI? I haven't found a way of setting that in 
4.20, used to be in Power Management IIRC - but can't find now.

find . -name Kconfig -type f -exec grep "select ACPI" '{}' \;

Doesn't find anything to select ACPI ...

Any ideas?

David.

