Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9760C43460
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 19:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF106145A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 19:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbhDUT6p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244346AbhDUT6m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Apr 2021 15:58:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7DDC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Apr 2021 12:58:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id 1so32183408qtb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Apr 2021 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=GOBYF8CKtvquG5LIZIJfL2CI7EYBH2dreb6jWO5IPs0=;
        b=CjmGnAVATJj85jD3vrzaLSzw/pAA03AacQbADnlM1NPAY4iuVRWEKIHWKL2uJgZkTp
         X+yB2n3XwYZ/n4lF89lVuuLA0iovLr1zsujb0WgwTgbrBngeXyS39hvbRmWa827RmFqO
         swLGjReVj8KjY7aFsaEnSG/O0s/DmDyrSp2rj/pSjj5SbA0kzNiGz+JG0mu6KemL0v8S
         XQoHCaBzGH4NA7JvnmQvenLrVDK9C3AokaCv2cY2DT9cEhzCO4iOX3nKajdelcjMkn2D
         z4wiAxY5tvgBuiKGmll8IJS+uWc17a027ID9PyS8FN2SvFo5DrbavFjbjMOZsps99Zau
         qq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=GOBYF8CKtvquG5LIZIJfL2CI7EYBH2dreb6jWO5IPs0=;
        b=g0025yC1D2LxncC3yv58vRiCfX2x7ZsgbcUYpN4rzBRqUE2/zvD09Jy8BeJdD3CHSZ
         N81wpAbLB4y7xO6krt1tzgJu1/DOBUwnx7L11dgLiIx2ScTNL/T4tAVI2vMQRw4Ts5eg
         r/M5tQMltB0Ec/r9zTg+wKz71TkBvUIyDCMr7NepqzZpOnngTOmp5HNtNuooO6JZwJ9b
         2dGsnD7KKS2Qh/RsOWosw1+nTnSsp0WQ+O6niLWK5v9P/U5nVhHt40TTombVG58Pe1uu
         C3BAhSCTjjUroCcoYBVmAWzunvqSIxSCISIvDMSdsVzYVs0qD0A5OhRI9huwcbcl6lQB
         pfQw==
X-Gm-Message-State: AOAM533biHdjSFVASZp03nhK3ou6U5nzUNE4elotf5xxbBnqkxUeMSqK
        3DzFKJpdLmS2WtsqDsA22t2/0GcjSKGxzQ==
X-Google-Smtp-Source: ABdhPJyAyuLKA2GPcz9GQw4D8Pd771vZRz5MrEbf8S0ZvHV42VzbYRrrxWiXNMQKRzO5jvc5fSH6Kw==
X-Received: by 2002:ac8:7c46:: with SMTP id o6mr19789390qtv.74.1619035087369;
        Wed, 21 Apr 2021 12:58:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.121.238])
        by smtp.gmail.com with ESMTPSA id r25sm487320qtm.18.2021.04.21.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:58:07 -0700 (PDT)
Message-ID: <608083cf.1c69fb81.45ec5.322a@mx.google.com>
Date:   Wed, 21 Apr 2021 12:58:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5726096833852792787=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v5] monitor: Fix the incorrect vendor name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210421193535.4616-1-hj.tedd.an@gmail.com>
References: <20210421193535.4616-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5726096833852792787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=471127

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      53.04 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      9.35 seconds
Build - Make                  PASS      226.97 seconds
Make Check                    PASS      9.64 seconds
Make Dist                     PASS      13.25 seconds
Make Dist - Configure         PASS      5.69 seconds
Make Dist - Make              PASS      93.44 seconds
Build w/ext ELL - Configure   PASS      9.35 seconds
Build w/ext ELL - Make        PASS      217.10 seconds

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
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============5726096833852792787==--
