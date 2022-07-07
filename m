Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C57DC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jul 2022 23:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiGGXB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGGXB7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jul 2022 19:01:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B556A61D56
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jul 2022 16:01:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z13so25008609qts.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jul 2022 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Q8c+Xm/4UypieJiCEYsfzfjLSPbK8ESc/IMskNeoNpk=;
        b=KFhlmwCOKrZLnVU34MrgE8HN3A98InUsycorNWoAI99HIZ+5CWNVNk0EWMXCjlDxWj
         lXRCjqK0W6DFHy5hqwOuN4vbd/poNzsfbW4CBAvXSv01ouI3OWteAVUwVOV1qcHYksij
         Rs79/XtxZKldhMWpUJo/o0cEjHj/aKY3uRvAk74RP/ZzEQTxS/Ia5XmLJwVQYwOAujVe
         kaNw1cG/1YTpHWv4Tp0FOEpX8lhntiLtw9mmZyPFNf6R5b5Z9MJlVRW9+hUSkaW2O8eE
         h6DVEYo5v9E6hrxgJn2yPt3ee/msS6eFY+GN+jRoGqTDf9riN6q35gJ+vyvNz/8IWOQF
         pESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Q8c+Xm/4UypieJiCEYsfzfjLSPbK8ESc/IMskNeoNpk=;
        b=XNpUDI14zTROkKk1XWGc7OzrjUcQazR8LJkbPq7fkfkm/2nOo4M/TCmPZw8+6F0WmM
         NpU9KL/aRFci/S9W4DYXxqnUUhom7qrTJOwsZm1r5TfFrrr2DVirAcHWUe0UkWhXikVK
         xr3kQz9Tmv4p1TLL6kvjwgu9c455D/FFk9iX4s/Jn3XJeVDa3p43bk9288Mdm3E2JqWd
         7y8s+ajqu5Gm5TRJBr83CjxPz2nJNZO7U8waf0EFp8FHgVw6askUVQZi1emUXB/TTork
         lqul8EDwzx+c8w3GKXQYhYs3+164X4jkq8fwd+G3mIvRbTkIYKe1upB7IzuPmfKjn0xx
         4isg==
X-Gm-Message-State: AJIora+mN5gpx5IzPChNdwWrSvdocVwdflxatEeR5rpcE/Xwg0mPpQ9p
        36UH4pweElJa3I01e302VaITft6fphQ=
X-Google-Smtp-Source: AGRyM1u7lCp2l/IbfkaHRUylEtvw0MZAKKgAvnzLc5unyxdFOTzgZlGotjBddL2XpOy3fqoeDtPp8A==
X-Received: by 2002:ac8:5bc1:0:b0:31d:2852:6898 with SMTP id b1-20020ac85bc1000000b0031d28526898mr539842qtb.318.1657234916439;
        Thu, 07 Jul 2022 16:01:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.75.150])
        by smtp.gmail.com with ESMTPSA id y21-20020ac87095000000b0031b18d29864sm20526319qto.64.2022.07.07.16.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:01:55 -0700 (PDT)
Message-ID: <62c765e3.1c69fb81.50fbb.ec35@mx.google.com>
Date:   Thu, 07 Jul 2022 16:01:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4053071602194866502=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v3,1/3] Bluetooth: Add support for devcoredump
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220707151420.v3.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
References: <20220707151420.v3.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4053071602194866502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=657598

---Test result---

Test Summary:
CheckPatch                    FAIL      4.51 seconds
GitLint                       PASS      3.02 seconds
SubjectPrefix                 PASS      2.72 seconds
BuildKernel                   PASS      32.04 seconds
BuildKernel32                 PASS      27.65 seconds
Incremental Build with patchesPASS      52.40 seconds
TestRunner: Setup             PASS      474.56 seconds
TestRunner: l2cap-tester      PASS      16.85 seconds
TestRunner: bnep-tester       PASS      5.82 seconds
TestRunner: mgmt-tester       PASS      97.85 seconds
TestRunner: rfcomm-tester     PASS      9.35 seconds
TestRunner: sco-tester        PASS      9.12 seconds
TestRunner: smp-tester        PASS      9.11 seconds
TestRunner: userchan-tester   PASS      6.05 seconds

Details
##############################
Test: CheckPatch - FAIL - 4.51 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v3,1/3] Bluetooth: Add support for devcoredump\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#133: 
new file mode 100644

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'include/net/bluetooth/coredump.h', please use '/*' instead
#138: FILE: include/net/bluetooth/coredump.h:1:
+// SPDX-License-Identifier: GPL-2.0-only

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#138: FILE: include/net/bluetooth/coredump.h:1:
+// SPDX-License-Identifier: GPL-2.0-only

WARNING:SPLIT_STRING: quoted string split across lines
#589: FILE: net/bluetooth/coredump.c:300:
+				    "Devcoredump complete with size %u "
+				    "(expect %u)",

WARNING:SPLIT_STRING: quoted string split across lines
#608: FILE: net/bluetooth/coredump.c:319:
+				    "Devcoredump aborted with size %u "
+				    "(expect %u)",

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#691: FILE: net/bluetooth/coredump.c:402:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump init");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#734: FILE: net/bluetooth/coredump.c:445:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump pattern");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#760: FILE: net/bluetooth/coredump.c:471:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump complete");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#782: FILE: net/bluetooth/coredump.c:493:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump abort");

total: 0 errors, 9 warnings, 0 checks, 670 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12910303.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v3,2/3] Bluetooth: Add sysfs entry to enable/disable devcoredump\WARNING:CONSIDER_KSTRTO: simple_strtol is obsolete, use kstrtol instead
#131: FILE: net/bluetooth/hci_sysfs.c:111:
+	if (simple_strtol(buf, NULL, 10))

total: 0 errors, 1 warnings, 0 checks, 45 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12910304.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4053071602194866502==--
