Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB18CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 14:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiI3Oo4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiI3Oov (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 10:44:51 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447002DFC
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 07:44:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 3so4383572pga.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ufKkfqZQib3gbHIjLUf1Rc98aoDBSxC631h5d1bRcZM=;
        b=bI2AGnnvkaoDdp5Js3WOfGvJt7wQYFR4iDrVMf3kLdkHb08Wo8Z7BzB/D3fozJEXO9
         GeylWn30suSIwIgbNnwVzc9j3IAXzD/6L6QDZDDk6mKvVW8xJPUGHC/n07HMUex0iL3p
         vgBsWbJfpprATSIv3qnMCFYax4YOgel949CibfrAfqHit72IYLSkUezcP2k4Dt9cg21q
         EINGFLj7HJ2I+IAItjCHVSmNdE5kmWL8eNY9SgX6ytQd/NgdvAVG4MXym1yqidlalD/k
         CnB20LmekjGoi8LtkvstNYDKrJPH7pyFuP5byf8OLBtTxmVmAqBvhdKoj/UzrGFGc2FF
         X11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ufKkfqZQib3gbHIjLUf1Rc98aoDBSxC631h5d1bRcZM=;
        b=qoPMdNplkvCgJJTbOfI5XbEUh5pvPr7NcUkQUNikmRTi4uYFcLNwDk46oovmAO/+yK
         0s1ELa1wbCi6p/EQbR2KstjHN3FzRfTseISDDQs5B34eTdlg7xWMH6XzJhaGieG5y1lB
         XmLlAuCiDoZiglJFopMI8yaUo6LNl2Ek5TMgQzoKRcub+hlY8lN+IqUOnvGacpOrg+S0
         sbLA++JCkmGpqdJYFZ913lacmqRdCMrd1nKyum+MYslf9GfS1vRuNxegtoGWOdliM2KB
         +Zx8UP+1NDfV5e/U194L8kkSWpVRQKfa9J4q69JHtMnu48szAbpeX4J+XkoAqeDCZ+US
         Ea+Q==
X-Gm-Message-State: ACrzQf0oKe0kRKIkngA8Yb8h/nG62W1ElqppQQtU6kGHBvq3rjrtCK+G
        +AdMZLsS+Xj6YecEBwr+LQEaBr/XQgg=
X-Google-Smtp-Source: AMsMyM5jYb78OZehsodR47HNqNUI+Uk8wXvhMWCVAYvMwwJCnTVuhktJYi72bBP/czLOLAf4NNmteg==
X-Received: by 2002:a63:5658:0:b0:43c:dac:9e24 with SMTP id g24-20020a635658000000b0043c0dac9e24mr7762929pgm.562.1664549086535;
        Fri, 30 Sep 2022 07:44:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.200.79])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a764200b0020087d7e778sm5419391pjl.37.2022.09.30.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:44:46 -0700 (PDT)
Message-ID: <633700de.170a0220.a01fe.9218@mx.google.com>
Date:   Fri, 30 Sep 2022 07:44:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5161959980282123563=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        ajye_huang@compal.corp-partner.google.com
Subject: RE: [v1] bluetooth: Fix the bluetooth icon status after running hciconfig hci0 up
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220930140655.2723164-1-ajye_huang@compal.corp-partner.google.com>
References: <20220930140655.2723164-1-ajye_huang@compal.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5161959980282123563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682277

---Test result---

Test Summary:
CheckPatch                    FAIL      1.86 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      43.87 seconds
BuildKernel32                 PASS      40.11 seconds
Incremental Build with patchesPASS      56.96 seconds
TestRunner: Setup             PASS      661.93 seconds
TestRunner: l2cap-tester      PASS      20.78 seconds
TestRunner: iso-tester        PASS      21.56 seconds
TestRunner: bnep-tester       PASS      8.22 seconds
TestRunner: mgmt-tester       PASS      130.75 seconds
TestRunner: rfcomm-tester     PASS      12.63 seconds
TestRunner: sco-tester        PASS      11.80 seconds
TestRunner: ioctl-tester      PASS      13.50 seconds
TestRunner: smp-tester        PASS      11.82 seconds
TestRunner: userchan-tester   PASS      8.27 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.86 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v1] bluetooth: Fix the bluetooth icon status after running hciconfig hci0 up\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#92: 
Refer to commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for power on synchronously")

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#92: 
Refer to commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for power on synchronously")

total: 1 errors, 1 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12995489.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.50 seconds
Run gitlint with rule in .gitlint
[v1] bluetooth: Fix the bluetooth icon status after running hciconfig hci0 up
6: B1 Line exceeds max length (89>80): "Refer to commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for power on synchronously")"
7: B1 Line exceeds max length (85>80): "Add back mgmt_power_on(hdev, ret) into function hci_dev_do_open(struct hci_dev *hdev)"


##############################
Test: SubjectPrefix - FAIL - 0.35 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============5161959980282123563==--
