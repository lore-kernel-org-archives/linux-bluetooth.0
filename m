Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF9FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 18:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiKVShu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiKVShs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 13:37:48 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E492035E
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 10:37:47 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x21so10931151qkj.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sVa2e6LUl6VBxsRBN1WAWrRuYsIqw5+FWeRiWrIEq6g=;
        b=YXeH23fqwSxEOTalYAa0pwGMz85HEEFTUXmJ3VKp0k/HQUYm41s1Id66q57NimKtEZ
         9cbbZ5royigZVVnCCWzj6k5aDYEZVjpwhcALjouI/eYZwvvH5A6HwhdNumTlPjE/3Pvf
         bAB39fX/4opBV/LyJCpNCbuT3YGjFNeC2wYMU4czKjjLHN/+0zdoskZ3KXPkoHaxSDvi
         iYDeAMK43v7/UXc0sC4hA/rgeRsMGUbNMc9R8D4WmePAEpSDcMGn6cCt0zTs9akAV8AP
         3AVpy7UnHz3Fi3nWPXekBTbmO/QT5OVe2WGgAUZVJXj9fG4jFmxA4fahtjn/+UdU2f9C
         /DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVa2e6LUl6VBxsRBN1WAWrRuYsIqw5+FWeRiWrIEq6g=;
        b=eGEeKEaV/RHUhAgpwxDVLsODUKSF1K+q02IPAvC5BUEh+Rf4Rkq8gbTKNQO9U7M5Fo
         4POTK9ZJ3vNNmJUtAiCVDR/5on50QkdyblcrpUNwx8mXXu3tJKaLwU97MlO84b+tG1Kt
         +nO3hHaSK51En9OBBLCNcAZ7OZpNxwxilbjiATI8l+Ep7sSAZlEOpceCcFfVCWzUL12x
         tUjICbdtcxyLPneuZ0SlufZXgCZdeHs8S8/3oCOpZwecjnAAEfxGBMfCKtj90mrjrBH5
         AIatzH//770smm+L1HK5HmykVmuzPoWaOe3VIHLAO+ZMddpsJAKooVhdZJ4wsks7aRwT
         SVEw==
X-Gm-Message-State: ANoB5plYVbm8QXYKLhkBqcu88f/KBkqlBKShnIZ0wG1ZR663/iNTBwF/
        LwvzRfSqJE/ii6bJrlWGz9B5507z2jukCQ==
X-Google-Smtp-Source: AA0mqf5Hv3uO3Bx8yr6+PVWmeVArz4kM5afSOjIrFSsvsGR2GuhO3Sju5UBgCT868kfObIeoQ0kSYA==
X-Received: by 2002:a05:620a:a10:b0:6fb:a7e6:96e with SMTP id i16-20020a05620a0a1000b006fba7e6096emr21340631qka.675.1669142266084;
        Tue, 22 Nov 2022 10:37:46 -0800 (PST)
Received: from [172.17.0.2] ([20.65.114.106])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm10659692qko.126.2022.11.22.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 10:37:45 -0800 (PST)
Message-ID: <637d16f9.050a0220.37710.7a6b@mx.google.com>
Date:   Tue, 22 Nov 2022 10:37:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6160342854867026951=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tglx@linutronix.de
Subject: RE: timers: Provide timer_shutdown[_sync]()
In-Reply-To: <20221122173648.153480304@linutronix.de>
References: <20221122173648.153480304@linutronix.de>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6160342854867026951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=698185

---Test result---

Test Summary:
CheckPatch                    FAIL      14.38 seconds
GitLint                       FAIL      6.00 seconds
SubjectPrefix                 FAIL      2.28 seconds
BuildKernel                   PASS      33.50 seconds
BuildKernel32                 PASS      30.83 seconds
TestRunnerSetup               PASS      428.33 seconds
TestRunner_l2cap-tester       PASS      16.08 seconds
TestRunner_iso-tester         PASS      15.63 seconds
TestRunner_bnep-tester        PASS      5.44 seconds
TestRunner_mgmt-tester        PASS      106.20 seconds
TestRunner_rfcomm-tester      PASS      9.39 seconds
TestRunner_sco-tester         PASS      8.96 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        PASS      6.82 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      5.72 seconds
IncrementalBuild              PASS      239.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[V2,12/17] timers: Silently ignore timers with a NULL function
WARNING: 'pathes' may be misspelled - perhaps 'paths'?
#85: 
In preparation for that replace the warnings in the relevant code pathes
                                                                  ^^^^^^

total: 0 errors, 1 warnings, 135 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13052619.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[V2,14/17] timers: Add shutdown mechanism to the internal functions
WARNING: 'aquisition' may be misspelled - perhaps 'acquisition'?
#137: FILE: kernel/time/timer.c:1326:
+	 * aquisition. By taking the lock it is ensured that such a newly
 	   ^^^^^^^^^^

total: 0 errors, 1 warnings, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13052621.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[V2,03/17] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function

1: T1 Title exceeds max length (103>80): "[V2,03/17] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function"
[V2,04/17] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function

1: T1 Title exceeds max length (94>80): "[V2,04/17] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function"
[V2,13/17] timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode

1: T1 Title exceeds max length (81>80): "[V2,13/17] timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode"
[V2,16/17] timers: Update the documentation to reflect on the new timer_shutdown() API

1: T1 Title exceeds max length (86>80): "[V2,16/17] timers: Update the documentation to reflect on the new timer_shutdown() API"
[V2,17/17] Bluetooth: hci_qca: Fix the teardown problem for real

21: B3 Line contains hard tab characters (\t): "			      deep in the work queue core code."
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6160342854867026951==--
