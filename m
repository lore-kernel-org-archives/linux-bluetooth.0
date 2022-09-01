Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D904ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiIATNA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIATM7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 15:12:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CED786F1
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 12:12:58 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x5so14232843qtv.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=tOMtGvLv+6/p3DYRi7J57L9DQmRykh87LmF+WvQ0gXk=;
        b=f6HzUUmafLZcPiamRzDay5oMavuca80pAIWcTYBHFXrx0Jw0wXPY2AJ34JxKcEfkNT
         EgZF6njWrJdQLLQTWWLblwuOWq4SAl/JoigrU+8PJ0lSbjBpe9bfF8CkuX1WkkjmWy2O
         R3jHKJdTQvsn804EAA/0GhoGOqV/VP8TdlwxfQpZ9sBZTRZ73g4upKQPL55pKfHJSYHe
         bzAnrUY6ehY/kANDKWqsBe6wBBSlvNpqykfLH8anSfDl9WZwevTb/vMK/dj7AM2CndiS
         arkF1CRu8OBkS8VwllABicgl26U+MLQ9h04bBR2v433TH0OUiDq0EjFZ+xjRm+Bkq3vW
         rK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tOMtGvLv+6/p3DYRi7J57L9DQmRykh87LmF+WvQ0gXk=;
        b=Kt94pW7wnTqiQ/NF9vtF/ztNt12dRpRo7XhE08OEGhnpf4U09wQP3xPqPNii6EVhdR
         EmjdMKPP7rr11sv0YzGnTMwVjluLP+9DqbszgDcAqLGUDzwaicQYDPaJlHrjtw8I8HTM
         9rtsq6C+znqcsUQW6UYEOCdDukOWR69bCEXSfeZJip4rSp2M149cDBaeZDH3TQlwOXn+
         yCefhTbjkQFLtFKWqfp21hsTKvPkKOgsuZ6Gay0PN0k8hhOBujmdOK8ZCpDnC1uXpCch
         z6u3e8raH93jttuXdrcQuJ1WEwN8b605qtBM380Lgze3CYJou4WB/VR3ii3w9RKYVi9Y
         3/zw==
X-Gm-Message-State: ACgBeo32ZPMteFAEz6LJBD5qEvCezL1BKkwd4d8SxDRMBN4+rN3tGkpl
        EHN8wZ3sR4QywzKbq+AKRYrO/HRUlXACnw==
X-Google-Smtp-Source: AA6agR7/caXq9lEQTs24qzebxnUSPt2JO0gQlKHm1IB54wU1lNj55j6/RP2AUTHU/WBEe2oDm4k7+w==
X-Received: by 2002:ac8:5885:0:b0:343:74df:9b26 with SMTP id t5-20020ac85885000000b0034374df9b26mr25645244qta.406.1662059577658;
        Thu, 01 Sep 2022 12:12:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.23.143])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a0d8d00b006b942f4ffe3sm5524857qkl.18.2022.09.01.12.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:12:56 -0700 (PDT)
Message-ID: <63110438.050a0220.15397.862d@mx.google.com>
Date:   Thu, 01 Sep 2022 12:12:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0656089784134711807=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add Mesh functionality to net/bluetooth
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220901182528.13487-2-brian.gix@intel.com>
References: <20220901182528.13487-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0656089784134711807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673351

---Test result---

Test Summary:
CheckPatch                    FAIL      6.08 seconds
GitLint                       PASS      2.28 seconds
SubjectPrefix                 PASS      1.95 seconds
BuildKernel                   PASS      34.33 seconds
BuildKernel32                 PASS      30.16 seconds
Incremental Build with patchesPASS      76.87 seconds
TestRunner: Setup             PASS      504.69 seconds
TestRunner: l2cap-tester      PASS      17.25 seconds
TestRunner: iso-tester        PASS      16.31 seconds
TestRunner: bnep-tester       PASS      6.58 seconds
TestRunner: mgmt-tester       FAIL      102.97 seconds
TestRunner: rfcomm-tester     PASS      10.03 seconds
TestRunner: sco-tester        PASS      9.81 seconds
TestRunner: smp-tester        PASS      9.81 seconds
TestRunner: userchan-tester   PASS      6.87 seconds

Details
##############################
Test: CheckPatch - FAIL - 6.08 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v6,2/2] Bluetooth: Add experimental wrapper for MGMT based mesh\CHECK:BRACES: Unbalanced braces around else statement
#244: FILE: net/bluetooth/mgmt.c:4641:
+	else {

total: 0 errors, 0 warnings, 1 checks, 182 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12963054.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 102.97 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds



---
Regards,
Linux Bluetooth


--===============0656089784134711807==--
