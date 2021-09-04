Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4CDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 00:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E74760F92
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 00:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350601AbhIDAeZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 20:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbhIDAeY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 20:34:24 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F813C061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 17:33:24 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id u1so708897vsq.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I71fM5nYfr80JM/eiwe4tGXaJ/J4M3g/RbTMABtU0I4=;
        b=R+bVZLmI/05qVY9q9AqNlOjDNj7+c1NjGbWsQUx1F+2gwO7mRXN1LjjKURIQRWgrFq
         DnkoKYEzVhACvRxSA8kOyd9qdgCIfVZi2vw2xx2CW0CWA/GiA7UOnzt2qYhRGxSDesF0
         NdJBpzXLHt7d1pmCQo0ulohEppy6YAl/ZV3/p1HhE2LBV7tr+yd0cfLVMwRlNt3drOPa
         qygogtM9u+AvnVVl27bHeVoanDD3UH8y4x5bkYhp1DavlrM+JO3bh6BxfnLNhRM2yCLL
         /Rm/FzTXFJU2B5btJA8PxTh9TH4KL8lj8W/wXNTE4ld3U/X20zfMitJT9xi4JanA9bto
         iB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I71fM5nYfr80JM/eiwe4tGXaJ/J4M3g/RbTMABtU0I4=;
        b=K1tJDgjKewB9V5XDg4lP4smWvNdpThVE/Rp4+8Xpky/vFYvYndIqzhuT3pFx8wsZSf
         JzHBHkhA2qjimqekhAi48NuFghA20gv8yGpD5+3jy6uPC20D+j+S+O+czG3+X6R8mH7I
         0JkkpwVc+0JLfLVKte+HOb4OHIkNcoMyM6ifudDM2TFCPOMDCcMo9lNWUtEAZUTMOhVD
         73lMKCAMVF8jwJeQLW6OrsrvDpxWJFSo5jAiM3Kxt0I/RMVcQlSdqaCCkcx7WWLKeVi7
         7WbTBMUKb78hz5hvOjpqx/EwaoCytl2pJP8SvRaLQuZMXAKK9Mba7wjXm8uwltypt36i
         q/Bw==
X-Gm-Message-State: AOAM533l0kQ+O37yOltO96yh4J8857cheqhrIsRC5diTUlc7DyBSa0JO
        50HwrDxfbZ6YSDaJ6EgXgb+QkPEZqebB51gzpsrYQIY0
X-Google-Smtp-Source: ABdhPJzfSNFjKfPjqiH6FH3tFq8JD/q0QsZ1/DjVsZxOtbLIbqEKf1OR87bcVLLszpMcerASoP9TBJvVlCVlM1HK0fk=
X-Received: by 2002:a05:6102:3ec8:: with SMTP id n8mr1208531vsv.39.1630715601496;
 Fri, 03 Sep 2021 17:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210903140118.3469656-1-alainm@chromium.org> <6132322c.1c69fb81.451d0.b741@mx.google.com>
In-Reply-To: <6132322c.1c69fb81.451d0.b741@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Sep 2021 17:33:10 -0700
Message-ID: <CABBYNZL4WkJWpj6CdUUtHu3mmNP7Z8uuONbjve2-RNZrnv+fWQ@mail.gmail.com>
Subject: Re: [Bluez] shared/shell: don't allow completion fallback
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, Sep 3, 2021 at 7:37 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=541783
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.27 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      40.85 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.13 seconds
> Build - Make                  PASS      177.53 seconds
> Make Check                    PASS      8.82 seconds
> Make Distcheck                PASS      211.31 seconds
> Build w/ext ELL - Configure   PASS      7.27 seconds
> Build w/ext ELL - Make        PASS      169.16 seconds
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
