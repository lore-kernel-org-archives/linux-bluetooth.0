Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B80C4321E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 21:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiK2Vph (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 16:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiK2Vpe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 16:45:34 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF296C709
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 13:45:32 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-14279410bf4so18755678fac.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iOgz9nlp6tPyqhBzJDsA3av9f9WYHYXpgnu87VcboZ0=;
        b=aDxG9xWf85CCoKp8cROf8gJ0lX4SIgXR8E077EOriFjmE9pXLmy4zsMvqIsVJfd7y1
         rP9DcDn7wUMkNXQObQ8huoF3NxOBs6JJD2H0LSrz6d6En6r+T3PEi5aV79SVEtzgyeAR
         99UIYUc6x8sG007t7VCkahni91dfGyhsjG9l2n/6uZ2wDeeCAe1/grwBqdDJUefbYha2
         w2WSwyBAADNgCUmyfv79Cb+EdVf8wvzEmPy7wfjLi5Ev8Kr/QhEdP9ojvRck7A2aP7lV
         WFR2xS5F+uSGgqoR5eX97U3JXYcNGOAYp1UunRG+OGepGqZlwq51E22D19zZEW15yJsb
         nicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOgz9nlp6tPyqhBzJDsA3av9f9WYHYXpgnu87VcboZ0=;
        b=Nllied7euYYslvhD5/6xykdgzb3Zhb0VAdFgUXVxqIageWeEnTNpGVExBs+DiD0D+F
         vThDmwDI9nMPhov0rD9xSBxi7C/rcb8dVbbbv7rPpIybHKYA/GL3aOkZ4Ly04KMVRNSi
         rX5ncL8iag7oYi6nnQUH74O1lVkUIR1WXrjeNTdpirNXHcdhtYDd0gyt3x7wwoxkZf1M
         H/ur+iHpl44z04XBKGowS3Ifdk2tkTl92mUyh94VbKuMvFlV63wzof3jWtpL/m1Usp4u
         AA2y28L8mcdZsSU/SRe+zbdqhiri2pxfbb6/hIZC307qcy2ZNYvxvFExBt80EdA04utv
         uyMA==
X-Gm-Message-State: ANoB5pm4oaOV8dSoz33oN0tkUNMFUmcJFaDxU3mgQMZF2ZYDcr0nUFiZ
        FdkraqSEDCTVw6FwqPXaU8V+jfwFyQg=
X-Google-Smtp-Source: AA0mqf7f9JIlZIRbvwhl7MHRyUapch9jnCF045aV44ibc0tmo9Id08QMRTnt0Bbwx4R2fXkM64SkCw==
X-Received: by 2002:a05:6870:e90:b0:143:edc:c354 with SMTP id mm16-20020a0568700e9000b001430edcc354mr22025989oab.276.1669758332175;
        Tue, 29 Nov 2022 13:45:32 -0800 (PST)
Received: from [172.17.0.2] ([40.84.227.182])
        by smtp.gmail.com with ESMTPSA id a7-20020a056808098700b003509cc4ad4esm6021188oic.39.2022.11.29.13.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:45:31 -0800 (PST)
Message-ID: <63867d7b.050a0220.7f60a.74a3@mx.google.com>
Date:   Tue, 29 Nov 2022 13:45:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0445351776086465774=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fix crash when replugging CSR fake controllers
In-Reply-To: <20221129205413.1537851-1-luiz.dentz@gmail.com>
References: <20221129205413.1537851-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0445351776086465774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700236

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      43.46 seconds
BuildKernel32                 PASS      39.22 seconds
TestRunnerSetup               PASS      542.86 seconds
TestRunner_l2cap-tester       PASS      18.75 seconds
TestRunner_iso-tester         PASS      19.38 seconds
TestRunner_bnep-tester        PASS      6.76 seconds
TestRunner_mgmt-tester        PASS      128.18 seconds
TestRunner_rfcomm-tester      PASS      11.48 seconds
TestRunner_sco-tester         PASS      10.40 seconds
TestRunner_ioctl-tester       PASS      12.38 seconds
TestRunner_mesh-tester        PASS      8.84 seconds
TestRunner_smp-tester         PASS      10.18 seconds
TestRunner_userchan-tester    PASS      7.07 seconds
IncrementalBuild              PASS      39.71 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix crash when replugging CSR fake controllers

11: B1 Line exceeds max length (97>80): "[   71.986130]  hci_register_dev+0x316/0x3d0 [bluetooth 99b5497ea3d09708fa1366c1dc03288bf3cca8da]"
12: B1 Line exceeds max length (88>80): "[   71.986154]  btusb_probe+0x979/0xd85 [btusb e1e0605a4f4c01984a4b9c8ac58c3666ae287477]"


---
Regards,
Linux Bluetooth


--===============0445351776086465774==--
