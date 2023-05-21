Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E5C77B73
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 16:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjEUQhQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 12:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjEUQhN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 12:37:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E004D2
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 09:37:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae3fe67980so49960905ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684687031; x=1687279031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UPqRV1ASvkA1tIMMoFGeb4WuxH6ZgrIVgskwe7NR+pQ=;
        b=naHLzR5c25IPeFYxMq2IdP2psTnqF+rejHOGwl1TvOMFMgJPSbpViJnQeH+QUNv8bQ
         3QgONZ4uHJKDi14ztPVF3gdrIzzhcD0iqpy4SIGutyH9x7M82xHvGAiJQIVM77FgmZtp
         5KrQsEG7WccmNDnGwSXrrDBUn2beGft5JXfo6b/yUpJ2yIjsVT1xyOCFY98aKArEWwQV
         geodp6w91aMkFFpyy84Ng4Zh5LrCp5ihhoRCJb70BMfnf8Zv8WfdXgAdgTXJCTuTlK2z
         stwMZN+QgvZX1Zt4fKkQNB4gRZiWJaIHftDIEMfTQXdoN24gCEvaauIS58BgJAoMBmgr
         UygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684687031; x=1687279031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPqRV1ASvkA1tIMMoFGeb4WuxH6ZgrIVgskwe7NR+pQ=;
        b=jd5pDF6e65+TSgt0Ve22K9gz9gBNjCxCwQ6Yny1kpu19/uCMwtma9+mBawXs+xsisg
         MmKk6wa3Ob9SRXP35mUwKj/0X9exRCbSp/4lwGADdEAmgoDTt0bR27TfK8G51qyZtDGP
         6k8hkFW1eCB3jH+QK//29hUrpGD+hYMscF2CcqDzRToIymcaFqWYxMjWQlmEqX7kNXGL
         RcnjL6Prnd5Srv41M0kV2nMRXBWL7SFV0By2H7ZEGSomcg1+xVtayvHBndU2zsYaNPQf
         8biVBS06II8b81kZonoq6LrrwSj99JOJUzQYIdqZqGq0z0+HBVgpUTiXbLC+qvUYjqX5
         MLBg==
X-Gm-Message-State: AC+VfDxpKIBzfzcK5yZ+dQKx75EMsfE023XUxlv2P3n2yifvwXRaej43
        MPTJ0sdRhOUxClwp4i/1/jUDrCHiTXE=
X-Google-Smtp-Source: ACHHUZ41W+MM0wNY2zV2aJKf48DsJ9mvM9hl86+MFKIqUmuAHK58AYcySIavigRFheyUhhmjSiAMXQ==
X-Received: by 2002:a17:903:1ca:b0:1ae:55d2:fff5 with SMTP id e10-20020a17090301ca00b001ae55d2fff5mr10102408plh.31.1684687030630;
        Sun, 21 May 2023 09:37:10 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.213.128])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001a922d43779sm3162967plg.27.2023.05.21.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 09:37:10 -0700 (PDT)
Message-ID: <646a48b6.170a0220.69e83.4ad9@mx.google.com>
Date:   Sun, 21 May 2023 09:37:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8576717053842697466=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [1/2] Bluetooth: ISO: consider right CIS when removing CIG at cleanup
In-Reply-To: <cfe0dd7b21b58dcb06af414e92386e5dd372adb0.1684683803.git.pav@iki.fi>
References: <cfe0dd7b21b58dcb06af414e92386e5dd372adb0.1684683803.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8576717053842697466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749545

---Test result---

Test Summary:
CheckPatch                    FAIL      1.64 seconds
GitLint                       FAIL      0.85 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      38.70 seconds
CheckAllWarning               PASS      42.33 seconds
CheckSparse                   PASS      47.65 seconds
CheckSmatch                   PASS      129.33 seconds
BuildKernel32                 PASS      37.24 seconds
TestRunnerSetup               PASS      532.64 seconds
TestRunner_l2cap-tester       PASS      19.71 seconds
TestRunner_iso-tester         PASS      25.55 seconds
TestRunner_bnep-tester        PASS      6.73 seconds
TestRunner_mgmt-tester        PASS      131.70 seconds
TestRunner_rfcomm-tester      PASS      10.63 seconds
TestRunner_sco-tester         PASS      9.81 seconds
TestRunner_ioctl-tester       PASS      11.61 seconds
TestRunner_mesh-tester        PASS      8.48 seconds
TestRunner_smp-tester         PASS      9.66 seconds
TestRunner_userchan-tester    PASS      7.11 seconds
IncrementalBuild              PASS      41.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] Bluetooth: ISO: consider right CIS when removing CIG at cleanup
ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 0 checks, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13249430.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/2] Bluetooth: ISO: fix CIG auto-allocation to select configurable CIG
ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 0 checks, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13249431.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/2] Bluetooth: ISO: fix CIG auto-allocation to select configurable CIG

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B2 Line has trailing whitespace: "    "
19: B2 Line has trailing whitespace: "    "
20: B1 Line exceeds max length (83>80): "    ISO Connect2 CIG auto/auto Seq - Success             Passed       0.148 seconds"


---
Regards,
Linux Bluetooth


--===============8576717053842697466==--
