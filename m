Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1584BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiKREi2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiKREi0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:38:26 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3DA18C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:38:24 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h24so2490114qta.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WHQeLhtO2eC6kYNvBOkDf5p9wo81O/Hpijm6wTz6wZU=;
        b=CHb/bKcYy7rOGCvySWJycMU615b+kA/YbuaZ6/tW5ztDMKHFYCbj2HVG9B1DlpJKIB
         s56/ssBYp+Uuu4s5eV7RsELfKOSnHibN//2+nfDOsdenj/EojLpjjcAkvW+7x6Sh2ac8
         yPyYPj1vuU2jkaKNwlofKIiOZSnfCcotMyfqPznautEJ58GQwK7TDmV8mNbomJFo2DQl
         2d+JHNKX1c7ARMfGzGCGuhRfsVaIGzXKGpniewnB9M6sqwF4Wk2DpFLzxqzLzpS4Ku3G
         WUwPub7PnPlp9PKsGDNaiJA32sKe0t+c8Vxu3AegyKINo7NZhxUBsB9ZLuNVRcsFN5v+
         lPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHQeLhtO2eC6kYNvBOkDf5p9wo81O/Hpijm6wTz6wZU=;
        b=b7zJiKS4+eRmdCmzeJiPHGDHmXGuraTFyEyTqNtIeJEkI7VlAsL76tGCmKtn0BNneG
         8RQTm5Tbc2ZHMZVhl2PP/w7mBHL8JnZN0ZZ/fPLldje2mqUkOwqdTld+5O3KjKJtch/D
         p+6h8oy4HK/NPmGivktnVT0cuYnqoTMkDg+UV6L/NbOSW75YrRvAX+DOHgYLTG6+kWzo
         DxJyHBCmK3RA6pbUwSWWuPe3YBK9qxAvMS1lGO66j3coOHFlzVn4Ok+Ugg9WPK56gsQi
         a3ZaSAeFTjq7zK4Xi0HobUn+uQYxZIfT5QVJ7PLVZDIwXEWv5VsxkdFEPvSJdMmU8tnl
         iocA==
X-Gm-Message-State: ANoB5pm/N7jnJee1c70wmJFoa0zPhGDkal0efiGl6cqUPC8jMOrJFvrj
        HJ8CyhT/ATQegNoeov4Mu8mq99WBbAWCRQ==
X-Google-Smtp-Source: AA0mqf5vZlnR0wAhkNghf4w1XzLaUoP31BoGDVjPk2Yv7YFSN5ZqMBGJBaHJuY/QF28TVPQpu6n/hw==
X-Received: by 2002:ac8:5d8f:0:b0:3a5:448:cc69 with SMTP id d15-20020ac85d8f000000b003a50448cc69mr5186654qtx.530.1668746303605;
        Thu, 17 Nov 2022 20:38:23 -0800 (PST)
Received: from [172.17.0.2] ([20.7.191.239])
        by smtp.gmail.com with ESMTPSA id f5-20020a05620a280500b006ce76811a07sm1803922qkp.75.2022.11.17.20.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:38:23 -0800 (PST)
Message-ID: <63770c3f.050a0220.91b5a.95d7@mx.google.com>
Date:   Thu, 17 Nov 2022 20:38:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6738384479220418877=="
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

--===============6738384479220418877==
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
CheckPatch                    FAIL      12.07 seconds
GitLint                       FAIL      5.39 seconds
SubjectPrefix                 FAIL      2.07 seconds
BuildKernel                   PASS      34.17 seconds
BuildKernel32                 PASS      30.44 seconds
TestRunnerSetup               PASS      418.16 seconds
TestRunner_l2cap-tester       PASS      15.72 seconds
TestRunner_iso-tester         PASS      15.12 seconds
TestRunner_bnep-tester        PASS      5.35 seconds
TestRunner_mgmt-tester        PASS      108.50 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         PASS      8.64 seconds
TestRunner_ioctl-tester       PASS      9.85 seconds
TestRunner_mesh-tester        PASS      6.71 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      5.60 seconds
IncrementalBuild              PASS      224.04 seconds

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


--===============6738384479220418877==--
