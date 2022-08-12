Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB7C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 23:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiHLXF5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 19:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHLXF4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 19:05:56 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB85C356
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 16:05:54 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10ec41637b3so2470998fac.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=Z76pi3PaaxshFWOmz0yt9YALR1NgVm6DCNwAgPn183I=;
        b=NISq1/Wd0IFnhGxB4qhhIbkdmRWl9TMv2pY51WXGcjGvCfPGtnmrQRoee+TvvEZvd0
         e4D+crHHKVbB7E9t8oFGOAm7v+URGZ9xMjSNwstBgo/Kb0cQz/IGuMpEiSjVJCuT2mgP
         Qizhiy0EnAQBjvnaEpa14DaGlsEhmBiKC8fvx35YijpaEtaAxhcez0cw4+ZjTuYw+lrZ
         SlcPgd2lhno8qiMz4KTh6AbWrfBAkk59uLqhCL+c3F7j83oD32NILsj6VJJdMgeaGbKg
         WwGMQLQdC93s7IDvtIRAG37ofb+Fgaa/P8yaaOKkklPrur6zLW1DhKMW+W/Bk525volR
         M8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Z76pi3PaaxshFWOmz0yt9YALR1NgVm6DCNwAgPn183I=;
        b=wNcJlD3xOAB9yRe6CMAifzZ/Kyv3lqEr47h9H7GxtI33Z6cnDjinhNpAUlmIn4OY2L
         l0pd35P0MAIcSqjbhNgsgxEk/W/omsVN10Zoc2+YRdWviFWfio2UP/Q96HveSVLIjWHS
         fiS9boUj/geVrC4qeITZVBdmN1ns8hrcQ6czyHkTYkqWBN5SrnuJynoclNRhgbTdpr7g
         G9zpJcwqm9P5jrz3MkUcozLVpXNePNBeioDTxm+kgdUh7OUPVzeiPC5CVs/PBEWYjlSU
         yrEMarXV9ZVaZxgx1m4k1Sr07+k0xeRz88qWzFOHJI6OJ7wR2gpJeRk3XkKfGECPoPQt
         M7DA==
X-Gm-Message-State: ACgBeo3vQKpIf/JDXaZILx3Nw5p/sJnLCauY0fX8ZV6/0DrZoRPUqGiU
        /9B9rpfFRxy4Lv9k/IwNaDLHLrKv7+I=
X-Google-Smtp-Source: AA6agR4h7SDESFx9sMvL8T96v+OBomXvM1Twn3xXlrXN3Tk/WLy9Hm5UC8f2yJyHChePzSGISdG2bQ==
X-Received: by 2002:a05:6870:42cb:b0:10f:530:308 with SMTP id z11-20020a05687042cb00b0010f05300308mr2765652oah.294.1660345553597;
        Fri, 12 Aug 2022 16:05:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.155.75])
        by smtp.gmail.com with ESMTPSA id o39-20020a05687107a700b0011382da43aesm183722oap.16.2022.08.12.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 16:05:53 -0700 (PDT)
Message-ID: <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
Date:   Fri, 12 Aug 2022 16:05:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8855571970606082894=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix build errors in some archs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220812223939.530428-1-luiz.dentz@gmail.com>
References: <20220812223939.530428-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8855571970606082894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 PASS      0.58 seconds
BuildKernel                   PASS      39.92 seconds
BuildKernel32                 PASS      35.20 seconds
Incremental Build with patchesPASS      49.68 seconds
TestRunner: Setup             PASS      584.32 seconds
TestRunner: l2cap-tester      PASS      19.76 seconds
TestRunner: bnep-tester       PASS      7.80 seconds
TestRunner: mgmt-tester       PASS      118.02 seconds
TestRunner: rfcomm-tester     PASS      11.69 seconds
TestRunner: sco-tester        PASS      11.30 seconds
TestRunner: smp-tester        PASS      11.48 seconds
TestRunner: userchan-tester   PASS      8.07 seconds



---
Regards,
Linux Bluetooth


--===============8855571970606082894==--
