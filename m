Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EC4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 21:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AFD61BCF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 21:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhKQVMi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 16:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhKQVM0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 16:12:26 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0B0C061766
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 13:09:27 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id b17so9050508uas.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 13:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oP7Gke3bRNKjvuP76mtf/Tx2Sv58m7aZSWkQHCFbMlw=;
        b=o/KHBuVUgB6yTwp5CIbMCVW1ZqmYMCurtrGNIwKKIaUxXpOhNb2gJX7E1uaglUVAyK
         aZgXv1hHrjTJhgTxZMjC/w1O/9A06vodvbvEQ11fpkrLMefMC0bWd+Tw3CbdWnVcmsb9
         cC+Fk9qLJJR6e63gFOMTJJVEYQlo8dCUq+aVF1jW7LgL+Qts0Ii60zTyDZ+pU5zCnXry
         DtoiT/t8W/S7GwbQC5hp7EIH54J0v+7EA0Jx+du7yVcqTceCr5e0gSqyiClKUQPjsl0g
         X7GY42uWHDC6FEHsUngy/R4I2Glo+TGil8pkZviGkjL1JCK47gnaEkPXRvbgat5+EdEy
         OXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oP7Gke3bRNKjvuP76mtf/Tx2Sv58m7aZSWkQHCFbMlw=;
        b=kcrgdcmF5m502uAlTTkzNAoWZq83oEIYFLLM3iurZjw+Cllpu4YbYcpDT3VpOno0qW
         b0aHIuOWrcJ/oC4eV5QYmXe2U6YdyOrAlcs8KdFXVkai2ij9IyysWkCL/4bF781qtoWs
         RjFox+Cp5xddgxiqn6gcjbuQ5EFt7iIugDm4jZLhG0NcYimCsjTHbAx1rOTfj23m7dNA
         lUe/4TQET/ojCjXB64Mh2XuMVDALStjoUqppnPxVTKC5Yc77l+ZPYoB+ntb8kIa2b0F9
         03VmHIxC7pU7PIml72Px/Ey3NQPx2FXqqp3fc2N0wQWohfcvn9uEwXmMUi8O5NiZIQSd
         3Qlw==
X-Gm-Message-State: AOAM533rVaikC4GolgLHX5cDL7b+DdBdPOi9Snz4QTFTtEk0TFTpFAw1
        MglXx+8O/VbQokJBJOmaKGUQu24XEbEPL8jZX+8mZmCc
X-Google-Smtp-Source: ABdhPJwDjNZLEEfsz3SEW5puzQcy+gAvzoMhQ4ofWCT4NR2rRuFJqkcqrz+qhHxcFFxnJJ1NMQ+cZ/4We0kDaLPdHss=
X-Received: by 2002:a67:fd90:: with SMTP id k16mr72228923vsq.39.1637183366648;
 Wed, 17 Nov 2021 13:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
 <20211117110627.BlueZ.v5.6.I363090b80e59a3cda134c9bd2df0b3bca2cb527b@changeid>
In-Reply-To: <20211117110627.BlueZ.v5.6.I363090b80e59a3cda134c9bd2df0b3bca2cb527b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Nov 2021 13:09:15 -0800
Message-ID: <CABBYNZL994EW-=6xrknc3LK0sRv4pv7OReKiWzC3eF54MBK0xw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 6/6] core: Update default advmon Sampling_Period
 to 0xFF
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Wed, Nov 17, 2021 at 11:15 AM Manish Mandlik <mmandlik@google.com> wrote:
>
> Update default Advertisemet Monitor Sampling_Period to 0xFF. It
> indicates that controller will report only one advertisement per
> monitoring period for a device. This will help reduce the power
> consumption drastically.
>
> Reviewed-by: Miao-chen Chou <mcchou@google.com>
> ---
>
> Changes in v5:
> - New patch in the series. Update default Sampling_Period to 0xFF.
>
>  src/main.c    | 2 +-
>  src/main.conf | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/main.c b/src/main.c
> index 5ca8d5644..1f852fdf6 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -932,7 +932,7 @@ static void init_defaults(void)
>         btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
>         btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
>
> -       btd_opts.advmon.rssi_sampling_period = 0;
> +       btd_opts.advmon.rssi_sampling_period = 0xFF;
>  }
>
>  static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
> diff --git a/src/main.conf b/src/main.conf
> index e05291d8e..e49259453 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -260,5 +260,5 @@
>  [AdvMon]
>  # Default RSSI Sampling Period. This is used when a client registers an
>  # advertisement monitor and leaves the RSSISamplingPeriod unset.
> -# Default: 0
> +# Default: 0xFF (Report only one Adv per device during the monitoring period)
>  #RSSISamplingPeriod=0

While at it it would be good to explain what is the unit used here,
also it is common practice to have the default on the commented entry.

> --
> 2.34.0.rc1.387.gb447b232ab-goog
>


-- 
Luiz Augusto von Dentz
