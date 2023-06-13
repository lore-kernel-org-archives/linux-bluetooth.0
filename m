Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1943EB64D0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 18:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbjFMSfn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjFMSfg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 14:35:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D535D19A8
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 11:35:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25bd6f22ff1so1637652a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686681334; x=1689273334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xM0aeRTUgIkQWd33sydKWbvf1vM8PLtBN+OMavWRaW8=;
        b=kr4uHdZIzUxZ+ErcRFI57OUk6G3Ct76gX9XENsDpJ+AIBMvmIEW2tpIWCvg4q+D+XI
         uLcLBoPqa/Dn1zRqryFyGoDDctmNMVC/KwJnrNksdyHlw8UWj9gpoPlnrvsMM54daZBD
         veZYgIGGWHp7E8Z7GSZG4f4xfOENgZs58ms0PxZgVsUjs7vVPqCuzPvi/W29pAt4slz0
         yQHNKPqspuAaYi00MNrog4Vq+47Srfo+N6ZjmhGUtn0IWejRniOBokUwerBX9mS1b4VN
         GAV+4N3LIdxfwdvKvLbhMoDMyxUX9NVqXVtFSXR3KANKr+u7+51M9YeEXkqB9XfZwMqN
         OOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681334; x=1689273334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xM0aeRTUgIkQWd33sydKWbvf1vM8PLtBN+OMavWRaW8=;
        b=hFoz44y6OliT3bnty8zlxCZH6KesH55F/4Z7Fl8ojNSlEqkTmiKVCk/kgqh+oCaLIa
         DFA9SIWVl9bq0FbmDVSQXlkIry2PcHg29FN+Zju1iLeBMfQUcChTxmvMAWNHqXX0b419
         +Y/fmVX7E07uDyqgvMJNFeI5TL023r6rAdDpDmUx3OFq3SgS/QeDVB3Qe0GdfwPYSVs1
         Mu2gtPil0xpf8Au7Ls28mTYgeoJkVLxVXiUrAbxZ2ogPsDqsuAUtoLq+85foNyPkSa4U
         PO0KVNAPP83DMOJkW8JgpJrNnwEhXL0R8CO9bN8ItBRRZlJ7WyGYPR4mcg/Mu1qZkTwC
         jnhw==
X-Gm-Message-State: AC+VfDw4Ly6RH5a/8foX+HMLRmiVu+AX5dRAkSZWpLspSlaKgJi+59wT
        aSCJuZ2NfN0Q+6PozmJeIrLcFV6XV2A=
X-Google-Smtp-Source: ACHHUZ6+QVSmo6jKp6lv04YzazmCuvE2Bo/CXSfI9O1BkInhSKE2C+Oiom6U2VY7HzvUkOZoTyxFSg==
X-Received: by 2002:a17:90a:359:b0:25b:be4a:84c9 with SMTP id 25-20020a17090a035900b0025bbe4a84c9mr8125448pjf.17.1686681334040;
        Tue, 13 Jun 2023 11:35:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.19.48])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090a2a0200b0025c288ada9fsm800864pjd.13.2023.06.13.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 11:35:33 -0700 (PDT)
Message-ID: <6488b6f5.170a0220.c4d39.21a8@mx.google.com>
Date:   Tue, 13 Jun 2023 11:35:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1800570878050078923=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO-related concurrency fixes
In-Reply-To: <d579997e06d68153a5630aba1ee9f2854d8b0cb4.1686589290.git.pav@iki.fi>
References: <d579997e06d68153a5630aba1ee9f2854d8b0cb4.1686589290.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1800570878050078923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=756835

---Test result---

Test Summary:
CheckPatch                    FAIL      3.28 seconds
GitLint                       FAIL      1.12 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      31.85 seconds
CheckAllWarning               PASS      35.68 seconds
CheckSparse                   WARNING   40.01 seconds
CheckSmatch                   WARNING   111.60 seconds
BuildKernel32                 PASS      30.98 seconds
TestRunnerSetup               PASS      445.96 seconds
TestRunner_l2cap-tester       PASS      16.59 seconds
TestRunner_iso-tester         PASS      23.20 seconds
TestRunner_bnep-tester        PASS      5.37 seconds
TestRunner_mgmt-tester        PASS      128.17 seconds
TestRunner_rfcomm-tester      PASS      8.67 seconds
TestRunner_sco-tester         PASS      8.00 seconds
TestRunner_ioctl-tester       PASS      9.18 seconds
TestRunner_mesh-tester        PASS      6.73 seconds
TestRunner_smp-tester         PASS      7.85 seconds
TestRunner_userchan-tester    PASS      5.63 seconds
IncrementalBuild              PASS      40.87 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/3] Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#105: 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014

total: 0 errors, 1 warnings, 0 checks, 405 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13279139.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/3] Bluetooth: hci_event: call disconnect callback before deleting conn
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#129: 
CPU: 0 PID: 1175 Comm: bluetoothd Tainted: G            E      6.4.0-rc4+ #2

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13279137.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,3/3] Bluetooth: ISO: fix iso_conn related locking and validity issues
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#120: 
iso_connect_cfm:1700: hcon 000000007b65d182 bdaddr 28:3d:c2:4a:7e:da status 12

total: 0 errors, 1 warnings, 0 checks, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13279138.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync

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
[v2,2/3] Bluetooth: hci_event: call disconnect callback before deleting conn

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
36: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
54: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
94: B1 Line exceeds max length (199>80): "Code: 15 d1 1f 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 9d a7 0d 00 00 74 13 b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89"
[v2,3/3] Bluetooth: ISO: fix iso_conn related locking and validity issues

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
68: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
90: B1 Line exceeds max length (106>80): "general protection fault, probably for non-canonical address 0x30b29c630930aec8: 0000 [#1] PREEMPT SMP PTI"
92: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
94: B1 Line exceeds max length (134>80): "Code: 90 90 0f 1f 44 00 00 48 8b 47 08 48 85 c0 0f 84 ad 00 00 00 55 89 d5 53 48 83 3f 00 48 89 fb 74 7d 66 90 48 8b 03 48 8b 53 08 <>"
134: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
143: B2 Line has trailing whitespace: "    "
148: B2 Line has trailing whitespace: "    "
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


--===============1800570878050078923==--
