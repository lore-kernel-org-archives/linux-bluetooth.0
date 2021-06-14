Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B5EC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 21:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FAA61166
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 21:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhFNVvs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:51:48 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:47054 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFNVvr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 17:51:47 -0400
Received: by mail-yb1-f176.google.com with SMTP id h15so17467932ybm.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FLEQ6B29ZSKg/yAHne/5r2gTjPEABCf+4PxtoJFZ6FQ=;
        b=YLL4R1ja+7mhk9QjraIgKKlPtsJySXRBVVzJqL5kTKLG6yaRT2/Vq+1hQ2+bqEOzCT
         nzwE2wGWI6BKoiCs+nffckNNx3OFeo0qxQ3sJomaPu08+WW4io0zsVvGdgNMmKQxyJwe
         2HG36u876+ZNJsoncHtsOxYo2KHVWerxhRVAg8rCuPvURedsfboSOzeFq7u+kxFV/JbY
         C3ogR2SFvAJEvik9t6L7raTFFcOQuQbdBvhYxn1S6dmDqQHXF8JGlezmdyo2leoIxRSL
         UTIFnT/Ck8cPZ4ckQ20zC/CMOqrJ/8Yf4VYTUV0IXPDgrowcXmbiolPXhTgtczvhU0pm
         7UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FLEQ6B29ZSKg/yAHne/5r2gTjPEABCf+4PxtoJFZ6FQ=;
        b=CeNbb6aShGUjHaaENlTDXSDwenMiB6qPR14QZf8Y7/zdGn8f6h14dXMke3ZX6Exxh5
         fgM9fZF+z7QGXvIi93zyl3oZU/emPx/vNX8+Tz9ovhd4BhJ5juJsFPUtbuPzuZe+esUO
         IWhV2MhizbeDegAJ89zHI89IB4rXvDb8Su4XQWd73twvX9VOKvjqrvAHzAV0BkwGT/+L
         w7SLTykR5Z1HCmflp0EhMgqE05hSDf06m0ggE1uBvGAFX0dEng1XePPNIXGzmawuFYA5
         3XdIFnwlZJbTJlt2Aur7DiW8j4HTSyr/iIa80u3Tre9jF1pReKTYWtdOAt8Os/6r/JjY
         +/0A==
X-Gm-Message-State: AOAM530iW7QwdoCJMjY+6ArGhP5EVaHxrKVJu21vsmJR+BZyDPESc1HT
        LHfsXCYMrHH8R30vfjKWGmdrNt/QWU/uV/p3CVBP2Md+AbU=
X-Google-Smtp-Source: ABdhPJxg3qAQ7oKNSQk1RygXrsiOE9Hr2u2I1U8EKEWMqhm7UR6iO3r9O19J0qygh8nRGCPfpI88vGE1xkMKckiXJjo=
X-Received: by 2002:a25:4048:: with SMTP id n69mr27452271yba.91.1623707309833;
 Mon, 14 Jun 2021 14:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210614174625.1259675-1-luiz.dentz@gmail.com> <60c79c18.1c69fb81.5961a.5bef@mx.google.com>
In-Reply-To: <60c79c18.1c69fb81.5961a.5bef@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Jun 2021 14:48:19 -0700
Message-ID: <CABBYNZK1LMkDqDuW=qwKonJD2yuAcpvtGhjosZo9SHw8Sk2uJg@mail.gmail.com>
Subject: Re: [BlueZ] mgmt-tester: Enable Kernel Debug Experimental Feature
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Jun 14, 2021 at 11:12 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=500073
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.45 seconds
> GitLint                       PASS      0.14 seconds
> Prep - Setup ELL              PASS      50.16 seconds
> Build - Prep                  PASS      0.15 seconds
> Build - Configure             PASS      8.54 seconds
> Build - Make                  PASS      218.90 seconds
> Make Check                    PASS      9.58 seconds
> Make Distcheck                PASS      253.81 seconds
> Build w/ext ELL - Configure   PASS      8.71 seconds
> Build w/ext ELL - Make        PASS      203.58 seconds
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

Pushed.

-- 
Luiz Augusto von Dentz
