Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12DCC388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D19206E5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hm5QjcrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgKSUZ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgKSUZ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 15:25:29 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:25:29 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id s25so9755321ejy.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEq4IzqBnAmx5dpMgp9ZKh8p2ENgVPKp2NO8sDACZG8=;
        b=Hm5QjcrRHQNnqdpS9xFHyT5a7BNHaoOjsJjZqdq8Js6e+rj2axPaaTYaivTiwMz2Gg
         0uLvD602+YeQqzQUR7R1aY38jkp8Hf+MdF5aQvKGVdAbHSb+XSDNKucwxcvdugFPw4M5
         gxBYn3el2FCOrIX8DwU8nyaj5nkKm8bQrSWT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEq4IzqBnAmx5dpMgp9ZKh8p2ENgVPKp2NO8sDACZG8=;
        b=eSFU/FFB2kk0pRLqr7EvL7qR6zGmURRCFcPoZqu6d4/+Rq9AJ8sDIxEvh+A6sZw7Zk
         L44VQyBmChqt2onb6Mv4pnJh92s5Cs+R1urt0Dkw3Ia0fUH/0/KC7MK1VTktsksmrTmE
         PbwsX7q1ecXRwZAjo+Ua3xOrzMfUR/PL8y3X8urK3tXtAVlpYHfFJjwhsOSkat4CK1sG
         +b3l58AKCKagOw+zI6Bvi4lSFLfYeXdnLQ5QQ5eM+hbDrhJicHNrLY0ZcPmRsC3kOzu+
         IQYxuBGu36Newgd1RLhd82LylTJwA6lyi6KRp5kcqJeG9ysX78/G3lr+/Fzv9L5asTQi
         UQeQ==
X-Gm-Message-State: AOAM532tP5BzsBTdId7OhVItuVuXtGdJTw0Xg0FqXpLW/YWhyZBnxcFI
        Le9ZbAfFqYaUMioR5Y6uEH2S7p8ITqpydA==
X-Google-Smtp-Source: ABdhPJxPUN9yCUMRnipCG3LSv+B7As62k2rNqQ2GeWRdLm0b3jTNBNuxW0wiaaapVeQ6kfD91bRq4g==
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr6789747ejt.522.1605817527140;
        Thu, 19 Nov 2020 12:25:27 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id rp28sm303605ejb.77.2020.11.19.12.25.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 12:25:26 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id a3so7879709wmb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:25:25 -0800 (PST)
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr6136023wmh.141.1605817525109;
 Thu, 19 Nov 2020 12:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
 <1273e316b9ec06061a1065c04521ae91ab379af1.camel@hadess.net>
 <CAO271mmYAx8jY4WMN3yRWOvxWpj1otJN0+aFm5LcTJAu+Cu5sg@mail.gmail.com> <d4ab4a00d074c9f7b80b52eacde380037ac87ff6.camel@hadess.net>
In-Reply-To: <d4ab4a00d074c9f7b80b52eacde380037ac87ff6.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 19 Nov 2020 12:25:13 -0800
X-Gmail-Original-Message-ID: <CAO271mkJuCyLsCKnLfo61chEkTsY-hanU-1F5i9NkTWY3uhuwQ@mail.gmail.com>
Message-ID: <CAO271mkJuCyLsCKnLfo61chEkTsY-hanU-1F5i9NkTWY3uhuwQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
To:     Bastien Nocera <hadess@hadess.net>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Thu, Nov 19, 2020 at 2:53 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2020-11-17 at 14:22 -0800, Sonny Sasaka wrote:
> > Hi Bastien,
> >
> > More responses below.
> >
> > On Tue, Nov 17, 2020 at 10:01 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > >
> > > On Tue, 2020-11-17 at 11:51 +0100, Bastien Nocera wrote:
> > > > <
> > > > <snip> didn't review the code in depth, but, having written this
> > > > mechanism
> > > > for Bluetooth battery reporting, I think that this is the right
> > > > way
> > > > to
> > > > go to allow daemons like pulseaudio to report battery status.
> > >
> > > It would also be useful to know what external components, or
> > > internal
> > > plugins you expect to feed this API.
> > BlueZ could have internal plugins to read proprietary battery
> > reporting, e.g. JBL speakers and Bose QC35.
>
> But you don't need to go over D-Bus to implement this.
Some proprietary protocols may not want to become an internal BlueZ
plugin, for example because it is developed closed source. D-Bus API
is useful to support these cases.
>
> >
> > >
> > > Apparently HSP/HFP, for example, provide more information that what
> > > can
> > > be expressed with the Battery1 API, whether it is charging or not,
> > > or
> > > whether a battery level is unknown, etc.
> > >
> > > So I would say that, even if the current battery API is extended,
> > > we
> > > need to make sure that the D-Bus API to feed new data is extensible
> > > enough to allow new properties, and they don't need to be added
> > > separately to org.bluez.BatteryProvider1 or org.bluez.Battery1.
> > I proposed the API to start simple, but I believe that it can always
> > be extended as we need in the future so I don't think the additional
> > features need to be coded now. I documented how this API could evolve
> > in the future by extending other features as well in this design
> > document that I shared with Luiz and Marcel:
> >
> > https://docs.google.com/document/d/1OV4sjHLhTzB91D7LyTVT6R0SX2vXwSG1IA3q5yWQWps
> > .
>
> Right. My advice would have been to say "the properties exported by
> BatteryProvider1 API match the properties exported by the Battery1
> API", so you don't need to update 2 APIs separately when the API is
> extended.
I am considering doing this. Let me think it through to make sure we
don't stumble on anything in the future if we do it this way.

>
> >
> > >
>
>
