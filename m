Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FD1C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 09:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A2A60BD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 09:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbhIBJdx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245519AbhIBJdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 05:33:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F5FC061575
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 02:32:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p38so2983786lfa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHkQ7q6rxBruAhxTCXApT0WkIN2bESI5ZnLL/a6Jut4=;
        b=t42zzYVxa1prLsBm1ZWiIsrOK/YupxAaMwPIdDgmED9dYIyS3wIBQ9KwBK8/dypOon
         Z8OovU6S2cjj2gW08DbxmfeqnZE4hgKmJ3zstTlEz81KxvgtuqeJUJcJ6b4kMMx5WZuG
         +/hNlqkAntUcw+vPz3m/MTysll6qOif6QuoG8gGFqmeM+qjggeuHZNULh8fLjtt0o283
         8Xl02u/b3h0U4oGi+cMgZ3RtT3poBMW+mvxFQg1fUo31S52L5Aaw6Wlwdxbp++UY0+Jl
         SFNI/MgrJlv5QO1+NQIlbrrHwPjHFQ9vr4duvALTrAy8eT1sW63ohSWJiYVHiGNAXtDV
         2syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHkQ7q6rxBruAhxTCXApT0WkIN2bESI5ZnLL/a6Jut4=;
        b=TW7M2eiIICLQM8TiV50ViWjfzO01PfQ/L06K4ato7gHcFE6bEHyqXXh7yCORrKr4ez
         23VMqOcPl0lQsCqfc7OXuxxOVdXaw8ur4O8JNFfCJ9VF0G0uuPeZhDOeoSE4rt+EhN4D
         F3Gs/K0+idRg1JYFyoHycF0h1C91kJcT3U3wiMs4fS6l8YiIZX4TenGl2cMtF7LNnbav
         TB8keo2ud/zD6ffcVc2p2fLhuCuqPG0boc+jnuaXM2Qh9aTRmXsoN6FeDkGwhct9sTRm
         XIi9vKEgUfUOwHLJZ/sadrS3BUekdOvhFpVTQ72QklaQA1kEImHTp+m2/C9DlOz2QAhm
         tjwA==
X-Gm-Message-State: AOAM531O6bBEa81xVHFrzznT6jUCeecO/Wt+4dfP7AzrCXTBAqZjXmoe
        X5nVJVDbwsaSqUjVVyjiWbffoWfCE6lEsCmxbLSgWuKnYDA=
X-Google-Smtp-Source: ABdhPJy+HCdopoGDOuK7Br33ECni+x6okMfUNhYNVM7oclX9t1RN7cV/jAdJ/OvK8XbFRgmc3tX/AnOnbczn/URaA2c=
X-Received: by 2002:a05:6512:1056:: with SMTP id c22mr481745lfb.586.1630575172378;
 Thu, 02 Sep 2021 02:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com> <20210902120509.Bluez.v2.13.I90a92f48ae29b2a8d8b18f856ea2a43afba52299@changeid>
 <1F544696-4D64-440F-B92E-5A0E05A64EE2@holtmann.org>
In-Reply-To: <1F544696-4D64-440F-B92E-5A0E05A64EE2@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 2 Sep 2021 17:32:41 +0800
Message-ID: <CAJQfnxErwXwpAm0DQQ97SLwb-HAVdEP+fCjEy8-rLdyjmYS6Sg@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 13/13] adapter: Inclusive language for storing LTK
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Got it, then let's simply leave this patch out.

Cheers,
Archie

On Thu, 2 Sept 2021 at 17:29, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > BT core spec 5.3 promotes the usage of inclusive languages.
> > This CL replaces some terms with the more appropriate counterparts,
> > such as "central" and "peripheral"
> > ---
> >
> > (no changes since v1)
> >
> > doc/settings-storage.txt |  4 ++--
> > src/adapter.c            | 10 +++++-----
> > 2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> > index 1d96cd66d9..3c637c3521 100644
> > --- a/doc/settings-storage.txt
> > +++ b/doc/settings-storage.txt
> > @@ -314,9 +314,9 @@ Long term key) related to a remote device.
> >   Rand                        Integer         Randomizer
> >
> >
> > -[SlaveLongTermKey] group contains:
> > +[PeripheralLongTermKey] group contains:
> >
> > -  Same as the [LongTermKey] group, except for slave keys.
> > +  Same as the [LongTermKey] group, except for peripheral keys.
> >
> >
> > [ConnectionParameters] group contains:
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 4ad53a3a24..8528e2b6e0 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -3745,7 +3745,7 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
> >                                                                       NULL);
> >       ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
> >
> > -     central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
> > +     central = g_key_file_get_boolean(key_file, group, "Central", &gerr);
> >       if (gerr)
> >               g_error_free(gerr);
> >       else
> > @@ -3777,7 +3777,7 @@ static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
> >
> >       DBG("%s", peer);
> >
> > -     ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
> > +     ltk = get_ltk(key_file, peer, bdaddr_type, "PeripheralLongTermKey");
> >       if (ltk)
> >               ltk->central = false;
> >
> > @@ -5780,7 +5780,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
> >       g_free(str);
> >
> >       g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
> > -     g_key_file_set_integer(key_file, "LongTermKey", "Master", central);
> > +     g_key_file_set_integer(key_file, "LongTermKey", "Central", central);
> >       g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
> >       g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
>
> this is just not going to work. You are going to break existing installations that upgrade to a new version. The storage format, D-Bus API and libbluetooth API are something that you can not search+replace.
>
> Regards
>
> Marcel
>
