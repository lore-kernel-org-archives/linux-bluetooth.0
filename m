Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3597C49EA6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 18:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB20E613FB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 18:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhFXSoR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhFXSoL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 14:44:11 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F0CC061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 11:41:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c138so16434682qkg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0Bagok8H9+N4ukCS5u3FL26MYE1dn9DzhkiUnMu5lPE=;
        b=YPdKC0HWyLrAHWlvOdFY2DZVLgkVr6eW+oYYQJ0p9jaZtAOzXSZUZHUR+0V2KRM0Tt
         MyfJlz/3t3cvrECcnlJskfQNCJXtysNzFYlWxhpnRMUuivvYEtIFl1M23mcmsXQ0SxmF
         fmqEdcyDocTGAq8oBZUJUn5TZk73WvCSiLwvM1Pxi/WYs8+pHqmpptd2k39kCrS5S8Wd
         uDqoWOViPcs4lhpKlMo9uqBoG02KWOB0QcHYtPQrCEjHWYJhn4ktNPQHOmVIBKgT+NjM
         5H6HRlLgz8KaIWsuAndzah7CeOivoS0oW8u6FW/Zmp4zWWHK2fOZkkyre5uiTvgo+9pb
         iV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0Bagok8H9+N4ukCS5u3FL26MYE1dn9DzhkiUnMu5lPE=;
        b=ZXNfsmk1EanZsojFc9sT34lXS8LOGL19VvahHPuTYONqgUVJhkvj6Ys/o1TNZICG+2
         JXR/fzY629/7Pz5y32CxE4EnK1RS7B/xjC+qwXyD3U4AqNxQaFJ2FQU1YJJ9+xrW1HNS
         /K1bJ4xM9abh0fdYMcJza6Er3908YrZuYzFWAXHOANq7wk84QKS8A6OgbXx86a8FY40d
         qxbuY6fzVh+kabGrcDzvMj7qtWr6w/x8NqB9/nand+1krbD+LZMvmuCUVR7OOtKlhKt4
         FJ5GeTyKsvagWmRYI+KE79lf9c8NnqIwmR8LlGcWb1joYAVSaxlXbDVsXzdktOnLOnSY
         XoKg==
X-Gm-Message-State: AOAM530cgsFbLZ6p1hImXlktgS9LjPLTF74Zs//6aus4fUrg6LYBJTFA
        w+tev0QBWwVZaV0BAWCfqcpgFoeob4U=
X-Google-Smtp-Source: ABdhPJxhbU0mt1FsOaJTQZwjua/WmiVSr/awwdvevk6xZB4CAnqJzKT/GFBBi1tvOFyJ4M+BU9bAPg==
X-Received: by 2002:a05:620a:29d4:: with SMTP id s20mr7307557qkp.287.1624560110170;
        Thu, 24 Jun 2021 11:41:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.138.97.49])
        by smtp.gmail.com with ESMTPSA id m19sm2412676qtp.93.2021.06.24.11.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:41:49 -0700 (PDT)
Message-ID: <60d4d1ed.1c69fb81.cb32c.fef0@mx.google.com>
Date:   Thu, 24 Jun 2021 11:41:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6978865258014331108=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, david@lechnology.com
Subject: RE: [RESEND,BlueZ] doc/advmon-api: Clarify Patterns property
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210624174401.1881338-1-david@lechnology.com>
References: <20210624174401.1881338-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6978865258014331108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=506641

---Test result---

Test Summary:
CheckPatch                    PASS      0.23 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.64 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.14 seconds
Build - Make                  PASS      174.76 seconds
Make Check                    PASS      8.47 seconds
Make Distcheck                PASS      210.39 seconds
Build w/ext ELL - Configure   PASS      7.21 seconds
Build w/ext ELL - Make        PASS      164.53 seconds

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


--===============6978865258014331108==--
