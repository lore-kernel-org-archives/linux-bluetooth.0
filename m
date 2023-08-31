Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE3FC83F2F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 21:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347488AbjHaVFO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbjHaVFN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 17:05:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5E7132
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 14:05:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso22420951fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693515907; x=1694120707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3Ht40VKtWEeVqnpvoz8L3E4L30e+ozlxRYcmGDajcI=;
        b=RzqWEXqrQATwdLGJveZOw3yRnXa/3PJOiEq0hImpKcUviqAxg8UGt9DBdp8jYAfkR9
         P7ti/79Bthh1gPHc7NxEB/duef3Qf2woZiZI2lLrNSWnFMLt/UpsOZgNZuRzDAwFhNzW
         wQV8hM0U2l0XLYrASP2+lYRkDAEN8Y8si9m1+pFEzwpoxslTHJnA1i1h4pMovK3+ls3A
         Lx4MGpvtL4/DCW2ZM+3IRl7D6qm5waNxBCvs4u6hf9Pvb6ii0FnNO3CVlb7hmD8J02U9
         BvKIjaNopxbp9U4pDjPezaMFFHMgvBGrh/TTc+d3YCpXApvO3R9bX8ftHA2GPHKwC3T4
         cU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515907; x=1694120707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3Ht40VKtWEeVqnpvoz8L3E4L30e+ozlxRYcmGDajcI=;
        b=ANXChm7k0tnbR0GlmwFI1HvmCnWZzh1iJRF6q/VGlwk3o6CqutW31mVfLlXPWxQFip
         Q3ONMFkpqF/1SBQwjUr9k550g/8Mw/z818oQvYhsHVNJPZ9dvggl8lMj2Lrp/QpZBFQl
         T9T6glqrYEwUFiGxNQulUUSBhfi4U6QCyUWxXzbQRTWCcf34Jp5+/jAVPleBlpYu5/6I
         cns5HaZafTANCNLztdOelvfqVR4297UR4GjGDTTvbeIrF+JBj0k+tyzxJFvPLouMN6b3
         GKlZv7E48ndI0aIx2z8FSmS2N72WxP01Ksk3Pbs2drR+1HSZhlshuL4shru31fSpr8hY
         Yytg==
X-Gm-Message-State: AOJu0YzkM0tdoIn+r0J2LPvA7KlefF1HbT2/2sKgHgYPng79fxDGb4Wp
        oljLGCWTgjnqc5uLfo4aC19vO35beder6q7tjNo=
X-Google-Smtp-Source: AGHT+IGVTXoM99vlQcDWcK0E/2YkboDRo8HkVVrtW5VnAyhvaYy6X4vsUnD5CVqNCOYTT7czwoV6TpcVYzl1fo43ekA=
X-Received: by 2002:a2e:8356:0:b0:2b9:f0b4:eaa1 with SMTP id
 l22-20020a2e8356000000b002b9f0b4eaa1mr266139ljh.16.1693515907233; Thu, 31 Aug
 2023 14:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
 <168858002504.7518.9584432839192702711.git-patchwork-notify@kernel.org>
In-Reply-To: <168858002504.7518.9584432839192702711.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 31 Aug 2023 14:04:55 -0700
Message-ID: <CABBYNZ+7kcMqxMCH+VEJgk3x=37RU2Mchdxn3xFuU2uVp7nsqw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] shared/bap: detach io for source ASEs only
 after Stop Ready
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jul 5, 2023 at 11:18=E2=80=AFAM <patchwork-bot+bluetooth@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Sun,  2 Jul 2023 21:43:04 +0300 you wrote:
> > The Client may terminate a CIS when sink is in QOS and source in
> > Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it when
> > Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.1)=
.
> >
> > It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiver
> > Stop Ready command if CIS is already disconnected, and then gets stuck
> > in disabling state. It works if CIS is disconnected after Receiver Stop
> > Ready.
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v2,1/2] shared/bap: detach io for source ASEs only after Stop =
Ready
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7b10e72de6f4
>   - [BlueZ,v2,2/2] bap: wait for CIG to become configurable before recrea=
ting CIS
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D8c3170190d6f
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Looks like this one introduces a problem when using the emulator:

https://gist.github.com/Vudentz/5c7ef940fc97b054227559dcd47b99f7?permalink_=
comment_id=3D4677775#gistcomment-4677775

If I try to release then acquire then it won't trigger recreate logic,
I suspect this is due to bap_io_disconnected being called ahead of
states changes.

>
>


--=20
Luiz Augusto von Dentz
