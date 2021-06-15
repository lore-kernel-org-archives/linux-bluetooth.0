Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DABC48BDF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C78613B1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 20:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhFOUk5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOUk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 16:40:57 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BC7C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 13:38:51 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id if15so418092qvb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nQQZRAVBHuynYYK6P6D/LMkEF0RnLUlkJVUtimJcLq8=;
        b=pQfg3+5mVVaMgtK4MS9OTmbi8ddB9aHy0ZOrZ+W6OgqVxpwv5MvbC6KyQk+F5y+/Ko
         qnfj8CZCrmxECMHriqkFxINKyEXKuEDMdgaaE3DI8xjEiaZZkXpJ+jlhI7qADJdWRmSH
         XVaPQf1+CMHaQZ2MTkcgK/Je+DfpusrUvl/A2wUqHq/39WqbJWbgn8g9q3f2rHbLtjds
         Gj6Qyw7px4w0YC2YsjRk9karXkUhvzVxlTFE2fLm7jCk5XemPqRV8F3Md1iQugjjmPqI
         cF/zk/ravkcaVWH4mBZ+3kFLER2V1mYRtBu9nGFf29MGnQ1o+N5czGQ2yBzHp7axpE77
         E6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nQQZRAVBHuynYYK6P6D/LMkEF0RnLUlkJVUtimJcLq8=;
        b=J925thh+qG2dtWi+lurKE0WGutbPAH+DrpscSKrgLjRJeUj8wAo/q1Qtjf+RA4jT8E
         /t4BlZMai3lT76CP8FoNIPx4MyCOzQN2X1A/iXKvnjTet48qki3sxNytwAnYTnkc2urM
         INsw0GTtgEzFb6luG3WrqBpGTR8b8ehMfwhnwxLMqaWa9MpocbWisAYU0nX4nLWb7Uso
         eggUdDjlHexdagdRSzoyFimvEZrFb+5nEM/1o3kMX8vfh4EY95C4een+8zUFIa/3jQHJ
         LMh9JapWoi3OgS/mgbMXDR7FFzKbksTQ9Ep564bP99GpEv4bTJzB5ZTte30Y3DhDWmO0
         ky1Q==
X-Gm-Message-State: AOAM533tq5101xcnOrfH6lQW5X1/gksbXyqtYkIj/JtvYAuGLTUxaa9g
        yowRNrWrUt7wXZLNh7Kt8OnzfR9uFk2JMA==
X-Google-Smtp-Source: ABdhPJwZS9kobQaZ0rhwMc3YjH6kTrkyUP5PvJIwNKjDBihWKsXCmr4B6ahMlwUpzHqxvqprnsFYJg==
X-Received: by 2002:a0c:f0c7:: with SMTP id d7mr7137160qvl.45.1623789530959;
        Tue, 15 Jun 2021 13:38:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.18.101])
        by smtp.gmail.com with ESMTPSA id o123sm144940qkd.6.2021.06.15.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 13:38:50 -0700 (PDT)
Message-ID: <60c90fda.1c69fb81.926c3.13a5@mx.google.com>
Date:   Tue, 15 Jun 2021 13:38:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9193491018153365820=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [Bluez] monitor: Adding missing device found flag in the parser
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210615200005.946131-1-alainm@chromium.org>
References: <20210615200005.946131-1-alainm@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9193491018153365820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=500957

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      43.79 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.85 seconds
Build - Make                  PASS      191.98 seconds
Make Check                    PASS      9.61 seconds
Make Distcheck                PASS      226.34 seconds
Build w/ext ELL - Configure   PASS      7.96 seconds
Build w/ext ELL - Make        PASS      181.91 seconds

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


--===============9193491018153365820==--
