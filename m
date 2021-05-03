Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B3C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 10:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71ED8611AD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 10:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhECKno (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 May 2021 06:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhECKnn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 May 2021 06:43:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC4C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 03:42:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l19so1799185qvu.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5mBzDhOwNtugXRG2Mybodo7JCiicAeOqJMSuPqu63Cw=;
        b=g8EWSP/rTyVjr/zcTuWl3T344WU6vziWtCRlR3b8UY5pyipBotLwdgpc+ZiNtoJbws
         QJdsCZOvg1TKKgF0oxPAx6z583P62wiDKvnUNV1or1VrduKWasXdaQElU+tlxxqVmoxL
         1Y4I281n7CDq24HUW+Tj3ouETA3aRnLEBZLVexbAi8tDjv1eyZ0ubhAopvigzWDsz2Jj
         d8DE/V+ZrLA3ELxZFf22gpoFWsuwz7tSirB8kjEUGr2ROQGh44XiGzGOzuyMb5zwiKbe
         haqNY01vsaMiyuMtN2ZVrL6sT7CxZY9IiNpnAY1eV0idRQsplt32YKl3shyBTX8ihSyM
         1QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5mBzDhOwNtugXRG2Mybodo7JCiicAeOqJMSuPqu63Cw=;
        b=chBNc3H79qxaM8DcZWW02KMzaZSVUbCeX/8PPabfVrjmkmtsWrlP/4dks+5vSzcssU
         3UTizXdosjJGa0gfrT06J7M/QPT+vcFshOygxpRzkxYuV9WkLwCf6r7mz0rabqaryE9U
         b5bSrfs5YqjX5u6stBvUHOsUBQN1JrLL4lH5DeHGINIPx0/i3Dh1n9C+zOFo71Rc1EEk
         OlvyBBchxM/XHJWea4ytMtSIaqkPqw1A0ADr5sh3V2sBMghgIPpPvBiytqtXpCD0KNDp
         cYa/3CAwQ9ExainyuqZ8WODUKIDYcrMFVRO/RE4nzwP0+1GtVlzFFlkdLZ4nHwkVfiCw
         9I8Q==
X-Gm-Message-State: AOAM5313I5yHnMvPIrnEExpt0eSfdm3UvZhsLewMZT2e0XX6HnBaWoeX
        rh4lnEVqqayuDu44dS644IY0ROH+6pUyNzm6
X-Google-Smtp-Source: ABdhPJyaJqpcw5dZf3UyjEQOKDo0FEDzktJS+iWA8xnLYef/aGUi46Yt31usq56NZ81uHLQHFmJP0Q==
X-Received: by 2002:ad4:4b33:: with SMTP id s19mr18497225qvw.35.1620038569374;
        Mon, 03 May 2021 03:42:49 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.222.42])
        by smtp.gmail.com with ESMTPSA id j9sm8132460qtl.15.2021.05.03.03.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 03:42:48 -0700 (PDT)
Message-ID: <608fd3a8.1c69fb81.2ced9.c634@mx.google.com>
Date:   Mon, 03 May 2021 03:42:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7574387887069166989=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,1/2] unit/gobex: remove timer only when it's not removed yet
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210503180321.Bluez.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
References: <20210503180321.Bluez.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7574387887069166989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476307

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.27 seconds
Prep - Setup ELL              PASS      50.39 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.85 seconds
Build - Make                  PASS      210.42 seconds
Make Check                    PASS      9.36 seconds
Make Dist                     PASS      13.67 seconds
Make Dist - Configure         PASS      5.55 seconds
Make Dist - Make              PASS      86.39 seconds
Build w/ext ELL - Configure   PASS      8.88 seconds
Build w/ext ELL - Make        PASS      199.24 seconds

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


--===============7574387887069166989==--
