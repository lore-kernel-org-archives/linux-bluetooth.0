Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02A2C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 15:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBYPcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Feb 2023 10:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBYPcH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Feb 2023 10:32:07 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D185B126E7
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 07:32:05 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l18so1365080qtp.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 07:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677339125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WqjTEN3a7SbWGz2QrZ92ZQpWz/b2dByfa6+u5+tt1UY=;
        b=O3C1JL8DPeQTyngEmEVjPtLBKAmsuzowcjNB5vDKn/xvXxcptx/3XKsF+lN4HCBAOw
         NDTCStfZhYYSR6QWN8Fwc9AC8H4f8keZ1s3x6w7p9VA5NzNQLPbK6uaKmip8npGfLgzj
         zc9j4CzZQrKFOQENPGqvPdUV+jbOdSJxbz3SMp77hDGPXgZo6GKtRsdahC2BFHiVnmKM
         I7JwpJLAwRS/9zWiaPsOkKHGTtgwZf2OBxEfrMugWmI2ClyN+/fSMWGp4fZF6vCLLlh0
         fO85Xt6/oz1KrelLmdby09TAm9GpDSMuCgdbof8MpQnMhH/iu0XwEd/4SKuDIcar6PRk
         YKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677339125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqjTEN3a7SbWGz2QrZ92ZQpWz/b2dByfa6+u5+tt1UY=;
        b=lCr4TLL+tchQes9a281gmOgqM1BFww9HLQI7AzAPWa49XjHbX3eFhJL4OFT+K1TZZg
         KKzUgTutivGtB2LqD9tJ+CQ4pZSkZKlmgur50Pek+MncoXWE7Qb+t2iw7qwTVNYwG8EW
         c/wpvI3ExwhoROpUQMPZF8z9fSeC0L+9+gSU6dhhI5VayZhrtwgzGhDJDMMHddHXPDoT
         suPUFL23ga0B/OghWYQtL4dRgzAeBAgNzd7eWSTxec6EjmdNfNfmaHW+VPoAfzsW+PhH
         5wFmUN4Mb5EWh6gXAUqkLOhZF4rMtkLsrNL9ZQCj1bmsU8tfOpWNycLwVF5hqsRF5yUs
         qt+g==
X-Gm-Message-State: AO0yUKWSIZA0NOiH0CzfrVWptoXZn8E+S+e1qLjSUzSOb8XODOotNzxi
        UV8+QuzYbuC3eCkf0cM38lx2jfMt0S8=
X-Google-Smtp-Source: AK7set8zNSr9I5/UP/eqLt4gqdofF9EUMFEzcLx4++8KwwPU2aG2D4xKuwE4ttQnt+w2YfsHhzZXqQ==
X-Received: by 2002:ac8:5b85:0:b0:3b9:bc8c:c1fb with SMTP id a5-20020ac85b85000000b003b9bc8cc1fbmr6251911qta.6.1677339124810;
        Sat, 25 Feb 2023 07:32:04 -0800 (PST)
Received: from [172.17.0.2] ([172.177.134.85])
        by smtp.gmail.com with ESMTPSA id o6-20020a375a06000000b007429961e15csm106176qkb.118.2023.02.25.07.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:32:04 -0800 (PST)
Message-ID: <63fa29f4.370a0220.4d3ab.0552@mx.google.com>
Date:   Sat, 25 Feb 2023 07:32:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4421157636087448141=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the bcm_broken_irq_dmi_table
In-Reply-To: <20230225143900.47158-1-hdegoede@redhat.com>
References: <20230225143900.47158-1-hdegoede@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4421157636087448141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724856

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.09 seconds
CheckAllWarning               PASS      33.97 seconds
CheckSparse                   PASS      38.40 seconds
CheckSmatch                   PASS      106.90 seconds
BuildKernel32                 PASS      29.86 seconds
TestRunnerSetup               PASS      432.67 seconds
TestRunner_l2cap-tester       PASS      15.92 seconds
TestRunner_iso-tester         PASS      16.21 seconds
TestRunner_bnep-tester        PASS      5.33 seconds
TestRunner_mgmt-tester        PASS      106.81 seconds
TestRunner_rfcomm-tester      PASS      8.55 seconds
TestRunner_sco-tester         PASS      7.85 seconds
TestRunner_ioctl-tester       PASS      9.09 seconds
TestRunner_mesh-tester        PASS      6.76 seconds
TestRunner_smp-tester         PASS      7.74 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      27.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the bcm_broken_irq_dmi_table

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the bcm_broken_irq_dmi_table"


---
Regards,
Linux Bluetooth


--===============4421157636087448141==--
