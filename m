Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D88C27C76
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Jan 2023 21:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjAYV5e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Jan 2023 16:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAYV5e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Jan 2023 16:57:34 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FA43921
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 13:57:11 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1633e6f83d4so347154fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 13:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aL1OixDIHg6aIQM9Z4vtLylcDWyXomHcnB8vo9s242I=;
        b=qbR2oT+C7cUQgvv0rd4xx9UYZcxMMaT2IyVrM7LKfRlKkyOSsibieZFsHR+kx4dtSS
         zA0tKiVe8HxvIFEmQWz8eEwi61hNnYJpA2yadL2CJooX+gupYJpk33Eckp7efOAC6S1a
         Lr68dSzDdZt8mFM71Y3b3hvdCEm8KJaFdXIjvr2PeQmbaORk7vH5sMxv++JEtxMk4Ypo
         UmTuK7YqmovDJI6pueAwe/8WHXCYNHHBVgA/K1OeAW/dadzz+C3QBlBlY4mvQHs5J/QP
         OoVm9AiitHwKW9u01ImHpDTkwSeCSPMoHNxVlNvI4hugGqswMr5oa5MBHo6TVF2Vyrg5
         P0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aL1OixDIHg6aIQM9Z4vtLylcDWyXomHcnB8vo9s242I=;
        b=TSLSSoWSBYu49MXhvRmiLBYI7d4bI5s6vj0VihxkZqGJfsurKP5Z7Z1kiAfRgwGFxN
         +sJbAeYwlUhaywGzysOwKVZsDC5KEM9lPnjeL1CLj4ivg9J/qsLR+B/jkKwRmUkAk5At
         YdueyvRHnShK/5oVqj+EFVLBLA35Ct62flUAKN9DAR5RKQWYj3jH8/nvHAA/61HSA+6o
         iF2HAWzmmxkXEc27gHKfm/JIYSMb4ysdhykXC3X4Kyg8X7oqnRIqFCRDMcUPOBo3Ii0+
         Ve3r35vLfudeXSahqJR4BkMS2nO/ESiPmMBilTCoEbxrwgKVrUETeF4DXV2h/eLclCb1
         X4ng==
X-Gm-Message-State: AFqh2kqrmFJZcBtau5BdhZxfYFP5uJBEZHf9Rq5JS+1aqlPWJFYDW7pS
        EK+Y49CRYH3szpYpP1Qjons+VWggICAL3Q==
X-Google-Smtp-Source: AMrXdXsEBVDaWExxbwk5eKj471Emd0DHWGhxQIc7u+jICx5eNGRhA8FGXyOqIPupCdUtr+kM8+pCRw==
X-Received: by 2002:a05:6870:35c4:b0:15f:74b2:9173 with SMTP id c4-20020a05687035c400b0015f74b29173mr10228618oak.1.1674683828896;
        Wed, 25 Jan 2023 13:57:08 -0800 (PST)
Received: from [172.17.0.2] ([104.44.128.240])
        by smtp.gmail.com with ESMTPSA id o1-20020a4abe81000000b004a0ad937ccdsm2359018oop.1.2023.01.25.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:57:08 -0800 (PST)
Message-ID: <63d1a5b4.4a0a0220.9d8f1.ae69@mx.google.com>
Date:   Wed, 25 Jan 2023 13:57:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3347452899669663631=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Reason to disable adv during power off without clearing
In-Reply-To: <20230125131159.kernel.v1.1.Id80089feef7af8846cc6f8182eddc5d7a0ac4ea7@changeid>
References: <20230125131159.kernel.v1.1.Id80089feef7af8846cc6f8182eddc5d7a0ac4ea7@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3347452899669663631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715641

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       FAIL      0.85 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.31 seconds
CheckAllWarning               PASS      33.97 seconds
CheckSparse                   PASS      38.25 seconds
CheckSmatch                   PASS      107.12 seconds
BuildKernel32                 PASS      29.96 seconds
TestRunnerSetup               PASS      430.17 seconds
TestRunner_l2cap-tester       PASS      16.16 seconds
TestRunner_iso-tester         PASS      16.36 seconds
TestRunner_bnep-tester        PASS      5.43 seconds
TestRunner_mgmt-tester        FAIL      110.68 seconds
TestRunner_rfcomm-tester      PASS      8.62 seconds
TestRunner_sco-tester         PASS      7.99 seconds
TestRunner_ioctl-tester       PASS      9.42 seconds
TestRunner_mesh-tester        PASS      6.79 seconds
TestRunner_smp-tester         PASS      7.81 seconds
TestRunner_userchan-tester    PASS      5.73 seconds
IncrementalBuild              PASS      27.75 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[kernel,v1,1/1] Bluetooth: Don't send HCI commands to remove adv if adapter is off

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[kernel,v1,1/1] Bluetooth: Don't send HCI commands to remove adv if adapter is off"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Add Advertising - Success 18 (Power -> off, Remove)  Timed out    2.314 seconds


---
Regards,
Linux Bluetooth


--===============3347452899669663631==--
