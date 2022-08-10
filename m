Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E7AC00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 17:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiHJRZV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiHJRZU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 13:25:20 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722BB1835C
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 10:25:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u24so3999714qku.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=Dd2ZeQarGxb0+1iTwID+fuOM9ToN7vjrVXqbb8gMuPU=;
        b=lAUeJDvXYxQaY0KOEqq2r0/n6me8oI1cueba494/+B9DKL/hsfHg2+Wx609HL3cU5J
         tzU9TzEpprED7zefxzg91OPf6J3XooTZxnyzbYebHtSrgy+d24/0rsVK8FyFmbn6hn8y
         URb1WJsPjd09sIhARMW3u0gyi7fUcJI6LuhDAl2BQ3Q6nb1L09QOJ3+tDBJbk7Ns3O9I
         ujmv56x58xCbdSLRntCCiCiHh+7l4AgeFjmbcvLnCCBbh2B94vC2tS/HxxPhlzQsm/UA
         XBc+LfK78xennW02nR8rGuXBN2mNXRQUk42V3HF3vc9265vdVCPMTqKTsxzltIJP/ZMv
         fmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Dd2ZeQarGxb0+1iTwID+fuOM9ToN7vjrVXqbb8gMuPU=;
        b=a/MDhMKg3rnKqOdBJMi/mFA9hZf71BN6jEB4OCglEJNq/Iek0j/0xW8yOt7ibTUCfJ
         ucCB1ANokq7x2hi/Wodk9xEdSZP7QO1iVqpvgfDbOLzh01D1R0818dg/8x9wL9DGYsJD
         1yYLFAU8AcWd95qHazcBbFq+m5GnHSp/RcSqai4tQZ2GEB3FlPNEk+5ASjBj6eDMrtUC
         Xt0DPRciTprtMBoDHbIhnM2GO/PKVz3mK+OqczCbum7NImwC1M0WZ5GUa//1J8bMLzYh
         B5L57+nmtxVBGD4S7AyEffjUjxbbHB2X1LDn1Kd6tcFRT7cbnZcbTjjcfEf3V6VK6eiV
         kUAQ==
X-Gm-Message-State: ACgBeo0BHeSdUcCvpbwUX2P/QbJPL5Abj+1NTpNHnvP1bSf0TInMAZK/
        G/NTKEM1D/lz7NrVfJmA2xYwhjJUzu86Ng==
X-Google-Smtp-Source: AA6agR4hKbpI6kgbv8G/ickS4aZzUgMDx45e5egkv/hdakVh8bzSo07T6WJUI+4kvSOsWzWL1YtiAg==
X-Received: by 2002:a05:620a:1728:b0:6b6:9c1:ac3c with SMTP id az40-20020a05620a172800b006b609c1ac3cmr21254047qkb.555.1660152317386;
        Wed, 10 Aug 2022 10:25:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.9.77])
        by smtp.gmail.com with ESMTPSA id x11-20020ac87ecb000000b003051ea4e7f6sm181030qtj.48.2022.08.10.10.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 10:25:17 -0700 (PDT)
Message-ID: <62f3e9fd.c80a0220.d4ee5.0e26@mx.google.com>
Date:   Wed, 10 Aug 2022 10:25:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8217007554158095835=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v5,1/5] sysfs: Add attribute info for /sys/devices/.../coredump_disabled
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8217007554158095835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666640

---Test result---

Test Summary:
CheckPatch                    FAIL      6.70 seconds
GitLint                       PASS      5.02 seconds
SubjectPrefix                 FAIL      1.74 seconds
BuildKernel                   PASS      34.25 seconds
BuildKernel32                 PASS      30.05 seconds
Incremental Build with patchesPASS      115.07 seconds
TestRunner: Setup             PASS      489.71 seconds
TestRunner: l2cap-tester      PASS      17.60 seconds
TestRunner: bnep-tester       PASS      6.69 seconds
TestRunner: mgmt-tester       PASS      104.89 seconds
TestRunner: rfcomm-tester     PASS      10.08 seconds
TestRunner: sco-tester        PASS      10.01 seconds
TestRunner: smp-tester        PASS      10.15 seconds
TestRunner: userchan-tester   PASS      7.00 seconds

Details
##############################
Test: CheckPatch - FAIL - 6.70 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v5,3/5] Bluetooth: Add support for hci devcoredump\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#152: 
new file mode 100644

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'include/net/bluetooth/coredump.h', please use '/*' instead
#157: FILE: include/net/bluetooth/coredump.h:1:
+// SPDX-License-Identifier: GPL-2.0-only

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#157: FILE: include/net/bluetooth/coredump.h:1:
+// SPDX-License-Identifier: GPL-2.0-only

WARNING:SPLIT_STRING: quoted string split across lines
#617: FILE: net/bluetooth/coredump.c:300:
+				    "Devcoredump complete with size %u "
+				    "(expect %u)",

WARNING:SPLIT_STRING: quoted string split across lines
#636: FILE: net/bluetooth/coredump.c:319:
+				    "Devcoredump aborted with size %u "
+				    "(expect %u)",

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#739: FILE: net/bluetooth/coredump.c:422:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump init");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#782: FILE: net/bluetooth/coredump.c:465:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump pattern");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#808: FILE: net/bluetooth/coredump.c:491:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump complete");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#830: FILE: net/bluetooth/coredump.c:513:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump abort");

total: 0 errors, 9 warnings, 0 checks, 699 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12940740.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL - 1.74 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8217007554158095835==--
