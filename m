Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55018C001DE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 16:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHEQlU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Aug 2023 12:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHEQlS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Aug 2023 12:41:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE71421F
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Aug 2023 09:41:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686b91c2744so2309526b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Aug 2023 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691253675; x=1691858475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ap/ofkJYvruibxOIMsMAiXGqchk8Q5HswDXC+zlPLf8=;
        b=Anv4PJsb7zpOxHdkmjg9Pyr9gaYeKpojWoOWTsxSu3KQsjqpf/T6y0p4zz+DXDmDDK
         o9bm0d20j9XcW/0V2jTMV0FXAYZXK7vl3AnCSoeJTp78fMk/MXSgGTDreoS2FFjm3OvA
         STzF8AdpvgBT7CtYLFi4LvpWST6MWIfDkzDcCE1PX8HauiVR3MlHrJ4M6zIrd4KvCSGu
         7fsRFeM4UCZmjLTQvQPFs4Z5OaOIKe7e3SK7NeXX53VBA0AsHg+ZKM3uYqia4RHzwJzD
         mjt5ZkaKq4YlEEhn8o0sFdcnV6SvPFiVC2iRHF+wiIDfHm7KzSxf/QzEyBfE6C/Hbn9d
         LNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691253675; x=1691858475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ap/ofkJYvruibxOIMsMAiXGqchk8Q5HswDXC+zlPLf8=;
        b=H52XYWc0QPiJZP5Bedia89/tg3t3kQLVp7H6G1eYOZeSAXqvIdXepTyjwj9QwIAYTm
         JaNDSoRPVeeatsv+9sZvXium7CW/yM/yQ9Qy3hvRfGfCD7fzKTBt+UY7K8fURD2MTKRW
         NHz1mlRrUVRa9dY6xRSvcxF8sEGOK5GxmCVYD4dTcxAqCiBybbZirLKjvoEliw8I7ZOo
         y8RpWvhOqmfIdPMD5Lu2JIc6RQh8pu0krrYLAFka5MEjPDL47xcQMwBE6YOeIOnzEg49
         OZ56BECxfvG2rF0Y6hYxHPdYG+sH2Lwfa1qz2kl0Bz6JY+HZyw0H9/yL4AwZGXZNFWRT
         5xsg==
X-Gm-Message-State: AOJu0Ywj4IsLa56BZMcWnSJF9koaMi4ozsS6xsLC7Ju8a9ivke3B4AER
        8/iqwgmEvW/0XUMc5KO2YwA73WSlsZo=
X-Google-Smtp-Source: AGHT+IHLHxGvmINhneaf5Gsd7FNdmsNfHKAGcXMK6BKPWYMp4BMG46179F1PDas7qPdWpwjO4Ea9iQ==
X-Received: by 2002:a17:903:650:b0:1b8:3786:3344 with SMTP id kh16-20020a170903065000b001b837863344mr4772838plb.49.1691253674662;
        Sat, 05 Aug 2023 09:41:14 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.1.192])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090311cb00b001bb8895848bsm3736649plh.71.2023.08.05.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 09:41:14 -0700 (PDT)
Message-ID: <64ce7baa.170a0220.e13e.71fd@mx.google.com>
Date:   Sat, 05 Aug 2023 09:41:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2605505998816623543=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [1/2] Bluetooth: hci_event: drop only unbound CIS if Set CIG Parameters fails
In-Reply-To: <5af5d6830d65173124aa525dd01b2718548ffb65.1691251325.git.pav@iki.fi>
References: <5af5d6830d65173124aa525dd01b2718548ffb65.1691251325.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2605505998816623543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773373

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.51 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      39.69 seconds
CheckAllWarning               PASS      43.65 seconds
CheckSparse                   WARNING   49.58 seconds
CheckSmatch                   WARNING   132.40 seconds
BuildKernel32                 PASS      38.51 seconds
TestRunnerSetup               PASS      579.52 seconds
TestRunner_l2cap-tester       PASS      27.76 seconds
TestRunner_iso-tester         PASS      68.79 seconds
TestRunner_bnep-tester        PASS      12.67 seconds
TestRunner_mgmt-tester        FAIL      252.38 seconds
TestRunner_rfcomm-tester      PASS      18.87 seconds
TestRunner_sco-tester         PASS      21.89 seconds
TestRunner_ioctl-tester       PASS      21.13 seconds
TestRunner_mesh-tester        PASS      15.87 seconds
TestRunner_smp-tester         PASS      17.16 seconds
TestRunner_userchan-tester    PASS      13.29 seconds
IncrementalBuild              PASS      68.10 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.924 seconds


---
Regards,
Linux Bluetooth


--===============2605505998816623543==--
