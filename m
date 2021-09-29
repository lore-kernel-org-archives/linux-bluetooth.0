Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A712E61440
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbhI2SGR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245613AbhI2SGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 14:06:17 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A04C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:04:36 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id w68so1570700vkd.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcgcUtbzHBFzQhR+MKrXyKi/+UexpoNsz6JWc5VdqA0=;
        b=mS/RNp7DMxCmejhmdm3LIRgj8zWEQ/NuB0tkMCmlnbVXpr6DDSwPU8TM/WyTqug8cn
         Yng8FFhllZzKJJUcGqsZHj0/9w+Z2EwOCzVwFIZOgfKH98b7JDb0EdnZ2oUw0U7WgdPC
         r88i4mc1WYK/5D14O16kmOva7motn2WxMp9eeQs7A8Q8X6qUQ/CW/vGdWaA81zuQuG1j
         hnPS4vTOcJTxMLVZxkXnEvbdVzkMZBQvJVZvovlj6DIHq9GaOxz2Omdd5b/EHSp6ak4w
         1ZueOl8itYsnAamHytFr4pkNOYUSyod8euIbdIRfHwYXO7PsA4YigGc1oXJLQdH5+TTb
         iE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcgcUtbzHBFzQhR+MKrXyKi/+UexpoNsz6JWc5VdqA0=;
        b=Djy5G1cIXWghfsJxZKSOHsXx+MRqirprogInS/4Ka9fcXWud3+jJ7upIxe23XMd4hP
         ea6gSCsEmJtVVcPKXBjwui/Ydu8qlF1tg8EIGQ1D8xBl6MOJ2a8Nf0shRvbZkhdfI4gm
         osOhTju0RUXS2wrgty1HXAkIce/zGVnTLe0istDq62EOe6KiusH1/pBBjzDylu2Ru4kO
         NFaB1OMPWrV5ugZJ9S3l9zP9KHsSptpkh5LI+Npja37TEbeiA1TpMD/8irbVIP6SO68A
         Uj9I5LXDDyMUWRRwhLewcFIkvfegZCEWNW62X5oSIoG4I9z0TUnA212WgdDf1Qlu4GZb
         g5xg==
X-Gm-Message-State: AOAM532fHe6McDt+MYJzgmJcP68o9QVYNEMQMChJh3PlUckT4N+/+8SX
        PiytOAWWSoTI9DtO6QLa8baDOIlFAaKgib1qjY7QhasoNc8=
X-Google-Smtp-Source: ABdhPJzd+OQgsvIgEgyP1I94r91UXFKK28b6fS9Tt6mRDRULA9StnppIllRDR7JXkomRr1hi0qQ9t4G6QkVNSEQ0q0o=
X-Received: by 2002:a1f:5c95:: with SMTP id q143mr1172432vkb.4.1632938673764;
 Wed, 29 Sep 2021 11:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210929161656.413300-1-dmartinez@starry.com> <20210929161656.413300-3-dmartinez@starry.com>
In-Reply-To: <20210929161656.413300-3-dmartinez@starry.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 11:04:19 -0700
Message-ID: <CABBYNZ+8SS1L14OnQ9H_N5SL9fg5O4-LgAP+_dHxCtp=MG4M5g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] doc/gatt-api: Add 'X-asynchronous` permissions
To:     Dagan Martinez <dmartinez@starry.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dagan,

On Wed, Sep 29, 2021 at 10:42 AM Dagan Martinez <dmartinez@starry.com> wrote:
>
> Update docs to reflect the addition of `X-asynchronous` permissions,
> which allow a GATT server to restrict CCC write permissions via
> permissions set on its associated characteristic.
> ---
>  doc/gatt-api.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 04789c6d3..2550510ba 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -253,7 +253,13 @@ Properties string UUID [read-only]
>                         Defines how the characteristic value can be used. See
>                         Core spec "Table 3.5: Characteristic Properties bit
>                         field", and "Table 3.8: Characteristic Extended
> -                       Properties bit field". Allowed values:
> +                       Properties bit field".
> +
> +                       The "x-asynchronous" flags allow a characteristic to impose write
> +                       restrictions on its client characteristic configuration descriptor,
> +                       if applicable, restricting access to notifications and indications.

Don't really like the asynchronous name, it doesn't really reflect
what we want to accomplish.

> +                       Allowed values:
>
>                                 "broadcast"
>                                 "read"
> @@ -267,10 +273,13 @@ Properties        string UUID [read-only]
>                                 "writable-auxiliaries"
>                                 "encrypt-read"
>                                 "encrypt-write"
> +                               "encrypt-asynchronous" (Server only)
>                                 "encrypt-authenticated-read"
>                                 "encrypt-authenticated-write"
> +                               "encrypt-authenticated-asynchronous" (Server only)

I think for CCC we may just inherit the read/write permissions, or
have it as encrypt-notify/encrypt-indicate, etc.

>                                 "secure-read" (Server only)
>                                 "secure-write" (Server only)
> +                               "secure-asynchronous" (Server only)
>                                 "authorize"
>
>                 uint16 Handle [read-write, optional] (Server Only)
> --
> 2.31.1
>


-- 
Luiz Augusto von Dentz
