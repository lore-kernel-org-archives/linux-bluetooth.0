Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA3C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F0E6109E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 21:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhHMVs3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbhHMVs3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 17:48:29 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4875C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 14:48:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k65so21351519yba.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uwd6xLMrmFdHdnC7yXTx9GxeuFOr0yzew/NqOlROMvQ=;
        b=uanRGbjhT2GD3Tlk1BgxzhEZKGDRK7Q2mlJCSlx0JdrVFqP/eABvSFTr4mJdZIl1dV
         1mJce0wxA8dbMa75/WnLQzAbQ8n6I30LPUm2sMECC2eyxMUccSIFvGpFXYY5ejo1J3Yh
         7Qb5gGm9pP3E0E5tJOpHmX08m3pwiyXABLn6+OpTwKcxj759+fkqpLhDro+M9Z+/fhNS
         vjZnEom6TXzkaf/fsDXz+Tt8HAVjrLlIjLWfsQ8kSrjajIDrCuiGEXiisznkD5z9YRB5
         nJrVpdzhapm/v2mg4xMlHOeBr9DIQyIGnYYM+vsjnNA1xtxYksaR9Dvj3xYDjdXYhvCX
         Fxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uwd6xLMrmFdHdnC7yXTx9GxeuFOr0yzew/NqOlROMvQ=;
        b=OqbqFBg7aCh/RA//fZ0IJI5R/eapw4YNmEpSbKa+B+G9P4w7jwf5+2fuy7O9PoWcPz
         K+0ZzYhZxzXIiIm0gLkDqOb175bYGe6tVV9YLetUqlFjF+/0hCdp/vRK1acfCzlJrv9I
         B/GJBm6+Wy736slI/Vr6sdqPIcfe0LdAnyHGkV7RH7OpfrjW7tXXkHjKnNqEcvsres2S
         ceC7IZNlNWnDnOmKM0CJkOD8coAeJ4pSkZlv8awFHBDCAAfAvWJpaH8gGSu6SrprVTMg
         Z1H0pJcMpU2F+W5MSfLkwOMKCJXEYdOSx5yGpS5fZuSGwBfp/QIqe9fKlyE2ScsUpmdi
         iSdg==
X-Gm-Message-State: AOAM53383CqE6h+eFMUD8WdvEz+a+mP1eTAZZvKiShc/+k+wG7qVdNyR
        NrLZXTznlQukXEeh93qMMr/WvEu9ujoOqRK9RRQ=
X-Google-Smtp-Source: ABdhPJwkTU1iof5x36POnS7odPragIHDyPesF96FR7LIkHyFuKjV9mAMz+Z9LBGWQNRtsOQ1xQtsmnzp/EQIDa0uR1Y=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr6070933ybg.347.1628891280996;
 Fri, 13 Aug 2021 14:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com> <20210813201256.Bluez.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
 <FB2904D7-96FA-4A26-83A3-2F1729DC2D73@holtmann.org>
In-Reply-To: <FB2904D7-96FA-4A26-83A3-2F1729DC2D73@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 Aug 2021 14:47:50 -0700
Message-ID: <CABBYNZJVNiz0E2_knPUoXOV1VVhkjBY2Wcq-So_+2=ES5a2cDA@mail.gmail.com>
Subject: Re: [Bluez PATCH 01/62] lib: Inclusive language in HCI commands and events
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Archie Pusaka <apusaka@google.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Aug 13, 2021 at 12:26 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > "central" and "peripheral" are preferred, as reflected in the BT
> > core spec 5.3.
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> > lib/hci.h          | 14 +++++++-------
>
> until we deprecate libbluetooth and no longer give an option to install it, you can not do this. It is part of libbluetooth and this would break API.

Couldn't we perhaps bump the major version so we could move on with
these changes, or would you like to deprecate the libbluetooth before
we move to e.g. BlueZ 6.0? Since we have done these changes on the
kernel size I wonder also if it shouldn't reflect into userspace
though, we could perhaps keep the old definition alongside with the
new though so we don't break userspace tools/apps which may still be
using the old definitions.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
