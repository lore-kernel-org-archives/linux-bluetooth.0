Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90715C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 05:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DEA613F1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 05:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhDOFoG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Apr 2021 01:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhDOFoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Apr 2021 01:44:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94945C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 22:43:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a12so15307070pfc.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fyEaz+U1tQ8hC3quZaWVCbZdUdm49klX2ZpT+uN8PrQ=;
        b=Q4rgJN5avPs0fx/C6J96S3EaBV6++vTlcWP9SkDeFYNHozBCcgS0z0LbE7qCR8X0p8
         8QYduhvq7aVcHhyfje9kepIbT6QzwfZxnjAByELE7EnX+R7337OoJ/mvhUk9x885ceBa
         0B9bMA1uIsELBESDgE6j7Zc+vk7z3/kJJ2E3+0e7H7zvPJTBdZUnFBZmSpm47sic+8AO
         3lun0cj3ERpmpkELk0ZNBBhql+RvyL/zEDZm/dyqc29hxV8lgb7jkG+IPZhVfqtF1Xkh
         qpoKaOAxZz97s6O3oW20y//5o3w4E2Wn476CRaksnv8yW/BoZdJe0zcCGEGuR6ijww1T
         Z9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fyEaz+U1tQ8hC3quZaWVCbZdUdm49klX2ZpT+uN8PrQ=;
        b=qqT9xsraiBsU+N626i8fkVGSTJ2WoQV4P+aXxL+ETielXP/X2/pH+sFTSAD/oqyFIt
         8XYeLV5OzZmJwXOu+AM61wUH4giy4/qNirvnrXrRiI6d2jjf5cnS7/9OBF4QvL2kiCgb
         AVimFX/6XRmdeokgh3zqq3RGyyS8B1doV0noRfrqZgYr2LOY2j4t9UodbY151W8byFK7
         hoZ0dhnwPtFpndOnG1N7UE3aOsQnwkWoZm/5GyIs0umy7gFTQ1OvighbTgT9Q2NUKgOl
         ysPtFNeYyrAdE1TO1Jj5m3ZwQwTIHk4pScOJuhoEc0x8mrfJoaLCLpm3Gk8+noDAguYH
         Y4Uw==
X-Gm-Message-State: AOAM532k6FuZrT3j7l0MEF+l6TuU3wMl6FG2uF1K/y7FlzHFNkn1WWjF
        R/2ZiZAdd7FOR6ilggc7Em+6gXpal9s=
X-Google-Smtp-Source: ABdhPJwswSJ4m2+hc1LMKgMSyVPPjKbfrNoThjLpcURkJj4cR6xmsyBE5pwmqdRimyOSUAdSUxW4qw==
X-Received: by 2002:aa7:8493:0:b029:1ee:75b2:2865 with SMTP id u19-20020aa784930000b02901ee75b22865mr1583297pfn.61.1618465420882;
        Wed, 14 Apr 2021 22:43:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.240.233])
        by smtp.gmail.com with ESMTPSA id u24sm1108106pga.78.2021.04.14.22.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 22:43:40 -0700 (PDT)
Message-ID: <6077d28c.1c69fb81.5cbb9.46dc@mx.google.com>
Date:   Wed, 14 Apr 2021 22:43:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1612273294007583927=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] shared/timeout-ell: Fix timeout_add() implementation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210415050347.253831-1-inga.stotland@intel.com>
References: <20210415050347.253831-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1612273294007583927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=467449

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      45.10 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      7.92 seconds
Build - Make                  PASS      193.52 seconds
Make Check                    PASS      9.37 seconds
Make Dist                     PASS      11.56 seconds
Make Dist - Configure         PASS      5.12 seconds
Make Dist - Make              PASS      84.81 seconds
Build w/ext ELL - Configure   PASS      8.80 seconds
Build w/ext ELL - Make        PASS      197.07 seconds

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


--===============1612273294007583927==--
