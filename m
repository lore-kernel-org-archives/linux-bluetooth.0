Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02744C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE082076C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5WK8boW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgHKS37 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKS37 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 14:29:59 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89953C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:29:58 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id a6so2827066oog.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fdxJyK64IhcdH2atTzNBdhDwAuEzjFER0OJtA1BgZGU=;
        b=m5WK8boW+6IbhXIHo3CNYA+M96rVERn6X6w64V9YEdEyOnFLUas6hDWPHx28tLp3uF
         QmPBxju5QNM2ghp1MHppYx535jP0ZXyEJ3Qmn54Mde+eNDBf8+nQXFJ+AKxwPkvobEue
         JTWIMygE5WpfDxOFbUYF37UrfQmKFekWUrwbiP6eNqAGkP6NYaKtPftE9pygzsdslGfo
         thRrKQQ5e1d9VKKlEnlkW+GNybbyRkqIhUNjEyHuEeZJjBSOw0Tdv9q2GfNxC/+FBYci
         gJXzQPVEhroCUMYkp8Zr6dWemmV2slCDHgBRW3p77g9SY80/fkix9kTWb5QwltcJ3T9h
         iC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fdxJyK64IhcdH2atTzNBdhDwAuEzjFER0OJtA1BgZGU=;
        b=K+59l8zFPdINpMM5Odifrp66b2FOVG3MgaFUhtEJtWYxo2zwXv4Bvzr32tvVzIVTs3
         IosBUTBmu01pc1KP9BcY1jfb2adbjbbgUWOg5vstlSxuYbv15w1+2eR13BIU5h4LAZ3O
         taquKRz5Pf1orFEsX5Yjp7LBxYgIVBdDX5etJu3k/cXDPgz1OGu5VHFwcpusXBUft196
         TTqU7J9Lf+0Hyn4cNvDqoanlmPySatAKRmVgkBRy7g4CrHqgdhe5FjoYcmLemyvp5cH7
         YlE2u2wQ5mcbhBxV34flGVH3fUAolOlTI7N4CSjsoM7AR2O1nYYORZLOzwIC/+lMNRzi
         uYVg==
X-Gm-Message-State: AOAM531p0yRAz3itPEksyOyGxjSkLtByQw6oD98Sg/GNrnsYlrhthcau
        X/RXkvEdqOaPSvO1elxR/r/iln1A+1ytasy/lBQ=
X-Google-Smtp-Source: ABdhPJyEmusZ1QL77ZM5y7NLzbqmJIdQY+gxs7gy82GQZvVYGpAoeCa+gj8D4r4+59TauPAfW4S09gfEQTmvANUe0lo=
X-Received: by 2002:a4a:380b:: with SMTP id c11mr6433608ooa.17.1597170597877;
 Tue, 11 Aug 2020 11:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200808193026.29007-1-pali@kernel.org>
In-Reply-To: <20200808193026.29007-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 Aug 2020 11:29:48 -0700
Message-ID: <CABBYNZJGQ26oiOqeGyUBvOPSzTWGuJpTumuzq+MPyiLzMkj4HQ@mail.gmail.com>
Subject: Re: [PATCH] sbcenc: Remove duplicate check for num of channels
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
>  src/sbcenc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/src/sbcenc.c b/src/sbcenc.c
> index 2a4c240..6f8d794 100644
> --- a/src/sbcenc.c
> +++ b/src/sbcenc.c
> @@ -142,7 +142,6 @@ static void encode(char *filename, int subbands, int =
bitpool, int joint,
>                                         blocks =3D=3D 12 ? SBC_BLK_12 : S=
BC_BLK_16;
>         } else {
>                 if (BE_INT(au_hdr.sample_rate) !=3D 16000 ||
> -                               BE_INT(au_hdr.channels) !=3D 1 ||
>                                 BE_INT(au_hdr.channels) !=3D 1) {
>                         fprintf(stderr, "mSBC requires 16 bits, 16kHz, mo=
no "
>                                                                 "input\n"=
);
> --
> 2.20.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
