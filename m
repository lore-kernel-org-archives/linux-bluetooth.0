Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C66AC001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 17:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjGNRHV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjGNRHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 13:07:20 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4DF1BC9
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 10:07:18 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3465ec72cc8so9971765ab.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689354438; x=1691946438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ/TE+0ndA5r2XZguC55t8CyBTFW2JYdsUNWoibzB4g=;
        b=Ez2RSS9z4FxXUOXuOBXny6T6S8BuT1D56CJPxYf8NedPUj2UYWU/bZIDYl9caiewn4
         +k4GRGV77t3/p9tPz3UXvD+8GlYYnsBJhUJRtBdi+rjSeVL3jx4Thd85bQ4XmCx8X7Ba
         Q7vLYQB43Wqfj4trtf+UkEZ69Auem74PA7cdxV+iDEQ04HDXdvXPZ04DUYOT89YCuT7V
         /3T2Ys24YdRCSkiWku1Tsy8jkt89AlQPqeAq9r2duA8y2RP2d0DJGFcTbljWn4nSXXLs
         zA0+Phh/9CbbNUsWgYJXy1nwIWpi037Xzj3NkceN2Njrs5hOddK0vBx8VhN9ywY4qBU+
         8hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689354438; x=1691946438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQ/TE+0ndA5r2XZguC55t8CyBTFW2JYdsUNWoibzB4g=;
        b=K84bU0hc2Ug7ly8KH/YWSMofFS6Ty7Vi0AQiDAwbX88OGe42Z1I14oLkZx3/8ig18G
         cPbzJA1fz4UgF7rRiguqSnr8Sr7ocvmx/V8tem+K+o/AtPjKwCLL1j6B13JpBK5c3E4U
         2hh67r13iSOLsXV4w0+sD+QWG6JKXwd90sS7oY6OsbI1+cRF1azHS6Cw4SKlGlI9eJut
         RTc8sWZ/+CC72R9dNweHAmXy5VKiOvlGTlDEpFqb/bCVH/Jo79RkJt9bbX3ZKcDPbHwm
         5Yf2sWp7QqDuWvL2PznJa9w82k9dFspKlFVFkxQQfzmMtBXZxDuwJmyCg0SBUfABCObM
         JHqQ==
X-Gm-Message-State: ABy/qLYIBTxD/IIxwCX2VM5FLJVz/jw/WtUc33f1IccZ0D+Q5C1fD5wo
        hfyN9mzbGU8mcdjKwq5ZaEaw1dmetgs=
X-Google-Smtp-Source: APBJJlGbzZ21gC2Q7zCzTZHx2e3UBnjkA64i91qKWkwkJm0zLHdUrfa6fOJVnibs5LLqJVzzFa9iPQ==
X-Received: by 2002:a92:ce88:0:b0:346:5a8b:53f3 with SMTP id r8-20020a92ce88000000b003465a8b53f3mr5619641ilo.26.1689354437808;
        Fri, 14 Jul 2023 10:07:17 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.18.88])
        by smtp.gmail.com with ESMTPSA id q4-20020a02cf04000000b0042b6cb44429sm2677270jar.46.2023.07.14.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:07:17 -0700 (PDT)
Message-ID: <64b180c5.020a0220.4fc47.4687@mx.google.com>
Date:   Fri, 14 Jul 2023 10:07:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0919123460273890046=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, joeyli.kernel@gmail.com
Subject: RE: Bluetooth: hci_event: Ignore NULL link key
In-Reply-To: <20230714161210.20969-1-jlee@suse.com>
References: <20230714161210.20969-1-jlee@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0919123460273890046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765780

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      33.91 seconds
CheckAllWarning               PASS      36.79 seconds
CheckSparse                   WARNING   41.59 seconds
CheckSmatch                   WARNING   113.49 seconds
BuildKernel32                 PASS      32.55 seconds
TestRunnerSetup               PASS      496.37 seconds
TestRunner_l2cap-tester       PASS      23.35 seconds
TestRunner_iso-tester         PASS      41.73 seconds
TestRunner_bnep-tester        PASS      10.61 seconds
TestRunner_mgmt-tester        PASS      217.91 seconds
TestRunner_rfcomm-tester      PASS      16.03 seconds
TestRunner_sco-tester         PASS      16.84 seconds
TestRunner_ioctl-tester       PASS      17.97 seconds
TestRunner_mesh-tester        PASS      13.39 seconds
TestRunner_smp-tester         PASS      14.57 seconds
TestRunner_userchan-tester    PASS      11.50 seconds
IncrementalBuild              PASS      31.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_event: Ignore NULL link key
WARNING: From:/Signed-off-by: email address mismatch: 'From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>' != 'Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>'

total: 0 errors, 1 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13313835.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_event: Ignore NULL link key

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (81>80): "Closes: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============0919123460273890046==--
