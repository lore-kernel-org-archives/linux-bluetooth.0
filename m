Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C40C3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 23:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2FF206A4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 23:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHzbO6Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgEDXjf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 19:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEDXje (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 19:39:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE58C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 16:39:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j26so152006ots.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UjmIGecejNQeR2VrEVCg1PmfwxYsH2z936uF8rTB8X8=;
        b=NHzbO6Ixan8IDKEPche5hU5H5fTHj6/BCUk+fFLvgxZhlxUo/NI7SHsawF8sVffk+/
         CEUK+JNwv/rQufttlL67SNRvkQlrOgixGNdFV+Dydw9rtmbSZ5/SfglKhIhIeVZ/VJxX
         tQ3CxnVKgj2MllzQw8rmAXYeH98UnZtX80T/jgxnqUiFNEMTc73eEKFc8ikSSm5VQZoy
         FB78R0KTKxWZgs/RlhkyBOOkAZsrsmX3iybn9Fb31VHzBiVKswakKVnjttz/fJVPDY/Y
         BlU1fF888k3LYDvvuTE8g+d7v2MiJQHVYeF3CSjST8A2cJvW8Fsbh8AWoGVcGAynC6Xw
         wiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UjmIGecejNQeR2VrEVCg1PmfwxYsH2z936uF8rTB8X8=;
        b=Y+QzKSdapTNxUd3rGWItSw5jPb3/ghTU/r+IQRrL+XmN6eaOSTaQ16yV14DuPjmPuj
         x/T/YDsF9FxWN788JAwM66mdg9cequb2C8GlKyoGHWre35PCDfIC1FoZvqFCgjqf2jsS
         x6V0wEenE4aWNOCjWnU126lZogd9l9x1oGVPscFhqZwtqzk/1mlC1HhQYd2qkWoc8ye+
         avorOQ9y3GtM2f0JJm42nOJqhS3v+Ibj796f1g6pyFPbgiBPlO1oK9gRZdqRyFnTvqhj
         AfQV5EYpAebx9/TCO/nFfYPkXAKL3OtYka7pHgIHFS/aTatiiiPmAJ/DzTLPtx2DbAQs
         sx+w==
X-Gm-Message-State: AGi0PuYKW4H69dHbv1yz9zSdEpX8o6PN/sLqjN2kLpvjjJLi479m35+n
        nG80KNp/RuwHf65gybkvWeVR5Lu0/zYpdoU/vnk=
X-Google-Smtp-Source: APiQypIeVZ0DEtEBWlowVrt4DgXtsaLjaZLEMAtAUaNq1OGwl/s87lYKMOEYJKQH3ks1Hsx7KpKZyH6Vzx8fgGrhZjQ=
X-Received: by 2002:a9d:3637:: with SMTP id w52mr75861otb.177.1588635573917;
 Mon, 04 May 2020 16:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <5ea9d716.1c69fb81.92030.0ba2@mx.google.com> <20200503110629.11068-1-pali@kernel.org>
In-Reply-To: <20200503110629.11068-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 May 2020 16:39:22 -0700
Message-ID: <CABBYNZ+5JsazyZUZHqS0B9LF3Mjs3Ly1kbEDFMQ2m-Y9d6eHLA@mail.gmail.com>
Subject: Re: [PATCH v2] a2dp: Check for valid SEP in a2dp_reconfigure
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, May 3, 2020 at 4:06 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> a2dp_reconfigure() is called as callback when local and remote SEP does n=
ot
> have to be valid anymore, sep->lsep can be NULL.
>
> This change fixes bluetoothd daemon crash (dereferencing NULL sep->lsep)
> when audio agent disconnect in the middle of the reconfigure call.
> ---
>  profiles/audio/a2dp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index c31aaf187..a2ce3204d 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1178,6 +1178,12 @@ static gboolean a2dp_reconfigure(gpointer data)
>         struct avdtp_media_codec_capability *rsep_codec;
>         struct avdtp_service_capability *cap;
>
> +       if (!sep->lsep) {
> +               error("no valid local SEP");
> +               posix_err =3D -EINVAL;
> +               goto failed;
> +       }
> +
>         if (setup->rsep) {
>                 cap =3D avdtp_get_codec(setup->rsep->sep);
>                 rsep_codec =3D (struct avdtp_media_codec_capability *) ca=
p->data;
> @@ -1186,6 +1192,12 @@ static gboolean a2dp_reconfigure(gpointer data)
>         if (!setup->rsep || sep->codec !=3D rsep_codec->media_codec_type)
>                 setup->rsep =3D find_remote_sep(setup->chan, sep);
>
> +       if (!setup->rsep) {
> +               error("unable to find remote SEP");
> +               posix_err =3D -EINVAL;
> +               goto failed;
> +       }
> +
>         posix_err =3D avdtp_set_configuration(setup->session, setup->rsep=
->sep,
>                                                 sep->lsep,
>                                                 setup->caps,
> --
> 2.20.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
