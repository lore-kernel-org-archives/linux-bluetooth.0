Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6317C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 00:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiCCAQR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiCCAQQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 19:16:16 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3BF3917
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 16:15:31 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 185so2763805qkh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 16:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AUx8TTelEdgpzTkPQntaKZLKYV6Wk0cf9MLzS2TA+WE=;
        b=GBZZyU78WQLsmNJPJVqnOfHwVutXGwzd4mi/gTiqD7ysqR1tc35cvQPsgK5VXxafxU
         Pfk9cDXKS+4GiWPh3a0WLkDZj9RLKCFZqEWG+FtsvbRXiXqvX/zK8lqp0uI2b8cf1bAH
         5RCUpKPYSf9Vls6TUX2b+plZbiKtIzjwnVxwYvRCsKC6yWIEfdxIJXtP08oHyRakpwMc
         H6Oa/71esCtJSfBBGdvvtCv4KzO1nPEo1T9QK/xD9mAghw96wtjyRHxcwx7eiKYQ6rgB
         WPoGSuCojxvDnd30VOcBIUVdeXAKgXHyXWd9dRvdvb8Fh7atr63nSRG53Osq0L0KfBoe
         GzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AUx8TTelEdgpzTkPQntaKZLKYV6Wk0cf9MLzS2TA+WE=;
        b=wSEMsCRZdKzYqwixMvd7Ywd8qmmAhJ3HTpx1kvBfPaJhRpd+DzZPWGcsQF5asfnb2u
         7hc6Ih0KVrkpAu6o/Ljy46bJQaAdt0/yn/uF2IhXzOVTcqllMkXGJb9ZQI2GFRlLRcW5
         RGGMmJuncyUg8UKXlsGULO9uO/ku50SY4q4go9fFGn0mFBKLOBfDiFltpiXDuLZ3Q5OP
         3eJXvppmfbS74FxaCn89vcdPvSnCcdbY4y59C7qhC/uuvMxCi0YR1jM0fwxUVlqxp99k
         vBPgHdZQL2hP3O8rJ4tazT8armIJezK4sO/zUUf8esVBx5/sxisQ6xMEQzvGR8dfxebm
         Pu3A==
X-Gm-Message-State: AOAM533ormGHrThZVdMeKI8dKVDVckIlLNITGzhTQt/RH16vTQ45E8KF
        N3CEs6V1PaBsZ+wns6k7wL7nUp7RvZ80Lw==
X-Google-Smtp-Source: ABdhPJy1g99Khjf6zppjez+9LZO8WJ+LiGGwcpZet8EzWfhxKxA66vpEkShHwD6sxZpVHNh82Lg48Q==
X-Received: by 2002:a02:19c6:0:b0:30e:e6a5:67ad with SMTP id b189-20020a0219c6000000b0030ee6a567admr27585929jab.45.1646262657765;
        Wed, 02 Mar 2022 15:10:57 -0800 (PST)
Received: from [172.17.0.2] ([40.69.191.158])
        by smtp.gmail.com with ESMTPSA id k4-20020a5e9304000000b00640dfe71dc8sm238099iom.46.2022.03.02.15.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:10:57 -0800 (PST)
Message-ID: <621ff981.1c69fb81.a6f0c.1284@mx.google.com>
Date:   Wed, 02 Mar 2022 15:10:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5608405304663039553=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: HCI: Add HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN quirk
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220302225049.432025-1-luiz.dentz@gmail.com>
References: <20220302225049.432025-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5608405304663039553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619721

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      29.46 seconds
BuildKernel32                 PASS      27.12 seconds
Incremental Build with patchesPASS      36.90 seconds
TestRunner: Setup             PASS      464.45 seconds
TestRunner: l2cap-tester      PASS      12.95 seconds
TestRunner: bnep-tester       PASS      5.74 seconds
TestRunner: mgmt-tester       PASS      101.13 seconds
TestRunner: rfcomm-tester     FAIL      7.22 seconds
TestRunner: sco-tester        PASS      7.31 seconds
TestRunner: smp-tester        PASS      7.09 seconds
TestRunner: userchan-tester   PASS      5.93 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 7.22 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.150 seconds



---
Regards,
Linux Bluetooth


--===============5608405304663039553==--
