Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE345C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A2D64F83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 19:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhCLTiA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Mar 2021 14:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhCLTh6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Mar 2021 14:37:58 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B30C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 11:37:58 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id x135so23498569oia.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 11:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M6xArKwU4d50Tu7WVpwSWy6G+zpUtIPrmTuan+APx58=;
        b=UH3SakLBY8eU5TkcridIl81IsB8bSp9SeH7uR+/8CzebintF3QpMpVWH+hl1+yRb9u
         1ij1dgL0cRr4fpmJpDAESTkx1XokV4GOcyGPmD6I/3oWJ6jbtQnsIrnHAZxWrpSzv7EX
         L0NUtd9986IagzTb3yKNopQH6DLNEdp1iwZDsVTeRFkqnWGDlYXtFioCBAgtTRNYWIOX
         sdRzq8eFsUXpvaql8bxpUOgcK4o588+iDSsGoWtPT8uunyZmCZMUXhL15c59505fEq43
         aNPEuWo3xOEP0boXAzd+lvGJ2NjU+8tsw6z4h0uqhxSeUDtddcZoJhvGi29UNSpVNJ8q
         5dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M6xArKwU4d50Tu7WVpwSWy6G+zpUtIPrmTuan+APx58=;
        b=bQB3sZztHinuP+ZWLHPg9vY1dZly1k+eGZ1n3SMnZozA5cMbEDRDT48nVMeP4lPPNC
         JqNBWfrJoX94VsgXmZT1EgtxCSlE5aX0coIcXT9XJwKMgTyB8UrQl9o884XC5jCvPGy6
         oARs5sW6x3Y0BCFMB448vUJRuO9XcL4Nq7/uM/AhQJUW8PzNKNFKS7U80bmam/FhTtDR
         VYP4CvaLhYpwEFo8W0FLnbiueiLyLGyx6dX2o/XlE6DRnTcCF69Ur4HBcUiaJtAI2Uxy
         Kvc5zj11BVYCv38M5+f72K7YAsw/W1YHTFG16lXwon2LPs6sFJO9BDOTmVU4vOE4B6YQ
         4Atw==
X-Gm-Message-State: AOAM532+gc0PswWKyVPqacZJHxp8M2/lHxNXgVjCYW5abHkSZT6QnlIS
        etd6fGtVGjbxn6FJeypqWWVU26CcYk/sFx+LIa0CI3KFrao=
X-Google-Smtp-Source: ABdhPJzxplh5+/2cjr4gotPxLlEEamiMI5oS0Gu9phAG6MPPQvmYFbDHbUYTAPikVi8NiLtpzxx3gaKRUyMmYv3V/b8=
X-Received: by 2002:aca:b645:: with SMTP id g66mr2443411oif.64.1615577877593;
 Fri, 12 Mar 2021 11:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20210312165017.31829-1-frederic.danis@collabora.com>
 <CABBYNZ+fjE8x6Ba4FJvzb+RUoNgN9i8O8Vn4g0fhLJ+8CbYigg@mail.gmail.com> <49e20ff2-795c-12e9-db79-697b12725f12@collabora.com>
In-Reply-To: <49e20ff2-795c-12e9-db79-697b12725f12@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 12 Mar 2021 11:37:46 -0800
Message-ID: <CABBYNZKOW_v+KHz-jjrMzgUsBpk+axze8UL4BUp-xnpgk1mZqw@mail.gmail.com>
Subject: Re: [PATCH Bluez v2] adapter: Fix discovery trigger for 0 second delay
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Mar 12, 2021 at 11:09 AM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Hi Luiz,
>
> On 12/03/2021 19:28, Luiz Augusto von Dentz wrote:
> > Hi Fr=C3=A9d=C3=A9ric,
> >
> > On Fri, Mar 12, 2021 at 8:53 AM Fr=C3=A9d=C3=A9ric Danis
> > <frederic.danis@collabora.com> wrote:
> >> When calling `StartDiscovery` the effective start can take around 10 m=
s or
> >> up to 700 ms.
> >> g_timeout_add_seconds() call doesn't ensure the time for the first cal=
l of
> >> the timer if the delay is less or equal to 1 second.
> > Interesting, I always thought that 0 would be handle just as idle and
> > not round up to the next timeout.
> >
> >> ---
> >> v2: Fix issue founs by CI
> >>
> >>   src/adapter.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index cc0849f99..3078ce1a8 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -1797,6 +1797,13 @@ static void trigger_start_discovery(struct btd_=
adapter *adapter, guint delay)
> >>          if (!btd_adapter_get_powered(adapter))
> >>                  return;
> >>
> >> +       if (!delay) {
> >> +               adapter->discovery_idle_timeout =3D g_idle_add(
> >> +                                               start_discovery_timeou=
t,
> >> +                                               adapter);
> >> +               return;
> >> +       }
> >> +
> >>          adapter->discovery_idle_timeout =3D g_timeout_add_seconds(del=
ay,
> >>                                          start_discovery_timeout, adap=
ter);
> > Maybe we should have a wrapper function for g_timeout_add_seconds
> > since I suspect there might be other instances of
> > g_timeout_add_seconds with 0 delay.
>
> Ok
> Is adding a timeout_add_seconds() function to src/shared/timeout.h the
> right place?

Yep, that should be the right place.

--=20
Luiz Augusto von Dentz
