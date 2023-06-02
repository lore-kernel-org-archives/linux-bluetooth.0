Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA4C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 08:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjFBI6k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjFBI60 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 04:58:26 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C123E41
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 01:58:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33b5dba8c6cso6078655ab.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Jun 2023 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685696304; x=1688288304;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wVZQ7BJyl7E182Wg5I//4XW0U0UWZ4YIglPySOO3hgI=;
        b=FNBiZ3X5mdOQe/L7l8xZ9BzVNvyCv9+0n5cIan2WZnoEZUzfNnc46lj7Wz7xojSECi
         C1pT1r8y+aEsClCiv+h+D5To95dj/FTR0FMx44Btr1yVwkxn1IZ13nnbhGNei3l5Hz01
         XOJuTqkhujBYMAjIRzWxu3DbBgxtatKJLRk5ANyiFYreogDWx1D780ziIk5A1akVtKlK
         i6OcnWeJMQnG1guNPqmch8yUOHHmXABbPiQvUpM4Q/sQQ6F7b2Ejnf49lFia0K7fS4c7
         lN0JcSFkf05DT5YABEl72mySxCAynEfXg5+3p+2l6iaKkJlbOvUjynBTKu5ZW6UlE0Y3
         a5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696304; x=1688288304;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVZQ7BJyl7E182Wg5I//4XW0U0UWZ4YIglPySOO3hgI=;
        b=UfNWtkDdffSh6Jbvn/A5a4fR3jRtg0uNIO/BXTHAlH6JB/qm1/mPp9ocVBUYTIfIiS
         1QXFsnaf1Csg3s/AcSBZ29sPj/SreZrUys4oB/6w76LKil50zjPYYd3HC5lmNyK5plhC
         kZkUMF+BeLKEHe0sUH3Gs/WyVMWBWJZI3JOe7gn62scP+iNRkWubwJWdaF3i4sy0EWbG
         rsjUDFsHP1r3KZgVA/fXauUM7TDqIIsrurDseMoFyNzqK16vCj2ztV+SydUl0Ds5sXwu
         g0UqdJCxU9N8zeovObL1K9R2kNhsM0PmiuPJOE5v0gtykH8PZ9lYNP3wldhLUYAm/R+2
         xDDA==
X-Gm-Message-State: AC+VfDyhDdatAT5qVtq2JYQkFSc16nTOrtpWsJZeOmv+hke9SLmDWRe2
        Pp8RXNPSnvlH02aNeJwLwZhl6HB2q8o=
X-Google-Smtp-Source: ACHHUZ7ITDyMpOc1K0XowDihtu5BGjgtdALa+zItnjTnIHNRwbAp8/o0KSszdk/Y0S89mDH1kByIVw==
X-Received: by 2002:a92:290d:0:b0:33b:363d:27eb with SMTP id l13-20020a92290d000000b0033b363d27ebmr5792684ilg.30.1685696304622;
        Fri, 02 Jun 2023 01:58:24 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.123.120])
        by smtp.gmail.com with ESMTPSA id q9-20020a02c8c9000000b004168689e2e9sm161799jao.57.2023.06.02.01.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:58:24 -0700 (PDT)
Message-ID: <6479af30.020a0220.df0c6.02f4@mx.google.com>
Date:   Fri, 02 Jun 2023 01:58:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6107745550358695770=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: hci_bcm: do not mark valid bd_addr as invalid
In-Reply-To: <20230602081912.4708-1-johan+linaro@kernel.org>
References: <20230602081912.4708-1-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6107745550358695770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=753409

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      34.01 seconds
CheckAllWarning               PASS      36.62 seconds
CheckSparse                   PASS      42.25 seconds
CheckSmatch                   PASS      113.68 seconds
BuildKernel32                 PASS      33.90 seconds
TestRunnerSetup               PASS      474.42 seconds
TestRunner_l2cap-tester       PASS      17.53 seconds
TestRunner_iso-tester         FAIL      24.51 seconds
TestRunner_bnep-tester        PASS      5.85 seconds
TestRunner_mgmt-tester        PASS      119.90 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      8.66 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        PASS      7.43 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PASS      32.26 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_bcm: do not mark valid bd_addr as invalid

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B1 Line exceeds max length (83>80): "Link: https://lore.kernel.org/lkml/ecef83c8-497f-4011-607b-a63c24764867@samsung.com"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 75 (93.8%), Failed: 5, Not Run: 0

Failed Test Cases
ISO AC 6(i) - Success                                Failed       0.238 seconds
ISO AC 7(i) - Success                                Failed       0.234 seconds
ISO AC 8(i) - Success                                Failed       0.232 seconds
ISO AC 9(i) - Success                                Failed       0.235 seconds
ISO AC 11(i) - Success                               Failed       0.243 seconds


---
Regards,
Linux Bluetooth


--===============6107745550358695770==--
