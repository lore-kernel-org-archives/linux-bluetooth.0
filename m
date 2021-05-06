Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DD0C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 04:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA3661207
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 04:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEFEE6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 00:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhEFEE6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 00:04:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5310C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 21:03:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o27so3786783qkj.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lseyQQX+hiFmG0SI4BDlBYVh2edQapduJ5YXkTqlXd4=;
        b=BXrCuFooTtA/4VqjLX3fhmhrb9lz64zxQ7/hqtNjrB40NRv5pETf9Bz9bb1iNbRTJl
         mMXDILvenKb45BlwlYTExHx1j+jhbPhp1AWAJcoi9f919Uu7hvqAMb5Ck41+vT3CMyfH
         IlVkFGwiJXoYhuQy3ZDCxPotQY0ZpFdjqOK+6dRxafXkSu0WDA8Zt5SAHHM07TuyhTcQ
         ER9afVOYJH2MWYQodgyR04RyglwjAmy5qh8lAFvZcXzJ6+vG3rzrbEEdhDnPRxWxdvWb
         gGwdmHGfgpA3rbOVLXnbhDxEv3xODO3VxZKVtNP+X9hJybDLMOy3EOsqCVNmHhR7V7wR
         JlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lseyQQX+hiFmG0SI4BDlBYVh2edQapduJ5YXkTqlXd4=;
        b=KcY5tBJ808CwbmNtpDBrLDHknPKTGt4sGb65sJmXduqe8ZH0GqyievylYJ5S29i6wQ
         HBHrr+T5STTvr5fitVlr2SG4W5ID4KyM8sE00FawmTgDQwMFyMiiuvKRr93diNXCwAwS
         Q0Cwgdyfn4YSgxOlaDb4jdBykerhB6K+OK+hvXs7pw+6YsFK+v3+iU7uE0Le8whlX6U1
         Uao5ovJgYbwIJJYJvkhVqgdc6qb6qS8yorQIYQf+iyMYb1q3XQypXMFq8HPxa/owqJn8
         lGOqa1ZWcEKpSE+RO8ZRpU8GPqjL+EvMcnBB13Htxu+d/p4R8cT4Zyne1NKoNBbKlf8a
         swqA==
X-Gm-Message-State: AOAM533pKw/SBizXFVWZF8ZCTmHfCgQOP2PrWjqjrvgNZRPfAoPKniqG
        qOWOlU/neln0NRBYqlJTt92KI/ua+0ebag==
X-Google-Smtp-Source: ABdhPJxBiy2q71xn3gB9WsICR64ACU+KDSOY/drRd4yy5UyMusPVq3NQwajymVf9zhWmnIC+Gq0BfQ==
X-Received: by 2002:a37:7ec2:: with SMTP id z185mr2137909qkc.467.1620273838903;
        Wed, 05 May 2021 21:03:58 -0700 (PDT)
Received: from [172.17.0.2] ([13.72.71.105])
        by smtp.gmail.com with ESMTPSA id c10sm1053296qtp.89.2021.05.05.21.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:03:58 -0700 (PDT)
Message-ID: <60936aae.1c69fb81.e4bce.68c2@mx.google.com>
Date:   Wed, 05 May 2021 21:03:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6946218620628548635=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v3,1/2] PRE-UPSTREAM: unit/gobex: remove timer only when it's not removed yet
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210506114234.Bluez.v3.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
References: <20210506114234.Bluez.v3.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6946218620628548635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=477667

---Test result---

Test Summary:
CheckPatch                    PASS      1.33 seconds
GitLint                       PASS      0.24 seconds
Prep - Setup ELL              PASS      40.93 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.15 seconds
Build - Make                  PASS      174.64 seconds
Make Check                    PASS      8.56 seconds
Make Dist                     PASS      11.62 seconds
Make Dist - Configure         PASS      4.47 seconds
Make Dist - Make              PASS      70.64 seconds
Build w/ext ELL - Configure   PASS      7.16 seconds
Build w/ext ELL - Make        PASS      164.49 seconds

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


--===============6946218620628548635==--
