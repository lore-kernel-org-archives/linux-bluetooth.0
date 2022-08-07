Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54821C3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Aug 2022 22:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiHGV7G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Aug 2022 17:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiHGV7E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Aug 2022 17:59:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111463EB
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Aug 2022 14:59:02 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j17so567633qtp.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Aug 2022 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=ord7tOG9rRtt3Wuq8M1a0HAnbwoEV3A9fTIe5EXa/+4=;
        b=kUStG+GoduIat6xgWu7l7Mr3SJ1SrPGMDyrpWoztlTGwvFvtFxP5/w27KA9qGNddDc
         NkGU4GVbKu9YsBKp2P3p9wT+2ZT6uEFKo8PMKa4IgLEFvGyvrxm5cd3N/Yvjv41wKU0K
         0ZBAfAeRM4pJjRsE8PXS524+3xX9JN4X7WpHvKttpHmah/NeBBlIToogrYFLgpU7IpDg
         L47Cd85E1ixgKg/rFmef/eYhQtUcrKEraQQ1yHkEiMq8BLvZbn3Gs3imJ7kjXmX/UOXm
         MLO3SkmncivhII3JFI6d70BCSXYhbFznPU5SNpvIydXt9I/kYLv9ybJ8KyWR+dcmAsJq
         e9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=ord7tOG9rRtt3Wuq8M1a0HAnbwoEV3A9fTIe5EXa/+4=;
        b=6H+u10u5lU+RDpJmtXTV+uu5HcnvNKkR2OyzycNyaTnX+gAg6d220Iwdmn3K63OVdV
         UqxX/SBddPQjemLsIHJIhrVv76JkLRSMOZtDP5WFlOZBePaf9Ric7qhLqOKENiz1zq2x
         QlY28iZTYiHDk/fhgTnJDnK0fJbuzAC4cStCWAWuM3FCuWxCnvdFriwVHo/tiZtVLDDt
         e19S59L18ws9Qwza4uNS4VVaVfUavMBYUJVQUhAMHAD9nf7Ojr1BlXb05BYA4xE81N1F
         y9r7xZJsE2xkeKwrrFX4sIWNJE6CMWvPafinMWWPgM6pBdN6wmYS3x85SISlpqf9DcW9
         uHkg==
X-Gm-Message-State: ACgBeo0l3n3tFwd5i1J49iQ5zwsGHawQsftfqK3sZ121qV2n0lROlmSJ
        vwBNzNyu5Eki5HWFbwZXi+kjXDSeg/s=
X-Google-Smtp-Source: AA6agR6hXQbtTuzBKcnwEbbbDNMDTF/z+9ACCc2K+/yF02zFrVpto7RzwMM9GgIgCDQDS5W3KGFKAA==
X-Received: by 2002:a05:622a:178e:b0:33b:1ad8:a58e with SMTP id s14-20020a05622a178e00b0033b1ad8a58emr13856676qtk.454.1659909541329;
        Sun, 07 Aug 2022 14:59:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.245.98])
        by smtp.gmail.com with ESMTPSA id x24-20020a05620a0b5800b006b93ff541dasm3232418qkg.8.2022.08.07.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 14:59:01 -0700 (PDT)
Message-ID: <62f035a5.050a0220.aebd4.50b5@mx.google.com>
Date:   Sun, 07 Aug 2022 14:59:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4665828363669088388=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: hci_event: Fix vendor (unknown) opcode status handling
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220807205740.777363-1-hdegoede@redhat.com>
References: <20220807205740.777363-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4665828363669088388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665926

---Test result---

Test Summary:
CheckPatch                    FAIL      1.88 seconds
GitLint                       PASS      1.09 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      33.71 seconds
BuildKernel32                 PASS      29.15 seconds
Incremental Build with patchesPASS      40.88 seconds
TestRunner: Setup             PASS      486.89 seconds
TestRunner: l2cap-tester      PASS      17.54 seconds
TestRunner: bnep-tester       PASS      6.73 seconds
TestRunner: mgmt-tester       PASS      104.38 seconds
TestRunner: rfcomm-tester     PASS      10.12 seconds
TestRunner: sco-tester        PASS      9.90 seconds
TestRunner: smp-tester        PASS      9.92 seconds
TestRunner: userchan-tester   PASS      7.00 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.88 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: hci_event: Fix vendor (unknown) opcode status handling\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'Commit fatal: unsaf ("ace/src' is owned by someone else)")'
#68: 
Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
handle Command Complete") was (presumably) meant to only refactor things

total: 1 errors, 0 warnings, 0 checks, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12938271.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4665828363669088388==--
