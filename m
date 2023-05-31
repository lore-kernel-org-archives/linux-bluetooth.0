Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057E9C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 09:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjEaJep (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjEaJeo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 05:34:44 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6153CA0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 02:34:43 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-19f7f41d9dcso2367412fac.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685525682; x=1688117682;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I3En16K5KvJAaDwYUgUDzkMOp6rMrDq6dR4y69EGNtE=;
        b=NETvYVizi6tGHYLNXGIIDQeSsizM8Rw8PgitcYCopcs1kgRFB86DY1Y6ckHcEfsbLu
         B9s/t2yIj8ph2tc/P9uM2NEHzksBs6OfmMs/gOI4JNVp/aRFLJVPc0D1qjmbME4cgXIX
         FZv+9LYtdEusQlL2DVDJ2zmX9TqVA7SPfYq7kRDzSyGIstCwxvsqbeZgjY4WhTwQOJ1h
         mBWXvMfCjtVUlJjvpl7eet49Q98wJyxpe1La47lHpWXLwwryf3RAOKJQgLBs5JSFgHgU
         JmpdU3nQaLH0qN2ZhehsKDmug/3OszupbrdrMXZPuhFmnS44KEBgywbd1JqE5yCk4Kjk
         hyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685525682; x=1688117682;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3En16K5KvJAaDwYUgUDzkMOp6rMrDq6dR4y69EGNtE=;
        b=RjEBlQ+rp76X8DHGsmrODhNekAriTV3W0x9vgUerMsn+xzC8yNj4rKgeC9H6MXYqwx
         L15KybG+tz7MQLGMjLVamMs/qs4ha8YqKPX1tm51dVZpz3pD7XV2598NQgw6Qu3Ravep
         do7bhuRnzgw7U8iE45IHDpGRqyf95iDe9DOogl2xbb28GWe+glNYZ/9g8eRWNq7Q53Iz
         HbD7/iAsvKts2vmToe8kYvr6o43GidjI8+s+Lbi6ylk1vvaMb7szJSL0uoJmwHbg4AzI
         2xCxeA2iYAky7YsC8QLeAuBoVpgQjbRo6Z5LLbT56c3iZsZQK0e5G0fkKT8nsXa88YiM
         vzzA==
X-Gm-Message-State: AC+VfDzl0YkbGu0gHtjOkJh6B/gYG/hX8C16qeo58BOt1HhNEJ8ax7B1
        YS69vZZi//iamSfdzakupKaLXujmubk=
X-Google-Smtp-Source: ACHHUZ4YCi91E0tB6mdUTR1s0C3nFjYvzKQ9MF+3wnWGP2pJbz++YuMjIJfG+AyZ2dq0MllBzD2i6w==
X-Received: by 2002:a05:6870:80c7:b0:196:5925:24cc with SMTP id r7-20020a05687080c700b00196592524ccmr4174956oab.21.1685525682516;
        Wed, 31 May 2023 02:34:42 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.20])
        by smtp.gmail.com with ESMTPSA id r2-20020a4aea82000000b00552502f3ae1sm5995490ooh.39.2023.05.31.02.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:34:42 -0700 (PDT)
Message-ID: <647714b2.4a0a0220.add82.cee2@mx.google.com>
Date:   Wed, 31 May 2023 02:34:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0200713201880134901=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: fix bdaddr quirks
In-Reply-To: <20230531090424.3187-2-johan+linaro@kernel.org>
References: <20230531090424.3187-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0200713201880134901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752646

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.62 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      34.55 seconds
CheckAllWarning               PASS      37.25 seconds
CheckSparse                   PASS      42.93 seconds
CheckSmatch                   PASS      114.27 seconds
BuildKernel32                 PASS      33.57 seconds
TestRunnerSetup               PASS      471.26 seconds
TestRunner_l2cap-tester       PASS      17.27 seconds
TestRunner_iso-tester         FAIL      24.23 seconds
TestRunner_bnep-tester        PASS      5.78 seconds
TestRunner_mgmt-tester        PASS      117.97 seconds
TestRunner_rfcomm-tester      PASS      9.13 seconds
TestRunner_sco-tester         PASS      8.52 seconds
TestRunner_ioctl-tester       PASS      9.87 seconds
TestRunner_mesh-tester        PASS      7.24 seconds
TestRunner_smp-tester         PASS      8.32 seconds
TestRunner_userchan-tester    PASS      6.05 seconds
IncrementalBuild              PASS      36.67 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 75 (93.8%), Failed: 5, Not Run: 0

Failed Test Cases
ISO AC 6(i) - Success                                Failed       0.239 seconds
ISO AC 7(i) - Success                                Failed       0.237 seconds
ISO AC 8(i) - Success                                Failed       0.238 seconds
ISO AC 9(i) - Success                                Failed       0.243 seconds
ISO AC 11(i) - Success                               Failed       0.238 seconds


---
Regards,
Linux Bluetooth


--===============0200713201880134901==--
