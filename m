Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7713BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 06:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A07E6117A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 06:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhDPGnn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhDPGnn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 02:43:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220A6C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 23:43:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b26so12569081pfr.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tiXa8EHxVL0LmOlG8i3N3SML2AgDK1uWbTJ6A7duW44=;
        b=BG3D6ece1nNvMhxSSdN2sL8QVK6FN6CP3iiC4OfzDMK4uQMT5vS64NB0L6GB7R/1cI
         6LsCD0FPcPDvkq44BPhV0rIBV42NyvG7CNX/J3lH8QiEWTY4X3WlQduNGmJ0BKdWkaGt
         +6T73GwFO1EDg9+7xAlOuTruaE8TU4lYkY/yTAw1R2hoCb1D5ZqNfyDlLJotGFv7QslM
         CHCAnr0+Se64f5Kr5Xl6u7pPjblb5NzIJqWObGjg7bpxt6Rw5NxyzoH8V+PcJIxkjysJ
         dBYko0au3yDWbuv/SjJt1Mz7OhYSW0H7TDfjmgXK4kn+O00jcjdXMIPTt8gy/D9KFubF
         Q21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tiXa8EHxVL0LmOlG8i3N3SML2AgDK1uWbTJ6A7duW44=;
        b=bX588S1uszCeZ6BS7WILHClQTbGZNws8TgY+DKNE0RvvWyi+szwHbk8lYCAPpwCtGJ
         jNV0TTKy2V15qp66jcodP+4e3+whJ/XFHt9VC9kLTfbR62Y8Hw3j9F3Bv1L5x2dJ58TL
         +BSWTumJYRxr+q2IM4VHI62iW08+MUyLdmt/jN1dy6Nax44Dt5kem0NVjraUZjYQVTGi
         06d6JeRGiSSuieC/jR4+bB2XzGHUHVd65B2CvvJBrmdC/mv6+FfEuddhGb7wp9gZBMqE
         Yp8RkslNjeVtu6RvAM8vYQQVSnatvDybguO1s+A+4SVneHCuKkkr6HI8Mt0XlOaKqItg
         Pzcw==
X-Gm-Message-State: AOAM532QR30600leonN79bx+7Egc/GKndJkdiapvhaCRVme/TNwv+8DO
        U8hRqA45z9xOpTVX4F55Dm6fcKURNqs=
X-Google-Smtp-Source: ABdhPJxsOGEvNxGX5iQ+SCrVLUYysJkk85lv192ghMZ6ZcXNXSsg5mT22s3ZoTEkHqPCnTyMa6JbpQ==
X-Received: by 2002:aa7:9dcd:0:b029:246:6209:5c22 with SMTP id g13-20020aa79dcd0000b029024662095c22mr6875115pfq.62.1618555398288;
        Thu, 15 Apr 2021 23:43:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.136.48])
        by smtp.gmail.com with ESMTPSA id w134sm3853754pfd.173.2021.04.15.23.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 23:43:17 -0700 (PDT)
Message-ID: <60793205.1c69fb81.20da1.bf52@mx.google.com>
Date:   Thu, 15 Apr 2021 23:43:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6835633207309767527=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] monitor: Update manpage
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210416055600.584533-1-hj.tedd.an@gmail.com>
References: <20210416055600.584533-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6835633207309767527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=468265

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.72 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.50 seconds
Build - Make                  PASS      193.28 seconds
Make Check                    PASS      9.69 seconds
Make Dist                     PASS      13.37 seconds
Make Dist - Configure         PASS      5.64 seconds
Make Dist - Make              PASS      81.35 seconds
Build w/ext ELL - Configure   PASS      8.48 seconds
Build w/ext ELL - Make        PASS      186.76 seconds

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


--===============6835633207309767527==--
