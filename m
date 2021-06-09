Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0495FC48BCF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF6A60E0C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFIWIa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:08:30 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:34496 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFIWI1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 18:08:27 -0400
Received: by mail-qt1-f177.google.com with SMTP id u20so11109963qtx.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jun 2021 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=L3pt+ouxiQf5QuuSM5aynuuq/mvdbQA/ATW+k0vCUng=;
        b=l5R7gNhDJ4ozLQsDk8U3GEU9hNgeFtwH8J5xzkJ7JzdfuCmcchrgVAihdo1SgQZVxd
         XjYhuMHTYCdFcBikNwPgVSkbghJhIsHblFRvuBPIHXTPMafBStfGi+BD2sPM7ppuM4/y
         sZtI4p2eJxWMUG1bf2deDtWcKob877nLxJ53gCsJCdYxY8J8eFMZz8AIlThv+EUNFWRS
         3Wqc0MQAhL9/q1DU1/32iyOCmP2vyjtek3TS0uy4gsq+BmsYYL8jX75bho72naYpd0WG
         9QDBKV5d9Eb2GcWtfcpv8wBNGsuoFXCxgXMI7LEc4vQk8rr//eMel3tuo36biUBk/C0n
         ymlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=L3pt+ouxiQf5QuuSM5aynuuq/mvdbQA/ATW+k0vCUng=;
        b=eB7kGcoolkQzKxQexhha9EpE1tlxURTNJ/Tc5VzID3vw/vSyo+38FJtF8PMe6QGU1D
         gmJNqWnMNIIX+Y+nv3SRv7W1q7Crr2uscts98eIQpWMG2LpD3vQejPg1q0legTiiKbR8
         0wSd224IXBnkbQfGzurkD+6GPPAjM8t8Ca/oCPA8AEaYhjxvbiOcgF+rK+RGKaxdix1M
         FUDyROQGncznLp01khsMeCLYH/m2H+Bd26JuoI3bhejMhQeDHIC2XWr4+Pc4wHSs0H8h
         yq6Anw4HinlB3qcrTga32yrYId5TpBd5OlsznrJNS6VNtvoc8NMDu8efq2itSSNKCvgd
         0MMg==
X-Gm-Message-State: AOAM531uTNhVDGnPWLRbQw7+pwkppN/hcGIzP2TqVxFCHHfaapsGOpae
        HJk8jK224yCSyAzcqAC6erMAh27F1o3YiA==
X-Google-Smtp-Source: ABdhPJy6rCkVPfxSPMstRgFjOaApVuKqu3CCxUlXwvpp7zsk195ECHEDWwnR30UtcYAzbhF3tDCR4A==
X-Received: by 2002:ac8:774c:: with SMTP id g12mr2209485qtu.39.1623276317342;
        Wed, 09 Jun 2021 15:05:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.65.196])
        by smtp.gmail.com with ESMTPSA id j127sm1012485qke.90.2021.06.09.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:05:16 -0700 (PDT)
Message-ID: <60c13b1c.1c69fb81.d4b97.87f3@mx.google.com>
Date:   Wed, 09 Jun 2021 15:05:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2774933137479044303=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Fix adding padding for Ext Adv (Scan Response) Data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210609212411.288330-1-luiz.dentz@gmail.com>
References: <20210609212411.288330-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2774933137479044303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=497549

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      48.50 seconds
Build - Prep                  PASS      0.16 seconds
Build - Configure             PASS      8.46 seconds
Build - Make                  PASS      210.61 seconds
Make Check                    PASS      9.60 seconds
Make Distcheck                PASS      245.58 seconds
Build w/ext ELL - Configure   PASS      8.34 seconds
Build w/ext ELL - Make        PASS      198.66 seconds

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


--===============2774933137479044303==--
