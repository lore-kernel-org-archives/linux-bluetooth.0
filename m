Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D90C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiKRHyO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKRHyM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:54:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509D38C08D
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:54:11 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so2682060qts.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3VNt1BVzOIBHBDvuRGyjUGwlS+Lb7/5vBkCWNlI2+Gw=;
        b=b2WRH236K/qhUbmHzE7kYrZc6CA8qLLoFrgK9YFQNZ5ikUH6FSgQM1dIJhDuPuWZgX
         MmuskmrrPvMui3aP/SbFmFpNK73zEO71uORRH0azBJEMyRU9At/cOkUe8tO5h5BEGZLU
         ZFAB//VLreR5XDJvsW1fV8kVcOsWiCITIE1jhGshkU6AVPutAV3ZF+KUSN+FRVVkjEEG
         HjU8BP+8jiJMdIXL9lCEFIcvMfoCiW6a7ds/FEkVrry21dZB6R4fwgzNBtzOOQSyWjQM
         mB8NjfmnkTtMd4ic+reG66GF7O4qQO8GNF5fAysn1C3B9RoWTuRQReyqku5Z6pV1KLme
         OOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VNt1BVzOIBHBDvuRGyjUGwlS+Lb7/5vBkCWNlI2+Gw=;
        b=BKi6AXz7w9EOTO92prsLDQCnXfHDPqn9R/D7BXL2di3/7ixItyIOhK3WRG3KyJjLhQ
         UE5l6iNIj459kdc0pwuLxHL8lxr8HpKmv92ukcmNz1HzRfrsSgFbF5eYCMzPXExaLnQ7
         n7VhtjlQlkGYy3xbeQ0ZpdcrdFvZ6VfL0jC+5/spjTtQ9+mWXfu6Ig8F4oouDQdoVDwb
         f9k07QIu1GbIfGU0Pnls10Qhybq2GOGG4z1grx+TCglVBPwmFJeaFXiUFgf/yX3nNQFw
         XwaulZLTTR+55dUJq1s+p8tZinMAoIc/iWKtv5ZzaBt76tYnoVmHRaWxnD57tKu8ElIw
         8Xcw==
X-Gm-Message-State: ANoB5pmxwzDLNKg4mngkO/XQvT+ZhPrR7Svcusdy+f2060e8tDVvaRgL
        WUer17hlG93JvmjjDW+gcaADTwv2/Oa1rQ==
X-Google-Smtp-Source: AA0mqf6lvgmWTQs/hwWgNu6zl+0Pf1FFhwXAI4YqR+JI4hotDMenLbHYTfSGdaaHND8OgVoi75EwQg==
X-Received: by 2002:ac8:1412:0:b0:3a5:26a5:51ee with SMTP id k18-20020ac81412000000b003a526a551eemr5721363qtj.84.1668758050306;
        Thu, 17 Nov 2022 23:54:10 -0800 (PST)
Received: from [172.17.0.2] ([20.172.204.111])
        by smtp.gmail.com with ESMTPSA id cc16-20020a05622a411000b003a606428a59sm1642622qtb.91.2022.11.17.23.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:54:10 -0800 (PST)
Message-ID: <63773a22.050a0220.9c94e.7a7c@mx.google.com>
Date:   Thu, 17 Nov 2022 23:54:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6743056638852262005=="
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

--===============6743056638852262005==
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
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      34.21 seconds
BuildKernel32                 PASS      30.76 seconds
TestRunnerSetup               PASS      422.26 seconds
TestRunner_l2cap-tester       PASS      16.39 seconds
TestRunner_iso-tester         FAIL      16.21 seconds
TestRunner_bnep-tester        PASS      5.61 seconds
TestRunner_mgmt-tester        PASS      108.09 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         PASS      8.94 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        PASS      7.01 seconds
TestRunner_smp-tester         PASS      8.70 seconds
TestRunner_userchan-tester    PASS      5.86 seconds
IncrementalBuild              PASS      31.87 seconds

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
ISO QoS 8_2_1 - Success                              Failed       0.157 seconds
ISO QoS 16_1_1 - Success                             Failed       0.155 seconds
ISO QoS 16_2_1 - Success                             Failed       0.155 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.157 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.157 seconds
ISO QoS 24_1_1 - Success                             Failed       0.154 seconds
ISO QoS 24_2_1 - Success                             Failed       0.154 seconds
ISO QoS 32_1_1 - Success                             Failed       0.156 seconds
ISO QoS 32_2_1 - Success                             Failed       0.154 seconds
ISO QoS 44_1_1 - Success                             Failed       0.154 seconds
ISO QoS 44_2_1 - Success                             Failed       0.154 seconds
ISO QoS 48_1_1 - Success                             Failed       0.155 seconds
ISO QoS 48_2_1 - Success                             Failed       0.157 seconds
ISO QoS 48_3_1 - Success                             Failed       0.155 seconds
ISO QoS 48_4_1 - Success                             Failed       0.155 seconds
ISO QoS 48_5_1 - Success                             Failed       0.154 seconds
ISO QoS 48_6_1 - Success                             Failed       0.154 seconds
ISO QoS 8_1_2 - Success                              Failed       0.158 seconds
ISO QoS 8_2_2 - Success                              Failed       0.155 seconds
ISO QoS 16_1_2 - Success                             Failed       0.155 seconds
ISO QoS 16_2_2 - Success                             Failed       0.157 seconds
ISO QoS 24_1_2 - Success                             Failed       0.156 seconds
ISO QoS 24_2_2 - Success                             Failed       0.155 seconds
ISO QoS 32_1_2 - Success                             Failed       0.156 seconds
ISO QoS 32_2_2 - Success                             Failed       0.154 seconds
ISO QoS 44_1_2 - Success                             Failed       0.154 seconds
ISO QoS 44_2_2 - Success                             Failed       0.154 seconds
ISO QoS 48_1_2 - Success                             Failed       0.155 seconds
ISO QoS 48_2_2 - Success                             Failed       0.158 seconds
ISO QoS 48_3_2 - Success                             Failed       0.157 seconds
ISO QoS 48_4_2 - Success                             Failed       0.155 seconds
ISO QoS 48_5_2 - Success                             Failed       0.153 seconds
ISO QoS 48_6_2 - Success                             Failed       0.155 seconds
ISO Connect2 CIG 0x01 - Success                      Failed       0.197 seconds
ISO Send - Success                                   Failed       0.158 seconds
ISO Receive - Success                                Failed       0.159 seconds
ISO Defer Send - Success                             Failed       0.159 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.155 seconds
ISO Defer Receive - Success                          Failed       0.151 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.154 seconds
ISO Send and Receive - Success                       Failed       0.164 seconds
ISO Disconnect - Success                             Failed       0.160 seconds
ISO Reconnect - Success                              Failed       0.156 seconds


---
Regards,
Linux Bluetooth


--===============6743056638852262005==--
