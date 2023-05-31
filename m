Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9102CC77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 06:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjEaGg7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 02:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjEaGg6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 02:36:58 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41D799
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 23:36:56 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19f268b1d83so3653312fac.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 23:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685515016; x=1688107016;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2BSsDF0YQHG9OMUOasLIJolVF8Fu9N3rt65FTcAEJJk=;
        b=DiXsOih2TOO7fWVHBYXIXZp77nhvd2mJbmVGELgfDi80REZZaH/e/+YAqeePps08RE
         FCkXcr6yKFHBuQZbDCWqkYiBj4VcihY2No0lZEY0IHPC2fXpdHT4ihYWJBxlo9qUpbEE
         QNsEOwl1Txol07OCZLmIRF3wvYs4lEMcFGBqS9kDRoGMlYqLMpVlL7RpTGG8KZ6uHu5u
         twHSilOCbf6dnfBkzCnj0Rewhe2RkAhGhpAXy8iL3CYTxB3NjjdQkXcSZSGzJ5qNAZt0
         3iFHrin/T36TdiFnz6atNx2nn0z2f/KNXMZWJ4VG5UJc/TbjUzbvtA2lYdjKPd9wno07
         8dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685515016; x=1688107016;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BSsDF0YQHG9OMUOasLIJolVF8Fu9N3rt65FTcAEJJk=;
        b=FCrV6hfoVfInENeZkiETeuV2a+UhwqKdCnmrjmcT7AYK8GPxRhrNRqlV4WbK6nFuOv
         7ZBMJYy/uQJttHhLa1HFcRTXN6tO5HN/m3l2x7KJggGJj1226ihSefptMDjna0Cza5jn
         +skobSsEAroPod7rzVbj+Vb/4JSzSW6gaPPZrC2hbJ8+04llOyrQk0elGY9pQfyOUO+o
         HtzrVWqwGxyDsrS2C988JYBCdyi5ZLJ8PprwDCxL3Qwz121bRUAyvbTD6I0nLTHteY2p
         ffNF8w/BUNzbyKl9wFC2Oj3wt2+U64WAPcl0FtNKllio6GDaTjqNQ8Ncf0aSNdnwWUmL
         SUhw==
X-Gm-Message-State: AC+VfDyklz7zDi7pTdyEeoYhmY7XmVsH4o/rYCYgUQ+PXQlnwlS+NA/D
        ub5ct929O5m3xkYt4fMUAwR8X1Ek/QfkOA==
X-Google-Smtp-Source: ACHHUZ6LjPHLQ/g3M/XuMwxrxrxU0mdzOEgp7CiWb5akPzL/ASCrkY56LHHhzEJ/HgMCRZx06f0IsA==
X-Received: by 2002:a05:6871:a782:b0:19f:8566:c1f2 with SMTP id wj2-20020a056871a78200b0019f8566c1f2mr2395409oab.47.1685515015869;
        Tue, 30 May 2023 23:36:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.168.146])
        by smtp.gmail.com with ESMTPSA id l1-20020a056870e90100b0017f84f81f3csm234501oan.52.2023.05.30.23.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 23:36:55 -0700 (PDT)
Message-ID: <6476eb07.050a0220.8a2ab.0d29@mx.google.com>
Date:   Tue, 30 May 2023 23:36:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7066436301598572540=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [v2] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
In-Reply-To: <20230531053955.2467043-1-iam@sung-woo.kim>
References: <20230531053955.2467043-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7066436301598572540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752554

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.83 seconds
CheckAllWarning               PASS      37.66 seconds
CheckSparse                   PASS      44.32 seconds
CheckSmatch                   PASS      114.17 seconds
BuildKernel32                 PASS      33.46 seconds
TestRunnerSetup               PASS      480.27 seconds
TestRunner_l2cap-tester       PASS      18.30 seconds
TestRunner_iso-tester         FAIL      25.23 seconds
TestRunner_bnep-tester        PASS      5.96 seconds
TestRunner_mgmt-tester        PASS      121.29 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      8.74 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        PASS      7.45 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.27 seconds
IncrementalBuild              PASS      32.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#80: 
CPU: 0 PID: 276 Comm: kworker/u3:0 Not tainted 6.2.0-00001-gef397bd4d5fb-dirty #59

total: 0 errors, 1 warnings, 0 checks, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13261484.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (92>80): "BUG: KASAN: use-after-free in l2cap_sock_ready_cb+0xb7/0x100 net/bluetooth/l2cap_sock.c:1650"
11: B1 Line exceeds max length (82>80): "CPU: 0 PID: 276 Comm: kworker/u3:0 Not tainted 6.2.0-00001-gef397bd4d5fb-dirty #59"
100: B1 Line exceeds max length (106>80): "page:00000000dbca6a80 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888104614000 pfn:0x104614"
101: B1 Line exceeds max length (89>80): "head:00000000dbca6a80 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0"
123: B1 Line exceeds max length (85>80): "- Link to v1: https://lore.kernel.org/lkml/20230526084038.2199788-1-iam@sung-woo.kim/"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 75 (93.8%), Failed: 5, Not Run: 0

Failed Test Cases
ISO AC 6(i) - Success                                Failed       0.242 seconds
ISO AC 7(i) - Success                                Failed       0.249 seconds
ISO AC 8(i) - Success                                Failed       0.243 seconds
ISO AC 9(i) - Success                                Failed       0.246 seconds
ISO AC 11(i) - Success                               Failed       0.250 seconds


---
Regards,
Linux Bluetooth


--===============7066436301598572540==--
