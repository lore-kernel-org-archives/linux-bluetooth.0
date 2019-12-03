Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76AFC432C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831AE20637
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPNOBsyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLCRSS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:18:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40055 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLCRSS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 12:18:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id 6so4011178oix.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Dec 2019 09:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGxtGP8voKgU9fYCA479kMrPwTdulBu32ubWXM36jXk=;
        b=FPNOBsyv0x85z4sHCsXDeFBehPs0lkuQUyweVWDNu9oVwBBG76MPabxjKBmr5diw7f
         FWjZ/p6j5JLd9gl13eVAcRo/RCHpfTgsMOjE3R4zS5x1rjIerYgBtGKKSMGVawf6u+dk
         5YP/prOt3Xm89IYRd6sqzOhLNDFBobV/Zi7GNtr3aGcl95tkQnTcL4ctLm0mdwCDcobv
         5MvW7JrxJJFWWL2WOQIDFaY9qlgtnM21+ketZ3sfXPcSH8vKL3ylbhJWYl9+6J00xibZ
         qDzox9zyoDJPjJT8xRH1PrMDrP1Pl2h563+APgrLaAyxtAFaZV/MwFezeW6KeZamxu8T
         NhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGxtGP8voKgU9fYCA479kMrPwTdulBu32ubWXM36jXk=;
        b=cQcpRI2OPUSe1ia6/wYd9qinSjt94hpiSU+jpoXHFUOmacYe/7N2Nkq925UooTKDwj
         gQm+P0zAyY/G/+sjHedllfsesEC8aMg8mwZB9jKXOrShAOV/1VkKC9tpIBhG/jgF6i/o
         C1zMbcZUrFi5RCu2mx2FX17Wpo5vphkCMBdoI44zFjj2ECVKFUETNYItsxSm0Ui/vuHU
         2cwPP+tnTIMpCSkpDnFyyDYnW7scuChHutljAeRXJP47LUc8A9x3pGUKllO/bb6AL5Xi
         mX8tOxmU8nhPSmTz+MljJLP7AbghdrouM4pUpkb7THINyjIJx424rTQ94WPRYN4zWVcy
         7w9g==
X-Gm-Message-State: APjAAAUPXNcJMqRqY4NlombrllF/8/dCZ3EOw1YbjhyTSgqeugO8nUiS
        Nuwzg6xUt7vv3YJWbskmOWbgCkMAzfmzg4y1loU=
X-Google-Smtp-Source: APXvYqxiOkM1hP+rao3v+Djki7JTZeEaDN9d6+XssRajPsFpPiLWCH6e2DBTBu4NWoMIUxeyEm18jP/Mtc4/8gih8pQ=
X-Received: by 2002:aca:d904:: with SMTP id q4mr4612384oig.21.1575393496763;
 Tue, 03 Dec 2019 09:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20191203010400.216538-1-abhishekpandit@chromium.org>
In-Reply-To: <20191203010400.216538-1-abhishekpandit@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 3 Dec 2019 19:18:03 +0200
Message-ID: <CABBYNZLbNrsK3KNyKeCQbLY5q_Bo9smRn0RyYG8iwKD6GGMmiA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 1/4] lib: Add ba2strlc to match kernel printk format
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Tue, Dec 3, 2019 at 3:04 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> When the kernel prints the bluetooth address (via %pMR), it prints the
> address in lower case. ba2strlc should be used in cases where we should
> match the kernel casing (i.e. addresses assigned to /dev/uhid and
> /dev/uinput)
>
> ---
>
> Changes in v2:
> - Split into its own commit
>
>  lib/bluetooth.c | 7 +++++++
>  lib/bluetooth.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/lib/bluetooth.c b/lib/bluetooth.c
> index effc7f49d..7cba509d8 100644
> --- a/lib/bluetooth.c
> +++ b/lib/bluetooth.c
> @@ -81,6 +81,13 @@ int ba2str(const bdaddr_t *ba, char *str)
>                 ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
>  }
>
> +/* Match kernel's lowercase printing of mac address (%pMR) */
> +int ba2strlc(const bdaddr_t *ba, char *str)
> +{
> +       return sprintf(str, "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
> +               ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
> +}
> +
>  int str2ba(const char *str, bdaddr_t *ba)
>  {
>         int i;
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index eb279260e..756dce164 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -325,6 +325,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
>  bdaddr_t *strtoba(const char *str);
>  char *batostr(const bdaddr_t *ba);
>  int ba2str(const bdaddr_t *ba, char *str);
> +int ba2strlc(const bdaddr_t *ba, char *str);
>  int str2ba(const char *str, bdaddr_t *ba);
>  int ba2oui(const bdaddr_t *ba, char *oui);
>  int bachk(const char *str);
> --
> 2.24.0.393.g34dc348eaf-goog

Applied, thanks. Note that I did change a little bit the code in
uinput_create since strncpy generates some warnings with gcc8 see:

https://developers.redhat.com/blog/2018/05/24/detecting-string-truncation-with-gcc-8/

What I did was to assign '\0' after the use of strncpy otherwise it
would generate warnings, also replaced the use of strncpy when we know
it would not need to be truncated.

-- 
Luiz Augusto von Dentz
