Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E216C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 03:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiKRDsY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRDsX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 22:48:23 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AD68F3D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:48:22 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id b2so2954593iof.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2+LAy52yixrs9zaYR9+KFSHsrhnfJk4yl1PmbkrXFwA=;
        b=ERvXs9sJh61JE2kvKxzTrEHzCb0yJ947u1q5ohhThnuMjNakhIr9H50quNAGbzphxF
         6KRRjFdRcgqibLO3EcuBSYiPx8wM1jbv2Jf3F1Ho+kOCMZl87jAhU/PG5JYOXO0BT1NH
         jdEdbnVKsMgh12aV7ognBHEpVLg+1VytXS8tuYcswC0VOjtiC0Tl/SSEaNFde86ogx7N
         hLPK3kefOzHFSKYbOOmpGV11OaSPn48UI4Iwp9ZDqu0U4ZY78wppvBhlqQlPqIEqAUy2
         fPkDAM+D0jOcMAPB8EcP2FU3PUDdpvHTfDJhTZO8UNDDujI7iwVlk7TaEJkUNwpDZb4A
         2bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+LAy52yixrs9zaYR9+KFSHsrhnfJk4yl1PmbkrXFwA=;
        b=rxft8ijlNZD8ogTGeulVxbxNVAE/lVBBs/VMXG7YZXJKtAAE/hXp50pnUnk3zY3pfO
         H98BhmIWXn8H2VYG+iRto6uYfBqRCftwoGwhe2oyiZiOoTdR6bRrsjY6xyA+RLzHz1gj
         g1xy+CH4XvV0V3I2wcAywGpwEQWGRYPPe57zIlN6gPxcDGpvB4BDGU9ZQVX5If5OvMtr
         H3CrS4eHBLqCDUDJO5Wsy1d09XZNxEdQvh3fzX7tZE4YIbeZOzrMpjgMg+XIy0fPoKFA
         fr64Em6HEIhbQRLMoFcBR6fFFs78FA9pE8aaJCqbsj/uhRpiYphS3CP7k/d1QMi/zeuj
         FIfg==
X-Gm-Message-State: ANoB5pkoCJSEZ7Hpf4To+jYGWhMTvHC8ZXU7AEuDUXdaJNhK2iROzdFv
        s4Q3wNaKuhTPOv8lNkFrNzfuPp1OwYo=
X-Google-Smtp-Source: AA0mqf5OolXdeHe7niNn1bfixMeuytYYHTVoZx1dwE9r63qc9t1asJCqJ0vkLazAVIMnS3vuMRklOA==
X-Received: by 2002:a02:858f:0:b0:374:fe5b:668 with SMTP id d15-20020a02858f000000b00374fe5b0668mr2481991jai.165.1668743301702;
        Thu, 17 Nov 2022 19:48:21 -0800 (PST)
Received: from [172.17.0.2] ([40.77.6.26])
        by smtp.gmail.com with ESMTPSA id q17-20020a0566022f1100b006bbf0466587sm948596iow.49.2022.11.17.19.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:48:21 -0800 (PST)
Message-ID: <63770085.050a0220.83604.230e@mx.google.com>
Date:   Thu, 17 Nov 2022 19:48:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9017411373430240794=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9017411373430240794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691972

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      34.19 seconds
BuildKernel32                 PASS      30.34 seconds
TestRunnerSetup               PASS      422.13 seconds
TestRunner_l2cap-tester       PASS      15.70 seconds
TestRunner_iso-tester         PASS      15.38 seconds
TestRunner_bnep-tester        PASS      5.33 seconds
TestRunner_mgmt-tester        PASS      103.42 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         PASS      8.60 seconds
TestRunner_ioctl-tester       PASS      9.78 seconds
TestRunner_mesh-tester        PASS      6.64 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      5.50 seconds
IncrementalBuild              PASS      37.75 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============9017411373430240794==--
