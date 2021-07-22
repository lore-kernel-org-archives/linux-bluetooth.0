Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C77C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC3E60E8F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhGVU5c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhGVU5c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 16:57:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20736C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 14:38:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso4562932pjn.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XixZBYZiefsPPvUhvwu+bl3dCv5955BV2PAiCOQ5szs=;
        b=QXBfOEs/IElTm7y/y0CK4gJ+bKP+SOJrY6PSHerpBOBrUANhSJMb9W1F/mlVcMIVTf
         2WUu58Bb21jCRGOk+t9zxkOKS1uzJHIvDPYC9b0RtJ0Yrk3rEP2rz5VYesjasUMFc0ne
         Z0RyjN8Qqxr1ZdIlVAdk7sJUdv+1vrDtURg1px2HVyOauGMhD5Y6fC39mDqgpufw/vIr
         nVnDcnqePEJSibfUBKgC8uk6GPzW6b3ie3em+goLSPBHXJnTM7sZd1yZZLh+G73hOZih
         LYCLWZ/LU91VMvgVqLw1O1pdF0vTCJnXau2FtpxczsLl6g6A0MGe+JLHbG7xygTgAOHt
         faGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XixZBYZiefsPPvUhvwu+bl3dCv5955BV2PAiCOQ5szs=;
        b=QlYWj5wGy2g8i+gJbM8QthvVAkZjxoaAbXSLhvDDv2ry2+KJa780rlp+nngRvXCtba
         /LW5ZX3ZGq/CEzvdUoSI+k6Q3/20g/n8JUhrOhR2Ss5ezq7C4p4KEgZFYuLH4X2ycZ0x
         zwmJCIKMjVwj1IyVqdJbReol1OYfNyjZ9ewEluhTN0J0BlnVO0Cfrivp+WwdAjmxrosK
         aD6+thlVNAQZcvfs611j3HeylrLlwN7VjQpp3wcUiXr1Y25qhWYRM/I8fX3c1CyumeYJ
         BQcxG270Sel++DO1UOHRuo9e3xyq/DLKZeIb8LAuqIHe5nc94h/4Hk2ck5dppoHDopGG
         i7fQ==
X-Gm-Message-State: AOAM5320hdAGu5pmnpFrlP2wH29lS3QhNflRqhCfyf5IWddBri35pCib
        uL/C4AyNKi5MBgSQcmLkw4+/Zm74v6c=
X-Google-Smtp-Source: ABdhPJwwphRCnz9yI1k9aMl+ok8CeM/BjDCfCo/flAe267wSsVK9jTt54Xc6nVg6p9oIu9ND0/BIAA==
X-Received: by 2002:a63:a18:: with SMTP id 24mr1850593pgk.309.1626989885312;
        Thu, 22 Jul 2021 14:38:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.32.133])
        by smtp.gmail.com with ESMTPSA id gm7sm26930825pjb.28.2021.07.22.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:38:03 -0700 (PDT)
Message-ID: <60f9e53b.1c69fb81.a0af9.2539@mx.google.com>
Date:   Thu, 22 Jul 2021 14:38:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4851016466257318764=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bluez@heine.tech
Subject: RE: [BlueZ] tools/mesh-cfgtest: include limits.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210722204923.29735-1-bluez@heine.tech>
References: <20210722204923.29735-1-bluez@heine.tech>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4851016466257318764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=519969

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      49.13 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.64 seconds
Build - Make                  PASS      216.88 seconds
Make Check                    PASS      9.25 seconds
Make Distcheck                PASS      254.97 seconds
Build w/ext ELL - Configure   PASS      8.52 seconds
Build w/ext ELL - Make        PASS      205.83 seconds

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


--===============4851016466257318764==--
