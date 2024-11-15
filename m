Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E261BE87C
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683915; cv=none; b=frVGM9I3a2RyMWqUaCe7pxl5M2+1AtZp0HWMT8Jkid1+XHygnYU/b6Zbk9Lxhg80KEg9MIw6dmVs5RM7MnA8+TP8kF+VCVBtCTJ+T9ZRcc2IqsPibF5ydYkpEYXOy3gIPu87+4GjdEFMdRazX+Fvjz2fxB62r7Ti/beV8dkIWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683915; c=relaxed/simple;
	bh=RgYWg/IKD2njDonpgOYoFtk2dMs04KUTAu7MCvIEfdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMSbfJAVrgLWCierGjlN1rI6+o7AIjtwARRyXPTBCqoRnWeT0DWcgoBdjtYLNdxeaUk8AC88MJie+IZcRsIEAXZHSVrmLGE0PG0Kxztjx43AwqkyKrYJWnKc230Uk/vv9NWYVTKK69sD4zE825utio4d7fpfOpx1Wzd+b5hmov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsiAsN0e; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsiAsN0e"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so8218211fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731683911; x=1732288711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU5ktrLPaU7n3xA0LZ/GgCkgwxk9VR3HxELTIbS14Rw=;
        b=GsiAsN0e5wQ9I+8gGSu7X8JBV22KxXzHNRkjzAmq7xIvC6tbdtuFK6DEY9agbFYxl9
         Qkn0Opki6+5L0isMOHvv3HRFqb44vf8aqWgkxsRhkwG29rz3r79k+688IKQRi49KsS5p
         MY8Wv2HLoqIIDpm+lLOlh7O36sRPwQ6Ddz3HXQMGxWABOzcchxkjY8+UYQUDHHLDhqVv
         Y6ui1vA5nBDF3MX02xKDxvk3n5VjqHpCf4MzKfViz6rpD3uj/pNMtvjSrb3fE3S1DRPp
         yjL5+McOOxOCrQbtxwgAbisxXJXEe7d5tKtpwn7Z+8TujWrwyOGbQNEqjKNc9lTmreBt
         1/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683911; x=1732288711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU5ktrLPaU7n3xA0LZ/GgCkgwxk9VR3HxELTIbS14Rw=;
        b=fXNh0v+o/8ImCOML2YwV77Ej9Q/9tNWDTepNOoxwp4WVSPt2gZqRT/rrHli3aBXmjG
         WeBrLH+Jcpn6Ekh868FsTIuaBglLgegqvEAoswu/hCti0OOsZ4r3tmdiO9FtPO5qY4Lb
         PW0pHYk5LwlN4kqqfxHr7CiZxokJ8YpQM47ET2tZymlorbPxzF0aQtDN6+cMvs0qVjD6
         zxIKGo86tJCZQsgmbHpfFVZA16pW5aqHKygwoDwfXR9q7tGz9vq1PDcbTPkH0dDWB5YE
         w9cI8VXQpjS0EnjAV5X0G0WLTNFMDBntFEzyNEXM+G7XYpqiwY5Su04cmmHYShVZ8Vdh
         2FLA==
X-Gm-Message-State: AOJu0YyvF+yoRpwoRU+cw8JNcVPqVwmVJXxwLMg4FilUucTOKGQDVn0B
	gwewRR2ZU7d41tEcq2eYTRyWM3iWRY7+BhRomw/3/zc8qiwnTWcryshMTy96WordX27PivehlNK
	5RBUC1S8gQg31f/ndNio8eeBrAdI=
X-Google-Smtp-Source: AGHT+IFDQolgnRQxJ4lKOkyZVjHP5Awejfwj8SDy19gpMKE6Am1CmbttY5ns2G/uJTYnUvnXEnSFSdo2pcB6vpR4Y4g=
X-Received: by 2002:a05:651c:160a:b0:2fc:a507:19c6 with SMTP id
 38308e7fff4ca-2ff606a84e2mr19271321fa.22.1731683911048; Fri, 15 Nov 2024
 07:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115103825.19761-1-iulia.tanasescu@nxp.com> <20241115103825.19761-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20241115103825.19761-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Nov 2024 10:18:18 -0500
Message-ID: <CABBYNZ+RuRAJpAum-S2EmVtgf5jKiZLVMwjPmv_9U5jQwtg=ZA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] bap: Rework parse_base
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Fri, Nov 15, 2024 at 5:38=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This makes BAP parse_base public, so other plugins can reuse the logic
> (BASS should also parse BASE internally for the Scan Delegator
> implementation).

For this sort of dependency should be handled by shared libraries,
otherwise we create interdependencies of plugins.

> Since different plugins need to handle BISes differently, this commit
> also reworks parse_base to receive a BIS handler callback which will be
> called for each parsed BIS.

The idea itself is good though, but I suggest we put this under
shared/bap.h, also it would be great to create some unit tests for it,
perhaps one test per supported AC or something like that, anyway this
can be added later on a separate set.

> ---
>  profiles/audio/bap.c | 78 +++++++++++++++++++++++---------------------
>  profiles/audio/bap.h |  8 +++++
>  2 files changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index df685c6d3..98b28f15a 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1086,8 +1086,42 @@ static void create_stream_for_bis(struct bap_data =
*bap_data,
>                         NULL, NULL);
>  }
>
> -static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *ba=
se,
> -               struct bt_iso_qos *qos, util_debug_func_t func)
> +static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
> +       struct iovec *meta, struct bt_iso_qos *qos, void *user_data)
> +{
> +       struct bap_data *data =3D user_data;
> +       struct bt_bap_pac *lpac;
> +       char *path;
> +
> +       bass_add_stream(data->device, meta, caps, qos, sgrp, bis);
> +
> +       if (!bass_check_bis(data->device, bis))
> +               /* If this Broadcast Sink is acting as a Scan
> +                * Delegator, only attempt to create streams
> +                * for the BISes required by the peer Broadcast
> +                * Assistant.
> +                */
> +               return;
> +
> +       /* Check if this BIS matches any local PAC */
> +       bt_bap_verify_bis(data->bap, bis,
> +                       caps, &lpac);
> +
> +       if (!lpac)
> +               return;
> +
> +       if (asprintf(&path, "%s/bis%d",
> +                       device_get_path(data->device),
> +                       bis) < 0)
> +               return;
> +
> +       create_stream_for_bis(data, lpac, qos,
> +                       caps, meta, path);
> +}
> +
> +bool parse_base(struct bt_iso_base *base, struct bt_iso_qos *qos,
> +               util_debug_func_t func, bap_stream_cb_t handler,
> +               void *user_data)
>  {
>         struct iovec iov =3D {
>                 .iov_base =3D base->base,
> @@ -1167,9 +1201,6 @@ static bool parse_base(struct bap_data *bap_data, s=
truct bt_iso_base *base,
>                         uint8_t bis_index;
>                         struct iovec *l3_caps;
>                         struct iovec *merged_caps;
> -                       struct bt_bap_pac *matched_lpac;
> -                       char *path;
> -                       int err;
>
>                         if (!util_iov_pull_u8(&iov, &bis_index)) {
>                                 ret =3D false;
> @@ -1177,18 +1208,12 @@ static bool parse_base(struct bap_data *bap_data,=
 struct bt_iso_base *base,
>                         }
>
>                         util_debug(func, NULL, "BIS #%d", bis_index);
> -                       err =3D asprintf(&path, "%s/bis%d",
> -                                       device_get_path(bap_data->device)=
,
> -                                       bis_index);
> -                       if (err < 0)
> -                               continue;
>
>                         /* Read Codec Specific Configuration */
>                         l3_caps =3D new0(struct iovec, 1);
>                         if (!util_iov_pull_u8(&iov,
>                                                 (void *)&l3_caps->iov_len=
)) {
>                                 free(l3_caps);
> -                               free(path);
>                                 ret =3D false;
>                                 goto group_fail;
>                         }
> @@ -1206,34 +1231,11 @@ static bool parse_base(struct bap_data *bap_data,=
 struct bt_iso_base *base,
>                                         func);
>
>                         merged_caps =3D bt_bap_merge_caps(l2_caps, l3_cap=
s);
> -                       if (!merged_caps) {
> -                               free(path);
> +                       if (!merged_caps)
>                                 continue;
> -                       }
> -
> -                       bass_add_stream(bap_data->device, meta, merged_ca=
ps,
> -                                               qos, idx, bis_index);
> -
> -                       if (!bass_check_bis(bap_data->device, bis_index))=
 {
> -                               /* If this Broadcast Sink is acting as a =
Scan
> -                                * Delegator, only attempt to create stre=
ams
> -                                * for the BISes required by the peer Bro=
adcast
> -                                * Assistant.
> -                                */
> -                               continue;
> -                       }
> -
> -                       /* Check if this BIS matches any local PAC */
> -                       bt_bap_verify_bis(bap_data->bap, bis_index,
> -                                       merged_caps, &matched_lpac);
> -
> -                       if (matched_lpac =3D=3D NULL) {
> -                               free(path);
> -                               continue;
> -                       }
>
> -                       create_stream_for_bis(bap_data, matched_lpac, qos=
,
> -                                       merged_caps, meta, path);
> +                       handler(bis_index, idx, merged_caps, meta,
> +                                                       qos, user_data);
>                 }
>
>  group_fail:
> @@ -1299,7 +1301,7 @@ static gboolean big_info_report_cb(GIOChannel *io, =
GIOCondition cond,
>         /* Analyze received BASE data and create remote media endpoints f=
or each
>          * BIS matching our capabilities
>          */
> -       parse_base(data, &base, &qos, bap_debug);
> +       parse_base(&base, &qos, bap_debug, bis_handler, data);
>
>         service_set_connecting(req->data.service);
>
> diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
> index cfe633311..cf2593db8 100644
> --- a/profiles/audio/bap.h
> +++ b/profiles/audio/bap.h
> @@ -7,5 +7,13 @@
>   *
>   */
>
> +typedef void (*bap_stream_cb_t)(uint8_t bis, uint8_t sgrp,
> +               struct iovec *caps, struct iovec *meta,
> +               struct bt_iso_qos *qos, void *user_data);
> +
>  struct bt_bap *bap_get_session(struct btd_device *device);
>  void bap_scan_delegator_probe(struct btd_device *device);
> +
> +bool parse_base(struct bt_iso_base *base, struct bt_iso_qos *qos,
> +               util_debug_func_t func, bap_stream_cb_t handler,
> +               void *user_data);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
