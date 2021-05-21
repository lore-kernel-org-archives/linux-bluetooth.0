Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB349C04FF3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 23:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BD06108E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 23:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhEUXz2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhEUXz1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 19:55:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33243C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 16:54:03 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id h202so9086157ybg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 16:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfgwY4HGiUVEw2Cinsoc8jUdPS+bg0FbJzjuNudBIpI=;
        b=qmc0wtYXqFDy4m2OWQwbwXgD+rCBCQ0x4Vv2VV8c4if5/7gxawXKU6cwCjchfC6cpU
         +7U85AG1wggr+r3Yp18RsbVXm5n3WZAVpBb8Hm1kOY+N9ydblFL68t/p6cFi8nW3pzRz
         LraIT1NG/QFkBoU9Spo2iusn3ksN1Ldk+0I0VzezICQnAKY9BcJlzKfjiBCJ6CjTCZX6
         DYZwoEaCzAT+MN1/51IS0CE1lBkYajAhwhMZc5OTjEtO/+PbJySAMRgUHupSA3gabuTl
         HkLMIM/oqO6TLwbtI6N1XGGQuHtL/RZYmF2Y+2yyW7h3yvMUhnuGfrRHgLLBHT34rAiY
         beGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfgwY4HGiUVEw2Cinsoc8jUdPS+bg0FbJzjuNudBIpI=;
        b=tJpG+Gcky36ZeH3O+iOU6g99Vz2mw5aQF13Qprj6ZkEmHSWrh3g3men7JA/aWTcTcD
         WewH1J0zOage+AFcvjVfTR53Evt7bP6AjDhDSQKT03FI45JZ2FJk7/b3lB79h+3RfQi7
         ASsb+VhASLXm1e1zPs3wWcoLSFTqb1SWhi7lJVwekCj/VWgsXHjiO0rs3JQmnZwx44+u
         yXgxAg1OqFd8IWTKMt3SDw+2RCzSXNlpXyIaC6zOgxHQDiUZ3+T46w1x/iGFrLwB2fOY
         wHV8mEjPqjeQ5OgKH7DVX7sq1+xyZVqqMeDv91DtlOvV81ThhjoSFyKHd251rR9AgAg9
         Ym0g==
X-Gm-Message-State: AOAM531CPV7VCdc7ZaL7dZfjoede4Nlk7w2HvCLxCVyQJeQgFZEFQhcs
        1jiwkYGZxkRSnh+zKHorhO9uwEQ0ldByoQPwrIGgk9EA
X-Google-Smtp-Source: ABdhPJyAmGV2S5pLMTw8SiPu7lrW2OQW/EJL+0E/5cvdrSbBkX2sJL/0Dvu7JbaF1Ce6v6OOZ+D2KcWWt7bbn8jdYuY=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr18889415ybn.440.1621641242252;
 Fri, 21 May 2021 16:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210521170407.180152-1-hj.tedd.an@gmail.com> <60a7f782.1c69fb81.7ea1.c108@mx.google.com>
In-Reply-To: <60a7f782.1c69fb81.7ea1.c108@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 May 2021 16:53:51 -0700
Message-ID: <CABBYNZK5m8JBTCAgPdU3Y+NkHTOYUJ5Dw60MbL9TPxiB0k8R0A@mail.gmail.com>
Subject: Re: [BlueZ] src/main: Fix double free str
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, May 21, 2021 at 1:27 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=486651
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.40 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      40.84 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      7.15 seconds
> Build - Make                  PASS      170.35 seconds
> Make Check                    PASS      8.91 seconds
> Make Distcheck                PASS      205.87 seconds
> Build w/ext ELL - Configure   PASS      7.05 seconds
> Build w/ext ELL - Make        PASS      159.02 seconds
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
