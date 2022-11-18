Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 09:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbiKRJbT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiKRJbP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 04:31:15 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74068C0B4
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:31:13 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s4so2770515qtx.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ujC6ecH5UqGbi8FRY8B2eBcdXftETL+iGWFhHkLXyxY=;
        b=Qu0MrFXv+glV8l9n6CxpRRrR44RtAMQ6N8uarLGciWazY4CpIoTrogHLuQ0mEcN40w
         NKwIuTX4DwTCQTofz2si82dzRYo2eoLJ6Ss75bPwYxTOxnLzIZ7mco6t5SMApe9d25a1
         JXgaIGfbhzUbqJErz9JIH32EGYGK8YpErgyhfomNxNs/CcqSu3Wo8uRUI9KxzkIkq9CP
         Lir9ozBOlTZQEVLkwTxbUhDdQWl1uHJd3u1uzlqKAgTS7SiA7u4pj7b7HOwyOMEf/4RY
         eWD0fXD/nFD1LAWl1DobVq7Y9wGZaS2fT064awVUirrFL1T2maGhfVBa/8cxxzq9enBa
         FyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujC6ecH5UqGbi8FRY8B2eBcdXftETL+iGWFhHkLXyxY=;
        b=5aW747TCTMq2pEDMTCVsLP5ID8ED+dzawWZWYrCJBMdLZwm+9Xk3ZIjqjIh/Ve1dUU
         +DfHTFPcFC5Z+k53hyhGjirdTotvvVl85GL9VGYuTn++WAxIK78yw+DMDwMhd4S0bwMd
         yjowKQZ9ojQW/LDKzLT4HS9eyfwIhH81M1jLQGLpAsOXQ4FMWwpjN/5AvQGc0xGuTj3c
         UCtyFGAs7wO+IQyyc/eSydS7FqkKo8YhR4GWNL2zuJj/DSLXIPaxGL6EvDWE6A/0jGCL
         0UQDGGjlNtIgLS2cK8HRmsajz42cSAkJJhQuLyPmT1Rv6Uz8cfK9AWmRJnx17BcGOmGy
         hJvA==
X-Gm-Message-State: ANoB5pkCnTeloYAh++LyeAjF3g7N0s796viQJJ3HqjL4blHG+tQ3LeH1
        n/OatfGN5zq6Tfh0N7dSqugEu3vENU/jjg==
X-Google-Smtp-Source: AA0mqf6xjFHol+Zusy+LAfAI96qy8H+VcX4Psv2yIeJqk1ghUGnZua4GJvWdkteriqOAWpgU0uNsZg==
X-Received: by 2002:ac8:4f01:0:b0:3a5:318a:1cd6 with SMTP id b1-20020ac84f01000000b003a5318a1cd6mr5864998qte.419.1668763873178;
        Fri, 18 Nov 2022 01:31:13 -0800 (PST)
Received: from [172.17.0.2] ([20.14.189.175])
        by smtp.gmail.com with ESMTPSA id v20-20020a05620a0f1400b006fbae4a5f59sm2071855qkl.41.2022.11.18.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:31:12 -0800 (PST)
Message-ID: <637750e0.050a0220.b344b.99c1@mx.google.com>
Date:   Fri, 18 Nov 2022 01:31:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6465011733900832763=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6465011733900832763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691972

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      0.69 seconds
SubjectPrefix                 FAIL      0.55 seconds
BuildKernel                   PASS      34.13 seconds
BuildKernel32                 PASS      30.46 seconds
TestRunnerSetup               PASS      418.42 seconds
TestRunner_l2cap-tester       PASS      15.70 seconds
TestRunner_iso-tester         PASS      15.51 seconds
TestRunner_bnep-tester        PASS      5.30 seconds
TestRunner_mgmt-tester        PASS      105.31 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      8.59 seconds
TestRunner_ioctl-tester       PASS      9.80 seconds
TestRunner_mesh-tester        PASS      6.64 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      5.56 seconds
IncrementalBuild              PASS      38.08 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6465011733900832763==--
