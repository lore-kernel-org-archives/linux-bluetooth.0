Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D224C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 20:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E66D2078B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 20:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH3uQQIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGJUfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJUfY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 16:35:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB37C08C5DC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 13:35:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 12so5852580oir.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rTNzcMkZJncAMvaHB7Lfn854pyoDmxRixBWBSIhfgI=;
        b=nH3uQQIgRl8BJOB1JmvfzBYe2itQSvKYw9MxwKIkyLHMU6htIhdTLAp0Tc1Vtv8swB
         QL20Od7WB1ceqIA3K2LXOCtCe6xA7CA99IjJ11+sGKTJ1Ycix1KadoI6/ZWhR1Rm4giJ
         ovn9KitsVJ/vRpI/iwtw8qXbsmiMKkhl+zBsBgnicARuv//mpeND5q6xSqdNEU4paQDC
         5lfjP7NY1a7TX43r8sfgvmnd9VuBDsvDfWU7R3hVHmZhPTSGvd96jXJoOGzuu4lGeXG/
         1bz3OkqeZjMmhq9dbwFLDXbabQx5WiVd5alQdmXGt1X/IaWg5e5wq2Vo4ugONaMGCLyl
         1zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rTNzcMkZJncAMvaHB7Lfn854pyoDmxRixBWBSIhfgI=;
        b=czL+cKNX+Vyfkbkg2kyog60lcOCBYaThwVsf0EmfhKlR3VtaNvm3i+lvRTBFeRgCUR
         rE05apc1/Nxdot3kzRl0KBk8b0E5TAm9xcBPGI168Ri3YkdJT8AZK5+icIYVh8kjdG00
         jIjM6KZRyrbf3N+VUVvrDEti99gZ2kLNmw9W1Cf1I38U+lCWUhG2ZCgLV+3N8hqiZM2W
         1oOEu8I05G774fFQ/VU0zSZLwwEpo7RCprqKkpv19qncaRgeh9gIySGl4URfm0FLJAnz
         SwF/jgxK0qafZu35590OUoM+p3ZPDPwixNrxppKgfGpYU48SEgh/e9uXaI/mz2DafXUM
         4mWg==
X-Gm-Message-State: AOAM531ET6yevy/mO4JeZZ7eEmT6s2ZHDMoe6gNnD1ezF7c7ynmA+wMh
        HcMYT6xgRPYpDxiwAeOmlE8Q353rTSVnCfxKZnDHTqDX
X-Google-Smtp-Source: ABdhPJzChgFtQ49ZrVHUfbZvfrxnk3Mp40ik/ET2zyu7S37Fj1eB8URv06dQvcC2jhzJTr3JDv/gCICSlWJFIt1OOVU=
X-Received: by 2002:aca:4a04:: with SMTP id x4mr5294868oia.152.1594413323851;
 Fri, 10 Jul 2020 13:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200709090631.Bluez.v1.1.I6aa22c6e425e5b19c321c0768f50ca3fc2c090da@changeid>
In-Reply-To: <20200709090631.Bluez.v1.1.I6aa22c6e425e5b19c321c0768f50ca3fc2c090da@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Jul 2020 13:35:12 -0700
Message-ID: <CABBYNZ+43QgENg6ZrF9ZVxnPSkJaE3OUeZH5aeN_zrP9N5OwNQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] audio/media - Fix volume sync between media and transport
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 9:10 AM Yu Liu <yudiliu@google.com> wrote:
>
> From: Hsin-Yu Chao <hychao@chromium.org>
>
> A volume value is cached on the global media player object. And a
> check was used to NOT update volume to each transport if this
> value doesn't change. That is causing problem at disconnect then
> reconnect when the new constructed transport never receive update
> about the last used volume value.

I think this might be related to the other bug we have where the
transport is created after the fetch of the volume so the volume we
have stored in mp->volume is never updated in the transport, see my
comments on the other patch.

> Reviewed-by: sonnysasaka@chromium.org
> Reviewed-by: hychao@chromium.org
>
> ---
>
> Changes in v1:
> - Initial change
>
>  profiles/audio/media.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 993ecb3b3..92e363de9 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1204,9 +1204,6 @@ static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
>         struct media_player *mp = user_data;
>         GSList *l;
>
> -       if (mp->volume == volume)
> -               return;
> -
>         mp->volume = volume;
>
>         for (l = mp->adapter->endpoints; l; l = l->next) {
> --
> 2.27.0.383.g050319c2ae-goog
>


-- 
Luiz Augusto von Dentz
