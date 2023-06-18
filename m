Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5212EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jun 2023 22:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjFRWcL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jun 2023 18:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRWcL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jun 2023 18:32:11 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93ADC6
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jun 2023 15:32:08 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7625746ff9cso43002185a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jun 2023 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687127528; x=1689719528;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sKXYE6w2LH4gEzv3CjTM9JftnOLQ/VcQtuK3cBv3AEk=;
        b=VBxmLpDO/K329kr8MgMOjp1fbflkYVHkXsXtZAEULwLuZ+ohBm1KCpcd+NTgeeSWKt
         chxcP4oKt+enjbfZjsfqeKionGoAsT08ZErGDk+up0iDhx0kGKxNSxtEDklumXyY0v+L
         ZqeUXzmuICH4vWvRADTzz88Ab8gl1Cb+kOEszByMJOWe++ruUKh4fXTmEyB+WN2N0cny
         rNsg2SYWSwtfkutuug1kiX1+JytVXf79CuP/pRlxUE1/U99NQwIlT8K2fBbtEGHB8prb
         whrLtBz8gLQu7htISXfYhQplbItP+aM5ehpUnIHvpvrLlT5PNP2v9yAw3eBUPCg5qK+m
         fOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687127528; x=1689719528;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKXYE6w2LH4gEzv3CjTM9JftnOLQ/VcQtuK3cBv3AEk=;
        b=fb0o8/FFIYeYudmjfVXrdD+gBe/ABiBh2ixj/YZfdhyPJ6z+jle9jslcXJUFZf30YH
         ifEvFj0hXm/Kztg19rAflJTNqAgwvN139L8cGeSSj49j+w889moMkQIqHuhwd6IBsFWZ
         qXgILL0aLIfHlOVRuWbY14Kliq7EHIEWQN4FQTYCywNANTll2npJPmlDPyXzkM0lOy15
         /C/qydk/hM2ydHA5BltH4thjqb9KDTvjBRctaJchYHqwzkc7XPN4PK4KhpY8aBlfQi0Y
         qTFgS2PyISQ0qumc0s30oKHcmnrqrfOEph7+riPwb0eSNNgG8BbtCEcwrQwO11nUdyZ3
         6Dng==
X-Gm-Message-State: AC+VfDyU5qJ9i86IKXHIql2umAsSEZQWuYpefs08e3AOMaOlE0y1ovoA
        sSogFH5Pt9TBYKhwshVT8RWU53HLPr4=
X-Google-Smtp-Source: ACHHUZ6pL5NyItpSPAfy5IkU2wgO1+cuwy4AOmZ+BrKeag3PK9gRNpZFqeDU3VUx7L9gss0TxZT9aA==
X-Received: by 2002:a05:6214:29ef:b0:623:66ee:79b2 with SMTP id jv15-20020a05621429ef00b0062366ee79b2mr9207881qvb.36.1687127527678;
        Sun, 18 Jun 2023 15:32:07 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.153])
        by smtp.gmail.com with ESMTPSA id a20-20020a0ca994000000b0062de1ed9d15sm7921742qvb.102.2023.06.18.15.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 15:32:07 -0700 (PDT)
Message-ID: <648f85e7.0c0a0220.70472.9db7@mx.google.com>
Date:   Sun, 18 Jun 2023 15:32:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5291499079861197265=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO-related concurrency fixes
In-Reply-To: <e088225b45037089deffabb013ce8ffbcc0ef9c9.1687115142.git.pav@iki.fi>
References: <e088225b45037089deffabb013ce8ffbcc0ef9c9.1687115142.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5291499079861197265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758199

---Test result---

Test Summary:
CheckPatch                    FAIL      3.82 seconds
GitLint                       FAIL      1.35 seconds
SubjectPrefix                 PASS      0.43 seconds
BuildKernel                   PASS      32.47 seconds
CheckAllWarning               PASS      35.94 seconds
CheckSparse                   WARNING   40.85 seconds
CheckSmatch                   WARNING   110.76 seconds
BuildKernel32                 PASS      31.56 seconds
TestRunnerSetup               PASS      448.68 seconds
TestRunner_l2cap-tester       PASS      17.64 seconds
TestRunner_iso-tester         PASS      24.63 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        PASS      134.92 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         PASS      8.68 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        PASS      7.41 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PASS      41.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/3] Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#104: 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014

total: 0 errors, 1 warnings, 0 checks, 439 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13283914.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/3] Bluetooth: hci_event: call disconnect callback before deleting conn
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#130: 
CPU: 0 PID: 1175 Comm: bluetoothd Tainted: G            E      6.4.0-rc4+ #2

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13283911.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,3/3] Bluetooth: ISO: fix iso_conn related locking and validity issues
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#120: 
iso_connect_cfm:1700: hcon 000000007b65d182 bdaddr 28:3d:c2:4a:7e:da status 12

total: 0 errors, 1 warnings, 0 checks, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13283913.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/3] Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
25: B1 Line exceeds max length (155>80): "BUG: KASAN: slab-use-after-free in hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)"
28: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
34: B1 Line exceeds max length (107>80): "? __virt_addr_valid (./include/linux/mmzone.h:1915 ./include/linux/mmzone.h:2011 arch/x86/mm/physaddr.c:65)"
35: B1 Line exceeds max length (122>80): "? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)"
37: B1 Line exceeds max length (122>80): "? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)"
38: B1 Line exceeds max length (120>80): "hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)"
57: B1 Line exceeds max length (105>80): "hci_conn_params_add (./include/linux/slab.h:580 ./include/linux/slab.h:720 net/bluetooth/hci_core.c:2277)"
58: B1 Line exceeds max length (81>80): "hci_connect_le_scan (net/bluetooth/hci_conn.c:1419 net/bluetooth/hci_conn.c:1589)"
71: B1 Line exceeds max length (85>80): "__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)"
89: B2 Line has trailing whitespace: "    "
[v3,2/3] Bluetooth: hci_event: call disconnect callback before deleting conn

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
36: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
54: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
94: B1 Line exceeds max length (199>80): "Code: 15 d1 1f 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 9d a7 0d 00 00 74 13 b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89"
[v3,3/3] Bluetooth: ISO: fix iso_conn related locking and validity issues

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
68: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
90: B1 Line exceeds max length (106>80): "general protection fault, probably for non-canonical address 0x30b29c630930aec8: 0000 [#1] PREEMPT SMP PTI"
92: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
94: B1 Line exceeds max length (134>80): "Code: 90 90 0f 1f 44 00 00 48 8b 47 08 48 85 c0 0f 84 ad 00 00 00 55 89 d5 53 48 83 3f 00 48 89 fb 74 7d 66 90 48 8b 03 48 8b 53 08 <>"
134: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
144: B2 Line has trailing whitespace: "    "
149: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============5291499079861197265==--
