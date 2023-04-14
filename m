Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9625AC77B71
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 22:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjDNWcG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 18:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNWcF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 18:32:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA94469E
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 15:32:02 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id m21so9966254qtg.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681511522; x=1684103522;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=48x21a9k4DBNJsmsxHlDd5XuJcS7zN5QY0/3ud2+ASQ=;
        b=LPYV9LF76KGiJvnAJKeEXSIhoBFgzaJAa8HHFwErAEiwNu659yurtCVvcKsbgKMi+g
         gvk1KSwoCYd1rIevneokkonsJJyg67pFRELZYLp11ilQDZrnFz4mp0DIBbBwWtbQ2hZy
         1QKLQRET3iEWfHiohpwoc3LPWn548is9oRZkVtyLfR1dn1CiRLEh+bwrw0YcnJyOz0wT
         VDwZlZa+o34n7WWgbuoHIhZu1lQanCMJ67o3yAQQfr6BYLHenuiD9MOu6kRtb2ATWCf8
         1QATlmkwH/OEZw+yquRkXCBYR8+9eF9LGgyyqEnpvlpy4WbogNdRCnoetiIwbjj7orPw
         mZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681511522; x=1684103522;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48x21a9k4DBNJsmsxHlDd5XuJcS7zN5QY0/3ud2+ASQ=;
        b=Gjrrk+T6mTCyEC8jCOEyl55Kap4PglplS1W+1wVvAyj7N/I8eI2jL3YX6TpHXyPG40
         4vXhrtx/KfcARWY4M7vtiqjBn0J6w9GO5YSI58ahwM/xrNsjnrEjGqSzFfLTUhCqiyHX
         2wkfVX8F6KlKYYeG2KMrMLytJxrcjN9R0tvdRVi6YsHc0h2Dvua2C2D+VNNr9E7qzthP
         8vMfALz9acDnab7hiCjOQKXOq2gIkN8IcYkYfE9LM5vmccQh/El40lpxDRcE8e39euKw
         mg2sjQ267x5WDMj6L3NwmWGWx2tSwxM4C4wN7bqnTnFC+1ODuYuusoWog6i/KMV2uWY9
         Uq3w==
X-Gm-Message-State: AAQBX9dkrV6mXoXjOuM2mrr2It5verbSR3rIlc8d2ZkffMP6FFENRElh
        DkKpAkwS4We7BH+8n122hRaaKAxuTRI=
X-Google-Smtp-Source: AKy350aqDAlnkCEuHBRidv0/mSb5gih41ldlQuaGw60wX7Ho2sFeFRYPk+nf7GW5PCwRuAdS/8jfoA==
X-Received: by 2002:a05:622a:42:b0:3e1:c341:f618 with SMTP id y2-20020a05622a004200b003e1c341f618mr11728057qtw.65.1681511521906;
        Fri, 14 Apr 2023 15:32:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.124.81])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a04ea00b007468bf8362esm43291qkh.66.2023.04.14.15.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 15:32:01 -0700 (PDT)
Message-ID: <6439d461.050a0220.fd67f.03e5@mx.google.com>
Date:   Fri, 14 Apr 2023 15:32:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2373087536295983480=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, raul.cheleguini@gmail.com
Subject: RE: Bluetooth: Add new quirk for broken extended create connection for ATS2851
In-Reply-To: <20230323135804.3962783-1-raul.cheleguini@gmail.com>
References: <20230323135804.3962783-1-raul.cheleguini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2373087536295983480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733189

---Test result---

Test Summary:
CheckPatch                    FAIL      1.63 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.32 seconds
CheckAllWarning               PASS      34.82 seconds
CheckSparse                   PASS      39.43 seconds
CheckSmatch                   PASS      107.85 seconds
BuildKernel32                 PASS      30.63 seconds
TestRunnerSetup               PASS      435.55 seconds
TestRunner_l2cap-tester       PASS      16.84 seconds
TestRunner_iso-tester         PASS      17.28 seconds
TestRunner_bnep-tester        PASS      5.51 seconds
TestRunner_mgmt-tester        PASS      114.76 seconds
TestRunner_rfcomm-tester      PASS      8.82 seconds
TestRunner_sco-tester         PASS      8.15 seconds
TestRunner_ioctl-tester       PASS      9.49 seconds
TestRunner_mesh-tester        PASS      6.95 seconds
TestRunner_smp-tester         PASS      8.00 seconds
TestRunner_userchan-tester    PASS      5.81 seconds
IncrementalBuild              PASS      29.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Add new quirk for broken extended create connection for ATS2851
WARNING: Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html
#109: 
  [1]. https://marc.info/?l=linux-bluetooth&m=167957918920723&w=2

WARNING: quoted string split across lines
#169: FILE: net/bluetooth/hci_sync.c:4537:
 			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),

total: 0 errors, 2 warnings, 0 checks, 45 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13185667.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Add new quirk for broken extended create connection for ATS2851

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
33: B2 Line has trailing whitespace: "  "


---
Regards,
Linux Bluetooth


--===============2373087536295983480==--
