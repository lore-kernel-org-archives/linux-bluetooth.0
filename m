Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD1CC761A6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 17:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjC3RhT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjC3RhS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 13:37:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A06A47
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 10:37:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o2so18780229plg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680197835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XKxR0ke/9a+HSZfus2glwVFIqwqQSdRmUgmFCpRJ4J8=;
        b=cSrknreOdSz0G1J5dKnA3GOm2VpDcEyysbb6mZMgZhIArRaIZRBmn9ahpthQ0ZWjVV
         hsPAu35iAeKwwb1Dtcnt/6JTkUWemKOWUwJ1YDE7eZAPsiruQH9BI5JyCg4Sdix2p14f
         nojjjU205WVeA/dFmQCwiFAUd29MhWKcwYTrE9v4Lu49AIszvmEi0LYn5uqaIg6IBVCU
         C2wtazSGbA2dZnsGyq1CNMIsLalnMKlfenrfspiEL8BHt3k8XhvlZflltdMAjfMYOeWT
         baCnN0eprSJ2qrXlFHjtqRBTjvt55MzGOb6wyEOU1/Vbi+tRnRoQ0vy3GUZX4psr8rhP
         2hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680197835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKxR0ke/9a+HSZfus2glwVFIqwqQSdRmUgmFCpRJ4J8=;
        b=HSvA1i4Nzpu4WbcLnyPOrKl7mMLboWKw9QdDtWtr3AGkYz82Jo083JhYS+tzlzzzOK
         XdNol5GP00lNSpE2vmZFhMME+/yvPNwALbw0btBokYpz7ke9UUU/uUyETDMlV8H3ST3o
         6Baq9fRsKv6SCyE8WKJdYBV8gtvb4dUYW1Jqel2PpHiAchekqIke1kqRC7MYDER99yhS
         nu0iLXVztnJP97RVDC+C5bGKwDx1ufILXlEfyV4YY51PZDrRL66AagVnO/oC6y5ule25
         7EsoxVpJzFmqMxagl7YsH2n0ib5X1JGvjGF0OTLofuDXtIhJEEAF75we9fbTq+SUFj/i
         cZ2A==
X-Gm-Message-State: AAQBX9emFPW9SMp0Qyj+hZQ05rv0IFWFMeAf5plYz+0XooPJVdbi/IBT
        YviREx6N6FkwIXwLi7jCi0+lzFq3CJg=
X-Google-Smtp-Source: AKy350ZtnQSIUoK2GMq+/+hYBYiEL1H5HglGYei9iCp9Er3dERMXxsqv63xDAxiXYg3ZQ0LuUaCt7w==
X-Received: by 2002:a17:90b:3901:b0:23a:333c:6bab with SMTP id ob1-20020a17090b390100b0023a333c6babmr24814414pjb.23.1680197835126;
        Thu, 30 Mar 2023 10:37:15 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.128.254])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090abb8800b002376d85844dsm3446332pjr.51.2023.03.30.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 10:37:14 -0700 (PDT)
Message-ID: <6425c8ca.170a0220.b14ce.795e@mx.google.com>
Date:   Thu, 30 Mar 2023 10:37:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2079418077757210386=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v13,1/4] Bluetooth: Add support for hci devcoredump
In-Reply-To: <20230330095714.v13.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
References: <20230330095714.v13.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2079418077757210386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735510

---Test result---

Test Summary:
CheckPatch                    FAIL      5.63 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      42.58 seconds
CheckAllWarning               PASS      45.59 seconds
CheckSparse                   PASS      51.14 seconds
CheckSmatch                   PASS      138.87 seconds
BuildKernel32                 PASS      40.52 seconds
TestRunnerSetup               PASS      567.89 seconds
TestRunner_l2cap-tester       PASS      19.82 seconds
TestRunner_iso-tester         PASS      21.31 seconds
TestRunner_bnep-tester        PASS      6.96 seconds
TestRunner_mgmt-tester        PASS      129.81 seconds
TestRunner_rfcomm-tester      PASS      10.79 seconds
TestRunner_sco-tester         PASS      9.99 seconds
TestRunner_ioctl-tester       PASS      11.53 seconds
TestRunner_mesh-tester        PASS      8.56 seconds
TestRunner_smp-tester         PASS      9.61 seconds
TestRunner_userchan-tester    PASS      7.10 seconds
IncrementalBuild              PASS      57.88 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v13,1/4] Bluetooth: Add support for hci devcoredump
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#169: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 706 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13194617.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2079418077757210386==--
