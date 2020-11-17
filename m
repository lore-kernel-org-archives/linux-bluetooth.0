Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35CCC63697
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 22:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7B7241A6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 22:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L/sjVH5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgKQW0R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgKQW0R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 17:26:17 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC85C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:26:15 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id d18so11281314edt.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jcL402HXfmlzonKdCIzeVQZ60+q+bqYV6QCyhds2f4=;
        b=L/sjVH5nhgEc5delwuvdEZFGwHhFtO6tExxhzdOIF1l10t4Ffj1ziSAe9IkROAbG0M
         mc308BfkljcidLlFZ/hhD1Zw60tlGmnEieC3hZl8Rqrm+U50wtq2CSTHwXwlTy95E7xk
         TGa4KustxWwEQNpI+OINInoMVTMfNGYx9pPm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jcL402HXfmlzonKdCIzeVQZ60+q+bqYV6QCyhds2f4=;
        b=EVzARx2R9iw8OOgiLZZ1Fq26KMJXTqsjNjpoeKYCPLzcYi4dKZyfITGLs2tr+H8K9J
         fmmIBJ8qt4Q2aochtNGB4wMFVNdjun5SWNZsyt6H4AqVgVmrBpV4EOK1okwGr26IEfxB
         INuJbARYsAB+hqbpEb2CrBQzV0NAAvQphrI+yiRl4WaZSsK46Pl9RB6tyNOv/Fe4SjeV
         /WUttbape2sx2mr6GpWHi4CHnWnriq62cYqptf/gg7GVKBHn40BunyxHtp9ywyfA+FRa
         pIGQn1CKtIDye5YbGcl94MRNqW93QfOgoi2yTMZwpyEaldXXOnSWV2j3HTwtHEFeD3q6
         2iTQ==
X-Gm-Message-State: AOAM530EQwKN/wl6T2p7NvQzcwpXqYIdcgLwL4cWzKUlbFNusSRbnC6p
        tNL7ZEXA2o6celhMeJYsK4GtQ86YPMmE9g==
X-Google-Smtp-Source: ABdhPJyGcqI6e6j3I1yLE2j6ddWjlkQBM+P2hryWun4uGXYw+DIJ7uheujPz+V+ao+7dZkRNqR4leA==
X-Received: by 2002:a05:6402:c83:: with SMTP id cm3mr22886458edb.189.1605651974246;
        Tue, 17 Nov 2020 14:26:14 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id v16sm917834ejx.57.2020.11.17.14.26.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:26:13 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id d142so245821wmd.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:26:13 -0800 (PST)
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr1143549wmh.141.1605651972869;
 Tue, 17 Nov 2020 14:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
 <1273e316b9ec06061a1065c04521ae91ab379af1.camel@hadess.net> <CAO271mmYAx8jY4WMN3yRWOvxWpj1otJN0+aFm5LcTJAu+Cu5sg@mail.gmail.com>
In-Reply-To: <CAO271mmYAx8jY4WMN3yRWOvxWpj1otJN0+aFm5LcTJAu+Cu5sg@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 17 Nov 2020 14:26:01 -0800
X-Gmail-Original-Message-ID: <CAO271mmWeteugnTw_8tD_Ami50JSyK+59QYL2_r14F9ys5K_hw@mail.gmail.com>
Message-ID: <CAO271mmWeteugnTw_8tD_Ami50JSyK+59QYL2_r14F9ys5K_hw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
To:     Bastien Nocera <hadess@hadess.net>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Tue, Nov 17, 2020 at 2:22 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Bastien,
>
> More responses below.
>
> On Tue, Nov 17, 2020 at 10:01 AM Bastien Nocera <hadess@hadess.net> wrote:
> >
> > On Tue, 2020-11-17 at 11:51 +0100, Bastien Nocera wrote:
> > > <
> > > <snip> didn't review the code in depth, but, having written this
> > > mechanism
> > > for Bluetooth battery reporting, I think that this is the right way
> > > to
> > > go to allow daemons like pulseaudio to report battery status.
> >
> > It would also be useful to know what external components, or internal
> > plugins you expect to feed this API.
> BlueZ could have internal plugins to read proprietary battery
> reporting, e.g. JBL speakers and Bose QC35.
Adding to mention that in Chrome OS we also plan to have a plugin to
decode Pixel Buds 2 multiple battery values (left, right, and case).
We have not yet decided whether this is going to be internal plugin or
external client though. But generally the API should allow this kind
of feature as well.


>
> >
> > Apparently HSP/HFP, for example, provide more information that what can
> > be expressed with the Battery1 API, whether it is charging or not, or
> > whether a battery level is unknown, etc.
> >
> > So I would say that, even if the current battery API is extended, we
> > need to make sure that the D-Bus API to feed new data is extensible
> > enough to allow new properties, and they don't need to be added
> > separately to org.bluez.BatteryProvider1 or org.bluez.Battery1.
> I proposed the API to start simple, but I believe that it can always
> be extended as we need in the future so I don't think the additional
> features need to be coded now. I documented how this API could evolve
> in the future by extending other features as well in this design
> document that I shared with Luiz and Marcel:
> https://docs.google.com/document/d/1OV4sjHLhTzB91D7LyTVT6R0SX2vXwSG1IA3q5yWQWps.
>
> >
