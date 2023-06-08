Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD58DC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 21:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjFHVde (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 17:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjFHVdc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 17:33:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5396D2D63
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 14:33:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-62b3b505961so7540146d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jun 2023 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686260010; x=1688852010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mSymAviVN51EHRalK/RvxOWwYQuzyYLOr+FYkZRHDTE=;
        b=XfUldFUlxdZ6NXv/yJLreNzk+78rLYA7X7/swxY0txBx69IpmaT6CHDCRBydgO8Fba
         TOQJEtDOaqvsE/HcvC7omU2MTZuwp0NSMD01oqUJp9J49C6vGAUqZ6DEliOu2uPoLjpt
         vt5zSzFpAqExY9qsSQZyDE3B+XROjeTqeY7wz4Oi5yqad5rKkfnvU1RScgqS3v7hpE8u
         yXVPX2ai2ZsOyLLb208Wi9ldPM1ln1Om1c0HVGh0dGYSfDHA3sxiVIf1gsT8Xswz7T2m
         BNYSMYtibgkHIpnWDY+M+iI/8Dv8yzr8cwDF42GS1q3mtOX7Bcjai4s56keAMrLYyIc/
         wrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686260010; x=1688852010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSymAviVN51EHRalK/RvxOWwYQuzyYLOr+FYkZRHDTE=;
        b=FFL7uwXXicvRawrpxq5c5VIhRDLWbzq6XenZ5XYP/QZPntjj84mT8Prw/t2JUN3LaG
         SKpVFQp6+94rC+Wh1V50uZIpZsW9BpCwuv2d+fZePLfPzny6EGBwbf7aeIndA8iAajvl
         cR10gIi+GbE+2bPYUMbkyAO1liC4yWd143MVEfjnhuE/xRROe0A8HBUuVTT3VMB0zSqg
         bS5zGHrPmatCRVp9ALet69HJ8S5TZFWr2udlhIS9NuYVLWgkY7O3aqf5lqUVYwu7v2Nf
         NL7IErC9RM/LgXaEfOFrglhX1KB2ViqT0BQ05ZngNb1uGIBxDwy6UwQjYmDcO/XOYkXb
         ofqQ==
X-Gm-Message-State: AC+VfDw04iMde1z9Kq+SieSdeCI1XNJBsPXbfz7Gkz1PTe/9RXuoUdPC
        wz+nu6r5CKo7uGfPY+JRMsM9ZHhS8hk=
X-Google-Smtp-Source: ACHHUZ6drYqHLjamyJQnPAbq5OoDJdI91Q/te7DyLfuVQOtVzUh9ia4Z3PoU15ArMrCKrTfOeHOP6A==
X-Received: by 2002:a05:6214:f02:b0:623:64cd:941d with SMTP id gw2-20020a0562140f0200b0062364cd941dmr3059108qvb.2.1686260010153;
        Thu, 08 Jun 2023 14:33:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.255.0])
        by smtp.gmail.com with ESMTPSA id h17-20020a0cf451000000b006260c683bf2sm692900qvm.53.2023.06.08.14.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 14:33:29 -0700 (PDT)
Message-ID: <64824929.0c0a0220.3a9ab.41d3@mx.google.com>
Date:   Thu, 08 Jun 2023 14:33:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8294321296578135655=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO-related concurrency fixes
In-Reply-To: <b723c232c6fd1f90e49b147180420d1856fb907d.1686252492.git.pav@iki.fi>
References: <b723c232c6fd1f90e49b147180420d1856fb907d.1686252492.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8294321296578135655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=755455

---Test result---

Test Summary:
CheckPatch                    FAIL      2.84 seconds
GitLint                       FAIL      1.32 seconds
SubjectPrefix                 PASS      0.41 seconds
BuildKernel                   PASS      32.59 seconds
CheckAllWarning               PASS      35.36 seconds
CheckSparse                   WARNING   40.70 seconds
CheckSmatch                   WARNING   110.07 seconds
BuildKernel32                 PASS      32.20 seconds
TestRunnerSetup               PASS      448.29 seconds
TestRunner_l2cap-tester       PASS      16.94 seconds
TestRunner_iso-tester         PASS      23.46 seconds
TestRunner_bnep-tester        PASS      5.73 seconds
TestRunner_mgmt-tester        PASS      117.30 seconds
TestRunner_rfcomm-tester      PASS      9.10 seconds
TestRunner_sco-tester         PASS      8.48 seconds
TestRunner_ioctl-tester       PASS      9.91 seconds
TestRunner_mesh-tester        PASS      7.27 seconds
TestRunner_smp-tester         PASS      8.35 seconds
TestRunner_userchan-tester    PASS      6.00 seconds
IncrementalBuild              PASS      41.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/3] Bluetooth: hci_sync: iterate over hci_conn_params safely
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#104: 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014

total: 0 errors, 1 warnings, 0 checks, 165 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13272928.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[3/3] Bluetooth: ISO: fix iso_conn related locking and validity issues
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#120: 
iso_connect_cfm:1700: hcon 000000007b65d182 bdaddr 28:3d:c2:4a:7e:da status 12

total: 0 errors, 1 warnings, 0 checks, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13272927.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/3] Bluetooth: hci_sync: iterate over hci_conn_params safely

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
26: B1 Line exceeds max length (155>80): "BUG: KASAN: slab-use-after-free in hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)"
29: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
35: B1 Line exceeds max length (107>80): "? __virt_addr_valid (./include/linux/mmzone.h:1915 ./include/linux/mmzone.h:2011 arch/x86/mm/physaddr.c:65)"
36: B1 Line exceeds max length (122>80): "? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)"
38: B1 Line exceeds max length (122>80): "? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)"
39: B1 Line exceeds max length (120>80): "hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)"
58: B1 Line exceeds max length (105>80): "hci_conn_params_add (./include/linux/slab.h:580 ./include/linux/slab.h:720 net/bluetooth/hci_core.c:2277)"
59: B1 Line exceeds max length (81>80): "hci_connect_le_scan (net/bluetooth/hci_conn.c:1419 net/bluetooth/hci_conn.c:1589)"
72: B1 Line exceeds max length (85>80): "__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)"
[2/3] Bluetooth: hci_event: call ISO disconnect callback before deleting conn

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
40: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
[3/3] Bluetooth: ISO: fix iso_conn related locking and validity issues

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
68: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
90: B1 Line exceeds max length (106>80): "general protection fault, probably for non-canonical address 0x30b29c630930aec8: 0000 [#1] PREEMPT SMP PTI"
92: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
94: B1 Line exceeds max length (134>80): "Code: 90 90 0f 1f 44 00 00 48 8b 47 08 48 85 c0 0f 84 ad 00 00 00 55 89 d5 53 48 83 3f 00 48 89 fb 74 7d 66 90 48 8b 03 48 8b 53 08 <>"
134: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
146: B2 Line has trailing whitespace: "    "
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


--===============8294321296578135655==--
