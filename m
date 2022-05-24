Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5CFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 07:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiEXHKr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 03:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiEXHKp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 03:10:45 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F0C85ECA
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 00:10:44 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id u3so14167162qta.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 00:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BWT04mVVxIKRvetPjM7arvoclhRiPJECJCERFnZU+3E=;
        b=Zf4lNnDaa7VtGDnfv5DvZReMH0vXAZeKyk3CPQGZgxaEUjCldAQB5bF3arzw3alqSz
         spRINhj7FNZ6delre18cABtJL+y8Zvejrl/G0yKgGlc7GMEj7ZgedLHLW3Pbo1qbAp4H
         1j9/Vm/b0FVacYFiViDeImdmkvRWVw3dcnnQLg2mbsZEa5KtWIp+INlDnX+sEUvI9iUZ
         YL0EmRDYFz/l8G8gzEgmlZ/Qr1JI2c/W4ZEj9nCMCbEM2lvVwPQN2oPkcNPRnNQapTEb
         HI4ipYr/QyfXI81QOxAifu+H1aTNGyZt58bDPanppIw/5RC14ifdSBKoh/ssQeEJV0FN
         9hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BWT04mVVxIKRvetPjM7arvoclhRiPJECJCERFnZU+3E=;
        b=DEsn/Jh/odl6NNIt00Oj0rtNq8UyOMFdYVRvftYdmL+LATqau+4rXE/V8ZTUwsQif7
         54VIl2erywzJUKCA9eiCJw7oyfuneyd3xUlaKVfis4M2ivep8bmGaKT0b12CIQyLQZsZ
         6xrIRiSlbyKTfwDlvGC9OoopYP51TJnKT4AtKILXtYJQCmv42uPBLb9/jU6M7nkjtpK8
         TZw3u0KW1COf/uhVpQ0QlK4jV+gT/eCafuOeS7D/KlDPZ3N0TmjkmmMkMAuyofaNIQCp
         ugWRqujHXdm0rwy7wddiFcVdnCnkveEhi3BiVmx3HN7eA8yMc05R4HseaQMsHqFM/dfC
         f1lQ==
X-Gm-Message-State: AOAM532UKvY1HQ9gVqE+vyfXeKoTB/fxMG3/PVVrVIiB/3UuWaOSHFK7
        5yReTwiWbMbBgz10vCtxmglDVTCQxGuBYg==
X-Google-Smtp-Source: ABdhPJwELH8ElPKZQGO61vjjWj3lkOocPMJAaVNX3rezoLlezkQtF3tNehCiDj2s+ayxw8QzvpCfDw==
X-Received: by 2002:a05:622a:4295:b0:2f1:d202:8285 with SMTP id cr21-20020a05622a429500b002f1d2028285mr19028607qtb.378.1653376242827;
        Tue, 24 May 2022 00:10:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.120.87.53])
        by smtp.gmail.com with ESMTPSA id cg7-20020a05622a408700b002f9050bb622sm5693425qtb.69.2022.05.24.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:10:42 -0700 (PDT)
Message-ID: <628c84f2.1c69fb81.a52ee.e7dc@mx.google.com>
Date:   Tue, 24 May 2022 00:10:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4909585048182640083=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, a.fatoum@pengutronix.de
Subject: RE: [v2,1/2] dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220524055642.1574769-1-a.fatoum@pengutronix.de>
References: <20220524055642.1574769-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4909585048182640083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=644532

---Test result---

Test Summary:
CheckPatch                    FAIL      3.26 seconds
GitLint                       PASS      1.86 seconds
SubjectPrefix                 FAIL      0.83 seconds
BuildKernel                   PASS      28.14 seconds
BuildKernel32                 PASS      27.09 seconds
Incremental Build with patchesPASS      42.68 seconds
TestRunner: Setup             PASS      446.89 seconds
TestRunner: l2cap-tester      PASS      17.84 seconds
TestRunner: bnep-tester       PASS      6.07 seconds
TestRunner: mgmt-tester       PASS      102.67 seconds
TestRunner: rfcomm-tester     PASS      9.64 seconds
TestRunner: sco-tester        PASS      9.38 seconds
TestRunner: smp-tester        PASS      9.55 seconds
TestRunner: userchan-tester   PASS      6.30 seconds

Details
##############################
Test: CheckPatch - FAIL - 3.26 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,1/2] dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding\WARNING:BAD_SIGN_OFF: Duplicate signature
#94: 
Cc: linux-kernel@vger.kernel.org

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12859675.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,2/2] Bluetooth: hci_bcm: Add BCM4349B1 variant\WARNING:BAD_SIGN_OFF: Duplicate signature
#95: 
Cc: linux-kernel@vger.kernel.org

total: 0 errors, 1 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12859676.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL - 0.83 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============4909585048182640083==--
