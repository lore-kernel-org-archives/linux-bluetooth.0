Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FBEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 09:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF2JlB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 05:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjF2Jk6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 05:40:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C03DED
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 02:40:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso3885615ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688031656; x=1690623656;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzjwRoe7c2+Rc7snjbcUooAWeg2OSfdFvJOkIlX+vuc=;
        b=eCxeotDQEPlq/gEO+OFVzZSUTXPn8rNEEp8ajqJOtdAbRX6YwQDriDWgPCtjdrTVhc
         B9HHj0R/GUdltztYqOoUU7t0SiA+x0c4tVtkxWcos/EMCiGcJ+IEDLPzrAHghiQupAP3
         sLgi3hmjGfq58B0eLgXaz/1ADc1Soi/WhYQSVeigMCYr4+z7ozxn3mOXvpEUUp43FStf
         yhLj/DD3aonmxFkxGVDr+/IjpEKNVKhTI9zTUYDFrtPKHXYdO3mK/+NvNFCr2s8VRHmL
         tr+vSyjavcxlGcQvZpAutgFeeFcFtdRx7VidxazYJzWcMqtNmpWMu33yTEHPQ3xYTJ+M
         qgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688031656; x=1690623656;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzjwRoe7c2+Rc7snjbcUooAWeg2OSfdFvJOkIlX+vuc=;
        b=lRk4iG5p74hnSgLlevu4pW042hb2jug7aMyEi5Uqehn2bk8pnd/EE2LUT49aHOi8VP
         p5H2GS85CtUW2TFSPzbfKx9C6eucAxnYiHZt7Kd6Mqac9RLOGPr6V/fFoSziDKXpBNhQ
         2aPrWhfZJJDv+rgKziHRcnpBS6ypAxVwuGCnSnP3Cr1ky9LL1uvhWN+oNUnK7iAeTz0h
         6hCJeP4uC57zut0pdHFKQmcxXCbYthjqz4Pibn0dWHk+xK9h+xtekZgVvqZ0dPFSuGN3
         URNQT/lDqQpIrwrsM4lmmiFHty1Yh011Yv6xVKgE5iK1+bj5u/HI30Nc0Zid95lFKiwD
         E9Sg==
X-Gm-Message-State: AC+VfDx8Tu9UUj7KcYn+h31DLNk/4thdxisUmYOmBPWBVw+I/IrAhDkz
        Va4zeYG96UjE46fYPwrmIuxGGspZRdA=
X-Google-Smtp-Source: ACHHUZ5vV/9+/fggKVcbiqBKsAqTz2fLzLXgYx6H2/MvBLpRAorodTGvIaCSlcYezYsAHBGLhwzzUA==
X-Received: by 2002:a17:902:d4d2:b0:1b8:adc:7c3d with SMTP id o18-20020a170902d4d200b001b80adc7c3dmr10003482plg.40.1688031656498;
        Thu, 29 Jun 2023 02:40:56 -0700 (PDT)
Received: from [172.17.0.2] ([104.40.79.86])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b001b558c37f91sm8721494plh.288.2023.06.29.02.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:40:56 -0700 (PDT)
Message-ID: <649d51a8.170a0220.6ce64.0a5c@mx.google.com>
Date:   Thu, 29 Jun 2023 02:40:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2693217661283679411=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: hci_sync: Enable events for BIS capable device
In-Reply-To: <20230629083726.8505-2-claudia.rosu@nxp.com>
References: <20230629083726.8505-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2693217661283679411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761163

---Test result---

Test Summary:
CheckPatch                    FAIL      1.01 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      43.74 seconds
CheckAllWarning               PASS      47.44 seconds
CheckSparse                   PASS      53.32 seconds
CheckSmatch                   PASS      146.25 seconds
BuildKernel32                 PASS      42.27 seconds
TestRunnerSetup               PASS      604.16 seconds
TestRunner_l2cap-tester       PASS      21.59 seconds
TestRunner_iso-tester         PASS      31.17 seconds
TestRunner_bnep-tester        PASS      7.75 seconds
TestRunner_mgmt-tester        PASS      163.48 seconds
TestRunner_rfcomm-tester      PASS      12.03 seconds
TestRunner_sco-tester         PASS      11.10 seconds
TestRunner_ioctl-tester       PASS      12.80 seconds
TestRunner_mesh-tester        PASS      9.50 seconds
TestRunner_smp-tester         PASS      10.66 seconds
TestRunner_userchan-tester    PASS      7.96 seconds
IncrementalBuild              PASS      40.26 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: hci_sync: Enable events for BIS capable devices
WARNING: Missing commit description - Add an appropriate one

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 1 warnings, 0 checks, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13296795.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2693217661283679411==--
