Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5599C49EA6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 20:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA89613B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 20:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhFXUOv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhFXUOu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 16:14:50 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B67C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 13:12:30 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b13so1115985ybk.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5T5dcKVdRg/n4Xvi1zGf2gk1NDADfeEbU6EAsqoPY/4=;
        b=NtbidzYgP5p/Cg/kfXAvaNqtFOWS8dR+uwJ52v4D/KGSkhoeN3qruqKFlzmPjMo8Z4
         RNGJqBajLx0jmbF+7RNyjyxnFCB6EjoOB4zZU/+nduyk61L55fDApfDJqxMS+gUs8es1
         8ad7hGEF+mWb4J6kEAnEr866IW1CZDyMrqXm1slB8YHgxjCaI4E8v7BWCW3wGyDnIeVE
         2czREYwd3U1KFFlvFJkdFq1nPzwUEahohNb+gj3uHreDBRoMTHd/rhKom527JuC3rXIj
         umt2cO033Ml1ka+HYlpzCeswN6Cd+spBXvA64yHmjcTqQYR6ZnDPeMAJzZucwuJUZULK
         oirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5T5dcKVdRg/n4Xvi1zGf2gk1NDADfeEbU6EAsqoPY/4=;
        b=frRVIvPFHyxLCXEmh8ANfYUCfHZhqpuGbln93nxF18VdH2gkHYLMsxSupkDw26vK6W
         bHEzCmhTpt7lmJzLEjDFWbqIMKW/VENduMQh51HWQ5trk+LvdecADHCS+rQKmw7Cu0Df
         RezVoc9xzrrefIF7V3m3X8zXDC6eRGME202cN43+18nKBJt5L4lWYJrTOgPu+nGTzH0q
         kTPexWRhaRIp+ZpvNjbADGXrewpHDRarxyfkn/EkcUlw2CR3+AYiOaMQWk+u4S9P/b0H
         xtmdmy1gWGq6jXBi4kfV1zSuNxMKlTZG7gN8gtTzQLZ9yg1RShw4s/gwYPQ2RVVQ1MD8
         LysA==
X-Gm-Message-State: AOAM532kGkbFd7G2XEZC1bBqdkToVeLOfkGnikklGMuu+c6RBvV6ayod
        9DYkJQLsqZejHoeH+Oz0eXzUfVYfCcrRrmWCOesePhdgWs0=
X-Google-Smtp-Source: ABdhPJwVIJlu3JCZfmkJobWhsePqw14Xio5RcWWlfuXu4frO6BnzUzNhpxu4E72saVaLLwCZb5YCFf5+ekG5HCIg6oE=
X-Received: by 2002:a5b:b44:: with SMTP id b4mr7308301ybr.440.1624565550052;
 Thu, 24 Jun 2021 13:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210624174401.1881338-1-david@lechnology.com> <60d4d1ed.1c69fb81.cb32c.fef0@mx.google.com>
In-Reply-To: <60d4d1ed.1c69fb81.cb32c.fef0@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Jun 2021 13:12:19 -0700
Message-ID: <CABBYNZ+pjLMRgRJg3bsOWLCJKM_x-BeGHHJoH2+gg4hOba6hVg@mail.gmail.com>
Subject: Re: [RESEND,BlueZ] doc/advmon-api: Clarify Patterns property
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     David Lechner <david@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Thu, Jun 24, 2021 at 11:44 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=506641
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.23 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      40.64 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.14 seconds
> Build - Make                  PASS      174.76 seconds
> Make Check                    PASS      8.47 seconds
> Make Distcheck                PASS      210.39 seconds
> Build w/ext ELL - Configure   PASS      7.21 seconds
> Build w/ext ELL - Make        PASS      164.53 seconds
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
