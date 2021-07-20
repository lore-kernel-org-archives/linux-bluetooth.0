Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA7C07E9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C5561003
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 17:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGTQ7u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhGTQ7n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 12:59:43 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327BFC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 10:40:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k184so33780529ybf.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alfYTnKnJV7hbE/HGGDxCyGgS0hp4r3nD1l6L1hWsHc=;
        b=WG/2sKXoUm8yOwBucLBuV2mJLvNJLQ3B7uqEWku/nxTj6RT1XOVl4NKpmi/2V0tzD0
         CpubQqyRbzJahDQxJjpREPXN0Y7xlNJaB4mmRp4bp1QWEbQC39U4DdU8qQANDj6d2roI
         7wbPuUvcAzzzQqe829u/tsGmXfHXHEzWHCawHB/UgCXRSMYWYYAq94m6zPX5PdaOR+W1
         /CXifRV5ViLpy4BbOJJqeGGOIT5Bh2hpQShV+AUj7D6t6pUwcVQq3YZc8aHPjGocWCmr
         HKtmn/w2UeIWCv+3srSNckNr3MbeyZZPOsFR+g/YLJVTLE7ZYWayjyN/OFTovbR1zFMU
         X/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alfYTnKnJV7hbE/HGGDxCyGgS0hp4r3nD1l6L1hWsHc=;
        b=RxYcDhgn4bvT4OPKs9lN4KnQDgx9H+n+PggM2YkTL8rkSY4FOu1XJjdMheW14CenGn
         wz0tLAuJ6oYRM7TwmHC2QTQ6toUIhkQ9qDdzRU1z0jkwCR+onck45Pw/G+CdxLENnurE
         epCdixuxVC4GJHeunWsU9jQycA7YVFojY3/qbliddvd3/mEUih1HJ+vnPgfBKMit/5Cz
         cNpzq1VpA6zcmW9m5iJV6AAtvUjw/ltn7PZmQNMa5kmD8Vnw7zM8XkB9AYFnsRy0uVdM
         cg7mIlFy1P6/DyOvIp2sGAG3mQRi0XBocgiZb2L66rAiSuNOSkm5QD+/o+GtG0rNxtJ/
         zr9w==
X-Gm-Message-State: AOAM533zbpOcCb+9g6ZDK9ohg1z7znd0faIPpyP6dsAF7RhQ4WqdJyx7
        5V8x3sJUlqNPE8IdKB5cRXRoIHEj+xZVI3e1mMYRvSRg
X-Google-Smtp-Source: ABdhPJy/gJYbLhvafG0AIc+myAAyFYB1bASt5Yvpp6pD5rr8vDcsHN0TbpWi70pjk9n30lal388nZ1TX8moLcuq/Ua8=
X-Received: by 2002:a25:be02:: with SMTP id h2mr41341477ybk.91.1626802820281;
 Tue, 20 Jul 2021 10:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210720195130.Bluez.v1.1.Ib24a67a8a849f311d5213f83eaac3cfbc54b7b58@changeid>
 <60f6c66d.1c69fb81.66662.df3b@mx.google.com>
In-Reply-To: <60f6c66d.1c69fb81.66662.df3b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 20 Jul 2021 10:40:09 -0700
Message-ID: <CABBYNZJrm7ZwXNxguu6+TQiK44KNgUP7cK8FWQp4GqP6+u8cMw@mail.gmail.com>
Subject: Re: [Bluez,v1] core: fix a possible crash when removing devices
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jul 20, 2021 at 5:52 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=518263
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.37 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      38.35 seconds
> Build - Prep                  PASS      0.08 seconds
> Build - Configure             PASS      6.70 seconds
> Build - Make                  PASS      168.29 seconds
> Make Check                    PASS      8.36 seconds
> Make Distcheck                PASS      195.34 seconds
> Build w/ext ELL - Configure   PASS      6.65 seconds
> Build w/ext ELL - Make        PASS      157.00 seconds
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
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
