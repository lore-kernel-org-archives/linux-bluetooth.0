Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF5AE81E07
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Oct 2023 15:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjJFPVs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjJFPVr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 11:21:47 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1959F
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1696605701; x=1696864901;
        bh=ON7ZqjhEcRQ3MXowqXGZHD79quHHAK5cE5iuqzkNAHw=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=PiB4rXCcBnPe9izaoLeH0fTUaQD07KqM0HgW9JE69xlRJ4zZK1gisw0PzIWRBt1/j
         X9hDWTvYpsJRCw2DPqG4ac/lkAx5YUlMMW/90Dtdqsk+9sdUUjs9JKTqE26U1xtVCX
         2ioE31sHKwIfebFZ+tb0WvVk34wclBiFa3HaHaqVyR1ZSuPhGzaTG+cFVV414/LhrD
         YMd+t2u2H7ssHtIIHH6z0AAwS4s4FPHvNHJtk/2VLzkhuy45qMLVJA0vURsiJTFbvU
         zZR4VMHKsSuTwCxGz+Ph1WBVJaP9eiGU9IpD+Ou0ggrsONAeXHf6HD0r68mvDjVllq
         t4xEkoUDO2n+w==
Date:   Fri, 06 Oct 2023 15:21:36 +0000
To:     linux-bluetooth@vger.kernel.org,
        Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH SBC 1/1] sbc: Fix mSBC reinitialization
Message-ID: <h3kjmy2E73AMMnudYd7oJUKOAJxhKXOQVYkWMqwpK_QiDyDzX4wRF-6s6mB1iIUgZnCQ3Tk8x9i8A-Bk5Z3RRQjYShU1nGmghyEwN5ia6Es=@protonmail.com>
In-Reply-To: <20230804192525.67067-1-arkadiusz.bokowy@gmail.com>
References: <20230804192525.67067-1-arkadiusz.bokowy@gmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi


2023. augusztus 4., p=C3=A9ntek 21:25 keltez=C3=A9ssel, Arkadiusz Bokowy <a=
rkadiusz.bokowy@gmail.com> =C3=ADrta:

> Commit 10310fb has introduced a function for mSBC reinitialization.
> However, it did not set msbc private flag, which is checked e.g. by
> sbc_set_defaults() and sbc_get_frame_length() functions.
>=20
> This commit fixes this, so now after reinitialization this library
> properly packs/unpacks mSBC frames and the sbc_get_frame_length()
> function returns correct frame length.

I would like to see this issue fixed. Is there any way we can move
forward? If there are any issues preventing the merging of this
change, I would be happy to address them if Arkadiusz has no time.


Regards,
Barnab=C3=A1s P=C5=91cze


> ---
>  sbc/sbc.c | 71 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 33 insertions(+), 38 deletions(-)
>=20
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index d059906..c35b564 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -1010,17 +1010,13 @@ static void sbc_set_defaults(sbc_t *sbc, unsigned=
 long flags)
>  {
>  =09struct sbc_priv *priv =3D sbc->priv;
>=20
> -=09if (priv->msbc) {
> -=09=09priv->pack_frame =3D msbc_pack_frame;
> -=09=09priv->unpack_frame =3D msbc_unpack_frame;
> -=09} else {
> -=09=09priv->pack_frame =3D sbc_pack_frame;
> -=09=09priv->unpack_frame =3D sbc_unpack_frame;
> -=09}
> +=09priv->pack_frame =3D sbc_pack_frame;
> +=09priv->unpack_frame =3D sbc_unpack_frame;
>=20
>  =09sbc->flags =3D flags;
>  =09sbc->frequency =3D SBC_FREQ_44100;
>  =09sbc->mode =3D SBC_MODE_STEREO;
> +=09sbc->allocation =3D SBC_AM_LOUDNESS;
>  =09sbc->subbands =3D SBC_SB_8;
>  =09sbc->blocks =3D SBC_BLK_16;
>  =09sbc->bitpool =3D 32;
> @@ -1033,6 +1029,30 @@ static void sbc_set_defaults(sbc_t *sbc, unsigned =
long flags)
>  #endif
>  }
>=20
> +static void sbc_set_defaults_msbc(sbc_t *sbc, unsigned long flags)
> +{
> +=09struct sbc_priv *priv =3D sbc->priv;
> +
> +=09priv->msbc =3D true;
> +=09priv->pack_frame =3D msbc_pack_frame;
> +=09priv->unpack_frame =3D msbc_unpack_frame;
> +
> +=09sbc->flags =3D flags;
> +=09sbc->frequency =3D SBC_FREQ_16000;
> +=09sbc->mode =3D SBC_MODE_MONO;
> +=09sbc->allocation =3D SBC_AM_LOUDNESS;
> +=09sbc->subbands =3D SBC_SB_8;
> +=09sbc->blocks =3D MSBC_BLOCKS;
> +=09sbc->bitpool =3D 26;
> +#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
> +=09sbc->endian =3D SBC_LE;
> +#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
> +=09sbc->endian =3D SBC_BE;
> +#else
> +#error "Unknown byte order"
> +#endif
> +}
> +
>  SBC_EXPORT int sbc_init(sbc_t *sbc, unsigned long flags)
>  {
>  =09if (!sbc)
> @@ -1056,33 +1076,13 @@ SBC_EXPORT int sbc_init(sbc_t *sbc, unsigned long=
 flags)
>=20
>  SBC_EXPORT int sbc_init_msbc(sbc_t *sbc, unsigned long flags)
>  {
> -=09struct sbc_priv *priv;
> -
> -=09if (!sbc)
> -=09=09return -EIO;
> -
> -=09memset(sbc, 0, sizeof(sbc_t));
> -
> -=09sbc->priv_alloc_base =3D malloc(sizeof(struct sbc_priv) + SBC_ALIGN_M=
ASK);
> -=09if (!sbc->priv_alloc_base)
> -=09=09return -ENOMEM;
> -
> -=09sbc->priv =3D (void *) (((uintptr_t) sbc->priv_alloc_base +
> -=09=09=09SBC_ALIGN_MASK) & ~((uintptr_t) SBC_ALIGN_MASK));
> -
> -=09memset(sbc->priv, 0, sizeof(struct sbc_priv));
> -
> -=09priv =3D sbc->priv;
> -=09priv->msbc =3D true;
> +=09int err;
>=20
> -=09sbc_set_defaults(sbc, flags);
> +=09err =3D sbc_init(sbc, flags);
> +=09if (err < 0)
> +=09=09return err;
>=20
> -=09sbc->frequency =3D SBC_FREQ_16000;
> -=09sbc->blocks =3D MSBC_BLOCKS;
> -=09sbc->subbands =3D SBC_SB_8;
> -=09sbc->mode =3D SBC_MODE_MONO;
> -=09sbc->allocation =3D SBC_AM_LOUDNESS;
> -=09sbc->bitpool =3D 26;
> +=09sbc_set_defaults_msbc(sbc, flags);
>=20
>  =09return 0;
>  }
> @@ -1095,12 +1095,7 @@ SBC_EXPORT int sbc_reinit_msbc(sbc_t *sbc, unsigne=
d long flags)
>  =09if (err < 0)
>  =09=09return err;
>=20
> -=09sbc->frequency =3D SBC_FREQ_16000;
> -=09sbc->blocks =3D MSBC_BLOCKS;
> -=09sbc->subbands =3D SBC_SB_8;
> -=09sbc->mode =3D SBC_MODE_MONO;
> -=09sbc->allocation =3D SBC_AM_LOUDNESS;
> -=09sbc->bitpool =3D 26;
> +=09sbc_set_defaults_msbc(sbc, flags);
>=20
>  =09return 0;
>  }
> --
> 2.39.2
> 
