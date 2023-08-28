Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5FCC71153
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 20:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjH1UiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjH1Uhk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 16:37:40 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08934109
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:37:38 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-44d5696fad1so928698137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693255057; x=1693859857;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=96sRxHDbwZ+2XS5zKg5CUdx/osFBawCKajR7byOXCfY=;
        b=azuh57wBknC4jVLE3ZVcAcUDKXY74cuaPl2HrlfgcGneETTPjF0glmecxxq7BbZmD2
         jbCEMOCL0vc7W03/rmIyFDWixcfvIxP6QAduMariuv4/F9O6X9uGCy36Bs6PKqZTFSOn
         s/zwhuTSiUbz+uKwssuH7J2pii0MzDwG5BdeXtzpr9nQ3GMUDm1Iq9rnZ8Nzln4kIOjV
         m41t74rOdKK32hrx6YSv0ieljJOKPb6dMBfYQ6WHQvK0UKxrIUdWUZqw8GgFl8j5JsHU
         YLvpy/2sLVl9hglXhfNeJ3Ws8NDpZuLmD2kOz9F9t7eyM2sj/XVwlfDdutrbA2s6fN/B
         de/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255057; x=1693859857;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96sRxHDbwZ+2XS5zKg5CUdx/osFBawCKajR7byOXCfY=;
        b=SZoJDkfzgSkwL/jRETGsaH4Y8exw4MVifNFHlA4yRID65TwMXATDB/+3wB9ubospXA
         rHbG+m9rpE9d14Sr9QO0VJESvfBsCgmfiGiuM0VqXBQYi75niGmvkOlbp80PgYVU8T2U
         4mEBnyhVE0OFqqxwPRe8fQPx4NUTnGmOBaZwX5RPVJCWqJ5JhPzSa0E3Efzm1SavS81u
         tZeps2f3OewUlp6YiBM0ERAnDfMRYilsaad2ca0safpJgcsLfM6GSApZh072UTCfDqBZ
         7dNTcQ6w3yrPkwFgpDrhz48o9NoYXZHU8lZeguvIktGON6cEPQz6/e1av7v2XKGHTUEP
         T3Pw==
X-Gm-Message-State: AOJu0YyKDoSnHRWLIqEOd/g4AiTN3FNfvJkU6ZcRbSl6jql7vUWt2pmX
        cf+LP6BSmEXZVtEXaLfAq2SE+qL0Z6svbw==
X-Google-Smtp-Source: AGHT+IFnmOYHPXtuLhNAjh+Jm6twvW21w76vCITuJXPHp0cQ/OxFZIzMMLt9/yiTUJkBTpzzqXA/Yw==
X-Received: by 2002:a67:f7c9:0:b0:44e:8df0:f51d with SMTP id a9-20020a67f7c9000000b0044e8df0f51dmr9703326vsp.24.1693255057028;
        Mon, 28 Aug 2023 13:37:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.70.194])
        by smtp.gmail.com with ESMTPSA id w17-20020a0cb551000000b0064f4f14aecesm2837514qvd.24.2023.08.28.13.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:37:36 -0700 (PDT)
Message-ID: <64ed0590.0c0a0220.fc657.a17f@mx.google.com>
Date:   Mon, 28 Aug 2023 13:37:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8785433926220039201=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Fix handling os listen for unicast
In-Reply-To: <20230828200345.579455-1-luiz.dentz@gmail.com>
References: <20230828200345.579455-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8785433926220039201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780042

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.16 seconds
CheckAllWarning               PASS      37.18 seconds
CheckSparse                   PASS      43.02 seconds
CheckSmatch                   PASS      114.56 seconds
BuildKernel32                 PASS      32.69 seconds
TestRunnerSetup               PASS      498.36 seconds
TestRunner_l2cap-tester       PASS      29.22 seconds
TestRunner_iso-tester         PASS      52.48 seconds
TestRunner_bnep-tester        PASS      11.28 seconds
TestRunner_mgmt-tester        PASS      227.01 seconds
TestRunner_rfcomm-tester      PASS      17.22 seconds
TestRunner_sco-tester         PASS      21.43 seconds
TestRunner_ioctl-tester       PASS      19.12 seconds
TestRunner_mesh-tester        PASS      14.24 seconds
TestRunner_smp-tester         PASS      15.30 seconds
TestRunner_userchan-tester    PASS      12.04 seconds
IncrementalBuild              PASS      31.21 seconds



---
Regards,
Linux Bluetooth


--===============8785433926220039201==--
