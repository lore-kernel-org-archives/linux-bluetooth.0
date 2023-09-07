Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE388EC8744
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 16:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjIGQpW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjIGQpW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 12:45:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B527019B4
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 09:44:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c06f6f98c0so9496245ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694105026; x=1694709826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+sW3iY2B1oTfusLtwcZHdFiD5ITxNQ60KJ+0NqIKv64=;
        b=g3BV7ay8Q4w9PlDoaTVB8+UAKDqFTGmJTIawhNPEkpMywh2BVaDzXNgegi00XLtSyN
         4thPNXzaKQJ6mOnrhJbySl32fq4hQ5dZ2JwEZ5BciU262Znj7jS2GumDZlIkK/jxAL1o
         lqU1fVB7vbsFaoz725RzZjQBcyQ9DHpiciK5T7HYKSfz9cqGXOyF2Ka2HEIwyjtIqQFd
         xtWDLICVf5LJXJQ9sfJDhYkt9ftZVOsgmyaTloOrm9zQILjRJnz0uX0kJGUrDpYwTTKq
         SRrDhd0aiDEuRuCrrWD0cM7rftLFR53LQmbMo6mNyZzHaUZa+RsYzfEkrzMVRVCvkNca
         2HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105026; x=1694709826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sW3iY2B1oTfusLtwcZHdFiD5ITxNQ60KJ+0NqIKv64=;
        b=T8zwV2hcPfeiYRJsveILC6DLyfKnVgh347nVTYcl3THKK0WPMn+5nH0cKQxIpc5T9a
         JTQJpsptnItbOsAz83Bi9SXJbQeC/X6TstnCHeqQcXUmOg7zEjuL71lP1IW5UZAp2mG7
         wln7FE5hmLBZ+2fyjvd0+Qoo4F5a1Omyixvzt0O7xRBVbpwYbvzjZnWyz0S0vS88eCSr
         5prciMmFEX4cOg90rzMzNYWFym3LPZQ4EKlSc47kHTbvAkNHCG7DTfIqX46e9nF0OCR/
         yHxIzgVlf/3K6hNQ/DVePcqHcZ46AU9sABGWYZO5+b6qkWjVvRc0cpMvwel0XkUNoSD0
         zDGQ==
X-Gm-Message-State: AOJu0Yzoxv6++YvcO0V+6XJikWFdjdDd+NBq7hz4imhd2zFz0/4WFi9h
        FCaIsybA4pfFjwXzOeEXd4/2+nRmadg=
X-Google-Smtp-Source: AGHT+IFpV32qjEL+KU1v7v0b15yz6hRfRisLcrTUqwCRwixMhkjVxXXMivcZ5aoA56LQDarveb3G/g==
X-Received: by 2002:a17:902:c215:b0:1b5:64a4:be8b with SMTP id 21-20020a170902c21500b001b564a4be8bmr106909pll.35.1694105025630;
        Thu, 07 Sep 2023 09:43:45 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.100.245])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b001bdc8a5e96csm13005619plr.169.2023.09.07.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:43:45 -0700 (PDT)
Message-ID: <64f9fdc1.170a0220.e5c40.c6bb@mx.google.com>
Date:   Thu, 07 Sep 2023 09:43:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6120289090394514550=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
In-Reply-To: <20230907054758.4893-2-claudia.rosu@nxp.com>
References: <20230907054758.4893-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6120289090394514550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782236

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      40.30 seconds
CheckAllWarning               PASS      43.47 seconds
CheckSparse                   WARNING   50.52 seconds
CheckSmatch                   PASS      133.85 seconds
BuildKernel32                 PASS      38.35 seconds
TestRunnerSetup               PASS      584.14 seconds
TestRunner_l2cap-tester       PASS      32.80 seconds
TestRunner_iso-tester         PASS      69.82 seconds
TestRunner_bnep-tester        PASS      13.16 seconds
TestRunner_mgmt-tester        FAIL      253.41 seconds
TestRunner_rfcomm-tester      PASS      19.74 seconds
TestRunner_sco-tester         PASS      23.27 seconds
TestRunner_ioctl-tester       PASS      22.30 seconds
TestRunner_mesh-tester        PASS      16.38 seconds
TestRunner_smp-tester         PASS      17.75 seconds
TestRunner_userchan-tester    PASS      13.95 seconds
IncrementalBuild              PASS      36.29 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/iso.c:1466:18: warning: dereference of noderef expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.901 seconds


---
Regards,
Linux Bluetooth


--===============6120289090394514550==--
