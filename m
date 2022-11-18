Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07122C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 08:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiKRIht (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241691AbiKRIhU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 03:37:20 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4938EB58
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:36:28 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id cg5so2695209qtb.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/QTwHbheUlc8bP5m+Y3FqcuZapXmwANYzMeGSbfP0cw=;
        b=TgiO8fXToSyazaimC3LnUbPcW5A9LEwJ/vhLpbStwOmv1lDEh4TLxvTCHwPj59ax2x
         LE1GbeZWKeoE8Omi3D5J7Ukwb64kHAelAqUEnFNkxh2p24DKFZGVf3OpR2nAoKud8n0Y
         J8m2s7GECW8ywWNZiXREzCvu8JAQAL1btl8QUp2m6JcduGHzjdXHkz6yhmVdORlKkHCk
         CHNWK54f1ElwGkhxvp8lKo/FrULUDvamQJGFWUixR14ry2K+jbxnr44dkgkW9rAx7nIk
         1yqOK6Bc+Uze7CIOyuDymJ7EhBl9h+t+stuwrhi92LcUASPpNpkDNkPrzonjuWBhKTq9
         n+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QTwHbheUlc8bP5m+Y3FqcuZapXmwANYzMeGSbfP0cw=;
        b=14FaXu3dXhTQVhdqx5p85VfpG0hzKqOhCTJTns+Q5c4rOqjdquv+jwNaPm2spJ5tSt
         960/+QgK0ZvwLg6WN0F8KTzlVB1cWSK5aERdoLJ+bSpCdayR7GCkKiLoCVG+iYlj5Or6
         IsEC6hLyQYbNXKRbOCnmsdgcYKCitKj23u2+fdJJJ3wybfS1WEPzF7F82i+ms+LAxHa9
         Uld32ZYy/VYSLmhuw3febxMsCU7QRWeyczWFN14yBoZjizB+FQbxL2/2udDhoEu4JS9y
         6SD76n8IX3kT9kS3b2u+OeK/sxHUMusxUlyrWQD61Sa9UwpgyIbr+izbh6spTbE5l6Tc
         p/RA==
X-Gm-Message-State: ANoB5pm+gOYJzag5vSNzNTx7lE7lwdMSPtfBmDe5G/IuW4tbsLqRh4Pi
        4AGllqt6eajOPTFddAeKE2WfYtfxHz1N0A==
X-Google-Smtp-Source: AA0mqf7lJpsICKrahZruKX38S1HHJ9FqH5eVt+3ftIRCn/9DC6IpqHplfUR0w6s0/SS19E+zkqc95A==
X-Received: by 2002:ac8:7cb1:0:b0:3a5:60db:4d5a with SMTP id z17-20020ac87cb1000000b003a560db4d5amr5778017qtv.467.1668760587269;
        Fri, 18 Nov 2022 00:36:27 -0800 (PST)
Received: from [172.17.0.2] ([20.172.166.213])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a414100b006eea4b5abcesm2015851qko.89.2022.11.18.00.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:36:27 -0800 (PST)
Message-ID: <6377440b.050a0220.a1e9a.a7e0@mx.google.com>
Date:   Fri, 18 Nov 2022 00:36:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1080905967810228818=="
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

--===============1080905967810228818==
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
CheckPatch                    PASS      1.75 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      41.48 seconds
BuildKernel32                 PASS      36.64 seconds
TestRunnerSetup               PASS      505.67 seconds
TestRunner_l2cap-tester       PASS      18.12 seconds
TestRunner_iso-tester         PASS      18.83 seconds
TestRunner_bnep-tester        PASS      6.73 seconds
TestRunner_mgmt-tester        PASS      121.60 seconds
TestRunner_rfcomm-tester      PASS      10.91 seconds
TestRunner_sco-tester         PASS      10.01 seconds
TestRunner_ioctl-tester       PASS      12.12 seconds
TestRunner_mesh-tester        PASS      8.41 seconds
TestRunner_smp-tester         PASS      9.97 seconds
TestRunner_userchan-tester    PASS      6.95 seconds
IncrementalBuild              PASS      46.17 seconds

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


--===============1080905967810228818==--
