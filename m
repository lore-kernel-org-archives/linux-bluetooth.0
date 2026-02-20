Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D831E35C184
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608630; cv=pass; b=VXD0R06vSwa/xirv3JRMO5PET33NqT1Ckw0FOqOVNZb4dVUBI8MEh7QTyQYvamNuupRuwgrNHCzx2K4hbbCigYSDE4JPaC30QB4C1PkT39kIk7T3b+CcYLvnyysFFp8+ClrrQ8OT7zM3kcEL9AQ/vYRRDBtruclh9BlhBBhg/Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608630; c=relaxed/simple;
	bh=BD2lh/cO8zz7olf/q0SO2PXxA/pAjB53zCmNbswZvIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGavX7q30DjEFWY1wsRci130VxRLpvOCGFFWtIKEmXoGZXgiMBC/+utRnT0x8pCBeQ+aPCQaCdyiuyATXf/ta5oXO2WpqLnEh9a7BujUdGd41qbwbHXRCyfuTnyBFXJr7qvoodxW8y5AZd5xxzoA3NtArdjhTNlS9tpncg/E6CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeLxrqEQ; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeLxrqEQ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad9238d8fso2291873d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:30:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771608624; cv=none;
        d=google.com; s=arc-20240605;
        b=GrUwamptP9Ck7B7oos8PLp6WqfHFl+P/P8+AApdrHz3vSf/aPlYQTko8OKJTENytUS
         X7zHeOwTO740sXuXQUimr+ROZFSeIJbCHybivZJoykb3CJYHVaah5LXUTY6wT3vPwULb
         rVf14Bcs6K3HGPt05jdwgtl3mCOiM/8YfsLIWtB/rlGdZu0OkoDRWcEHyij69ac8BNr+
         rQnd8naE8qHE8tPXQqrzWts6nX3RPSW1vkidnDEaUPtmFeTINOkR7nw8iox3EFlt3a6V
         cirHgO17kSNZLhtkkCmfHy1xKp9+448oSH+QmFkqpijYbJuZ1nnNN4x5oN9SXihIIDEF
         oOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J59xxy8kxTtAhjK2EoPJgEsd6SDgRL3+aMo93HyG9as=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=RAgUO6MiEVTJY2H0T0DPPw1syaakU2kuqZ3xikakvTp9RykmkRHS2sZHphEzK2OYEC
         o5acOTT2RuGEDBTko8GryowcyenYVlEYkb9MeTenlRWpqEFhZ3D4PypF+Hyo5wuitM/C
         jcsIoBqYhcG2YywOrU+8w1iYQpwFGvyT3TLteFd6OvI6P4C0pgsoUKbTsWuEfhyFBpE5
         KxSCm2H2WjYD9MLZjOpDG9og5mrc5wzBkBA3Ov4llGFY/rtJQ7FnbTauWU1PzL2lInWC
         bccSV322kf03733zaPV5Lq7MnQ0pX4tC/TkIM+kODCWONOOPM9fTUkQK7bWcdt7KIv6x
         YOJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608624; x=1772213424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J59xxy8kxTtAhjK2EoPJgEsd6SDgRL3+aMo93HyG9as=;
        b=NeLxrqEQsjzT/9j+uUqRYfSA6BB3RUyizk36JVdIfSz3p2JHuYCOb/L03J/2682GIQ
         k9cdgf+EAYh+LUpu7ND6oYHhYjqhGMVRt9DIiTMX+vmvlcsqifpv9DpRoHo5kvk77ukt
         jH51Xtgj57KkC6esVZFbhpcgwNwUKh1zrPMNbLfHu4n69EiTyeIqHNtdbo8bAqfMpqZe
         pTj6a4tzHS7rdASpAabEXfo/YaJ5Y+vvU7f3v4mokVl3ouT3pzUGLvSHooSHcSsJwRg8
         9x+4LbXbwIpmj3ePnGXEI3ilquoNjW39QU0Ox6Ia0j37U8q1UqCKYx76GbbUVO0Zlbfc
         Yn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608624; x=1772213424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J59xxy8kxTtAhjK2EoPJgEsd6SDgRL3+aMo93HyG9as=;
        b=GYUSZ6dytiBBYFNnFYEkMVT8La8tcZ/kLMOzSduGJPyJSS6SGJwBrvBglyFc71fRKI
         RtOV5D/O7TqdLeky7GwqBUIFSm69UmK+6Q/VT8/mLa4I4lByuqUwVde6EVXz9vzy/J2o
         SdZpLdJhIS/0viqUnH9MDrJgBNgcQtIfJNFu9gWsP7Gcq2moC/qC/KUmK4QhAajgkaYU
         CO3wT/wY3fcEHvulXIvmDqhxw7Lf3kvyb8dokVfKtkvDYKtTw9zZkVShw1EUK7duzBpy
         92RXdsipujhLAo/1mTTao0WbnCvDI7CvxcaeKmZ0Wn+ArxUFUeuDAtFDTJidnGOPTFjw
         KjFg==
X-Gm-Message-State: AOJu0YzlaWetaOEusmRqk5gTYmJuH3RmtTQSngY84fG0t6BsS8JK9R61
	0KMWv49JMRzwiDFpcM/n1ymKtfkPksbXFCnK3MBr5y0lOGstoDBvwkkJJyqERx4GYff9dcTaDjg
	JeN32BCoLirZxT9TBa+IzD/npM80b6LA=
X-Gm-Gg: AZuq6aJsAmZi695oMVfIpUmpyXaF/Ux5K1AaBQFgynvYLFD9rQBNwOdkoWaxLvtAaZK
	IxWEkR/s8i914WUrWVr7EdJnLvkuMVKvxaPrgf/Gf5zZYYYE6pAmdtH+YrjqACR4XpJdEBYbFZR
	UaS6oip5gEZSec2ahPz8e3cstK95EsJUEnVGW+PBUcomopwxjDhYK0NY9TCQhrgHUr1r73RnJ6j
	jOGP306AdPThsZajcZnFIsNl1r44LhItQiq08k/qgvwEekVEkzI4vkqKzTzurX8XkEBW+zkMVks
	PsD85/4pelBFG1hcsg8NrE1ZQJMv5KzFwG+m14nnpQBGwxrXcL1LMmp9mw6ouY77xJeoDA==
X-Received: by 2002:a53:acdb:0:10b0:64a:f1c0:65c6 with SMTP id
 956f58d0204a3-64c79076cb0mr372639d50.80.1771608624375; Fri, 20 Feb 2026
 09:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220155525.860822-1-frederic.danis@collabora.com>
In-Reply-To: <20260220155525.860822-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Feb 2026 12:30:13 -0500
X-Gm-Features: AZwV_QhDSJ9hiQNpoyCZ6d6_aTC3IbOQkoLmr21WjddeIDo98NScMn5FjH71le8
Message-ID: <CABBYNZKF1fEV_raE0dT3f=-0HgwYGp8uTgUuh35GS8FDFSaPXA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: Fix endpoint configuration
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Fri, Feb 20, 2026 at 10:56=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> When a first local endpoint is created after connection to a remote
> device this doesn't trigger the SelectProperties request because
> bt_bap_bac ops are not yet set when bt_bap_select() is called.
> Creating a second local endpoint allows to trigger SelectProperties
> request for the first endpoint.
>
> This commit fixes this behavior by setting the ops during bt_bap_pac
> creation.
> ---
>  profiles/audio/media.c |  4 +---
>  src/shared/bap.c       | 11 ++++++++---
>  src/shared/bap.h       | 30 +++++++++++++++++-------------
>  unit/test-bap.c        | 34 ++++++++++++++++------------------
>  4 files changed, 42 insertions(+), 37 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 772af1014..0b88c46f1 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1363,7 +1363,7 @@ static bool endpoint_init_pac(struct media_endpoint=
 *endpoint, uint8_t type,
>
>         endpoint->pac =3D bt_bap_add_vendor_pac(db, name, type, endpoint-=
>codec,
>                                 endpoint->cid, endpoint->vid, &endpoint->=
qos,
> -                               &data, metadata);
> +                               &data, metadata, &pac_ops, endpoint);
>         if (!endpoint->pac) {
>                 error("Unable to create PAC");
>                 free(name);
> @@ -1371,8 +1371,6 @@ static bool endpoint_init_pac(struct media_endpoint=
 *endpoint, uint8_t type,
>                 return false;
>         }
>
> -       bt_bap_pac_set_ops(endpoint->pac, &pac_ops, endpoint);
> -
>         DBG("PAC %s registered", name);
>
>         free(name);
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 37b04c5c1..549c43c34 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -4129,7 +4129,9 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gat=
t_db *db,
>                                         uint8_t id, uint16_t cid, uint16_=
t vid,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata)
> +                                       struct iovec *metadata,
> +                                       struct bt_bap_pac_ops *ops,
> +                                       void *ops_user_data)
>  {
>         struct bt_bap_db *bdb;
>         struct bt_bap_pac *pac;
> @@ -4150,6 +4152,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gat=
t_db *db,
>         codec.vid =3D vid;
>
>         pac =3D bap_pac_new(bdb, name, type, &codec, qos, data, metadata)=
;
> +       bt_bap_pac_set_ops(pac, ops, ops_user_data);
>
>         switch (type) {
>         case BT_BAP_SINK:
> @@ -4178,10 +4181,12 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db =
*db, const char *name,
>                                         uint8_t type, uint8_t id,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata)
> +                                       struct iovec *metadata,
> +                                       struct bt_bap_pac_ops *ops,
> +                                       void *ops_user_data)
>  {
>         return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, =
qos,
> -                                                       data, metadata);
> +                                       data, metadata, ops, ops_user_dat=
a);
>  }
>
>  uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index c1b75949f..f7e25a93c 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -67,19 +67,6 @@ struct bt_bap_pac_qos {
>         uint16_t context;
>  };
>
> -struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
> -                                       const char *name, uint8_t type,
> -                                       uint8_t id, uint16_t cid, uint16_=
t vid,
> -                                       struct bt_bap_pac_qos *qos,
> -                                       struct iovec *data,
> -                                       struct iovec *metadata);
> -
> -struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
> -                                       uint8_t type, uint8_t id,
> -                                       struct bt_bap_pac_qos *qos,
> -                                       struct iovec *data,
> -                                       struct iovec *metadata);
> -
>  struct bt_bap_pac_ops {
>         int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
>                         uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
> @@ -92,6 +79,23 @@ struct bt_bap_pac_ops {
>         void (*clear)(struct bt_bap_stream *stream, void *user_data);
>  };
>
> +struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
> +                                       const char *name, uint8_t type,
> +                                       uint8_t id, uint16_t cid, uint16_=
t vid,
> +                                       struct bt_bap_pac_qos *qos,
> +                                       struct iovec *data,
> +                                       struct iovec *metadata,
> +                                       struct bt_bap_pac_ops *ops,
> +                                       void *ops_user_data);
> +
> +struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
> +                                       uint8_t type, uint8_t id,
> +                                       struct bt_bap_pac_qos *qos,
> +                                       struct iovec *data,
> +                                       struct iovec *metadata,
> +                                       struct bt_bap_pac_ops *ops,
> +                                       void *ops_user_data);

Id keep these and only add a variant where we set the ops inline that
way we don't have to rework pacs without ops, etc.

>  bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *o=
ps,
>                                         void *user_data);
>
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index 3a67e7016..ab3996e22 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -686,12 +686,12 @@ static void test_setup_pacs(struct test_data *data)
>                                                         BT_BAP_SINK, 0x0f=
f,
>                                                         0x0001, 0x0001,
>                                                         data->qos, data->=
caps,
> -                                                       NULL);
> +                                                       NULL, NULL, NULL)=
;
>                 else
>                         data->snk =3D bt_bap_add_pac(data->db, "test-bap-=
snk",
>                                                         BT_BAP_SINK, LC3_=
ID,
>                                                         data->qos, data->=
caps,
> -                                                       NULL);
> +                                                       NULL, NULL, NULL)=
;
>                 g_assert(data->snk);
>         }
>
> @@ -702,12 +702,12 @@ static void test_setup_pacs(struct test_data *data)
>                                                         BT_BAP_SOURCE, 0x=
0ff,
>                                                         0x0001, 0x0001,
>                                                         data->qos, data->=
caps,
> -                                                       NULL);
> +                                                       NULL, NULL, NULL)=
;
>                 else
>                         data->src =3D bt_bap_add_pac(data->db, "test-bap-=
src",
>                                                         BT_BAP_SOURCE, LC=
3_ID,
>                                                         data->qos, data->=
caps,
> -                                                       NULL);
> +                                                       NULL, NULL, NULL)=
;
>                 g_assert(data->src);
>         }
>  }
> @@ -753,30 +753,28 @@ static void test_setup_server(const void *user_data=
)
>                 data->snk =3D bt_bap_add_vendor_pac(db, "test-bap-snk",
>                                                         BT_BAP_SINK, 0x0f=
f,
>                                                         0x0001, 0x0001,
> -                                                       data->qos, NULL,
> -                                                       NULL);
> +                                                       data->qos, NULL, =
NULL,
> +                                                       &ucast_pac_ops, N=
ULL);
>         else
>                 data->snk =3D bt_bap_add_pac(db, "test-bap-snk", BT_BAP_S=
INK,
>                                                         LC3_ID, data->qos=
,
> -                                                       data->caps, NULL)=
;
> +                                                       data->caps, NULL,
> +                                                       &ucast_pac_ops, N=
ULL);
>         g_assert(data->snk);
>
> -       bt_bap_pac_set_ops(data->snk, &ucast_pac_ops, NULL);
> -
>         if (data->cfg && data->cfg->vs)
>                 data->src =3D bt_bap_add_vendor_pac(db, "test-bap-snk",
>                                                         BT_BAP_SOURCE, 0x=
0ff,
>                                                         0x0001, 0x0001,
> -                                                       data->qos, NULL,
> -                                                       NULL);
> +                                                       data->qos, NULL, =
NULL,
> +                                                       &ucast_pac_ops, N=
ULL);
>         else
>                 data->src =3D bt_bap_add_pac(db, "test-bap-src", BT_BAP_S=
OURCE,
>                                                         LC3_ID, data->qos=
,
> -                                                       data->caps, NULL)=
;
> +                                                       data->caps, NULL,
> +                                                       &ucast_pac_ops, N=
ULL);
>         g_assert(data->src);
>
> -       bt_bap_pac_set_ops(data->src, &ucast_pac_ops, NULL);
> -
>         att =3D bt_att_new(io_get_fd(io), false);
>         g_assert(att);
>
> @@ -1052,13 +1050,13 @@ static void test_bcast_config(struct test_data *d=
ata)
>                                                         BT_BAP_BCAST_SOUR=
CE,
>                                                         0x0ff, 0x0000, 0x=
0000,
>                                                         NULL, data->caps,
> -                                                       NULL);
> +                                                       NULL, NULL, NULL)=
;
>                 else
>                         data->bsrc =3D bt_bap_add_pac(data->db, "test-bap=
-bsrc",
>                                                         BT_BAP_BCAST_SOUR=
CE,
>                                                         LC3_ID,
>                                                         NULL, data->caps,
> -                                                       NULL);
> +                                                       NULL, NULL, NULL)=
;
>
>                 g_assert(data->bsrc);
>         }
> @@ -1073,13 +1071,13 @@ static void test_bcast_config(struct test_data *d=
ata)
>                                                         BT_BAP_BCAST_SINK=
,
>                                                         0xff, 0x0000, 0x0=
000,
>                                                         NULL, data->caps,
> -                                                       NULL);
> +                                                       NULL, NULL, NULL)=
;
>                 else
>                         data->bsnk =3D bt_bap_add_pac(data->db, "test-bap=
-bsnk",
>                                                         BT_BAP_BCAST_SINK=
,
>                                                         LC3_ID,
>                                                         NULL, data->caps,
> -                                                       NULL);
> +                                                       NULL, NULL, NULL)=
;
>
>                 g_assert(data->bsnk);
>         }
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
