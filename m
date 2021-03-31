Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3568BC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 20:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F101E610A0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 20:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhCaUOm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhCaUOS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 16:14:18 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DD4C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 13:14:18 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m13so21192635oiw.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGUcrbBUxI3BdvikNVCBFTHpOea7WHdLoiBWRAaWFdo=;
        b=jX1HwvxXiAw228NjZup8uFiQnh0NDb/JtI94hBrea6tIykUMBJbbOEnYd/8i7AWcO3
         Qz+sXRfe/+Laxv9Z5F0zQ8M2N8y8x5kT3Cpcm82zbhXnmwcLQbYITQgw31KEA4z5Hq5j
         nxsrzus2crDI3tGaA8gtSuOtEMk/UAS/Q36Pdmao1KmHRzoQcClbmgHFkE4AIOoamURK
         nFpSkoHpJPRYuJWIxI4/NweQZh8wDEONsYzLB+cSyU+7PngcHQCk1utAOD2YB8Nrqfl4
         NGxCJsSYEHfS4mBO/zmvmlvXbXYqzehVAZ+yzqwZwR0xy1Jsft5CdgsacRA5mnlY28CK
         iGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGUcrbBUxI3BdvikNVCBFTHpOea7WHdLoiBWRAaWFdo=;
        b=VMRc6wx+jl2vXVtJ4s79q/dPKEwVFL+DV5mAuATJKuGAmvhHGby9nQt7U7fdeD2Tg0
         7DPM1JitV6KoMMI5dssPFcVz3p1fbvjdmSgKnWsQy5s508PRggqfoDd1bwelUqPElcXN
         vsj6l9TLEbBAJ8/mkIXn/gB1Plc7fisznDH6IBiLs9g+E6mfMf3gHGNq9Mz4FFZ7cSfL
         MFnS0enodWy8wP6jXhpLa23Rws4D9HhJlHRq7pR2vdI/dZgxyUcplCKFw9bvc5L8hzj1
         WW94U9iWmMtRqM5dxvoQEAV/izqiUHxZVFNFk6+insdpcZoJqrp27P1yVE387FiBp5jC
         JC/w==
X-Gm-Message-State: AOAM531MoaIoTw/Pi7/Qs4o/DqS3p74kEYQBdLfw4ouGhj93ZpgmMOgX
        oXmIzApjoMw45y2mQlk4OKmUddd9k1PDYuG7v2Q=
X-Google-Smtp-Source: ABdhPJygctfd+hucmn79p4UKQLWfADEgYH/UqLBP0le4x9Uyfq1syCQIQ0f1cDdNdJK3xCvXPmAwKM7o8xWEkOpEJ0Y=
X-Received: by 2002:aca:b645:: with SMTP id g66mr3311623oif.64.1617221657230;
 Wed, 31 Mar 2021 13:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <80f40fbd-c903-6f10-1d9f-e75f0f214db5@gmail.com>
 <CABBYNZJ2Hw1+xSvhqwBQa90qkpcmYh+qO3U+Rs1JBaSOz+7AMA@mail.gmail.com> <394e71c9-3abe-7a9d-e47d-0793ba9736f3@gmail.com>
In-Reply-To: <394e71c9-3abe-7a9d-e47d-0793ba9736f3@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 31 Mar 2021 13:14:01 -0700
Message-ID: <CABBYNZ+XKuFfpo8iyVq_3gmY8aoNJ_rb2t5+S8StZhmvPPtdOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/transport: Emit Volume changed if endpoint is source
To:     Feryllt Pryderi <feryllt@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Feryllt,

On Wed, Mar 31, 2021 at 1:01 PM Feryllt Pryderi <feryllt@gmail.com> wrote:
>
> Hi Luiz,
>
> sure I can update the patch, but is the if at all needed? Can we have transports without any of source_watch and sink_watch?

Right, I was about to do the change myself but you have a good point,
if we will be emitting for both then we should just signal regardless.
That said when acting as a source (notify=false) we would be sense the
command AVRCP_SET_ABSOLUTE_VOLUME which the remote shall generate an
event AVRCP_EVENT_VOLUME_CHANGED which will then generate the signal
at media_transport_update_volume, so something is off here, are you
really not getting any signal?

> On 3/31/21 8:33 PM, Luiz Augusto von Dentz wrote:
> > Hi Feryllt,
> >
> > On Wed, Mar 31, 2021 at 4:40 AM Feryllt Pryderi <feryllt@gmail.com> wrote:
> >> Change set_volume to send a Volume PropertyChanged signal also if
> >> transport->sink_watch is set (and not only if source_watch is set).
> >>
> >> This fixes volume changes signals not being sent for devices like speakers and
> >> headphone adapters with volume control (like Bose Soundlink Revolve or Fiio BTR5).
> >> ---
> >>  profiles/audio/transport.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> >> index 8248014ae..26aa237a3 100644
> >> --- a/profiles/audio/transport.c
> >> +++ b/profiles/audio/transport.c
> >> @@ -662,6 +662,7 @@ static void set_volume(const GDBusPropertyTable *property,
> >>      a2dp->volume = volume;
> >>
> >>      notify = transport->source_watch ? true : false;
> >> +    notify = notify || (transport->sink_watch ? true : false);
> > Id replace the following like with:
> >
> >   if (transport->source_watch || transport->sink_watch)
> >
> >>      if (notify)
> >>          g_dbus_emit_property_changed(btd_get_dbus_connection(),
> >>                          transport->path,
> >> --
> >> 2.31.0
> >>
> >



-- 
Luiz Augusto von Dentz
