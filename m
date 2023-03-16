Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35028C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 01:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCPBSl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 21:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCPBSj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 21:18:39 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCDD5FA58
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:18:18 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id bp11so191009ilb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678929498;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=//xQ5WXhbr4hgnLJ7nPEcHxxSpL/e3fssu+toGgNxU8=;
        b=Ak7GCIGJvCt73qTKM9Lt/60B7GQogUgTlD2k8/xb9bMyOUWZcBPCuiManndS9E7N7C
         /j7qgA+0XCMaWoGo0z61A9kmpG+ve69HWLxUziF8e0Jf/TL2FJYGz35brE/OcN3CRMOk
         k7xXNtQLaoJJi8NQrzvsznsb6skwJpCSCPf1OUsGlVBg1QJfxmlDXLuyfq0TwrLVNbuf
         eZPbKeidJHCLf95hovwuJiN2LSUFyiuIhWV2H1WGwbmZXO3bkcIdoJaRabb+9g8bTu8y
         SAAMt8PYHIH7EKT3ShvqWK++rdxAZHXIV56cNrfscInqiVxR8xnUjKMeEDalCqzW74IZ
         85Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678929498;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//xQ5WXhbr4hgnLJ7nPEcHxxSpL/e3fssu+toGgNxU8=;
        b=QRA9HYN5hsER5KwJeXpt0ZwxA1At3PdrwE4E/xgAoE8jHG60KdADGAkN3V4q6HtCVp
         kOW9u64paTSbj6j08c71n/04REURSPOq5Q40vhKyVhkWoqDE6Lykd+XWCzpvgsdjzxry
         XUF12Dd614SSBmh2dpw8kjKfz1NfdgTdkxdAy0UcajYmNrjYCHwULotzVC27zjCfY04g
         BBsbx+OHyzVq/kykOy35C7Ggqs2iNJAiOxu49y0W5WXH/QODufb4eFpcRWbJB2lpbCHL
         r4zckxDslFl5CMtMQce5qaB8GIx+X6g4+HlQHc8R6FVSOKk1A0luN2zzskgfNUGQUIYA
         /Wvg==
X-Gm-Message-State: AO0yUKW6UrXSLUAGqhW2YZZylW4oYgN10FdXVKN1yLzbJ3Yi7gOE6trT
        s8ifdi0WwgSsBmw9Mll8UYfjyB/U/hGl4g==
X-Google-Smtp-Source: AK7set9yEwysboUZ4n89DbU0gRC70dbHGl18AwO0bB2xX7eFTEqS3bSws6/kwVa10Ea9Rd/I8MNaaw==
X-Received: by 2002:a92:c943:0:b0:317:994e:5988 with SMTP id i3-20020a92c943000000b00317994e5988mr5592523ilq.11.1678929497955;
        Wed, 15 Mar 2023 18:18:17 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.43.48])
        by smtp.gmail.com with ESMTPSA id y34-20020a029525000000b003b331f0bbdfsm296770jah.97.2023.03.15.18.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:18:17 -0700 (PDT)
Message-ID: <64126e59.020a0220.da5de.0d54@mx.google.com>
Date:   Wed, 15 Mar 2023 18:18:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1707891006620049230=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM
In-Reply-To: <20230316002559.32562-1-kiran.k@intel.com>
References: <20230316002559.32562-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1707891006620049230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730552

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
GitLint                       FAIL      0.87 seconds
SubjectPrefix                 FAIL      0.68 seconds
BuildKernel                   PASS      32.89 seconds
CheckAllWarning               PASS      35.15 seconds
CheckSparse                   PASS      40.32 seconds
CheckSmatch                   PASS      108.87 seconds
BuildKernel32                 PASS      31.38 seconds
TestRunnerSetup               PASS      451.42 seconds
TestRunner_l2cap-tester       PASS      17.34 seconds
TestRunner_iso-tester         PASS      17.89 seconds
TestRunner_bnep-tester        PASS      5.66 seconds
TestRunner_mgmt-tester        PASS      113.92 seconds
TestRunner_rfcomm-tester      PASS      9.12 seconds
TestRunner_sco-tester         PASS      8.46 seconds
TestRunner_ioctl-tester       PASS      9.87 seconds
TestRunner_mesh-tester        PASS      7.34 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      6.07 seconds
IncrementalBuild              PASS      35.80 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
25: B1 Line exceeds max length (94>80): "https://patchwork.kernel.org/project/bluetooth/patch/20230313151549.15791-1-kiran.k@intel.com/"
[v2,2/2] ACPI: utils: acpi_evaluate_dsm_typed - fix redefinition error

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (81>80): "../include/acpi/acpi_bus.h:57:1: error: redefinition of 'acpi_evaluate_dsm_typed'"
25: B1 Line exceeds max length (94>80): "https://patchwork.kernel.org/project/bluetooth/patch/20230313151549.15791-1-kiran.k@intel.com/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1707891006620049230==--
