Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C57CD6137
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 21:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378713AbjJIVGm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378603AbjJIVGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 17:06:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B72184
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 14:06:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c63164a2b6so44017025ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696885561; x=1697490361; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4V5NmmnNwAVimhojO6cnSra6XCf5DIDHiQ9OTmLs25o=;
        b=hF376ITIAoqFOAt76ErT7AdcLMRqIvgoLusup6Ggma7bUlpRutTpgbvDdeA4zkjFDs
         DsS5jm58Vk2rHtD/dX7v5RcSxF3uFsIbYYK3I8bqCM6UPfpBX/96JMEBCZXqDxtfwRgr
         cDm5nhiVGE2fp/6DwnF/N5foaHKS6Vg2My+cqNN2c1q7oXaIL/pnb3eQi3oEypNFyYpA
         pwUkAU0n1l5jYKQ0tjEKspHdwsdcJRqvGY0y2d+ob+qBQDfWAyc4KiX4vwJgc0IS/uy0
         8R9wVP7JvVnH4RLGKKPpf7SM64byEiusJ5b6GA/14DbQ80vzS+2/Va4/gwMFWNYziG0I
         636Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885561; x=1697490361;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4V5NmmnNwAVimhojO6cnSra6XCf5DIDHiQ9OTmLs25o=;
        b=mQV7O7MqVvnAYjPib8OREvcH43J+Fpbm8xO+V+1gQ2Ida/XMuX6XgKJNuCiXcO2yRw
         NEZtey95QLGONVD6AUmxCRqwxrQA+/G1Qvx2rfhVN7FT75QuWtiyie5VgwY4/9DkuA4O
         wSRuZHkV8L296LDG1lB0MS6ebvUNVF4flwAKdT6B+zFEw/nefyMdX+eCgyQBPPjJjGo6
         HOOnJ2F+z2X34aXrkwOg7/LpDRMwOUJYfu+WQq00oh11JMZQ31rVYI2kGqE3VbZ6CTVa
         wNCClyYgXW4BF40MnUjRYchvaPdudrxh2AxUBDt/rgHhZTk99jRW3wkhN0pejy6NgBAR
         KOkQ==
X-Gm-Message-State: AOJu0YyqJs1Q4+z93IPeJhGGEwy5uNYhTpshUOrC/qEVDc1Hpi0LffCK
        3U8B9U+c6vXiJ/ywlb/vRsYqNT4TjIM=
X-Google-Smtp-Source: AGHT+IEoV9XT4WEhPbqEas1yI95QKfZKKk+pNWEHzb8oiZzrajk4bFODaHC+ptaS5oZfJTU2p7s/mw==
X-Received: by 2002:a17:902:7fc6:b0:1c9:b258:5092 with SMTP id t6-20020a1709027fc600b001c9b2585092mr57314plb.32.1696885560551;
        Mon, 09 Oct 2023 14:06:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.36.82])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902a5cc00b001c6187f2875sm9999867plq.225.2023.10.09.14.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:06:00 -0700 (PDT)
Message-ID: <65246b38.170a0220.fc8c6.9fbd@mx.google.com>
Date:   Mon, 09 Oct 2023 14:06:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4477596342238984220=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: [v2] Bluetooth: avoid memcmp() out of bounds warning
In-Reply-To: <20231009203137.3125516-1-arnd@kernel.org>
References: <20231009203137.3125516-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4477596342238984220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791522

---Test result---

Test Summary:
CheckPatch                    FAIL      1.02 seconds
GitLint                       FAIL      0.61 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      41.00 seconds
CheckAllWarning               PASS      45.04 seconds
CheckSparse                   WARNING   51.19 seconds
CheckSmatch                   WARNING   136.82 seconds
BuildKernel32                 PASS      39.85 seconds
TestRunnerSetup               PASS      607.10 seconds
TestRunner_l2cap-tester       PASS      35.76 seconds
TestRunner_iso-tester         FAIL      82.33 seconds
TestRunner_bnep-tester        PASS      12.70 seconds
TestRunner_mgmt-tester        FAIL      253.22 seconds
TestRunner_rfcomm-tester      PASS      19.38 seconds
TestRunner_sco-tester         PASS      22.86 seconds
TestRunner_ioctl-tester       PASS      22.32 seconds
TestRunner_mesh-tester        PASS      16.06 seconds
TestRunner_smp-tester         PASS      16.98 seconds
TestRunner_userchan-tester    PASS      13.48 seconds
IncrementalBuild              PASS      37.88 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: avoid memcmp() out of bounds warning
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#68: 
    inlined from 'hci_conn_request_evt' at net/bluetooth/hci_event.c:3276:7:

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: Reject connection with the device which has same BD_ADDR")'
#78: 
Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device which has same BD_ADDR")

total: 0 errors, 2 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13414405.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3228.
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: avoid memcmp() out of bounds warning

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (125>80): "include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]"
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
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 99, Passed: 98 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       6.548 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.663 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.527 seconds


---
Regards,
Linux Bluetooth


--===============4477596342238984220==--
