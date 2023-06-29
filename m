Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DFEEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 10:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjF2KfK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjF2KfE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 06:35:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF348E4B
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 03:35:02 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b75637076eso445984a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688034902; x=1690626902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qiGD7I8f83FNzqQzuJb0Uq+P4Nx7LZsglvJqQxb+OnM=;
        b=eB+4m4nS83y1T0lQtT8E7Qs3AbMrBFoNoCnO/Rnfe6pY4v2P3+nzaSz1zN+tIyhiff
         ruACFWA2DfIBRMrG1SFBF6nXYeqEjuTHG6p6YOYjhDnXt/ioFriiWZM9YJsFn/X5DPZa
         qXLUB3Z7OOqQgu/Qcd+oyZDqOFB7rP9BenVqL/7LXiq4ETxENAaXb7tHXOY4CM2XwIlL
         vLtWVfHW1jesCBNQgmRIVbnFXKGQMx57H2yTam1uR85c+O3ctYYHZUSspT7mQOLGkHKO
         hQi8ubl4o02IVcDSYDXSyx4I19JLsbEfGOVk4o091rm6wNbRCAuVUmQvIPqG5T4zt8R3
         MlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688034902; x=1690626902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiGD7I8f83FNzqQzuJb0Uq+P4Nx7LZsglvJqQxb+OnM=;
        b=Bl+LUcP4weyDIYBZx/x6JDv9TwR1+weOGbuExemM6WM9IypoOQenW/nyLISOsEA2iw
         yziNtaTjQEhC51bxZyWJba/8f6EUbrzju+x6GerJjh7eA5WzJ178KX/nhJs72N0OyvTu
         DqfOxV9zpXFhgsdHu9yqiHAGr/2gkYDwS+nE/oRsRhcj9STo11GE0XyVO4ao3Pm6PjEM
         jRKZjuKOB2XuyXHb1Fqxc5BW4f6tlyiDyws9wIYhMuoT7n4bwLoq21oMbeuM1rzl4J+5
         fp1vpuU5XU5RFL/BNo4M+MgGW5QIWyU6/UsyUtOmyoQAuOl1YR3pzjVU3hpUpQyqMtQa
         kQ6g==
X-Gm-Message-State: AC+VfDyWI3Y9XAwgLqr6RU3zGCBKOLBG1+j+kHKDl4+Ljmf9Th2sQT6R
        Cg11Vlo+/c+8Utwz0yKmDLnZfXxMBgo=
X-Google-Smtp-Source: ACHHUZ5vGMaHkB66iD3qceagWRyxvPwzff84WycW+vsmvvMEz5832YUkEdpYtiy3lQvLVyCPzjtImw==
X-Received: by 2002:a05:6830:10ca:b0:6b8:85c0:1b9a with SMTP id z10-20020a05683010ca00b006b885c01b9amr2979546oto.9.1688034901854;
        Thu, 29 Jun 2023 03:35:01 -0700 (PDT)
Received: from [172.17.0.2] ([65.52.35.21])
        by smtp.gmail.com with ESMTPSA id j4-20020a9d7684000000b006b725dea64asm5438294otl.63.2023.06.29.03.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:35:01 -0700 (PDT)
Message-ID: <649d5e55.9d0a0220.90ea7.b4ff@mx.google.com>
Date:   Thu, 29 Jun 2023 03:35:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7332109861848940861=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: hci_sync: Enable events for BIS capable device
In-Reply-To: <20230629094120.5463-2-claudia.rosu@nxp.com>
References: <20230629094120.5463-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7332109861848940861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761184

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      32.47 seconds
CheckAllWarning               PASS      35.28 seconds
CheckSparse                   PASS      39.76 seconds
CheckSmatch                   PASS      112.05 seconds
BuildKernel32                 PASS      31.27 seconds
TestRunnerSetup               PASS      448.16 seconds
TestRunner_l2cap-tester       PASS      17.05 seconds
TestRunner_iso-tester         PASS      22.63 seconds
TestRunner_bnep-tester        PASS      5.48 seconds
TestRunner_mgmt-tester        PASS      128.48 seconds
TestRunner_rfcomm-tester      PASS      8.72 seconds
TestRunner_sco-tester         PASS      8.02 seconds
TestRunner_ioctl-tester       PASS      9.23 seconds
TestRunner_mesh-tester        PASS      6.89 seconds
TestRunner_smp-tester         PASS      8.01 seconds
TestRunner_userchan-tester    PASS      5.75 seconds
IncrementalBuild              PASS      29.93 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/1] Bluetooth: hci_sync: Enable events for BIS capable devices
WARNING: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 0 checks, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13296835.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7332109861848940861==--
