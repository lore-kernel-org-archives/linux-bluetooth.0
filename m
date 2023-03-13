Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE989C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 05:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCMFgt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 01:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMFgs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 01:36:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F363D0AC
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 22:36:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m4so1177531lfj.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678685801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/lIZfd58WTdCFK9RgpDo0IowGCfm7nm/r8KwY6UyOs=;
        b=j7/+cr0bzYmXPdgNnhy6R4hIhQLZo1YtmqTKnu8pgZpJbi2LI4h8SLW3my4ecoauOP
         nMLcXJKWpW5swo4ahXgsHI6AzDjJifRpbdl8TuYl/O+Bs8j4IErw0ABjtuPgMEzcHUz9
         03opoPGZ2+JunRMxJyqFRZYIHr+shLJyVaKtENx+A6Dcxd1jRB9nR14N+P1Qva8Nyh49
         6h/sVoquiPcldxSnkBvmcI8b7NKCZ1dSBw+CAQvcbpwhoSYj6BhXTm5LHwTdxw5l7PfW
         NG5rMhr2SzmgPTVDVn79lo8MTPU5Iimw3QjXpu4nqXKmctX6YeCee1wgDsBD1En4EI41
         oj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678685801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/lIZfd58WTdCFK9RgpDo0IowGCfm7nm/r8KwY6UyOs=;
        b=ETKs6Inf8KP6cuUth9nvjZlUJRbxjHzGfQGt4yVj5JXKSKf5SDrCitfkdUPVBHeUcF
         wj3CPhhL+0jJrmqZOo2FTB6V1nLZ868ZbjeLGiBuyAk6Hujolk1/eHt3h/lip+B7zIbq
         C68dn2CpAkKPb48Ru33KIBaC+SWt69zp+dsZ77nYXL9xH4B0NUQNo2mT8bXeAgg0xhF1
         LRNSDrkrgUsnSiPzXXfhQmIqa7xMM3/K13DpeiwuRxM2a85q+rv3vXkSpXN+XTF/scPS
         FhpmzxfF2Zrgub3Fq1W1bBqDcJaZhIu2eOzUUtX1Rs03V8Bzc5FyvzPpVabnF+vkgp0F
         n+4g==
X-Gm-Message-State: AO0yUKUL8St+R5fc7TWbX0EhBqWRev0S210XksORR0yAK0/zirQTTag9
        KYi5s1uavkeNEtlDPMAfeTl/PFZUWJhPsbxOiB/tnTRK
X-Google-Smtp-Source: AK7set+GTEwZmmiNoE5kb+vW1S/mJeSoUDyi+MvVB7CCazBEYlFZMW9zsyI2tCdC6Q+uEoAUSCbSV3ct1ETkzHFq73k=
X-Received: by 2002:ac2:5325:0:b0:4d5:ca32:68a3 with SMTP id
 f5-20020ac25325000000b004d5ca3268a3mr10077025lfh.8.1678685800585; Sun, 12 Mar
 2023 22:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230307222422.2608483-1-luiz.dentz@gmail.com> <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
In-Reply-To: <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 12 Mar 2023 22:36:01 -0700
Message-ID: <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
To:     patchwork-bot+bluetooth@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>,
        =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli, Frederic,

On Fri, Mar 10, 2023 at 4:40=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue,  7 Mar 2023 14:24:11 -0800 you wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This adds bt_crypto_sirk which attempts to generate a unique SIRK using
> > the following steps:
> >
> >  - Generate a hash (k) using the str as input
> >  - Generate a hash (sirk) using vendor, product, version and source as =
input
> >  - Encrypt sirk using k as LTK with sef function.
> >
> > [...]
>
> Here is the summary with links:
>   - [RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc1dd94cc7f81
>   - [RFC,v2,02/12] shared/ad: Add RSI data type
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc2e99aefd337
>   - [RFC,v2,03/12] doc: Add set-api
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D6477522e92e3
>   - [RFC,v2,04/12] device-api: Add Set property
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D5bac4cddb191
>   - [RFC,v2,05/12] core: Add initial implementation of DeviceSet interfac=
e
>     (no matching commit)
>   - [RFC,v2,06/12] core: Check if device has RSI
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df95ffcc8b1fe
>   - [RFC,v2,07/12] main.conf: Add CSIP profile configurable options
>     (no matching commit)
>   - [RFC,v2,08/12] shared/csip: Add initial code for handling CSIP
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd297a03b7a61
>   - [RFC,v2,09/12] profiles: Add initial code for csip plugin
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9e1eb0a62b3f
>   - [RFC,v2,10/12] tools: Add support to generate RSI using SIRK
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc446a64d461b
>   - [RFC,v2,11/12] client: Add support for DeviceSet proxy
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D373bafc34ce6
>   - [RFC,v2,12/12] client: Use AdvertisingFlags when available
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D815f779aa8e4
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Let me know if you guys are happy with this interface to detect
Coordinated Sets, it still experimental so we can experiment with it
until we think it is stable, regarding the implementation of the
transports one major difference here is that we will need to encode
left and right separately, not sure how hard it is to do that in
pipewire?

>


--=20
Luiz Augusto von Dentz
