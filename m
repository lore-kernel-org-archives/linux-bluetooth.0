Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Feb 2022 02:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiBWCTM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Feb 2022 21:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiBWCTJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Feb 2022 21:19:09 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A754E08A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 18:18:40 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id fc19so4977288qvb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 18:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7efpNlq1xr5xxF2An8YbAsINsSterIalnqpxWFWCIAw=;
        b=Y+9xXMDLI9pe89TVCsZphits8wMp8+dBRwgZnK+SQVfhtW4dXfwnaMKgN56YA8gaps
         eJHUGv8X23sozzHpO1GP9+XP5rnrreJ/LbUzWjTVvWqfGK9EdsJpYapCTipNBoO9gTv/
         yWbPpss4A1W/fFmvz5OeApdPpU5ldZ4oNV1e0P1KFBMI2bqDbhcHFtlvPYPwSrtmkbCW
         znkYk66OJvG+wWBR/AuxUGWReTJ/YxFCYr8uY6IYx44qp/iHrlAHcxCY17iZPKF+Ammg
         hKBYTUsdUKg/l48dhZj2J7zDjhyQCnnPK5dsy1hIafg27bDRVKgcUvtmXbgNJsgD6I1f
         aOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7efpNlq1xr5xxF2An8YbAsINsSterIalnqpxWFWCIAw=;
        b=t/O2sH/VesbbvcRseqv34Kw/AG9YZRkcpEiB1UUOWh2uHLg/y41sCkDiVW1BHKE8J0
         OIpQi77c1gsHVh2j26/NnBf3Xq5+zEdLXuhyWsw77bv58qd8wIT9lpTj4PBeZbSRqOez
         KAzQgqSI+LxjhiGCNFv/eIDrpQRq25B4l6Y6VOcR89i/kcWtpVMsastVaT/3OVdY/f5k
         XCLLmyEiAZ5aXMILziZQAw8XX73d6ILkKLsG654KV18NQ/IpksF5RCBNsc3M2mAJSq/h
         aHPZHoQFWzPz04ypa3fidxXExa6y4u1EsBvHDTRDp+hxMVuE30deKvNjshU5JFlfPYaD
         xevQ==
X-Gm-Message-State: AOAM532OeCt8ilQ8Znxjf0Xz/W9/hPAGEOEhj81ZiGYQl7GRbXineDIP
        5ySTJ+I+UyEweckjdlftX//T1MO13J5Xag==
X-Google-Smtp-Source: ABdhPJwikFO/YuSVlDrajWdynD8NpDLYLMi+WS/TtJZDMuhPhVnLKJIucPdRZnHHc6CUuXg/zSirdQ==
X-Received: by 2002:ad4:42aa:0:b0:42c:3cb0:392d with SMTP id e10-20020ad442aa000000b0042c3cb0392dmr21465375qvr.67.1645582719208;
        Tue, 22 Feb 2022 18:18:39 -0800 (PST)
Received: from [172.17.0.2] ([20.122.171.182])
        by smtp.gmail.com with ESMTPSA id p141sm964777qke.96.2022.02.22.18.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 18:18:38 -0800 (PST)
Message-ID: <6215997e.1c69fb81.53a76.614a@mx.google.com>
Date:   Tue, 22 Feb 2022 18:18:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5238465061573765949=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [1/2] Bluetooth: btusb: Add a new PID/VID 13d3/3567 for MT7921
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <dba1c05e4bfdf53e631ff134eaa9449e2ad5deef.1645573830.git.objelf@gmail.com>
References: <dba1c05e4bfdf53e631ff134eaa9449e2ad5deef.1645573830.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5238465061573765949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=616926

---Test result---

Test Summary:
CheckPatch                    PASS      3.47 seconds
GitLint                       FAIL      2.10 seconds
SubjectPrefix                 PASS      1.86 seconds
BuildKernel                   PASS      40.56 seconds
BuildKernel32                 PASS      35.11 seconds
Incremental Build with patchesPASS      53.96 seconds
TestRunner: Setup             PASS      613.32 seconds
TestRunner: l2cap-tester      PASS      16.84 seconds
TestRunner: bnep-tester       PASS      7.62 seconds
TestRunner: mgmt-tester       PASS      130.91 seconds
TestRunner: rfcomm-tester     PASS      10.12 seconds
TestRunner: sco-tester        PASS      9.88 seconds
TestRunner: smp-tester        PASS      9.78 seconds
TestRunner: userchan-tester   PASS      8.34 seconds

Details
##############################
Test: GitLint - FAIL - 2.10 seconds
Run gitlint with rule in .gitlint
[2/2] Bluetooth: btmtksdio: Fix kernel oops when sdio suspend.
1: T3 Title has trailing punctuation (.): "[2/2] Bluetooth: btmtksdio: Fix kernel oops when sdio suspend."




---
Regards,
Linux Bluetooth


--===============5238465061573765949==--
