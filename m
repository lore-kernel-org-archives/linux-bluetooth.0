Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F1C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814532073A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 14:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUlcbWln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgEFOBv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728058AbgEFOBu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 10:01:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFD1C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 07:01:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so2495453ljd.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F86Ze5srcTv+7cK58NMIv+FmtiQTJPxcJBVBxiRh/VA=;
        b=MUlcbWlnVD3TkRPMYuRuMhyoP2PcfCuxV48hSxOSDNd1Ut+IPq11JQ8iAtoy6sL/98
         iEcFtsdCKTxaJ2O4e7zS2pX9xrSWG2xcnGa3PuphCrzotrOgabndSalW/4BNQUmcAHoT
         7CTw/HAhtV/+kwBkuXvwf4/sWTTEePOY3TEOaO0strTa1U4MsFPOtCn5qRDINWOWSJI/
         SRdaAea8+IunTNQ9SwVs7TWN6DCoTtqNc52o4aJ5wSaIBPomXJcGut77AoDlUV8BbUAR
         x2OZib+dRGuI6Wq+RN3u6kiMlEuKuGb3ASEshXVVDM+4qeKkhCRI30UjP4zVKW2xksMs
         tvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F86Ze5srcTv+7cK58NMIv+FmtiQTJPxcJBVBxiRh/VA=;
        b=U7e+zPpOIZjUd20MHMtUd0VJOglq2COwE3IolA3gkysu99XFp4Zfjj9tYw4msMaF3m
         QrWutGMMVe2EGeQhMBSGlAvNYbKOrGQzDV6NgCTwy4l69OV50on4g2oikiMZ+X9kXBsg
         nNcXwmUyWA5en15U1wjetkpjJMIF3W/aKFDw9RTa3usWVgO5sOUv+yNM7j9Z7O1fTQsE
         mSRO5F9v/iTZqpyYAUMFNjk06dHLBzYnO+tTGiZIlApQF9DdYcFZpgxATbeD7yJ/wSko
         JOOEOjGkGQ9MEQ5y4KN+RDruACMeLMYjifwrqDIYOeQuAYeEkcZyhZHc0agqAsus+zRl
         AvuQ==
X-Gm-Message-State: AGi0PuZyqHsAUCdhONXm/5HhvkApY1VB/8vrtZWigONMCrS3aTLrPsls
        Y/WnY11Kpr6kqfM5qH/3UzvxNtFBMamNADy6BFqza+Ol
X-Google-Smtp-Source: APiQypIB/Bvj4JgDZYV1tU7E/jCpv7WJzAtHEIi2yaVjd/JeV99KerdjnQp4xK4hcHP4sCExWzVAOQ88RKKRL5AwkBM=
X-Received: by 2002:a2e:9c9a:: with SMTP id x26mr5196346lji.44.1588773708652;
 Wed, 06 May 2020 07:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200501215352.23858-1-sonnysasaka@chromium.org> <4A9E7F0B-4AB8-4330-BB2B-1A0EAA4EFDE8@holtmann.org>
In-Reply-To: <4A9E7F0B-4AB8-4330-BB2B-1A0EAA4EFDE8@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 6 May 2020 10:01:36 -0400
Message-ID: <CALWDO_WGrReJ2rRyrh6J0WpTOjDoP-cHdhzQwe5UJx3GqjUimg@mail.gmail.com>
Subject: Re: [PATCH] build: Add option to disable battery profile
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, May 6, 2020 at 7:24 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > Some clients may want to handle battery profile through the generic GAT=
T
> > interface rather than BlueZ's internal Battery interface.
> > ---
> > Makefile.plugins | 2 ++
> > configure.ac     | 4 ++++
> > 2 files changed, 6 insertions(+)
> >
> > diff --git a/Makefile.plugins b/Makefile.plugins
> > index 98eee9ec8..b9733d31c 100644
> > --- a/Makefile.plugins
> > +++ b/Makefile.plugins
> > @@ -101,8 +101,10 @@ builtin_cppflags +=3D $(ALSA_CFLAGS)
> > builtin_ldadd +=3D $(ALSA_LIBS)
> > endif
> >
> > +if BATTERY
> > builtin_modules +=3D battery
> > builtin_sources +=3D profiles/battery/battery.c
> > +endif
> >
> > if SIXAXIS
> > plugin_LTLIBRARIES +=3D plugins/sixaxis.la
> > diff --git a/configure.ac b/configure.ac
> > index 1433ace4a..d4fa862b5 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -181,6 +181,10 @@ AC_ARG_ENABLE(hog, AC_HELP_STRING([--disable-hog],
> >               [disable HoG profile]), [enable_hog=3D${enableval}])
> > AM_CONDITIONAL(HOG, test "${enable_hog}" !=3D "no")
> >
> > +AC_ARG_ENABLE(battery, AC_HELP_STRING([--disable-battery],
> > +             [disable battery profile]), [enable_battery=3D${enableval=
}])
> > +AM_CONDITIONAL(BATTERY, test "${enable_battery}" !=3D "no")
> > +
> > AC_ARG_ENABLE(health, AC_HELP_STRING([--enable-health],
> >               [enable health profiles]), [enable_health=3D${enableval}]=
)
> > AM_CONDITIONAL(HEALTH, test "${enable_health}" =3D "yes")
>
> I have a little bit concern splitting this since battery service and HoG =
are kinda connected. Wouldn=E2=80=99t it be better we have a cleaner interf=
ace. Maybe we should actually integrate cleanly with /dev/upower or similar=
.
I agree, we are re-evaluating this.

>
> Regards
>
> Marcel
>
