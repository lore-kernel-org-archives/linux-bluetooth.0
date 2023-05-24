Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B61C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 08:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbjEXICj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjEXICe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 04:02:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37906186
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 01:02:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53474b0c494so608935a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684915352; x=1687507352;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1UKo6v3gbL4OgCjq+WJT1BlZyWYNxkEUxjXoOqFwC8o=;
        b=eVCCeHOo8ap9XifEimCDqWOoq3WTh81eF2cJyUWTjOyvKRpUWsYMgJXpRi1zTCENyT
         IjJztFpVC7/i3ydvqyYbdDjlRgOmtbgTzPg8vVCvuAWEjXfHyDfGTaaVubl6RPf44Cjn
         3JJnY4xGNYGZHdU3SC+iVD5Jl0rG23ADACwCMvTYylUggF74ZX4EpNf3oIS0HJulklp0
         itx/CI5KZv0T2GY4MYakX3DpROEk0btjBlJq6Lzbrb7lVDvXq9HGotL9hPuB6JolXgjP
         l2iFynK9gbKXhFadMlvg7xRFvG/Y672g9VTu8NGzGErCTogd1Ys66ldpxwTOwSiJDC1u
         ve6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684915352; x=1687507352;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UKo6v3gbL4OgCjq+WJT1BlZyWYNxkEUxjXoOqFwC8o=;
        b=TQg4buTX+LShEwh0fW2WsnwBU2vrI16J/RPRuIaZNaKoHE/R2oB6o54WS61Qu9LJVZ
         mWP45+bWlSO0hS0vA6VNVj0xAZTq5jHKFyvGGxmua6nhsaA6MpnEPqMpVyaOV+RZJ4IT
         v107DVchlusUy9JVbXdWo+eLTnMq6HGAjESbDAf8vma/xj6EXsZH36RUCk3PrM731I6p
         /cZRMDyz/k7ADRiWPrKltt/mjUP5kwW1Tzav8T3art/l1pdr1MexAyiUsPEHffgAogEZ
         R3vlkNSl/Os97dySqHNpAmn01wxiQxrRHnANfUDQuHIqqZxQtE8ymUrAQdbvmT+yntT4
         zo9Q==
X-Gm-Message-State: AC+VfDwG7jwN1TpO53A/GlY3xHGUnvsAO96IfIe0NmmF3Yr0WPJQB0lJ
        kVW3dRuzkaIvNmWy3VHX6LuJRocVAeQ=
X-Google-Smtp-Source: ACHHUZ5JzKISMbv2V7Lh/tOspzKE5etFqIdfIPefmKMauUoFp40ACE9s5XAvUfc3GfHfVn+Nk+dyTw==
X-Received: by 2002:a17:902:d2ca:b0:1ab:253e:6906 with SMTP id n10-20020a170902d2ca00b001ab253e6906mr19330397plc.67.1684915352235;
        Wed, 24 May 2023 01:02:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.98.114])
        by smtp.gmail.com with ESMTPSA id c9-20020a170903234900b001ac5896e96esm8006505plh.207.2023.05.24.01.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:02:31 -0700 (PDT)
Message-ID: <646dc497.170a0220.9314c.e29f@mx.google.com>
Date:   Wed, 24 May 2023 01:02:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1748453465264363337=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v6] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230524072733.23955-1-quic_tjiang@quicinc.com>
References: <20230524072733.23955-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1748453465264363337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=750521

---Test result---

Test Summary:
CheckPatch                    FAIL      1.45 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      39.11 seconds
CheckAllWarning               PASS      45.79 seconds
CheckSparse                   PASS      49.41 seconds
CheckSmatch                   PASS      143.88 seconds
BuildKernel32                 PASS      42.47 seconds
TestRunnerSetup               PASS      610.30 seconds
TestRunner_l2cap-tester       PASS      21.10 seconds
TestRunner_iso-tester         PASS      28.47 seconds
TestRunner_bnep-tester        PASS      7.43 seconds
TestRunner_mgmt-tester        PASS      147.23 seconds
TestRunner_rfcomm-tester      PASS      12.27 seconds
TestRunner_sco-tester         PASS      11.07 seconds
TestRunner_ioctl-tester       PASS      13.12 seconds
TestRunner_mesh-tester        PASS      10.22 seconds
TestRunner_smp-tester         PASS      10.60 seconds
TestRunner_userchan-tester    PASS      7.92 seconds
IncrementalBuild              PASS      41.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
WARNING: DT compatible string "qcom,qca2066-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#282: FILE: drivers/bluetooth/hci_qca.c:2364:
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

total: 0 errors, 1 warnings, 167 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13253391.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1748453465264363337==--
