Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED3C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 02:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCUCYd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 22:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCUCYa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 22:24:30 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FCA38B51
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 19:24:24 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17997ccf711so15042656fac.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 19:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679365463;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YCv0qGYNUWTsjW07s+rwarUoRrHbdJOKYXfR1l6jwv0=;
        b=fhBof1aO/QSfGF3ByBVBGWLZISGOH0XOkNzFH086szDfpvIVz8mfzxWmj4o0cbTnzh
         6hPvUWuVUVeI2xPJXmw023nBtHw/NFDaxAXHbI17HLwrDhqx1anLo/dVkdTbG7oYDk0R
         N3sQLtuPNa+C/kvatGySGA/NzAQRHJideQlMlFq48ju/knLiMw4PjxC7vuPpeo8S3Q15
         FBcn4gIpiMh3p4T7DPOz8cYC+Iri076/YiV8islfFrZ0NGc2zpM8ZUJ0D0ihiq+vM89l
         4YQuuxErgF4NjkJteAzGXxz+joSMDWmhPfvZWgV3LJtQ4BfPLsU9D39HzOIv2EtwXFYY
         dNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679365463;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCv0qGYNUWTsjW07s+rwarUoRrHbdJOKYXfR1l6jwv0=;
        b=GqatvaljEO1MwltVqvIegWbew6QBI7KPJTDtmrXC0lhCB/j5bF/3n5ZlWL+gbMzpCH
         JNJSjIGxa8NJxj/Es5//Rm5jXkSaxVsDqK/aO7XQzWVU9qiSJPkLXriE+1WJYSO3X48Y
         +tCr838Y52wXh3Km8iruERfRDz/mWQBCdTVqRwwPAkrsEqNdJWOQWNo0a00kX577jyN7
         e1SzEIypOTFDhsKu2eHhb6ICpAk68sOjzQYXebp39gRb/n29C1rGRZWRWvOTCz5vTmRK
         BAFP0HGZ35ZC1GqPshYKF/8g2VvjjI2xh4xvX2M6WkCnhUkUSAV2q/KGwtGvLQiu+XXg
         in8g==
X-Gm-Message-State: AO0yUKXrXPFEqUs/Yqc8b0fJaOjhXBIR7x+w/n/NerjjshtUPaivMO7Y
        FHqWp+tH16rMsnD4lGeVnwpflW4JXxI=
X-Google-Smtp-Source: AK7set8QntbE6t7C8VkpipaqMtBvDkjshIw+dvg/dxlO7kLrrqSnRal69aVAjK2VF1ZyCCuVoSXlTg==
X-Received: by 2002:a05:6871:70a:b0:178:9bb0:4c8e with SMTP id f10-20020a056871070a00b001789bb04c8emr290240oap.48.1679365463491;
        Mon, 20 Mar 2023 19:24:23 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.246.130])
        by smtp.gmail.com with ESMTPSA id ya9-20020a0568714cc900b001723a2e84b6sm3853715oab.6.2023.03.20.19.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 19:24:23 -0700 (PDT)
Message-ID: <64191557.050a0220.bb25d.18c7@mx.google.com>
Date:   Mon, 20 Mar 2023 19:24:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7506548738622238753=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: HCI: Fix global-out-of-bounds
In-Reply-To: <20230321015018.1759683-1-iam@sung-woo.kim>
References: <20230321015018.1759683-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7506548738622238753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732139

---Test result---

Test Summary:
CheckPatch                    FAIL      0.92 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.54 seconds
CheckAllWarning               PASS      36.63 seconds
CheckSparse                   PASS      41.32 seconds
CheckSmatch                   PASS      109.88 seconds
BuildKernel32                 PASS      30.92 seconds
TestRunnerSetup               PASS      442.73 seconds
TestRunner_l2cap-tester       PASS      16.53 seconds
TestRunner_iso-tester         PASS      16.56 seconds
TestRunner_bnep-tester        PASS      5.37 seconds
TestRunner_mgmt-tester        PASS      107.29 seconds
TestRunner_rfcomm-tester      PASS      8.55 seconds
TestRunner_sco-tester         PASS      7.84 seconds
TestRunner_ioctl-tester       PASS      9.22 seconds
TestRunner_mesh-tester        PASS      6.72 seconds
TestRunner_smp-tester         PASS      7.80 seconds
TestRunner_userchan-tester    PASS      5.60 seconds
IncrementalBuild              PASS      28.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: HCI: Fix global-out-of-bounds
WARNING: use relative pathname instead of absolute in changelog text
#85: 
BUG: KASAN: global-out-of-bounds in hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#85: 
BUG: KASAN: global-out-of-bounds in hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#85: 
BUG: KASAN: global-out-of-bounds in hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#94: 
? hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#94: 
? hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#94: 
? hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#96: 
? hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#96: 
? hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#96: 
? hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#97: 
hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#97: 
hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#97: 
hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)

WARNING: use relative pathname instead of absolute in changelog text
#99: 
? mutex_lock (/v6.2-bzimage/./arch/x86/include/asm/atomic64_64.h:190 /v6.2-bzimage/./include/linux/atomic/atomic-long.h:443 /v6.2-bzimage/./include/linux/atomic/atomic-instrumented.h:1781 /v6.2-bzimage/kernel/locking/mutex.c:171 /v6.2-bzimage/kernel/locking/mutex.c:285)

WARNING: use relative pathname instead of absolute in changelog text
#99: 
? mutex_lock (/v6.2-bzimage/./arch/x86/include/asm/atomic64_64.h:190 /v6.2-bzimage/./include/linux/atomic/atomic-long.h:443 /v6.2-bzimage/./include/linux/atomic/atomic-instrumented.h:1781 /v6.2-bzimage/kernel/locking/mutex.c:171 /v6.2-bzimage/kernel/locking/mutex.c:285)

WARNING: use relative pathname instead of absolute in changelog text
#99: 
? mutex_lock (/v6.2-bzimage/./arch/x86/include/asm/atomic64_64.h:190 /v6.2-bzimage/./include/linux/atomic/atomic-long.h:443 /v6.2-bzimage/./include/linux/atomic/atomic-instrumented.h:1781 /v6.2-bzimage/kernel/locking/mutex.c:171 /v6.2-bzimage/kernel/locking/mutex.c:285)

total: 0 errors, 15 warnings, 0 checks, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13182133.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: HCI: Fix global-out-of-bounds

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (275>80): "BUG: KASAN: global-out-of-bounds in hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)"
21: B1 Line exceeds max length (86>80): "print_report (/v6.2-bzimage/mm/kasan/report.c:307 /v6.2-bzimage/mm/kasan/report.c:417)"
22: B1 Line exceeds max length (241>80): "? hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)"
23: B1 Line exceeds max length (86>80): "kasan_report (/v6.2-bzimage/mm/kasan/report.c:184 /v6.2-bzimage/mm/kasan/report.c:519)"
24: B1 Line exceeds max length (241>80): "? hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)"
25: B1 Line exceeds max length (239>80): "hci_dev_open_sync (/v6.2-bzimage/net/bluetooth/hci_sync.c:3154 /v6.2-bzimage/net/bluetooth/hci_sync.c:3343 /v6.2-bzimage/net/bluetooth/hci_sync.c:4418 /v6.2-bzimage/net/bluetooth/hci_sync.c:4609 /v6.2-bzimage/net/bluetooth/hci_sync.c:4689)"
27: B1 Line exceeds max length (270>80): "? mutex_lock (/v6.2-bzimage/./arch/x86/include/asm/atomic64_64.h:190 /v6.2-bzimage/./include/linux/atomic/atomic-long.h:443 /v6.2-bzimage/./include/linux/atomic/atomic-instrumented.h:1781 /v6.2-bzimage/kernel/locking/mutex.c:171 /v6.2-bzimage/kernel/locking/mutex.c:285)"
29: B1 Line exceeds max length (100>80): "hci_power_on (/v6.2-bzimage/net/bluetooth/hci_core.c:485 /v6.2-bzimage/net/bluetooth/hci_core.c:984)"
32: B1 Line exceeds max length (99>80): "? strscpy (/v6.2-bzimage/./arch/x86/include/asm/word-at-a-time.h:62 /v6.2-bzimage/lib/string.c:161)"
34: B1 Line exceeds max length (94>80): "worker_thread (/v6.2-bzimage/./include/linux/list.h:292 /v6.2-bzimage/kernel/workqueue.c:2437)"


---
Regards,
Linux Bluetooth


--===============7506548738622238753==--
