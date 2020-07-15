Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A43C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 22:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2B720658
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 22:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHQfBgno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOWt0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOWtZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 18:49:25 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE89C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 15:49:25 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j11so3525509oiw.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4udghYGtUYeaRoul7B0YgVKGSlph/H2QPmKSktA8esE=;
        b=ZHQfBgnoIyqczd+dSUqiH9XRQINki3vuivj2cPIrgNBXg49yYfDtSx8Bsf8G5X625/
         mOptg48RQARzcQ+rkH/uxDWqdwae+2uxF2ifZ9Q3/iyD9Fmb+iR5XcBHgQATA/bPQjn1
         /NTLL7bPw8se2pZ7UmNBotzg2w1+cViAYuvMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4udghYGtUYeaRoul7B0YgVKGSlph/H2QPmKSktA8esE=;
        b=a+qlPV9ZasHf8smSdZyVFndm8GgkkzIhg6g2vrMQoRhCanfj+hj8eiQ4pd7fxqX7Om
         /6PjcWWEXyEJhwfk1bSyp9lRkY8xMAzMlH2tIEnLlYu/g+1+o8PQ5sBQweGnKBjVFCJ9
         neE/T1rAlXrcV+8AWtYJQVjZceUvJ4SQwAIfFBtov+bP3hZ+FzL5Boc51A7DWdbgj8V8
         p0DmCX1ApbBZERaEMv8PybO651dAmBIYThHRDioK/hlor6zQ6KmSHpqsnRYdmYtp+OKt
         dzGAANNUJHPAK7toTIRJ/VLLHIb8bqPc/cFWb3fNLp8aed8SDnrIH77vqWN75wG3FAGQ
         CHfQ==
X-Gm-Message-State: AOAM532aX09nGRaOINduAWISwg2S3jjJ5uGXYsFAp2dbF3Zoam4Ntzro
        Y4ZdH5bUNW8GC3tPL+e6w4JavXbwZ2uftsZ33tKrDQ==
X-Google-Smtp-Source: ABdhPJwcFR7XFKyRSgaTNd9FYUCmKeBGmYkbi9JVcxnn/3VbXuvYRGCZCXSEyQb/dYgjQertAM/zwyP7NQ216Wc1SYA=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr1727356oib.142.1594853364963;
 Wed, 15 Jul 2020 15:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200715222812.238172-1-sonnysasaka@chromium.org> <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
In-Reply-To: <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 15 Jul 2020 15:49:13 -0700
Message-ID: <CAOxioNkERG9b+Rn2StC6_HgBG41=6wa5rPR-J3Snj6MFds77TA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profile: Add exception from being claimed internally
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, Jul 15, 2020 at 3:40 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Wed, Jul 15, 2020 at 3:32 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > This adds a flag to give exception to profiles that are considered safe
> > to be both handled internally and externally via GATT API. Currently
> > this includes the battery profile.
> >
> > ---
> >  profiles/battery/battery.c | 1 +
> >  src/device.c               | 2 +-
> >  src/profile.h              | 5 +++++
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> > index 4da4355a1..20aa47727 100644
> > --- a/profiles/battery/battery.c
> > +++ b/profiles/battery/battery.c
> > @@ -354,6 +354,7 @@ static struct btd_profile batt_profile = {
> >         .device_remove  = batt_remove,
> >         .accept         = batt_accept,
> >         .disconnect     = batt_disconnect,
> > +       .claim_service_exception = true,
> >  };
> >
> >  static int batt_init(void)
> > diff --git a/src/device.c b/src/device.c
> > index 0deee2707..cfa52461f 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -3818,7 +3818,7 @@ done:
> >         profile = btd_service_get_profile(service);
> >
> >         /* Claim attributes of internal profiles */
> > -       if (!profile->external) {
> > +       if (!profile->external && !profile->claim_service_exception) {
>
> The external field was added exactly to allow it to be used externally.
Oh, I was misled by the field name, I thought it's to mark profiles
which are not handled internally. I have sent another patch also
clarifying the field with a comment.
>
> >                 /* Mark the service as claimed by the existing profile. */
> >                 gatt_db_service_set_claimed(attr, true);
> >         }
> > diff --git a/src/profile.h b/src/profile.h
> > index 4448a2a6d..25e83381b 100644
> > --- a/src/profile.h
> > +++ b/src/profile.h
> > @@ -36,6 +36,11 @@ struct btd_profile {
> >
> >         bool auto_connect;
> >         bool external;
> > +       /* Some profiles are considered safe to be handled internally and also
> > +        * be exposed in the GATT API. This flag give such profiles exception
> > +        * from being claimed internally.
> > +        */
> > +       bool claim_service_exception;
> >
> >         int (*device_probe) (struct btd_service *service);
> >         void (*device_remove) (struct btd_service *service);
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
