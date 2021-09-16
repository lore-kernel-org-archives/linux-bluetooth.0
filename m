Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2EBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 19:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D116113A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 19:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhIPTcX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhIPTcW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 15:32:22 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA3C061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 12:31:01 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id gs10so4881141qvb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=e6L9KeBVM0iK54wl1xOE5zf2w2bd2EzLjHGod1esdmA=;
        b=gAdyDnDT1AVneIA5UYirmH4iHtslDBnnTOx2k0xH/B1/yopMC8Ns8isXiMj1ExRcom
         yDe0q/QADIqPV0AEwEO9JGu2WL//wozgba2p1x//suwqNAEaIhkgv5uN7B8Hvd0huNEs
         GcNUS6MqLplUmUwOSYh5rVVtCaKHtimrT4PKGCf2TitloeaSGdn+ilKnIlA3Y1uxvrMc
         V9pCMrRf5ccBpxhbOOjKZF1hSzsOyD38DkkNThbKulDHa8PaU2aLcgMd6pOpca+f5mBf
         k3vV3PBZuC+HAtQ8rrsUh3bAheSEGRGHI3lTHI8Z54ra5KNGFZjJ/vwTky5Y3QjBI7AE
         3rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=e6L9KeBVM0iK54wl1xOE5zf2w2bd2EzLjHGod1esdmA=;
        b=MHerskdX6fjt6asKLnJfsVxNjZ89C1LLg+Q0hOj/JWLiU6afdkiVTYhZzrJUOI0fc7
         DHrVyZsrgy+7LZF6T67UK8TzCW/j0ageakgJCoi/+Bsv3PgCRKXPa0YgYVR/9xtSgR6a
         9kxsXG+m9IV73qeX/2biRqH/AKpyrCLCBtqMixI+72ImF7nGvOlRHiN+8sjREHvyo4LH
         aMezGxPmLjPeTmgf9P83s85PI33fWEEjq3lSjSFSV1t/YYMxQB8mTdgKzOo14QUajKeD
         jVo1C9qirYT37LlyzO6O8ruXBi6pVR6WRaLjpSQckCW65tcSuM6uDry94f70e3K12d1Y
         UDEQ==
X-Gm-Message-State: AOAM5321X5rlK6hcWAhSphO2vcP7DV4+fv9VaGtTxFTHhO1eW2gIL1oz
        hIMQLDVWHQlaeyDYdN/fC9PW/TKzkzYj2g==
X-Google-Smtp-Source: ABdhPJynDbTEWEpK4E0tIGKT9ZlO3HSxfEAqV4m0VCimlRNnRTea/StGtoZGlvBKs872/hIjVP7nSg==
X-Received: by 2002:a0c:e052:: with SMTP id y18mr6968002qvk.1.1631820660515;
        Thu, 16 Sep 2021 12:31:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.127.144])
        by smtp.gmail.com with ESMTPSA id j184sm3210982qkd.74.2021.09.16.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:31:00 -0700 (PDT)
Message-ID: <61439b74.1c69fb81.cd793.a8db@mx.google.com>
Date:   Thu, 16 Sep 2021 12:31:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1848924320044148423=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] service: Add btd_service_is_initiator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210916184021.83775-1-luiz.dentz@gmail.com>
References: <20210916184021.83775-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1848924320044148423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=548375

---Test result---

Test Summary:
CheckPatch                    PASS      2.68 seconds
GitLint                       PASS      1.80 seconds
Prep - Setup ELL              PASS      40.71 seconds
Build - Prep                  PASS      0.46 seconds
Build - Configure             PASS      7.46 seconds
Build - Make                  PASS      174.81 seconds
Make Check                    PASS      8.77 seconds
Make Distcheck                PASS      206.27 seconds
Build w/ext ELL - Configure   PASS      7.46 seconds
Build w/ext ELL - Make        PASS      164.85 seconds



---
Regards,
Linux Bluetooth


--===============1848924320044148423==--
