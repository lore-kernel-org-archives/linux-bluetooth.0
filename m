Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D74C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 22:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKDWYA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 18:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKDWX4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 18:23:56 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C7349B60
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 15:23:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 11so4930661iou.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bRZjEhRVUT2Mt4yDI+DW072Q+mJ31XQ4+eI/SuQp2Zo=;
        b=FGIMXKwJyXFgbMEXu4ywa+xqU8xy6KsyFwBkNyKfvui9QgxNvneQ8WyLhIatFJlqzp
         WjonqSQcIU/0a5PPFmUzlLLVVnX/A/Mra53TlFn3ftXHSM0RqcH7E5WQUJ5/BzAGSBXL
         CTG8RpQuFrFrqT8IM9C/asXcuC0v2+fxysQEl/ThoOOJ57dP+vd71Tms9skfWYpFidl8
         IqHKIC4cYiLvGMpJkGAxBBeBZl+yngPFWPHfnIDiBgLkbyQGRJ2LugZtlASbf/tRTIob
         /zEEsEOwGqnx4cOfxMsaQlpk2jEf8In9pch6W9eFTB3o6Qhm93AaqRoxnE/FLVeBUhog
         poLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRZjEhRVUT2Mt4yDI+DW072Q+mJ31XQ4+eI/SuQp2Zo=;
        b=flz/JnDGaL5JlRVm8yZI2lomJqFWtP93hAXyNVVZ9S15Cqi9FRDblbHCJ2luNNp4RX
         l2VWvvdmDGvgkoayEAJRkZzIIGd3yW+pYtRV/fvUjJD5SB+hji3h5nDYCUEG2j1Ub6ID
         T2NSzSMXGycMEGz2XBrdMMuru3fcTujcbE241eK1KTk6y8+XJJSkqwVJACZCrVi80Jzq
         1U39KKL/D+kY9OLfc79vFCF6jnL5D+5K/s0x0Bd7uf7bmueRIupXGQX/QoZzB4PDe/Sj
         CjwTJdfNmdZsoezIpu15ShS3Pr6HxP4kJiSJ67ZL/m+sgZYhDTQ5Ay8pSMLU4dC/egnq
         c8Vg==
X-Gm-Message-State: ACrzQf05Ltti7iySQwKxk6MCkRdjFBIF5ZQoG9d7RCQBjlaityw6GNsr
        6Vqp2CLWLyFqL23nx5jjiPYFNFort00=
X-Google-Smtp-Source: AMsMyM7vklnxk5LYSjM8bsYVJZe3W9BYbFvHqUiRjKq2P/JD0zd5Dg3EBtCQ00v3I3QP+obfd2xVEg==
X-Received: by 2002:a6b:2a05:0:b0:6cf:e8d4:9206 with SMTP id q5-20020a6b2a05000000b006cfe8d49206mr19660496ioq.135.1667600634442;
        Fri, 04 Nov 2022 15:23:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.83.176])
        by smtp.gmail.com with ESMTPSA id z63-20020a0293c5000000b003738c0a80b4sm65009jah.144.2022.11.04.15.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:23:54 -0700 (PDT)
Message-ID: <636590fa.020a0220.7579a.01ea@mx.google.com>
Date:   Fri, 04 Nov 2022 15:23:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8300571016266576883=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor/att: Add handler support for Read by Type
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221104213649.36925-1-luiz.dentz@gmail.com>
References: <20221104213649.36925-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8300571016266576883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=692284

---Test result---

Test Summary:
CheckPatch                    PASS      2.48 seconds
GitLint                       PASS      1.63 seconds
Prep - Setup ELL              PASS      26.72 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      8.59 seconds
Build - Make                  PASS      822.68 seconds
Make Check                    PASS      11.56 seconds
Make Check w/Valgrind         PASS      292.16 seconds
Make Distcheck                PASS      237.97 seconds
Build w/ext ELL - Configure   PASS      8.62 seconds
Build w/ext ELL - Make        PASS      85.40 seconds
Incremental Build w/ patches  PASS      204.50 seconds
Scan Build                    PASS      603.42 seconds



---
Regards,
Linux Bluetooth


--===============8300571016266576883==--
