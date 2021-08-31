Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D33DC4320E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 16:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46977610A4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbhHaQwh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhHaQwh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 12:52:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B351C061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 09:51:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j1so12251967pjv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JVxGV7M+MiiHGjDXiq3CdFg3Va1B5aNorDIfeOttdbU=;
        b=P+Oa0I5LbcEjCTBCM/Rf2iyvDwrl2JOxRZrNVauB1rTigqp0lsGsBoRlGmc4y5CLpl
         9/4iXDJ0Vke7CEX8i5QgJRh+7H+SKmT6/4pTDPtTfRfe+JJqSSM61PANzXa3Qu/uQXLF
         S7FBeTfOefX5Q+xJ+Pzrrw4kVIeErk+5IrFiPcZjXqA1OBv0Fhd6Cn6JUDJj6cVl/dIb
         V+HFGPL7MDfBEBDqTLIbg2AzGLWFxK1CPPFHsxx0DfTn0esDKtJ+s5K8YxHUFS7SCq6R
         6WuH73vkTckrfpsAtW38ML067cOrUInDQzgXIUPPFbH+tF/REVWSAo0h48cmBhnR40HP
         gWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JVxGV7M+MiiHGjDXiq3CdFg3Va1B5aNorDIfeOttdbU=;
        b=F0+e2SfA6jVFQ2tPHZZbBjPOK+iszC9bHF5cxL6vYJeIjYDkgswFv4nsUbyx7Xu6s6
         G1KHG3M6RqfC063uBK3jTPI4+wdCdRZdwpmmnkzJq17TjMqgRMw3q9MuFoP5cQ4t/rFT
         qmdl1KW52NJvAm78C4thZWKC/rDBoHPzXA2ZKW0saZFkJmTaUH2m8XpVjXJqHkSW0xvW
         u+2m0Gh2PClF6lz48RlqxtBD/eg+u3VAgiBRUxujNZ9ra1EExTD+Il0qflYQmGhg8T0J
         fuiB0tp9/9bTy6SlZp8vblojI3JZVElRJ8gIwXFSdIlVjtmFLa3TthU4YvGUCO3bBTh+
         19fA==
X-Gm-Message-State: AOAM5338cXBhB/v67afytgjlV+4bkbUTJgU0REY0iDgszS6tv5PDPnSn
        TbVT1rIg2CB/ZNLq7OF3kv5+4tYkRfI=
X-Google-Smtp-Source: ABdhPJwTbk9G+rOxlGZxGz/BJx3a8YIXdC0p50TlxtxwEF5aEd/eib2ICA+zpCFvsqK22f0+MWhXpA==
X-Received: by 2002:a17:90b:e0d:: with SMTP id ge13mr6560311pjb.53.1630428701216;
        Tue, 31 Aug 2021 09:51:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.233.77.206])
        by smtp.gmail.com with ESMTPSA id w3sm3368788pjv.0.2021.08.31.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:51:40 -0700 (PDT)
Message-ID: <612e5e1c.1c69fb81.de2f1.939d@mx.google.com>
Date:   Tue, 31 Aug 2021 09:51:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1765339074602025146=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pab@pabigot.com
Subject: RE: [BlueZ] lib: fix variable-length array declarations in hci structures
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210831163545.3646157-1-pab@pabigot.com>
References: <20210831163545.3646157-1-pab@pabigot.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1765339074602025146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=539937

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.48 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      207.41 seconds
Make Check                    PASS      9.24 seconds
Make Distcheck                PASS      243.61 seconds
Build w/ext ELL - Configure   PASS      8.39 seconds
Build w/ext ELL - Make        PASS      192.18 seconds

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


--===============1765339074602025146==--
