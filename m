Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CD4EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jul 2023 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGQLFS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jul 2023 07:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGQLFO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jul 2023 07:05:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CDE58
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 04:04:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-765a1690003so358741885a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689591888; x=1692183888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LVoVSN33C+yIu5kXjS6FO2uWXDpbojhhT5RWdEIEPQY=;
        b=b7+z8mNqRZP0sTpCp6ijm0L5QKYmoEnbCnLChcMsyewwB6ss33vckTF0vUgoMqdKAC
         Z/yGcVFeoIDDbbBPaMo4JMpkbtD3C4ERHW6g5Zuqda4BRVKOM+vSSioleURdIH1TMlgu
         UDSzTMyxTEKG+dQ1vjN+6huPUZf6zSq/eRP9L+JL8DjU9DH78gqRCABCfTHs/ab/pMBx
         8zDHyw4B6dX1zIL3HtcGhMT2w/VGNFlUyuLFsTXj3L5LFGhQM/3pmLa62OiW2o8ZPJrD
         fkAnwxv3/bmhY81fl/XnxkYzaD/oaFecs2bSpVOKPmKx0xxWBbPVzlrkkOdS3pyBYNhT
         SJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689591888; x=1692183888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVoVSN33C+yIu5kXjS6FO2uWXDpbojhhT5RWdEIEPQY=;
        b=h989z8yWTSPpRWEYQHh2jldLF6x9QeevqRPR05ZLyFiHFDmGdpSn+rcYViesKPWQU6
         hJXB2hVqNqMiRyngaLunBPEqdy3wSn76uxBemwXxW5ei3MVfsKsQ6w/HO8Esy0D5pcfB
         mE1lCNgEBXx/569gOaaIoTqWu0H03FS8sBxcb1PlvwzeCm2sUlGH1ekK4W+Ki4heEX1Y
         3mDLxa/2GWIAcYAmVHiaGLkRWOUd3jhEQEy4BrB/t4dcFLVI9e6hawhlIEDfoEC6kmnv
         wnvhqxTeZKdbb46zsFpJWaUd7+Sh2lv2nIRfgincrVms1hYoNg4yOvxv31D0kHmFkcaZ
         U+Fw==
X-Gm-Message-State: ABy/qLZ+q87f/ESeSdm12TRbM6d6hFxRd2DKs/wWIxi/gldqAamTNP8H
        ueSR6cHvscUuWCJ3YHCW6OA5aYu6fK4=
X-Google-Smtp-Source: APBJJlF2xfTyY+FNz7Sg4NoloccgxWmFJmyuUAkfWXKFNBqErEWEgwfjZFEiaqnElw4brg0oCAUsKg==
X-Received: by 2002:a05:620a:24c4:b0:767:e65b:5fcd with SMTP id m4-20020a05620a24c400b00767e65b5fcdmr13593212qkn.68.1689591888312;
        Mon, 17 Jul 2023 04:04:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.119.55])
        by smtp.gmail.com with ESMTPSA id c7-20020ae9e207000000b00767cfb1e859sm5977985qkc.47.2023.07.17.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:04:47 -0700 (PDT)
Message-ID: <64b5204f.e90a0220.c7cf2.34b9@mx.google.com>
Date:   Mon, 17 Jul 2023 04:04:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6755762752033022562=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: Bluetooth: hci_conn: clean up some casts
In-Reply-To: <5cbde2b4-69b5-4b25-a095-251c8347cb09@kili.mountain>
References: <5cbde2b4-69b5-4b25-a095-251c8347cb09@kili.mountain>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6755762752033022562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=766419

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.04 seconds
CheckAllWarning               PASS      34.95 seconds
CheckSparse                   PASS      40.28 seconds
CheckSmatch                   PASS      111.59 seconds
BuildKernel32                 PASS      30.71 seconds
TestRunnerSetup               PASS      470.82 seconds
TestRunner_l2cap-tester       PASS      21.71 seconds
TestRunner_iso-tester         PASS      40.80 seconds
TestRunner_bnep-tester        PASS      10.13 seconds
TestRunner_mgmt-tester        PASS      211.54 seconds
TestRunner_rfcomm-tester      PASS      15.39 seconds
TestRunner_sco-tester         PASS      16.06 seconds
TestRunner_ioctl-tester       PASS      16.84 seconds
TestRunner_mesh-tester        PASS      12.38 seconds
TestRunner_smp-tester         PASS      13.60 seconds
TestRunner_userchan-tester    PASS      10.48 seconds
IncrementalBuild              PASS      29.37 seconds



---
Regards,
Linux Bluetooth


--===============6755762752033022562==--
