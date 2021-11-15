Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00980C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 00:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE45561407
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 00:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349888AbhKPAZV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344917AbhKOUIR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 15:08:17 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F79C06120E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 11:45:01 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id az37so37286215uab.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 11:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VP7K0FOCCEGRDmmlmRYrm9gBTsQN9Gd9wxcVinZL3Q=;
        b=A/ikYXa/lKmhKpAiffSruj+0LBEr88VEgMtbUqoj/3GaPwVvxFd+vZfab5G41Oh5u3
         xNd5SGtcr1jE7LQcq7DK1ITmn1mXjCG5H8hoB6yef5Qd+o+HQ2oKJsIRDtw+Y2zLRJoN
         VqyPFn7j//Qve1aUOnx4rjHtxXROaMdhqfc3Fb8ipKTkS1p2AGzPsn4qV0Zixq1xuoAw
         GjtJaxlsh5C1qU9AZkNBS/gSn8HWmet+ekgrbRyO6my0CDO5L1J5gQ7tY20rSgjTt9Eu
         AECcFyZg4xlJMFHesOa/BmQJN/y06qJ/Qdt5ZnvSqBNSJJdXQOhxo3WzMHDeWRLJBcbI
         YOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VP7K0FOCCEGRDmmlmRYrm9gBTsQN9Gd9wxcVinZL3Q=;
        b=UujJ6vUgErkFUfhvcqxSmayk8domERGNlqfM57Ys7MPqQB1h5cFID0Ma4gZYd1WIaH
         t1A73sAemk1n2ViB3gpVI1ixX4XhC5lZsXa4NEFYopyGJnDGaTx2nxE2DND5E9MqtbLp
         pXbhv4Zj0PdzyV7p9qZTXypKVk2sNYrPTq3jzayyqLvqBnIfR5pe2tJpNczPeoqU+6aI
         yx5/5xSefUU8B3aGU8qFHQRLhD560e3azji+TP//piRFkLb+qv3OEOrDza/jvLEW58Hh
         RIto4n4OynDoxi8yG4zs7PWDJHQxAyhzXEP9hhyGgX5allHpJnNHeqRNfdwlJb9vkuuJ
         ekrA==
X-Gm-Message-State: AOAM532Mf5y6GRwVR3G4JcLvr2FM8G3ekh86+J+vxngpaKoi4t3lGFxI
        m6SNMVyz/APsLggkWQ6saT24g87yKuCVhjAL2dI=
X-Google-Smtp-Source: ABdhPJxk0jLiKev8DcBlIwm/XC6oIJHZbssnSW5AWXO8gjfraH/+zetR3fqkEeDtGnks64h3QHht0HJkzg+gtqmXvWI=
X-Received: by 2002:ab0:4465:: with SMTP id m92mr1963090uam.47.1637005500300;
 Mon, 15 Nov 2021 11:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20211115094108.24331-1-kiran.k@intel.com> <CABBYNZ+rFbfe1joiLmJBGB_twX4_kNu3Nsr=TSs1SyfMvAes8Q@mail.gmail.com>
In-Reply-To: <CABBYNZ+rFbfe1joiLmJBGB_twX4_kNu3Nsr=TSs1SyfMvAes8Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Nov 2021 11:44:49 -0800
Message-ID: <CABBYNZJRm8Ej7FfW7bnA8ZdZFmHbsOnVfXavM0hFdSFd2ib1Gg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] avdtp: Add a flag in struct avdtp to control a2dp offload
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Mon, Nov 15, 2021 at 11:42 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Kiran,
>
> On Mon, Nov 15, 2021 at 1:36 AM Kiran K <kiran.k@intel.com> wrote:
> >
> > Define a flag in struct avdtp and set it based on
> > the definition of env variable USE_OFFLOAD
> > ---
> >  profiles/audio/avdtp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index d3dfbf96dda3..b6feac0ba4d5 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -409,6 +409,9 @@ struct avdtp {
> >
> >         /* Attempt stream setup instead of disconnecting */
> >         gboolean stream_setup;
> > +
> > +       /* use offload for transport */
> > +       gboolean use_offload;
> >  };
> >
> >  static GSList *state_callbacks = NULL;
> > @@ -2425,6 +2428,7 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
> >                                                         struct queue *lseps)
> >  {
> >         struct avdtp *session;
> > +       char *use_offload;
> >
> >         session = g_new0(struct avdtp, 1);
> >
> > @@ -2436,6 +2440,10 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
> >
> >         session->version = get_version(session);
> >
> > +       use_offload = getenv("USE_OFFLOAD");
> > +       if (use_offload && !strncmp(use_offload, "1", 1))
> > +               session->use_offload = TRUE;
> > +
>
> We already have a configuration for experimental flags:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n118

Correction, we may need to introduce yet another experimental UUID
given the UUID above is just about codec offload not MSFT A2DP offload
which may require a completely different set of commands.

> So you just have to check if experimental is enabled, or the offload
> UUID, in adapter.c, also perhaps we should have something like
> btd_adapter_experimental_is_enabled(adapter, uuid) so it would take
> care of doing all the checking if that had been enabled in the kernel
> or not.
>
> >         if (!chan)
> >                 return session;
> >
> > --
> > 2.17.1
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
