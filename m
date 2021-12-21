Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B34C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 21:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhLUVUJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhLUVUI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 16:20:08 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7AFC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 13:20:08 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id j124so690670oih.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 13:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkDpkabvmW3VkQkE5L59kEuDY8LJ+nc6bU13fclfr58=;
        b=Nwvs4UA+UzCPtVkF7QgadcoQUS6cye025xBPKsUzbIj2tY9DYp4fvbUGQsg3Qgf5Df
         L3oHlKZ6wWp5jI+f3tPSNZ+WhtX28cCPYerW5EOxdwB64fBmO32a2VDJspwKMk8jn4Gz
         R6GpzTwmgip/+TNz5urJxMPxXRdpyCac7Q7CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkDpkabvmW3VkQkE5L59kEuDY8LJ+nc6bU13fclfr58=;
        b=cLDCTbBGbBTu/YomCocVK4TmjU5/qm1iISBRvskkhnj03FLBIVMazTrxnaaJLJBZvN
         XPs8LLhRHYVK+691kIyFK2WjE/HqAinfatRK7a1NnomL7Y7XATyOVx06wz3iV7ppaIXu
         7d9tEBMJnjAaF9AWT4DH0gWB597fRuLOS9aB99A66/Ulb1RH0J3jhU2YGHnXfBw6PJDB
         +t5y3AKvm+3/jl7Tq2a9nm4Z++BVVaj0jO2UkyV7vraja3s96S8QDzO9j01H3rYg3HhX
         iQfJ1ImSgSnnuDhbPBKVWRNfcx6AnA+U61NuyvEc0Dnjz6/b9hclUqnVpOvus5hMsO08
         Ws6Q==
X-Gm-Message-State: AOAM532xaYiDCSPpusKbur2A+yGuSOnqZxcZDMob1aQgeZnhNpFJxah9
        4f+TFVffGGxl5sqXFBfrKthHDHb+D5n8AA==
X-Google-Smtp-Source: ABdhPJwdja1OseFfdLBKLj1aGl0jOTvSldcusUYmvf1ZlcR1tcA+O1Q7xFQumvoQ+Gs+oRFCrUfs8Q==
X-Received: by 2002:aca:5f44:: with SMTP id t65mr206215oib.131.1640121607030;
        Tue, 21 Dec 2021 13:20:07 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id l24sm28918oou.20.2021.12.21.13.20.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 13:20:06 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id s73so740259oie.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 13:20:05 -0800 (PST)
X-Received: by 2002:a54:4381:: with SMTP id u1mr239994oiv.70.1640121605395;
 Tue, 21 Dec 2021 13:20:05 -0800 (PST)
MIME-Version: 1.0
References: <61c10192.1c69fb81.96a67.06a8@mx.google.com> <CABBYNZLQ_b8Aw21QnUzmuEedny4wh4LSu6DLQvw1pynFGvHMTA@mail.gmail.com>
In-Reply-To: <CABBYNZLQ_b8Aw21QnUzmuEedny4wh4LSu6DLQvw1pynFGvHMTA@mail.gmail.com>
From:   Jesse Melhuish <melhuishj@chromium.org>
Date:   Tue, 21 Dec 2021 15:19:52 -0600
X-Gmail-Original-Message-ID: <CACGnfjRA2Co6OpTJfosbx0GdLJwk3dVHQ8edWPqkKSo_q4JyPQ@mail.gmail.com>
Message-ID: <CACGnfjRA2Co6OpTJfosbx0GdLJwk3dVHQ8edWPqkKSo_q4JyPQ@mail.gmail.com>
Subject: Re: [RFC BlueZ PATCH] Bluetooth: Use driver status and experiment
 value for central-peripheral support.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Jesse Melhuish <melhuishj@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for looking at this. I did see the main.conf file, and the
documentation is fairly clear, but I think there is still a bug here.
Mainly: if one enables the experiment via main.conf, but the driver
for the kernel has not set the relevant quirk indicating that the
device supports the functionality, we are still seeing
"central-peripheral" listed as supported. Ultimately this leads to
test failures for us as, believing that the functionality is
supported, we execute tests that then fail (this is reproducible if
you modify a test device's driver to not support this feature (for
btusb I removed BTUSB_VALID_LE_STATES as an attribute) and enable the
feature via main.conf). In code, I think the culprit is seen in this
function in that the value of "action" is set exclusively by the
main.conf file, and is then passed into "feat->func" which adds it to
"adapter->exps" (at least for this feature). Given what you've said
here, I believe the right solution would be to require that both the
feature be supported (as derived from the driver) and enabled (as
derived from main.conf) in order to consider the feature enabled (as
reported to peers/via query).

On Tue, Dec 21, 2021 at 2:57 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jesse,
>
> On Mon, Dec 20, 2021 at 5:59 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
> >
> > ---
> > The observed behavior without any change is that support for the
> > central-peripheral role can be enabled through an experiment flag in
> > BlueZ regardless of whether the controller can actually support it.
> > Additionally, if the controller has enabled this feature but the
> > experiment flag has not been set the central-peripheral role is not
> > listed as supported. I'm not certain what the expected behavior should
> > be, but enabling if either source says to enable (this patch) or only
> > when both enable the feature both seem like reasonable options to start
> > with.
> >
> >  src/adapter.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 9fc6853c9..60325015b 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -10434,7 +10434,8 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
> >                         }
> >
> >                         if (feat->func)
> > -                               feat->func(adapter, action);
> > +                               feat->func(adapter, action ||
> > +                                       (rp->features[i].flags & BIT(0)));
>
> Feature being supported doesn't mean the system wants it to be enabled
> since this is experimental after all there could be side effects, the
> proper way to enable it is via main.conf:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n115
>
> >                 }
> >         }
> >  }
> > --
> > 2.31.0
>
> --
> Luiz Augusto von Dentz
