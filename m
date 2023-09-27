Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98489E7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjI0V4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0V4J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:56:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1F9AF
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:56:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so191862641fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851765; x=1696456565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6guOrrhXeLWKmM6AnsqmdngKYCksYGWTsJMFqDK+iU=;
        b=kFx/bu5yO1noQXTxUkCRmCrbW0QRMDIVFRf1RJVxydqfCToL7RHWZdYg4dsH1XMNIi
         KhS6flwfG1pgl/mxIadVOLlpvfp3SxvZqA7C9YGsSUZQ+0ErUwrreQIqqoABfvwGcrHn
         Ea9CeQ9p1hJL4TCdgkHvkL9QDakwj5BJgO5Rj59PdBIZX2b2UG/p7MEMiwoGK/9UqlFn
         Ap3aYpvSVqcAnf1wtUgRmloZTh+rG84Gx49lyxTNwefz63cTIM0XzTnwov50p/qNBp9i
         i0cHQkxEkScOif4vfoZCjukDrw299/3FlhopCp1lrZ/bAi2H1X+TPGv3RC1gM0p0+HKF
         qfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851765; x=1696456565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6guOrrhXeLWKmM6AnsqmdngKYCksYGWTsJMFqDK+iU=;
        b=NgAvty6A3zLzseSxeNw3W60ztL9HIoHtYRK7qDaa0K8R7OerKapS/np0KlfCQTV6y7
         VaLXumV78GVpZR0iKfvc/BAdBL1suTF8B6HWpcD4Hl4HOAsY2/Kd1uu6BcrrjWbz7V93
         rzZ4Y//KMWwoPqHHvCXGxG4YmylrjbZofrZQu/kF1kGLEySn8251glVtRkERgqmPao1y
         hZ8HNgWRTLyuJvIqbACeNSjlwKZE/Eh8iUL83gQx9+DtHnGklSe5KEBMOJ/l2VLo/STJ
         E/lLbe3l9LHiN6BnAsBb6XLkOeDNwD2tXE79hfColEoG3tmKNq/ItQUBmZzq0FZ86SoD
         O1ZA==
X-Gm-Message-State: AOJu0YwoBcGB3fJvPDBJv/A9U+/tkAq13ZBbu2YV3ETQr42u9C+d5r6v
        eHstvSDCKzRvufCNE7NVPBbKgtIxGnZTIH4iLpIif+LXn524eFoS
X-Google-Smtp-Source: AGHT+IGAWQyRW4BBRTTCb/CKo+H/9mDzHxM7sc84h5ujWUjZg7d4lQBeIk3LMkIavASlaOrD5wZnjPrSj1EOsBahnfw=
X-Received: by 2002:a2e:9897:0:b0:2bc:ee89:6976 with SMTP id
 b23-20020a2e9897000000b002bcee896976mr2904350ljj.24.1695851764908; Wed, 27
 Sep 2023 14:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230927062436.6306-1-andrei.istodorescu@nxp.com> <20230927062436.6306-2-andrei.istodorescu@nxp.com>
In-Reply-To: <20230927062436.6306-2-andrei.istodorescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Sep 2023 14:55:52 -0700
Message-ID: <CABBYNZKG0zBFcdReZFCdMx_BLJKmO+Vbjy5XLzUfSzRBM7gPtw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] bap: Remove memory leaks and buffer usage after free.
To:     Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrei,

On Tue, Sep 26, 2023 at 11:24=E2=80=AFPM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> Make sure the endpoint does not contain uninitialized pointers after
> creation. Rework parse_base and parse_array. Add missing unregister in
> bap_exit.

Ive addressed something similar in the following change:

https://patchwork.kernel.org/project/bluetooth/patch/20230927214003.1873224=
-13-luiz.dentz@gmail.com/

> ---
>  profiles/audio/bap.c | 66 ++++++++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 27 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index ee90426b9812..b164f68d3187 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -278,16 +278,17 @@ static const GDBusPropertyTable ep_properties[] =3D=
 {
>  static int parse_array(DBusMessageIter *iter, struct iovec **iov)
>  {
>         DBusMessageIter array;
> +       struct iovec tmp_iov =3D {0};
>
>         if (!iov)
>                 return 0;
>
> -       if (!(*iov))
> -               *iov =3D new0(struct iovec, 1);
> -
>         dbus_message_iter_recurse(iter, &array);
> -       dbus_message_iter_get_fixed_array(&array, &(*iov)->iov_base,
> -                                               (int *)&(*iov)->iov_len);
> +       dbus_message_iter_get_fixed_array(&array, &(tmp_iov).iov_base,
> +                                               (int *)&(tmp_iov).iov_len=
);
> +
> +       *iov =3D util_iov_dup(&tmp_iov, 1);
> +
>         return 0;
>  }
>
> @@ -300,7 +301,8 @@ static bool parse_base(void *data, size_t len, util_d=
ebug_func_t func,
>                 .iov_base =3D data,
>                 .iov_len =3D len,
>         };
> -
> +       struct iovec *csc_iov =3D NULL;
> +       struct iovec *meta_iov =3D NULL;
>         uint8_t capsLen, metaLen;
>         uint8_t *hexstream;
>
> @@ -330,22 +332,21 @@ static bool parse_base(void *data, size_t len, util=
_debug_func_t func,
>                                 "Codec", codec->id, codec->cid, codec->vi=
d);
>         }
>
> +       /* Fetch Codec Specific Configuration */
>         if (!util_iov_pull_u8(&iov, &capsLen))
>                 return false;
>         util_debug(func, NULL, "CC Len %d", capsLen);
>
>         if (!capsLen)
>                 return false;
> -       if (caps) {
> -               if (!(*caps))
> -                       *caps =3D new0(struct iovec, 1);
> -               (*caps)->iov_len =3D capsLen;
> -               (*caps)->iov_base =3D iov.iov_base;
> -       }
>
> +       csc_iov =3D new0(struct iovec, 1);
> +       util_iov_memcpy(csc_iov, iov.iov_base, capsLen);
> +
> +       /* Print Codec Specific Configuration */
>         for (int i =3D 0; capsLen > 1; i++) {
>                 struct bt_ltv *ltv =3D util_iov_pull_mem(&iov, sizeof(*lt=
v));
> -               uint8_t *caps;
> +               uint8_t *csc;
>
>                 if (!ltv) {
>                         util_debug(func, NULL, "Unable to parse %s",
> @@ -356,35 +357,46 @@ static bool parse_base(void *data, size_t len, util=
_debug_func_t func,
>                 util_debug(func, NULL, "%s #%u: len %u type %u",
>                                         "CC", i, ltv->len, ltv->type);
>
> -               caps =3D util_iov_pull_mem(&iov, ltv->len - 1);
> -               if (!caps) {
> +               csc =3D util_iov_pull_mem(&iov, ltv->len - 1);
> +               if (!csc) {
>                         util_debug(func, NULL, "Unable to parse %s",
>                                                                 "CC");
>                         return false;
>                 }
> -               util_hexdump(' ', caps, ltv->len - 1, func, NULL);
> +               util_hexdump(' ', csc, ltv->len - 1, func, NULL);
>
>                 capsLen -=3D (ltv->len + 1);
>         }
>
> +       /* Fetch Metadata */
>         if (!util_iov_pull_u8(&iov, &metaLen))
>                 return false;
>         util_debug(func, NULL, "Metadata Len %d", metaLen);
>
>         if (!metaLen)
>                 return false;
> -       if (meta) {
> -               if (!(*meta))
> -                       *meta =3D new0(struct iovec, 1);
> -               (*meta)->iov_len =3D metaLen;
> -               (*meta)->iov_base =3D iov.iov_base;
> -       }
> +
> +       meta_iov =3D new0(struct iovec, 1);
> +       util_iov_memcpy(meta_iov, iov.iov_base, metaLen);
>
>         hexstream =3D util_iov_pull_mem(&iov, metaLen);
>         if (!hexstream)
>                 return false;
>         util_hexdump(' ', hexstream, metaLen, func, NULL);
>
> +       /* Update caps and meta with received Codec Specific Configuratio=
n and Metadata */
> +       if (caps) {
> +               if (*caps)
> +                       util_iov_free(*caps, 1);
> +               *caps =3D csc_iov;
> +       }
> +
> +       if (meta) {
> +               if (*meta)
> +                       util_iov_free(*meta, 1);
> +               *meta =3D meta_iov;
> +       }
> +
>         return true;
>  }
>
> @@ -780,7 +792,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GErr=
or *err, void *user_data)
>         char address[18];
>         struct bap_ep *ep;
>         int fd;
> -       struct iovec *base_io;
>         uint32_t presDelay;
>         uint8_t numSubgroups;
>         uint8_t numBis;
> @@ -807,12 +818,11 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GE=
rror *err, void *user_data)
>         if (!ep)
>                 return;
>
> +       /* Update endpoint with the values of the peer's (BAP source) QOS=
 */
>         update_bcast_qos(&qos, &ep->qos);
>
> -       base_io =3D new0(struct iovec, 1);
> -       util_iov_memcpy(base_io, base.base, base.base_len);
> -
> -       parse_base(base_io->iov_base, base_io->iov_len, bap_debug,

Ive made quite a few changes to how broadcast works, so please have a
look in the following set:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D788264

> +       /* Update endpoint with the value received from the peer's (BAP s=
ource) BASE */
> +       parse_base(base.base, base.base_len, bap_debug,
>                         &presDelay, &numSubgroups, &numBis,
>                         &codec, &ep->caps, &ep->metadata);
>
> @@ -917,6 +927,7 @@ static struct bap_ep *ep_register_bcast(struct bap_da=
ta *data,
>                 return ep;
>
>         ep =3D new0(struct bap_ep, 1);
> +       memset(ep, 0, sizeof(struct bap_ep));

new0 already does initialize to 0.

>         ep->data =3D data;
>         ep->lpac =3D lpac;
>         ep->rpac =3D rpac;
> @@ -2288,6 +2299,7 @@ static int bap_init(void)
>  static void bap_exit(void)
>  {
>         btd_profile_unregister(&bap_profile);
> +       btd_profile_unregister(&bap_bcast_profile);

The above should probably be sent as a separate fix.

>         bt_bap_unregister(bap_id);
>  }
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
