Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F4CC282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B076020870
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 14:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDn1iZmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfAVOUZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:20:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36217 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfAVOUZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 09:20:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so23762244otk.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRQyo+9FLUZ7G+IfWmTvQNFrcySN6caixA1hfZzdCn0=;
        b=DDn1iZmnVr/O5mHyE3lMZRJ4wjOgWHfk9UsyCP1YBJS9sAdVdwkV8j9B20Ro3ftJb9
         eVPgFcR8oGiAcMPfSwb/MarGlwgPb5rkftbJ2OC5P00x68Ag3TZCEQa9gZw+SdxyznYZ
         SvAw/CMVUCUoBdG8YDBcLTsZqqBc/YPcNXbD+Ih61NrWuzOY9wOKUYc2/Ah7X3FpuEr7
         /3JIxr9Gdihxj/0BhNSoFf9+ul4woYTZKjM4uXOoUevPuPJ9ZDaSaC7yySt9sTMWS76U
         7oDPjzl5ZHb7Ymo8yZykE3787GRGweDshsmWSKNZNIMMw8MF+iTrmMqkkF4fGNESX9W5
         VW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRQyo+9FLUZ7G+IfWmTvQNFrcySN6caixA1hfZzdCn0=;
        b=psGzwO31nMkdgqBghhugoUL4qrx3ys/KisqNRo5WODFND2ThgC4KrtCaLIMbhy8biO
         IpKcbUlj5/riV8wEHHfH+9EjuoxMxogV4hoA6MxUuU0cj3sZ5fa93JPe4qlF+LSqUTfs
         g54nci6w4k0p/QxTYMCuFTgB2Flvl9C7bDLiRgaRg/70pKrbkAH81xULbO+CpI2KI6m/
         Kq9+r6qw0i1psECn5XMB4jsqFAyxj/wDntcai9ekQT0faVPWLKeXpMsPxaH+c6ZtdJ9r
         ios/x5oRZbGXKaXwvADEjIhsWBZN1C+43Lb3KbqCuVU/dvSWJnMNLnJjElHLtPZ9TtoY
         pQpg==
X-Gm-Message-State: AJcUukdEz1gIxb5ZWXDFIz3SmH+pMgnb04Jax2D7aGSE3tq210tP5Cy0
        d8CaRR4TfpdPSc6vrdPTeu4fWpOV3Q9jzX3Uqpuu4Q==
X-Google-Smtp-Source: ALg8bN4XAtNWLrM6JU9sOV/fQABLEIz6K426QpOglwJP26m/VaOBPcYrlRHC06uJ5W6RCTgZPSuIUAYVTURPGUn2nl0=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr13645657otf.52.1548166824095;
 Tue, 22 Jan 2019 06:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
In-Reply-To: <20190122134524.20509-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Jan 2019 16:20:12 +0200
Message-ID: <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,
On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds the possibility to expose remote SEP using MediaEndpoint
> interface to allow setting a configuration.
> ---
>  doc/media-api.txt | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index b5ad2db12..af9485342 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -500,14 +500,23 @@ Properties        object Player [readonly]
>  MediaEndpoint1 hierarchy
>  ========================
>
> -Service                unique name
> +Service                unique name (Server role)
> +               org.bluez (Client role)
>  Interface      org.bluez.MediaEndpoint1
> -Object path    freely definable
> +Object path    freely definable (Server role)
> +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/sepX
> +               (Client role)
>
>  Methods                void SetConfiguration(object transport, dict properties)
>
>                         Set configuration for the transport.
>
> +                       For client role transport must be set with a server
> +                       endpoint oject which will be configured and the
> +                       properties must contain the following properties:
> +
> +                               array{byte} Capabilities
> +
>                 array{byte} SelectConfiguration(array{byte} capabilities)
>
>                         Select preferable configuration from the supported
> @@ -532,6 +541,20 @@ Methods            void SetConfiguration(object transport, dict properties)
>                         endpoint, because when this method gets called it has
>                         already been unregistered.
>
> +Properties     string UUID [readonly, optional]:
> +
> +                       UUID of the profile which the endpoint is for.
> +
> +               byte Codec [readonly, optional]:
> +
> +                       Assigned number of codec that the endpoint implements.
> +                       The values should match the profile specification which
> +                       is indicated by the UUID.
> +
> +               array{byte} Capabilities [readonly, optional]:
> +
> +                       Capabilities blob, it is used as it is so the size and
> +                       byte order must match.
>
>  MediaTransport1 hierarchy
>  =========================
> --
> 2.17.2

Can you try this set?

-- 
Luiz Augusto von Dentz
