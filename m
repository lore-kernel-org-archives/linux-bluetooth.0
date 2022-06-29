Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2112C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 21:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiF2VIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2VIE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 17:08:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E7286E0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 14:08:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n15so20498834ljg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1fCLtfjWHJs+K9kcrVu9hY5BpiFjaC8Fgc7RipsZfyY=;
        b=Cbf+X1GeJOY9p35sjMler8RESmvoJF+nX2XEQ3Z0LB61EKQi/xqJC4DcvfjeLr3Jko
         45E5X33GnSIRwwQYxc1lA2jctu1dWMGkrnEZ/UdihXtTwp34gXh4VkqHxd5MOrMEZH6M
         98JUv5wfxvbx6BWNAPUEqnD9KiXfOr/5N87uZsJQ8KZwQNlXTUwINxVdmNdWohzWmSqV
         a31epskcRVRw70f1KCxASJ+ZYO3MDSilFzHIq1AwsYBTX5AEn9jeKKjTAkplTpXxi8Ii
         hjVEI3EK+Cs3SHdEC1h2CKByU45LT07wqdFXLhbHj0BrABzZIg9hLlwSlgD2j+1x0Ljz
         /gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1fCLtfjWHJs+K9kcrVu9hY5BpiFjaC8Fgc7RipsZfyY=;
        b=0PFHALNQrP2goUuH9S/MnVerB922f+h3AaaRJ9m6Eg3+dQ2DLzzeOHZ2w2SsV2Qdje
         FoRkkY99amYB9wiOqy9evmwjrUg87g4BkckjttTzbOPZ9Q2xyPoiSYW8y0yweC/HL1+1
         YSE9g5IHmtjaEwfc3+xvl0TUYaIfQaGvt3zpe8NFcTiJPRJa5Ymqab7FhCHRrLG+y55n
         huWZ0DiufOQizCFat1kXHp1+RhvPv2MEgqqEvaOYEutqwYg0ajaAaAyj7NJ6JFHohOiZ
         3z6fUeeqiwbBztGJdvSZoXTDaS3yJgtJ6lLu/ib630trFNCUBTxZqssGqPBp3KQiXngi
         SA6A==
X-Gm-Message-State: AJIora9hiGXWYIN0Ls9WnoDmF5+wxX3bM2Ld00XL13ZeP/kBT7Fj+1X4
        fHwRMXm6ODZ0/IWFNrykjoM+ofiRatjqV6e4Llw=
X-Google-Smtp-Source: AGRyM1tZ9ZAYFgj93wUepwaZ6aHutsMmJ3SzLir9qd3aTkGtItrGIiwNs3hlBICHrr6L7qXAIx5idKYxJuEZ431tO70=
X-Received: by 2002:a2e:a16f:0:b0:25a:7527:95ce with SMTP id
 u15-20020a2ea16f000000b0025a752795cemr2887612ljl.305.1656536881560; Wed, 29
 Jun 2022 14:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194432.20229-1-brian.gix@intel.com> <20220629194432.20229-2-brian.gix@intel.com>
In-Reply-To: <20220629194432.20229-2-brian.gix@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Jun 2022 14:07:50 -0700
Message-ID: <CABBYNZ+RutkWSsOqo1Ci5XrvivRr7w+YAXXQ55OPM4MsWpi-Ag@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] core: Fix signed vs unsigned compare
To:     Brian Gix <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        luiz.von.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Wed, Jun 29, 2022 at 12:56 PM Brian Gix <brian.gix@intel.com> wrote:
>
> __time_t is not a portable data type, and can cause sign mismatch on
> come compares.
>
> Fixes:
>   CC       src/bluetoothd-device.o
> src/device.c: In function =E2=80=98device_is_name_resolve_allowed=E2=80=
=99:
> src/device.c:4092:17: error: comparison of integer expressions of differe=
nt signedness: =E2=80=98__time_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
and =E2=80=98long unsigned int=E2=80=99 [-Werror=3Dsign-compare]
>   if (now.tv_sec >=3D device->name_resolve_failed_time +
>                  ^~
> cc1: all warnings being treated as errors
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 7b451e458..012d73583 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4088,7 +4088,7 @@ bool device_is_name_resolve_allowed(struct btd_devi=
ce *device)
>         /* now >=3D failed_time + name_request_retry_delay, meaning the
>          * period of not sending name request is over.
>          */
> -       if (now.tv_sec >=3D device->name_resolve_failed_time +
> +       if ((unsigned)now.tv_sec >=3D device->name_resolve_failed_time +
>                                         btd_opts.name_request_retry_delay=
)
>                 return true;
>
> --
> 2.36.1

Can't we just use the same type for name_resolve_failed_time?

--=20
Luiz Augusto von Dentz
