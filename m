Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 15:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiEZPjp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiEZPjn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 11:39:43 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4563BDA3A
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 08:39:41 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-f16a3e0529so2639322fac.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VfsypV0iXHqf8GH2h/CRZJ1e8ILpBuUf9SK3Scs9+1A=;
        b=UgSGHnWhDCoqnWyFfGJVui/gjF5tAjol+VXiXeNi+EF3+PFdNjYZfCisM0WJtoaKBX
         ji+r7xyyfj8j5wViK2jCyD5RhkB2RKqTNi77OEhb/JP+lhcd7DQ9WqXLE7Tko1HTwz9/
         V+3nxCw14leTLSm9IffRMKrsDmhBI4zg3w2Xkfy12V2fRC7OKhhu72ZoPIGeO96zEaKv
         XYKgIi/KfAJWks6XVeuUZEEeqCCqf2/c84Y30h6yWxq9FlLKtE55nD1cHZfkXpoFGr26
         GYPZIpaQ3pzGh/G70V5IycWNmlUePtt01O2n85Tdn9f0U8EPW5LEDdjQXDpPAIpERPIQ
         tu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VfsypV0iXHqf8GH2h/CRZJ1e8ILpBuUf9SK3Scs9+1A=;
        b=bPNpPuVe7gTY41dekIojNRCt4y/plWlNUylrV2/GMBjaZLVzaxUYjfam12jNHwKZeN
         bqDzlM4yzsoK1tR01Bl6kx5ZVTCZq2qgmlnxrJi4ZKGmUwdPMwchOH+FwXl3mFSCANBy
         ZzXmS0td641WBZmLHKln3kaFGSDtUDcrK+wiHL1/202a506W3UyQAZAD969JoZkcg1f3
         F86Vdm7XzzV0rIe+q6wbxz2AI6iwifeEF3gIXsvmyHf8k1n77AboH7Fqr7uGGkpzZ/5U
         1ykykLFGhNO9ETS0+1/lBXXkjvmP8jcyV+4GUXnSANPaC5meIpZdDbzJlShItrwQ1EvT
         he7Q==
X-Gm-Message-State: AOAM530OcqaisrzjAmXy+WeC7QtSsV22fyCnlgaKcduUZoZvWcskLZ17
        zGJBm8EeTBjjvdu+QqcsgjxMvQlMS44+sw==
X-Google-Smtp-Source: ABdhPJyftmCoeYHzfsTJkhPPkBJl6570MomkhvWKCKUhjMglGWiv1nNjCdPj2MjjWJcO7Wa9JXZ3zg==
X-Received: by 2002:a05:6870:b616:b0:e2:f8bb:5eb with SMTP id cm22-20020a056870b61600b000e2f8bb05ebmr1564694oab.218.1653579579989;
        Thu, 26 May 2022 08:39:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.210.213])
        by smtp.gmail.com with ESMTPSA id s17-20020a056870631100b000f2c0ec657asm782809oao.0.2022.05.26.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 08:39:38 -0700 (PDT)
Message-ID: <628f9f3a.1c69fb81.49317.594e@mx.google.com>
Date:   Thu, 26 May 2022 08:39:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6369354455691373126=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v6,1/8] doc: Introduce the quality report command and event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220526112456.2488536-1-josephsih@chromium.org>
References: <20220526112456.2488536-1-josephsih@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6369354455691373126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=645249

---Test result---

Test Summary:
CheckPatch                    PASS      8.83 seconds
GitLint                       FAIL      5.88 seconds
Prep - Setup ELL              PASS      43.76 seconds
Build - Prep                  PASS      0.56 seconds
Build - Configure             PASS      8.53 seconds
Build - Make                  PASS      1334.80 seconds
Make Check                    PASS      11.63 seconds
Make Check w/Valgrind         PASS      458.89 seconds
Make Distcheck                PASS      239.06 seconds
Build w/ext ELL - Configure   PASS      8.89 seconds
Build w/ext ELL - Make        PASS      1320.90 seconds
Incremental Build with patchesPASS      10678.68 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,v6,2/8] lib: Add structures and constants for quality report command and event
1: T1 Title exceeds max length (85>80): "[BlueZ,v6,2/8] lib: Add structures and constants for quality report command and event"




---
Regards,
Linux Bluetooth


--===============6369354455691373126==--
