Return-Path: <SRS0=2sDM=QZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15734C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7234217F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 20:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="rNyaiSRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfBRUFS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:05:18 -0500
Received: from mail-gw.thundercloud.uk ([149.255.60.88]:59402 "EHLO
        mail-gw.thundercloud.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfBRUFR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Feb 2019 15:05:17 -0500
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk [149.255.60.72])
        by mail-gw.thundercloud.uk (Postfix) with ESMTPS id 2FC1A60A2F50
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Feb 2019 20:05:11 +0000 (GMT)
X-ASG-Debug-ID: 1550520310-0554131265235350001-Y6scnF
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id owO1GuFNhxEW7YlF (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO) for <linux-bluetooth@vger.kernel.org>; Mon, 18 Feb 2019 20:05:10 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C2d2fmiKKrJhoMv/UDMiduGVfCU4Ob+h464yXpnSw1s=; b=rNyaiSRCrPwjhAxTXiB6+EZsSx
        1DGcvv/4eHhwR4+ybf0MnB7V/UzPTtknFJxL1MOkQjxJljmhjr2IcQjsyXzt1kCTV6x/xXSOL3+tO
        LprymLnXpcpxJrEu4OZJx01Z4KwO2u3uX/KDh7/m3iinGuHhN0QKEs3HByUCCds3yXKLZYCd+291W
        bLz3/u3tfVrY9oQIKEUm2YDTI0F1hFZ+IDnOYDKe7qloMCIyzCdrTe1H/MuzczLj3+egBcPxbrRtb
        A5775KB1KVy0RpXGGiXIesQx8Jlkz711g1h0rH4Vj/hmUaB2jvujwYTfHU6sFKRsptZVXXW/e/Sry
        uRnZnTEw==;
Received: from [87.114.170.31] (port=58246 helo=[192.168.2.187])
        by cloud706.unlimitedwebhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <beagleboard@davidjohnsummers.uk>)
        id 1gvpA6-000N2y-9S; Mon, 18 Feb 2019 20:05:10 +0000
Subject: Re: drivers/bluetooth/Kconfig BT_HCIUART_RTL depends on ACPI
To:     Marcel Holtmann <marcel@holtmann.org>
X-ASG-Orig-Subj: Re: drivers/bluetooth/Kconfig BT_HCIUART_RTL depends on ACPI
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
References: <9d693bec-56c7-58a1-67b8-ba9edd63989d@davidjohnsummers.uk>
 <07109476-C017-4DC2-98A7-2EE5B53C4AB3@holtmann.org>
From:   David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <54432239-eb3c-45d0-a1a3-a7e5bd0d584d@davidjohnsummers.uk>
Date:   Mon, 18 Feb 2019 20:05:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <07109476-C017-4DC2-98A7-2EE5B53C4AB3@holtmann.org>
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
X-Barracuda-Start-Time: 1550520310
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 1700
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67542
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 18/02/2019 10:48, Marcel Holtmann wrote:
> Hi David,
>
>> On Arch Linux Arm, have a couple of people helping with the Tinker Board Patches - think we are close to something that may get passed.
>>
>> Now testing it far more, and a snag, drivers/bluetooth/Kconfig contains:
>>
>> config BT_HCIUART_RTL
>>      bool "Realtek protocol support"
>>      depends on BT_HCIUART
>>      depends on BT_HCIUART_SERDEV
>>      depends on GPIOLIB
>>      depends on ACPI
>>      select BT_HCIUART_3WIRE
>>      select BT_RTL
>>
>> But why does it depend on ACPI? I haven't found a way of setting that in 4.20, used to be in Power Management IIRC - but can't find now.
>>
>> find . -name Kconfig -type f -exec grep "select ACPI" '{}' \;
>>
>> Doesn't find anything to select ACPI …
> initially we only supported Realtek chips that are described via ACPI. For DT based ones you need to extend this. The Broadcom ones uses this line:
>
> depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
>
> Maybe this works here as well.
>
> Regards
>
> Marcel
>
Thanks Marcel,

Happy we have some else on ArchLinux ARM, Stefan Wahren, who has showed 
an interest in getting these things working. He has (very recently) had 
a go at and update, available here:

https://gist.github.com/lategoodbye/79bac99d4f1158a719a48ea3c45eb7f1

Any we have asked someone with a ASUS Tinker Board (S) to test. Stefan changes are good, because he has set up so it uses device tree - which is what we need on ARM. However he has said this was just a hack, so even if it works I expect he'll make more updates.

Hopefully though he'll be able to send a PATCH  in when he is ready.

Regards,

David

