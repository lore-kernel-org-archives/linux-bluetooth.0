Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B601C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 18:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiFMSiH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbiFMShy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 14:37:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB8A13F19
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 08:39:13 -0700 (PDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 596BD3F210
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655134751;
        bh=qIyjHtlgmZ2mGqkFBQdbyeKZViSqALiGs38sp6wvC98=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hhHS9wDWo1T9emOiQdZR2fVXZEHA+VXzYtoFnKfticEc/tHOBat/vtYjbgmiUUh0y
         awfmyrhnFMGQWX2KTL9OgvUPQp+UfF7KRECmbN1YFHG9N1Y2cWByTR37Gf9hcGl798
         cdsyQRryMMmcsC4566uGX2i8F0ioQV1cjbJYIhcE7tlxJd2NBQ/qJ1NpM1ggBQBHs1
         QCtbCyTfDPUdQbNHuPgVijITEAXqGl+YEVO9ZUvGMamEcG9Mw5SiOzJ6HDzwqSUhhy
         blOgDukk0xa7OfO0gEfJ7HT1Ng66yYyfhW6xijBqujtlEbOgqesXjcOjH6wpHs1Eru
         ALNT28DOWg4jw==
Received: by mail-il1-f197.google.com with SMTP id i18-20020a926d12000000b002d1b13b896cso4815501ilc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 08:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIyjHtlgmZ2mGqkFBQdbyeKZViSqALiGs38sp6wvC98=;
        b=psHFG18M0/mh491lRNYhJOGFRLNvS4T7vjWgAD75Mj/FgoSgFYsuixicNmxw/V93NA
         C26eBXQPLcFjwXhCGfIkyZdnxK3c0XXtbIuT5dU5QDvlfEYgD6fm1j0hD9m2Xwl1a3im
         v7Tw+4M27tkcRWXU7tlyrsFqf90POaOEr1ZqYXKPTd5wJf/HprAdlrsJpnm0BII35J2v
         78vtQaIIMDdu8hs/aBfwNiBkQaNCF0YUGnxm1Lf9OhTsMm/rUWJYUrl5QN4424zoHCVQ
         +KOumk9LzOOGEzAZ5HfYf8NaPwVspBtNT2ELR2amPIFq71K4i3ioQRnQXNdN5mbdvb04
         sPzg==
X-Gm-Message-State: AOAM5318aoevbqgLJMNXYypPyZL6nOFfCH8Iqjeq88zRJPuoXli97B4m
        7PgvnPydR2hPtzxTckQS/WIFzoH82XO0blKwSDu27RM+66igxIb7gtcN9RiImHeCLfgl9St0sB8
        +svqHOpA3iS8gyrdl2Z8ADP/cVTXkXr1LaHh5Mc2u62r0tezBcoukRBSmOWtJ9g==
X-Received: by 2002:a05:6638:144d:b0:332:fa9:28a9 with SMTP id l13-20020a056638144d00b003320fa928a9mr201874jad.237.1655134749715;
        Mon, 13 Jun 2022 08:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXNtA+ciI6OWgaT4ebrOdHTZuUKQ3+cRYrYw1j3M7psuLRVjd2hmONX/3HkZzlJ0grCgnTwnE68cXxcjLf3ns=
X-Received: by 2002:a05:6638:144d:b0:332:fa9:28a9 with SMTP id
 l13-20020a056638144d00b003320fa928a9mr201863jad.237.1655134749505; Mon, 13
 Jun 2022 08:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220516103329.516952-1-dimitri.ledkov@canonical.com>
In-Reply-To: <20220516103329.516952-1-dimitri.ledkov@canonical.com>
From:   =?UTF-8?B?RGltaXRyaSBKb2huIExlZGtvdiDwn4+z77iP4oCN8J+MiA==?= 
        <dimitri.ledkov@canonical.com>
Date:   Mon, 13 Jun 2022 16:38:33 +0100
Message-ID: <CADWks+ZBZo1OQyV4wwx9=tnXa4Vn+KVNpQyAZq7HULJmO1D97A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Correctly declare all module
 firmware files
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

Does this v2 patch address the concerns you mentioned in your review
of the v1 patch at
https://lore.kernel.org/linux-bluetooth/3EA82A93-D167-482D-AAF4-D781B77A4646@holtmann.org/
?

Or can you explain a bit more how I misunderstood your request?

This patch correctly documents the strict patterns of dozens or so
existing firmware files which this driver can load for each of the hw
variants.

On Mon, 16 May 2022 at 11:33, Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:
>
> Strictly encode patterns of supported hw_variants of firmware files
> the kernel driver supports requesting. This now includes many missing
> and previously undeclared module firmware files for 0x07, 0x08,
> 0x11-0x14 hw_variants.
>
> This especially affects environments that only install firmware files
> declared and referenced by the kernel modules. In such environments,
> only the declared firmware files are copied resulting in most Intel
> Bluetooth devices not working. I.e. host-only dracut-install initrds,
> or Ubuntu Core kernel snaps.
>
> BugLink: https://bugs.launchpad.net/bugs/1970819
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>
>  Changes since v1:
>  - encode strict patterns of supported firmware files for each of the
>    supported hw_variant generations.
>
>  v1 submission link
>   https://lore.kernel.org/linux-bluetooth/20220509163259.1513242-1-dimitri.ledkov@canonical.com/
>
>  drivers/bluetooth/btintel.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 06514ed66022..17022758b5bd 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2654,7 +2654,22 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
>  MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
>  MODULE_VERSION(VERSION);
>  MODULE_LICENSE("GPL");
> -MODULE_FIRMWARE("intel/ibt-11-5.sfi");
> -MODULE_FIRMWARE("intel/ibt-11-5.ddc");
> -MODULE_FIRMWARE("intel/ibt-12-16.sfi");
> -MODULE_FIRMWARE("intel/ibt-12-16.ddc");
> +/* hw_variant 0x07 0x08 */
> +MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
> +/* hw_variant 0x0b 0x0c */
> +MODULE_FIRMWARE("intel/ibt-11-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-12-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-11-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-12-*.ddc");
> +/* hw_variant 0x11 0x12 0x13 0x14 */
> +MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
> --
> 2.32.0
>


-- 
Happy Pride,

Dimitri
