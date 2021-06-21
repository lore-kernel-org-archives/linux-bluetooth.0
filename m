Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C2C4743C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 10:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBDC61153
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 10:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFUKpd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhFUKpd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 06:45:33 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EB1C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 03:43:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q64so22811737qke.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pR3NqYFq2cG/T5X8hUhbOoeLsaPWdxEnBHVJMG0MJp4=;
        b=MUd5RHlyu2xEaSkQsPsGgXYefMGUPcsJz/SYo91Rt9j2h6L3GucxjjFI1Kxn4jM9ZF
         TNhpE9xn+tbNz9shJ7ZNZNJ9jYrROShw6ULCXze8503UKkUokjA0O9JzVnjgwhSiSOII
         9OzbHWbwxp5rH2iZ4fN/8nzu5oTmUbe2m8GtauUYx16zR3PVJVwWQtcEZcTftThjWrWY
         B5vra3RE09LDjtya0H87tScrkky3o83xJk+RMxADripGAFpezNfuwuLpgAYMs6tUpbsQ
         SeyEEpTDcNHsS1loHmm/d3S6BmUnFh9/fPy+jCHjF83B3RxzQ5nTgdyMZNnFsGphxAwv
         T+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pR3NqYFq2cG/T5X8hUhbOoeLsaPWdxEnBHVJMG0MJp4=;
        b=GxiBClxRsO+Aj797W/wKGqbJ2NeHv9AbbXAaGCtbHlinL6ILEqTXvftcAvEYtiGwiu
         2qn7clbfaLEuxxHATsfiN45BKTyMKXdRwjITUSPVPkS5yOMcrewJaLnmjnXSM06GBtRL
         6H+vM6ud9rE06Dioe8zha2bqeOduUZWnOqnnXKBmynHUXZu7hk1EQicIzI+1AeeMqsU3
         QcYNIB9jqZSdAwQbfy3sSXLeozTFcNbBuA/x/RXjpsnWo3yzzbUhKJSrsG14AYM9Cjae
         Ql8R0/6IRK01HcQAziorR9iXMOBgCC5eO71RDxoOWj52pJJTJcoGW2Y9anr5SJF17jvY
         bzJw==
X-Gm-Message-State: AOAM533t6ugfpWqKs18kGkQcacNWSAc3+KoPqEyR2oNfVcCgALdzXC9l
        TkVEcIWOw8V+T82SSs5bRb+rHhUGGPdBHA==
X-Google-Smtp-Source: ABdhPJwxCVIt9KkTXRrJoor8m4nBGqgk+zIpuhCk5x8h7z2nqJ78FmexzlO/mi2sOqRUblgiLRuvng==
X-Received: by 2002:a05:620a:239:: with SMTP id u25mr22459425qkm.197.1624272198255;
        Mon, 21 Jun 2021 03:43:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.58.161])
        by smtp.gmail.com with ESMTPSA id m189sm9552026qkd.107.2021.06.21.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:43:17 -0700 (PDT)
Message-ID: <60d06d45.1c69fb81.ab06d.e4d4@mx.google.com>
Date:   Mon, 21 Jun 2021 03:43:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5609831095654081481=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v2,1/3] monitor: add new Intel extended telemetry events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5609831095654081481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=504265

---Test result---

Test Summary:
CheckPatch                    PASS      1.48 seconds
GitLint                       PASS      0.38 seconds
Prep - Setup ELL              PASS      47.50 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      201.30 seconds
Make Check                    PASS      8.72 seconds
Make Distcheck                PASS      235.49 seconds
Build w/ext ELL - Configure   PASS      7.99 seconds
Build w/ext ELL - Make        PASS      187.68 seconds

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


--===============5609831095654081481==--
