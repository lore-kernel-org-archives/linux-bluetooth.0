Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECC8C4708F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 21:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22D5613B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 21:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhFAVNH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbhFAVNG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 17:13:06 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DEDC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 14:11:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id a7so193613qvf.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rg7b/AHy3tNrpv0jD8GaEUbPvXYZQ+E372+Na9WTkNI=;
        b=mjeJHsPwNfY2Hmf6hwyCWpegDFGOCjGdPjL3G2Jhw+JJOuUsy29e4VQOrbnlcFm6sT
         Qb5wE1J2Zu9dzlkKSI/8fxXUjBkauNmjgAwZr9stTl87zBp5HEQv6xyrfvt8vNLMJ0q9
         xhPYwEwsXPh4EiNHc/iQVyThBBZW3guv21mznCHS5VtRMafLlYNwP73UZDqyRm79Bnha
         0cgpnfe4HYuB9KWkf8p6Nm8iMLmo5kciC7fcIA1Vb963gEo/kz+8Qo0OIANO8Y/3Pmul
         mLMoNV4ZeuGKVLXBAQQ768m6HpAmDiVDH1LVU8pE99bsDd6yOKIYMj95E06bLRaAlAQq
         7w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rg7b/AHy3tNrpv0jD8GaEUbPvXYZQ+E372+Na9WTkNI=;
        b=AHTxy/95zIdXDjuePOwuNeDw6tLoPDCeTnEKBQL++w4HmYwEm8k/P58FvbpisoQnMh
         vwDBZqZji8WKgIhWmzCSBg2yxYZjzaoITMHWC1xpNuQ2kgrl12XI+nTbqnt44V/VNR1W
         O+McayyPI1qzG9Natnjwy1FLQ9qI/l7U2lAwM62j3QBt8o1TgfxmmCWHLOMJGcPhlYh6
         rK3BT/y76lvsC0MDjudLc6mBIA1D0jlezHWx5YiPTATg1+ZKakeEtynTR1v89WMvdn9V
         locphq/hs+PoEQ8I6hBisYIJxPUuSqgtai8sx81EJyJcC+AaAcA7cGRgfpqRr2BUT8Aq
         Dz8Q==
X-Gm-Message-State: AOAM531X5kfhV6OA3ydVLODVzGyC8/Ap9rfn9uRmEN6kh5tsMfwS6+33
        6kSHGQEfnzvh2mQKL9H378QMR/CLI7H4tg==
X-Google-Smtp-Source: ABdhPJxOWSzYJIyYCTSEhbQ6lurS3iOlqtp59WvgHXMpkPiyai5BDWscMEWWH+AH7sBWrw6ordytLA==
X-Received: by 2002:a0c:e601:: with SMTP id z1mr24956388qvm.62.1622581882798;
        Tue, 01 Jun 2021 14:11:22 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.60.54])
        by smtp.gmail.com with ESMTPSA id o26sm6989545qtt.11.2021.06.01.14.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 14:11:22 -0700 (PDT)
Message-ID: <60b6a27a.1c69fb81.bf667.fcf2@mx.google.com>
Date:   Tue, 01 Jun 2021 14:11:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0012848605818867662=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,V2,1/3] emulator/btdev: Enable LE Privacy feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210601204918.903327-1-hj.tedd.an@gmail.com>
References: <20210601204918.903327-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0012848605818867662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=492061

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       PASS      0.32 seconds
Prep - Setup ELL              PASS      41.15 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.20 seconds
Build - Make                  PASS      176.25 seconds
Make Check                    PASS      8.86 seconds
Make Distcheck                PASS      208.06 seconds
Build w/ext ELL - Configure   PASS      7.32 seconds
Build w/ext ELL - Make        PASS      166.59 seconds

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


--===============0012848605818867662==--
