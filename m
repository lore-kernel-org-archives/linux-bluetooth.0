Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF24C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 16:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9093760F6F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 16:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbhHZQwz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbhHZQww (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 12:52:52 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBCAC061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 09:52:02 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d2so2999754qto.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iRXEmeXghOHSjkq2ncGMfIA5c1fzykFoumI9IXfKaYY=;
        b=JirO++78CMPfGIRXKNLs2MTM0tNHIkKdvLnkXjtau5Qq/bk1WjldlehvimI/3euECP
         CPuhaw2HgdlWjHPuIpJuidpp4ropMajOIV9G2BzV4Ww8ltQblP33d5ugnxqyKmBKCalk
         uBcc0ELiN8q60pv4pD3z1/bi0oRzqtkXLKTiGjBQXk2kvoUfbMt0FGRZJRw5F8S9VGnH
         yBkbev5ls2tTtsplty5hWLnTFpPMAJp2OtVyfP56bvjRLqqlYLX2onh50iQ2HKZ7JGCr
         lR1QsFPSBsatK1vBZvioohxWeN7CaX1WTOJF6ijRYi5WfInDoVD9v/R144C7XZ/EalzM
         VMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iRXEmeXghOHSjkq2ncGMfIA5c1fzykFoumI9IXfKaYY=;
        b=gHUjxP942ht5gz4VAxT2IVhFKynONZrYYwCEIL6/rewO8IXGKskbEbzRlXjtOI5alM
         PLpAnGib4uvZEr/DvzlYQ0RbBo10xYkOKTPoVIXSMNGBLMsOP5uA/5YGdoB4NmvNBuFJ
         lI3rVB/TIcRwOg+OzAsgMpesmhdkjcNbkJgh0EbaUq3yaZY+5UTmXBs+HazD/Ij7kCD9
         qtIjsJb4kOZ1Q6e0R5gx93jfTikh4JCQIZ/ZLMYFQvi3vDgOLexLn2TK/YR5CWw9n9CF
         FQhF87ZXjC73AoQOpw3trKceruCuMZf1NforWmdG7cu7ZS8d2H2Fbx6QWK2UB0GU+leB
         LSRQ==
X-Gm-Message-State: AOAM533WtdRpGhTCpcczotxG2TkT+9edV8XsgGQMLyM45YNh+XxOayq2
        5Toc41Mf30YgPw3LfD201qWQ7W3g/UmWYA==
X-Google-Smtp-Source: ABdhPJzEbQk84CR49XFdM+YMaViYpX62NtNaKNXLf5PAy/XJFuUwJfGP/yr4bk84pz/vZEhHuHN1Cw==
X-Received: by 2002:ac8:4cca:: with SMTP id l10mr4139837qtv.70.1629996721909;
        Thu, 26 Aug 2021 09:52:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.6.187])
        by smtp.gmail.com with ESMTPSA id c1sm2151141qtj.36.2021.08.26.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 09:52:01 -0700 (PDT)
Message-ID: <6127c6b1.1c69fb81.ff1d8.00cf@mx.google.com>
Date:   Thu, 26 Aug 2021 09:52:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2306671461236849249=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v1] adv_monitor: Clear any running DeviceLost timers on power down
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210826085906.BlueZ.v1.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
References: <20210826085906.BlueZ.v1.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2306671461236849249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=537875

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      45.94 seconds
Build - Prep                  PASS      0.17 seconds
Build - Configure             PASS      8.13 seconds
Build - Make                  PASS      197.05 seconds
Make Check                    PASS      9.18 seconds
Make Distcheck                PASS      233.12 seconds
Build w/ext ELL - Configure   PASS      8.12 seconds
Build w/ext ELL - Make        PASS      185.92 seconds

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


--===============2306671461236849249==--
