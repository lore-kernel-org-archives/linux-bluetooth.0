Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80733C07E95
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jul 2021 23:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D27F61107
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jul 2021 23:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbhGSXLc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jul 2021 19:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387999AbhGSUlA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jul 2021 16:41:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE04BC0613DC
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jul 2021 14:17:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t186so29879394ybf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jul 2021 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=S4AcFcPbXxhmtLS+6EG2EaS08QltzWZhNSzNb2rMJoQ=;
        b=hilavFmPa4KjRLWkSt6OzFgVdvN22Pvac7AJm1ITt3s/eBL94u0S13bTzdBlPmxCt9
         g1Nb9t08dvSEb9Df7+sQyJjxnEYqYOAqgYDwR+XITmcx+k/4dFjHGdXTX4OBqMnmcPpy
         kCtdyoeM51Bogrwoh5uVC7V1QNU5dD7z5vSokdna8gc9KKn54N+mBQOguAeceEbUx2iS
         anDK/00JgF2mGQQxk2+FCZdnEYg9N/vouFDzS+MPiZSm9XKSzwLdEznanA35sqJ+VerU
         hpnDhnoooLHYBn5lRTg+ijdGqENfuJLUH6S2jUTiw4ZDxl17unbSThuidqj79nYWxXdP
         2jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=S4AcFcPbXxhmtLS+6EG2EaS08QltzWZhNSzNb2rMJoQ=;
        b=haPqelQ1Tok/bxa1InvrQCZ5qDBKoQ9GGMsv4otTsu4QxwZ506KeNmhW3nROYCg0Ex
         U6LuRR7MSyjRHX4bdX9/w2Hy9KjQJXwuHxpQYssmj2tXAeonO8xKpnU3UHmbb+D4nLra
         2HIG7/DWbKmmmAb2NKXxO7V7P8h5LT3My7Crm6PpHxmrfkH7r4dghYR2NGiWYATSNOgk
         qmRZCzZxwSg0jScaBahxK8yeIcJcEAaoz8Tx/bP5jiRMdKxv/+su1Rz2CUChcqKVmME4
         PgBahzX6mXR7TeHJO5ueNFlb+klFoQfJzVwITPlUYb+oVUQtLoqzJIgOxAoRIX/AuIMv
         AeiQ==
X-Gm-Message-State: AOAM533kzl2u9rYGtL6ZsHOgr/caZdQqerqyIwhMJZnONzFnsVW5s+CP
        xAFu6B1JcLVai4GmsVnbRD+LqFqK8kxvaXmTLlWGc+5MmZ8=
X-Google-Smtp-Source: ABdhPJwn6XUDPWDxBt3OveYFt+ryvH848QmP/VKCZbGPVSO6Ciq1RL0bHF8p+YKzo7wGP1UWbLG1Vuixc/2OTnOzgRU=
X-Received: by 2002:a25:fc1c:: with SMTP id v28mr35233087ybd.408.1626729455829;
 Mon, 19 Jul 2021 14:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210714235832.2992619-1-luiz.dentz@gmail.com> <60ef8eb3.1c69fb81.18f73.ba5e@mx.google.com>
In-Reply-To: <60ef8eb3.1c69fb81.18f73.ba5e@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Jul 2021 14:17:25 -0700
Message-ID: <CABBYNZJKcK+a7tGo1Uz77GFnpsL+ggWkhM2YnbsBOCtJGCFPHg@mail.gmail.com>
Subject: Re: [v2] btdev: Add proper checks for own_addr_type for LE (extended) scan
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jul 14, 2021 at 6:26 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515773
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.36 seconds
> GitLint                       PASS      0.10 seconds
> Prep - Setup ELL              PASS      40.59 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      7.09 seconds
> Build - Make                  PASS      174.33 seconds
> Make Check                    PASS      8.79 seconds
> Make Distcheck                PASS      207.88 seconds
> Build w/ext ELL - Configure   PASS      7.12 seconds
> Build w/ext ELL - Make        PASS      162.98 seconds
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

Applied.

-- 
Luiz Augusto von Dentz
