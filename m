Return-Path: <SRS0=VFYa=Y5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E2C5DF60
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE3621A4A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 15:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mYYiIA3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbfKEPY1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:24:27 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40993 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389240AbfKEPY0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Nov 2019 10:24:26 -0500
Received: by mail-wr1-f53.google.com with SMTP id p4so21844813wrm.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Nov 2019 07:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZMJ7wtO4WXlhObWuKBQubCP0xVRYpzZmHuADnt8h2zg=;
        b=mYYiIA3hHedD3psQjc3/4hukHiUdrYHEzjXo0JsPbtz4uJy9ce/gUQIO7t++T2J30L
         ZXqfPbVjoqEqnQtCJwuOU/Hm62dRr4b4wgyU26zCKF/ioMDLumlJSsxQcVHtql+Babhr
         tT/p7XnlbFmftqIiUgjPi+OjASSoCLmZA7N9i8XqreEbAusJgTDtLOKSAcuGm1BH1bIT
         GpYjGWqe276DZPcCBrz3UC3q20XzgjfVubN8m34hGy+w4sm45/rI6tlcP8oF3IFbs0zC
         m4/8mMIRY+7fSQQ/zX6orY4D7x3ZFVUpDDyrVBkZE1GPY+PGPIMGM+Qi2EFGnKkHV0YA
         Y1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZMJ7wtO4WXlhObWuKBQubCP0xVRYpzZmHuADnt8h2zg=;
        b=gtQNkL/omqiuu+df2te5cUXCFaycW3eQKc65vH2MBl/L8w9N26BvaxBGen5BCxBdk2
         /u5FKBkWEm6jOoJNiilvLqw3l4W8nXshXnFEJD3R2S0/VTviK37Bc1UFxxBL07Ur7UwN
         IAGeJH+j3LfOPwdcqEmt3D3bdKbY2Y/TC/UhwOTk298AlWVbgcwPvgpzcsCX1hGwCZrH
         4W7lRxvyP6RO0DVws8i2XbtK7RCmazwKJyGZ7jgsiitCLT5UXRcDQKaPEJ7Vl3wffjCV
         Gi+SNpJbvufAhanMxr1LkGrMdyf/LAHnO79LeodpO3Cb8zqa9XSYHrjWVdLBIWtg8sHg
         gYMg==
X-Gm-Message-State: APjAAAVpN6GU7pSQJnmkXRRuBaRs5eNsZEqu1DAWSwu5u9NBju/Avyi/
        DQoD9atJfvnjHIxb3ih3wf9jR9VA
X-Google-Smtp-Source: APXvYqwJHSDyWtY5T3F1UKQeKVOGoDvt+fUN47mPGavcv2YHoQDF9GTQAmzw+rZ2X3tpGmZYMBZ1TQ==
X-Received: by 2002:adf:de86:: with SMTP id w6mr28560197wrl.220.1572967464761;
        Tue, 05 Nov 2019 07:24:24 -0800 (PST)
Received: from [192.168.201.5] (p4FD25546.dip0.t-ipconnect.de. [79.210.85.70])
        by smtp.googlemail.com with ESMTPSA id w4sm6838738wmk.29.2019.11.05.07.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:24:23 -0800 (PST)
Subject: Re: test-mesh-crypto segfaults
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>
References: <5f75011d-a157-cab2-72df-0209f7a30f21@message-id.googlemail.com>
 <70299d5df034aa0174a9263ea8736b56fd9bbd02.camel@intel.com>
 <cf7105b3-c623-5583-6cb5-2d04f22c9766@message-id.googlemail.com>
Message-ID: <c67c9cd7-ecdd-396e-ab7b-bb8716733690@message-id.googlemail.com>
Date:   Tue, 5 Nov 2019 16:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cf7105b3-c623-5583-6cb5-2d04f22c9766@message-id.googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 05.11.19 um 10:53 schrieb Stefan Seyfried:
> Hi Brian,
> 
> One thing I forgot to mention explicitly: this is the recently released bluez-5.52 tarball, not git master(!).
> Also note that openSUSE Factory use LTO by default now.

LTO seems to trigger the problem, see
https://bugzilla.opensuse.org/show_bug.cgi?id=1155889#c6
for an explanation of the issue and a suggested patch that will fix / work around the issue.

Best regards,
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman
