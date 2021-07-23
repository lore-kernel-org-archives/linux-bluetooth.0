Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C7C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18AF860EBD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 08:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhGWH6D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhGWH6C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 03:58:02 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D35C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 01:38:36 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i7so646866qkb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=G4Fyhaud3OTV/KQlr9dj5xDt9MsRnCpMSDRnkPpxTMs=;
        b=U2AAx2kzB+bJlAabLd/XxxbBk9uMRcV6oz1Z+8KQL99g8OsfBIVTG4lmO+EPZtnNfw
         JVZ51oShUZ3MNkrgTluGc3yIlGppYAp2edL5upWN0GdHS1dGY1CLgKbtFvdz8Xy3DeM2
         vv1FzPPfQkGwnH9y5btyIQoC86bzAOIMAMw/FUK38OV66eXl5NLGrEvuo7Rsp7/l2xzO
         K0kZaQEHBU9PZnh4lhd9xFJqmtTMmW5Tc66YIiQVX67/f9qSL0XEFOk7ejSPFw2wW3Ty
         B14gh5Lq/q7Uxg1ocUlvjQGEPIE6IBcWJLY5klXNFxC+uXBD6SM4A3IETRBMJEYZVf05
         lp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=G4Fyhaud3OTV/KQlr9dj5xDt9MsRnCpMSDRnkPpxTMs=;
        b=Mrka3mhpglO1ALEBN918vL8gkBNCp4JwJ7SYe6kFEoCpzymcgeuRzmUG4uv9wDd5m3
         KDeTVnRsvAlzgHYBeMtUvPOSchXbXGaEAR8BlyV+lx/5O2VAfG3Gsm1j/lCS4hfDAfov
         9mG46qiGraIVoyy8z0rN0Ucfg1tIcENOaoSgBwiHf1Ehme9VGD0sUKUD4sif62QT177B
         BiXcn2io4MLPJl6/WiLGoBJssrUeHHL9zrysoxFYf72gLlpT67cdrMKsZUTv8irRRGFX
         9jpBdRoOtrNUTXjsbXxmEnLYaA3YJFup2xqSU4T7wP5BMUWuTbZ0zwsZu20CGXiiKD2R
         nvrw==
X-Gm-Message-State: AOAM532G81U1lcW4yqc0yfRfM8e/XfkpKFpzgAgMxOZ0DNh0QSIN9sDw
        Gn7oEDBismq4tApBSRI2L9If9cAA7lU=
X-Google-Smtp-Source: ABdhPJy1VTXQu0m2zfQwe7gSg9F8O820b1s5CLGGcHuAsL9CCscv47LC7vZgdeFtXLXsFXfNIbPzFw==
X-Received: by 2002:a05:620a:982:: with SMTP id x2mr3512474qkx.347.1627029515302;
        Fri, 23 Jul 2021 01:38:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.67.67])
        by smtp.gmail.com with ESMTPSA id w26sm11143597qki.6.2021.07.23.01.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:38:34 -0700 (PDT)
Message-ID: <60fa800a.1c69fb81.229d6.4d53@mx.google.com>
Date:   Fri, 23 Jul 2021 01:38:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6883639500835517902=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bluez@heine.tech
Subject: RE: [BlueZ,v2] tools/mesh-cfgtest: include limits.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210723081039.30396-1-bluez@heine.tech>
References: <20210723081039.30396-1-bluez@heine.tech>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6883639500835517902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=520149

---Test result---

Test Summary:
CheckPatch                    FAIL      0.26 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.96 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.97 seconds
Build - Make                  PASS      174.42 seconds
Make Check                    PASS      8.52 seconds
Make Distcheck                PASS      204.41 seconds
Build w/ext ELL - Configure   PASS      7.03 seconds
Build w/ext ELL - Make        PASS      164.50 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools/mesh-cfgtest: include limits.h
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#11: 
http://autobuild.buildroot.net/results/20cc47f54de0b0d4bdf108c3715c590ae8ab476f/

- total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/mesh-cfgtest: include limits.h" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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


--===============6883639500835517902==--
