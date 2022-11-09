Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D03DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 10:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiKIKFB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKIKE7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 05:04:59 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F09B6365
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 02:04:58 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id k2so10621416qkk.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A+iZXy9ScfopTlh2W6kUUnQfdEBNqBIsuaMX9T+pP5w=;
        b=jqAPn0sEdW1cvQyDBMSdy6+ymAYTSXQmdzNUXCBu1O2I4rd6/ykEFfPyUJ0Dhv86Lu
         swgoaHnuJnmsII4S41PZqnZGSkLpf1RAyE+8pIdAT+NOycuCNuTNRQTODVORrY3hlNIq
         TP6Z9GFVTnHojItee0yMb47noHaf/+yucQarbCFHcJEbwM26UsIPomimPAqGCHw1P4zz
         qNtTxIx13Yljf2Ug/7rVWuVDQeiZR2/f1d4aKStae4nzRCDgftavnB0ua4GjKA2fpYyG
         KofdruMCMpuVzrD68wyaQ4XQb7l9EYwLLve+DvOsyyMIHe9WaSsrjavA35VobDW83ksr
         Ht1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+iZXy9ScfopTlh2W6kUUnQfdEBNqBIsuaMX9T+pP5w=;
        b=2Rkte/ceX+uAvKJ/2cQxx3Y5lptLN9G55TXnSc0R7CaVej1UN6b4bdU7jcYG1hjGr0
         kEKTM4IrnJxOdmfJLgA889532dgap4ak2m3/ghXkLxxyIs6ktI0uiF8atQzIMuF1P6nf
         HX4t7VPIdQcAkP7fuXwOo+uQrLNSGCUVtcUKw8sZ1zVFCLfK4lC5xMBhUJtSHSj/VB9/
         WiSKLrLWMWceidSrKX7NItnSvXpNi2V1zK3ZFHIio3iIJhT1b2n853Q8eSnUNmLhyY2u
         QzDphDWYusWdMcTEJYpKwIeuoeVb65lwfFlqVVpOOLCvCKtlmuNzmJsRnM2e9t2Gpkm2
         dfEA==
X-Gm-Message-State: ANoB5pnYGlMZdItB/iGj2Sd++V9WU4PGfc4zDIMZAE6uyvT42N2AOoD1
        vvwKVwHHM8kYohMuFS9qHgC5bPt9hSKgaQ==
X-Google-Smtp-Source: AA0mqf7Oo/FzZetk3QYQyKEMotDLF3GTXXzr0Q56WWwRhX5yC9UWHrgr0gmE3bZzsi4+cBczjMROMA==
X-Received: by 2002:ae9:f11a:0:b0:6fa:cbd7:3b7e with SMTP id k26-20020ae9f11a000000b006facbd73b7emr11576636qkg.666.1667988297495;
        Wed, 09 Nov 2022 02:04:57 -0800 (PST)
Received: from [172.17.0.2] ([20.242.53.170])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a269800b006e2d087fd63sm10867891qkp.63.2022.11.09.02.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:04:57 -0800 (PST)
Message-ID: <636b7b49.050a0220.b0ddb.a9be@mx.google.com>
Date:   Wed, 09 Nov 2022 02:04:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6528295710353769388=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chenzhongjin@huawei.com
Subject: RE: Bluetooth: selftest: Fix memleak in test_ecdh()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221109085835.213252-1-chenzhongjin@huawei.com>
References: <20221109085835.213252-1-chenzhongjin@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6528295710353769388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693538

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      34.37 seconds
BuildKernel32                 PASS      31.17 seconds
Incremental Build with patchesPASS      45.95 seconds
TestRunner: Setup             PASS      520.84 seconds
TestRunner: l2cap-tester      PASS      17.46 seconds
TestRunner: iso-tester        PASS      16.43 seconds
TestRunner: bnep-tester       PASS      6.45 seconds
TestRunner: mgmt-tester       PASS      103.78 seconds
TestRunner: rfcomm-tester     PASS      10.32 seconds
TestRunner: sco-tester        PASS      9.67 seconds
TestRunner: ioctl-tester      PASS      10.73 seconds
TestRunner: mesh-tester       PASS      7.63 seconds
TestRunner: smp-tester        PASS      9.51 seconds
TestRunner: userchan-tester   PASS      6.60 seconds



---
Regards,
Linux Bluetooth


--===============6528295710353769388==--
