Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B42C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B087260D07
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhHKHeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhHKHeA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 03:34:00 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28BC061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:33:36 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e1so648100qvs.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sldiOeRtVHi9Jw0f28BuaUeHQJrWDbE3Jell5HVoue4=;
        b=l1K0/OpR5AzmvQDY5uiSvjCZ3gTwlGodBeN82/58aePAPo18ydFyP+8d2SdxFSVZMb
         v1T5IBV/54IZ9+YSSCauBz09ZrJ+qeMMwBYLSce3V0zGDnVsU5R1LruZEgMk1iGJdOaD
         o9IKqJUX9n2gR8wJeoQfTKXYm0Ek0BPgd72o3mcio7s02L+Pw0S7tPg3dFcTC3QlsbRU
         3Ze9dpXsjgiLozTb9B351HdDlPoMrpDC22mWng11nn0+/GBaW8Qyg2UWNpaIYDy3KSOZ
         3+kRqFYg0Dfrexfe8Xo4P8xfp3ugnnrDbhn3fX2+tLV2NCyMKYBP2XFGki2JEt3vpDJO
         3NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sldiOeRtVHi9Jw0f28BuaUeHQJrWDbE3Jell5HVoue4=;
        b=nvEIhRGidWaebF35XbXBUayA8k2yYCNFSMQC/V7hd2BnCPPHsTg9xPolqOWTzppTzF
         GEVa0+od8Jtd4eYSWdZCPSlMCMaZzluICMVi65TgZTqBDx980vNxJXeFjA812zB2V0Kn
         Yj/IhqRf72DSsXI78lroax8dGswhq8UoR8+KLat7ZqJvV3WqPZ1wMpnbjAAAW5Q0xaIj
         ngcdHHQKUwC3BcjzeCp/mK7aUjpcEpBk0mH/07cm5MO2mY+B39c52e2UZySbMp6TNhUk
         Sj61ulhZFlrCdwn6JSGmDVnutvk/WF3dUhxTdlCtd9/R+Ex3tKS0ApLrjNsr4GXrAYYd
         RR5A==
X-Gm-Message-State: AOAM533Z9qI81lAlQwolzhOePznEcvjgWZtx4qs/nIKMOIM4a7Act3NZ
        DuX6h+bcZFfw+QjEjJbfBjy30ST81PQ=
X-Google-Smtp-Source: ABdhPJw91YLb/JvWoFEGnRgq689qnoLK7JGptr/ZWnKvcYscJf6v2DOkhUf6L1mXpnCuhLdyTvFcRA==
X-Received: by 2002:a0c:ef85:: with SMTP id w5mr21869475qvr.22.1628667215690;
        Wed, 11 Aug 2021 00:33:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.101.233])
        by smtp.gmail.com with ESMTPSA id y9sm9030343qtw.51.2021.08.11.00.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 00:33:35 -0700 (PDT)
Message-ID: <61137d4f.1c69fb81.d26ad.c894@mx.google.com>
Date:   Wed, 11 Aug 2021 00:33:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7144137189459376864=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v3,1/3] shared/shell: fix missing stdbool in shell.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210811150752.v3.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
References: <20210811150752.v3.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7144137189459376864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=529629

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.30 seconds
Prep - Setup ELL              PASS      39.82 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.97 seconds
Build - Make                  PASS      172.65 seconds
Make Check                    PASS      9.56 seconds
Make Distcheck                PASS      204.28 seconds
Build w/ext ELL - Configure   PASS      7.09 seconds
Build w/ext ELL - Make        PASS      163.00 seconds

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


--===============7144137189459376864==--
