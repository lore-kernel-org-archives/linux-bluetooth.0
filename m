Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D48BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EA6206C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULpZAa7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgFHPyx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHPyx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 11:54:53 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD6BC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2020 08:54:53 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s21so15724623oic.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2020 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mE6HRfHOJhso90OF9rMC9M3j5EvjPSj3hqjz2GShy/k=;
        b=ULpZAa7lFNQrd0GV65VaDpTK0AtV8mlZZk28L/n2LdFQGxJx5+ORFoHBp+C2rnJK/U
         3btMilSD1UaxZZihjDrSop2lWBTK7YgLTEhvVbylg7DjMuH5uDpRgezEHGAjpRZZzwzB
         xWAZaokjbixNasmnm2yYLER6/dBG4D5O1vke7dWULwTLIodWlFsmaEjpoadxo6+YHLr4
         TY1AHQXd+LdbCaJK7C+NDLI/csnZGiHVIypoim6WAj+dbjSkwdYPcscvp1McUo4fVoE3
         O3Y+HWeat0XFMK8abbEELk+tiQzwgcMR35if5XxBPJlW00WUKTkHHfOTzT+/BHPTnNs/
         oT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mE6HRfHOJhso90OF9rMC9M3j5EvjPSj3hqjz2GShy/k=;
        b=Y5a8Bq6G+d2fSJ4IBgQeht+jvrG7UySsewNW6x7JK32LYAFLV29RSuBX7YL6ExCOsP
         gnT/FyZ2QZh8vt/82Dd/rZH/KMXLAJQJfol1knUeAKv5Fj4OBl6Mz3fPlpSsMY/glDSs
         /slfXCojJLgEqL6/3Fq7Ny7WYzTszYRmB6Zof2oQ4HgfxQiJq7ia7rdnVvHkf+1+Wlob
         rxxSlQJCauSY3Vhp6vzPkjGKhwswJpsKr720Yw7xZxjDgnN7nit36ZcGuBVocJnaIxGD
         kS/bqb7NC0esxICqMjlHNtVQPeZlCy3shrb2y25UQnAdDVm4/pkkCrTkXACqScEluRHs
         65pA==
X-Gm-Message-State: AOAM5335RPwUVRTBqXnTZxPrQWw2guAnF2tiWPC6JBzBndH2O8vlsstf
        fDA682v9qvlpJBp6+l8CR8cQqirdpwa28Z5hU/A=
X-Google-Smtp-Source: ABdhPJzZt/RsmmQrmujWoTCEqWIiagjiUwUCyviklABDvrMrPL6rJBiYiXiH1DZoGse+TlJ9s5r85Ad1mHFzdJH47J4=
X-Received: by 2002:aca:fd16:: with SMTP id b22mr30438oii.108.1591631692352;
 Mon, 08 Jun 2020 08:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZJ=RirU3of1pCUjgBwKTP0Rmv5g0uGP-CKJnYLvdDUwOQ@mail.gmail.com>
 <20200608134036.3242711-1-marijns95@gmail.com>
In-Reply-To: <20200608134036.3242711-1-marijns95@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Jun 2020 08:54:40 -0700
Message-ID: <CABBYNZJ-BBGRz8BATC45Un+6rxCLj2zDVe=m-ReepP974RwDww@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btio: Fix not translation mode to L2CAP mode
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Mon, Jun 8, 2020 at 6:40 AM Marijn Suijten <marijns95@gmail.com> wrote:
>
> Hi Luiz,
>
> > Hi,
> >
> > On Fri, Jun 5, 2020 at 10:59 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > When using L2CAP_OPTIONS legacy modes need to be used since they are
> > > not compatible with BT_MODE.
> > > ---
> > >  btio/btio.c | 24 ++++++++++++++++++++++--
> > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/btio/btio.c b/btio/btio.c
> > > index 13c731062..844d6007f 100644
> > > --- a/btio/btio.c
> > > +++ b/btio/btio.c
> > > @@ -597,6 +597,20 @@ static gboolean get_key_size(int sock, int *size, GError **err)
> > >         return FALSE;
> > >  }
> > >
> > > +static uint8_t mode_l2mode(uint8_t mode)
> > > +{
> > > +       switch (mode) {
> > > +       case BT_IO_MODE_BASIC:
> > > +               return L2CAP_MODE_BASIC;
> > > +       case BT_IO_MODE_ERTM:
> > > +               return L2CAP_MODE_ERTM;
> > > +       case BT_IO_MODE_STREAMING:
> > > +               return L2CAP_MODE_STREAMING;
> > > +       default:
> > > +               return UINT8_MAX;
> > > +       }
> > > +}
> > > +
> > >  static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
> > >                                                 uint8_t mode, GError **err)
> > >  {
> > > @@ -614,8 +628,14 @@ static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
> > >                 l2o.imtu = imtu;
> > >         if (omtu)
> > >                 l2o.omtu = omtu;
> > > -       if (mode)
> > > -               l2o.mode = mode;
> > > +
> > > +       if (mode) {
> > > +               l2o.mode = mode_l2mode(mode);
> > > +               if (l2o.mode == UINT8_MAX) {
> > > +                       ERROR_FAILED(err, "Unsupported mode", errno);
> > > +                       return FALSE;
> > > +               }
> > > +       }
> > >
> > >         if (setsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o)) < 0) {
> > >                 ERROR_FAILED(err, "setsockopt(L2CAP_OPTIONS)", errno);
> > > --
> > > 2.25.3
> >
> > Pushed.
> >
> > --
> > Luiz Augusto von Dentz
>
> This patch seems to break avctp browsing. The creation of browsing_io in
> avctp_register already uses L2CAP_MODE_ERTM which is not in the
> switch-case hence results in "Unsupported mode". What is the desired way
> to fix this? Should all those calls use BT_IO_MODE_* instead? Not to
> mention the uses of these functions should be checked for their enum
> usage as well.

I will fix it, bt_io API shall only operate with the its mode not
L2CAP mode so it is a bug to pass them.

-- 
Luiz Augusto von Dentz
