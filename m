Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DDDEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 18:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFWSAE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjFWSAD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 14:00:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7852133
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 11:00:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76246351f0cso79836885a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687543200; x=1690135200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pXZ8b3Jbqx6T+C+ZxTOdesFLB8NMah0yNb9gxD1eNMc=;
        b=bPo5++mBO71icZGxM56J/zSp+HKMA7gDWZCKOZctb4ReExvsSKbeTvvd4X3Y0PfgPZ
         4z7Wbq2JmZo5by8enE83c7Qbmqmws/o8mIQM0F2EZlHotdtkWF4+IyBe2OJ2wUkliOAF
         NahwRHudxUUgcHyI1i/0rHzmNJDXDEtXWxDinD78kWwifzwqIqkC6oewECYO7UQ37yB9
         A6NJwzy5CAHjkSRC1/1/ldoAwoU+z/pLt5MUhhc52llJo/xpeS0NXQ4PALZ2TvbfWrVJ
         LsA2mZABje317R0L5OAe4XIgLeO++T25e8O57R4Ed9mtkSTngCdqDWlLfGfkgtQCrEV9
         N7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543200; x=1690135200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXZ8b3Jbqx6T+C+ZxTOdesFLB8NMah0yNb9gxD1eNMc=;
        b=DrDFqKIyLwSsYYcpu+w2RfW0NN/HTCPPvcrSOtqomQzNbsms0omiGJf0tidRWl90eY
         hbZT5BOGY3kKzcQCL4AagXbpwAZbTtbrsMpKlztmEAd7UFp1bQG2Nc6COHvRdY6EyBsZ
         zWkxmcLTKVPG1nLh5mm23wNBeWKd0Uc562SQY5HITWEZjQG0i/qDQ6tKlXHceHqmjDHz
         8Y7lobNPM+Ut+bD+4ircseTSKXlGNmOXWFmCalHUSY1noyvZaoAqtWsTDuG0mN9A+pZF
         2U3jJjpW9sku+NGwAXer9OAN12gu/anwwanEinEAhq48U86KenPRUkNwbVNVJQfo/qHc
         Izkg==
X-Gm-Message-State: AC+VfDzFdaIWrxasCEIzoPEduNI1Dv+vNslj8mgoQ1ErGFvcvqSeP/QI
        LVmRs8YQbfAyyPFUrMcQxc11+62RG/w=
X-Google-Smtp-Source: ACHHUZ7xPMw9raU8dujJWVRBj8XAn8Nb9rZkMaGguUcEmlY8/XrmheYZzh6dzMOp7yHI4GFIr0bHEA==
X-Received: by 2002:a05:620a:8013:b0:763:9f05:99a0 with SMTP id ee19-20020a05620a801300b007639f0599a0mr18065157qkb.0.1687543200328;
        Fri, 23 Jun 2023 11:00:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.137.183])
        by smtp.gmail.com with ESMTPSA id l15-20020ae9f00f000000b00759554bbe48sm1995781qkg.4.2023.06.23.10.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 11:00:00 -0700 (PDT)
Message-ID: <6495dda0.e90a0220.555cf.689e@mx.google.com>
Date:   Fri, 23 Jun 2023 11:00:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7015025390081051227=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: hci_conn and ISO concurrency fixes
In-Reply-To: <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
References: <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7015025390081051227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759866

---Test result---

Test Summary:
CheckPatch                    FAIL      4.21 seconds
GitLint                       FAIL      2.10 seconds
SubjectPrefix                 PASS      0.68 seconds
BuildKernel                   PASS      33.21 seconds
CheckAllWarning               PASS      35.89 seconds
CheckSparse                   PASS      40.89 seconds
CheckSmatch                   PASS      113.98 seconds
BuildKernel32                 PASS      31.83 seconds
TestRunnerSetup               PASS      450.74 seconds
TestRunner_l2cap-tester       PASS      16.89 seconds
TestRunner_iso-tester         FAIL      22.89 seconds
TestRunner_bnep-tester        PASS      5.40 seconds
TestRunner_mgmt-tester        PASS      128.09 seconds
TestRunner_rfcomm-tester      PASS      8.59 seconds
TestRunner_sco-tester         PASS      7.93 seconds
TestRunner_ioctl-tester       PASS      9.29 seconds
TestRunner_mesh-tester        PASS      6.77 seconds
TestRunner_smp-tester         PASS      7.89 seconds
TestRunner_userchan-tester    PASS      5.66 seconds
IncrementalBuild              PASS      51.76 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,2/5] Bluetooth: hci_sync: iterate conn_hash safely in hci_disconnect_all_sync
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#102: 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014

total: 0 errors, 1 warnings, 0 checks, 180 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13290840.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,3/5] Bluetooth: hci_conn: hold ref while hci_connect_le_sync is pending
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#101: 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014

total: 0 errors, 1 warnings, 0 checks, 41 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13290841.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,4/5] Bluetooth: ISO: fix use-after-free in __iso_sock_close
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#106: 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014

total: 0 errors, 1 warnings, 0 checks, 90 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13290842.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,2/5] Bluetooth: hci_sync: iterate conn_hash safely in hci_disconnect_all_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[RFC,2/5] Bluetooth: hci_sync: iterate conn_hash safely in hci_disconnect_all_sync"
16: B1 Line exceeds max length (157>80): "BUG: KASAN: slab-use-after-free in hci_set_powered_sync (net/bluetooth/hci_sync.c:5345 net/bluetooth/hci_sync.c:5385 net/bluetooth/hci_sync.c:5397) bluetooth"
19: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
25: B1 Line exceeds max length (107>80): "? __virt_addr_valid (./include/linux/mmzone.h:1901 ./include/linux/mmzone.h:1997 arch/x86/mm/physaddr.c:65)"
26: B1 Line exceeds max length (124>80): "? hci_set_powered_sync (net/bluetooth/hci_sync.c:5345 net/bluetooth/hci_sync.c:5385 net/bluetooth/hci_sync.c:5397) bluetooth"
28: B1 Line exceeds max length (124>80): "? hci_set_powered_sync (net/bluetooth/hci_sync.c:5345 net/bluetooth/hci_sync.c:5385 net/bluetooth/hci_sync.c:5397) bluetooth"
29: B1 Line exceeds max length (122>80): "hci_set_powered_sync (net/bluetooth/hci_sync.c:5345 net/bluetooth/hci_sync.c:5385 net/bluetooth/hci_sync.c:5397) bluetooth"
49: B1 Line exceeds max length (108>80): "hci_conn_add (./include/linux/slab.h:559 ./include/linux/slab.h:680 net/bluetooth/hci_conn.c:1002) bluetooth"
62: B1 Line exceeds max length (85>80): "__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)"
65: B1 Line exceeds max length (93>80): "kobject_put (lib/kobject.c:683 lib/kobject.c:714 ./include/linux/kref.h:65 lib/kobject.c:731)"
72: B1 Line exceeds max length (117>80): "exit_to_user_mode_prepare (./include/linux/resume_user_mode.h:49 kernel/entry/common.c:171 kernel/entry/common.c:204)"
[RFC,3/5] Bluetooth: hci_conn: hold ref while hci_connect_le_sync is pending

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (100>80): "BUG: KASAN: slab-use-after-free in hci_le_create_conn_sync (net/bluetooth/hci_sync.c:6167) bluetooth"
18: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
24: B1 Line exceeds max length (107>80): "? __virt_addr_valid (./include/linux/mmzone.h:1901 ./include/linux/mmzone.h:1997 arch/x86/mm/physaddr.c:65)"
52: B1 Line exceeds max length (108>80): "hci_conn_add (./include/linux/slab.h:559 ./include/linux/slab.h:680 net/bluetooth/hci_conn.c:1002) bluetooth"
54: B1 Line exceeds max length (104>80): "process_adv_report.constprop.0 (net/bluetooth/hci_event.c:6172 net/bluetooth/hci_event.c:6293) bluetooth"
56: B1 Line exceeds max length (90>80): "hci_event_packet (net/bluetooth/hci_event.c:7515 net/bluetooth/hci_event.c:7570) bluetooth"
67: B1 Line exceeds max length (85>80): "__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)"
70: B1 Line exceeds max length (93>80): "kobject_put (lib/kobject.c:683 lib/kobject.c:714 ./include/linux/kref.h:65 lib/kobject.c:731)"
[RFC,4/5] Bluetooth: ISO: fix use-after-free in __iso_sock_close

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (83>80): "BUG: KASAN: slab-use-after-free in iso_conn_del (net/bluetooth/iso.c:211) bluetooth"
23: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
29: B1 Line exceeds max length (107>80): "? __virt_addr_valid (./include/linux/mmzone.h:1901 ./include/linux/mmzone.h:1997 arch/x86/mm/physaddr.c:65)"
34: B1 Line exceeds max length (101>80): "hci_conn_hash_flush (./include/net/bluetooth/hci_core.h:1872 net/bluetooth/hci_conn.c:2576) bluetooth"
37: B1 Line exceeds max length (92>80): "hci_set_powered_sync (net/bluetooth/hci_sync.c:5433 net/bluetooth/hci_sync.c:5441) bluetooth"
57: B1 Line exceeds max length (108>80): "hci_conn_add (./include/linux/slab.h:559 ./include/linux/slab.h:680 net/bluetooth/hci_conn.c:1002) bluetooth"
70: B1 Line exceeds max length (85>80): "__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)"
73: B1 Line exceeds max length (93>80): "kobject_put (lib/kobject.c:683 lib/kobject.c:714 ./include/linux/kref.h:65 lib/kobject.c:731)"
80: B1 Line exceeds max length (117>80): "exit_to_user_mode_prepare (./include/linux/resume_user_mode.h:49 kernel/entry/common.c:171 kernel/entry/common.c:204)"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 76 (95.0%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Receive - Success                                Failed       0.192 seconds
ISO Receive Timestamped - Success                    Failed       0.181 seconds
ISO Defer Receive - Success                          Failed       0.183 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.181 seconds


---
Regards,
Linux Bluetooth


--===============7015025390081051227==--
