Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BF1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Jun 2022 09:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiFYJE3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Jun 2022 05:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiFYJE2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Jun 2022 05:04:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F233E06
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jun 2022 02:04:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k127so4542693pfd.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jun 2022 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+O7LZff8/1NgULcyZL4qIy+jd+NIaYwTHO2t2sl7fzQ=;
        b=X+5vtxnuoVVgLQbx+jS5RvJHdqqqsIEU9OC78BecNQYbyzNxrrWA98PjOP0uhuj/ZL
         1KXTeauJK0QSn9tnJBkfYzxUHF5t88OPfd1TgiI8nQrkPo15wcKR/TkQi2SIuTBhdNIq
         3keeYtxPC/Li7fNdfNhzxT+o0391bawL6w2K9/dWPeBHRTkGONPzGNGreg/AMeKXv1IH
         51lbhs2SbPvWjy6oNlxOmc0vG5UwELckUGr/WyiFrIG4OVQf5s/8GXzsX+603UN9hxq2
         SUYdXgv+YJt9sM9UTH7HV2dCug2H5Zbt1vNia+HUJ0KzrncrX0o3uyTUy+6g9LCtntrI
         vmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+O7LZff8/1NgULcyZL4qIy+jd+NIaYwTHO2t2sl7fzQ=;
        b=xTrp1iejwQGYSAFiMbsvPhwWWOHzNQvHDtYibZWbenrhXxyCknA9Ky46Fn78CrG8BH
         idWGM6ThTy7vNU6BLgQEpli9wrBrO/qxKtuZEXUAfGdetuAXVbLV+GBpA6lfN7Mc17PW
         kxEXNmu7hbF445MhcSKiS1TSNKBM8CuYTHxYHb/uwcT7mVOkGVScZ9WTwPGWykfHNZ35
         sUkSfqX81ar+pZk8jQvJvLmTZW6kNL1Qkvvtah/FsOgqt40nXdxYA0Q5HtprX0mpTkkb
         ti8BqIXAKQBjicIrJ9t12GJ3Ivj5SXXF2CRLLlwvEQ0Ejz2ANoMamVgEjpp8EQIC143f
         fcfg==
X-Gm-Message-State: AJIora/CGGNBdoZH78Custq3Xgj3UYVmnPfg/e5D5Y5PghcDOORM7uOv
        7DynkQtU8BleFTckCm5rz8+71e17gQw=
X-Google-Smtp-Source: AGRyM1sYAtKmgG4g7rBJaZ70PDT6Bo9280IB7zoHx2z+TUS+DV451TJShnXiJHJqO9yIpEhD/TM+Rg==
X-Received: by 2002:a63:2b03:0:b0:40c:6041:930d with SMTP id r3-20020a632b03000000b0040c6041930dmr2915612pgr.455.1656147866872;
        Sat, 25 Jun 2022 02:04:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.75.150])
        by smtp.gmail.com with ESMTPSA id bj10-20020a056a00318a00b00518424f8922sm3125196pfb.77.2022.06.25.02.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 02:04:26 -0700 (PDT)
Message-ID: <62b6cf9a.1c69fb81.856ad.4e6d@mx.google.com>
Date:   Sat, 25 Jun 2022 02:04:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4476530293213253932=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, xw897002528@gmail.com
Subject: RE: [v3] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220625080003.7104-1-xw897002528@gmail.com>
References: <20220625080003.7104-1-xw897002528@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4476530293213253932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653782

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
GitLint                       PASS      0.52 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      30.86 seconds
BuildKernel32                 PASS      27.46 seconds
Incremental Build with patchesPASS      37.90 seconds
TestRunner: Setup             PASS      474.04 seconds
TestRunner: l2cap-tester      PASS      17.08 seconds
TestRunner: bnep-tester       PASS      5.89 seconds
TestRunner: mgmt-tester       PASS      102.26 seconds
TestRunner: rfcomm-tester     PASS      9.43 seconds
TestRunner: sco-tester        PASS      9.24 seconds
TestRunner: smp-tester        PASS      9.31 seconds
TestRunner: userchan-tester   PASS      6.19 seconds

Details
##############################
Test: CheckPatch - FAIL - 0.98 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v3] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922\WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name mismatch: 'From: xhe <xw897002528@gmail.com>' != 'Signed-off-by: He Wang <xw897002528@gmail.com>'

total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12895265.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4476530293213253932==--
