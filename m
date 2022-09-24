Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C5C07E9D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Sep 2022 15:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIXPFA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Sep 2022 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIXPE5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Sep 2022 11:04:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D9A205CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Sep 2022 08:04:56 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c11so1723088qtw.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Sep 2022 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=3kzT3CKZ1SmKqAl5QeFIvuRppkiHWkMTLzEJ/E1NAU4=;
        b=gjmanheu6eJJaMirJ+E0ZreBnlABc3IGPjuuEqOl5/yJ6Y4D/jkBwVkauioiJWGRHD
         rGJDUWLBuR6RjOL4BFi3jGmW9/QZnU/WVxi6DxgMsKtvPvXfwp7iBndediG45eogdAVZ
         1D7NTJwYDrTbn6aHsviZiGnPcLUxvpFfoepralk4WgZBNXk8cU+n1hHcxiKpd8arlI7g
         ir9uuN3vfkLRgJVMoVEIwtC5D7LW+3uv2b5/8pS8wbiDB5I/VU+wYcxbC8rsFa4Bvzvd
         PAS2zDJrMtdc5r3boQvjAhOuebL0xSGHZHGHXjz2q40u0g8NN5u6CpBFsVVB2EnpHP2C
         lPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=3kzT3CKZ1SmKqAl5QeFIvuRppkiHWkMTLzEJ/E1NAU4=;
        b=RsE2MI7wGnF/Z0it1gjYQoSR7RuTQG18NBl19dgAK/WYJFgY4eBoJDxTfc+7JHmrZd
         20jL05SiPiutOjM6XMI+LuXza848X9l/kTCUoQomaibmegZgp3DmA1MLPb0n2WYqBBFz
         6YryNnW7sAVUryQ4Pwtw07RLHLtckEy4u2/WW+Cd4gJ+RBQhz7yAvVYNdyJiC7t09AMY
         C2mEyEcKDoge5J9PhV8Q3glA94enKHPYVHV7k08H5v/tLQ+8TRttbd/ipTDY83Y8ycRu
         l13u6TNMYIvGVObjj1PrpyUgtWAOH1BYVn1bbFrnjLjOpDWHa/309C8nnPmeOgp8aztX
         Gr7g==
X-Gm-Message-State: ACrzQf0xUpMWZuv4vlqTAMq/XyNGUdp7SmEbAlOihdWoo7QuqddyISwa
        iQDWPBIEQx+crSrv9l0EUqtKIIstKHY=
X-Google-Smtp-Source: AMsMyM62DoG2AfYHIBHFdTrWCX2Lu5+R+y30yTELjmongtgK77i/28CwFK4XsqhAxBwyg1NjVLqvvg==
X-Received: by 2002:ac8:7fcd:0:b0:35c:c2ad:bc78 with SMTP id b13-20020ac87fcd000000b0035cc2adbc78mr11493101qtk.671.1664031895193;
        Sat, 24 Sep 2022 08:04:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.73.239])
        by smtp.gmail.com with ESMTPSA id bj36-20020a05620a192400b006ceb8f36302sm8196710qkb.71.2022.09.24.08.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:04:55 -0700 (PDT)
Message-ID: <632f1c97.050a0220.44105.ca6a@mx.google.com>
Date:   Sat, 24 Sep 2022 08:04:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8368335523250587579=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luca@z3ntu.xyz
Subject: RE: [v3] dt-bindings: bluetooth: broadcom: add BCM43430A0 & BCM43430A1
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220924142154.14217-1-luca@z3ntu.xyz>
References: <20220924142154.14217-1-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8368335523250587579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=680145

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
GitLint                       PASS      1.07 seconds
SubjectPrefix                 FAIL      0.90 seconds
BuildKernel                   PASS      34.77 seconds
BuildKernel32                 PASS      31.30 seconds
Incremental Build with patchesPASS      45.59 seconds
TestRunner: Setup             PASS      513.04 seconds
TestRunner: l2cap-tester      PASS      17.24 seconds
TestRunner: iso-tester        PASS      16.11 seconds
TestRunner: bnep-tester       PASS      6.59 seconds
TestRunner: mgmt-tester       PASS      104.39 seconds
TestRunner: rfcomm-tester     PASS      10.43 seconds
TestRunner: sco-tester        PASS      9.81 seconds
TestRunner: ioctl-tester      PASS      11.00 seconds
TestRunner: smp-tester        PASS      9.94 seconds
TestRunner: userchan-tester   PASS      6.86 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.90 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8368335523250587579==--
