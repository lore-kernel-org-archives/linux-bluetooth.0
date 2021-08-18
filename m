Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5803C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 19:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC05610FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 19:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhHRTEU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 15:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhHRTEJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 15:04:09 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F7C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 12:03:34 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id bl13so2252273qvb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Mz3i6+N2ssWrGXqs5a81NcfnjnQcZ0ltkDotULNIm5g=;
        b=AqOYI65Gsvtq/dZuRNbp0cJbkCPNIxHb19HplJOUYC0TRzOvbA9ejiGi+d8cc5cXtm
         rgPfa0C05GiC8t8Mc0xVRwNcA9hLTUTXx+mtZFdcjr3EhLxUuIapRmGNAAgrCyTr7j7u
         rR2YQR3ccWUpMeWY/P+FtgnqqctYXAJn5wcE/7XSZxLwBP9tKQc7KENG18Y55crq57Or
         TqsdQFgFBCTsG5vwsm08DB51GpU36Gtb77HTCxPGlH80LpKEeWYi+gs9mxGmRkNvCrxL
         ZSblnsFre7oz8nz05j58tXkEK6iYCclpm1le223/SSESqsQLDvvXMntf71s9nx1Y2lC/
         53rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Mz3i6+N2ssWrGXqs5a81NcfnjnQcZ0ltkDotULNIm5g=;
        b=YR7R+e6wogMYUfARUJJGa0wGjkWFgpJZo6YEYmrz0ROpq1UmiGjiBKJeYU+3AwRt+3
         7VaIEnKsJNyg5135i2eIHWYwsJ018Uxoo5j/vTrhTGddEkXPgZSf5KjXNl9v5rFhEp13
         LGfyQbTasUvEeZwB/E0Qt84Ldfa3jUYfNgfzh6gMlWXpMhz4eE61U+PFz6v3krRNWhPG
         Whfoxaz0EedM1/sqq7Pt8TnxG7RxG7YcPOyTZ5nt0b0pNONtQXanebj4UTK9O/sUpwXP
         n7rzLRce6a16BNOi+RSBqbU6O1U889ebea38v3TRkxzaYTZgfILtZqNqr1j53XT2Wt9k
         BdQw==
X-Gm-Message-State: AOAM5323e0RZja12dYUkLaMVUeYTPNgv8lPUYs5E0JWcsV/zt9UTaR7l
        I7xpYnn7LzIdWJq6xWuM47jnCT2CP1Hu9g==
X-Google-Smtp-Source: ABdhPJyTgeWDKVH3Oh4m6UlgsyT5Ce/ur1F7zh73dM1lyFCfgQUgJTr4eKebmmO34d/5LbufGCc3fg==
X-Received: by 2002:a0c:fe6a:: with SMTP id b10mr10533368qvv.6.1629313413024;
        Wed, 18 Aug 2021 12:03:33 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.26.5])
        by smtp.gmail.com with ESMTPSA id n11sm340326qkk.93.2021.08.18.12.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:03:32 -0700 (PDT)
Message-ID: <611d5984.1c69fb81.3f537.311c@mx.google.com>
Date:   Wed, 18 Aug 2021 12:03:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2875553227176286066=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] tools/mgmt-tester: Add Read OOB Ext Data test cases
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210818183108.1636030-1-brian.gix@intel.com>
References: <20210818183108.1636030-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2875553227176286066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=533641

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      41.16 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.20 seconds
Build - Make                  PASS      178.65 seconds
Make Check                    PASS      8.36 seconds
Make Distcheck                PASS      210.16 seconds
Build w/ext ELL - Configure   PASS      7.23 seconds
Build w/ext ELL - Make        PASS      166.79 seconds

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


--===============2875553227176286066==--
