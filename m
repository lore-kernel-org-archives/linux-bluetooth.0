Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48840C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Apr 2022 13:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347091AbiDLNig (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352478AbiDLNif (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Apr 2022 09:38:35 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236D2D1D9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Apr 2022 06:36:16 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id hu11so16119244qvb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Apr 2022 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zc6QypAEMxowhau5kaBAsI5duvfPh/wtw6yCZBn10go=;
        b=hvK6Y255iFFbdgzBisq63MxAyz6k+Y4g+ZkrJX5nRNaZ5+MtzhPbQZZ0vu0wiALhX1
         I5tnR0+VTxRmQks1wJXYjJKdTP3itsBpnikv9JRD0ddUl8TPiqhxQJgQgxsDZosstPJH
         UvlNsSgWeA2S2SbLZZ1B0aTDc73lqjYNW3358v+d/rMT/PD0qVgm8rbza1XyT6VEXjOT
         L56G66JiDpHlvp97LAPii1NifkT3r1xS54zY2wihFsPKAKnlCD0FuinXAqgAARjRrtI3
         j9+RI0O/mx0CaA3EmLhIeNuQXQZm1E7Us9yXZgCE8QXBkkJRbnDJRIlRSn6SiWqqGnzi
         4Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zc6QypAEMxowhau5kaBAsI5duvfPh/wtw6yCZBn10go=;
        b=YWYSW00HwGtlmYKjA2D/dDufUvaz3HdM7RGAwqVT49L4tS/c6DEzd++WGqd0M/zTki
         0dK+KthJl96APgqCSYmXSeTOywI/rUcNkeAwNjj0PQmpNHjgL1/rEpRliWR3zwrIiCg9
         yKNnwjFOWctdPbDhAOC9u5lmgDdiT/hBHzzkFkPQQWwxBnGRBii/hyN/msmM6XDa7dXg
         lxirrDg58BppA3tfJp3VW6BE071LRkW6huSbtjQiq7qTrDG8HiDttGbS/ePYJSdchBOx
         SsqJL8DLVqAM3UrZTU6sZskOcPJ3TFrmuP9DhdxU7Yj7A/xvPPHhVZ0qHRogIYbLpTEq
         kufg==
X-Gm-Message-State: AOAM530psIl6/1K+QXWLSVDDSACWPWkNV4wsCXKRvS0HieEvlGE6Mb2q
        2/LOHgXlJaNsxnffX6nc6DNQcfuKwAOdMA==
X-Google-Smtp-Source: ABdhPJz1m+VSS8/GdXsbGJXqroIi0x+stmrOmUNiQJR1bC9hi0OOZZUcNvVpQRYMx8YJe+oDuNQhKQ==
X-Received: by 2002:a05:6214:d41:b0:442:19b7:62e6 with SMTP id 1-20020a0562140d4100b0044219b762e6mr3605457qvr.17.1649770575840;
        Tue, 12 Apr 2022 06:36:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.112.110])
        by smtp.gmail.com with ESMTPSA id f3-20020ac87f03000000b002ed137e0510sm7369731qtk.77.2022.04.12.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:36:15 -0700 (PDT)
Message-ID: <6255804f.1c69fb81.50dda.e99b@mx.google.com>
Date:   Tue, 12 Apr 2022 06:36:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6352712201273326612=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vvavrychuk@gmail.com
Subject: RE: [RFC] Bluetooth: core: Allow bind HCI socket user channel when HCI is UP.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220412120945.28862-1-vasyl.vavrychuk@opensynergy.com>
References: <20220412120945.28862-1-vasyl.vavrychuk@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6352712201273326612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=631489

---Test result---

Test Summary:
CheckPatch                    FAIL      1.67 seconds
GitLint                       FAIL      1.02 seconds
SubjectPrefix                 PASS      0.82 seconds
BuildKernel                   PASS      30.11 seconds
BuildKernel32                 PASS      27.80 seconds
Incremental Build with patchesPASS      39.08 seconds
TestRunner: Setup             PASS      471.62 seconds
TestRunner: l2cap-tester      PASS      16.22 seconds
TestRunner: bnep-tester       PASS      6.26 seconds
TestRunner: mgmt-tester       PASS      106.06 seconds
TestRunner: rfcomm-tester     PASS      8.22 seconds
TestRunner: sco-tester        PASS      7.99 seconds
TestRunner: smp-tester        PASS      7.98 seconds
TestRunner: userchan-tester   FAIL      6.66 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.67 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[RFC] Bluetooth: core: Allow bind HCI socket user channel when HCI is UP.\WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email address mismatch: 'From: Vasyl Vavrychuk <vvavrychuk@gmail.com>' != 'Signed-off-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>'

total: 0 errors, 1 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12810739.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 1.02 seconds
Run gitlint with rule in .gitlint
[RFC] Bluetooth: core: Allow bind HCI socket user channel when HCI is UP.
1: T3 Title has trailing punctuation (.): "[RFC] Bluetooth: core: Allow bind HCI socket user channel when HCI is UP."


##############################
Test: TestRunner: userchan-tester - FAIL - 6.66 seconds
Run test-runner with userchan-tester
Total: 4, Passed: 3 (75.0%), Failed: 1, Not Run: 0

Failed Test Cases
User channel open - Failed                           Failed       0.082 seconds



---
Regards,
Linux Bluetooth


--===============6352712201273326612==--
