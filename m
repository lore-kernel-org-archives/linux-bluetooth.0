Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D549AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 12:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B529861A03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 12:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhG0Mwo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 08:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhG0Mwn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 08:52:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2D6C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 05:52:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so4143335pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bxFBn8jZwuOvDrhY+jm9Z5LfGHpbs+SUvWn7xk1WLak=;
        b=anaD9BS01tBAMXqh0Llp77UoUnOCj4HODEFb0rFkiZRwfG5Nkp0l32l2+FsxWkyhAM
         BNA7tLFZj/Y/xw62nRPOKwXfxcldjjWGpImkYMeSMPk814EILTHtR0lJUWdI7jiP90kB
         PB1gPX9eXWAqTocRiz+GKXbd4utIG7vgQvQSPbV2P6crdyCaNdka9gq5VLvp0Sxq8QhS
         NeKbpoQQJK36ctofUQnmH7hBtOzG9bXTKfx9bJVoma/zbzXAkztuTZnlDb8XFwi6ylhJ
         1kA6qMQvhxZKpYa6wCcQ0wJIzKX1aEOvL5o7GFpGV7qaPF0fHYGFyZPnnk3pNmjQM6qk
         5KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bxFBn8jZwuOvDrhY+jm9Z5LfGHpbs+SUvWn7xk1WLak=;
        b=cwUcZj6ZF2dn0Df9jYGU4AiquD2fM96tKoI01VqwW/2KvkWdljb/GIed4pnSut7thr
         i3gY6IHYrs97vObK/u1V0uE7xnWiBzfmEjGKL4gfgqHCO71iBt0JDdsfJJ6erdIOCBHo
         NW3ivlquiyeUwDO+y5pCi6Hgpv8SbO4f3gAYgEsXsjLPML83rFEtkZYHUE105VJRrVGx
         VC8p+dLfiGh03T+vMAyhd0bAhCWHLSs/7f3v/zh1LqUkyiJnfJtgNxx+E7MtjumYZFPl
         DYmR6y7l9/NFmWB0eMjkJxeMHAOEd/cEHThHp6iJier/BOdNbdkCuQoIGfzfbzQb/IgD
         wXOg==
X-Gm-Message-State: AOAM533aw7oRzyQ0TR/+4D+H7/OdqGBDu1YyBmgLF5PcLBUqo6+6ng8s
        xlvnZGzL6oUIiqXF8nqeWBuRQAa0HLE=
X-Google-Smtp-Source: ABdhPJzVOs/ivySK3U4q3S5swwHOfWAp+noBPu/XFqYu7pGvDEmBoNwc8MdGu+X93XVNVTyPi1PpHw==
X-Received: by 2002:a63:dd4a:: with SMTP id g10mr23469937pgj.179.1627390362505;
        Tue, 27 Jul 2021 05:52:42 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.97.203])
        by smtp.gmail.com with ESMTPSA id z16sm3786545pgu.21.2021.07.27.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 05:52:42 -0700 (PDT)
Message-ID: <6100019a.1c69fb81.d5e35.b370@mx.google.com>
Date:   Tue, 27 Jul 2021 05:52:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6377515094545189189=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] gatt-db: fix service in range check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210727195057.Bluez.v1.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
References: <20210727195057.Bluez.v1.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6377515094545189189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=521971

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.14 seconds
Prep - Setup ELL              PASS      48.34 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      8.49 seconds
Build - Make                  PASS      224.26 seconds
Make Check                    PASS      9.09 seconds
Make Distcheck                PASS      255.44 seconds
Build w/ext ELL - Configure   PASS      8.56 seconds
Build w/ext ELL - Make        PASS      201.55 seconds

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


--===============6377515094545189189==--
