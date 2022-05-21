Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F30C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 May 2022 21:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346328AbiEUVHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 May 2022 17:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiEUVHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 May 2022 17:07:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC057532CD
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 May 2022 14:07:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so10458125pjf.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 May 2022 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1YJ2Y44pgroztrxz1GFoatC0xvEu9wWs9fLT/jBMK5g=;
        b=kX8l5MtBWWVwrw8Qj8udQxaQubxdrR8ZpiNjD722prJaFURzzkRcqgZ73StV0Q4p4z
         TgjOgVkGeCYSrm1Fc2EAts3LT0b8txPbUpWfH4aeMZs04c5sCjlhUYTUSsSjMgmZrC6u
         3LRgps+pTPJqsJJIB2cFAxSAaiGAdHRHj4RKfq5W9vWyG19MzZlA4Xvnvf5NXHO+l0vT
         IFazPYyAmynZjakHDWt/hZUmu130yOW5JG00WYRpP5f9uOMj6H1lAb6RtdZb6juy1VPx
         JbYA8v5P7iwk8FkGi0oa5t63W81FgezMCJX7xDOZa/p2HnLZUNBhwB/2icHnVRBpipuw
         T3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1YJ2Y44pgroztrxz1GFoatC0xvEu9wWs9fLT/jBMK5g=;
        b=DOP+yRubr2TJXaTA9ZMvecKIccZZ4dWkAeiUwkoqx/gf5pAkjAFV6UfOTEzd64xwFN
         yRTrPNdOAIskUS2vXpqrib6J5LC2LA77tC7YBg7hZPgoE73m4uB4u/s+Pd3DxNpqvE8d
         m9l4q42Q5d0JYoQf4KZbGChRxhXV2CXA6C4RtutuZOZ2Xxn2xLHDuX/cI0pLTXFSkdJl
         DXuRF+IfbPb2Gk12VdLh5zA/MrLTPsjCR+gCQyfWbg0Vj6laHvFN3yJ8mmiwRqBXvlCG
         0yYttmeL+kWZcHcF03no/0UK3HbIGSWXgcqT4VFPPIt1fi4g2ZLx8dx4namibBxyP1pM
         SjzQ==
X-Gm-Message-State: AOAM532z6rFjhqxBhHZwEfhmuoDQhb3Qpa2alJithKnHnFvnR5FjAyFr
        lgtXPELMHisMPUDCTjXdQPOI6KAEbJ54Jg==
X-Google-Smtp-Source: ABdhPJxGqu+OgPE4IFIXk/JuRfMATnM+ZPlrfLW7vieIYbSbLJcQWe7Jjm5Dfcd5PUdppgIHQ/PcDQ==
X-Received: by 2002:a17:90b:4f87:b0:1dd:100b:7342 with SMTP id qe7-20020a17090b4f8700b001dd100b7342mr18596004pjb.64.1653167269144;
        Sat, 21 May 2022 14:07:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.237.249.212])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b00161c3fc7a44sm2045646plg.108.2022.05.21.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 14:07:48 -0700 (PDT)
Message-ID: <628954a4.1c69fb81.7226f.4ea7@mx.google.com>
Date:   Sat, 21 May 2022 14:07:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3655636668602253063=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, a.fatoum@pengutronix.de
Subject: RE: [1/2] dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220521200734.421223-1-a.fatoum@pengutronix.de>
References: <20220521200734.421223-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3655636668602253063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=644017

---Test result---

Test Summary:
CheckPatch                    FAIL      1.84 seconds
GitLint                       PASS      0.84 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      40.18 seconds
BuildKernel32                 PASS      36.15 seconds
Incremental Build with patchesPASS      54.29 seconds
TestRunner: Setup             PASS      602.88 seconds
TestRunner: l2cap-tester      PASS      19.98 seconds
TestRunner: bnep-tester       PASS      7.16 seconds
TestRunner: mgmt-tester       PASS      122.74 seconds
TestRunner: rfcomm-tester     PASS      11.33 seconds
TestRunner: sco-tester        PASS      11.17 seconds
TestRunner: smp-tester        PASS      11.03 seconds
TestRunner: userchan-tester   PASS      7.79 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.84 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[1/2] dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding\WARNING:BAD_SIGN_OFF: Duplicate signature
#87: 
Cc: linux-kernel@vger.kernel.org

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12858005.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[2/2] Bluetooth: hci_bcm: Add BCM4349B1 variant\WARNING:BAD_SIGN_OFF: Duplicate signature
#91: 
Cc: linux-kernel@vger.kernel.org

total: 0 errors, 1 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12858004.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL - 0.30 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============3655636668602253063==--
