Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82824C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 04:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1343320867
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 04:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOsMedtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgKEEoc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 23:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKEEoc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 23:44:32 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 20:44:31 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id y12so167777wrp.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 20:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZyeSgPPUsuU6xAIcitPfcfg7EjZq+JAUC8raf9PCrZc=;
        b=EOsMedtqux3uPG15CD2fR+j3+xGR0ByFXp9N/TNCKVJ2sgqDpv1LYwXkgcqHBaF0no
         b1qNW1GuF5UEe8aiLnWTNsHt7Kf8FCejWXOa4LqY3xkCGiAe/bgoQnnxQ24EbXG3kq4x
         +Pfrgd3UGHav1YTFFrU3MiiE1llKnnU3/h9QYzi5cd5EKf3KJQEJvkliCVCuLlFtsWXm
         Al1pHevUyCi4q0V8X2w61Q2ituiOdu/l2VbiTnF1krhcEYriMu/EORo2KL+/pjnK0ZJe
         boPpxLzPrH6fzOPPYIWMavsN2tx9GL0SPMV2qIsdGrVizwPRbw7EgPpUyhYmvcHbZS34
         3/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZyeSgPPUsuU6xAIcitPfcfg7EjZq+JAUC8raf9PCrZc=;
        b=QX/AsgzD2yFLptfnee0Aleo21X4657ad8RKsRu0cTKTQg7lkrR/YVF6v04LnXc9kKL
         LWDb1eVaHrpH4OuCngxobzL+KkeanVuYLYcxbyj0diOiSs+zNZTgCtz2qqaiuD/2ADhG
         8dMCAHwpULeDdKq+Lw7yIrnfDKyw6qKX52SlvewO88UAuxNBlF3WC1BsqlUXBIwlkN/N
         dG3GRDnsczY2+Q2gmnUMJbmQ2QVb13kvHFPJK9XRa2GNRWurFhxXp61PNxy30ZATIGDr
         1wAko23QAI+XY5h+brP0/IxxThGj1kFZESTd0Km0Ir1RhiaFw6t3GpoxYkA7DsCnn3Ff
         Sp5g==
X-Gm-Message-State: AOAM53133IzYrsnGgVQ5wlNS80Al7PRLqwgfH7tylR0Iuc6pmkqDLYVm
        VTJJU7OxnuoHTE3ThhGhNNCcbrJziScyFMfSSkY+zw==
X-Google-Smtp-Source: ABdhPJwqcSAPJ8axNb8lpLxZa8N7J4rrvJMyBiNHmZY9g5hvK4x20Wgp2+bc2LQ790P5oFY1Wpv8nA3A5VLPh0Fvg14=
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr509247wrn.262.1604551470475;
 Wed, 04 Nov 2020 20:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
 <CABBYNZKRhGcqtd1eUhE2AbF98RNnDkEfTHcg8p38JSB=ENXy1Q@mail.gmail.com>
In-Reply-To: <CABBYNZKRhGcqtd1eUhE2AbF98RNnDkEfTHcg8p38JSB=ENXy1Q@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 5 Nov 2020 12:44:19 +0800
Message-ID: <CAJQfnxGV_7ps3Lg4-vUcfJwMUf9Mby6kWvobEYFadaEURLXBZw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/3] policy: add checks before connecting
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, 5 Nov 2020 at 05:13, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Tue, Nov 3, 2020 at 9:35 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > When policy_connect() is called, there might be a case where the
> > device is not ready, or even the adapter is down. Add some checks
> > by calling btd_device_connect_services() instead of directly calling
> > btd_service_connect().
>
> But we could perform these checks in btd_service_connect or you also
> intended to use the pending list? Im a little hesitant with such a
> change though because there could be a pending connect already causing
> it to fail instead of just connecting in parallel.

Yes, we can also perform the checks in btd_service_connect or in policy_connect.
I have no intention of using the pending list, and to be frank, I also
don't know whether we should let the connection happen in parallel or
we should form a queue.

This issue correlates with the other issues addressed in the second
and third patch.
However, if we leave this patch and only fix the second and third
issue, this one would not cause a problem by itself because even when
the adapter is down and policy_connect is called, it would just fail
and we would recover cleanly.
This patch is merely just to skip the unnecessary connection attempt.
I will submit another patch which performs the check inside
btd_service_connect, and I'll leave it to you to decide whether this
optional patch is needed.

>
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> >
> >  plugins/policy.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/plugins/policy.c b/plugins/policy.c
> > index ba9e1be020..42b15cb65f 100644
> > --- a/plugins/policy.c
> > +++ b/plugins/policy.c
> > @@ -106,6 +106,7 @@ static void policy_connect(struct policy_data *data,
> >  {
> >         struct btd_profile *profile = btd_service_get_profile(service);
> >         struct reconnect_data *reconnect;
> > +       GSList *l = NULL;
> >
> >         reconnect = reconnect_find(btd_service_get_device(service));
> >         if (reconnect && reconnect->active)
> > @@ -113,7 +114,9 @@ static void policy_connect(struct policy_data *data,
> >
> >         DBG("%s profile %s", device_get_path(data->dev), profile->name);
> >
> > -       btd_service_connect(service);
> > +       l = g_slist_prepend(l, service);
> > +       btd_device_connect_services(data->dev, l);
> > +       g_slist_free(l);
> >  }
> >
> >  static void policy_disconnect(struct policy_data *data,
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
