Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE166C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 04:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AD76140A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 04:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhDUEHf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Apr 2021 00:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhDUEHf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Apr 2021 00:07:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB44C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 21:07:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u15so12338574plf.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 21:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AEzt6C/Br79YsF3sxQOScljOs9nH6uGWIsy4bJny3SY=;
        b=IbI64fD8KpRluW1PylsqGvvrExpXuNwHm/MYgkbzwvEGhTmVgRvOlUW2RBsHREBG+T
         sNFxuHut+8FntU8yX4a66EcCOlz6wvxXgseQf3uPP0L9LfBE1Mr9Dqby0/vBCETDwttB
         IDGD5825Z+LkFWrqeVCRoRC35Os2Mhf2Hpx1pCJhumMyoeSZYDi5RWWByO7e/WPz85jt
         hS7JJaxgMM85JkI6NDxf0KyBJihO0MPG6PvRO4QxpHriVoNJraV2xCgnTsFTTrPLFW4q
         cxyVKaZ5JGB8A7CNpstj3ZuSMVeq0TmcX/0CY3Sl3SDa/iwUMLzH4TXRVG/Hs64Svhag
         Lwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AEzt6C/Br79YsF3sxQOScljOs9nH6uGWIsy4bJny3SY=;
        b=j/k5Bmc1wFBlIReg1AxUzbJEGxcBS+bd4Q56DJVTKMzzdEEXWd+VytTiUiFion67QK
         X2+2FxcMB1TAZua/TB2DOOHfdzEpSoGsEih5+z/cjVRyxZcu/8y0NiVGHhezncQcsgSi
         pDFV6CQ+wBUd4N+GNvN3sIcbY0jrlVgVO+SgWaintdM3qN/j2L7uvlAAfa6QpgJRrjCZ
         ZHm9SLHDkvnZLdwdPwmZ+eoP6exFUXPTJgPfwuHu54jpWLsref2kMVE8Q/7nWyTzwCQq
         kwyGpHZj09a8hKm8OZqrzLMSsk9Ue5RmS8JtBnRW7OdPk8W+S6lJM8YIiTniUOvjLMTa
         vjpw==
X-Gm-Message-State: AOAM5324u+fIIY5t7f4IIH4lZRf7zGp5FG6CrOFy63qfDuunsbiZfbMH
        wQ0dSqjHKJ5y8vuVsJ65ovJL8XODwZc=
X-Google-Smtp-Source: ABdhPJxpUne+Evyxft10AuZo5lNDrufOQlqGTevFxW5opbt+cWsI9Ua8DTfIsJimcUoAf8/kllA0jw==
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id p6-20020a170902a406b02900e678c471c8mr31703404plq.17.1618978022237;
        Tue, 20 Apr 2021 21:07:02 -0700 (PDT)
Received: from [172.17.0.2] ([40.91.71.195])
        by smtp.gmail.com with ESMTPSA id w25sm415889pfg.206.2021.04.20.21.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 21:07:01 -0700 (PDT)
Message-ID: <607fa4e5.1c69fb81.abe79.1f30@mx.google.com>
Date:   Tue, 20 Apr 2021 21:07:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1215820986367343199=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v4] monitor: Fix the incorrect vendor name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210421033758.762312-1-hj.tedd.an@gmail.com>
References: <20210421033758.762312-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1215820986367343199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=470617

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      48.15 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.32 seconds
Build - Make                  PASS      205.14 seconds
Make Check                    PASS      9.13 seconds
Make Dist                     PASS      12.34 seconds
Make Dist - Configure         PASS      5.17 seconds
Make Dist - Make              PASS      84.35 seconds
Build w/ext ELL - Configure   PASS      8.62 seconds
Build w/ext ELL - Make        PASS      196.41 seconds

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


--===============1215820986367343199==--
