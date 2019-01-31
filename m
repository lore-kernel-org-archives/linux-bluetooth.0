Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC826C169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 10:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EFA218DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 10:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxYcEyct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfAaKud (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:50:33 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39815 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfAaKuc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 05:50:32 -0500
Received: by mail-oi1-f180.google.com with SMTP id i6so2331297oia.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 02:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=an3n9uPYIbdMY8UEd4I2+NS6usCUM1fsKjauvRsI0Sg=;
        b=hxYcEyctguFEC97W1mBhMdHGo4ffEYsd3PZQxXSyXzKZADzeTbolDmahemr0LSCMPQ
         LMUqrMjbq6z520ZfWkGIuBwEtvG8Dm5T7/WesLm7jiRUranStg9O7c8+pH99KROli0MU
         pDFE1wfNdNINguq3y0EKyhVnOkT1+fNYA6LcGssRKWmlEcWdj3r6pr8kXA/bNeqD2Xsi
         1PWcclRgy7/sPfV4UPfWJLt0V1YwH0bcA7ZrMAQA9gL4iXaV0Tq68UNOLhXu1m3CWZBX
         KfEVlI1jrOojUh8MMUUGydqFBHWgicKLRlSMsH4O1g8hBT+4s/qMuhaavM8pp2UP7wsY
         R23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=an3n9uPYIbdMY8UEd4I2+NS6usCUM1fsKjauvRsI0Sg=;
        b=bhYrNC6hKMb0Ss/3KQ2o7cze1vVtj96Qe7tThVqahh5KjR4yhpFiJNgwvnGny4HU7G
         87jG3bESaiIMIv6TxERzRCRIpa7rMvnOGdTxAPTVnQEEvnDF1uPv6S6yqikDXvYnA4od
         Q1KgU3PwGrFRat7oOnsEz22ddVhomI2Ysi8JZyf2qj1om2Y6OlTfoKvnzde0ZGemcweN
         I8j4Kju2bwCdJizc9J6VVK/VfTTwAtsvRyuLrKCAQm7GfDUcFQ1F+17VQroKgDSuc40x
         HWa9XMGM+ewaTac8xkpKJ/QPVc20Nn8NfKRHVHmnqrTqkWEEpX3KjVQliJ0HrJnk4RKp
         dhjQ==
X-Gm-Message-State: AJcUukfmCRhtwQ4cIgFMhVOTLV5Klr3oTOZRmRvGvMGPUrzR5ooqjmL9
        eP3ntq47daCJathp0xt5ZBajdc0vvaZqxN354bDQMA==
X-Google-Smtp-Source: AHgI3IZOpAU+6eA0uZS+fAe+H2aiJ07032RFQJqYvTb+ufc4CaAlOPhrQh4oZToywX0QNiIdqguISAYcS/ZaSK/hIfg=
X-Received: by 2002:aca:47c6:: with SMTP id u189mr15348597oia.250.1548931830674;
 Thu, 31 Jan 2019 02:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20190126102450.23851-1-pali.rohar@gmail.com>
In-Reply-To: <20190126102450.23851-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 31 Jan 2019 12:50:18 +0200
Message-ID: <CABBYNZ+1B89KQxCUX59=kD1QMzE8iyM8vX_T9ps9ESuNfZBQ0A@mail.gmail.com>
Subject: Re: [PATCH] avinfo: Dump unknown codecs and unknown categories
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,
On Sat, Jan 26, 2019 at 12:26 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> ---
>  tools/avinfo.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/avinfo.c b/tools/avinfo.c
> index a3298e8c8..42f539f43 100644
> --- a/tools/avinfo.c
> +++ b/tools/avinfo.c
> @@ -648,6 +648,8 @@ static void print_media_codec(
>                         struct avdtp_media_codec_capability *cap,
>                         uint8_t size)
>  {
> +       int i;
> +
>         if (size < sizeof(*cap)) {
>                 printf("\tMedia Codec: Unknown (broken)\n");
>                 return;
> @@ -668,6 +670,10 @@ static void print_media_codec(
>                 break;
>         default:
>                 printf("\tMedia Codec: Unknown\n");
> +               printf("\t\tCodec Data:");
> +               for (i =3D 0; i < size - 2; ++i)
> +                       printf(" 0x%.02x", ((unsigned char *)cap->data)[i=
]);
> +               printf("\n");
>         }
>  }
>
> @@ -699,6 +705,7 @@ static void print_content_protection(
>  static void print_caps(void *data, int size)
>  {
>         int processed;
> +       int i;
>
>         for (processed =3D 0; processed + 2 < size;) {
>                 struct avdtp_service_capability *cap;
> @@ -715,9 +722,14 @@ static void print_caps(void *data, int size)
>                 case AVDTP_REPORTING:
>                 case AVDTP_RECOVERY:
>                 case AVDTP_MULTIPLEXING:
> -               default:
>                         /* FIXME: Add proper functions */
> +                       break;
> +               default:
>                         printf("\tUnknown category: %d\n", cap->category)=
;
> +                       printf("\t\tData:");
> +                       for (i =3D 0; i < cap->length; ++i)
> +                               printf(" 0x%.02x", ((unsigned char *)cap-=
>data)[i]);
> +                       printf("\n");
>                         break;
>                 case AVDTP_MEDIA_CODEC:
>                         print_media_codec((void *) cap->data, cap->length=
);
> --
> 2.11.0

Applied, thanks.

--=20
Luiz Augusto von Dentz
