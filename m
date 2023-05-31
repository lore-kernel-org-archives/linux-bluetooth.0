Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B86C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 04:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjEaEeU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 00:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjEaEeT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 00:34:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C08F
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 21:34:18 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6260de7cfaeso25806676d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685507657; x=1688099657;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0cWBzEvIPvb7IyfTZl9slXNxt26AkJwOLVQB2RJSM7M=;
        b=nIdSX4Imbrvr80vim2tsFbEMdc423Xyj1d5DjJLbGt65H55G34YT7kUX2cWI5kMIVc
         99jn9iwWc5iU73zNu159QWRUtGeXaAw4SeB88kiVDrjrEw8MOdCOkrkmB+OpKTyRvWPu
         F5odJKJIh4YyJ9j6HahgVSucghFuOowAFiNw+gdJuMGD57OHUOFDJn1zjQ1VHQZWNTww
         AAofs8Ywm5M1F4jJ5yC358Zbm5pVuDVtKgcp66JcgTa6Os+8Wx+b2j9ukFWpCqgGkfvj
         8Y+Zn+QWmxWPTsLIgwrYDW24XlPAzPKNUlYw1iHEpNUB1LFmJYLMhYFG1vijLAcnpQhI
         HBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685507657; x=1688099657;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cWBzEvIPvb7IyfTZl9slXNxt26AkJwOLVQB2RJSM7M=;
        b=GsrAkyjrNmz1NbsxriNu/ahip5HnrYuIfDiNgPpY7QFEBXxuvHgQ5c4yuf37t4+w9R
         D+4877hnfDtSMex1gkjFT7i6hVqFN1/9Z6uevDw4Vck2eO4LhDiPoe15AtSGSv59qkCC
         wU2BEf05jnkD8mKT2rhJo5BpQyp+8Zm90U2lM6MMINwGdcF+phuja7SK6VfS1jBAEaeY
         FSLq3mJr06o38k7YxU96H9B9sZ0kqpQ1ojO7tQYk7UP6lKD6VUKo8fGyJDPfyxNL0SS7
         tQTlKuMH3Jg8cz+yp6eegGTzsPDwiqAaliPyJNYDQcbDJlttQKcbwhEb4CXHOw6fguCA
         Kv8Q==
X-Gm-Message-State: AC+VfDwuiAQkG4SmrnI4Ddl8QY/moRKHU4oji7YDAOpBcUBC+jvKNvVV
        k85xAI8dONtr2L+/HyQJrimhF4x3uQk=
X-Google-Smtp-Source: ACHHUZ5D9l/f822TJwgZXtvdbYj2OibKrZaBdWkSmagRNJshjhKkLRUFo4MRRpHVMc/cDGV13Wz3Sg==
X-Received: by 2002:a05:6214:29ca:b0:621:48be:bab5 with SMTP id gh10-20020a05621429ca00b0062148bebab5mr4553850qvb.8.1685507656913;
        Tue, 30 May 2023 21:34:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.102.40])
        by smtp.gmail.com with ESMTPSA id f16-20020a05621400d000b006262d158ab9sm1839901qvs.124.2023.05.30.21.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 21:34:16 -0700 (PDT)
Message-ID: <6476ce48.050a0220.c922f.7b68@mx.google.com>
Date:   Tue, 30 May 2023 21:34:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2004553520577161843=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v7] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230531034338.23121-1-quic_tjiang@quicinc.com>
References: <20230531034338.23121-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2004553520577161843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752537

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.02 seconds
CheckAllWarning               PASS      35.06 seconds
CheckSparse                   PASS      39.40 seconds
CheckSmatch                   PASS      110.86 seconds
BuildKernel32                 PASS      30.73 seconds
TestRunnerSetup               PASS      441.43 seconds
TestRunner_l2cap-tester       PASS      16.58 seconds
TestRunner_iso-tester         FAIL      22.28 seconds
TestRunner_bnep-tester        PASS      5.41 seconds
TestRunner_mgmt-tester        PASS      111.66 seconds
TestRunner_rfcomm-tester      PASS      8.64 seconds
TestRunner_sco-tester         PASS      7.99 seconds
TestRunner_ioctl-tester       PASS      9.25 seconds
TestRunner_mesh-tester        PASS      6.78 seconds
TestRunner_smp-tester         PASS      7.85 seconds
TestRunner_userchan-tester    PASS      5.64 seconds
IncrementalBuild              PASS      28.96 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 75 (93.8%), Failed: 5, Not Run: 0

Failed Test Cases
ISO AC 6(i) - Success                                Failed       0.216 seconds
ISO AC 7(i) - Success                                Failed       0.213 seconds
ISO AC 8(i) - Success                                Failed       0.215 seconds
ISO AC 9(i) - Success                                Failed       0.215 seconds
ISO AC 11(i) - Success                               Failed       0.219 seconds


---
Regards,
Linux Bluetooth


--===============2004553520577161843==--
