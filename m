Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB32C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 20:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B9860FC2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 20:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhIQUzI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Sep 2021 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhIQUzI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Sep 2021 16:55:08 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD080C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 13:53:45 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id n17so10009455vsr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leqqlflc5Zj8QAfEwMsGbfmJBdTHkTrafJRNrhkm1PU=;
        b=j5QDMAxibLNi52O8EyxVZNH3msXP611HED0cRsRUGeqIlizw3VqRiFC9k8YMShwvgk
         tjUHHvcjEtB18DQyVyfZdzGPfdpEo8uUMtpEaPhDe09y9sZLvg7smzRd8beOH1mvwxPS
         Ajn82i4uO6nonSrLCdpoW1PN+U0k82ElTxxiNue3NJbtkyTzKUvVoKICRVHPO5z2QiYt
         6jD6Bfvag+je2Y3hXkOSHPVBr2GrD2Vt0w9xnIcEEER3XlSElQrLc5gnkHGDgPDCkr2W
         GMwq2MduunzNYMdqqM1RmeM5Gh1tT6Qq7+14c6VAWQLjPHQmSV9pZibV8YNT5jpdKcFm
         lEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leqqlflc5Zj8QAfEwMsGbfmJBdTHkTrafJRNrhkm1PU=;
        b=uPeZDA+/07uFEyDDDDp2B5k2C9YkBg8Imi71/liy/VnR0FpPlgycxVH4e8J/uezf+o
         gfTl+/NSPwcLjna+hVpqGV/F/x/j52vQEjsP7RDLvFU6Pejv/vPAMo87IdQEmM/yWKc4
         FbLPLl93mz2CVewYoPYVit90wxe4JMsMQGbkGuNVKqOhQleZsUNyX9WjwmGi+v39jGXI
         6CTa9FdKscmZHQ0exVuKg+3lCP5v8E7j5gpJyMziubiC3BDabz2rUw/wO2YxcBdxk4xV
         DV4Gebb4YI1FH4AkvVZzsunUYXb0JC6c1BU5ek7/xZVHK9XiIvjdEKu3WAVWl8Mm3jEJ
         lgrQ==
X-Gm-Message-State: AOAM532+e2A/XdaTiuQHPrKHXZxxa9t3BbLoYrUqf5DfqEMKuzJzvDdV
        qnRueglpTzJQok44JpcXgT6XRARrayKzL8fFH+Y=
X-Google-Smtp-Source: ABdhPJy5x/E1gDULMEgWP6DMY3/b9y1skzxPBHmdmfnliypBa/jOHuVvlTS1HyOgDtEPZUPqPYu2BUDOY1CHqL6OBbM=
X-Received: by 2002:a05:6102:21d0:: with SMTP id r16mr74618vsg.39.1631912024659;
 Fri, 17 Sep 2021 13:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210912204839.3018089-1-fontaine.fabrice@gmail.com>
In-Reply-To: <20210912204839.3018089-1-fontaine.fabrice@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Sep 2021 13:53:33 -0700
Message-ID: <CABBYNZ+Lj1r4NTPuL1RorkYn8ZuTsKAL_oOTKuf40vyOtbW7zQ@mail.gmail.com>
Subject: Re: [PATCH] profiles/audio/media.c: fix build with glibc >= 2.34
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Yann E . MORIN" <yann.morin.1998@free.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fabrice,

On Sun, Sep 12, 2021 at 1:50 PM Fabrice Fontaine
<fontaine.fabrice@gmail.com> wrote:
>
> pause() is defined in glibc since the very early times; it appears in
> upstream commit 28f540f45bba (initial import) in 1995 [0].
>
> Bluez has been defining a function named pause() for ages too, since
> commit caab74c97542 (media: Implement new callbacks for pass-through
> operations) in 2013 [1]
>
> With the recent bump to glibc 2.34.xxx, the build now fails because the
> two pause() clash:
>
> profiles/audio/media.c:1284:13: error: conflicting types for 'pause'
>  1284 | static bool pause(void *user_data)
>       |             ^~~~~
> In file included from /tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/bits/sigstksz.h:24,
>                  from /tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/signal.h:328,
>                  from /tmp/instance-0/output-1/per-package/bluez5_utils/host/bin/../s390x-buildroot-linux-gnu/sysroot/usr/include/glib-2.0/glib/gbacktrace.h:36,
>                  from /tmp/instance-0/output-1/per-package/bluez5_utils/host/bin/../s390x-buildroot-linux-gnu/sysroot/usr/include/glib-2.0/glib.h:34,
>                  from profiles/audio/media.c:21:
> /tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/unistd.h:489:12: note: previous declaration of 'pause' was here
>   489 | extern int pause (void);
>       |            ^~~~~
>
> The culprit is indeed glibc 2.34, as can be seen in this result matrix:
>
>          \   bluez5_utils
>     glibc \  5.60  |  5.61
>     -------\-------+--------
>     2.33   |  OK   |   OK
>     -------+-------+--------
>     2.34   |  KO   |   KO
>
> The underlying reason that pause() is now causing issues with glibc 2.34
> is not obvious: glibc is a big beast, and finding such issues is not
> easy. However, we can see that the pause() provided by NPTL has been
> dropped in favour of the generic one, so maybe this is causing symbol
> visibility or weakness to change or something...
>
> We fix that by renaming the local pause() in bluez5_utils with a
> namespace-prefix, like some other functions there already have.
>
> Fixes:
>   - http://autobuild.buildroot.org/results/c4fbface34be8815838fd7201621d7a8fddd32c5
>   - http://autobuild.buildroot.org/results/62b88740f19fbe4a1ad7959dc141d539eb88c1f8
>
> [0] https://sourceware.org/git/?p=glibc.git;a=commit;h=28f540f45bbacd939bfd07f213bcad2bf730b1bf
> [1] https://github.com/bluez/bluez/commit/caab74c97542a56b591f0b16b44ab6ba4b40f0f5
>
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> Signed-off-by: Yann E. MORIN <yann.morin.1998@free.fr>
> ---
>  profiles/audio/media.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 267722542..f93b74e67 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1281,7 +1281,7 @@ static bool stop(void *user_data)
>         return media_player_send(mp, "Stop");
>  }
>
> -static bool pause(void *user_data)
> +static bool media_player_pause(void *user_data)
>  {
>         struct media_player *mp = user_data;
>
> @@ -1331,7 +1331,7 @@ static struct avrcp_player_cb player_cb = {
>         .set_volume = set_volume,
>         .play = play,
>         .stop = stop,
> -       .pause = pause,
> +       .pause = media_player_pause,
>         .next = next,
>         .previous = previous,
>  };
> --
> 2.33.0

Applied, thanks.

-- 
Luiz Augusto von Dentz
