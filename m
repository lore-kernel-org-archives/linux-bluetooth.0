Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBEC07E99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 01:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCBE613CA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 01:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGJB1T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 21:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGJB1T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 21:27:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2CAC0613DD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jul 2021 18:24:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x16so10308513pfa.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jul 2021 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9VxMdr6M7mrVN0iCdx/ymU2eA9AvEq6OMwtz0Wg5Zf8=;
        b=TRqxqsiySWUpH2TC1IzvA1DtfQOng1/zMiEli9M8vdaJpopGQ14b82r6+rUpKhRi/P
         oGlE2hUIiKo3WlKPBxE5MhBTdnCs7Txrp0IcY0DHoKC2dl5o8z1jr71D+Dv8DssgOyNU
         VrhhkjMGD7oGWe1T1lNlRzj8/ZMU+i4wsp7x0x9JEy3vH+OgbbkpNEInahFsPBG+P+Gy
         L1oW5cY0WhyBZUbeJX6H4L+CXVNCZuAL0XcVWe+DgjqzBBH5m+0c+Z4/WPrf2KwSqr1y
         UCiwFcVENska/kUcVTYVVSmLoVZ7daZIFiQxYzg7sd0EKmd681Yuc1nwe8qXS6uhfVvt
         wPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9VxMdr6M7mrVN0iCdx/ymU2eA9AvEq6OMwtz0Wg5Zf8=;
        b=UeYeqChDW8FVsYNFwkA2MfGeA3KXDGK8wsjzIlbTLjx6H7fAv7UGCPiRSQ9OqyXwhP
         QdMvlD2YC7leeyXAKtaVBWTmBYdPKJ2qrMJbJaAxcF5KJCVMuJt+6xvYAzKlTvxAOZet
         4ZyxGQHuPCmbQkZlr4O4Ch3tAie8FYnT0/n6mKj9TLVUorcp0zkZApvVGft2kqGu0+sz
         UKot0okbz6nccxZx1aObfxuT5tC+83n8b05b+XfM8IjYO1wEtzjGbXlbL4r0UfGyk/Lf
         77QEkSI7rBNF8y2pZlBeZmtsUigbY7aUc7DycJu7LjIrb38GCIc5+lAq90dkbhjX+QQt
         Qa/g==
X-Gm-Message-State: AOAM530b/cCr+6e7ANW1KfNNKQ83dVaGDiynoeNQheyiir7jNBJ8IZlQ
        SaIPI/66ZXlBwEqtUZRjEYuGMCBNK7k=
X-Google-Smtp-Source: ABdhPJy+qYZ7EpHx68qrWyFw3o2YW+uotoV9qHmleuZ8KFlrq3o72u2cCRoWXo4WXAQxlHHXBChl/g==
X-Received: by 2002:a62:1887:0:b029:315:320e:6b75 with SMTP id 129-20020a6218870000b0290315320e6b75mr40195806pfy.77.1625880272710;
        Fri, 09 Jul 2021 18:24:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.28.230])
        by smtp.gmail.com with ESMTPSA id s9sm4181278pgv.37.2021.07.09.18.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 18:24:32 -0700 (PDT)
Message-ID: <60e8f6d0.1c69fb81.55cc.e0ce@mx.google.com>
Date:   Fri, 09 Jul 2021 18:24:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7637181818499476553=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/2] emulator/btdev: Add support HCI_READ_CLOCK command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210710003801.941787-1-hj.tedd.an@gmail.com>
References: <20210710003801.941787-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7637181818499476553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=513347

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.26 seconds
Prep - Setup ELL              PASS      50.85 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.96 seconds
Build - Make                  PASS      226.64 seconds
Make Check                    PASS      9.05 seconds
Make Distcheck                PASS      265.15 seconds
Build w/ext ELL - Configure   PASS      8.90 seconds
Build w/ext ELL - Make        PASS      212.07 seconds

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


--===============7637181818499476553==--
