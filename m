Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1DBC2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 00:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300632072A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 00:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRw/oz0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDGAQj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:16:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37275 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGAQj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 20:16:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id g23so1341160otq.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 17:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vH5WbHKuWBqtZnrxm5e0ptpN3/tK3bRHsJUE87/js8=;
        b=ZRw/oz0CzTrV0KcXTLayHJhRpkuR0n0922ssGcZreHLg4Gk5kiR8l5JjMAZhzI1cw5
         d+OdJqx9hnIqVdk+T2WJ4AAbFH6q9BYpj7pL4N72pOOmh1Bkezh8cxwix42eZhozG/rH
         gAhQz55cA2quRiSxBV/NzSmYlWDgA8pOTn5wG1BVxKl1BLIUfkAl/L6eq/oGuQfBmiDV
         zvqZSTVlQ7WQYbYYRp/Rs4XCoItWmlxzARyp2A9hZbwlQjZTaBYUG96riQr9ltciMiPV
         kPhjoIb/pG8mAiXSGPqB8fHfMzGC8s/XmMqHEK5Khba4uk/ktKa008dpEcJwSHsi4NsK
         n8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vH5WbHKuWBqtZnrxm5e0ptpN3/tK3bRHsJUE87/js8=;
        b=ZQ1+uf/6h1188YaXAFMwrz4T188Vt7K7mm6rkvLLm7YlSFPDR/rbAqqsBUtD8BBjq+
         Rgo8TKCwxyd1X4jqUS/TMDndwZnPBvp6WiHmTYab8YiLaOm4NYdfEtTor6a/vLi8w6AC
         zrQARmQKoBTmggdNjXUtKj36yyz6rsaZoeQbvbv1bd9tdMfhkUP775IjIjbFL8nomqOa
         Ap3LpFWoqvQz92qR8hLMj9ZOYdzGyH1JqIWhVwU4NvY7nvo2SQRlLAp8yfETEjVIoYos
         VciFZFFtTbAGSOYZuwi/LhGZmQucXDDaWAVa5V5l0auQSs60wB1RO6/YaEqsOYF9n6nd
         WDQA==
X-Gm-Message-State: AGi0PubyBwHSmeR756/imcSDYd3kQWWKRFl5MPRdPSmu9QmLZM9xEoPP
        Hu1uaZahfsD+OA34IaZjzRei8ZQjvWorobMbqfCO++qb
X-Google-Smtp-Source: APiQypIfyUuNx6+BxwT73KqIqWmboDN9RAvaZU9W5XMDn4waN2oOZo/JnyXcFrtKWI9d3uwWunP1ynMEqOULgIK4Hwc=
X-Received: by 2002:a4a:2cc6:: with SMTP id o189mr1476436ooo.20.1586218598763;
 Mon, 06 Apr 2020 17:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200406201410.11803-1-olivier@labapart.com>
In-Reply-To: <20200406201410.11803-1-olivier@labapart.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Apr 2020 17:16:27 -0700
Message-ID: <CABBYNZLyP5HWLwC_-9XBv3E11U_ZOvkmmqR8a2BVp4v6L7jaew@mail.gmail.com>
Subject: Re: [PATCH BlueZ] emulator: Fix command line parameters with optional argument
To:     Olivier Martin <olivier@labapart.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Olivier,

On Mon, Apr 6, 2020 at 3:45 PM Olivier Martin <olivier@labapart.com> wrote:
>
> Some parameters were missing the indication that additional
> argument could be expected.
> ---
>  emulator/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/emulator/main.c b/emulator/main.c
> index 68c53488e..3e32bf95d 100644
> --- a/emulator/main.c
> +++ b/emulator/main.c
> @@ -58,8 +58,10 @@ static void usage(void)
>                 "\t-s                    Create local server sockets\n"
>                 "\t-l [num]              Number of local controllers\n"
>                 "\t-L                    Create LE only controller\n"
> +               "\t-U [num]              Number of test LE controllers\n"
>                 "\t-B                    Create BR/EDR only controller\n"
>                 "\t-A                    Create AMP controller\n"
> +               "\t-T [num]              Number of test AMP controllers\n"
>                 "\t-h, --help            Show help options\n");
>  }

Actually optional arguments cannot have spaces in between the option,
that is why one need to do -L2 for example as -L 2 would ignore the
number, perhaps we should actually document the long version with
--le=2 which should probably be the prefered method.

> @@ -97,7 +99,7 @@ int main(int argc, char *argv[])
>         for (;;) {
>                 int opt;
>
> -               opt = getopt_long(argc, argv, "Ssl::LBAUTvh",
> +               opt = getopt_long(argc, argv, "Ssl::LBAU::T::vh",
>                                                 main_options, NULL);
>                 if (opt < 0)
>                         break;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
