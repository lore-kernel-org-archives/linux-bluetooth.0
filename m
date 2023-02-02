Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13F7C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Feb 2023 12:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBBMnw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Feb 2023 07:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBBMnu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Feb 2023 07:43:50 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B0789FAC
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Feb 2023 04:43:11 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v17so1620411qto.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Feb 2023 04:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HXzrTC3ZODUU4poqnw//uLiji7zxiHrJDMPUfuV8ogQ=;
        b=IRVFAjUyBA3lbSI2UxCBSU1q5Qd826sgxv46PinYtjc0epPKNsQHHGTKDHu6YvJPWH
         ETnhg4pzTnEmEV72wJ2/cOZO1+5GQzwTR4NmbXIH9KC8/TAYfXMCIWpKKiyxl/EiGlEG
         aG3Pnpl4lRXmzJR6h4wz8RPI9HfXABpZTs3KIwycI8BxAbIwjTd8ynmn+mcwLbYIHJj2
         Lxt/0Q+ut4JqMFbrGvrCnBAmhDH79aL6pOYo5JQo6qp8oP29roVYGTYwZnRdvc9lMP1p
         XxRHtbk7lj22exX2IH8wl7orUUj1xDXBSBMAeMfyOidMK7fq63PUN0a1BqCjzG/z8FSF
         jgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXzrTC3ZODUU4poqnw//uLiji7zxiHrJDMPUfuV8ogQ=;
        b=wWsujBnZsltfEZ95/+MRMxxdeEI0OIkvRtat2UZig7Dt7lW9RCiq1u5V4v2O/f+7Kt
         iIwevx7kStTVBF0ZAFF7AZBUfyU15RvscobR1sIDC6FIt66yeMAWrco33ew+lxJ+sxkX
         s0N+FNUqCwPyINApHVzcFVdB21pUg9UrWE6eH4nI9m6AS67L5stvPg1gMNR+kM0e/+22
         Vs0HB+zC+sL6NYYzNUQYfTvLFP83KfA3Tc3gADGV4wSOgf54MLy8UnlJfTa20BawXAdh
         0Vv1IicBVR2eoSfJRFcyBGWCt8itFWjqepdL9GeihGX2FgRwG+nZG8K5QQ7IWYtBY5Cf
         LX6A==
X-Gm-Message-State: AO0yUKUmqPmiSvv02DG5MFTwYyDS0boqTVQBez+X3BPXUXESqFL30Ou8
        h1SJMVDf/2Ck343DbslhIOYY6BS5qF4=
X-Google-Smtp-Source: AK7set+naYuRQuiedhivkDnjzOIlm8V56HvznzciRVpkSYsyryEmW4BYJg1mIYfXO/AUnUdjrfeOJw==
X-Received: by 2002:a05:622a:294:b0:3b6:3e4f:f876 with SMTP id z20-20020a05622a029400b003b63e4ff876mr10933568qtw.18.1675341723644;
        Thu, 02 Feb 2023 04:42:03 -0800 (PST)
Received: from [172.17.0.2] ([104.45.203.195])
        by smtp.gmail.com with ESMTPSA id z20-20020ac84314000000b003b960aad697sm6192431qtm.9.2023.02.02.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:42:03 -0800 (PST)
Message-ID: <63dbaf9b.c80a0220.30d2e.7d9c@mx.google.com>
Date:   Thu, 02 Feb 2023 04:42:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4285628920454705461=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v2] Bluetooth: btrtl: Firmware format v2 support
In-Reply-To: <20230202114614.53907-1-max.chou@realtek.com>
References: <20230202114614.53907-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4285628920454705461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=718117

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       FAIL      0.59 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.41 seconds
CheckAllWarning               PASS      34.42 seconds
CheckSparse                   WARNING   39.28 seconds
CheckSmatch                   WARNING   107.00 seconds
BuildKernel32                 PASS      30.51 seconds
TestRunnerSetup               PASS      438.93 seconds
TestRunner_l2cap-tester       PASS      16.68 seconds
TestRunner_iso-tester         PASS      17.51 seconds
TestRunner_bnep-tester        PASS      5.83 seconds
TestRunner_mgmt-tester        PASS      113.14 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         PASS      8.45 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        PASS      7.34 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      6.11 seconds
IncrementalBuild              PASS      28.50 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btrtl: Firmware format v2 support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (83>80): "> I rather use an skb for parsing the data instead of parsing via pointer directly,"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c:882:22: warning: cast to restricted __le16drivers/bluetooth/btrtl.c:888:27: warning: cast to restricted __le16drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4285628920454705461==--
