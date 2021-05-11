Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80213613B6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEKH6b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhEKH6b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 03:58:31 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE513C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:57:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k127so17914396qkc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=U7BDqFag4S0YTfKLMr2+FM0e5knNiQLKnKU8HFqexDM=;
        b=cvredxmfs9u3NCWdYFnilbWWl/HYfx/bI01jDHFotUUaQnvnEK5ZUOn114o+kDNCRV
         h1bOP42f3ZIX0w89Gyhijyr3hdwI2uzxS1hm0XZ7pLAcqjb568+xMvYVy37vvXO3dD0w
         QjxgUSANFKD53CmeYrAEoYWZWl4qLLgU7dD4u36QjH4Wd7lnpfPLzvcc0XNZAKaMqMNt
         DoMEjpNdz1UCQApo2qD7AJwOmc3pWMXo8AzART2VjBJducFVAVNgWdnavoRRJqV9HgL5
         7ZP2kqq5GUb4wrmjf3uwqKa7SINTyE1BUKY469/uEqj4Kcyjo3jGtbRnF0YSVDOXrEb7
         H8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=U7BDqFag4S0YTfKLMr2+FM0e5knNiQLKnKU8HFqexDM=;
        b=NxmAp2ARbG0lEsD2EocN/Oat444d3HLC8WcfSav8XTDkeYfDiP6BCb3t+QQIo3Xf17
         2bN4gXI42oC640OIEPMheA9juOeaIB41Yo0bqgIofeAtCCTwNdE2IqBlkJAUC8Q2645N
         wB9FQwCYHZTr3DLjET/Z9Walr4cmwRm1O48QFV+xBWfU8roVtASznV9F6VawNYqmJ9+2
         LfwiF/2KHFBYMYYeyKaCpioy9UxXWXhICG0lUCWy3O3EiyOyRGH85DSDNj1+SnGqi7LI
         /Cy8jB1ctDulV2Vy2407sDisn86tiSyWp50wwL5pxAJTpMVwjjM7kTkOS21gGic85l3v
         n5ww==
X-Gm-Message-State: AOAM5313gb741Nii9OxVtpc1v/mqHIpp2QHbHAhWRTSmVE5LwS1gsxL8
        2PmdSfh29XiT88/Zkj8npjCdiJaIMqLuTw==
X-Google-Smtp-Source: ABdhPJwRYYHB7T2nBjdP5VIe3aY8JlwnwCx1DXKukWWo+7eFo1SUDktHMojl2u86ptoElB4lATOKuw==
X-Received: by 2002:a37:e312:: with SMTP id y18mr18353661qki.39.1620719843877;
        Tue, 11 May 2021 00:57:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.61.236])
        by smtp.gmail.com with ESMTPSA id q23sm5624581qtl.13.2021.05.11.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:57:23 -0700 (PDT)
Message-ID: <609a38e3.1c69fb81.32693.f50b@mx.google.com>
Date:   Tue, 11 May 2021 00:57:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5696360452348184917=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] monitor: Fix possible crash of rfcomm packet
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210511152807.Bluez.v1.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
References: <20210511152807.Bluez.v1.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5696360452348184917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480043

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.28 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.20 seconds
Build - Make                  PASS      169.18 seconds
Make Check                    PASS      8.61 seconds
Make Dist                     PASS      11.36 seconds
Make Dist - Configure         PASS      4.52 seconds
Make Dist - Make              PASS      70.51 seconds
Build w/ext ELL - Configure   PASS      7.17 seconds
Build w/ext ELL - Make        PASS      156.78 seconds

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


--===============5696360452348184917==--
