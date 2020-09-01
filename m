Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB9C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 05:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F0A2083B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 05:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="up/SpoL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgIAFUQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFUP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 01:20:15 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E1FC061290
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 22:20:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e23so121092otk.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 22:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KRFwGBLakySRCLBsud3HZmRY9ihXCzODxn9dGXiuihA=;
        b=up/SpoL5psQ1eMDz4BwrF7HNBqUJKRmuT6ZgPPKNsVIJVha+QfIpE3DTNIuc+LWcIe
         XUXeLrc/afL2CdJP5SRRSM0pwdI20Uld8ZbVuy7wHlPg2aoPOIhn6krvXAcv2PczUJPQ
         qRAx1uQ5xWQGGpJa4KIIi9LUHmMBmwlKLXj2ViII1nGgbTUoO+Uz03VY2+1zwpTtvY0f
         Gk00FYYtOE8NkkxfyLclAx58kpSZX0OIXimmSHFeZm1QUGYcoqKviJfVrctna2lbtoVa
         EZbEyFoAZOoal746r4GZOBAgHXhy8pPPrg1CwsgOx4fChT1iuNnq07CqAV00QG5ii/uH
         /JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRFwGBLakySRCLBsud3HZmRY9ihXCzODxn9dGXiuihA=;
        b=IA+jvhfcgi+Kz5zvnz/Q8AvNEyYHWwsKzYl9WgDo1p3kaVizm9NKYDeekbnyI3pxiW
         6craHAYeNgWBhxYk50woozzZOEd2VXbiq+g6gmpcSVe60i4dNT7S1t5tPMw9XhNhpPuI
         kf+9tID8bVh2Hy4Vlw1TOVxAfpjomy5PEEpFx8DMZCxVbIxHyNEMWIWjfNrp4oT/pdGi
         uAzBYXGXqDdf9OgpWl+WoYGlIoddtb159vC9ElAWN2KSmsdLcevprGz5wVHsPScH3e8o
         cHyumpB4c2yFA6vDWcIQU7PrZcLvrMTAIyJmQR7Sh9GUmL0yyMrSD7VLB82i2VEVww2j
         kTFQ==
X-Gm-Message-State: AOAM530/MyBr1aG0E8C+p/zw266zWw0IGLDFjnpwP0ccD5zYTQz7W1zK
        Ak1giE5jlWRqkW1KIl94R0iQ2A0MceLzki+iec4=
X-Google-Smtp-Source: ABdhPJysurRlWe9JH95EiXQVHEmQZJrS3SbjnGV09l1/IsVFHXDGJExrVCRlC8SWRZry2dbTORxhFwhX7y7OhOVh/Zc=
X-Received: by 2002:a9d:429:: with SMTP id 38mr194835otc.88.1598937612625;
 Mon, 31 Aug 2020 22:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
 <CABBYNZ+Q84vmEDgfNuoYXAAMi6T3segO_hSkG5Oufc5F_w9Qeg@mail.gmail.com> <CAJQfnxHyzFAG6zJfsuneLX_rW8yNkd2ZpKotHu3DV6vZABT-qw@mail.gmail.com>
In-Reply-To: <CAJQfnxHyzFAG6zJfsuneLX_rW8yNkd2ZpKotHu3DV6vZABT-qw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Aug 2020 22:20:02 -0700
Message-ID: <CABBYNZJ4Y-U1nvyBvFwUXf+c0uT-42pBbrNtBG_G4RhLXGYspw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc/media-api: Add Press method for MediaPlayer1
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Aug 31, 2020 at 8:19 PM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> The reason we introduced this method is because we need to send some
> of AVRCP category 2 passthroughs in order to be able to qualify the
> AVRCP absolute volume control as an audio source, despite we don't
> actually plan to send any passthrough in the practice.

I wonder what those are, are they volume up/down?

> Therefore, which passthrough we send is actually not important (to
> us), as long as we can do that to satisfy the requirement.
> However, I see that there are over 50 passthroughs across category 1 -
> 4, and thought that it would be cumbersome to have a different method
> for each key if one day we decided to support them all, hence the
> generic method.

Yep, but there are button presses so things gets a little more
complicated if we need to emulate press/hold/release semantics.

> May I have some questions?
> (1) Why do you prefer a dedicated method per key?
> (2) Let's say I need to add a dedicated method for a single category 2
> passthrough key, do you have a key in mind or I can just pick by
> myself?
>
> Thanks,
> Archie
>
>
> On Tue, 1 Sep 2020 at 01:16, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Mon, Aug 31, 2020 at 12:37 AM Archie Pusaka <apusaka@google.com> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > This allows us to send any passthrough command.
> > >
> > > Reviewed-by: Michael Sun <michaelfsun@google.com>
> > > ---
> > >
> > >  doc/media-api.txt | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > index dabc69936..fe7222eef 100644
> > > --- a/doc/media-api.txt
> > > +++ b/doc/media-api.txt
> > > @@ -199,6 +199,14 @@ Methods            void Play()
> > >                         Possible Errors: org.bluez.Error.NotSupported
> > >                                          org.bluez.Error.Failed
> > >
> > > +               void Press(byte avc_key)
> > > +
> > > +                       Press a specific key to send as passthrough command.
> > > +
> > > +                       Possible Errors: org.bluez.Error.InvalidArguments
> > > +                                        org.bluez.Error.NotSupported
> > > +                                        org.bluez.Error.Failed
> > > +
> > >  Properties     string Equalizer [readwrite]
> > >
> > >                         Possible values: "off" or "on"
> > > --
> > > 2.28.0.402.g5ffc5be6b7-goog
> >
> > For now I would prefer to use dedicated method per key or are there
> > many keys you would like to use from the upper layer?
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
