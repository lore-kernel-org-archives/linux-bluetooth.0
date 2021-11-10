Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B9CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08166115A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 18:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhKJSn0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhKJSn0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 13:43:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E665C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 10:40:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso2568586pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 10:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Mj18NN6NGY4cD54wc4Nq3MoJD5ifqzcXVVdpPs9R46w=;
        b=Nkd24AE4mYnNqSwhdzD3cQz0LzCw+T1cE44NBW7ucQdXTdMk/xrXs0Op10SvDWqKSs
         D3QC3pGhUg/HZQsX6GC8gahaSqGV50Mj1VZkd5fU2swYbDFEM31L6cP8upLlbcbJjptR
         WDhQphmWx25oQsY6B9IkC7v0Yy5cbWNFR9C9lJ4edZmR/6raIHWgZcuDxjECtR/03NBC
         sjZwBKuwOU12tvdSEQybNH5emLAKTGKcGXFNqlVrlsGY10rxtLHOqDcFziKf1B+QF4jP
         nJM3jM0MK9nt9aqKG7SD2RNDfKKUjrDygaP5/lrqYtC5LMT33btjvPPAuD2gwxuVKEQ0
         peBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Mj18NN6NGY4cD54wc4Nq3MoJD5ifqzcXVVdpPs9R46w=;
        b=WbfHcP3ld4K1rrt3JNSTXDbGbFwH/57murOQS9Em3gdt4BiEtVcr/GLVbfBRd9OqES
         EPXFQSy/SQYIAzGOfEywk9eXt5fTAHacRWozGCtU0fZguZeX6bq2w+i58L6Yt0eJ3GWZ
         4xN6GQf/d1Qj0fx95tWqL9tphhSBCCICK/zHqaDDRcvn5sy71lcuA95O4gl4u44TAciF
         YSd4GzxiduB5wZ6NZSufAbDRBkAtDYoKoONLWzqxP66RxqSIQX0Gmt7CONGMmNSbrDW7
         kkBW56mias6xLIDBY1Z57wuUuOhFYXp6RtRKenYhOhc0p9LCHRQuVnUh1KSxQFzoWQpO
         /VHA==
X-Gm-Message-State: AOAM530w5jUNKoovcA1SI5PDe5fOM9jfvS+4U13AZ2GUG5puTlykGbow
        CGopZ0v5SBzYpbUvG868ZhpwSRKs1JQ=
X-Google-Smtp-Source: ABdhPJx12WDtAtBDYykuJpVMyXlAg5wru5E6B8rOP29q6vRFRYW40F9722jAys5s+M89XgRO2HHnWA==
X-Received: by 2002:a17:90a:4801:: with SMTP id a1mr19312908pjh.156.1636569637772;
        Wed, 10 Nov 2021 10:40:37 -0800 (PST)
Received: from [172.17.0.2] ([20.83.124.11])
        by smtp.gmail.com with ESMTPSA id o1sm345666pfh.191.2021.11.10.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 10:40:37 -0800 (PST)
Message-ID: <618c1225.1c69fb81.98619.14e3@mx.google.com>
Date:   Wed, 10 Nov 2021 10:40:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4816766484066324266=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, goodgame13241324@gmail.com
Subject: RE: *** Meshctl "sub-add" command oversight fix ***
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211105165735.13606-2-GoodGame13241324@gmail.com>
References: <20211105165735.13606-2-GoodGame13241324@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4816766484066324266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=576179

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       FAIL      0.32 seconds
Prep - Setup ELL              PASS      53.92 seconds
Build - Prep                  PASS      0.26 seconds
Build - Configure             PASS      10.35 seconds
Build - Make                  PASS      236.27 seconds
Make Check                    PASS      9.43 seconds
Make Distcheck                PASS      278.09 seconds
Build w/ext ELL - Configure   PASS      9.71 seconds
Build w/ext ELL - Make        PASS      220.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,1/1] FIX: Fixed oversight of not supporting vendor model in Meshctl tool's sub-add command
1: T1 Title exceeds max length (97>80): "[BlueZ,1/1] FIX: Fixed oversight of not supporting vendor model in Meshctl tool's sub-add command"




---
Regards,
Linux Bluetooth


--===============4816766484066324266==--
