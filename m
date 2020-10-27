Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB630C4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853DF20878
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 21:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qY5NFL6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374724AbgJ0V7v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:59:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43535 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374722AbgJ0V7u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 17:59:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id x203so2893998oia.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mVrifiS7V7HQK+JbsLwridxi+OaBHNcnonmncxzcag=;
        b=qY5NFL6WCNg8DdkKHytUoUCvU2uqmNwkNmhgMujC98Zfq/NSYbx58DTGlBYCU8q+iU
         JuwAU2444WEpN9ByYS+kw/eRTjWxAwaKzH96rk2Y6I9Up04bzzRmq37+fW7tdtS/k5jn
         QtOD4B/7mBC1E/EBLO6bEbklJKr8fjZtCVGu15DT5GZnwFTbAkqkwPgR67If/J/2NVww
         d+PiuhczsiReDTsgz76w//d63Xo/w66Ux/u2g9EmRy7tMs29Ha/rF4D0aLCwPwnkLca1
         apgni60943H417004Pz/jEbuJed2ddMz2redLIU92m5tuExYh8MFddyHnW3LRVsB88J6
         Ef3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mVrifiS7V7HQK+JbsLwridxi+OaBHNcnonmncxzcag=;
        b=tpDOIBem0zLx1Z5y0sjwZ4t226Pj98eD1oUJipvohPjvN7iWHvHwX2+LdzLU3fmbHl
         lWExgM731MTCmGQ2TA/LOXwnmf+IlqrM7GJHoCRnoShVPbY8j5XBC17CnZd6UljCDPx/
         N2cWXp1H558NhVHRchVNfQjGHmOCXxAMvkYb+LCw3HXAWqcxk0LGdZ0G6oHlYtalU0Ad
         FDlX7atzcZFmgoXFPXjwiA4WVv5YpqwL1YBJYAyDCDcoPaa3f0XhWdOQR+LRjPow+z9P
         P0nM3BpBKukRaXsOe0wQiIiuwsAO8kAqpZ7hLaESLykvfv/IY3hFUZ6a9K8+rpaaVxhC
         n3tw==
X-Gm-Message-State: AOAM530sBH4KS51mhq7p2d1TaC5QyEvkVwqkFRNCgV7nbq8cogFCvqH3
        2F38Yut+iP2cxCfPfOsrMWXRYGcHEf5r9AGV8wo=
X-Google-Smtp-Source: ABdhPJwi9q/rCVxfh1gQCl4yOv+jYs7KYjTrBj2XGvc2dx1chpd+45WMDNLTqveL2ECsHYKOyjSPz9yVGvuYEWakxT8=
X-Received: by 2002:aca:518a:: with SMTP id f132mr2865351oib.161.1603835989451;
 Tue, 27 Oct 2020 14:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com> <20201001155738.Bluez.v4.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
In-Reply-To: <20201001155738.Bluez.v4.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Oct 2020 14:59:38 -0700
Message-ID: <CABBYNZLzsZ=rvqHCpQze1ht_LVvj9HL4ecmeqXnev0V-0AkOpw@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 01/10] doc/advertising-api: update API with new interface
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Thu, Oct 1, 2020 at 4:07 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> This updates the advertising documentation to include the following
> features:
>
> LE Advertising Manager:
> - New SupportedCapabilities property
>
> LE Advertisement:
> - New min/max interval properties
> - New tx power property
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  doc/advertising-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index b0565eab2..3215a52f7 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -138,6 +138,33 @@ Properties string Type
>                                         "2M"
>                                         "Coded"
>
> +               uint32 MinInterval
> +
> +                       Minimum advertising interval to be used by the
> +                       advertising set, in .625 millisecond slots.
> +                       Time = N * .625 ms, where N has range
> +                       [0x000020, 0xFFFFFF]. If the provided MinInterval is
> +                       larger than the provided MaxInterval, the registration
> +                       will return failure.
> +
> +               uint32 MaxInterval
> +
> +                       Maximum advertising interval to be used by the
> +                       advertising set, in .625 millisecond slots.
> +                       Time = N * .625 ms, where N has range
> +                       [0x000020, 0xFFFFFF]. If the provided MinInterval is
> +                       larger than the provided MaxInterval, the registration
> +                       will return failure.
> +
> +               int16 TxPower
> +
> +                       Requested transmission power of this advertising set.
> +                       The provided value is used only if the "CanSetTxPower"
> +                       feature is enabled on the Advertising Manager. The
> +                       provided value must be in range [-127 to +20], where
> +                       units are in dBm.
> +
> +
>  LE Advertising Manager hierarchy
>  ================================
>
> @@ -209,3 +236,26 @@ Properties byte ActiveInstances
>                         Possible values: "1M"
>                                          "2M"
>                                          "Coded"
> +
> +               dict SupportedCapabilities
> +
> +                       Enumerates Advertising-related controller capabilities
> +                       useful to the client.
> +
> +                       Possible Values:
> +
> +                               byte MaxAdvLen
> +
> +                                       Max advertising data length
> +
> +                               byte MaxScnRspLen
> +
> +                                       Max advertising scan response length
> +
> +                               int16 MinTxPower
> +
> +                                       Min advertising tx power (dBm)
> +
> +                               int16 MaxTxPower
> +
> +                                       Max advertising tx power (dBm)
> --
> 2.28.0.709.gb0816b6eb0-goog

Please mark these as experimental for now, other than that it looks good to me.


-- 
Luiz Augusto von Dentz
