Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543EFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Nov 2022 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiKWU7s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Nov 2022 15:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiKWU71 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Nov 2022 15:59:27 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB281FF90
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Nov 2022 12:59:16 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id mx15so1201739qvb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Nov 2022 12:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1JUYr24mAiGSioRYeaTDmdJzAQb7gP2ERdJbdGCsyvY=;
        b=IHJ4RCwt5KFs57oHE0WL3Fv9FN1jbUYnu9fQ3bIcqWJiG5j2Qtp7kDAxhFnFy6+bBY
         TbC1sGCM8N/f2eMqiqmw8FoAX2n9ND2tCWjDWz+0MVjHp5IuRuWT670LWsgt7Nxuyp1U
         5HcM17Fg0qxBMm7caXuWOCvD+DQwGn5sNfLK+poTpDdHn9dbEyrZS3F6thg7DlJC7ZO5
         tYXyw/szE1qiSHOUoztNq59izBG5XqiQk8rLqCVC2aZQuDO1qBB6fSwOYS0BbsN4J2GF
         Fv00DxJmg0VzF0Qq5nYsRAQb+3DgZrPEoAZSnuRWthUANyDC/RomMET4y5L62Nbk/yEp
         hsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JUYr24mAiGSioRYeaTDmdJzAQb7gP2ERdJbdGCsyvY=;
        b=i2GAqE4hSVAep48aUTbC+r7+Ov6ZU3fTxuxxuvIzGoGV8HeYuj4NifCk7IEiy8mbuW
         g9XcHOKNiLihMQvpJdGRHVLhUFeFotuUdIZCromK78DKrVGOZuP5oH2/dcrD9yVipEPb
         AuJJLGR2QKbpduIXXesD7tog0wwGj4Bk7JlcLpWqxFx/WaEYU0mm7DPJZFXBBPHDDu0v
         olGsexgr1CaoFavd0M/yX9SB2GxZGF7+Q33kDKwYqDZpRtFQzREu25UNOazGexfEMdkD
         UBjcOfKlQeROJNYWUqW0EslRMaHEUAVas92v2vuUknig6RkEvqbO/MlmbOKgnoYH8cVR
         kb3w==
X-Gm-Message-State: ANoB5pkofA6I9K1yncqRNQT7gEe5ky/J29xP16uAGTDIT8tL9FNoWJjO
        EzoEapeSh4UjQTgBdEZdF2YQBks0GHg=
X-Google-Smtp-Source: AA0mqf7v4VFzf1f3uZxr4yX4dasMAg8jHeaZl4cTFH/Ausk67du3OqZqzDe9mSElbmVLCMXIUgGLDw==
X-Received: by 2002:a0c:fe44:0:b0:4bb:6bc6:4276 with SMTP id u4-20020a0cfe44000000b004bb6bc64276mr9639313qvs.122.1669237155824;
        Wed, 23 Nov 2022 12:59:15 -0800 (PST)
Received: from [172.17.0.2] ([20.230.4.242])
        by smtp.gmail.com with ESMTPSA id q46-20020a05620a2a6e00b006fbcab95d70sm12232439qkp.101.2022.11.23.12.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 12:59:15 -0800 (PST)
Message-ID: <637e89a3.050a0220.a7622.e093@mx.google.com>
Date:   Wed, 23 Nov 2022 12:59:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1935593993356016724=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tglx@linutronix.de
Subject: RE: timers: Provide timer_shutdown[_sync]()
In-Reply-To: <20221123201624.452282769@linutronix.de>
References: <20221123201624.452282769@linutronix.de>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1935593993356016724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=698659

---Test result---

Test Summary:
CheckPatch                    FAIL      13.97 seconds
GitLint                       FAIL      5.70 seconds
SubjectPrefix                 FAIL      2.18 seconds
BuildKernel                   PASS      33.18 seconds
BuildKernel32                 PASS      29.73 seconds
TestRunnerSetup               PASS      422.98 seconds
TestRunner_l2cap-tester       PASS      15.74 seconds
TestRunner_iso-tester         PASS      15.37 seconds
TestRunner_bnep-tester        PASS      5.42 seconds
TestRunner_mgmt-tester        PASS      106.03 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      8.73 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        PASS      6.90 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      5.64 seconds
IncrementalBuild              PASS      231.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[V3,14/17] timers: Add shutdown mechanism to the internal functions
WARNING: 'aquisition' may be misspelled - perhaps 'acquisition'?
#139: FILE: kernel/time/timer.c:1326:
+	 * aquisition. By taking the lock it is ensured that such a newly
 	   ^^^^^^^^^^

total: 0 errors, 1 warnings, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13054235.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[V3,03/17] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function

1: T1 Title exceeds max length (103>80): "[V3,03/17] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function"
[V3,04/17] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function

1: T1 Title exceeds max length (94>80): "[V3,04/17] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function"
[V3,13/17] timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode

1: T1 Title exceeds max length (81>80): "[V3,13/17] timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode"
[V3,16/17] timers: Update the documentation to reflect on the new timer_shutdown() API

1: T1 Title exceeds max length (86>80): "[V3,16/17] timers: Update the documentation to reflect on the new timer_shutdown() API"
[V3,17/17] Bluetooth: hci_qca: Fix the teardown problem for real

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


--===============1935593993356016724==--
