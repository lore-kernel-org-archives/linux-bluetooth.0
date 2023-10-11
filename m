Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7387CD98EB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 03:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjJKDlw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 23:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJKDlv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 23:41:51 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F292
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 20:41:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1dcdfeb7e44so4365179fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995706; x=1697600506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BgqbPNN1o5fpSSuBl3VAHfHZd48TlaE8ghAjsnHUEsc=;
        b=Q9EpNA/HJXOvtzZkRZGzbk2qdMc1s9f91oMeoXwnURLkV97rnHDIuIldCE5FcTytnt
         m6nRrvw6/dFpK4UIPS2ce53qHEAzEK+ZJQURhAwtMAuKS6DelNyaMfr/Fzeg3Wn0Rr9E
         38XlZb+gA75qsjJqMxishHRqRMkQuSi0n2bfMuzv5+z+Y2BuVpTKeJU02GsKek0mpViK
         50KasYR7jBm1CoyDo7+8qrJwe1ccFerjEUUjkvOtxTxYrnQ0VHqHI8hsLMtft5xYpIRI
         IalhEfu9ixKB6trcrjQwhrLUH4YNNOp8gL6e4vU6NUuW5J5k/a64oM0mmD8vsgJHh47D
         NSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995706; x=1697600506;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgqbPNN1o5fpSSuBl3VAHfHZd48TlaE8ghAjsnHUEsc=;
        b=GAzigxYdi5ASAzjEYQkeZrAcxlY68kTQ89wCBH1/CNYyVrsnlvJKJYfZCnZVYor5xW
         iL0Wh0HbNvo76wlt58NvbSm5Xa3yL2UhOBPfyqCbcWM95fzuJqrjgcHcyNwuiMfA8YD8
         PrSkfqyQXVaDQF3pwtIkKLmDiDftubR2Bo//myI25PpA/cfzPh+hVvTD+BkA7UiwP+5V
         8dvNqPk0ZsaeA0s60ghvTgR2u5q0Fq8OaC8nXpWvlN9TASDeIt+2OY0WahtqLaVnozFE
         z5/HdgHeE6Bh32VWRJq6WdHiGYqZnkjap0P02/+RF7jfsOkXKojx87bwLj7OCnnsErmr
         z8dw==
X-Gm-Message-State: AOJu0YxuYZqDHPg1Ef1PRBxXGVzNhhN4ClxjqpJr4u8hHctbDz/K57ip
        SQYEbmZlnlIX6m+7bh7tyTMWzKLpxTE=
X-Google-Smtp-Source: AGHT+IEbf2MzFY1kYNziLLYdhgxSvNZ0tlly7SqsWLxAoZEa4ng3ya7ov2YrQI79CYVOPo6urbfA/w==
X-Received: by 2002:a05:6870:d38a:b0:1be:fd4e:e36c with SMTP id k10-20020a056870d38a00b001befd4ee36cmr22973551oag.2.1696995706494;
        Tue, 10 Oct 2023 20:41:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.110])
        by smtp.gmail.com with ESMTPSA id n1-20020a9d6f01000000b006c6311b15f6sm2038639otq.38.2023.10.10.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:41:46 -0700 (PDT)
Message-ID: <6526197a.9d0a0220.16ef7.d317@mx.google.com>
Date:   Tue, 10 Oct 2023 20:41:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0572978562215268643=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@126.com
Subject: RE: Bluetooth: btusb: Add date->evt_skb is NULL check
In-Reply-To: <20231011022604.88595-1-wangyouwan@126.com>
References: <20231011022604.88595-1-wangyouwan@126.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0572978562215268643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792019

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      39.90 seconds
CheckAllWarning               PASS      44.21 seconds
CheckSparse                   PASS      51.25 seconds
CheckSmatch                   PASS      139.93 seconds
BuildKernel32                 PASS      40.30 seconds
TestRunnerSetup               PASS      606.11 seconds
TestRunner_l2cap-tester       PASS      35.75 seconds
TestRunner_iso-tester         PASS      65.02 seconds
TestRunner_bnep-tester        PASS      12.83 seconds
TestRunner_mgmt-tester        PASS      258.76 seconds
TestRunner_rfcomm-tester      PASS      18.90 seconds
TestRunner_sco-tester         PASS      22.14 seconds
TestRunner_ioctl-tester       PASS      21.42 seconds
TestRunner_mesh-tester        PASS      15.61 seconds
TestRunner_smp-tester         PASS      16.67 seconds
TestRunner_userchan-tester    PASS      12.93 seconds
IncrementalBuild              PASS      36.96 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add date->evt_skb is NULL check

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (91>80): "[ 6104.969697] FS:  00007f5a1cab9d40(0000) GS:ffff8ad578200000(0000) knlGS:0000000000000000"
36: B1 Line exceeds max length (85>80): "[ 6104.969778] RSP: 002b:00007ffeefe39010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001"


---
Regards,
Linux Bluetooth


--===============0572978562215268643==--
