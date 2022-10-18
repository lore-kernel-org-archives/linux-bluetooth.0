Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FB3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 18:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJRScS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJRScP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 14:32:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA192F4D
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 11:32:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so14777502pjl.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=54RoSb+gsOT2SAU2DMltPjNrFjUoCXfppRDwJjGLnU0=;
        b=bBAmbM9B908L9fKzfwEPBwZ0aLian0fokYYU7rRglMFCW5FjWekR/x5xC6eekDokSh
         SyO5oDoAEgh/TSvGBkAZLJeHP58V0jC/EoRq6kk6JyiufNNXR/QwYAA0YndWw5Q+sovg
         TEgAgvcCT5V8EcL/aGe3twCVUUglAFFUT/pr71WGlByefjfYL8I7h7URajFhvPB6q3iT
         h3kZ3JiJOf01FksZciNSfKA9NUo+2Tvv7OYOJE37mEx1D7Mk+9DL02qZeUq5cNig/4cM
         Nq6ibfJFy4huS4U2XXdyUAgXYsDqT46oLuRHLIkv/GNcTHd6YqkZc6ogqdHemgpTFX1Q
         ffQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54RoSb+gsOT2SAU2DMltPjNrFjUoCXfppRDwJjGLnU0=;
        b=gslcMgrGjyptgDbHtVh4hbp6D9AhPmfnTWweZGB/vtHg/mWHYq6JWrmKgV5vtklgOM
         mwIQXf4ho2/x/1HRU6Ka+XY6Fg4QhQKlC4RjEUkS97q1NuOXqtusdxOKazjZnr5WIsge
         tNDeVmlWe4TUcp7wNuD2nvGAqmVfshjZEIu18Yeeo/hDzgHHaKg3kyfqERoh2TVuAWaR
         r1B/yWcxzMNITFKIl0fQ9lbebja55U0QNc7fylCdBStoiARfWHBZXhHyYqlTubsTKo2Z
         e5qXCgGx7hxzB0CB+m73HMTlqSOE3GUyCMx0QewfrOuBrjXuGjpbt85jYzGGY75rEOqQ
         Q//g==
X-Gm-Message-State: ACrzQf2L8v3EbbfMQl6Grw9iHcNRa5KsJjG1vBMlaFB0PMbtE+pF01KY
        w8UsYqVwM5Nm+RTBi7fYrbX3SehAEeU=
X-Google-Smtp-Source: AMsMyM4FJeBjljpJ54eM64mvwTE3Za/AVJKELJORzbIdMGDlkd8qjnRVrriu/uwborqQIO4poAX7Zg==
X-Received: by 2002:a17:90b:4d0c:b0:20b:c983:2d85 with SMTP id mw12-20020a17090b4d0c00b0020bc9832d85mr41228228pjb.45.1666117930019;
        Tue, 18 Oct 2022 11:32:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.87.167])
        by smtp.gmail.com with ESMTPSA id f23-20020a63f757000000b00460c67afbd5sm8413871pgk.7.2022.10.18.11.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:32:09 -0700 (PDT)
Message-ID: <634ef129.630a0220.c76d6.fb34@mx.google.com>
Date:   Tue, 18 Oct 2022 11:32:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7699783861717577562=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, igor375@gmail.com
Subject: RE: virtio_bt: Fix alignment in configuration struct
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221018173050.581812-2-Igor.Skalkin@opensynergy.com>
References: <20221018173050.581812-2-Igor.Skalkin@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7699783861717577562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686388

---Test result---

Test Summary:
CheckPatch                    FAIL      1.21 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      43.15 seconds
BuildKernel32                 PASS      35.30 seconds
Incremental Build with patchesPASS      57.19 seconds
TestRunner: Setup             PASS      670.92 seconds
TestRunner: l2cap-tester      PASS      19.69 seconds
TestRunner: iso-tester        PASS      20.41 seconds
TestRunner: bnep-tester       PASS      7.48 seconds
TestRunner: mgmt-tester       PASS      125.55 seconds
TestRunner: rfcomm-tester     PASS      11.91 seconds
TestRunner: sco-tester        PASS      11.23 seconds
TestRunner: ioctl-tester      PASS      13.98 seconds
TestRunner: mesh-tester       PASS      10.32 seconds
TestRunner: smp-tester        PASS      12.00 seconds
TestRunner: userchan-tester   PASS      8.77 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.21 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,1/1] virtio_bt: Fix alignment in configuration struct\WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email address mismatch: 'From: Igor Skalkin <igor375@gmail.com>' != 'Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>'

total: 0 errors, 1 warnings, 52 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13010854.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL - 0.33 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============7699783861717577562==--
