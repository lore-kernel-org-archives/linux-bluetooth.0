Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993CC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 23:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiHPXNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiHPXNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 19:13:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC1C3334E
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 16:13:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo262920pjd.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=7XnaFraax8PyYgmwXiph6gai7onIH+AVrb33iTBX+aE=;
        b=C04EhIiTjUbJA/npn2H9HvXIMwweAnZQ/ypEOdI8KBIzPNLsuOovCtZeyQ8h6+lP+S
         A6DJPICWUcv/QRW1r4Jt7AepmXPIMS/4vmah96q5NKOQfxGmAZeeBP2LWiFKzaGoPiSW
         4xv5KRkcLXr3E2ylpasEm1T941+bS18oUsjcTBMlwOnsFrAWfUr5iabt9RMOReuGraCB
         xkPJGoElnBouIsEAxB5/qxzSHmlBIJhHtbJrRTWqsaUmczV1lIhg5tL+xvUw83VGpVAY
         8LoXRwRjXVPZ7mV4wA445o2DMIh7Io0UVYG96vt7QDyl/PqiGYnZxOUjw1loG5z2WRiZ
         O1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=7XnaFraax8PyYgmwXiph6gai7onIH+AVrb33iTBX+aE=;
        b=sDqjqDnNK/YIgddd+FFjz6NGT9hnHEkCkTInQEuIMtp6clIE7NIVWCIFuHdIjBoqCq
         uVzuYSJCgrMxQzu3qvNxRJvekqr5SoSoXoz3HST/3UOwjv+NyvzoNuaI628z2cKcTH6b
         bkcIxJwwhyG1Xk0LXEG+9fK5bK2ACQwLKMfbuZDHj11CSBkvPQQFfcfsSTo9Mw4M8KII
         /cE8N6ts4Wribm5ZobvXkQHrMLYSDBx2tcHU4rZxjCuVTlyn9EblKXeEZczbppC3e3W3
         /GGDWYIRWtSOPxj4frLEiqxcjVfLBOi9pS4oZJ1rF7pJH16Zn0OUDSN3Q6WEbTMtYwpW
         eH0g==
X-Gm-Message-State: ACgBeo0wrcT7AMrZNntFWxbD+v3WxdXCeUgBF/8C9oRHZyhxP93BBK/W
        kHIajsDjep6Qv7SkeHE1tNMKDFdowSQ=
X-Google-Smtp-Source: AA6agR6ZydGjm4+JSWUFVRS3SI6syQJlC7++A37JK3nZLpv4bmkLGroV21qlB+UmkpF8gC6zlkauXw==
X-Received: by 2002:a17:903:25d2:b0:16e:e1c9:e0eb with SMTP id jc18-20020a17090325d200b0016ee1c9e0ebmr23388611plb.92.1660691632470;
        Tue, 16 Aug 2022 16:13:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.252.12])
        by smtp.gmail.com with ESMTPSA id a8-20020aa79708000000b0052e6c058bccsm8918784pfg.61.2022.08.16.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:13:52 -0700 (PDT)
Message-ID: <62fc24b0.a70a0220.b7101.ef6f@mx.google.com>
Date:   Tue, 16 Aug 2022 16:13:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3827120077932144213=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] hog-lib: Don't restrict Report MAP size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220816220548.1555673-1-luiz.dentz@gmail.com>
References: <20220816220548.1555673-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3827120077932144213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668224

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
GitLint                       PASS      0.92 seconds
Prep - Setup ELL              PASS      32.69 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      10.39 seconds
Build - Make                  PASS      991.54 seconds
Make Check                    PASS      12.29 seconds
Make Check w/Valgrind         PASS      345.94 seconds
Make Distcheck                PASS      295.42 seconds
Build w/ext ELL - Configure   PASS      10.63 seconds
Build w/ext ELL - Make        PASS      98.58 seconds
Incremental Build w/ patches  PASS      234.28 seconds
Scan Build                    PASS      617.84 seconds



---
Regards,
Linux Bluetooth


--===============3827120077932144213==--
