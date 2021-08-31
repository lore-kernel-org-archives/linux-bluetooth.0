Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C693DC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 06:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C5660231
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 06:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhHaGlb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhHaGlb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 02:41:31 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66051C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 23:40:36 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id eh1so9758765qvb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 23:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TkYZby4Sv0pXaAfhRhyesTZkxlA+CHS0P7VgRwMSGPE=;
        b=RvNCAx7SeQk/R1JYlwDbZbQv9EYrOVGH2YCUlKt+kKAyo09hV6R9VIA4WmXQ16IXAc
         ijJd5TvHDYvQfH0AERz6YWL6MbYarof1z5oqTghcA4EJXQVzKFMSOp2vqAlOyKWA8oa0
         Y+e51pGQKEtbAMyjMGxRahT00MUw6v/4vCo2rs6sRknkXeWG0Mfiz4c3YUuLgg/wSjV/
         ZC6JwjOdekArFY5RFOsV3DJRuyOKp0/IaJiiNfHinCwehuln5PWZVaHDCBT/v8sh0apu
         Ctbzm4IjHDl324xnByaDd+7KLmxTKwcfdQpqTNJlMUh/BqG4Na97az4UGfPoFYexmvLv
         Umdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TkYZby4Sv0pXaAfhRhyesTZkxlA+CHS0P7VgRwMSGPE=;
        b=iY9Ss6e6eeWlZ4gVrbXQ7iSW4ImWtmECGC4CZ/hoDpQLU5XFFGLwYBTFwzwNWY4ktg
         eefk2dC6CLe7ZT27meVKdh+lerf8XQV+hztJaihu6a7Gq+6F1xqZJftFE5lY3gG1HF+S
         +NAKY2j0MzLlabJkcDIezvFGjikehxhUFKsy3wm7ukYDadHD6+ddR8wNjcz4LV6WmEJz
         PeNVWTAtdy5WJXsXOLdX96GC9jW0RagmBuEMhPr4UJTWsxZgUtoOF2upirQhQ9bRGAMr
         /YFdhiQGAE68vErUYOm81jC9SVBYcJIlwwC/JP6GCkdRCfoDGEBU60TeF5PQ/6rlJdHe
         aXCA==
X-Gm-Message-State: AOAM533O5si1YV9ZuPa/GpnXxQsb4x3d/psASOKQbzMbaLq1jCbXWeiz
        SPeUnf8vr0yGh+VYpLlSX/wWPy3HlToTDA==
X-Google-Smtp-Source: ABdhPJxcnIwq9/H9dVQrvQtlS9g4YBKOHav1QF/s+faB61BDXBYnOuNNwYG0ph+FfFtwpdK7QC/HhQ==
X-Received: by 2002:a0c:d7ca:: with SMTP id g10mr27382350qvj.49.1630392035452;
        Mon, 30 Aug 2021 23:40:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.210.113])
        by smtp.gmail.com with ESMTPSA id m16sm12911229qka.84.2021.08.30.23.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 23:40:35 -0700 (PDT)
Message-ID: <612dcee3.1c69fb81.a8dde.8568@mx.google.com>
Date:   Mon, 30 Aug 2021 23:40:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2963925315222751495=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] plugin/admin: fix set empty allowlist no persistence issue
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210831133844.Bluez.v1.1.Ia40feb9cf37fd87db5b5b4910c08882c9cf21688@changeid>
References: <20210831133844.Bluez.v1.1.Ia40feb9cf37fd87db5b5b4910c08882c9cf21688@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2963925315222751495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=539553

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      44.12 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.31 seconds
Build - Make                  PASS      180.67 seconds
Make Check                    PASS      8.61 seconds
Make Distcheck                PASS      214.06 seconds
Build w/ext ELL - Configure   PASS      7.34 seconds
Build w/ext ELL - Make        PASS      167.81 seconds

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


--===============2963925315222751495==--
