Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0855FC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 12:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiGVMCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiGVMCB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 08:02:01 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC621E3E
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 05:02:00 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j11so3274652qvt.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yDtfjOlNmC0XJd4MMqOO04842YAQfjJs0ZDmGWWTEzk=;
        b=IdgPVduL2DrvbHpZbF7Qx87cVZ0/oxqivWoOq+MVzvZZctDxsi+mdujL/fcakBe7Pb
         hEeGPKQRxdaPkxPUJIO4I+TZ7V7qXyWrdQj64MSnHZmvejJPy1kGMjOnxUJLbtWqGbGg
         I89a+Hk5+t70YR6iN2KHv5T2eymCPJlv0a8g0OOjFH8rlDvYn6qMB+tASEMqtAc4bOdZ
         A/nQuN6GlmcDewyBxwWo/WbfmC9lbF2mafBngKPh/BdIQS/dB3qs2pG5FMI9aexaS8NJ
         gdiPXa4RrDX0sSDANZZMpuF6HI2b8/b0XWXAs45kn86d7W6CwlLrAK0uUEBvI77aP8zy
         8nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yDtfjOlNmC0XJd4MMqOO04842YAQfjJs0ZDmGWWTEzk=;
        b=2sNhNUPkXAblR4cYIBts1rTruQcn88ikf8at7Djd8hLN/Beke/MYTUZ7Kqx8rM0X7E
         96sv2jR6mOAet75D/Fta+y59ryT31iZEBjxKjbp7OWNGZpIy+LIyk5qBCrHDgqfCCVYk
         T5SR1Gk67GL/YFGDHMZ4otknlynV9808IaePajW2cywXWyX4EVH2qU0NuuMfw1fCFK97
         pJmWKAraplsq1GF4ZaOyVaCPuFmugMWDKtlBJxQo7Xx8PXyVUOCkasmTtD6kRQ0EghL0
         cOY9jghg+RfdRogSsYMgCCIgS6OVKZJts+Svq04ybQCWUCauDZVFbV6mUGfwcq45T4tR
         VQIg==
X-Gm-Message-State: AJIora/mEb73YrjQFo08D6Vf+f+ND0Jy6RixhFVJl7LsaED/Tw6i2edf
        zCa29bYyZpRr/GmJteLva1OscMoMztE=
X-Google-Smtp-Source: AGRyM1v1wItCdlTkyPJ3gIv9Wk3RCxEWkc3NrmroEAqGxQvTsOxyk8iolYIcmhzz+EVOTWRjzTy5jA==
X-Received: by 2002:a0c:c506:0:b0:470:8e86:de0 with SMTP id x6-20020a0cc506000000b004708e860de0mr166571qvi.104.1658491318990;
        Fri, 22 Jul 2022 05:01:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.199.74])
        by smtp.gmail.com with ESMTPSA id e19-20020a05620a12d300b006b5905999easm3053005qkl.121.2022.07.22.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 05:01:58 -0700 (PDT)
Message-ID: <62da91b6.1c69fb81.ecf26.855e@mx.google.com>
Date:   Fri, 22 Jul 2022 05:01:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3515496915187409801=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v5] Bluetooth: hci_sync: Remove redundant func definition
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1658488552-24691-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1658488552-24691-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3515496915187409801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662214

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       PASS      1.07 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      35.23 seconds
BuildKernel32                 PASS      31.05 seconds
Incremental Build with patchesPASS      49.16 seconds
TestRunner: Setup             PASS      535.85 seconds
TestRunner: l2cap-tester      PASS      17.28 seconds
TestRunner: bnep-tester       PASS      6.05 seconds
TestRunner: mgmt-tester       PASS      101.05 seconds
TestRunner: rfcomm-tester     PASS      9.41 seconds
TestRunner: sco-tester        PASS      9.45 seconds
TestRunner: smp-tester        PASS      9.24 seconds
TestRunner: userchan-tester   PASS      6.07 seconds



---
Regards,
Linux Bluetooth


--===============3515496915187409801==--
