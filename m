Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC94ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Oct 2022 00:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiJ1AMX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Oct 2022 20:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiJ1AMV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Oct 2022 20:12:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884623FA0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 17:12:20 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o2so2465042qkk.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 17:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IONdietJPsIAj1V3w1iPti68NvpsI1UX4YWJpbc+fDc=;
        b=PKRCwR3ZJ4jVz6CjlWIV2jqjt0yKIvbpJko/7pjAa17XQwj1L2jmxjQiyMRVrTGypr
         fH1wh8UBcHplju9ucqxH+Swj7/F890kFFnO/5cQYyM8zRyZ9B+VdE7gtV8GaBvVDwy7k
         AdtQiUzCXnYTrdRSvB6mWC2EZKDj1FYG3leE9WfwY2n887S5+ZzR9+2o4E+ROtQIfFZc
         WL/pX8F2/rMxeBzAQ0o1Nqj2j0meozH16UocINYW91mkr/qjg/Ldm8GeLuUZoZggudNE
         ARkftz03xA/NKDVGIH7uxX5x9G42u7sPo4+WYYsZK7ZiwIe9n8hEtnZRgDEy709ccpOU
         Y9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IONdietJPsIAj1V3w1iPti68NvpsI1UX4YWJpbc+fDc=;
        b=6C5oPuBu6oHSFP82PdYvuJM59Pz2bYktEkl19HuUcjNTOXO2S1l+fP2jptTBVJvYzM
         TgPUiDIQA+HTykqwCpaZbiZQCq0wvOHaHfLt96Pk3sWEhn8U435Y2tcLgURKG6WaDGKM
         zl/xeHhO4qw+bK+GeU8O7BVxCQcSoSGD3YG3hxFXrV4wUyzK/UsV55aSyVz/8sjRi6Z4
         ZYyc4OurqjNq/FPWLMqg8UfzdWVRhcOAJX8MlL7Dom7mGxpC4vu7F7j3hX9O1X4jZQSC
         YBLESYo8RdcOM/NvTXyZybCrIVzBV9jTTelj6ekqqBeiORThx5wLI1zcL+H6i11hLpK3
         5kpg==
X-Gm-Message-State: ACrzQf2E+9ZtDA0oGbndbBz26VTj1KEmVHuU0DzY73ezuGoah/2OtJAe
        JI+G8Q7+IUYyLy9M8LncuUKAH5hIurLcsA==
X-Google-Smtp-Source: AMsMyM4pdeSYkXuQB6LK8hCGABCISfdhZsSwKbvoTfxltQcZuiggHNo1R9ZKzEGFHqFRwpvAF2Qw8w==
X-Received: by 2002:a05:620a:1725:b0:6ee:e8bc:9594 with SMTP id az37-20020a05620a172500b006eee8bc9594mr37441823qkb.184.1666915939526;
        Thu, 27 Oct 2022 17:12:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.14.204.158])
        by smtp.gmail.com with ESMTPSA id b17-20020ac844d1000000b003a4d5fed8c3sm1585813qto.85.2022.10.27.17.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 17:12:19 -0700 (PDT)
Message-ID: <635b1e63.c80a0220.41d1f.6e7f@mx.google.com>
Date:   Thu, 27 Oct 2022 17:12:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8900753325840960485=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Add CONFIG_BT_LE_L2CAP_ECRED
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221027232528.1996093-1-luiz.dentz@gmail.com>
References: <20221027232528.1996093-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8900753325840960485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689611

---Test result---

Test Summary:
CheckPatch                    PASS      1.83 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      34.27 seconds
BuildKernel32                 PASS      31.02 seconds
Incremental Build with patchesPASS      46.58 seconds
TestRunner: Setup             PASS      514.95 seconds
TestRunner: l2cap-tester      PASS      17.48 seconds
TestRunner: iso-tester        PASS      16.75 seconds
TestRunner: bnep-tester       PASS      6.64 seconds
TestRunner: mgmt-tester       PASS      106.88 seconds
TestRunner: rfcomm-tester     PASS      10.50 seconds
TestRunner: sco-tester        PASS      9.95 seconds
TestRunner: ioctl-tester      PASS      11.37 seconds
TestRunner: mesh-tester       PASS      8.19 seconds
TestRunner: smp-tester        PASS      10.02 seconds
TestRunner: userchan-tester   PASS      6.99 seconds



---
Regards,
Linux Bluetooth


--===============8900753325840960485==--
