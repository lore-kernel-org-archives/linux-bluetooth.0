Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C36ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Sep 2022 23:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIFXI0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIFXIZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Sep 2022 19:08:25 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD486886
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 16:08:24 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g21so9354778qka.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Sep 2022 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=VkUK8XuSW05kO+lGU5iTkRm3TjsWhHCBWSVzCFXY+1I=;
        b=QkJ+VMglaypJyKvZnmktvFMTHjjNsrzvL2uw8Oy4XBygd9AwvuRtBZBibmv/nUb5kU
         M/haa2qZ9fICMvOEFidMXmPeq2/GTz3aGsqn3s8K/40yQc3v3pOT+3DH6WgyTkjj1EAH
         /M9sF1ayKwoC9PQ/4kg2hFR7Ol+7UbiHSP73eD2Xc3KJLueekGqF6V2EznxLXumJCsBq
         IebOeTT/rZwVSIQsT0jAyutBL/agTMQONIamNdqJBMnvdqfui4c3a6C57GrVdqQq3xxk
         G8Z0LQBwcZOOJwbtGsvdMMxZ/LSDmDg1x+pKxd3NAZf/TN/htTyD94xyNxGtJVenARzU
         42rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=VkUK8XuSW05kO+lGU5iTkRm3TjsWhHCBWSVzCFXY+1I=;
        b=S3GQ+8mEM7WwAL9h5XZNgkO+WGXhQuoumndtJes1/5o/bFYWmdcwbhXkSRm7Tgyq8Y
         DPG2rALQGtWCWsS3mn1HkchzHgugBDE/+9Gp+jK5HhaPmLU4LM0S3PAzd7EvHGuD1Kgn
         R6BKWOLGAggeaV1EQBf1VZob+B5Jc+SoHqY+7yezYkHASHgK4bFztm5Gm6351bEhgCyT
         wVkPoWHyUjmpyuJMnd4n8UltFFcpoSnsp2BpZ4a6Cs6rIqfykGpmbRXfZuTzdwB1roEq
         U2V96ShRLjhO1bbU/2uh/cbJMwrrmjkCgFdV+mkAx8ZzP+x3Yi1sEsPw+NasjTkMEBnv
         L9hg==
X-Gm-Message-State: ACgBeo2lUn9Et/8ERciSc6yYUku1tcHEe8gKaYJVGeedQFM3sfeTICu5
        5NM2TUyj++N3vcH3KDxMx4lWKirdkHc=
X-Google-Smtp-Source: AA6agR6LcHQrYbze0QKbfb/JNw5ksB37U46vaNS9zar+sX1qdldDCK+rGJtIhFB6vGFHAy81k795og==
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr842949qko.260.1662505703201;
        Tue, 06 Sep 2022 16:08:23 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.199.209])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a440500b006b9a89d408csm13194910qkp.100.2022.09.06.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 16:08:22 -0700 (PDT)
Message-ID: <6317d2e6.050a0220.8b700.ed88@mx.google.com>
Date:   Tue, 06 Sep 2022 16:08:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1538035368338868668=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Enable LE 2M PHY by default
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220906215353.2820044-1-luiz.dentz@gmail.com>
References: <20220906215353.2820044-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1538035368338868668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=674664

---Test result---

Test Summary:
CheckPatch                    PASS      1.77 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      36.43 seconds
BuildKernel32                 PASS      32.20 seconds
Incremental Build with patchesPASS      48.59 seconds
TestRunner: Setup             PASS      529.00 seconds
TestRunner: l2cap-tester      PASS      17.66 seconds
TestRunner: iso-tester        PASS      16.81 seconds
TestRunner: bnep-tester       PASS      6.67 seconds
TestRunner: mgmt-tester       FAIL      108.08 seconds
TestRunner: rfcomm-tester     PASS      10.39 seconds
TestRunner: sco-tester        PASS      9.98 seconds
TestRunner: smp-tester        PASS      9.92 seconds
TestRunner: userchan-tester   PASS      6.90 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 108.08 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 492 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Get PHY Success                                      Failed       0.120 seconds
Set PHY 2m Success                                   Timed out    2.402 seconds



---
Regards,
Linux Bluetooth


--===============1538035368338868668==--
