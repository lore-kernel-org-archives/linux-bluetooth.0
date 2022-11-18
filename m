Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC86C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbiKREUD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241063AbiKRETo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:19:44 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B0987A66
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:19:32 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id v8so2694436qkg.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ceC+Miq/r5P9+rh/aagml+iv4nsi42HvByQm3xt+AA=;
        b=plze2L3+FV1oVRS7qVnaAEqcsv+jwB/y1BonzV3dOk72Ez+npwssV/oaOiGcYHnA73
         o/1yMC+5VSf0Smm4c8uJrDd/uscIXVqwtdQBYBU3ZW7/GNj4TQBJVDhCVCAnZsk6EAKV
         1DQ6xdmET/Zevb/eDu5tAPXLyhbu5WB9DQUO+3lTjzFEnovMuH+R9xrzH24b9tV3Z1sq
         /HeVL43rCYuvCw/rWshKUFogf4tlwvA7K2zI8CAOvpNZgZDmdGfPgF2axQQtqk/i6IBq
         a5s1oYBWUMhW7Z/zbuslxXSaIgFf4vy1Zl/h4dHz22ZvFakWWNHeoDqJBLjw3V6LJAV0
         dZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ceC+Miq/r5P9+rh/aagml+iv4nsi42HvByQm3xt+AA=;
        b=ifDSjvrNjht7DLWQHfYj82bK8JiWdVgJ8qFf/RrxHRWx4vZSo5x1grYm2lzNngFtG5
         gukP3iww0tMMMf4j/CX9tbMHgHS/X74aLJBTkUrPXXMt5SMsNOU3xbyX1pKEwB7umCN0
         qb+lxeHN7YehH11QakxCmLTPKqgRTSzGMWZs6Zt5YUL1cr4LagVcCHGBkxGMG2e8AGqO
         9kvEmyUA5T+4B58OA/jKIvSYlGXkoHQCDwZnv3oTLLl9Acjm55j8RjZmcVb9Cq4fAMd5
         wwC1rwPk9wlGE1VtwN73RKlJmkhEdqC1+6BA8RL1wTKVxT7ZNyVtqjY7OnBSmpJmXd+X
         Tm2Q==
X-Gm-Message-State: ANoB5pmge+ATXb23/jorDVsZ6FhICfD34imsHlFHeq2s8wCVrPARvQxl
        pspJe8DQjMWIwzjZImXWs8zQqujFvPF8ag==
X-Google-Smtp-Source: AA0mqf4cwr9rRXVvKb3nqvF1l9re0sUAP6ZzOqEnVQjqjMLbPPHVfT1xv8bhXHKPUz0UbtzwQqHPAQ==
X-Received: by 2002:a05:620a:2b9c:b0:6f9:bc42:699a with SMTP id dz28-20020a05620a2b9c00b006f9bc42699amr4392566qkb.496.1668745171741;
        Thu, 17 Nov 2022 20:19:31 -0800 (PST)
Received: from [172.17.0.2] ([20.122.18.126])
        by smtp.gmail.com with ESMTPSA id do52-20020a05620a2b3400b006fba0a389a4sm1726805qkb.88.2022.11.17.20.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:19:31 -0800 (PST)
Message-ID: <637707d3.050a0220.73ffa.8da5@mx.google.com>
Date:   Thu, 17 Nov 2022 20:19:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8357570399401931598=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tglx@linutronix.de
Subject: RE: timers: Provide timer_shutdown[_sync]()
In-Reply-To: <20221115202117.038937247@linutronix.de>
References: <20221115202117.038937247@linutronix.de>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8357570399401931598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695686

---Test result---

Test Summary:
CheckPatch                    FAIL      12.25 seconds
GitLint                       FAIL      5.41 seconds
SubjectPrefix                 FAIL      2.00 seconds
BuildKernel                   PASS      35.22 seconds
BuildKernel32                 PASS      31.94 seconds
TestRunnerSetup               PASS      447.37 seconds
TestRunner_l2cap-tester       PASS      16.46 seconds
TestRunner_iso-tester         PASS      16.53 seconds
TestRunner_bnep-tester        PASS      5.75 seconds
TestRunner_mgmt-tester        PASS      109.56 seconds
TestRunner_rfcomm-tester      PASS      9.82 seconds
TestRunner_sco-tester         PASS      9.20 seconds
TestRunner_ioctl-tester       PASS      10.61 seconds
TestRunner_mesh-tester        PASS      7.33 seconds
TestRunner_smp-tester         PASS      9.08 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PASS      243.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[10/15] timers: Silently ignore timers with a NULL function
WARNING: 'pathes' may be misspelled - perhaps 'paths'?
#84: 
In preparation for that replace the warnings in the relevant code pathes
                                                                  ^^^^^^

total: 0 errors, 1 warnings, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13044156.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[12/15] timers: Add shutdown mechanism to the internal functions
WARNING: 'aquisition' may be misspelled - perhaps 'acquisition'?
#133: FILE: kernel/time/timer.c:1322:
+	 * aquisition. By taking the lock it is ensured that such a newly
 	   ^^^^^^^^^^

total: 0 errors, 1 warnings, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13044158.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[02/15] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function

1: T1 Title exceeds max length (100>80): "[02/15] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function"
[03/15] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function

1: T1 Title exceeds max length (91>80): "[03/15] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function"
[14/15] timers: Update the documentation to reflect on the new timer_shutdown() API

1: T1 Title exceeds max length (83>80): "[14/15] timers: Update the documentation to reflect on the new timer_shutdown() API"
13: B3 Line contains hard tab characters (\t): "  	del_timer_sync() returns the number of removal attempts ]"
[15/15] Bluetooth: hci_qca: Fix the teardown problem for real

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


---
Regards,
Linux Bluetooth


--===============8357570399401931598==--
