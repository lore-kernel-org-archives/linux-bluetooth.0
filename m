Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A59C0015E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 03:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjHGDQt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 23:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHGDQr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 23:16:47 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2FC10F6
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 20:16:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bcb15aa074so2716457a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Aug 2023 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691378205; x=1691983005;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlhhy0IzhZHXfHXaj56d/44dalu3djmME3+7AAfxZWY=;
        b=Vdid46QXZKTafeQHAGV0SFzqP8emSDLF7o6XRiADWE6WMpELcKQxpdHm336+V/oMnQ
         aPGy+UQ7vNsxc29KnLodN1cRPG2rbGhPVeEJ/lLmedF44sfGerwwXsXzAKCpSA6mNK38
         WTP8bWYiv2RDmc+x1vZYKXZSJMg0rYYMjYXH4heUgospFZeRxel4le92kbZ185Hzy3uN
         KKO7N/OnuXrSAdOuEa2GseZt9EiiZnvZNmdL/IJ1SJI6lZ5dclMncdS2vXmgZZ5g/Qkj
         UHYyk6wEVo8+sUJYG0+GCDQPSQldQEBJZNKRZtd6Y5a29gSbUJTWa/Gvq9chDWBP+69t
         x9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691378205; x=1691983005;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qlhhy0IzhZHXfHXaj56d/44dalu3djmME3+7AAfxZWY=;
        b=Q4GWnlam7SfHwEbuTMOgpKXnjpQS7Lx1IBNjIvClcp7Dx33py6zK+gX/xjjr0dLuZ7
         YK9wACbEXom7N7M7xx6ncJKWZs/OhzMrJAfEBFnSn/88Wgh6qJPZDz1mAQlG2JI8LMsN
         2mMl8qFYdDpbhQJ9PkFXLgLsBnag2blgIKZTDY2Px+W1KtOE39b+OlB7/8zjba9U5zrx
         1Dh6hYFuuUmTsItcZvxrLwV20qNxf/b3ei98lBcxesUA4A5kcOo+8Se01k/YZquf1EqN
         NQ5owwijreH5e/BF6rjHV7x3cqiFajhuSQMapIT/4b//zMRnEiwVCmCiQDuJl8M1VMGo
         Xg1A==
X-Gm-Message-State: AOJu0Yz3H+nHKB9vP92XD/2PvWuZdE5TZt56xJ50obuOkJGD8IxRc1Fw
        X6ugKwYHve3jsHyK3xsKyFP0abwj3pQ=
X-Google-Smtp-Source: AGHT+IHfVVHr577dM4jOaPyzlM8MQgUpjWM4sFsWyseGhObkQFu2GX/137+tVq3eBqoN1B9iq5Yfkw==
X-Received: by 2002:a9d:4690:0:b0:6bb:3032:55e5 with SMTP id z16-20020a9d4690000000b006bb303255e5mr5293285ote.9.1691378204971;
        Sun, 06 Aug 2023 20:16:44 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.140.126])
        by smtp.gmail.com with ESMTPSA id z65-20020a4a4944000000b00566383daeaasm4284334ooa.32.2023.08.06.20.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 20:16:44 -0700 (PDT)
Message-ID: <64d0621c.4a0a0220.943bf.091a@mx.google.com>
Date:   Sun, 06 Aug 2023 20:16:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8464385579564950588=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, william.xuanziyang@huawei.com
Subject: RE: Bluetooth: Remove unnecessary NULL check before vfree()
In-Reply-To: <20230807023206.2128846-1-william.xuanziyang@huawei.com>
References: <20230807023206.2128846-1-william.xuanziyang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8464385579564950588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773474

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      43.73 seconds
CheckAllWarning               PASS      46.79 seconds
CheckSparse                   PASS      54.08 seconds
CheckSmatch                   PASS      145.77 seconds
BuildKernel32                 PASS      41.48 seconds
TestRunnerSetup               PASS      641.68 seconds
TestRunner_l2cap-tester       PASS      31.51 seconds
TestRunner_iso-tester         PASS      85.57 seconds
TestRunner_bnep-tester        PASS      14.37 seconds
TestRunner_mgmt-tester        FAIL      257.97 seconds
TestRunner_rfcomm-tester      PASS      21.70 seconds
TestRunner_sco-tester         PASS      24.16 seconds
TestRunner_ioctl-tester       PASS      24.67 seconds
TestRunner_mesh-tester        PASS      18.26 seconds
TestRunner_smp-tester         PASS      19.38 seconds
TestRunner_userchan-tester    PASS      15.55 seconds
IncrementalBuild              PASS      39.32 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Remove unnecessary NULL check before vfree()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (98>80): "net/bluetooth/coredump.c:104:2-7: WARNING: NULL check before some freeing functions is not needed."
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    2.067 seconds


---
Regards,
Linux Bluetooth


--===============8464385579564950588==--
