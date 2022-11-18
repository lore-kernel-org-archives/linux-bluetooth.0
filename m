Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE06C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 09:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiKRJde (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbiKRJdb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 04:33:31 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2DBED
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:33:25 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-14263779059so4506901fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/YJGzMMEvaLrs+rNIOoRQAGCjIJ/HDZIG4GUpgVfzQs=;
        b=ff1M2M1axSeDwJsRqsIjSLDEepO8oobQThF4GLzsFFUipSS0poiZskeA0ZFiuDkgQH
         nrZBx8QrftDwuVZBsQZeQYv4kWbZIngH4LHIc+E4a9YNcFuWqlmAMWaS0gQ//S7LBxPJ
         NR2wCK3ckTHRKenaLcsXuMySq8fiAzj6uMe58pco2BEP8JUZMK/2uQEpNp8XEqrgNpcC
         +BLWhDSxwS3eNoW64dc+9a8gLr0HmkHpXfDTMzbLW22bB8WqW+mvxna7gZx9dnGbRB1G
         uHidzrfaLM9RTPokKHFJzhK3ie2Fo7Vt00MXAdXamiYOkenanJ81408CW2UgV3GdeMbO
         4n7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YJGzMMEvaLrs+rNIOoRQAGCjIJ/HDZIG4GUpgVfzQs=;
        b=2C87buCZQ+wNmDny9QcyVj3qLm0jQdhx1PIcKFeLc2rdaRAugRv7Wb+M6ZV8fhsNkN
         UiAwWk/s8oREE8yHfmaeDl0V+s3Eu5LC0WI7pDIkkgh/ZqN1ZQwlZZbn6qzSueiE9Nb8
         S7A99stJR8DZY2m/RtUgaQ70lj+rU30fKSIgOjcovHds8mP+nuFQRwVYo61cWOxdFXnC
         2VhvvjcC3BH8PMSSBMV6DVFM74A5eqMv+3uY4Llnw5EXBMnjhNVBFbQcEUw+SZ0oE1bw
         +lokwSfKYqAGoa8d4VPW+wrrUJyBBt6IbiV2ezhFOMvpBTyhjneJFZr8LDi1EfKUT3B8
         k5jA==
X-Gm-Message-State: ANoB5pkxNY0iRLmtSqIU+1iMUQX69xDmV9FOOhqoGxGTwrpMCNx7EJTP
        rD+OUE6QPqh/eOMgTY543GVxWI7tLhVFrg==
X-Google-Smtp-Source: AA0mqf6IC5HSKEEyDF13V2LfJYomHq3Dk33sBOuDZ5CL11H5/wMUQ0KK3f0Q+FvBxSPSRqsrpX1JOw==
X-Received: by 2002:a05:6870:5898:b0:13b:d07f:f28f with SMTP id be24-20020a056870589800b0013bd07ff28fmr6757377oab.41.1668764004459;
        Fri, 18 Nov 2022 01:33:24 -0800 (PST)
Received: from [172.17.0.2] ([20.225.226.136])
        by smtp.gmail.com with ESMTPSA id s27-20020a056870ea9b00b001422f9b5c17sm1702011oap.8.2022.11.18.01.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:33:24 -0800 (PST)
Message-ID: <63775164.050a0220.fbc9e.7338@mx.google.com>
Date:   Fri, 18 Nov 2022 01:33:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3669560846697165537=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3669560846697165537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      37.80 seconds
BuildKernel32                 PASS      34.42 seconds
TestRunnerSetup               PASS      486.85 seconds
TestRunner_l2cap-tester       PASS      17.55 seconds
TestRunner_iso-tester         PASS      17.63 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        PASS      119.71 seconds
TestRunner_rfcomm-tester      PASS      10.69 seconds
TestRunner_sco-tester         PASS      9.98 seconds
TestRunner_ioctl-tester       PASS      11.53 seconds
TestRunner_mesh-tester        PASS      7.91 seconds
TestRunner_smp-tester         PASS      9.71 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PASS      36.96 seconds



---
Regards,
Linux Bluetooth


--===============3669560846697165537==--
