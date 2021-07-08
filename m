Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5696AC07E95
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 02:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D69961CD0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 02:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGHCim (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jul 2021 22:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhGHCil (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jul 2021 22:38:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6260FC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 19:35:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ga42so6771371ejc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 19:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VBNdO3Om1Rvqk+3UaOnwFXvamJIQMipSJ24QHi91MpQ=;
        b=og7XbAX5owVTZGDXe9o0w1zVPdxXmJ5E90GNMPFIJglWlaXWLKydHjDXwz/RwtD5PM
         +AXOMcrrIV97TniUIIkpyYywGbZCpQ1noYN+/8iBBlDgfM33SupmCMxDJsr/E2JxU8L+
         8HM+ld9upb9GCHBlKL7BLhEPE9JWSuoImB4SO7nFwoBrwIaEzBCHbDGfQWn+jXrRf95i
         3ZclloRXSwAsCwR2uahyQawNUH7mdPjaozwM0I3W+rRSok52sU7VbFA0xVll+E3MIcqY
         uFKp1C0IJWOlcqoL4Am5s4oi7synQFODj95qPqgyQX7Dyh2bGq9BiGGNNtS49UFMBH93
         d33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VBNdO3Om1Rvqk+3UaOnwFXvamJIQMipSJ24QHi91MpQ=;
        b=frQcIDMg8Hz7WOdh6nb/TTFZx1Iu2yFzsLo1YmJR4SLioaqr+B+dnlO+qAos/vjV+H
         UFK7gpitVPmYxxzxX6ClCozUp+iXW50eOFOatlYTCGya02OgSBk9TSdBnhmxfxFk0CWF
         i2FfzSlQFeiUmYfsUfXgkq9DOtrXQEQ1XJfy4svv1oTRmgVDP5yaLONiqhA04W2lEpge
         Fbl+arwfZflD5PLM8R5VTy8o86ubBoxnLyaTIvw8b1iod7+fqoTvNZKPb576uWyi2kut
         H9d29afo3lmmVS8Kx7UGMSgW2dklfWkS9ChQ750UALxZ2lSA3hAX2Uck4q0oHUKw1RBj
         /lGQ==
X-Gm-Message-State: AOAM5307B2MUBA85q+BQAYxmImuXFb6++Bzql3kB865fZFx5jGV9UutG
        gEvdqDobGLspb7uYeQ53fFaTIRIHs/flrqWOJA4IT2s4T5t0yg==
X-Google-Smtp-Source: ABdhPJxlYD8m+88lc7bsUTWnYu43WJLmiAL6hnKZZFWc53eYAquZ/YpiACUNUQjkOQkv0gpxDBbfu9GWtemHpPU6uw8=
X-Received: by 2002:a17:906:71c1:: with SMTP id i1mr21810221ejk.549.1625711757365;
 Wed, 07 Jul 2021 19:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210628113535.Bluez.v2.1.I5dc587c2fe4bf2e49927513cd711d353510c12fc@changeid>
 <60d949b8.1c69fb81.7de68.0d09@mx.google.com>
In-Reply-To: <60d949b8.1c69fb81.7de68.0d09@mx.google.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Thu, 8 Jul 2021 10:35:46 +0800
Message-ID: <CAPHZWUcpvuR+V43VEjVvB0qXT_eyTEdXJskPtJxBn=AbvZ+_YA@mail.gmail.com>
Subject: Re: [Bluez,v2] src/adv_monitor: Remove checking in device lost timeout
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Gentle ping.

On Mon, Jun 28, 2021 at 12:02 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=507773
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.69 seconds
> GitLint                       PASS      0.14 seconds
> Prep - Setup ELL              PASS      47.87 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.22 seconds
> Build - Make                  PASS      204.47 seconds
> Make Check                    PASS      9.06 seconds
> Make Distcheck                PASS      241.25 seconds
> Build w/ext ELL - Configure   PASS      8.28 seconds
> Build w/ext ELL - Make        PASS      192.03 seconds
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
>
