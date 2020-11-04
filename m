Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4255BC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 00:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB71A223C7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 00:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maRBeobL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgKDAhm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 19:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgKDAhm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 19:37:42 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4DC061A4B
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 16:37:42 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m143so11067555oig.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 16:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zx2KCew9yJOLhuCRAceiFOfGxJZgoLHik50VTTlt3O4=;
        b=maRBeobLiBGBAYA4seRENrW3fOr3Rmg+a8/gSLyqj08+TvhHOh2+RLyB8jk4ivSnKy
         MIPGt/xaXAqcqDeBlgD759fqw3kxhp00YAvoNSrfI9XIFJyZ1zoFilPWbK7992X+ZYAa
         +CRQoJ18+106tgKhOvcuJN6l3AaJXCnfIF2T/KqqbB9rvm29UO9BjxOxr3ID+zYcSQme
         jMeUSNmaBbN+onU18xFlZa2bLLLsDU0eGzXd2Q05Sgry4DwO3Alz+DC6o7lPPeroVISD
         eYY3K+0N4ZhEx8zLatKyxrM2gXEYYzOKN7y0CYollDeLnUmRKOfc9dWPlZ0G/lwCww94
         eynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zx2KCew9yJOLhuCRAceiFOfGxJZgoLHik50VTTlt3O4=;
        b=fh7bdl3Pzw5B227vEzzfyyJzct9Lhqkw/VkwotkO/CUWjB1/jrM3q7gZKf087pkEjq
         X2h9GsSLXId5zd8tL1qy+DcQ8Yc6RzxH6cxeHbF0BNun3uRhyl0mu2Pfhjh8/LVLvaHk
         bT8Qs8FKpVpwAHwvYqHxf082FmW30EO6kjJ7C6ctCOTztyuLEDPtdil6diTEfM8f9GEi
         o7+51ntDsaSh4xYrcxphEO3adJ4gjt0hZZLaPEQCDdzxlzvg6dSAmXbzfA3M/WHJsLg8
         f1P77XEwRfEfmTJ3kYs/Q94jnDrcFaG5YIATRQH+LRyToNa6svPdgkMwP6jO/lSkO0ei
         PI+g==
X-Gm-Message-State: AOAM5317XOPWDQMVLCtNKerdRMdxLXtEf92W8AWicbnkYB72hR53FvIH
        dv0G3QAg/d/iTdXi7J70gk4HGc/7426zsofKAfU=
X-Google-Smtp-Source: ABdhPJyHF/Lz9hsUyDVK3Zs5KyN+iXA0V+mQSVQHASodEiQ+BKS6kKWGYeWYA/V12nen1g94Obu4OZinSm8oI+HGf78=
X-Received: by 2002:aca:c70b:: with SMTP id x11mr1170908oif.58.1604450261429;
 Tue, 03 Nov 2020 16:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20200419234937.4zozkqgpt557m3o6@pali> <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
 <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
 <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
 <20200516075340.3z37ejs3fuhctunl@pali> <CABBYNZLWsYHeOo3_+hcq4r+gY_0sLBQhftW7My7Y4D1n9o5jxg@mail.gmail.com>
 <20200518165011.jfarrp5mtqoy3mqz@pali> <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
 <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
 <aff611bb-4b38-7614-ce61-fc3e7c012615@igalia.com> <20200604204343.eor47oe3fbzf6rbv@pali>
 <020e740e-807b-ccda-0036-f307fe453c1a@litza.de>
In-Reply-To: <020e740e-807b-ccda-0036-f307fe453c1a@litza.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 3 Nov 2020 16:37:30 -0800
Message-ID: <CABBYNZJTBM87Yr+rqUm6MwwSR60YNe+UFr0HHj5T2DkY7LqJqA@mail.gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
To:     Jan-Philipp Litza <janphilipp@litza.de>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Ujjwal Sharma <ryzokuken@igalia.com>,
        Andrew Fuller <mactalla.obair@gmail.com>,
        Aleksandar Kostadinov <akostadi@redhat.com>,
        David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, usharma@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jan-Philipp,

On Tue, Nov 3, 2020 at 4:43 AM Jan-Philipp Litza <janphilipp@litza.de> wrot=
e:
>
> Pali Roh=C3=A1r wrote:
> > Have I missed something? setsockopt() solution which I described in
> > <20200419234937.4zozkqgpt557m3o6@pali> email is already runtime option.
>
> I think what Luiz meant was that there has to be a module option that
> enables the additional kernel code, for example
>
> modprobe bluetooth enable_voice_setup=3D1
>
> This would enable us interested folk to test the changes, while they
> cannot blow up other peoples Bluetooth stack. At least that's the
> reasoning that I assume.
>
> The setsockopt() is a runtime option on the application side but doesn't
> "protect" the kernel.
>
> Content-wise, I understand Luiz' message as an approval of the general
> API you proposed, as long as it is not active by default.

Yes, in fact we are trending to introduce experimental interfaces for
most of our new features so we can polish them and users can test with
either build time option or runtime option like you mentioned above,
this should balance the stabilization of new features with power users
that do want to use them even though there are not marked as stable.

--=20
Luiz Augusto von Dentz
