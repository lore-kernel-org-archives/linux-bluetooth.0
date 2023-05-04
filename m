Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DA1C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 May 2023 21:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEDV53 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 May 2023 17:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjEDV50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 May 2023 17:57:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E360413851
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 May 2023 14:57:24 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-74e19dcf217so51668885a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 May 2023 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683237444; x=1685829444;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rCurWGmtXL5sq5EgxZ89G/H7672efzT1Wl14Z6MS2Gk=;
        b=gZLc95Fhwzu4FdoWT4x3WqE/veBFUXBzBdFZ3HzdHrKNfXxjQZJSaad4ntqXtr76mc
         SH+td6FrFUKDi0M1WXLAD2B2MRt/mV+Bc3+nzKpyPyHQefw+5ug3GOXyMSCNXA8V4uAy
         HEy75uY2MBwGFTjJolrzuW9kw16UbhaR3kOr9SQLzb2sz8yMTGvt57x480mhUez7Otpi
         MjKKn4Gwqqjljgc98sD2mU4FbedfJdJ7vfs/SfTB53lTjrL2Vv2lwuz+p6C4fyCqgObT
         5S74pfB2laGyNv5okIy2OwWP023bSTcPk8jLt5PrUKNSHTP5GNsxZDcSMajXATOAPToe
         kKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237444; x=1685829444;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCurWGmtXL5sq5EgxZ89G/H7672efzT1Wl14Z6MS2Gk=;
        b=F9bINUGMVifiI6J+1yzs5Zfi+9ysCK29NrgUOJan4cYUHTkGrync/gaYwXoCZVmReO
         K/7phuTOD+ATLE6B9pAw5clFVT9f/FlrTkLidmyxHleR+VCllwMzs6pbXcDpgIq+AaLH
         u/6qypxCJRwBZ/xoAlvbp2h8fuHYoXeQJe6MwbkYS+WyiO7SxO3mX9JKANdr/Q1jSagK
         Xyzol5TIURQa+NlNqKKKmI5CRyGqvcV+9YtudKxZ+C4JSqt16/lUxRV1N+FkcW6CxHWA
         3ZaeCSb+/5T5XoissNPAzGmKaGsXSSdjqs6FxZrWTI08nvBRDK1IJ2TjZSpH6bbNzaCP
         cMfg==
X-Gm-Message-State: AC+VfDy8Yd4P+W+ah9mE22ou4dkhIWGMapH1dmRVofTnRxPKq/jRqZEE
        XUgPGG86kjr1JWvIfDuTPqsAdSEzcck=
X-Google-Smtp-Source: ACHHUZ64WK2Mgtg6AXHH1HCstu6TZLEX/EDv1zcM5a3X9zZzseQLhWL5HJwbN5nZM15H446XqNr6fA==
X-Received: by 2002:a05:622a:64c:b0:3f2:1b6a:689 with SMTP id a12-20020a05622a064c00b003f21b6a0689mr7529634qtb.3.1683237443847;
        Thu, 04 May 2023 14:57:23 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.200.33])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a01fb00b007441b675e81sm123659qkn.22.2023.05.04.14.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:57:23 -0700 (PDT)
Message-ID: <64542a43.050a0220.ba9c7.0c9f@mx.google.com>
Date:   Thu, 04 May 2023 14:57:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5691710937128199765=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.gora@gmail.com
Subject: RE: [1/1] Bluetooth: btusb: Add device 6655:8771 to device tables.
In-Reply-To: <20230504212752.16179-1-dan.gora@gmail.com>
References: <20230504212752.16179-1-dan.gora@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5691710937128199765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=745112

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       FAIL      0.59 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.12 seconds
CheckAllWarning               PASS      36.76 seconds
CheckSparse                   PASS      42.12 seconds
CheckSmatch                   PASS      112.73 seconds
BuildKernel32                 PASS      32.51 seconds
TestRunnerSetup               PASS      463.04 seconds
TestRunner_l2cap-tester       PASS      17.54 seconds
TestRunner_iso-tester         PASS      21.76 seconds
TestRunner_bnep-tester        PASS      5.76 seconds
TestRunner_mgmt-tester        PASS      118.56 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      8.57 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        PASS      7.36 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.04 seconds
IncrementalBuild              PASS      30.59 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/1] Bluetooth: btusb: Add device 6655:8771 to device tables.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[1/1] Bluetooth: btusb: Add device 6655:8771 to device tables."


---
Regards,
Linux Bluetooth


--===============5691710937128199765==--
