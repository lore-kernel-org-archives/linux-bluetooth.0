Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C108C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 23:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DD661435
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 23:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhD1XnW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 19:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhD1XnV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 19:43:21 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B05EC06138B
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Apr 2021 16:42:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id n22so8433425qtk.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Apr 2021 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EMSWyo6O9mdVMq1x1lVRVT3hS7EOyyoDlIoF4AIL3kg=;
        b=LKVKGX93Fr+R/HgCeY6MOCcKUs1ueDE2YrHdg2YBoYNSKqJ2H6c3CJFyf+Bz0CxWVQ
         BUm00sxZfOMxKQtwJDr/BjOe9hGVEN+r9zGx//VuAqHtLf1YCmN7iJitXu32+2+/lcKN
         aMhyhDcHSXXZyG3PGh+e679m+ami2FOX6Ro7ZU40NySMkBq8klSy2iojch8NI9LEULYn
         sxdhOLLJpw5SPQz/plCTKWukAJyQkFzg2yGij1RiHlH+2JC65uryV8GguxtCK9KiA//j
         VRJrXsgb99Z3g5AJoyaExm6M0qvUswh05egT0k1uv6PQCPSR1Re/or7MSwclinSFhhAV
         lFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EMSWyo6O9mdVMq1x1lVRVT3hS7EOyyoDlIoF4AIL3kg=;
        b=MjEVLJuwxxKjXRrgjEFMnbNf9HYAN6K5TSzMNHbthOiJWIol1dRELyTu8Fl8bgCKRV
         jLWF8OI/cff5qNpRSd98Ti5LhKg9d5qjWhFnQun+lZVXFQkOszVwuYsc5UI7Xb999JVH
         9XFfC7/riS4dn7aYFR07A7o5vYr04elW4ryHVUpAfjpovvHczRGxYhNSJsarakykz/Mu
         CPIqQjCGW09jOrl6YTOVfGLUEPUiKtOzgF23G3RSC1diF6e7sLsMPSTTRQvRHpCPNSHe
         20ISACSzHkimWiTwyNWeUaS5KpceX+SbXUrwWhSv+AXW47nya1z4akHZxW6D9MZpRH5m
         MJww==
X-Gm-Message-State: AOAM530P8VOuqRfo7ukneB/hnCUzv++KTWKkFPbC7Lr1niCu/l9eXz8V
        2YjZh848SXqQqKGfey6mnMU/0agEE5qBQg==
X-Google-Smtp-Source: ABdhPJxMPLqTkHFEFXNnmcPrEH1QaXjDy2fXu4JvTumXPoOguAr/gSjPgohavFB5/HeGtWOqlkS2uQ==
X-Received: by 2002:ac8:5283:: with SMTP id s3mr19252980qtn.66.1619653355035;
        Wed, 28 Apr 2021 16:42:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.120.110])
        by smtp.gmail.com with ESMTPSA id a29sm1249185qtd.15.2021.04.28.16.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 16:42:34 -0700 (PDT)
Message-ID: <6089f2ea.1c69fb81.44687.a8d3@mx.google.com>
Date:   Wed, 28 Apr 2021 16:42:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3042689492206539138=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] Build: Add missing ELL headers and sources
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210428225650.372450-1-hj.tedd.an@gmail.com>
References: <20210428225650.372450-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3042689492206539138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=474765

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      48.10 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      8.39 seconds
Build - Make                  PASS      207.27 seconds
Make Check                    PASS      13.27 seconds
Make Dist                     PASS      12.03 seconds
Make Dist - Configure         PASS      5.18 seconds
Make Dist - Make              PASS      84.09 seconds
Build w/ext ELL - Configure   PASS      8.44 seconds
Build w/ext ELL - Make        PASS      194.55 seconds

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


--===============3042689492206539138==--
