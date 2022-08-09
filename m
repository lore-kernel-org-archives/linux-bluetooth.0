Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC74C25B07
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Aug 2022 16:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbiHIQJ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiHIQJ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 12:09:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82FC1132
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 09:09:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o3so11762483ple.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Aug 2022 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=977dtfk0LJIK2IJUcohC85/q8XxRzalrl1/6ijLREF8=;
        b=Got9Inzl88neGIWiB7aI4IrMur4lM+Sevp6qFVVXPDhIEULSiwGXGQUygwodm6yqFf
         jQMztvCLvYdgQaD7XM9B9FldAr2fMMa0vAXjCIkHwm9UHGAGv6UGcyIb2dBcHEPk1W3J
         5M250N8zdQp2olBdV9IbXQsWi4tIjNLPWiDHoHwlV1nttrT9aLhMszv5BTtAtLc+Q5Bz
         Jos/m2LKC2P3fPq484Z9/R0QC+VbtE7/EezQm6fh9nX5TSGdQz7fRTJtgJzPK6+DPY+K
         WqzM3/E7P7JNq+U3KJ8jotHKNgWUWEQrm8N2cACApBBrmy6hOLdaNXMJU1BUjW+s/jMl
         lsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=977dtfk0LJIK2IJUcohC85/q8XxRzalrl1/6ijLREF8=;
        b=F/NqeRBOLuoFCFNw8VO0EXYF+T0ETrpWIBYtGy/VHDVM7sYSVHo/aUi77yk+vUC3ii
         PasdrW2tFFYUkDkcmP/wnJG+dM2BFq7iAdYIs3yTMcbuaqMG96ay9L32/GeN6oyq2J6H
         wToDxNUEv8HoKDo5uOicbPTQ0EQCMXUXG19nGUOkXWgMOo3TiA0bsHi6hyni0SiW62nE
         FJ1O+DNfCPIqCN65Ro7BdWJ1NCRw0Avkt/aPPNNw1GoTtv6ewv3SOb2QeOke+uVLcyte
         vqxfZa5EfLop8XBd3A1nBdm22I/FGCsRtl6Q45cYmV/W+VMSl6FpcsS7pZ1xka1elRQd
         tNXw==
X-Gm-Message-State: ACgBeo28iLVrHbgGFh4IlkDkxi5ybYYkJwPt77mXcZXu46WtI0lih0R7
        +/l6f3RQROhNxXPUJlNASUz+NK8TKXk=
X-Google-Smtp-Source: AA6agR4Algs/fVuEiRWO+20oc1Os07MDWftuC+ngEkPAJhKBA7y4BkaaPc+BAbwASGNb5UvP9hmaxQ==
X-Received: by 2002:a17:902:8bc5:b0:16c:f48b:d5b5 with SMTP id r5-20020a1709028bc500b0016cf48bd5b5mr24730968plo.128.1660061362809;
        Tue, 09 Aug 2022 09:09:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.49.10])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b0016bd8fb1fafsm10858840plb.307.2022.08.09.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 09:09:22 -0700 (PDT)
Message-ID: <62f286b2.170a0220.fec9e.289a@mx.google.com>
Date:   Tue, 09 Aug 2022 09:09:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7372284070388006475=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v4,1/5] sysfs: Add attribute info for /sys/devices/.../coredump_disabled
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
References: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7372284070388006475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666320

---Test result---

Test Summary:
CheckPatch                    FAIL      4.30 seconds
GitLint                       PASS      2.69 seconds
SubjectPrefix                 FAIL      0.84 seconds
BuildKernel                   PASS      32.61 seconds
BuildKernel32                 PASS      29.36 seconds
Incremental Build with patchesPASS      110.37 seconds
TestRunner: Setup             PASS      482.17 seconds
TestRunner: l2cap-tester      PASS      17.01 seconds
TestRunner: bnep-tester       PASS      6.38 seconds
TestRunner: mgmt-tester       PASS      101.09 seconds
TestRunner: rfcomm-tester     PASS      9.79 seconds
TestRunner: sco-tester        PASS      9.34 seconds
TestRunner: smp-tester        PASS      9.53 seconds
TestRunner: userchan-tester   PASS      6.54 seconds

Details
##############################
Test: CheckPatch - FAIL - 4.30 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v4,3/5] Bluetooth: Add support for hci devcoredump\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#143: 
new file mode 100644

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'include/net/bluetooth/coredump.h', please use '/*' instead
#148: FILE: include/net/bluetooth/coredump.h:1:
+// SPDX-License-Identifier: GPL-2.0-only

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#148: FILE: include/net/bluetooth/coredump.h:1:
+// SPDX-License-Identifier: GPL-2.0-only

WARNING:SPLIT_STRING: quoted string split across lines
#608: FILE: net/bluetooth/coredump.c:300:
+				    "Devcoredump complete with size %u "
+				    "(expect %u)",

WARNING:SPLIT_STRING: quoted string split across lines
#627: FILE: net/bluetooth/coredump.c:319:
+				    "Devcoredump aborted with size %u "
+				    "(expect %u)",

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#730: FILE: net/bluetooth/coredump.c:422:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump init");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#773: FILE: net/bluetooth/coredump.c:465:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump pattern");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#799: FILE: net/bluetooth/coredump.c:491:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump complete");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#821: FILE: net/bluetooth/coredump.c:513:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump abort");

total: 0 errors, 9 warnings, 0 checks, 699 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12939701.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL - 0.84 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============7372284070388006475==--
