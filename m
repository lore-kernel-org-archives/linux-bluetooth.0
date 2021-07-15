Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D14DC12002
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331C3613CC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhGOB3G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhGOB3F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 21:29:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13214C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:26:13 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id k3so3373241qtq.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dvQSb95/ec2fuA0Oxz9GnLLdzr9nZk+BWKFZLrRgJIA=;
        b=hOjmVBBbTYZxPn5t7ghLN7yGkU95rJxrBMo+aZ0LQoRO+DVt3lpZcbbw/iXYzOW7PO
         AKRBU8BCI+AsM8lw7iv8G6P9GkWGAuQ7wqggdhdlTs8MvydKB6+8bhf3HVGYt6csv6x3
         jyLKtyskwP1HICrSB/CoySGFoKLH5vBel7jSnE10EnlPsLfbZvjKQRx75kUhXnZMGAWH
         uVMOqpj01FCHa1ufbqbXJEqq4gx9wOFsoJWgWUWfzOMAqkf2IJHPJbyAPA7JpzkwcdXl
         4caAJsQTXOoorzESO5p/HcnbYblMM8X4KvTPaus4lbX4YnhUfjCZHfOQ0f5WJ+Wg8pvN
         6ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dvQSb95/ec2fuA0Oxz9GnLLdzr9nZk+BWKFZLrRgJIA=;
        b=SVo7XcObvMrJhoR7J4ofQ7fa41cOpSjG6I0r8G+VP16AF8wBHOjJrD/EV6DP42Tw9s
         aNmTUJL8k9YrLWf4mvMHqKlw5ku5Nu4GLqGdDFBuUWCXc09/JNvfTKX16Uv8fhY4cK03
         u/OcbdXYrwb1hnmdDSIvS0zlfwj2LEwrVF2Wy5n2w4MkyhlbAgugBYJ5x7GGdbgIAugB
         Q4WX8xQGHZxOydfc9wFuorgA9XAYDHX2v6ff9HGBwRbxtN2aAMrJA0KzSqQAekOMNYNC
         CFVDmbPEGwSsEr08aYBZsigBa9uqJiiJSrVg2oPuWRxRjBMEXhxD2T+AMhwx/cscvvl8
         lkdA==
X-Gm-Message-State: AOAM530T4LYvszhk2p7md1gvufyt+unPkHxSP/rNO8FtZ0kx4S16pTU+
        ojUo72dIeEO15z0bLM8Fe/OfFzHCtLrsug==
X-Google-Smtp-Source: ABdhPJw2pIayo3Q7U4e52peMVs6RXv2+rv5Ykk+tyOqltA/uA3AVwdXTD+AjlD9johcufL5KS61N9g==
X-Received: by 2002:a05:622a:1112:: with SMTP id e18mr1052270qty.17.1626312372169;
        Wed, 14 Jul 2021 18:26:12 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.57.129])
        by smtp.gmail.com with ESMTPSA id bm24sm1761407qkb.47.2021.07.14.18.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 18:26:11 -0700 (PDT)
Message-ID: <60ef8eb3.1c69fb81.18f73.ba5e@mx.google.com>
Date:   Wed, 14 Jul 2021 18:26:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0422892984855475817=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] btdev: Add proper checks for own_addr_type for LE (extended) scan
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210714235832.2992619-1-luiz.dentz@gmail.com>
References: <20210714235832.2992619-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0422892984855475817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515773

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      40.59 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.09 seconds
Build - Make                  PASS      174.33 seconds
Make Check                    PASS      8.79 seconds
Make Distcheck                PASS      207.88 seconds
Build w/ext ELL - Configure   PASS      7.12 seconds
Build w/ext ELL - Make        PASS      162.98 seconds

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


--===============0422892984855475817==--
