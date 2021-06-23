Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A940AC4743C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 05:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858D760FE9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 05:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWFIM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 01:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFWFIM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 01:08:12 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAAEC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 22:05:54 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y29so520379qky.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iKvzUk+T1S18ZHmkzJ7gsjD3t5bJax9bxrors+jV7ps=;
        b=prXSmp0kyvDvtdewgqO7E23hBjgfseE10hMWhcVfMK3d5u7lMOiNFfk0IQOVGQ6Tdg
         SAFQ0PebgbALu4LbSYqUtuVeAPG+eqU0YeUggBOeWB3BwPR+0cJ3Xdw7ajuFPfQWAWZR
         5R0l8o+/5LEFICAvgK6yOepkdH1x9rBh/5YZMCINYM5tSlwGfv9uH13qyILDXWJN2Tet
         UbzG2AevgsAU7xx0qaiMOtlioDZZoVmNkDljr5NsXF3yaDkgwT6H+bUoDs4VJJnwGM88
         7PHuUJgzdUUKOeuo/t6VhE85Mxn/0ps4e6MUldU3Casv8Q2CJF6O8r1nhlKSIyjo8SZC
         7xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iKvzUk+T1S18ZHmkzJ7gsjD3t5bJax9bxrors+jV7ps=;
        b=UIfGD2tpq5F7zJyTtmqJccMXi6P0XzCRoRNeZoqUFaKTEoftVXxJ7xgg43RS+MzJ81
         kHIQe9OxbFhnlq6tLMuL/H0yKkwv8k56EpSWXbh6xSGhlzc8R4eLSRFDrguuPR5AvmRl
         bCBLd9mtXz5iDFm9kgHvJT6+i6CkLzgUq8GyD95Cy5idH/pLJ5V0G7qyUWQS+793QkZe
         On8S5DxhwU2MKUIRJhKIemxeqSpSwZpaxnyeBCBGfBEH/ZnO+OBDginXn1pVKuGn/zck
         f6JVunJFqW1aEBUKgpSHqRuChmWsxTKIlF3KzOMwiU19TgfFKBoFZRiqjJCAnmi66QTX
         n4Jw==
X-Gm-Message-State: AOAM532JJgbQL7KyOSxIB3oQf8TF/17A56LWRRjgXvqBRly3Q0j5kTG1
        WC7tnCQdvnWq1VVawnUO033YTsWRjvGG9Q==
X-Google-Smtp-Source: ABdhPJzMjtBm8Z9hWdXFyAn755AWogkw3hBLyxFinxNoTEVK6dvMXCfsZoJRBdH8MHKNOxkdoj/5AQ==
X-Received: by 2002:a37:62cb:: with SMTP id w194mr8056276qkb.83.1624424753586;
        Tue, 22 Jun 2021 22:05:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.252.234])
        by smtp.gmail.com with ESMTPSA id 200sm14523620qkk.12.2021.06.22.22.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 22:05:53 -0700 (PDT)
Message-ID: <60d2c131.1c69fb81.7b32d.c122@mx.google.com>
Date:   Tue, 22 Jun 2021 22:05:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7322318129163441653=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2,1/5] tools/mgmt-tester: Enable High-Speed(HS) test cases
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210623044944.602205-1-hj.tedd.an@gmail.com>
References: <20210623044944.602205-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7322318129163441653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=505495

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      0.56 seconds
Prep - Setup ELL              PASS      40.42 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.04 seconds
Build - Make                  PASS      174.30 seconds
Make Check                    PASS      8.99 seconds
Make Distcheck                PASS      205.52 seconds
Build w/ext ELL - Configure   PASS      7.06 seconds
Build w/ext ELL - Make        PASS      164.15 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============7322318129163441653==--
