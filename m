Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0FBEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 10:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjFUKgi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjFUKgL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 06:36:11 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703701728
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 03:33:28 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-763ddc4259dso5299385a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343607; x=1689935607;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hGX8B3ugITgoxTD+m2PlLcY4FAOU2374wGhSnEqWULM=;
        b=kCjSf6VM1oL7BaLo25oIeLrRHm4xlFvJCPbdOriV459PIwj0TItGslNsQz8bJEO5vq
         gP+gzPy1WWI4JGG5LlpYYAQE9s1lvqFSGLJQNrVmRhx44XS/42TNlBxituQT5wmAclev
         Ew6IXi3IfXLfL2CkC0HYsEgSFvGJcWM2/LelNrnpXnDwq4Cq78E/m+BFTJrjiiGqXXXn
         2wF65VL5uVMDfYkExbx5oLvRzcPMBgAyVavTeh8C2d6B+NOvlUGBaLe5K6MXa0B5LPhQ
         QCa1IVREuRXVY+qWoRjgcqMMFxVBdJb0JtkSbH3keAMgcvB0Y9sjkov+UdefYiYHh/+b
         qmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343607; x=1689935607;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGX8B3ugITgoxTD+m2PlLcY4FAOU2374wGhSnEqWULM=;
        b=clOvVdQkJIbt+P2PKHh6UsWWZqOYUS49kz8gNv7nhtgWXkry8x/wz8UHLejJ0avtj3
         xjipegw8rbSkOPwQh6tiC26JH0T6NunAsxeBuajH5msW5YO/A+dvLl6Bjxzed0n96oHC
         TfDLyRfL7dD59DFehQbq+Ht+cnJe5WbBVW9Lq6gq3uWsrcYw73T9sZSznoiyOnH5Qy0h
         VzCGWGKFpfJQt4HafYL1c0zizp/aDPwmXlsJphvLMZk139X2eHGOKB/OCMNJPYWsTqg7
         i0qoZNX+Kkk4ufjU73u0xv1Nirje4NoyqgHpDCvrfA33RViSml6pu1aXqxdpwio8tIC8
         MA8A==
X-Gm-Message-State: AC+VfDxnBx+gEJABIbtJ1l5Z3cZVMySpXVPtO9SWMMBCdQJNgpt2U4ei
        MkTcNXKK7om95yqjgYOLxbZgSxPTTZY=
X-Google-Smtp-Source: ACHHUZ6fKXKOVtb6a7weAN6khTUJf1XQnePiCmTexij/ebg6Z0o1DzxKDt9pEAOd0BeZLZ6PSfvavg==
X-Received: by 2002:ad4:5c61:0:b0:61b:6a71:e741 with SMTP id i1-20020ad45c61000000b0061b6a71e741mr19791022qvh.23.1687343607371;
        Wed, 21 Jun 2023 03:33:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.37.26])
        by smtp.gmail.com with ESMTPSA id i19-20020a0cab53000000b00630136700a7sm2350593qvb.82.2023.06.21.03.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:33:27 -0700 (PDT)
Message-ID: <6492d1f7.0c0a0220.9bc6c.693b@mx.google.com>
Date:   Wed, 21 Jun 2023 03:33:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5225219657197089197=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v5] Bluetooth: msft: Extended monitor tracking by address filter
In-Reply-To: <20230621100031.19477-1-hildawu@realtek.com>
References: <20230621100031.19477-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5225219657197089197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759053

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.28 seconds
CheckAllWarning               PASS      35.44 seconds
CheckSparse                   PASS      40.65 seconds
CheckSmatch                   PASS      112.92 seconds
BuildKernel32                 PASS      31.27 seconds
TestRunnerSetup               PASS      445.76 seconds
TestRunner_l2cap-tester       PASS      16.59 seconds
TestRunner_iso-tester         PASS      23.14 seconds
TestRunner_bnep-tester        PASS      5.36 seconds
TestRunner_mgmt-tester        PASS      128.25 seconds
TestRunner_rfcomm-tester      PASS      8.66 seconds
TestRunner_sco-tester         PASS      8.00 seconds
TestRunner_ioctl-tester       PASS      9.20 seconds
TestRunner_mesh-tester        PASS      6.84 seconds
TestRunner_smp-tester         PASS      7.94 seconds
TestRunner_userchan-tester    PASS      5.67 seconds
IncrementalBuild              PASS      29.96 seconds



---
Regards,
Linux Bluetooth


--===============5225219657197089197==--
