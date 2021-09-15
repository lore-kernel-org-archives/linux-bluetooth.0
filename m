Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C3CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 01:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D399D61244
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 01:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhIOBCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Sep 2021 21:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhIOBCO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Sep 2021 21:02:14 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C2C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 18:00:56 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id d6so1148234vsr.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 18:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7rKL+Vnfb9mIADv3h2bDWVhYJ+my+rzPWgKlI+4Hrs4=;
        b=p3xiGCZkMnnp5dNj+z+jUmDgHLbBIUxpuHKNiK/hUXY3LahIiRTizHT6G2SIFakskX
         7mCIqQqKQ1Ok24es5lM/4doe4EKhho8XpRGdyGRknbOUDKDUWqNAWbQToQWeTJTMwkon
         hupMDzEyXAv8X5ECpMHD8g97eO1qXs6Z2hvrWWEKJj0nzws/f7ZWxy3mgOPAgRCg0Y6y
         UQ20exXxNyI6tXWS/2C1pwe5x8w+qJEByulm8zExVT0LLM63zyi3G5sjhpSp2LONugSY
         Oud4CUKzt5laIKqPM/BpzlOeLgPY1ohJlPcHEBHC8/s6NE1KJoaiKQDRO4BcSbu51WRY
         ntFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7rKL+Vnfb9mIADv3h2bDWVhYJ+my+rzPWgKlI+4Hrs4=;
        b=hMLrSccOx0beBZyp8Mprkrvj0ZwkQ/vkgz1JwvVicKeenKpN1HkQpvzFqYJ44VXmdx
         TnflcqPBg1ALuNJqUvkaZtv6Tk6X7sfJy+M2r3D2fRtWXwf401TreKjhG1NKV3I4vcT8
         L1o+g3/WB0xX3DzzzgoNA6ZLjwVHPpYbJzh0oXPmRrN6wEP2mEJ07MeRfaLrz9DtP6NA
         eTYrQ5tgVFvRu74/y1+ouDz4IykubtPmthy9ik3MeRnyM+c4/QHLShtngMjHN2c/2azu
         JqodNLE+13PDcuFtPMiLd9MUwP6srWXou/dfVlX7RgtR8ZZ/HmsyDIDW3Md/5T/aIYkq
         6q5g==
X-Gm-Message-State: AOAM532FhP9I4jKgeY8ucR+abc66VDjB8XUPs66OhZtheMKOQLYjPKb5
        7RQ7T7JbPb3pYQsOT3DKn9StNcX1XxX+xdsNR1YinbA7
X-Google-Smtp-Source: ABdhPJzY8cz2IEBYmQ/sjKWGlmNTtb7q2tQmWWaiv7t0cMVLV8A5oBhy3tNlKSjUmovmLegYa6TPaJzyHWHZGxSMHCc=
X-Received: by 2002:a05:6102:31a5:: with SMTP id d5mr1823964vsh.23.1631667652627;
 Tue, 14 Sep 2021 18:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210913201341.3515285-1-luiz.dentz@gmail.com> <613fb66b.1c69fb81.4e083.5b80@mx.google.com>
In-Reply-To: <613fb66b.1c69fb81.4e083.5b80@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Sep 2021 18:00:41 -0700
Message-ID: <CABBYNZ+VGB1BAsG=v5fEO_oHHShhfs1q4BJOHHU8Ku-iUEPkoQ@mail.gmail.com>
Subject: Re: [v2,1/2] shared/util: Add conversion function for 24 bits
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Sep 13, 2021 at 1:36 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=546113
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.50 seconds
> GitLint                       PASS      0.20 seconds
> Prep - Setup ELL              PASS      39.88 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      6.99 seconds
> Build - Make                  PASS      173.70 seconds
> Make Check                    PASS      8.77 seconds
> Make Distcheck                PASS      205.84 seconds
> Build w/ext ELL - Configure   PASS      7.14 seconds
> Build w/ext ELL - Make        PASS      164.39 seconds
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
