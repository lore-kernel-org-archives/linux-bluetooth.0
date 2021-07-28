Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4911C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 23:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD17F6101B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 23:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhG1Xfj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhG1Xfi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 19:35:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0B6C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 16:35:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o13so4046353qkk.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 16:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NUnlGE2fCgZWsUdpHl7ixw46IboRO/EymXiGZTh/f1c=;
        b=IPk4thCo7DJqegIEISqRLxBJuopXw5D09CiwrLAjOWilCcKx6yt11nGHuaDn60ut36
         GR+W6nVJATBS85GvSJ4XgFaP3rb2TqB/ZXXEvDMpJcbOpsDC3vWc62800+MPjchzJ766
         2bZsHoK5105C+vkR4x2gerBy7dOW6SO5HszRN5lXNF/uwvyl9p/GmJhvBDSL8RjeI7uE
         w/qiMIul0pzvhNI7VX62nowk66832b0N39nkBOubETRTDpwmQuSTuNC0ur9lbq5bSprT
         RSL3frqQT9EJdkcgBOrMknPujiy+FmzFmqWRb98b7MkrmtImR7nsFwXm0WkJIPoKQgrw
         JhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NUnlGE2fCgZWsUdpHl7ixw46IboRO/EymXiGZTh/f1c=;
        b=SdiWLeRM+I753qz63Kw9l86Hg4SZaLiABEkEczDnrEKS1ZQRLQufaqyhtxLIW/p/MT
         zVTY4mE+HWsR0dyxJ5w3NoYWW6dhCiBuC7KTDHKrjtAxAzfO6HNBXaFQVNaTyuWOWw1y
         5h4foW6otIEneuDdN9V3OBN7W3sXN2dltgrE1mrP746xMOew8XvTwsskTQiIuWA08uYZ
         Nbc5DvKto53O9RcH/kaNNkArgD7xJVFDNULxM49wePdh0Elj+mtleYcxHyk+cJDKsgeG
         3v2rrPWI6b0xmF9miQj5M1lqO4i1oC8rM9yhIstlVJWzK1tBl1BWsrT3wAPtMVQEL7hL
         1rCQ==
X-Gm-Message-State: AOAM532UeJHpNDUuMcKT1zS8mpVvIQmpvs7q9katudlWTT6TS0tD4qwP
        +ObUcMd4+MpuYOgLm4lFIjhSghpBdV6LOw==
X-Google-Smtp-Source: ABdhPJztiQJ/4bxR5vvRhymHAcoudy3xSCM60CaCXeb2sX3hhl7Sf3v4BVpMFcnWvOuEmfaOhmcRyg==
X-Received: by 2002:a05:620a:a5a:: with SMTP id j26mr2327587qka.42.1627515335603;
        Wed, 28 Jul 2021 16:35:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.217.187])
        by smtp.gmail.com with ESMTPSA id x10sm746882qkf.91.2021.07.28.16.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:35:35 -0700 (PDT)
Message-ID: <6101e9c7.1c69fb81.8c2e.6735@mx.google.com>
Date:   Wed, 28 Jul 2021 16:35:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0007433650914164596=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC] monitor: Add support for tlv based version format for Intel vendor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210728225110.187933-1-hj.tedd.an@gmail.com>
References: <20210728225110.187933-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0007433650914164596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=522997

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.60 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.11 seconds
Build - Make                  PASS      177.90 seconds
Make Check                    PASS      8.84 seconds
Make Distcheck                PASS      209.27 seconds
Build w/ext ELL - Configure   PASS      7.18 seconds
Build w/ext ELL - Make        PASS      165.29 seconds

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


--===============0007433650914164596==--
