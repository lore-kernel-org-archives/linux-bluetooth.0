Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDFBC3DA7D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Jan 2023 11:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjACL53 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Jan 2023 06:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjACL52 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Jan 2023 06:57:28 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79FDFE0
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 03:57:27 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v14so21569474qtq.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jan 2023 03:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nqe9hxxPfBADt7BddV4osN2qTM1tFIOk09a/o5SMRXk=;
        b=dZVu5uL4/yyWHK46kAf7XMEQzxVIWSmsGh7OHGn51bzBjKH9prTyCYSovuttd1NAbK
         383iMigHUI8KCaoS5BtsmJM0FHfCuI+iyzP3AYNodOu04NQwY0fDoyBC9LpNoA2/agAo
         u5dURaoH3N+G8SYzzDI9MzWlGbF2C6KBj2qRmTyvqvBWoa0Q9iHXYr9JDLOOkyO/3Hi4
         dtjzCf/15Co2k+nEVzHHXzQ3QP2zfFTe30zc42QgAObhukCW14gqHWCUzyLHyTzONdFX
         NrdIttQE/yu3OZ/dhteMedMWsD1hCCPxvzhi5ZHFQeGltvyWbWdZc2yd/H63xSYXW2eC
         R/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqe9hxxPfBADt7BddV4osN2qTM1tFIOk09a/o5SMRXk=;
        b=B1k+2Y9DIxzsbVtHP98Lq3YtMuP/g52+RSpD72pYgD/h5Kk97CabFapf+Ibf7pDSeU
         7e+HWgzWqdZ0Cb9uvOi0AyTrRgvVYqcVFokv3AEHtQfPVz7G7BaAOjBLGGv5Dzlf6VDj
         i32Nbz2b5OgW2BefVR6Wur33IwBvOaB72EbqWM8uFHCc+Y83zQQ1Qhjy52caqiHAPkig
         aJcNPtcBEZViN2ySC2hRxYjdnp2sWCZtNCyRPUbHnyvwC5a5oE1Y3qlAynk3UfvnCIKJ
         vA6kcNYQbnmSy2z31/P63dWNRlLMyU93KlSYHmL2OBxoj/w+y/uy8++SGfr8Vchciudo
         znBg==
X-Gm-Message-State: AFqh2krZDdUZsEJoGxwEdIK1aTK259w3MgeFraTptJKL/wcb5ahf34ML
        guF6+27d47CluEQp9X4pLHVZOzxaH/r9mA==
X-Google-Smtp-Source: AMrXdXtfienPy3uljmfXNMVR+bQJoD5OuDST0ILN2iCFG5LPtQT5GIeVvScaD8l5UCzWFpFc9nkdkw==
X-Received: by 2002:a05:622a:4a8b:b0:3a8:1617:bdac with SMTP id fw11-20020a05622a4a8b00b003a81617bdacmr66708810qtb.5.1672747046382;
        Tue, 03 Jan 2023 03:57:26 -0800 (PST)
Received: from [172.17.0.2] ([52.190.14.161])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006fca1691425sm6791759qkp.63.2023.01.03.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 03:57:26 -0800 (PST)
Message-ID: <63b41826.050a0220.85dd0.ec50@mx.google.com>
Date:   Tue, 03 Jan 2023 03:57:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1042859050869647914=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: Fix possible deadlock in rfcomm_sk_state_change
In-Reply-To: <20230103111221.1.I1f29bb547a03e9adfe2e6754212f9d14a2e39c4b@changeid>
References: <20230103111221.1.I1f29bb547a03e9adfe2e6754212f9d14a2e39c4b@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1042859050869647914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=708446

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.20 seconds
CheckAllWarning               PASS      35.40 seconds
CheckSparse                   PASS      39.71 seconds
CheckSmatch                   PASS      107.33 seconds
BuildKernel32                 PASS      31.11 seconds
TestRunnerSetup               PASS      444.66 seconds
TestRunner_l2cap-tester       PASS      16.80 seconds
TestRunner_iso-tester         PASS      17.33 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        PASS      111.28 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      8.50 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        PASS      7.76 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.09 seconds
IncrementalBuild              PASS      29.61 seconds



---
Regards,
Linux Bluetooth


--===============1042859050869647914==--
