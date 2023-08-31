Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE87C83F2B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 05:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjHaFlV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 01:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbjHaFlV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 01:41:21 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CAEA
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 22:41:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a86a0355dfso231154b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 22:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693460478; x=1694065278; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XYbKH1zcvKQ4oV8WyVzETGmUqRA/OO8HGH/5N3pVW3A=;
        b=qSya5U9FvpxIlo6gV0VYol5aUiRRH5LNOSIVxBtihaRfSxQBDwQwGY8hHI4Df1pGO9
         AtEMuhZ0ROPv/RSnApW/SFi/ZSeif5Ez+mzM9FVIsYUcEhvPb1FrQTJT1VzZGqlcFTw/
         dZcxYBcQpGqih+E7s6PjU84OFc9PMbDsYs3M5hCdxZb4oRM7n5dlz3CrYAa6MLzj7B3n
         6ZsCIGmje4PgFNXKpVH0zurkVUgWOXS7XSV5JYXt98qQsNigRXTlbFPblFu4a4myihqf
         C0xjBcx5YHTPlgKth0hPPg5l7AVhH0+iLFyOImTevI1KAZD1nF6HqXLKAazV9R4a8yrF
         4rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693460478; x=1694065278;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYbKH1zcvKQ4oV8WyVzETGmUqRA/OO8HGH/5N3pVW3A=;
        b=UdKmkuaSR6pjiD43Jdr2JxcJzWibchEiTosJIF059D7JpMSNxsBaIgnzZ/DqD4zPTl
         mFubi7SfiW5Xagyheyt0K8ulS4E9CvLP/nBY8QiTOOD7p6vGw4bT/v+ySiUUdGNR0f1s
         Z+s7pXLTy99Y7DimcwgzhOSn4TBTTpGLofL4FasYwLh7EGSeoXFeC4I83m3TNSLDAymx
         47wR3Q9/egDCXZ7KhrtKdcp9jDPiyUFO4ViBbs8/GOcGfXR47r1XQWOegZwd678r5iqV
         Nsh+MErFxqkb32lRl5J7Q3RDDXB+jVrhhdObVIXQJPUwcL6TuJZKIoFkMjiqIVCXtpmT
         rkCQ==
X-Gm-Message-State: AOJu0YweHOWMqpWxtGxPLuqgaH2/hlVmAPgpXXN9LLevbj/dnyAcAP9N
        lnkiHcs9Yumqa6Ji9jQ7/6B1WJS7M54=
X-Google-Smtp-Source: AGHT+IFJSkxk35csG3QKuGTTbFp0TsORr1qsdlxkq3iDMNYcgN+WY//1pdaQj+qA3QbfhGuwDQnDww==
X-Received: by 2002:aca:6547:0:b0:3a8:5133:482d with SMTP id j7-20020aca6547000000b003a85133482dmr3953223oiw.35.1693460477673;
        Wed, 30 Aug 2023 22:41:17 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.139.251])
        by smtp.gmail.com with ESMTPSA id bd11-20020a056808220b00b003a7527207b5sm378558oib.7.2023.08.30.22.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 22:41:17 -0700 (PDT)
Message-ID: <64f027fd.050a0220.eedc.1955@mx.google.com>
Date:   Wed, 30 Aug 2023 22:41:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5391041092257649555=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v1] Bluetooth: qca: add support for QCA2066
In-Reply-To: <20230831043902.145872-1-quic_tjiang@quicinc.com>
References: <20230831043902.145872-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5391041092257649555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780707

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      40.68 seconds
CheckAllWarning               PASS      46.07 seconds
CheckSparse                   PASS      49.58 seconds
CheckSmatch                   PASS      136.99 seconds
BuildKernel32                 PASS      39.15 seconds
TestRunnerSetup               PASS      597.62 seconds
TestRunner_l2cap-tester       PASS      34.07 seconds
TestRunner_iso-tester         PASS      75.28 seconds
TestRunner_bnep-tester        PASS      13.58 seconds
TestRunner_mgmt-tester        FAIL      259.39 seconds
TestRunner_rfcomm-tester      PASS      20.74 seconds
TestRunner_sco-tester         PASS      24.08 seconds
TestRunner_ioctl-tester       PASS      23.46 seconds
TestRunner_mesh-tester        PASS      17.54 seconds
TestRunner_smp-tester         PASS      18.47 seconds
TestRunner_userchan-tester    PASS      14.32 seconds
IncrementalBuild              PASS      37.13 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.916 seconds
LL Privacy - Unpair 2 (Remove from AL)               Timed out    5.000 seconds


---
Regards,
Linux Bluetooth


--===============5391041092257649555==--
