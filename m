Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EC4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiKREPa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKREPW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:15:22 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97A66151C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:15:09 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-12c8312131fso4667922fac.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3VT8AGomHAWSXZCSTrVn8dzYBN9pmuzm+fAMGKA4OOU=;
        b=l3C87z9WG28zv3zrWqtoIRQZASGPOyCLbkn5hDOEJqIbMrvLlM0FmR+cEXXLVmHw2O
         ZfDFHDwMijzziMEfEy8HZjvY8xlECs0T1RyQQT0qtiRathxqXoIJTMbc5gKuYUYCWP+7
         vomqUGfIZlyljIhCTWKKA9FlZ+mVEabAS5THjMhi+Ol4I4ob7fFHrydrlmguPQjiOuhB
         tFOH4ati/vbrlX3R0ufCXYtI8Ii6j++PY5U+MOSixy7qkRm+S5cgmTTtTlhg6lSOgxHe
         DP/ZJZmUnx/YZtv0JC1AJ545DHY9xv2di4uMrBsLrgZqtGGMQpjGSoIkeT0IMRF4wyAH
         riIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VT8AGomHAWSXZCSTrVn8dzYBN9pmuzm+fAMGKA4OOU=;
        b=WIlzZ14vIRc4p+6Ung/DjDao6gzYYfrBAmsskJ2JmfT3we9jfoLgTrf4BelYOTJg3T
         PKNks7xI52F5rectU15gUw521jxj58oca2GhUYNgL0ex9I64iFoaNDPopc8wFY3fbFZT
         YW62dBCzfdloyIT24991GAPLq3LvqKC6Batf3Vji923k4HoInq+FmIPLcNGxhlNuPBtc
         7OJPjXZJwKBy/buMEOprnjLiVj0P5YWzUv4UW1O39Xj3nvAKYsfYkaRnAQtBT8aQ3CFl
         0H+C4LUutxMNK/ZET8P8RCpBJVCFNqzg9SplXHtMH7Qn9wMh+DkVeEMzbDOmw0IvbUr4
         C4aw==
X-Gm-Message-State: ANoB5plg01I4ih4NJxjCSKpeBKfeeAvZWdyjlg34azJ+Tvk0+jmkfaUB
        rmbeFNU4RRHP4GTn4GJilTR65c9Ea50=
X-Google-Smtp-Source: AA0mqf5bgWnmBuGU9fPUicOQF3GrGRC8ehcBY9/Tm0BGcvx2oDPpTyWhrQGqR28gHuN6wqxet3zUsg==
X-Received: by 2002:a05:6870:63a5:b0:142:792f:948d with SMTP id t37-20020a05687063a500b00142792f948dmr1981264oap.39.1668744908915;
        Thu, 17 Nov 2022 20:15:08 -0800 (PST)
Received: from [172.17.0.2] ([20.165.40.85])
        by smtp.gmail.com with ESMTPSA id g89-20020a9d12e2000000b00661948e6119sm1143994otg.47.2022.11.17.20.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:15:08 -0800 (PST)
Message-ID: <637706cc.9d0a0220.ad2b5.53b4@mx.google.com>
Date:   Thu, 17 Nov 2022 20:15:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4239161678646174889=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: hci_event: handling CIS QoS
In-Reply-To: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
References: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4239161678646174889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696036

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      33.62 seconds
BuildKernel32                 PASS      29.94 seconds
TestRunnerSetup               PASS      418.08 seconds
TestRunner_l2cap-tester       PASS      15.64 seconds
TestRunner_iso-tester         FAIL      14.97 seconds
TestRunner_bnep-tester        PASS      5.41 seconds
TestRunner_mgmt-tester        PASS      103.52 seconds
TestRunner_rfcomm-tester      PASS      9.04 seconds
TestRunner_sco-tester         PASS      8.46 seconds
TestRunner_ioctl-tester       PASS      9.68 seconds
TestRunner_mesh-tester        PASS      6.62 seconds
TestRunner_smp-tester         PASS      8.39 seconds
TestRunner_userchan-tester    PASS      5.51 seconds
IncrementalBuild              PASS      30.91 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 55, Passed: 11 (20.0%), Failed: 44, Not Run: 0

Failed Test Cases
ISO QoS 8_1_1 - Success                              Failed       2.009 seconds
ISO QoS 8_2_1 - Success                              Failed       0.142 seconds
ISO QoS 16_1_1 - Success                             Failed       0.143 seconds
ISO QoS 16_2_1 - Success                             Failed       0.142 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.141 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.140 seconds
ISO QoS 24_1_1 - Success                             Failed       0.139 seconds
ISO QoS 24_2_1 - Success                             Failed       0.141 seconds
ISO QoS 32_1_1 - Success                             Failed       0.139 seconds
ISO QoS 32_2_1 - Success                             Failed       0.139 seconds
ISO QoS 44_1_1 - Success                             Failed       0.142 seconds
ISO QoS 44_2_1 - Success                             Failed       0.141 seconds
ISO QoS 48_1_1 - Success                             Failed       0.140 seconds
ISO QoS 48_2_1 - Success                             Failed       0.140 seconds
ISO QoS 48_3_1 - Success                             Failed       0.142 seconds
ISO QoS 48_4_1 - Success                             Failed       0.141 seconds
ISO QoS 48_5_1 - Success                             Failed       0.139 seconds
ISO QoS 48_6_1 - Success                             Failed       0.139 seconds
ISO QoS 8_1_2 - Success                              Failed       0.143 seconds
ISO QoS 8_2_2 - Success                              Failed       0.143 seconds
ISO QoS 16_1_2 - Success                             Failed       0.141 seconds
ISO QoS 16_2_2 - Success                             Failed       0.145 seconds
ISO QoS 24_1_2 - Success                             Failed       0.142 seconds
ISO QoS 24_2_2 - Success                             Failed       0.143 seconds
ISO QoS 32_1_2 - Success                             Failed       0.141 seconds
ISO QoS 32_2_2 - Success                             Failed       0.141 seconds
ISO QoS 44_1_2 - Success                             Failed       0.140 seconds
ISO QoS 44_2_2 - Success                             Failed       0.137 seconds
ISO QoS 48_1_2 - Success                             Failed       0.140 seconds
ISO QoS 48_2_2 - Success                             Failed       0.137 seconds
ISO QoS 48_3_2 - Success                             Failed       0.141 seconds
ISO QoS 48_4_2 - Success                             Failed       0.139 seconds
ISO QoS 48_5_2 - Success                             Failed       0.137 seconds
ISO QoS 48_6_2 - Success                             Failed       0.139 seconds
ISO Connect2 CIG 0x01 - Success                      Failed       0.176 seconds
ISO Send - Success                                   Failed       0.140 seconds
ISO Receive - Success                                Failed       0.145 seconds
ISO Defer Send - Success                             Failed       0.141 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.139 seconds
ISO Defer Receive - Success                          Failed       0.139 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.135 seconds
ISO Send and Receive - Success                       Failed       0.141 seconds
ISO Disconnect - Success                             Failed       0.140 seconds
ISO Reconnect - Success                              Failed       0.141 seconds


---
Regards,
Linux Bluetooth


--===============4239161678646174889==--
