Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5DFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 19:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiKST3h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 14:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKST3f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 14:29:35 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC613D2B
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 11:29:32 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a7-20020a056830008700b0066c82848060so5097641oto.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 11:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wHyyYELpoNZxwBCn+EEpw/J5fz3y/7GtFHlU/P1fM9M=;
        b=AjoLSAtGBdKosqDVsomDEjMvVXin87OsSsXTb2zCZn9VYr3mloYvx44iKz9eNnnx23
         pB/6LXXQovRVBTpleHEK+EkT7tN/++RoVMa4tOHauKdPqS1FR9v+eTcfZqf8B7jQP/bI
         VPRkL/g2dqfz7eZ6UzLnW+eqjtYpb/DtFCcpg38U5RyxOqVcZS+SkvjnZnlsLDin420y
         4fx651J/tz991OuYY3k4IAo/Zl3MTupRhrD2KAHorgXLecB/tam3Pv/X74DuUtSUuEV/
         CUk8xhHd3s8JIMdb4OszLNnCDr17mEW59ubpDIRsY0lW+sDrQK5gVu0ql0MKYVNz4h8x
         tc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHyyYELpoNZxwBCn+EEpw/J5fz3y/7GtFHlU/P1fM9M=;
        b=VCjKIzeEQ7Bv8geR9p5xotMDkQmhcpX0tQWGiJbPXbbXG78varfETRGl93Cq0+ZI3m
         acfJBhj1T88gt2l3IQVuDme6nLYE9cDGjVauHp0vTk+byLTOQYVsOB2h23bhPwj+z/kb
         /08Yycsbcdmpq2Re6oRw0/yrGeCLG3XuE2c1J1GPha7b+1ZRPeiuiDTEIC0eRo2mqJnx
         lx1pp6tpkEggLT5La8Ryvet2A78Qc1jySRRNT0+Vzg/k5zOG8Ai0dMqrDpmToMCp4UMA
         8tjmMt6JS9eWWC3utDTknHEshigESyIXVa9GmRX35EbU8KXfpMcp8aGCdVqFzc2l3nur
         /f4A==
X-Gm-Message-State: ANoB5pl8H/GDEVjbTJMJwJaaP2b+iWtVzgwKZagRG5R4LkibCBIJEbio
        X1ViNV36CYvqCMtkrjZy+BoRrYZbR2GdEg==
X-Google-Smtp-Source: AA0mqf5+deCPSv8aHvMBxEQx/rxUE8KL4Q9PPqW6wZ9rP+zPMueG6KAHGl2bDl7EiVed/pz+mCcgYg==
X-Received: by 2002:a05:6830:208f:b0:667:cdec:4c9c with SMTP id y15-20020a056830208f00b00667cdec4c9cmr6483008otq.349.1668886171272;
        Sat, 19 Nov 2022 11:29:31 -0800 (PST)
Received: from [172.17.0.2] ([20.165.68.136])
        by smtp.gmail.com with ESMTPSA id y18-20020a4a6252000000b0049b17794d19sm2674320oog.20.2022.11.19.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 11:29:30 -0800 (PST)
Message-ID: <63792e9a.4a0a0220.5f0d.b27f@mx.google.com>
Date:   Sat, 19 Nov 2022 11:29:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0622173397150502624=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, MihirKhatri@proton.me
Subject: RE: Bluetooth: btusb HCI_QUIRK_NO_SUSPEND_NOTIFIER causes kernel panic on CSR 5.0 clones
In-Reply-To: <ehYYBNwlU_5Z9W9Wzl5scfuMSmrs_K_s9vKb0M7nVP5JPgTDJB1q1rrnPCoXbxtirqiG5jy98alelPr2zWh_0BsZDpMLEiMOPfUbwAZ_pWg=@proton.me>
References: <ehYYBNwlU_5Z9W9Wzl5scfuMSmrs_K_s9vKb0M7nVP5JPgTDJB1q1rrnPCoXbxtirqiG5jy98alelPr2zWh_0BsZDpMLEiMOPfUbwAZ_pWg=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0622173397150502624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697285

---Test result---

Test Summary:
CheckPatch                    FAIL      0.82 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      37.11 seconds
BuildKernel32                 PASS      34.17 seconds
TestRunnerSetup               PASS      456.41 seconds
TestRunner_l2cap-tester       PASS      17.58 seconds
TestRunner_iso-tester         PASS      18.12 seconds
TestRunner_bnep-tester        PASS      5.96 seconds
TestRunner_mgmt-tester        PASS      112.39 seconds
TestRunner_rfcomm-tester      PASS      9.83 seconds
TestRunner_sco-tester         PASS      9.26 seconds
TestRunner_ioctl-tester       PASS      10.61 seconds
TestRunner_mesh-tester        PASS      7.26 seconds
TestRunner_smp-tester         PASS      8.97 seconds
TestRunner_userchan-tester    PASS      6.22 seconds
IncrementalBuild              PASS      33.32 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb HCI_QUIRK_NO_SUSPEND_NOTIFIER causes kernel panic on CSR 5.0 clones
ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13049772.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb HCI_QUIRK_NO_SUSPEND_NOTIFIER causes kernel panic on CSR 5.0 clones

1: T1 Title exceeds max length (84>80): "Bluetooth: btusb HCI_QUIRK_NO_SUSPEND_NOTIFIER causes kernel panic on CSR 5.0 clones"
4: B2 Line has trailing whitespace: "on some fake CSR 5.0 clones can them to get "
6: B2 Line has trailing whitespace: "the bit HCI_QUICK_NO_SUSPEND_NOTIFIER everything works fine "


---
Regards,
Linux Bluetooth


--===============0622173397150502624==--
