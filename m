Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD12C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23F82076B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjcmiJT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgHKSa3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHKSa2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 14:30:28 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579C8C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:30:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u63so13139778oie.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bRl+N2lUAUG3eTPKJF5TH+I9ukhRa38Y8HEJ3262t1w=;
        b=gjcmiJT41mgveIIu4ovS/fBlYB3ML/Qyu6PCXKc6P7yYQK5+wxaLYyz/mag1ZqS81z
         TTAViQhBpqvkHZRbslXnqmJ/p4d6MDhcjiNOmVMRHg2tCza0/QCGASWQ8rpui+h4Te30
         v9/05Odn/wRc1VxbNRxCBlyIMEn13L3PwWb4Cl9TjxZ2bAvgVCi9jl537Kk5jKI7ZS7Z
         pNedzYOuVpt3/k9irXUV+VL0wudKW6J32AkqdyuT9WdbXWj2Rz0xh0kpKrTInQwLE0zh
         3bQcsLK94cbkmvzVoz6EH42wIVWagqr9QpOA8delYjBeCj4hgptLmkXqcBPMsT77sqTM
         px7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bRl+N2lUAUG3eTPKJF5TH+I9ukhRa38Y8HEJ3262t1w=;
        b=U6LPhi2JyiC5oNXb0kPavEZhLhGXk7zUzX6iIe25ubqX41xl3TYAB4VKZazQE1FKTb
         F7LusTf0tWitTTdgLd4vvh4rEs851aurr4/pVk3tV6ipt1FcpTPuY/Nr/uMvvn+43fzs
         rp9IyBJjvxGq7DYKRZ3LpKlD7J2AydsZAuEQlysXisg8dyHbOjaZwWDvDeyEJm/ZWCbE
         cyrjAEALP/R28p/o/obo+vpxghLxI61wKlC2S0rYmiMg/pJJ759Ojb/qVyoRjLh009x/
         lB7lJNDsfLpNimKZ3Ep3MNaJlKn00CBn+bUOxn/PZ+x+6NYBbDCLgmnKEvW33XrxfKtA
         yLMg==
X-Gm-Message-State: AOAM532WQRGg9tezJZX7pKaR48s5zMXyL3mzWv+h5nzVI2NuLyyAH7H1
        UxHfzfSAl/3vmsG2jlpCYPa1E432Wdv9hz3IxwYS0Q==
X-Google-Smtp-Source: ABdhPJxvIYkebtSCWjLpCApcjIoOySUdddnoJ/R/GdfBt9yFL+2v0M/Nt76o5/pj/KJQxWVfnFtJZxy/qy0bShSGNlc=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr4408361oig.152.1597170626544;
 Tue, 11 Aug 2020 11:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200808193014.28951-1-pali@kernel.org>
In-Reply-To: <20200808193014.28951-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 Aug 2020 11:30:16 -0700
Message-ID: <CABBYNZJ0+frWpUWE3J+T+KfobesCnfpmskfOZRO0Lt3rFSfhRw@mail.gmail.com>
Subject: Re: [PATCH] sbcenc: Add missing error check for unsupported sample rates
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sat, Aug 8, 2020 at 12:34 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  src/sbcenc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/src/sbcenc.c b/src/sbcenc.c
> index dabdff4..2a4c240 100644
> --- a/src/sbcenc.c
> +++ b/src/sbcenc.c
> @@ -105,6 +105,10 @@ static void encode(char *filename, int subbands, int=
 bitpool, int joint,
>                 case 48000:
>                         sbc.frequency =3D SBC_FREQ_48000;
>                         break;
> +               default:
> +                       fprintf(stderr, "Unsupported sample rate %ukHz\n"=
,
> +                                       BE_INT(au_hdr.sample_rate));
> +                       goto done;
>                 }
>
>                 srate =3D BE_INT(au_hdr.sample_rate);
> --
> 2.20.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
