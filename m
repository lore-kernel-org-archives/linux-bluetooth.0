Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8CCC388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 23:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACF02168B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 23:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vb7afP0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKUXAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Nov 2020 18:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKUXAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Nov 2020 18:00:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F45C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 15:00:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id w24so13830053wmi.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 15:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A582mc+X46A+mQGx7MsTNlhs58iMV3P1d1nvj5f3PXM=;
        b=vb7afP0/v3DDelx4vRF/kev2bHlyOTBMHJLC3wyNEe0nJGN6cxKRP1V28y2wLI6GzB
         1MMYwb5y+/tnV0DKuv1DwMf70Xk/NHAyhxXM02KmY6crIlwFM3//q21L51akP9kYwfWT
         uAlXKnH/AlllXpCC3nbK0J1Yg0XwMsloGZZw/8hzZ937dYpL9/o5D5Lh4zKgcfAPywM7
         xb2znChcEcvuEkiLZ+isTGacn9xoWOm/dyhNlY/+UDeLrAxuoZ/keCf7dCeMKh2j791m
         hkfGSFrSrYoOjX10kSQkOoRj82BFdmlkWTYf/HV6dgtqxn8+Ga8RR9KdTFQDY0Iv/6gR
         m7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=A582mc+X46A+mQGx7MsTNlhs58iMV3P1d1nvj5f3PXM=;
        b=f9Q3YOWLV1D61jJyQFG0Jw2gwpANOWL7VU+hKmh2ScETsNoQ8EeVJsGWvFFLTHbIyX
         WL4KEwHKXgNnC5TpcognXosztH72THYn+IR5U332DZDSPU7y/QHdfZjTU6sGBL3eKRz3
         HNyS57PEkJA13W9TRAHwmedGLFsGLNuUczW2wJ8mAbJ+jqxPWoF3PzBT6+FOnZsCb5vZ
         QHimEjiyBpDVaZPVMDHD88mIVP/Vm/6azkHOWDpBXKTsZqrntTUSsUoxbajcgVYv9Drw
         e4dif2m/YId3uJ1cyBNgK5A/XLq6du1EhkVNankEaMRWygL1sp0tDCx5kxXSuH9kLM8W
         bXhw==
X-Gm-Message-State: AOAM531Ed1BKMHGea3TEnGup9BVwCKUbv8BIAuZx9sPk8OljutYQcvX3
        XrmYLi34A+z2/xY0Dn6Kzt/vV62FTFWCzA==
X-Google-Smtp-Source: ABdhPJztZMa/pJTpJJh/F4YyMA2ibP5zoL8m1E/8vQ9Ah8B7MjClloX7/PhNDpxFtsaAlK7burGeqw==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr16046579wme.113.1605999617016;
        Sat, 21 Nov 2020 15:00:17 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:f88a:cca6:feee:cbdc? (p200300ea8f232800f88acca6feeecbdc.dip0.t-ipconnect.de. [2003:ea:8f23:2800:f88a:cca6:feee:cbdc])
        by smtp.googlemail.com with ESMTPSA id f16sm10404160wrp.66.2020.11.21.15.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 15:00:16 -0800 (PST)
Subject: Re: Firmware version read error on Intel AX210
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Kiran K <kiraank@gmail.com>, Kiran K <kiran.k@intel.com>
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>
References: <89a134d0-c6f6-c685-2aeb-7dc5eee1966f@gmail.com>
Message-ID: <44820333-3e09-5405-a1aa-19f64087f164@gmail.com>
Date:   Sun, 22 Nov 2020 00:00:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <89a134d0-c6f6-c685-2aeb-7dc5eee1966f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 21.11.2020 um 23:12 schrieb Heiner Kallweit:
> I have a new AX210 WiFi/Bluetooth card and btintel_read_version() fails
> with error -22 (EINVAL). Underlying error is that the firmware version
> read command returns with hdev->req_result = 18 (0x12). (req_status = 0)
>>From what I've read this means invalid command parameters.
> Did something change with AX210 and command 0xfc05 requires specific
> parameters now? Or what else may cause this issue?
> 
Seems AX210 uses the new TLV infrastructure. btintel_read_version_tlv()
returns valid data. Will TLV/AX210 support be added for 5.11?
