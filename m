Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8473CECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 00:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiINANQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 20:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiINANO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 20:13:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149AA6582B
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 17:13:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so12854480pjh.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 17:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=LGOAYbCebfphpzggogfAGIWZAMRfAp9l2oMgYp4IQs8=;
        b=mWC7WYguoWd/3mhEV0nOhtopa8ope7o9i0WWguZeuzpVKJh4+d+va+aOdyK1zM8zmb
         pvEO79coMA4nLfoJqFpew5TQ4U9qEnMgbXs8e8AfyqZ0XKjOfGy1p2QxgBtV9Ui2vXVm
         dmMvLGSzPOKCo5l3Qr93a5wtqX5O/Lh3oekFS20bcHxxlCC4MTBjjzMKDYe0XMlJqu0k
         A9CjJtmDDdMXXm2+uQwAMg1cZ+8vAG+U/chplOb6Xer6jLZCIS92YNCBD5j5C1Heposv
         tR6znS/s+N/tHOJuy9Os2Kfh1o1zkrDxytid75gN71fuJnKjA3cHfGcRuLHDlyZuyHIA
         pRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=LGOAYbCebfphpzggogfAGIWZAMRfAp9l2oMgYp4IQs8=;
        b=X/HtN4MhR9AHQhXgISr5xrpl/O3IPyAJ/R9fJZuuWHodYSxCW9O5Lv477l5K8CxZn3
         iciJubpDaZFx2TwRTJVRDBC0We9DL2yo/q9GtzmI+jdaAVhacB5g0/VxkQiV1A+w+ilO
         d3RBcf26RPV8oGduGNwYtHyXhIQJlLD17tnV3d60VBG37Av0yyIn6XdqtQW9igWw085j
         DlWsrJw8jWL0cQCeD1kMm+SESojp23R7zWVcmRAf6t4Yx+nDTNLbqlYNfT2FhwXu7V3F
         dD2IUgI2qs43MKbRkplFk+hiNmj6J0WzWunUjNL5r32I+r4+2xF89o4cpOpX/WRiJieI
         lirw==
X-Gm-Message-State: ACgBeo2RDxPosGFVBWM90g0pBy961cInjBCUKLR8fgGECtrf2x4a6LzQ
        7N3/yfcw8hohbATdBGReLDWMY2jJmK4=
X-Google-Smtp-Source: AA6agR66voGJC5dBDtib0qiE/fXDlsOVpIW3++CGIfZRZNWQuSZuWrP2FPg8QBvDWkSvP9tFRzbYdg==
X-Received: by 2002:a17:903:2601:b0:178:a68:82ee with SMTP id jd1-20020a170903260100b001780a6882eemr22306779plb.163.1663114393121;
        Tue, 13 Sep 2022 17:13:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.237.194])
        by smtp.gmail.com with ESMTPSA id g11-20020aa796ab000000b0053bf1f90188sm8709981pfk.176.2022.09.13.17.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 17:13:12 -0700 (PDT)
Message-ID: <63211c98.a70a0220.fc7d7.e5ba@mx.google.com>
Date:   Tue, 13 Sep 2022 17:13:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7358198639069807451=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: RFCOMM: Fix possible deadlock on socket shutdown/release
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220913233157.526041-1-luiz.dentz@gmail.com>
References: <20220913233157.526041-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7358198639069807451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676714

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      45.45 seconds
BuildKernel32                 PASS      40.12 seconds
Incremental Build with patchesPASS      59.47 seconds
TestRunner: Setup             PASS      667.48 seconds
TestRunner: l2cap-tester      PASS      20.48 seconds
TestRunner: iso-tester        PASS      20.45 seconds
TestRunner: bnep-tester       PASS      7.74 seconds
TestRunner: mgmt-tester       PASS      127.19 seconds
TestRunner: rfcomm-tester     PASS      12.53 seconds
TestRunner: sco-tester        PASS      11.90 seconds
TestRunner: smp-tester        PASS      11.79 seconds
TestRunner: userchan-tester   PASS      8.35 seconds

Details
##############################
Test: GitLint - FAIL - 0.47 seconds
Run gitlint with rule in .gitlint
Bluetooth: RFCOMM: Fix possible deadlock on socket shutdown/release
21: B1 Line exceeds max length (101>80): "Link: https://lore.kernel.org/all/CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com/"




---
Regards,
Linux Bluetooth


--===============7358198639069807451==--
