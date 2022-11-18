Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D680FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiKRFaq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiKRFao (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:30:44 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7959A251
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:30:43 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m15so2061983ilq.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uKPrzdU9Pj6Wy1+9aZ+5VeDl/8q84kaWp7TZrhvmh0c=;
        b=YWk6gG+oKfOIF2fl81xUxZWK8DryIDi+nvOTZnsRU9wHX0YDjvpIXjAt2HDCHGU5Hf
         tUbB9FCsxK87Y/z/b1vUMpmhvVCqV8jhc4NWBottXa2gHEa1UGMUJNiLj96sJinGUXQP
         vvEMPTfIg9N0ERiIITbcudWAm/KIVrIWjd6a0JtPeIzKw0P3cBcfMIs2NXokUrr/ZsZE
         nIerqVNnKTMCTCJdX//63wY3gtPM9SQ6W3I+DaQWd2Zg7kJze3082fds4FkcDoAmzvv5
         2rDphMIiNqFcvIcCtRXyk9BQbqChtrAsaY+bg6lioslSj6bn8Eg5nQd9OvppJlwpkATg
         x8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKPrzdU9Pj6Wy1+9aZ+5VeDl/8q84kaWp7TZrhvmh0c=;
        b=IyAQQdbkkLiQyitCE6HKorpCiM4oAfM58hhaoTzdg79uzmt8Sp7rzfxprVilgWFvtK
         02RpZC9cHMhzzZHM2Ht1rY8gig01soZLTdBwzA4c+yXp7zvxmW7ySEVRHKg68h4oyXm0
         oQcnwdT/rv98SNrZovJmw/vWpGqJUfjWCjlqd4V3jTotsb9tJc9U9iHR1rH8W42rymNV
         G6pretQjmwOR2Tb2c4L6EavQXtofvFhyicSCXdf0mEPsFW5zpKPCw9I8UsM8UptV5/5f
         noDgisHa1ESz7qjaqCpmtmnbBVnoZYpuRj7EowKkgwPwo9R5qhm2fhG+jXLnQRvavIIT
         7qMA==
X-Gm-Message-State: ANoB5pmD4IZhu0SLebZ1zbRkcmPaMXNWIWTOcxsVas38Zdgwn0/SZ07V
        OUGxtgq9Ww3C7ceMnCdAc2DgRSXpR80=
X-Google-Smtp-Source: AA0mqf5KVI82BMyIUujkLwxN1pInzWdDEx9IyDx+BFCM1ZQsIZUEKZvDDXt2iEKJxnCchYv9XVYQ/w==
X-Received: by 2002:a05:6e02:1d9b:b0:2fa:122:5409 with SMTP id h27-20020a056e021d9b00b002fa01225409mr2677757ila.154.1668749442369;
        Thu, 17 Nov 2022 21:30:42 -0800 (PST)
Received: from [172.17.0.2] ([40.122.71.104])
        by smtp.gmail.com with ESMTPSA id u11-20020a92da8b000000b003026db79c16sm981470iln.1.2022.11.17.21.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:30:42 -0800 (PST)
Message-ID: <63771882.920a0220.e7f4b.21e7@mx.google.com>
Date:   Thu, 17 Nov 2022 21:30:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3472774896365986528=="
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

--===============3472774896365986528==
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
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 FAIL      0.40 seconds
BuildKernel                   PASS      33.94 seconds
BuildKernel32                 PASS      30.07 seconds
TestRunnerSetup               PASS      427.72 seconds
TestRunner_l2cap-tester       PASS      16.08 seconds
TestRunner_iso-tester         PASS      16.13 seconds
TestRunner_bnep-tester        PASS      5.55 seconds
TestRunner_mgmt-tester        PASS      107.54 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         PASS      8.90 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        PASS      7.07 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      5.86 seconds
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


--===============3472774896365986528==--
