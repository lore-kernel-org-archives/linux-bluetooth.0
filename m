Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15058C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 19:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E635D6108C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 19:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhESTo1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 15:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhESTo0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 15:44:26 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E8C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 12:43:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a10so4253299qtp.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=a0l95yBFLdgMl/5jTNKS+KTtoXEx2ta3bvmgX9rjYCg=;
        b=D54XBQMvmjTj/MH+KABcCZVuMQUmDoWrIG5NJNDHmmEn+IvnREb2W13HFBZNBIt9zF
         JsWr7fGe28jhjnarlW3OI6frh7zOGzZfu4rP7cagEcRHR+AmbwJWrIqd0YopEIVOkPP1
         2i0TJ+Y0SGfKafrk+SYSfS23flUn3ydPvXY3H66Rqy/mtOfVmKUX2I46DKrE+ZPSWTik
         bSh+3IQfgziFu2Fe8chQvZdA4JRNxLWq/sVf+PAd1qKuBML4t6JBVZz9jXkWVDpJwHpg
         yk7Bkrq5CWyu9g/jgmjcMO5aMK+wAJvRlsP6Tlepw0IaasIl8dVW/CUL5tM9z/pnxgZE
         rWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=a0l95yBFLdgMl/5jTNKS+KTtoXEx2ta3bvmgX9rjYCg=;
        b=TnhAoZVQ0K/+4e0tDnyRTNF0zdkLGzn2H4S745XJheqccJ9fi9ekxMH+eLhT7n4Ykn
         vbdDZNtXSo+kz2WjgX85pRDZecvvN1nhVPhqi4t0XqkDF/U2FWis35G65cikWWekruET
         ut4c45gKDQoVZM7ONRCCS007mTf5UzZMGC4qMWb7d2ZdDjP2jS8AiEJtphjrnJSaGLaV
         9hee+sCpxle/Y/rhjfoORXEmHlZurUcFCKGx+N089yxQ0KI2INIcwfqjHZ+tvBILutxT
         oubuC6+gUfrN8iUEf/Q12boG8OofPylKogibP8XfBWDyf0QCBLAGOAXGvU/52A+/hpMh
         S1Gw==
X-Gm-Message-State: AOAM533cl8BeLx/CIwXhucNOjuMl/tUe3bk2Kxi135/G8wIXTI160BR+
        PPBR41B3Y5EtaNS4+BLRThPvggRN3wmE3w==
X-Google-Smtp-Source: ABdhPJwLwjMxaK723xIAAOfD5ULIyzK/h5KtnjtHeI3t9FVeEoPTygIURTO/Oq8zE9/dh9bevyGsFA==
X-Received: by 2002:ac8:7e81:: with SMTP id w1mr1295090qtj.82.1621453385623;
        Wed, 19 May 2021 12:43:05 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.108.236])
        by smtp.gmail.com with ESMTPSA id a14sm296308qtp.74.2021.05.19.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:43:04 -0700 (PDT)
Message-ID: <60a56a48.1c69fb81.b67ce.2b84@mx.google.com>
Date:   Wed, 19 May 2021 12:43:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4018317522887578237=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: OOB Authentication improvements
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210519190925.1723012-2-brian.gix@intel.com>
References: <20210519190925.1723012-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4018317522887578237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=485263

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
GitLint                       PASS      0.62 seconds
Prep - Setup ELL              PASS      41.03 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.17 seconds
Build - Make                  PASS      173.70 seconds
Make Check                    PASS      9.14 seconds
Make Distcheck                PASS      204.37 seconds
Build w/ext ELL - Configure   PASS      7.15 seconds
Build w/ext ELL - Make        PASS      163.44 seconds

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


--===============4018317522887578237==--
