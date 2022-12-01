Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB76C4321E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 03:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiLADRn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Nov 2022 22:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLADRn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Nov 2022 22:17:43 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F1D1834B
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 19:17:39 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k4so319107qkj.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 19:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TH7LZS0FAjRT7n0tfxT3di/l2IlssbA7qdM/xDVxDo0=;
        b=ZcFeiKhJfO2EnKQG0RdCLBbSwLEsH9oeulsk3xjrDu7irNnPsHfu1rJ4WE52m0CTzW
         oxt0tWwGo5HfjINSgnJHgclo0hIjUMUdRNX4ZVlgiiWYjxDQr/PZOIJKpuwGXwmXbVK0
         PH69xjlNWGgU5YVYTsAuIB6CHjBZ9MnJGCwXxnn80szB5O1krEoKgbwLPm/tZUrzSUP8
         HpcHjXFNWeWpPDMaoPKQNaKYlgwo8CR9NtTV6mLR35XHnAvBLm26q/Cf8TRi3oSvO6vo
         HqSJPkEnLFz1Ko/GbVMQ5v10RlRusFc1pgCYsDPk4ee2N+qJO7zkqdqs3bZJGShGWYhM
         4GDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TH7LZS0FAjRT7n0tfxT3di/l2IlssbA7qdM/xDVxDo0=;
        b=5vpfk10BvPO3gYBoGG0nuitD0e7M9bIVJjDKE/auLPDXm6y4on8KUR34oQPCmf/Aej
         0WsGgoD9BYNDSRZDodd821PmEdtRvYuMpXF7kTEYbu6lHVLMAHSdl0IBY0lobzWCa3NG
         mQLE2VrpGVcYvhuOgImKGvODoSj3rhbEpbeRPHVbrqUEDKDH398/LyBlgIladYlNygpf
         N29nQY6x97OJZk6SZkTE/rXDpDWxGw/2kQ3H7L6pHdTt8W//+B87lQLfVlFAnGaX3/Z5
         INmR2cN79vtbqq1m+2DP/XvVmtkQdvz1sftEuvU0v/f7NCYGP5QGsLgZy2zC+4RTZizu
         D9WQ==
X-Gm-Message-State: ANoB5pk3/h9kncAaMTzmR6H4Q7SrphHxESYaKuG/GlHSapxrd4g6/k9A
        VUim2gIia4v5zJ4ypO+MK0OqXYZicVjIAg==
X-Google-Smtp-Source: AA0mqf5yrhZNJiSxzbKhYM3nRsVYK83YXIDGbZ+uxUCMUlELAvEjJcoCOlQm1L6QjigSEOPX0OesIw==
X-Received: by 2002:a37:2dc7:0:b0:6ce:2d77:92d0 with SMTP id t190-20020a372dc7000000b006ce2d7792d0mr57217457qkh.713.1669864658811;
        Wed, 30 Nov 2022 19:17:38 -0800 (PST)
Received: from [172.17.0.2] ([172.174.34.57])
        by smtp.gmail.com with ESMTPSA id x26-20020a05620a0b5a00b006cfc01b4461sm1307381qkg.118.2022.11.30.19.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 19:17:38 -0800 (PST)
Message-ID: <63881cd2.050a0220.2f2dc.5ecb@mx.google.com>
Date:   Wed, 30 Nov 2022 19:17:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7268659590242162696=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lifangpi@hotmail.com
Subject: RE: [v3] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
In-Reply-To: <SI2PR02MB4603E1ACBD47EA74D555A198DD149@SI2PR02MB4603.apcprd02.prod.outlook.com>
References: <SI2PR02MB4603E1ACBD47EA74D555A198DD149@SI2PR02MB4603.apcprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7268659590242162696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700661

---Test result---

Test Summary:
CheckPatch                    FAIL      0.96 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.12 seconds
BuildKernel32                 PASS      30.21 seconds
TestRunnerSetup               PASS      425.44 seconds
TestRunner_l2cap-tester       PASS      16.12 seconds
TestRunner_iso-tester         PASS      15.74 seconds
TestRunner_bnep-tester        PASS      5.55 seconds
TestRunner_mgmt-tester        PASS      107.92 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         PASS      9.06 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        PASS      7.07 seconds
TestRunner_smp-tester         PASS      8.70 seconds
TestRunner_userchan-tester    PASS      5.82 seconds
IncrementalBuild              PASS      31.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
WARNING: From:/Signed-off-by: email address mismatch: 'From: Gongwei Li <lifangpi@hotmail.com>' != 'Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>'

total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13060883.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7268659590242162696==--
