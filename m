Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BD3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbiKRF4m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRF4f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:56:35 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4042F97AA6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:56:30 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id df6so519190qvb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sXA9OTQ2KETKNM5JCtuQoDTLIdDmbo6ZKW70AWZGPGA=;
        b=C77JhqXGucFEQUdErAZG7Vnj3X4ebxLAQ37vPqqfcGUexwgKTDeE1ytWuN2/bzwC20
         uYe+5U2ujoJ5o80/nibs19sY6OpGcAoPz54A/LOa1rTBTWd+KJrE8zVHp9BP/u45gIVI
         Gxek6PvGsI+prW/mafhD9qccjO2+VABqh6AalwZLOiuWGkjQs6ET4Uj4Tz51F6WFtIYj
         bNDdRyM9E6P4m/CBTBilsv3mFDnwthDL1TybTnrY+/eOan/MsyPaENnCS9SNSAclxxIG
         vv1+0tiy54O4Amob5+F8C6zaxLXJyXo56rqWBhyzT7DXZgv/RKpzdV986rNwnYQcTwgm
         oeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXA9OTQ2KETKNM5JCtuQoDTLIdDmbo6ZKW70AWZGPGA=;
        b=LR5TyjgPtc97jhW9qZQltxtJMZZFdOVebDiDsoQIkrfxoy4IVs0+TtSkfnhcBO+iRg
         KuulBUeOpMrKiviso04LRRc1axBAjb6TKjsxEzLzulaZ/QlDeINOv9a01/EI93n/wSZF
         W8eEH8FuM5OA5v21Nsx8qtE2Y8PKgTpKgmj07mkKw/rK36OWy4JUiX4mynlZKXVLrGAX
         QjaK/bQpIDaBzzaVozg1qTANqH1wTnU7ZTv1MPMn8Zn6oZEX6VXuOD1aWWSUs5maa2NX
         y6DBbBFv5pWjmwCWKWRKOlgS455VCVCurAW/9M5WTW1/Ku76lEoDXZf95xTTsmePSvv8
         CjoA==
X-Gm-Message-State: ANoB5pnQc1rm71eJHdrMdeyjkdIqZffM89CTmDI286WuGDrfsgXvXrll
        eSTqOYJswtODlmAnx/R0stFdBFXFkvl05w==
X-Google-Smtp-Source: AA0mqf4xx0Llvbt9hZABapA8gTk2mQT6EGgUkOEUeVnHoXOZBWXuHpOAIshpzm7C6HC8/EhRiZjgKA==
X-Received: by 2002:a05:6214:1cc:b0:4b1:1172:a587 with SMTP id c12-20020a05621401cc00b004b11172a587mr5617195qvt.75.1668750989250;
        Thu, 17 Nov 2022 21:56:29 -0800 (PST)
Received: from [172.17.0.2] ([172.176.206.196])
        by smtp.gmail.com with ESMTPSA id de36-20020a05620a372400b006fbb4b98a25sm1860835qkb.109.2022.11.17.21.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:56:29 -0800 (PST)
Message-ID: <63771e8d.050a0220.7dcee.9a57@mx.google.com>
Date:   Thu, 17 Nov 2022 21:56:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9014317448903307978=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: hci_event: handling CIS QoS
In-Reply-To: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
References: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9014317448903307978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696036

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      34.87 seconds
BuildKernel32                 PASS      31.40 seconds
TestRunnerSetup               PASS      433.85 seconds
TestRunner_l2cap-tester       PASS      16.40 seconds
TestRunner_iso-tester         FAIL      16.15 seconds
TestRunner_bnep-tester        PASS      5.61 seconds
TestRunner_mgmt-tester        PASS      108.01 seconds
TestRunner_rfcomm-tester      PASS      9.55 seconds
TestRunner_sco-tester         PASS      8.99 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        PASS      7.12 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      5.89 seconds
IncrementalBuild              PASS      32.55 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 55, Passed: 11 (20.0%), Failed: 44, Not Run: 0

Failed Test Cases
ISO QoS 8_1_1 - Success                              Failed       2.029 seconds
ISO QoS 8_2_1 - Success                              Failed       0.153 seconds
ISO QoS 16_1_1 - Success                             Failed       0.153 seconds
ISO QoS 16_2_1 - Success                             Failed       0.157 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.156 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.153 seconds
ISO QoS 24_1_1 - Success                             Failed       0.153 seconds
ISO QoS 24_2_1 - Success                             Failed       0.152 seconds
ISO QoS 32_1_1 - Success                             Failed       0.156 seconds
ISO QoS 32_2_1 - Success                             Failed       0.155 seconds
ISO QoS 44_1_1 - Success                             Failed       0.154 seconds
ISO QoS 44_2_1 - Success                             Failed       0.150 seconds
ISO QoS 48_1_1 - Success                             Failed       0.152 seconds
ISO QoS 48_2_1 - Success                             Failed       0.153 seconds
ISO QoS 48_3_1 - Success                             Failed       0.150 seconds
ISO QoS 48_4_1 - Success                             Failed       0.152 seconds
ISO QoS 48_5_1 - Success                             Failed       0.152 seconds
ISO QoS 48_6_1 - Success                             Failed       0.154 seconds
ISO QoS 8_1_2 - Success                              Failed       0.156 seconds
ISO QoS 8_2_2 - Success                              Failed       0.152 seconds
ISO QoS 16_1_2 - Success                             Failed       0.152 seconds
ISO QoS 16_2_2 - Success                             Failed       0.155 seconds
ISO QoS 24_1_2 - Success                             Failed       0.156 seconds
ISO QoS 24_2_2 - Success                             Failed       0.154 seconds
ISO QoS 32_1_2 - Success                             Failed       0.156 seconds
ISO QoS 32_2_2 - Success                             Failed       0.152 seconds
ISO QoS 44_1_2 - Success                             Failed       0.154 seconds
ISO QoS 44_2_2 - Success                             Failed       0.152 seconds
ISO QoS 48_1_2 - Success                             Failed       0.157 seconds
ISO QoS 48_2_2 - Success                             Failed       0.153 seconds
ISO QoS 48_3_2 - Success                             Failed       0.155 seconds
ISO QoS 48_4_2 - Success                             Failed       0.155 seconds
ISO QoS 48_5_2 - Success                             Failed       0.154 seconds
ISO QoS 48_6_2 - Success                             Failed       0.155 seconds
ISO Connect2 CIG 0x01 - Success                      Failed       0.194 seconds
ISO Send - Success                                   Failed       0.154 seconds
ISO Receive - Success                                Failed       0.159 seconds
ISO Defer Send - Success                             Failed       0.155 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.152 seconds
ISO Defer Receive - Success                          Failed       0.151 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.149 seconds
ISO Send and Receive - Success                       Failed       0.157 seconds
ISO Disconnect - Success                             Failed       0.159 seconds
ISO Reconnect - Success                              Failed       0.158 seconds


---
Regards,
Linux Bluetooth


--===============9014317448903307978==--
