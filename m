Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2224C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Mar 2023 14:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCDO5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Mar 2023 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCDO5F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Mar 2023 09:57:05 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3229015CB8
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Mar 2023 06:57:04 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d7so5991872qtr.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Mar 2023 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677941823;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ngef6pQ7mDvngqgb42wmfKKHedysVbnyE/I9SLpseSY=;
        b=c3+kacEdIcRNgkjYEJFAPBDkoKcrP33DWnn2EwW5M1xfAKqaPrZE/VlFWYdc/aAHUi
         UwNehgGudenn8UKVkYNA3RzvNgNjJ3GNjDgZ2A9E1/4Z6PC3Kw8clsSwtupG1aJOA7KN
         tMApPaqGWBAm7ufzpUFeH3dj0QfUCuIHQDNSN1bAW+89IMG9zkzSn4IBNGAAXpO2B7Hd
         6x9Ce2xbU8bT1iHN1A+GYrFiwu7uDYraeB0S1Iulbv4x9FATEYm0B6sC4ADuTK8wzfhu
         Miruio3s3N4kvJDQGNVySq6GTJY/FptN/+IqqP7RcP8DEUdXBmpmiNmVoc2Tax7gwaRu
         okAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677941823;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngef6pQ7mDvngqgb42wmfKKHedysVbnyE/I9SLpseSY=;
        b=HTfxASwSAcp2ChqAcuROfBa2TBF2LhzLq/eCPqYgxXPFOwDMrC1ilFoieUabxSPvV0
         efp+LTSSyWaJTCEQTgAgHlmtUne//ODbrMmLI9t7qgZPopnDqtCu5ja3QFtv9qub9oCb
         AqIqwP4PMwHe0Tuh/ya7AixkMuNXp+UaqQ4N+lGAvPyfnsQ3R2d5O8k1gkSAR/3Wm9OH
         7r7FsrIM8gedjuAO0+xBHRQO59ef3nlmh6qFGtQ6d7PKaAhTh+bkAvolyN/mnppileOq
         CGswI661yP6qqx7N9OoXQSJWTf+Pq+XeHvfbkHTNLyXWS2Rt/RaR0DsKCfZMYNoTbEof
         vByQ==
X-Gm-Message-State: AO0yUKUMAWGINg1uHBTmmloyGoZi5ewxQA6yPU3+4NeW0PUXNcPOz03L
        dyLbPCEtaSFbAYcmdUaqJ7xXh/CpNLY=
X-Google-Smtp-Source: AK7set9JTzFBau342ARCQ3IZione9SO12CaJmt4REz1f13vTP3eO6I5qdFjDm/fn/ApMYc9RatgNwQ==
X-Received: by 2002:a05:622a:15d0:b0:3bc:e507:297 with SMTP id d16-20020a05622a15d000b003bce5070297mr8534101qty.21.1677941823181;
        Sat, 04 Mar 2023 06:57:03 -0800 (PST)
Received: from [172.17.0.2] ([52.226.126.48])
        by smtp.gmail.com with ESMTPSA id l6-20020ac84a86000000b003ba11bfe4fcsm3834049qtq.28.2023.03.04.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 06:57:03 -0800 (PST)
Message-ID: <64035c3f.c80a0220.7ec03.eb1c@mx.google.com>
Date:   Sat, 04 Mar 2023 06:57:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0018631161370205908=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lm0963hack@gmail.com
Subject: RE: [v2,1/1] Bluetooth: fix race condition in hidp_session_thread
In-Reply-To: <20230304142330.7367-1-lm0963hack@gmail.com>
References: <20230304142330.7367-1-lm0963hack@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0018631161370205908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726625

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.22 seconds
CheckAllWarning               PASS      34.86 seconds
CheckSparse                   PASS      40.03 seconds
CheckSmatch                   PASS      107.74 seconds
BuildKernel32                 PASS      31.24 seconds
TestRunnerSetup               PASS      446.15 seconds
TestRunner_l2cap-tester       PASS      16.82 seconds
TestRunner_iso-tester         PASS      17.77 seconds
TestRunner_bnep-tester        PASS      5.76 seconds
TestRunner_mgmt-tester        PASS      113.05 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      8.43 seconds
TestRunner_ioctl-tester       PASS      9.86 seconds
TestRunner_mesh-tester        PASS      7.29 seconds
TestRunner_smp-tester         PASS      8.35 seconds
TestRunner_userchan-tester    PASS      6.00 seconds
IncrementalBuild              PASS      29.26 seconds



---
Regards,
Linux Bluetooth


--===============0018631161370205908==--
