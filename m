Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B83C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jul 2022 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiGMQLA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiGMQK5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 12:10:57 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA83F33C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 09:10:56 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f62-20020a9d03c4000000b0061c2c94ab8dso8649458otf.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ifuYpJUtElMYdMNC6sKRDHNgJjC8EhNCTL3azpJwLDQ=;
        b=irwyGLjS2B7ic0e0nme2rmlnKj6r9Q05IbuZ9qkr/72vddHpnO9eb/WK+iTrPfw4rs
         a+Vk6MK2OWDqLRzu+Hnd/fYF1LanC6WlmyUVOohvBtAcFHzsZBuxwLlsWGB7z6sEVvpZ
         R1Xlyk7uSJEer5w4+otlj0SuldGxk4gnNssh6zJX6ESMsTE2U4kgOB/lo2DJQyw+UED/
         QbHYJVBpoFSk62luwM4XTQEqr35eR9E9vJVgxi9PZAYJmKA6clrrYzWWthN/wEthXAbR
         3O2IPISOVHD+5KL8wRTjf3ELt4O00YF8dPASVCmoEcyvPLdbFBIx3wRQFX++L10Sma8Y
         O8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ifuYpJUtElMYdMNC6sKRDHNgJjC8EhNCTL3azpJwLDQ=;
        b=pYLO4ZPIkySJ1wpVg3OPn02KtosZo9QWuQtw+UlcVKD1ZpjjfZ9bqxMqt1VphQbzJs
         5Yzl6Xl4sdJ0eSxXbXeNMdAc/CUV2tskgMo8gOYtkDTiS2PxBb4emRqkYv42akak6DgQ
         co0nvcHQTJcZNZjfor1Zr1GftBoQq18V0yanFVLwQcLIebwvJWCZ61Ier30Ng8JlxjVG
         fG5FIUCV1VX4liYXwxClZM+l89bXATsyCWpk+akM22FqupF0xiQLrLUwojET2NxnbFhi
         oyuKRstdrU3cGnAzu+TW571VmSdOK/CQ5EFxCE3xaxJruTiLR2LuKiM02JXAmtmrGHLR
         qpVw==
X-Gm-Message-State: AJIora9JWu8QYo97o/dPz6o7HrHJNFvtO/ulNmDckZEO7jo5Q8sZ0oRX
        iS1y4p99zp9MB6anFb/8vxqln3r5k4Y=
X-Google-Smtp-Source: AGRyM1t5SMMJH5ng9p47FA73+nXjJJIE1yQQfAOg1w/esJFarZ9JpSZxnTIJ7MPtDK15NASIv9lJJg==
X-Received: by 2002:a05:6830:1da4:b0:61c:388c:cb1f with SMTP id z4-20020a0568301da400b0061c388ccb1fmr1575756oti.210.1657728655644;
        Wed, 13 Jul 2022 09:10:55 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.182.119])
        by smtp.gmail.com with ESMTPSA id x11-20020a056870e38b00b0010c289aafbcsm6099227oad.16.2022.07.13.09.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 09:10:55 -0700 (PDT)
Message-ID: <62ceee8f.1c69fb81.95746.4807@mx.google.com>
Date:   Wed, 13 Jul 2022 09:10:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3567558411658209295=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wavexx@thregr.org
Subject: RE: [v2] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MTK
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220713152913.87328-1-wavexx@thregr.org>
References: <20220713152913.87328-1-wavexx@thregr.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3567558411658209295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659388

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      0.74 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      40.10 seconds
BuildKernel32                 PASS      34.51 seconds
Incremental Build with patchesPASS      47.48 seconds
TestRunner: Setup             PASS      590.85 seconds
TestRunner: l2cap-tester      PASS      19.21 seconds
TestRunner: bnep-tester       PASS      7.11 seconds
TestRunner: mgmt-tester       PASS      112.79 seconds
TestRunner: rfcomm-tester     PASS      10.82 seconds
TestRunner: sco-tester        PASS      10.50 seconds
TestRunner: smp-tester        PASS      10.52 seconds
TestRunner: userchan-tester   PASS      7.35 seconds



---
Regards,
Linux Bluetooth


--===============3567558411658209295==--
