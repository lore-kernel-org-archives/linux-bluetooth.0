Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE82C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjDSJeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjDSJeA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 05:34:00 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5666C273B
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 02:33:29 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a15so9536278qvn.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681896808; x=1684488808;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+CWFghLwuL7P2kggmFvSvsYQfkLO+BJUp+CNJ3gMmB0=;
        b=s2sHj1BlRi5AOQ3kq5JPrgxtjdP6HidtJR/RG8AjEuFycDQ7ma3uBZUbkSHdt2t69I
         8C4Z2RXHNOMAOB5HUQyB+RcAVpk/ODpCvLUtw9VwhEPgDvkJmKueJtMYhROXfJbiPX+8
         dc2pLQFTMe4WQGpv0P+XNX+d76qbvn4VGEG5+7T3aDao+89dXXj6eOTt577wVhh3g3vB
         6om/iq4rcgmsxai/HgdL+S2hp6Evfn7kaDoZZwfu1pmuqxDfeQdigWiA8VQaIMtYM7qW
         u0didn/FZei6AATP/dwDvQbAr2LiCJsY8AWW60COaC005mVv3DjBNXphqf6TRSJPdVCv
         JTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896808; x=1684488808;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CWFghLwuL7P2kggmFvSvsYQfkLO+BJUp+CNJ3gMmB0=;
        b=e2uE6Vx3D7t5d1eu1hugX15yl9UdneemhH21A/tXlSa2YWDfDNGLs74Qs9ZDfggicD
         G9vEw3RK6JYwLNx/R7Bo8/tR+OzRA4wo2NcohHV+Hd4TPRQWreElixKv2vPIBlOzPS5m
         FRI39DdA26GeEIGbrlu3VJsmyc4DrI9XbtP6G6hnPXlFcSA8IOYKG2NaEtSjHikUwm1B
         iPobdzJ24ujtHVh+CM6ecq24mVNA7iRjuh0iun2y8uF8n1E4lK2I2V2/Z6ycuFXXSHch
         U8g/qFl5xQnaqrDRYSGr06ZpXLv2sV4tykP0LCdGGOGZiMBvHABvsQ9eVcTUv2oDo/n/
         arYQ==
X-Gm-Message-State: AAQBX9c0Bqs2djRtZ76/q9tzsOn5PzjpdwtZK3Pa1ngi0VsJXixWMty3
        Nzbl/kHbjnKiHjrzPfsR542AzV4D4Vg=
X-Google-Smtp-Source: AKy350Zov88enFPFlJqy7Fu/LoJZdrq3LynggkFeibrvm6hxR9ANfPIjguXB3h+uA3pEYYPwQaDq4A==
X-Received: by 2002:ad4:596d:0:b0:5a9:d6dd:271f with SMTP id eq13-20020ad4596d000000b005a9d6dd271fmr2752815qvb.23.1681896808269;
        Wed, 19 Apr 2023 02:33:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.114.139])
        by smtp.gmail.com with ESMTPSA id es13-20020a056214192d00b005e5afa59f3dsm4272734qvb.39.2023.04.19.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 02:33:28 -0700 (PDT)
Message-ID: <643fb568.050a0220.9f7d6.6e99@mx.google.com>
Date:   Wed, 19 Apr 2023 02:33:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1724860680806095354=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Enable flow control before checking boot signature
In-Reply-To: <20230419090346.1671130-1-neeraj.sanjaykale@nxp.com>
References: <20230419090346.1671130-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1724860680806095354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741256

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.23 seconds
CheckAllWarning               PASS      34.90 seconds
CheckSparse                   PASS      39.82 seconds
CheckSmatch                   PASS      109.22 seconds
BuildKernel32                 PASS      30.95 seconds
TestRunnerSetup               PASS      440.73 seconds
TestRunner_l2cap-tester       PASS      16.86 seconds
TestRunner_iso-tester         PASS      20.67 seconds
TestRunner_bnep-tester        PASS      5.59 seconds
TestRunner_mgmt-tester        PASS      115.18 seconds
TestRunner_rfcomm-tester      PASS      8.98 seconds
TestRunner_sco-tester         PASS      8.33 seconds
TestRunner_ioctl-tester       PASS      9.72 seconds
TestRunner_mesh-tester        PASS      7.09 seconds
TestRunner_smp-tester         PASS      8.08 seconds
TestRunner_userchan-tester    PASS      5.84 seconds
IncrementalBuild              PASS      29.67 seconds



---
Regards,
Linux Bluetooth


--===============1724860680806095354==--
