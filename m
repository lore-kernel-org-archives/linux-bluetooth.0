Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7A5C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 04:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjEREj7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 00:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEREj5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 00:39:57 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BA41997
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 21:39:56 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-19615d6ef9eso1248950fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 21:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684384796; x=1686976796;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uTrYpHSD+oHrFD15R1PW50QYwHidZeEZGGahtJqcCRo=;
        b=RWHjnBa/NsrzdDNMxbJzTP4qg5JynHPmTTS5QkDj7dx31BkRcv5mcJS1tEK5xEbg89
         h/PGIPaKc3YN6yyoyMm1WYFn1bOvzRacB/aRF1reU9gkxQZq0KAncjcDb+m40Uj70g5m
         9KCSYD54irDyBM/xLWUQj3zlk94OyXfL/iAOvHgcKEFuXVt5i2lU+YE7a/C/jLSE/zRR
         J8jy/vLWi0NxqgTahBNBNX2kQ8ixIW3QGp0FwWpSj38TANALVQMx306/rVFiMJtTNIAx
         4d5fn7g7ayJadGaNiEHORBE2Rx9i4jmNwuyfCpnMAdI+vetcLfSffFcgtpO810ZU0UCJ
         3S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684384796; x=1686976796;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTrYpHSD+oHrFD15R1PW50QYwHidZeEZGGahtJqcCRo=;
        b=dn44z+wuMqOetsgSetGUc57VYH9yVbgD01gCP1SS7iq2xYr71rl5vzYDuDAEIa8WVl
         3mFvxNqhqOq5DTsAWJQ/TY5psYZXww6zsMaeYeRO+RLjQ7a9zHvadqf2I3EgspZipkVS
         1+rT6zkyZ+3EtG/a1y/1LKYbRLnCqdVpPRJMSJ6YRgMkRPz2b/PD48duap3sXHFinHwX
         ES2gwmz7KRr/40JaS3AjadIyE+BZvwScL2Hoed8bI5eao9fqihAEa2ob05ldAs4yqkSI
         Sd/nxzkEIjUFLcJxlslwKlokKxXLW1I6Ejnid/V5AWgSJvpvRK2rwR4KyY7vJzvmrwEb
         VX3Q==
X-Gm-Message-State: AC+VfDxrFjAHpeV34vpxMlNIMzdCRLHursmrASJqRMkpl9HmEn4RvqGb
        X7Wrlqjjr3PJiskWsHDm9QnR3U6z2dM=
X-Google-Smtp-Source: ACHHUZ5wsJEncp+bNQFEfk4BiKvEGp8f9RGSW9cebp8WCfS463v94vB+5fryVOA2hrsjr/4oFtYjxw==
X-Received: by 2002:a05:6870:e14d:b0:187:e5c4:4a50 with SMTP id z13-20020a056870e14d00b00187e5c44a50mr185767oaa.17.1684384795768;
        Wed, 17 May 2023 21:39:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.99])
        by smtp.gmail.com with ESMTPSA id em8-20020a0568705b8800b0018045663fc5sm372056oab.48.2023.05.17.21.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 21:39:55 -0700 (PDT)
Message-ID: <6465ac1b.050a0220.a9def.1dca@mx.google.com>
Date:   Wed, 17 May 2023 21:39:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8307631597099962961=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v5] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230518033935.11428-1-quic_tjiang@quicinc.com>
References: <20230518033935.11428-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8307631597099962961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748731

---Test result---

Test Summary:
CheckPatch                    FAIL      1.64 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      42.79 seconds
CheckAllWarning               PASS      47.73 seconds
CheckSparse                   WARNING   53.56 seconds
CheckSmatch                   PASS      144.40 seconds
BuildKernel32                 PASS      41.99 seconds
TestRunnerSetup               PASS      597.07 seconds
TestRunner_l2cap-tester       PASS      21.31 seconds
TestRunner_iso-tester         PASS      27.79 seconds
TestRunner_bnep-tester        PASS      7.48 seconds
TestRunner_mgmt-tester        PASS      147.14 seconds
TestRunner_rfcomm-tester      PASS      12.06 seconds
TestRunner_sco-tester         PASS      10.95 seconds
TestRunner_ioctl-tester       PASS      13.32 seconds
TestRunner_mesh-tester        PASS      9.62 seconds
TestRunner_smp-tester         PASS      10.86 seconds
TestRunner_userchan-tester    PASS      7.99 seconds
IncrementalBuild              PASS      40.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
WARNING: DT compatible string "qcom,qca2066-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#282: FILE: drivers/bluetooth/hci_qca.c:2364:
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

total: 0 errors, 1 warnings, 160 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13246087.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:712:24: warning: restricted __le32 degrades to integer


---
Regards,
Linux Bluetooth


--===============8307631597099962961==--
