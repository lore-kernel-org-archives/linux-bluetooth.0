Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC9C77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Apr 2023 03:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDQDJD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Apr 2023 23:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDQDIu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Apr 2023 23:08:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C333649E9
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Apr 2023 20:07:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id e13so7075991qvd.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Apr 2023 20:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681700816; x=1684292816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YVL1TCwnKPNEBwXevHluMM0tLqJHJ20vEfGnNva+dZw=;
        b=L4D0qTZZH62nS1F1RvUGGi6JVkT52+qzm6KFiR2dAjgMH4B/MD/4xOElNn+elYq80I
         I53OuAwcg6kjQJmcnM7RE5CFy1tsYrSXSfxdgz4MRXFDZWMTHpU1NhiXIrVhiDXfVm2L
         9JvC8t+Q/OeiTPp5UAzKcpwANhzmOujXlAhjniJPbo06kuG+D/bJPfoAwsQcAZMBh357
         nekbeZylax7s7H7aRRtARqCkL9Umtkxozwc+4BqiOUB2s8BBy+BS06fRl5bXkK5zPgLp
         mQLc3dNHbklP/SMztFT38LY7xfuilLDJ3qVc4YM9oO0Hcm8UWQpS6CyRbjkUmw1j7VTO
         nQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681700816; x=1684292816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVL1TCwnKPNEBwXevHluMM0tLqJHJ20vEfGnNva+dZw=;
        b=WOU4L3xw2b9HUbxmZ49oYGg+LyKK/j5psZvf9WyKE7fW+q8SFlpi3ZXgy06fVOZggC
         6rADRCQxP7uUWgilCv7I3C5ayup2nBoU1Cm6ewTlpaWIhu5Zcfwep2ocQuIBHs5bhzcy
         HXbA39+lDNRRUyzZZ71Z/x5xw6wNp6yAMQP0sgLX7yjTgHBF+yvl+vTh/PnllP7lxl+t
         tBKoPy9pSxyuKqGT3BxNk+otUm4rO9CckL2tvWKo3nri1lpXJ7kVguI4cakMbFwRn6iA
         tJ5DhFrbQS5jxYapid1sz4bFTdmzqiwXy93VmumyC6I3c8Cx29BjcdCIvIRoqRMzqORj
         OZcQ==
X-Gm-Message-State: AAQBX9eZUirkF4PsbtOAr3LgoNJPGI5lP8JGBUlk+aXCn/brikq1BOT8
        QYLBdaZKtAMhjGFcoGuBBHduyUaF+0s=
X-Google-Smtp-Source: AKy350ZIUh1hlOp1hTaMAPSvyokttubNNhd6xnJ6r3ULLesxjxQE8GXldVlyO4J6KkvdLOxjnED45A==
X-Received: by 2002:a05:6214:1c4e:b0:5ee:e4bc:a5a with SMTP id if14-20020a0562141c4e00b005eee4bc0a5amr14098300qvb.17.1681700816020;
        Sun, 16 Apr 2023 20:06:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.254.87])
        by smtp.gmail.com with ESMTPSA id er5-20020a056214190500b005e7648f9b78sm2743288qvb.109.2023.04.16.20.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 20:06:55 -0700 (PDT)
Message-ID: <643cb7cf.050a0220.4f717.c92c@mx.google.com>
Date:   Sun, 16 Apr 2023 20:06:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2820854079334600928=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v5] Bluetooth: btrtl: Firmware format v2 support
In-Reply-To: <20230417023358.38767-1-max.chou@realtek.com>
References: <20230417023358.38767-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2820854079334600928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=740290

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.86 seconds
CheckAllWarning               PASS      35.18 seconds
CheckSparse                   PASS      40.03 seconds
CheckSmatch                   PASS      108.90 seconds
BuildKernel32                 PASS      31.05 seconds
TestRunnerSetup               PASS      441.64 seconds
TestRunner_l2cap-tester       PASS      16.92 seconds
TestRunner_iso-tester         PASS      20.55 seconds
TestRunner_bnep-tester        PASS      5.52 seconds
TestRunner_mgmt-tester        PASS      114.76 seconds
TestRunner_rfcomm-tester      PASS      8.84 seconds
TestRunner_sco-tester         PASS      8.27 seconds
TestRunner_ioctl-tester       PASS      9.55 seconds
TestRunner_mesh-tester        PASS      7.04 seconds
TestRunner_smp-tester         PASS      8.06 seconds
TestRunner_userchan-tester    PASS      5.79 seconds
IncrementalBuild              PASS      29.70 seconds



---
Regards,
Linux Bluetooth


--===============2820854079334600928==--
