Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2755FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 19:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350558AbiFJT4H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350528AbiFJT4D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 15:56:03 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BEF17584
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 12:55:59 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s1so139334ilj.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pNPk8/u6pwLQSy/5+8GjjfCqN5ZZKr0klrDxI9WTNXY=;
        b=c6DgtUcz/I8Wv3gyicx/EaW2zp+WUJWHVMTi6eRTXf0vyZgJgoKZBfeImB4QKCUB+s
         qjoV3IolhvmK7CFus0uHLgsvfmyFzzEJDzO1x8ODrNi7pAfuQz/v30kwc+706eedgBFq
         UBZs8WE8rNoC6gvEeoc0vrAbIBlLJFHIJDiMoYXktyhCEG5VJ1ChxQaig5D9i2ZO6JS+
         yClsQsq1QYswNQKILcBaNdAyDzeycbdCmAVo14LOY8xPQKWwwiyKD/YK5y+C/Faqhg4n
         rPU+R1XqpD8Aqfq2ntmEuT2vrbx+4MsLJib5IaYAlM2dzToHvf8WgelkjoO4fnT2VpEI
         hbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pNPk8/u6pwLQSy/5+8GjjfCqN5ZZKr0klrDxI9WTNXY=;
        b=eR4QRBBJ4tvxhCfo5IfeyH7GV9TXruEJ8O2U1jBevBvNsgAkENt4Qym018EvcSqqdU
         aUzixApcipdDRWLBEbVY93vmjLgO93x8I8wHVeFoXhZpgTYoNCJpJ+kR9rDF/SvJeREL
         9cel0Ll36l+cw6oR1ZgxUvYMNLydgDdMZU/fbVq1UCxjcTnk8nOknNWqf2SGdpe9/dHW
         UzrkIoXbsm9FY/mXq/30+yCk74bh4fAqjZTIe/YnkP581MmQzchk4hLkjCgi+awG1DaJ
         uroolisAEbKYD9EcZt79ovpZ0VGebSRAbgBzt9eIg9POp+80tgoYFLQd9j/pZXBcPKY/
         l/QA==
X-Gm-Message-State: AOAM532RToxtX6JaRuSyVWXBBAZlvwKz8DzhzbIQKExkIDk3dRSto8jd
        n2+TfsYEG5sbAw9L9Bjbp6Hap7Yg4BY=
X-Google-Smtp-Source: ABdhPJwKWBAPoozVz46zqF2Rr2eWb+xZkGNcsooqTZYR+rl5mpKOJ73aZPOzo2iZbrqq57+XNtaJzw==
X-Received: by 2002:a05:6e02:1bc1:b0:2d1:8e35:dcba with SMTP id x1-20020a056e021bc100b002d18e35dcbamr25901249ilv.58.1654890958385;
        Fri, 10 Jun 2022 12:55:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.38.241])
        by smtp.gmail.com with ESMTPSA id k1-20020a023341000000b003314f874ac8sm11044091jak.36.2022.06.10.12.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 12:55:58 -0700 (PDT)
Message-ID: <62a3a1ce.1c69fb81.4ccad.4c16@mx.google.com>
Date:   Fri, 10 Jun 2022 12:55:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7765332951807026137=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Fix refresh cached connection info
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220610121915.kernel.v1.1.Ia621daca5b03278ee09314c59659b64c901408cf@changeid>
References: <20220610121915.kernel.v1.1.Ia621daca5b03278ee09314c59659b64c901408cf@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7765332951807026137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649392

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      31.71 seconds
BuildKernel32                 PASS      27.44 seconds
Incremental Build with patchesPASS      37.83 seconds
TestRunner: Setup             PASS      465.62 seconds
TestRunner: l2cap-tester      PASS      16.97 seconds
TestRunner: bnep-tester       PASS      5.81 seconds
TestRunner: mgmt-tester       FAIL      103.03 seconds
TestRunner: rfcomm-tester     PASS      9.15 seconds
TestRunner: sco-tester        PASS      8.93 seconds
TestRunner: smp-tester        PASS      8.98 seconds
TestRunner: userchan-tester   PASS      5.99 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 103.03 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 491 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Add Advertising - Success (Name+data+appear)         Timed out    2.755 seconds
Add Ext Advertising - Success (Name+data+appear)     Timed out    1.789 seconds



---
Regards,
Linux Bluetooth


--===============7765332951807026137==--
