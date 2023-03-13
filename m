Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D8EC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 14:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCMOdx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCMOdw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 10:33:52 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9CD22A39
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 07:33:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c18so13302614qte.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678718029;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m6wxrXWK/O5heW8A1sqqI7iIHwIFAkL2YwIRBdvuxSc=;
        b=WTIycob9e3H5ueA9nzVpMbLktmEcMIWxi91asqX2ygnoWAJ4S3f72xifmlfAZUGVJk
         LvGw7bPHXPVZ1FfyQSEgxjy5igpgRnl14Dt0x+rF9ifwAQB5A+HibohXUclTH0ZQoSuw
         4yxbyQg3yVYYV2wUxDcmmd/vpLtqP32O9TGzTIq2+B7GHli50hSJvQzQm0cVm/9mm4+k
         ERDGmeaG2GV8Ur/h406PpfAgzO2CzuDSrjnCfezmZStkTj89v7szxqOM0TqM7EH090Q7
         w89fvDAY5PoVC9b2eJA9J5Sfd1/xmher+SrQF05X/LWdVZRS67+0t73SrrVLLEE8VNjt
         ocng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718029;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6wxrXWK/O5heW8A1sqqI7iIHwIFAkL2YwIRBdvuxSc=;
        b=CUM/RTATEOEy15QsZv7kyPqYK132e+iW9MdNR3SNIAU2nHc1L7z6WLYIvpMUe9i4iQ
         1/u6431Pxn44AmIl22Dtpfz89+JIMcsWXeoiRKZuCLDXUrGy0wh0CkMCvX5kRnScnVEu
         vmLfDCvYC97u4bNPIKskS8ZL6DUaw0Vcuz1fyr+BpGBz5Dd3h0+jH1RzcZi04cOOtaTN
         yfH/Xsc6JPk6sS9VkBj2Ww5I3sJuD3Wv2JfSZ2f/y5O3zEip4AfYh9TKY1exCcAaWd30
         n+KmHFP2HgUPAzAgCvuJ2anmgK6lDXcMgfJ3qYh4JNOv11LjpEqz4SdpTtsE3WjdGbpY
         w0UQ==
X-Gm-Message-State: AO0yUKVkRJci5N44fGqR94K9Zn15w5w7iSSzJpxuS7RNAdF9W1e5rCM0
        sGitwFC0Rzpfj15KmjPvEfgf7kN7pS4=
X-Google-Smtp-Source: AK7set/7JYCZg6ef0y1xoH+dtTDYbBk3e5pauxTuEAUCzoCHZqCDLeXudP02zoR/YqFR85BMSLKOhA==
X-Received: by 2002:ac8:5bd2:0:b0:3b9:8885:296f with SMTP id b18-20020ac85bd2000000b003b98885296fmr61718624qtb.24.1678718029132;
        Mon, 13 Mar 2023 07:33:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.19])
        by smtp.gmail.com with ESMTPSA id l25-20020ac84cd9000000b003bfc355c3a6sm5532522qtv.80.2023.03.13.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:33:49 -0700 (PDT)
Message-ID: <640f344d.c80a0220.5bd64.deda@mx.google.com>
Date:   Mon, 13 Mar 2023 07:33:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2871822664587236933=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230313140924.3104691-2-neeraj.sanjaykale@nxp.com>
References: <20230313140924.3104691-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2871822664587236933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729473

---Test result---

Test Summary:
CheckPatch                    PASS      4.33 seconds
GitLint                       FAIL      1.37 seconds
SubjectPrefix                 FAIL      0.61 seconds
BuildKernel                   PASS      32.83 seconds
CheckAllWarning               PASS      35.60 seconds
CheckSparse                   PASS      40.43 seconds
CheckSmatch                   PASS      109.26 seconds
BuildKernel32                 PASS      31.28 seconds
TestRunnerSetup               PASS      446.50 seconds
TestRunner_l2cap-tester       PASS      17.30 seconds
TestRunner_iso-tester         PASS      17.93 seconds
TestRunner_bnep-tester        PASS      5.73 seconds
TestRunner_mgmt-tester        PASS      113.64 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         PASS      8.44 seconds
TestRunner_ioctl-tester       PASS      9.95 seconds
TestRunner_mesh-tester        PASS      7.32 seconds
TestRunner_smp-tester         PASS      8.40 seconds
TestRunner_userchan-tester    PASS      6.06 seconds
IncrementalBuild              PASS      38.59 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v9,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (87>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============2871822664587236933==--
