Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85FC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jul 2022 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiGMVGO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiGMVGH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 17:06:07 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D732EE7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 14:06:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q82so11537991pgq.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6uTgGSguHja0xYEF+nuxmYLxWoL/N5icijZ01vFVfuM=;
        b=i2LtbuEMZdKRD+xyLw9qmsZKpM3p3FnROt8MdqNJg22jF1IIljGt6opDtpgxlqxpJj
         tyFCGA0Jb96nzdderq/BO5t01jrmTGh2K4FBFvMPsFNByTCrFKBRNtvc4JWMqQKdZidZ
         BZXdsc8YCd0ooqMZy4Xe2YXiVrM0kIFqWXLKImh+pRjDmJKY3DeLovji/BL1h7/B+WGA
         mwLl2ODHFQObb4X2iCsPO6CxEO1aJix0K0vWz0JhTMJ/rQfQ/bFFSnFBi9YdK30FjOru
         VmSc/hS/EStjOJaKGZYbLnP0RkJs5pTHpnUCw3xtDmpD4HKXUT7/JpnMjbCT+bTOPv6u
         +aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6uTgGSguHja0xYEF+nuxmYLxWoL/N5icijZ01vFVfuM=;
        b=L5ew6OQOt8VqsG2bkiCvMQ+ZyRwtVQ8eHQbHo3ES7bif2KMWtG0BeLeecGooVVAgMX
         7lAnOZu4ILgGKTkvCLjgNgNahmZo6bLWIvTVxRIFGVHY3MNpMOdkj3KyjdeAScJV2iBL
         4TE3k5Gvt+s5fQkZweJUtCXAunSlQN2BfrJRELn0JCMxCgPD2lRtTZG3leNTltyZFm1R
         stFnSE/XLhjCdZn2SPGs1UAh4puQnXvjN4D4q17W5sKWnamKjRx8RedaAadXiUQX+RD8
         QDwxQyZ09faPj4uYxgQoTteRhmaAly1+1gVsV7shSKAyWsswSvDO8uBsnt5ewDyJCmbp
         d55w==
X-Gm-Message-State: AJIora8tKuSs1YGh42m62ZoGg2bAaNGqeBEal2jldS1YkoMPuSCVO9OG
        Qc0a4O7VemlaITLaR/XFciEyzBNzQ9I=
X-Google-Smtp-Source: AGRyM1uJg2DQBvjtamW99jwGQFYIrTET/0P56Pc+0hwp6x52+E7IfuAQs5fWIR9tWCDKvFLehWHvLg==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr5047517pfi.84.1657746365260;
        Wed, 13 Jul 2022 14:06:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.59.123.148])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709027e4c00b0016c38e5a9fasm8372779pln.242.2022.07.13.14.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:06:04 -0700 (PDT)
Message-ID: <62cf33bc.1c69fb81.78ce0.cf19@mx.google.com>
Date:   Wed, 13 Jul 2022 14:06:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2806101042347094004=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v2] Bluetooth: btusb: mediatek: fix shutdown failure during runtime suspend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <3f1ee6737f092ae6312a7ae6079d341b81c791a5.1657670957.git.objelf@gmail.com>
References: <3f1ee6737f092ae6312a7ae6079d341b81c791a5.1657670957.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2806101042347094004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659440

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      41.55 seconds
BuildKernel32                 PASS      37.70 seconds
Incremental Build with patchesPASS      49.91 seconds
TestRunner: Setup             PASS      620.74 seconds
TestRunner: l2cap-tester      PASS      20.09 seconds
TestRunner: bnep-tester       PASS      7.29 seconds
TestRunner: mgmt-tester       PASS      122.23 seconds
TestRunner: rfcomm-tester     PASS      11.24 seconds
TestRunner: sco-tester        PASS      10.85 seconds
TestRunner: smp-tester        PASS      11.16 seconds
TestRunner: userchan-tester   PASS      7.91 seconds



---
Regards,
Linux Bluetooth


--===============2806101042347094004==--
