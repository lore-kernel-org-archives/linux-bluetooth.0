Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C17C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 17:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9B16103E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 17:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhG1Riu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1Riu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 13:38:50 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866BDC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 10:38:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id k65so5202226yba.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CBfBiMnq8n1CGum1MHdnOJooBrmDLh8W//4KGkz/KM=;
        b=qyv0N2Nph6U9JwRyotqlZtaHWtfPxtPTicl+GerTuUNBFzphH8mLxHJCvPb9MwDVPe
         MU/WHRuyDnkigHbYwBf9oHFShVpzwAe8SWypD+vHVmbojWe7doMzD+qRChnbsmosdkMC
         X6AztFuN+Nvicecx2UFAS59jhFzqCJsiGZZ7Lm9GviZN+GpGj2qbIjGHgChmZpP4C3Df
         rvWCS5ANkbX+d5kfpFgA9KCkJ6ln7h7I4LrL3FUHYa1SO5TFhGrOcFHrwzD4QutI1Lp5
         dnRU2WsCyIc2PdC77ddM/Q+C5Gum7Kl8BXQjfBhFjd9cQft6sq2KbfGmsh0ZkdzXp0so
         wzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CBfBiMnq8n1CGum1MHdnOJooBrmDLh8W//4KGkz/KM=;
        b=nPrDqQ0aSxnJB3MHdYyRTDsUNfB6zTcFFGjtZfZYyQK60Ek7eVU0MkYlVCfb/HCa0S
         XWFBuLqoPhZNYpr803D8dhytau1bVAuMSkXyiFZy63W7vGXEcoOaXA+wEzEXgIamJZNK
         4QvabSC0sTb67StzojWaXAWacVxEKANohL74MS1nDz8mNfHA9nK0KwARLOYIJvdI7VKz
         LsHx3WjfB9whUxCCQNdKBjAUo2OQW//xsutIn4ObXLyWqkOmD98sdtY7Xom/cM2ezFRe
         bfkAnK/N1V45OJzYaFqOW/SDQ4lrZeFnEf1DF+59WDmnn10t9+CPK1YgpbtfFa0Y9uAP
         6ypw==
X-Gm-Message-State: AOAM533GZgcdy6EdlD9+gBI+DPdauKpgLVC45E46JU56U6624AZvjlLH
        uqGQyPh8cNsnlQ1uNWvHurrk36ACbZVtK5dRGhPSnmX/4So=
X-Google-Smtp-Source: ABdhPJzFFKgrkARa0zibjLE52KqcPyGOo8WXT5XCDdexIPj7R3Clc90TO3LH2n5VA4W88+t5CJZ1ePRr8BRVCYvnsAo=
X-Received: by 2002:a25:b741:: with SMTP id e1mr1075369ybm.347.1627493926603;
 Wed, 28 Jul 2021 10:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210728212259.Bluez.v2.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
 <61015f06.1c69fb81.1f3ca.029a@mx.google.com>
In-Reply-To: <61015f06.1c69fb81.1f3ca.029a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Jul 2021 10:38:35 -0700
Message-ID: <CABBYNZL0R_1XENCaUkn-+vQp6sSh-8A+5Afx7otmhHVzzQv9Bw@mail.gmail.com>
Subject: Re: [Bluez,v2] gatt-db: fix service in range check
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Jul 28, 2021 at 6:45 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=522683
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.29 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      40.81 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      7.35 seconds
> Build - Make                  PASS      176.55 seconds
> Make Check                    FAIL      8.72 seconds
> Make Distcheck                FAIL      190.86 seconds

These will need to be fixed, I suspect removing the check completely
is wrong since the condition svc_start < foreach_data->start is not
tested.

> Build w/ext ELL - Configure   PASS      7.24 seconds
> Build w/ext ELL - Make        PASS      165.61 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - FAIL
> Desc: Run 'make check'
> Output:
> ./test-driver: line 107: 28579 Aborted                 (core dumped) "$@" > $log_file 2>&1
> make[3]: *** [Makefile:9910: test-suite.log] Error 1
> make[2]: *** [Makefile:10018: check-TESTS] Error 2
> make[1]: *** [Makefile:10412: check-am] Error 2
> make: *** [Makefile:10414: check] Error 2
>
>
> ##############################
> Test: Make Distcheck - FAIL
> Desc: Run distcheck to check the distribution
> Output:
> ../../test-driver: line 107: 47458 Aborted                 (core dumped) "$@" > $log_file 2>&1
> make[4]: *** [Makefile:9910: test-suite.log] Error 1
> make[3]: *** [Makefile:10018: check-TESTS] Error 2
> make[2]: *** [Makefile:10412: check-am] Error 2
> make[1]: *** [Makefile:10414: check] Error 2
> make: *** [Makefile:10335: distcheck] Error 1
>
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
