Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31449C7619A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Apr 2023 17:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDHRcz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Apr 2023 13:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHRcy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Apr 2023 13:32:54 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77105255
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Apr 2023 10:32:53 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id kj14so1071216qvb.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Apr 2023 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680975172; x=1683567172;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+LhJ8Cs14wrYcDvkeKSIqWEzCALD/tgFg2zAI+UzvxY=;
        b=LXJS+uVcyKyw7Q/e173GO7MUDTPGi6b7Yl2m63oOUgOBLUbZQfnQYSWPfTRfVdNDe2
         M9POPGayZ9rsdtx7ROYrZ2tAi9f2baqWcE55UTqbnb4lD+QinLc5uxzsNOlw0xWvb7i9
         IAFx9QMIP5epKqPGqOqY4e1kmlZzGswW9R8jeh/x4UjX4rJRdoxDVQzOku6DbDlulVgN
         +dJBHzuN2TEMjRFclvhd6NvXLwyGi+2164gsYxy49ITHFolaDNcFldb2sVKVEz0PH+ZP
         vfAr+17M2vQNkVN+a+VYdi79QnfN5zsb17Ss72NfdgVmknvGKgOaLrRK3GQqcribgI2p
         Q3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680975172; x=1683567172;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LhJ8Cs14wrYcDvkeKSIqWEzCALD/tgFg2zAI+UzvxY=;
        b=DnM2c9Zn+3tpBRXH4GrIeJrkiuFV0QvhItnvnSnJhKoPpsc/PEggZ3xxjb+c44xsib
         3dnhqW2Pqbs/jBRgnPhP1GMxqNIhXnfN4tFIXcIt43eIlFLNdCXVEETfRmJ8MBPS1NY1
         PgJ30UIYBUAldtiRvr5jjaxlbjHSRJiqP2raTP50tCgPUvcEZa+Kn2NGT8zAFQe8r5va
         1rQdvg6nTauu+6cX9VqCkiiw24qmO/NUX6V0uQw4sog3PbqL90eHpfqE5TGGMPlo9Io9
         DpSTfibnsN1UHciK5TAPgPLAlDRG4InL22dzhMvBQG5cgSfrZcSb9QxaJwLc3tzNdZuP
         z1Ew==
X-Gm-Message-State: AAQBX9cZTnyQAaTSVj2DhM1rVy37REDRLVAOPCn/Lk1WZjPyw8IJR5C+
        KpgskY5VK0cH4NNy8pcARYQMenePhHw=
X-Google-Smtp-Source: AKy350bODypb2j6zl/DL8CIWxR01tU9vjKWE0Xz2l65O8U8t1efXh9bsCXHnO98ahJXiaEvq8Xm4XA==
X-Received: by 2002:a05:6214:485:b0:570:bf43:499 with SMTP id pt5-20020a056214048500b00570bf430499mr11711834qvb.9.1680975172463;
        Sat, 08 Apr 2023 10:32:52 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.152])
        by smtp.gmail.com with ESMTPSA id do20-20020a056214097400b005dd8b9345f5sm2165435qvb.141.2023.04.08.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 10:32:52 -0700 (PDT)
Message-ID: <6431a544.050a0220.4baee.7b24@mx.google.com>
Date:   Sat, 08 Apr 2023 10:32:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7458631707104137286=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, u202212060@hust.edu.cn
Subject: RE: net: bluetooth: hci_debugfs: fix inconsistent indenting
In-Reply-To: <20230408164542.2316-1-u202212060@hust.edu.cn>
References: <20230408164542.2316-1-u202212060@hust.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7458631707104137286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=738211

---Test result---

Test Summary:
CheckPatch                    FAIL      0.93 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      36.61 seconds
CheckAllWarning               PASS      39.95 seconds
CheckSparse                   PASS      45.55 seconds
CheckSmatch                   PASS      120.89 seconds
BuildKernel32                 PASS      34.41 seconds
TestRunnerSetup               PASS      498.88 seconds
TestRunner_l2cap-tester       PASS      17.98 seconds
TestRunner_iso-tester         PASS      18.74 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        PASS      123.48 seconds
TestRunner_rfcomm-tester      PASS      9.83 seconds
TestRunner_sco-tester         PASS      8.99 seconds
TestRunner_ioctl-tester       PASS      10.58 seconds
TestRunner_mesh-tester        PASS      7.79 seconds
TestRunner_smp-tester         PASS      8.85 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
IncrementalBuild              PASS      32.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
net: bluetooth: hci_debugfs: fix inconsistent indenting
WARNING: From:/Signed-off-by: email name mismatch: 'From: markli <u202212060@hust.edu.cn>' != 'Signed-off-by: Lanzhe Li <u202212060@hust.edu.cn>'

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13205785.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7458631707104137286==--
