Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF34FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Nov 2022 09:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiK3J6P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Nov 2022 04:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiK3J6O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Nov 2022 04:58:14 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8B22E697
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 01:58:12 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z1so11819455qkl.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 01:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBRsXNRJPSjuHWTUVZdYsPcFWWy98cJcm0lbRLsUmi4=;
        b=ULIBRzryShAbqB+YodAp+HZ/S9Gt+z+JJR6kpwC5oxXNvFVYo+5GEHZrYjgTW0rXIW
         1soutIUJhzU0sNsKs7ybIqXbEFXTh9Fqek/KaAHyjjql7FItbOSGMS5K4YOYpNkgs1cl
         HXp75Rb+Fo9gxVpB8MOy/TOtR4djo6N9UrbQw4bfjLcpahDd3DuPhVVEkhc3fEa9dCxh
         yxjKtRIfuT1Y9iPensoZ8v9jUHhT1+/j6TXhS9l95EcJNcLIved+w63KacEnDpoioP7h
         /2avtn6OUzhXKCqN0t7AFtRohATjn1XaNkuipBevvTWsFzcGQ6RSRQIFT7cNtzEObhH8
         ui2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBRsXNRJPSjuHWTUVZdYsPcFWWy98cJcm0lbRLsUmi4=;
        b=dvAQkVHML4RBJcgr/LEUhtka8OiiQioUE3dlYBonjiUyPfzV4BuoIpezHPPlTKoMra
         E1MML5cCQGIDgJvRSH/mDrjwpvXLNczNoy7S4L1lwaknJv1PlpxjcQQlLwaoCWq7hU4p
         G2UjkT+tn4l6/7aArQNA0ErbXVB+vtUtSY3GEhpFWNI+yu2h+D84U8qyCiMKCRg2MEpL
         lbc8hZU572KYPnjoqlL9dmp8YmRAoeQBRdNBvxWwQC4whtR5NiR8+DR1Xj+yWG7Ql3XG
         ilfn08P/z0Im9RpQDS4KRr67JuHqsP72Fdrtxmg3F9TnFJtin21g7EO2S1nnFdaudPBM
         3Uyw==
X-Gm-Message-State: ANoB5pmyJ3CA5kQVWG1T9hYsbj5VvM3OTQ8nOOjCoYtYJ3eABuE7AHKW
        lRtKVqGKr8YiTztvNFDhLtI7HY/lFtBJaQ==
X-Google-Smtp-Source: AA0mqf54FjJM5ZZv7Nfy2J7xxNxiZLPM0a0fmCRyApmZNp7PA/meCL5uPENFmS86bq4gCPqMjfKcjw==
X-Received: by 2002:a37:ba82:0:b0:6ee:c002:1f64 with SMTP id k124-20020a37ba82000000b006eec0021f64mr37715226qkf.165.1669802291454;
        Wed, 30 Nov 2022 01:58:11 -0800 (PST)
Received: from [172.17.0.2] ([4.227.207.222])
        by smtp.gmail.com with ESMTPSA id b22-20020ac86796000000b003a591194221sm607914qtp.7.2022.11.30.01.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:58:11 -0800 (PST)
Message-ID: <63872933.c80a0220.b11da.0fa2@mx.google.com>
Date:   Wed, 30 Nov 2022 01:58:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2439391259890147014=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lifangpi@hotmail.com
Subject: RE: [v2] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
In-Reply-To: <SI2PR02MB46038FD0DE47A12629F9FB25DD159@SI2PR02MB4603.apcprd02.prod.outlook.com>
References: <SI2PR02MB46038FD0DE47A12629F9FB25DD159@SI2PR02MB4603.apcprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2439391259890147014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700376

---Test result---

Test Summary:
CheckPatch                    FAIL      0.93 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      39.95 seconds
BuildKernel32                 PASS      35.22 seconds
TestRunnerSetup               PASS      501.50 seconds
TestRunner_l2cap-tester       PASS      17.75 seconds
TestRunner_iso-tester         PASS      17.84 seconds
TestRunner_bnep-tester        PASS      6.51 seconds
TestRunner_mgmt-tester        PASS      121.30 seconds
TestRunner_rfcomm-tester      PASS      10.95 seconds
TestRunner_sco-tester         PASS      10.10 seconds
TestRunner_ioctl-tester       PASS      11.40 seconds
TestRunner_mesh-tester        PASS      8.01 seconds
TestRunner_smp-tester         PASS      9.66 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PASS      36.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
WARNING: From:/Signed-off-by: email name mismatch: 'From: ligongwei <ligongwei@kylinos.cn>' != 'Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>'

total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13059615.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2439391259890147014==--
