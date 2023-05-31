Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12FCC77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 09:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjEaJeG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 05:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjEaJeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 05:34:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262A12B
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 02:34:00 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77703f20aa9so135894139f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685525640; x=1688117640;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KCvPDfwhA54XEtvqUyWdIg2ww5J2A+IjfjVie8boqa4=;
        b=lAVB1O7hHZuFusdMfvMidJiapkFTtg2ZJoRwoysY6G+z3qop4yWhqeRHoPzVY5xLOL
         9z/cUjxjI7FT3ncmDI2hFT7oVn1vVUctZaWUp6goCqAY5ooWtxnFJC8b75fe+GM3U+EP
         AR8LpQbngRvG8OIJD4nxRa7YsvnqT+hKBMEB69LyBWl3Dp8tKFwaWBIYCGU4KrCDjHbe
         fnNL8Sb+x/KPO52r/TmY9vSvMQnc6dfTjEt+oyTmwOJp1FdzGtyuwHfmhQ4R2S1Zthih
         jAraUKqckuxHYKG2AZB5WNKNqCvaBs1C0rqrAZArQ8t0K46R8helhId81e8VG7z6gHZi
         qclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685525640; x=1688117640;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCvPDfwhA54XEtvqUyWdIg2ww5J2A+IjfjVie8boqa4=;
        b=Y7DZ3uaJx+T/VSElQ2/KwHs2szHyfr58ML9BzUB/M6aJw+h3ZPRiYSqQNi4mNytP3x
         mQj4QXOTe4qhzASaM0EE5Yb6eT+JxJB34Rtl0jLx3M7fxM3sgkTDLV+ytomDFIJ4v8ik
         xIWEj2zv1q8gRuGca/pZrLHLH/FCd9xi6b8VEsKUriJAak86NOB/OXUiFKy3TPdaGzXO
         BPHwQN3lVMZPj3xbVtI9Kg/lqNfVfxUpBTA+Gukd4yOHi76E5iccu3XZZNK5CUosE0xJ
         TElN8ApxcaDFAn7VN0IJq9f/zFH5F2PbsUmqsfJ/gUvI/EnKmY+fYGMKG/+c/xvlci3D
         s+tg==
X-Gm-Message-State: AC+VfDxzR6BqzI7OPbM1/c2AZQcwDasHhKc1UO5i0qXEHHaYt1sHiuWw
        I9d91wL9Ex+3hHsHCwt2fsNGFalwaGI=
X-Google-Smtp-Source: ACHHUZ5f4qPCigG91RxuZvLpGQLW0Qx0nr4Z01qTGE3E6SB4US0gTihozOXafHXyQAnEmNW7f0yprQ==
X-Received: by 2002:a6b:d914:0:b0:769:a826:2818 with SMTP id r20-20020a6bd914000000b00769a8262818mr3970332ioc.16.1685525639812;
        Wed, 31 May 2023 02:33:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.208])
        by smtp.gmail.com with ESMTPSA id c8-20020a6bec08000000b007748d9a6bf2sm3851053ioh.19.2023.05.31.02.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:33:59 -0700 (PDT)
Message-ID: <64771487.6b0a0220.56ba2.5286@mx.google.com>
Date:   Wed, 31 May 2023 02:33:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0351466407953096379=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: fix debugfs registration
In-Reply-To: <20230531085759.2803-2-johan+linaro@kernel.org>
References: <20230531085759.2803-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0351466407953096379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752636

---Test result---

Test Summary:
CheckPatch                    FAIL      1.67 seconds
GitLint                       FAIL      0.82 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      32.16 seconds
CheckAllWarning               PASS      35.70 seconds
CheckSparse                   PASS      40.62 seconds
CheckSmatch                   PASS      110.56 seconds
BuildKernel32                 PASS      31.75 seconds
TestRunnerSetup               PASS      452.79 seconds
TestRunner_l2cap-tester       PASS      17.51 seconds
TestRunner_iso-tester         FAIL      23.43 seconds
TestRunner_bnep-tester        PASS      5.67 seconds
TestRunner_mgmt-tester        PASS      116.32 seconds
TestRunner_rfcomm-tester      PASS      9.11 seconds
TestRunner_sco-tester         PASS      8.39 seconds
TestRunner_ioctl-tester       PASS      9.81 seconds
TestRunner_mesh-tester        PASS      7.18 seconds
TestRunner_smp-tester         PASS      8.32 seconds
TestRunner_userchan-tester    PASS      6.05 seconds
IncrementalBuild              PASS      34.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RESEND,1/2] Bluetooth: fix debugfs registration
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#82: 
	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!

total: 0 errors, 1 warnings, 0 checks, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13261771.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND,1/2] Bluetooth: fix debugfs registration

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B3 Line contains hard tab characters (\t): "	debugfs: File 'features' in directory 'hci0' already present!"
13: B3 Line contains hard tab characters (\t): "	debugfs: File 'manufacturer' in directory 'hci0' already present!"
14: B3 Line contains hard tab characters (\t): "	debugfs: File 'hci_version' in directory 'hci0' already present!"
15: B3 Line contains hard tab characters (\t): "	..."
16: B1 Line exceeds max length (82>80): "	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!"
16: B3 Line contains hard tab characters (\t): "	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!"
[RESEND,2/2] Bluetooth: hci_qca: fix debugfs registration

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	debugfs: Directory 'ibs' with parent 'hci0' already present!"
15: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 4.20"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 75 (93.8%), Failed: 5, Not Run: 0

Failed Test Cases
ISO AC 6(i) - Success                                Failed       0.225 seconds
ISO AC 7(i) - Success                                Failed       0.226 seconds
ISO AC 8(i) - Success                                Failed       0.232 seconds
ISO AC 9(i) - Success                                Failed       0.232 seconds
ISO AC 11(i) - Success                               Failed       0.224 seconds


---
Regards,
Linux Bluetooth


--===============0351466407953096379==--
