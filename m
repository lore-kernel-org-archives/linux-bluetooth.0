Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF3DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 19:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8670F610E9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 19:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhIPT16 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:27:58 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58580
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhIPT16 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 15:27:58 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A75E4025C
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631820396;
        bh=hthyLwHWx+KEvuJBuzDNi3dTold2mGmgMiAxn5ZC9BI=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=fjOahzyLrUoYN0MAWmLmsa5uDpn/GWigEg5atXi65WOtg99LPwh9e7SaYi783vXwX
         dKbm6OZKiX2X1Vr71DSM9RAHI5OVDViig/+SZNl1dkBkjkLtiOloUI1t9VQ+PjxT3+
         awxWet/bkdYOKEn6KKoDOkjV9UguGdQPgZyE2VtpUknIZuNAzu1cFoZB6IxWAdNKH2
         FgFu143H3gRChXcH5DCgjrebOG5ucehR6ptsrArE1J7RpjCDM0dU3ZoGBaUZVumX4D
         vrZ8Lb40GaJ29HbXzgRqZTRJ0sf3JI9i699yIrdCQj/G2Uzf39MRwf1IiwJGBUoEuy
         0ewCzkjFiZ2tA==
Received: by mail-wr1-f69.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso2822072wrn.19
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 12:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hthyLwHWx+KEvuJBuzDNi3dTold2mGmgMiAxn5ZC9BI=;
        b=Sk0/L5kGLorYzRmQeaMaFYjmqlcNm5ISKxjOOgxIwUbXQFBJf4gSEKn24WZBcir2qx
         VNCOycYWDLaS6FD9+8lDwJWnBtpuELXzgtlE9WZ7PWT56P2+gywywdGMoZt0ZjDwq8Ki
         W6SMEg8bxhIEpSbVwA6CO4LC/uNWUa2U4ep/1/euJxaz4NQMWCTwhpPddbw6yU7gCPUy
         gBEKbuKFRjP4aeCzHAqhgByv7MQl/hE526gJZ0Z646zA0UvVrtezCK0uhq3BCbz018Ys
         pr/+iAn7g/1nIh1lVpLL1gORO8TyPCxAx9fvg2tLumdI7CQtklXx2uL7IH9FKfeOWu8c
         gR7g==
X-Gm-Message-State: AOAM533SaGrdV7wbqOk/VpD6eMdL8xYvfxnzwlz9HeAlq6g/OwqJJRir
        IscPYtKblpAcolmOIE7uoZgHHkBWY2dCaNaIUFZuSdWHanEj2w4M/uf7KtoY9U/ls3S7HI+HBl4
        3DSkRcBCNC0xW/2BF9wOiHXSw/lYWbKea/DKYU+qmTgmABA==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr6757625wmj.108.1631820394527;
        Thu, 16 Sep 2021 12:26:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL9M4RIZwRkAGaHz0YUhvb/dAGXWekeYxToaptcRiM6Z4TKTRIqPvxTa9kfRB2QzXhA9i8Fg==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr6757612wmj.108.1631820394261;
        Thu, 16 Sep 2021 12:26:34 -0700 (PDT)
Received: from [192.168.2.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id h16sm4304634wre.52.2021.09.16.12.26.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 12:26:33 -0700 (PDT)
Subject: Re: Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt compatible
To:     linux-bluetooth@vger.kernel.org
References: <20210916170528.138275-1-krzysztof.kozlowski@canonical.com>
 <61438790.1c69fb81.b0356.7bdc@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <413556b2-61c6-941c-60b0-991965e41e87@canonical.com>
Date:   Thu, 16 Sep 2021 21:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <61438790.1c69fb81.b0356.7bdc@mx.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 16/09/2021 20:06, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=548291
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    FAIL      0.44 seconds
> GitLint                       PASS      0.10 seconds
> BuildKernel                   PASS      519.20 seconds
> TestRunner: Setup             PASS      345.93 seconds
> TestRunner: l2cap-tester      PASS      2.70 seconds
> TestRunner: bnep-tester       PASS      1.93 seconds
> TestRunner: mgmt-tester       PASS      31.31 seconds
> TestRunner: rfcomm-tester     PASS      2.09 seconds
> TestRunner: sco-tester        PASS      2.12 seconds
> TestRunner: smp-tester        PASS      2.16 seconds
> TestRunner: userchan-tester   PASS      1.95 seconds
> 
> Details
> ##############################
> Test: CheckPatch - FAIL - 0.44 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt compatible
> WARNING: Unknown commit id '81534d4835de', maybe rebased or not pulled?
> #9: 
> Fixes: 81534d4835de ("Bluetooth: btbcm: Add BCM4330 and BCM4334 compatibles")

Although you asked not to reply to this email, but you also sent it to
public mailing list, so I will reply.

Your report is incorrect. Commit ID 81534d4835de is from mainline,
merged into Linus' tree as: v5.13-rc1~94^2~197^2~38

> 
> total: 0 errors, 1 warnings, 7 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> "[PATCH] Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt" has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.

Checkpatch does not report any warnings like that, so this is false
positive of your system, not checkpatch.



Best regards,
Krzysztof
