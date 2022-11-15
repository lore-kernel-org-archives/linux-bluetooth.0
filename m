Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEAAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 21:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiKOVJl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Nov 2022 16:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiKOVJk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Nov 2022 16:09:40 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB1FADF
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 13:09:39 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p18so10422448qkg.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=55VZbut00xkGJWNJyMaDuylU3oZYbojWFXG8ZLQYbL4=;
        b=b/6gXeJYQ5LXBfxtdPH73SOre1xEF0qeErM9EDlN2QJxcQAZUB9pjwM8BJH+IG6FEM
         E08OvKt+JHF/GJ3R16yAP0uHc5hRxDyawPcH2gZDeYb1kUAvZoiYNRtm+JU/DxkX3UNP
         IHCwiMRPsfXTKn0b0pXJq6Xx/Asmtz/jWGCZ5ebMQ2ag1TerNmAaLxhOpB7HbiPqnXDu
         C7/I5tcFo46w3GcqkpS7EE7sU+kK3uyiNrSMjtoYz5MflNIts652AFdY2fISjZqH/Xxk
         xVpAlWPYz9fWL0ck0XVj/sjUSxS9BVwuo40nzZSml14nuh5LNK04rRQEJAXMjdc6xck0
         1aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55VZbut00xkGJWNJyMaDuylU3oZYbojWFXG8ZLQYbL4=;
        b=iDc380VoWxGKSjW+NJeHT6g2Vw7l1Jys44zjQI7DLRpJHPqJBGwVvRGJnIJhndkuiG
         EQjvgpgvFP7mjtDNrNo2icCJhrvSjQ8KUJT1Ji+3uuVOvSBrvA+y683PjOEUJEdO7NGS
         v7JsZR86R+sh2Je2lOrCFInqdyBpDXmb1nlrZoDF9mVMamOj3qHxUXDs4dwwoiLFYeS3
         lusiWLIjzQJ9Swneu6QJSA5zUWdh6thXIhUe295YL8fDLInkWq+PzWgI8rf++S8OwKkD
         f5OVh3vEmj2Z0wJEleYrqLGnFRoOfV0b+wJLi4sYs/Ebzq0odPfAkPOmHnBae8LGAhfr
         DV6g==
X-Gm-Message-State: ANoB5pk+3ScIkoVO7sEnSFFF124bPqyLJfjfn8ZMaRIh72lHt/UvM1nO
        f9z+J4TvW/PMi0PC1czf4YlHLeaTGM5LTQ==
X-Google-Smtp-Source: AA0mqf5bt4AjV1JZuXdoQyChK9xWtulYq5WIY/lhsgrJWPg3DxlVMSdyu30bdMY+5Ts9a1AtzKxRyA==
X-Received: by 2002:a05:620a:1094:b0:6fb:4a84:cef2 with SMTP id g20-20020a05620a109400b006fb4a84cef2mr16448811qkk.158.1668546578680;
        Tue, 15 Nov 2022 13:09:38 -0800 (PST)
Received: from [172.17.0.2] ([172.174.67.100])
        by smtp.gmail.com with ESMTPSA id n77-20020a374050000000b006b5cc25535fsm8623157qka.99.2022.11.15.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:09:38 -0800 (PST)
Message-ID: <63740012.370a0220.aebb6.dbb5@mx.google.com>
Date:   Tue, 15 Nov 2022 13:09:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0747017688285942784=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tglx@linutronix.de
Subject: RE: timers: Provide timer_shutdown[_sync]()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221115202117.038937247@linutronix.de>
References: <20221115202117.038937247@linutronix.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0747017688285942784==
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
CheckPatch                    FAIL      20.38 seconds
GitLint                       FAIL      14.40 seconds
SubjectPrefix                 FAIL      11.71 seconds
BuildKernel                   PASS      36.84 seconds
BuildKernel32                 PASS      32.69 seconds
Incremental Build with patchesPASS      263.63 seconds
TestRunner: Setup             PASS      532.30 seconds
TestRunner: l2cap-tester      PASS      18.21 seconds
TestRunner: iso-tester        PASS      17.37 seconds
TestRunner: bnep-tester       PASS      6.79 seconds
TestRunner: mgmt-tester       PASS      109.81 seconds
TestRunner: rfcomm-tester     PASS      10.69 seconds
TestRunner: sco-tester        PASS      10.13 seconds
TestRunner: ioctl-tester      PASS      11.43 seconds
TestRunner: mesh-tester       PASS      8.18 seconds
TestRunner: smp-tester        PASS      10.13 seconds
TestRunner: userchan-tester   PASS      7.00 seconds

Details
##############################
Test: CheckPatch - FAIL - 20.38 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[10/15] timers: Silently ignore timers with a NULL function\WARNING:TYPO_SPELLING: 'pathes' may be misspelled - perhaps 'paths'?
#84: 
In preparation for that replace the warnings in the relevant code pathes
                                                                  ^^^^^^

total: 0 errors, 1 warnings, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13044156.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[12/15] timers: Add shutdown mechanism to the internal functions\WARNING:TYPO_SPELLING: 'aquisition' may be misspelled - perhaps 'acquisition'?
#133: FILE: kernel/time/timer.c:1322:
+	 * aquisition. By taking the lock it is ensured that such a newly
 	   ^^^^^^^^^^

total: 0 errors, 1 warnings, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13044158.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 14.40 seconds
Run gitlint with rule in .gitlint
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
Test: SubjectPrefix - FAIL - 11.71 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0747017688285942784==--
