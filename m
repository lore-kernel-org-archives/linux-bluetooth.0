Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93243FA3741
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 03:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ2DHh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Oct 2022 23:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJ2DH1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Oct 2022 23:07:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D618B093
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 20:07:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 4so6430430pli.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 20:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0TP2Cp+X3fgx85/UFVxGkbzPex2J+oPD9FwXWwoH9V0=;
        b=qfIDK0UAoNdtnOIgjsCMfBUnpyKZRY/dsh2c3XoBh2hbxAsi6T99rMfGADvwtJ2+jF
         f50DDSfKOJTsyE/pVZOXc2k95mgTJCl8Fe5K1OhXV+K86TjAlEgZj8XPJabAfP3sEzWL
         gVA5u/QBPNLyA1GLb5W5hVJh/e3J88Su2ua98quQS/3sYVeihEwC4L/ISz0X0cDdEihk
         72A3V+1FFP/pMhTA9/sBNx1noE7r6jCFGd5WQIA7fWtuNbYT3IxK9rbzF3VJ0o7r+J9w
         bkcYhAlAReraNJILfGFs7DWUxtuDt1g933xUUf0A2V84pagc1qx5cpdp+nW3FX2u846y
         nYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TP2Cp+X3fgx85/UFVxGkbzPex2J+oPD9FwXWwoH9V0=;
        b=jylhIk6TplFzUHOxaxPNbJYnrS0/qd3QSNRDlBfLLWaccguKf6iD04LiLH1BDECCbQ
         Ev8OIxksPBnwx2Nk4PnC9cOZPGOrj0iJsh1ByI4Nv9a8euNM2ecMRTtjHTgBbzjR/tCw
         lCbdQLnB+ExIycLaCaqUt+mR7oo4JxDJYd28fD3upuBnEUI8f106Y5kiGIs0yEj6YA3F
         MdppA7PZ9y3IGNPZkUiImUCLhFI5TMnAZgJuewf4Rou8Ot5bbP8th6tO1BXqcz3GH35o
         FbD6mFDxqHpFtr3eTyrhC9UCnVgHHiTlsOLflYeXn1jf0U6GjZ1+U2iWrmeZN5hZmR3g
         vYYg==
X-Gm-Message-State: ACrzQf1qSq8K0BKX/Bb4zaK6WUSDJ1+rjK4EQVF+AQmZEF/ezKIfNGIu
        UM+Dp3PltRksBZjj9b/z/NQsKznq7Dg=
X-Google-Smtp-Source: AMsMyM5nd5ByPhe8Y9QdGksDJ8Q87yAiJDhZ83FCX3psw9Uv/eebgobSeS19Y7h+NvAXSPyaC8ulUA==
X-Received: by 2002:a17:902:e54b:b0:186:5fba:13a5 with SMTP id n11-20020a170902e54b00b001865fba13a5mr2309079plf.173.1667012834638;
        Fri, 28 Oct 2022 20:07:14 -0700 (PDT)
Received: from [172.17.0.2] ([104.42.100.154])
        by smtp.gmail.com with ESMTPSA id y72-20020a62ce4b000000b0056b9d9e2521sm165815pfg.177.2022.10.28.20.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:07:14 -0700 (PDT)
Message-ID: <635c98e2.620a0220.7d3f7.0753@mx.google.com>
Date:   Fri, 28 Oct 2022 20:07:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7672820831282554256=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] tools/test-runner: Remove bluetooth.enable_ecred
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221028234712.2213561-1-luiz.dentz@gmail.com>
References: <20221028234712.2213561-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7672820831282554256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690053

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.46 seconds
Prep - Setup ELL              PASS      32.13 seconds
Build - Prep                  PASS      0.82 seconds
Build - Configure             PASS      9.93 seconds
Build - Make                  PASS      1054.07 seconds
Make Check                    PASS      12.67 seconds
Make Check w/Valgrind         PASS      347.68 seconds
Make Distcheck                PASS      291.17 seconds
Build w/ext ELL - Configure   PASS      10.33 seconds
Build w/ext ELL - Make        PASS      106.40 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      658.46 seconds



---
Regards,
Linux Bluetooth


--===============7672820831282554256==--
