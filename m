Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E251EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 21:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFUVdj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFUVdi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 17:33:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625E41B4
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:33:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666ed230c81so4467127b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687383217; x=1689975217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zIU3mnWjZNHSiRqWaJpCKXMHEEMTAcXzLi/MlaQD+jM=;
        b=ST/Y70q+xn6VCt0+mAtOJkDRpWnVSjP0v4tSpKYC5vWemM9pXIwRBIKxK1y4JBAacu
         a0lnxtK522AaiAh9KWNMcMkvhAghZVX+EPmQQhwbE/hQml1Jn6/pPGLnJZnHw6oWfMU+
         e1+N/dmmadWaMEVnObjhb5ytTBFnbtsAgfYdg+aYVnN3CRzKyDLdH/wDDgfPrMnZUlnt
         Gom4sSp7lr4YkNpPU1uH/tWkgVkgAcvp4EZADtO/PG8JdJM3hf5ABTHFTtZOw73/t3t0
         DgdtubRpQVUb5NoYsxXuv7ACvFGm2ov2j2ZZlKLE803VpO6SNXIEmgInf7IUeMnMsEQE
         GdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383217; x=1689975217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIU3mnWjZNHSiRqWaJpCKXMHEEMTAcXzLi/MlaQD+jM=;
        b=AhAlSa5GFEYBS+wDBjeV5bHhcDr1T5oFD5A/d+tBo0qRhJha8e4bADfRL8Mj3Z0wKT
         l5yXff7CSfDYL6qn/TpoQsp5J+RZIKCRGXgLBPWUXl+RSRoEf7lbOXszcBAzmi18dswg
         sI6RDZmcOt84hpeYyvILAuoxuIa9LJ5P6iq1ASRivnMXukALAe9Hcijnf1ON5VLq7VuC
         974k/PQQyzGhE/iGNlAonksxAPYK67tLlnxUOxuNepXxwf0BQcmYy52f5N04ArKIaTLG
         2tB5l6ksFLo9NSiMiVlpgDCGjETqSH+yC4EG2cRXUnrptsKAtaUe1+4xB7K+8dZcQgCt
         IbXQ==
X-Gm-Message-State: AC+VfDwHo9zal1nWmgRmt0KJq+ZfIy4fhNcxnigfkyHLYEhXLctTpEWU
        kqXs2PHYk+/vTL9fKzkAKiEMACQLm+M=
X-Google-Smtp-Source: ACHHUZ5jHL55EMHBPx4NyaU++ZKlm6Iy5Igp1HpTmp66Ar1OLqbqFsaWvBrwvS09LA5GiJWvAUakDA==
X-Received: by 2002:a05:6a00:1a0f:b0:668:82fe:16f1 with SMTP id g15-20020a056a001a0f00b0066882fe16f1mr9905210pfv.1.1687383216687;
        Wed, 21 Jun 2023 14:33:36 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.3.172])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79104000000b0066a31111ccdsm2077418pfh.65.2023.06.21.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:33:36 -0700 (PDT)
Message-ID: <64936cb0.a70a0220.1f04c.5fb3@mx.google.com>
Date:   Wed, 21 Jun 2023 14:33:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3554534279436419783=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_event: Fix parsing of CIS Established Event
In-Reply-To: <20230621205230.1006939-1-luiz.dentz@gmail.com>
References: <20230621205230.1006939-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3554534279436419783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759272

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      32.63 seconds
CheckAllWarning               PASS      35.81 seconds
CheckSparse                   WARNING   41.19 seconds
CheckSmatch                   WARNING   110.78 seconds
BuildKernel32                 PASS      31.94 seconds
TestRunnerSetup               PASS      456.21 seconds
TestRunner_l2cap-tester       PASS      17.69 seconds
TestRunner_iso-tester         FAIL      32.80 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        PASS      136.43 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      8.65 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        PASS      7.41 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PASS      29.84 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 17 (21.2%), Failed: 63, Not Run: 0

Failed Test Cases
ISO QoS 8_1_1 - Success                              Failed       1.134 seconds
ISO QoS 8_2_1 - Success                              Failed       0.217 seconds
ISO QoS 16_1_1 - Success                             Failed       0.216 seconds
ISO QoS 16_2_1 - Success                             Failed       0.216 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.217 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.215 seconds
ISO QoS 24_1_1 - Success                             Failed       0.217 seconds
ISO QoS 24_2_1 - Success                             Failed       0.214 seconds
ISO QoS 32_1_1 - Success                             Failed       0.216 seconds
ISO QoS 32_2_1 - Success                             Failed       0.213 seconds
ISO QoS 44_1_1 - Success                             Failed       0.218 seconds
ISO QoS 44_2_1 - Success                             Failed       0.218 seconds
ISO QoS 48_1_1 - Success                             Failed       0.218 seconds
ISO QoS 48_2_1 - Success                             Failed       0.217 seconds
ISO QoS 48_3_1 - Success                             Failed       0.212 seconds
ISO QoS 48_4_1 - Success                             Failed       0.215 seconds
ISO QoS 48_5_1 - Success                             Failed       0.216 seconds
ISO QoS 48_6_1 - Success                             Failed       0.217 seconds
ISO QoS 8_1_2 - Success                              Failed       0.212 seconds
ISO QoS 8_2_2 - Success                              Failed       0.212 seconds
ISO QoS 16_1_2 - Success                             Failed       0.215 seconds
ISO QoS 16_2_2 - Success                             Failed       0.213 seconds
ISO QoS 24_1_2 - Success                             Failed       0.213 seconds
ISO QoS 24_2_2 - Success                             Failed       0.210 seconds
ISO QoS 32_1_2 - Success                             Failed       0.212 seconds
ISO QoS 32_2_2 - Success                             Failed       0.214 seconds
ISO QoS 44_1_2 - Success                             Failed       0.216 seconds
ISO QoS 44_2_2 - Success                             Failed       0.220 seconds
ISO QoS 48_1_2 - Success                             Failed       0.220 seconds
ISO QoS 48_2_2 - Success                             Failed       0.215 seconds
ISO QoS 48_3_2 - Success                             Failed       0.222 seconds
ISO QoS 48_4_2 - Success                             Failed       0.220 seconds
ISO QoS 48_5_2 - Success                             Failed       0.221 seconds
ISO QoS 48_6_2 - Success                             Failed       0.220 seconds
ISO Send - Success                                   Failed       0.216 seconds
ISO Receive - Success                                Failed       0.206 seconds
ISO Receive Timestamped - Success                    Failed       0.193 seconds
ISO Defer Connect - Success                          Failed       0.217 seconds
ISO Defer Connect2 CIG 0x01 - Success                Failed       0.306 seconds
ISO Defer Send - Success                             Failed       0.218 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.219 seconds
ISO Defer Receive - Success                          Failed       0.201 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.198 seconds
ISO Send and Receive - Success                       Failed       0.214 seconds
ISO Disconnect - Success                             Failed       0.216 seconds
ISO Reconnect - Success                              Failed       0.215 seconds
ISO AC 1 & 4 - Success                               Failed       0.219 seconds
ISO AC 2 & 10 - Success                              Failed       0.220 seconds
ISO AC 3 & 5 - Success                               Failed       0.217 seconds
ISO AC 6(i) - Success                                Failed       0.248 seconds
ISO AC 6(ii) - Success                               Failed       0.308 seconds
ISO AC 7(i) - Success                                Failed       0.245 seconds
ISO AC 7(ii) - Success                               Failed       0.300 seconds
ISO AC 8(i) - Success                                Failed       0.245 seconds
ISO AC 8(ii) - Success                               Failed       0.299 seconds
ISO AC 9(i) - Success                                Failed       0.247 seconds
ISO AC 9(ii) - Success                               Failed       0.307 seconds
ISO AC 11(i) - Success                               Failed       0.250 seconds
ISO AC 11(ii) - Success                              Failed       0.307 seconds
ISO AC 1 + 2 - Success                               Failed       4.317 seconds
ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Failed       4.319 seconds
ISO Reconnect AC 6(i) - Success                      Failed       0.310 seconds
ISO Reconnect AC 6(ii) - Success                     Failed       0.309 seconds


---
Regards,
Linux Bluetooth


--===============3554534279436419783==--
