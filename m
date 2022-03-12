Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C411C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 01:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiCLBZe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 20:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLBZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 20:25:34 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3722180221
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 17:24:29 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b67so8434336qkc.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 17:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8FTTpKjAK1toKhKmoJcYsSrrkz5xHnrYtMHw3+T6OEY=;
        b=Wy68CmBauL11LgNUtuo8HfIEqBMhZG6kMfJqXKcSWxwsko7Sl4R7s9vw512Ar8QIuL
         ggbw0zduJPzu70lcr/HLuJ+8O93VO3t26aNvwOW9qLWyfP1D1cU+j6/bcnVI45M6J2Zo
         dUvTydhcEQ+58fiZleEfqVntDV9wJXW4g5B/PSPXMGqZrxDv171u+1Gnzj2xtbniTy5d
         McNmXXKBVORPBZbVAoNCrY+T7yvSQZmodS/IQ8VRBlzqbfF0+8CuMG6kOF8Zb3ISlxKL
         jeQ9eAGNNtTfSXoUJjggxF9Lwrb+wGCjKZ8Me+3IH9HDEX6ze1nBZxLm/2caQFX9a/dV
         BAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8FTTpKjAK1toKhKmoJcYsSrrkz5xHnrYtMHw3+T6OEY=;
        b=W3vMaQukBqwNGkFVYa9WtvWdqBhhs8blslilzuHINt88lss/D0uLG4qvbGtuP8WbYH
         TeNiIejQc3uEnvmtjTo/eU4/5g26WAa8oBsWNtlQKsb4qXg61lWYaTv6mcMiDw+DPiqf
         ahgUZMC3d8EGFjf6HeEvwsQSr1DV63GTvU0C8xG+2XvBdIuRlsWOaVeNs2w0sVMiFhHB
         FrjIyX/monJZWf9eQqmoTdkAg48dq0KYVABDKMixDd2hHNYkgak+tUH4gCVo8j2eGrtA
         coTy1IC2VsrA5Y+r51mKDbAj8TXUyelsKlxXmb1LdbwI/9td5drO9OjyC5B19JoYK8bM
         MBaQ==
X-Gm-Message-State: AOAM533EO3fCIzvgj1dR8GbmGzxwbiXbI/0QH4GLZGOZ5DbXv/pR5SHM
        Vdq8doSLxQxVdqWImxQ7ii6wDWSAgEd32A==
X-Google-Smtp-Source: ABdhPJyEP3u2HZmbmnCCpCTrgImcBPmm0PA+SoDjoxR6vUQwNqLzsPA5YIswk9dugs7z+V+yuppPhw==
X-Received: by 2002:a05:620a:1210:b0:67b:3fc4:b7a7 with SMTP id u16-20020a05620a121000b0067b3fc4b7a7mr8297903qkj.114.1647048268698;
        Fri, 11 Mar 2022 17:24:28 -0800 (PST)
Received: from [172.17.0.2] ([20.231.123.102])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a288100b0067b1be3201bsm4571809qkp.112.2022.03.11.17.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 17:24:28 -0800 (PST)
Message-ID: <622bf64c.1c69fb81.9fb3a.bce8@mx.google.com>
Date:   Fri, 11 Mar 2022 17:24:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5201937166198049099=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] bthost: Fix not setting all parameters when using Create BIG cmd
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220311211730.3285028-1-luiz.dentz@gmail.com>
References: <20220311211730.3285028-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5201937166198049099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=622790

---Test result---

Test Summary:
CheckPatch                    PASS      3.05 seconds
GitLint                       PASS      2.12 seconds
Prep - Setup ELL              PASS      55.50 seconds
Build - Prep                  PASS      0.88 seconds
Build - Configure             PASS      11.01 seconds
Build - Make                  PASS      1549.91 seconds
Make Check                    PASS      12.81 seconds
Make Check w/Valgrind         PASS      566.40 seconds
Make Distcheck                PASS      295.67 seconds
Build w/ext ELL - Configure   PASS      11.28 seconds
Build w/ext ELL - Make        PASS      1520.49 seconds
Incremental Build with patchesPASS      3122.33 seconds



---
Regards,
Linux Bluetooth


--===============5201937166198049099==--
