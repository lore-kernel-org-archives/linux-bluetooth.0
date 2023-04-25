Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6949EC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 17:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjDYRCb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjDYRCa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 13:02:30 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898CE59D0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 10:02:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6a5e8baad21so4560779a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682442146; x=1685034146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iXtc/vJhuVldcTbHh7DFIkr7bKNy/VoTQp8KS+alRgI=;
        b=byzs9ougM0lJXdOmgY2Nf6IV4wFGFBy038nBoxne9ZUOYWvyY61n615h47eIu/gcj7
         ZHJpyzrm07GNoxSPYLYuEIzq1+Ec0KqDcIkmvIR9eR2/UMNuF8kP2/aiEQlO4eAd6SE/
         Wo3jb4dfzyYKSQxsiib+AxXicqVEeUW6EJ3yGYIlJpwiWudZ6KuMCzIhhaNYU2fr3aCV
         VRpxz3gzb2o3x+F6GUDQeAON+aJqKxdDNFq56Mia7XeOTybbrwcyIocvdHk2kV7FAQEx
         WdNmCFIMPe2CeAlOyJOE1sHsi/6XILD/ma7i+4rnqCAoQXolhw5Hg1xC71YJmhusZBtL
         4v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682442146; x=1685034146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXtc/vJhuVldcTbHh7DFIkr7bKNy/VoTQp8KS+alRgI=;
        b=QSQyfd1FXF3w1YA9U4gcv/Jka5LROzXfywyR2sxLunRD/cVJ8FrUbGelgnDs4/v4eG
         x5GQqb238el/+foxfCYP4MV/HTZd2ulocEeyRdxHK6luLq7rdES0+xwmDDqCsG1qMaFl
         vRNl4jpzhIFnbQbyDHKvpRpbJTc1Ysmu+GfqzqbOMu1t/xDn2qg5qqHR4ebKy6eTOCAK
         QjSiVXEA91R4LeNZqT7JWQiRocpeJ095e6lYh3VXCuta6Cn2SQeqQlXrJ4bfX7qYGHA2
         URxtkl58EhyMyR/NQVgDoFh/nYf3d9qHTya64QCOP/wHDkI/QGmB9qD+PwLL5AFcnTpb
         iiGA==
X-Gm-Message-State: AAQBX9e5f7hJGkeVPaiY/uO9016BBdEOrk/znzrDkynWSH6I+RG0R9UO
        ZC8vUodN0QEnlkc34MLw3ws0IG80pYE=
X-Google-Smtp-Source: AKy350YoULSGbLDszXLqL6Vx/baThgfeewkxeVwRv3ElDEcz0n4Z7Zc2QltkH9XrEolAmCb6eWx0mA==
X-Received: by 2002:a9d:4e82:0:b0:6a5:dae7:9c74 with SMTP id v2-20020a9d4e82000000b006a5dae79c74mr8050829otk.30.1682442146631;
        Tue, 25 Apr 2023 10:02:26 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.196])
        by smtp.gmail.com with ESMTPSA id h19-20020a9d6f93000000b006a62aac5736sm5512482otq.28.2023.04.25.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:02:26 -0700 (PDT)
Message-ID: <644807a2.9d0a0220.db740.95ed@mx.google.com>
Date:   Tue, 25 Apr 2023 10:02:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3330094289718348287=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, raul.cheleguini@gmail.com
Subject: RE: [v2] Bluetooth: Add new quirk for broken extended create connection for ATS2851
In-Reply-To: <20230425163120.1059724-1-raul.cheleguini@gmail.com>
References: <20230425163120.1059724-1-raul.cheleguini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3330094289718348287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743095

---Test result---

Test Summary:
CheckPatch                    FAIL      1.44 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.96 seconds
CheckAllWarning               PASS      36.71 seconds
CheckSparse                   PASS      41.33 seconds
CheckSmatch                   PASS      111.31 seconds
BuildKernel32                 PASS      32.35 seconds
TestRunnerSetup               PASS      455.78 seconds
TestRunner_l2cap-tester       PASS      17.19 seconds
TestRunner_iso-tester         PASS      21.70 seconds
TestRunner_bnep-tester        PASS      5.64 seconds
TestRunner_mgmt-tester        PASS      116.88 seconds
TestRunner_rfcomm-tester      PASS      9.04 seconds
TestRunner_sco-tester         PASS      8.31 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        PASS      7.06 seconds
TestRunner_smp-tester         PASS      8.29 seconds
TestRunner_userchan-tester    PASS      6.00 seconds
IncrementalBuild              PASS      29.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: Add new quirk for broken extended create connection for ATS2851
WARNING: Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html
#113: 
  [1]. https://marc.info/?l=linux-bluetooth&m=167957918920723&w=2

WARNING: quoted string split across lines
#173: FILE: net/bluetooth/hci_sync.c:4537:
 			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),

total: 0 errors, 2 warnings, 0 checks, 45 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13223516.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: Add new quirk for broken extended create connection for ATS2851

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
36: B2 Line has trailing whitespace: "  "


---
Regards,
Linux Bluetooth


--===============3330094289718348287==--
