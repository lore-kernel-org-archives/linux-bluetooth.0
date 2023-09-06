Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C0EB8FA5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 10:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjIFKlF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 06:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjIFKlE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 06:41:04 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F0E71
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 03:41:01 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76f08e302a1so213536285a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693996860; x=1694601660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MSBQFowxwiVzMWGKutiVCChXm2U86zNxZBtkcRPVuD0=;
        b=La7AlCauH4piDbyF/5WOQOue6Cybi/nNlr+K73AHdsRdvushThtrTAaR1ZoU1XIZnS
         46bpEOSryTgfLnqQYm0Foqut0MWmAfxhRLH3YiXfJqkEHFl/jZhUy5mhJ5ZvW4UJhFnT
         +7gEmqikh1BjBDl0U+R6h95GZvViVBx0TfaFjNkbw276m8fVcBKX5OhvE/MEGvPwkCZh
         SOEo72WPz+oj35nutolMAul6RCgHO6thpdgGikLR3LNHK6FPkH6JWLKr5xrheSVL/4ei
         gs/t6qRps/8NKxKIO4Kq2sD36gu7hAFQ07tOVl7sPg3diFOT41ABLNZiq8gh6FyIyum+
         7MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996860; x=1694601660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSBQFowxwiVzMWGKutiVCChXm2U86zNxZBtkcRPVuD0=;
        b=OmH9PGn3aVtfRWoXTvmsxVCnrb8F89gOpRraLAViCPm6Nd/GEPiIc7Qt7Pp3F4AAx8
         QMG2SVaO5mPRa1s8SEGMmkogMCJPyPxzf0PWoesN6MbCtN9WE8KE+cpE5ptHVQTZnYHN
         U6OcNiZ5IzQ4vkPnEVR2x5DQuV8XgrllZ5eC1j4B4gSaepnsvdE6CuRhQq9bT3gqDTJd
         /97x689mL4Aur00oWBMl/MVKB6Og2Bn/3JHa/0zzvKJy9O4NgiLpeREkp3mwURzkfz37
         XkAcIuQeB9GglP1UeWPIiEVgjTaCU7uu7j0sTUYeW6P1zNwJJP4CecYlZuAMW5612QKl
         1RYA==
X-Gm-Message-State: AOJu0Yy0LBKHrm+LJY2auP3UiXFlwkknrXYuEjrxHDkT1OXrXsYe2Z9y
        B8fd3DJurqz9Lsl7KOAqqQvJMsgB2zisHQ==
X-Google-Smtp-Source: AGHT+IFvKQyzhOvO1gvuxMjPIdVt2tZzDN00vYy2YXmaFPry/MHNeD+U6lwqOTXSCE89/SlQDO3y+w==
X-Received: by 2002:a0c:8e45:0:b0:64c:3132:be13 with SMTP id w5-20020a0c8e45000000b0064c3132be13mr13495472qvb.55.1693996860142;
        Wed, 06 Sep 2023 03:41:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.71.33])
        by smtp.gmail.com with ESMTPSA id d10-20020a0cb2ca000000b0064f53943626sm5385936qvf.89.2023.09.06.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:41:00 -0700 (PDT)
Message-ID: <64f8573c.0c0a0220.5356.18d1@mx.google.com>
Date:   Wed, 06 Sep 2023 03:41:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4568136511123768671=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
In-Reply-To: <20230906093305.11237-2-claudia.rosu@nxp.com>
References: <20230906093305.11237-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4568136511123768671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=781929

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       FAIL      0.62 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      40.41 seconds
CheckAllWarning               PASS      44.74 seconds
CheckSparse                   WARNING   49.64 seconds
CheckSmatch                   PASS      133.86 seconds
BuildKernel32                 PASS      38.81 seconds
TestRunnerSetup               PASS      567.33 seconds
TestRunner_l2cap-tester       PASS      29.57 seconds
TestRunner_iso-tester         PASS      53.80 seconds
TestRunner_bnep-tester        PASS      11.43 seconds
TestRunner_mgmt-tester        PASS      233.86 seconds
TestRunner_rfcomm-tester      PASS      17.39 seconds
TestRunner_sco-tester         PASS      21.31 seconds
TestRunner_ioctl-tester       PASS      19.66 seconds
TestRunner_mesh-tester        PASS      14.77 seconds
TestRunner_smp-tester         PASS      15.49 seconds
TestRunner_userchan-tester    PASS      12.22 seconds
IncrementalBuild              PASS      31.29 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/1] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B2 Line has trailing whitespace: " "
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/iso.c:1466:18: warning: dereference of noderef expression


---
Regards,
Linux Bluetooth


--===============4568136511123768671==--
