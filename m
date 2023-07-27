Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FE6C0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 02:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjG0CUS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 22:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjG0CUR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 22:20:17 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F332116
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 19:20:15 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76af2cb7404so41144285a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690424414; x=1691029214;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MJhrLCEHxDHaL5+hY/FQnSeePhpqAsCpX/rWta6jMsA=;
        b=eTyRckrNtafWuogWCzjOQq0LDu06A+KRVoqK1QLe6Vt4DUQ+OwD/wcE4ucdhEwVZNJ
         F/ueCfVx1qIzGTiva4ULq3N/dCYTD2zkVTUCdhU4X6oRMWifdvb/1r9I9AmV+Cgeud7d
         PSW+InoYIDIVbZ1FztJeAUIq75yCi9GLAq6JgD8P3Tqngnt9RGxNPovUpIc5JItrhe2m
         jG+sDgwTzUtqe3TvwfXUVxsergqujqwQNHSZXHKWrr7UL6Mw3/RfrRi0D4PHQxu14tBE
         oWZW1GgQe36uC7dfoHCsyt6JXOfUbMUckFu+NqCvEYjdUYz/S8mX4XtXAReQsB7KB1+6
         FlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690424414; x=1691029214;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJhrLCEHxDHaL5+hY/FQnSeePhpqAsCpX/rWta6jMsA=;
        b=D2sMwhWrxmCkWpocIZns7F6t/eY48T5gcaE9Nc+6TAspNDppsl3FygbT3uwEM73qqp
         ZowhsijR/nOTbuK3j1rsiY2RDkt+Uf81UDQzFKT5B9bxOJRq219zzCYoBG8sqcqiysBR
         DGecBkA825pRittMbS9cK78PVQO9xF414q+kJBGdE2VPbVm6gu4uCJXNN6NyTSybu5NK
         15MKOkjp+4yOy7RWwZgKDJnFXWvyqb+/AW9n2FgXnEYScmEcSnKwB/yj+YUwdX3KIelx
         4GkNCR7XOp8U0+/pcq3T6lj5+q7KYO2FwP2aqYQ/bG2sNoIsDQQvoQz8Xme1irJQETS8
         sDwA==
X-Gm-Message-State: ABy/qLbSh+aLuwMOofIDcQngnC4xu8rarC+/6KRbl+TUFfpF1WOkiOth
        lwR42cJ2F+1X6UjBEVN4Uzg7iVkglGs=
X-Google-Smtp-Source: APBJJlE9gH2xl7t+LzPvjeyjZc/uYUB3PgHjgdtQADTO4jKrqVQ1XgdcmLCRhL6NOsFWNVd+mVub+A==
X-Received: by 2002:a05:620a:485:b0:767:e231:b38f with SMTP id 5-20020a05620a048500b00767e231b38fmr3960911qkr.45.1690424414680;
        Wed, 26 Jul 2023 19:20:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.33.114])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a071300b00767d572d651sm86456qkc.87.2023.07.26.19.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:20:14 -0700 (PDT)
Message-ID: <64c1d45e.050a0220.f52f6.03e8@mx.google.com>
Date:   Wed, 26 Jul 2023 19:20:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2416018762234895779=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yuehaibing@huawei.com
Subject: RE: [v2,-next] Bluetooth: Remove unused declaration amp_read_loc_info()
In-Reply-To: <20230727013907.29068-1-yuehaibing@huawei.com>
References: <20230727013907.29068-1-yuehaibing@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2416018762234895779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769893

---Test result---

Test Summary:
CheckPatch                    FAIL      0.82 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.63 seconds
CheckAllWarning               PASS      35.23 seconds
CheckSparse                   PASS      39.91 seconds
CheckSmatch                   PASS      112.17 seconds
BuildKernel32                 PASS      30.89 seconds
TestRunnerSetup               PASS      469.75 seconds
TestRunner_l2cap-tester       PASS      21.85 seconds
TestRunner_iso-tester         PASS      40.19 seconds
TestRunner_bnep-tester        PASS      9.92 seconds
TestRunner_mgmt-tester        PASS      210.41 seconds
TestRunner_rfcomm-tester      PASS      15.05 seconds
TestRunner_sco-tester         PASS      15.97 seconds
TestRunner_ioctl-tester       PASS      16.89 seconds
TestRunner_mesh-tester        PASS      12.52 seconds
TestRunner_smp-tester         PASS      13.38 seconds
TestRunner_userchan-tester    PASS      10.43 seconds
IncrementalBuild              PASS      29.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,-next] Bluetooth: Remove unused declaration amp_read_loc_info()
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#52: 
This is introduced in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")

total: 0 errors, 1 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13328661.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,-next] Bluetooth: Remove unused declaration amp_read_loc_info()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B1 Line exceeds max length (95>80): "This is introduced in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")"
4: B2 Line has trailing whitespace: "and never be implemented. "


---
Regards,
Linux Bluetooth


--===============2416018762234895779==--
