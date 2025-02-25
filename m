Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD926B2B0
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495976; cv=none; b=G1FWwe/N5XOyLB1nZDHG+lVIn27JbCQpOwJys8ZTGnCaDTCrCrbRTcZiVWYLW/GbfyNpqLFnpG2gWKci0LTdsq9GNS9THRHfgn694kusLoEhmF3zU0HI8H3hrCrWxqbA/T/MC6S0BlJyRyOop89ym7ZEuoAzpdAqv7Bw8vFPE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495976; c=relaxed/simple;
	bh=lsQTD5TZRXIa5ot0XIT2Igq0dQBxHKWDt+gygcOUz8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mU0PwkWfvOhFZRcRpSYAPHZTlcmvZbgU3jg/Jo3GHe52E7ZSr7XuLj6CFcmyxmGejTT6e4q1mQ455ClVGlFtZJlsydJNp0GJJ85wO4FBTjLD35zJfWesCD46YbkccTfefuGdthor/PFu9pkdFxTEyJpbd1JjNMOqM2DD7+qpi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbnmjxAG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbnmjxAG"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a29f4bd43so51169331fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 07:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740495973; x=1741100773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rGk7XO22TuSyaUur7sW3ujLoRtIqU5Q3hGFYBGsJoo=;
        b=QbnmjxAGu7B1JAPhxO6xUvQmfo/sSdLCKQEbxsUaoUUuV52sGGChe22msrmk9ApBbf
         FkHIma1jOyy9ymduTDuw2HVtOLstLqJa9+IV7qKuzV5tqpriBbnYLILpX8DoEE+W+eZW
         G+p6pul9fNIkZVg8KwcKNCP7Xpx4mXOR56bxJ9s3eo3wa9YcoALLKt8lklNd5aXGl03j
         sdSU4aL7kNGAoHtfRmYJGM4eNugxCDxYKQpbBw9kKDZYbvu03398hMn5APchcelpbiFs
         RmjQT2RKF1eMOBSNf4ANufodaNOASHolaDhs3a0Fq9ASaO8JsSTYpPRXGRjw0UJ/DVL0
         IS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495973; x=1741100773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rGk7XO22TuSyaUur7sW3ujLoRtIqU5Q3hGFYBGsJoo=;
        b=qyTPYmTYoxWKKMvj9nWLTwgKcA9SZCdLEznxw0+rFUUY5m77Xno3ZcKgPO2RFf/u+i
         Z7NOH91sjUrlH+Nh8D88tAKQqHrbYceoGRiUunjpN36GJep3p8EZ3qO4EmgJ4G8Q/PmS
         PD7BS/H5BsJQ7abIUwiRRQoqPkuukDI3qqvgV+0J+IAYnp4j3KLD3BXRl28N1Q4CNF+s
         sci/SCIYCHbi4UI2erCF112u+JQP3uWPLySAa/NAe6o02nGEj/bYwx5m6ET9/4MU/+Fq
         6+gfmVgAF+b2tHhHJbaJrYv66IlMMVazPv0Ukhc2Ry2KbFxK/7xujL0Ua3hVol8LX3XM
         RSBg==
X-Gm-Message-State: AOJu0YxKL6b0zTIpuitllcqgCAk4BYF8wPsTnb6Utt17YUke11cHvC5N
	0JfTRXMpcR8us+22vzTqept67RzzUhX7Lt3rKG8lVmcZznzADvi0dxJTiH7bup3NJncxGDUqLtA
	yFJ7VOXvRd1iw5cT8aaxmUmu+QyOOTiq+lLo=
X-Gm-Gg: ASbGncurWOnYy68RPecVjWyM4gvvhFsXXi/8vCASTKE2WJq0DTd7qDADmM7WhuKG2Am
	2cC8RwZIA+8gemAAFDY2WHg88Psiql8IRka+xj9QO6kkKSePlMrD9hxvL3WdeiWpCvChseM+/h4
	A51zzLCQ==
X-Google-Smtp-Source: AGHT+IHY23laUDFmv4lNzRS+i3z3rBGP3MRP5px8BCMkfWMeBd7ojFLDG28PyMeBYt+nP3JGsFdULH1KHi9YB72K3iI=
X-Received: by 2002:a2e:9688:0:b0:309:1d7b:f00f with SMTP id
 38308e7fff4ca-30a598f3d9cmr59606131fa.18.1740495972055; Tue, 25 Feb 2025
 07:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225084414.28677-1-iulia.tanasescu@nxp.com> <20250225084414.28677-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20250225084414.28677-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Feb 2025 10:05:59 -0500
X-Gm-Features: AQ5f1Jpf0IuL67GtVgFXCFv7PY0L_QJphvdLR0eCHOL8JsT1QU8zdkP11AcFAyU
Message-ID: <CABBYNZLO10Jw9cGqyUdbM+GwuBo8=5ohdANwV1LOFwyJzKcEdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/bap: Add support to register bis callbacks
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Tue, Feb 25, 2025 at 3:44=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This adds support for registering BIS probe/remove calllbacks with
> shared/bap. This is needed by the BAP Broadcast Assistant (BASS Client)
> implementation, so that the BAP plugin can notify BISes discovered
> after parsing the BASE to BASS, avoiding direct function calls
> between plugins.
> ---
>  src/shared/bap.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/bap.h | 12 +++++-
>  2 files changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 6ffeefa41..76df7f4e4 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -80,6 +80,14 @@ struct bt_bap_state {
>         void *data;
>  };
>
> +struct bt_bap_bis_cb {
> +       unsigned int id;
> +       bt_bap_bis_func_t probe;
> +       bt_bap_func_t remove;
> +       bt_bap_destroy_func_t destroy;
> +       void *data;
> +};
> +
>  struct bt_bap_cb {
>         unsigned int id;
>         bt_bap_func_t attached;
> @@ -180,6 +188,7 @@ struct bt_bap {
>         struct queue *pac_cbs;
>         struct queue *ready_cbs;
>         struct queue *state_cbs;
> +       struct queue *bis_cbs;
>
>         bt_bap_debug_func_t debug_func;
>         bt_bap_destroy_func_t debug_destroy;
> @@ -4190,6 +4199,16 @@ static void bap_state_free(void *data)
>         free(state);
>  }
>
> +static void bap_bis_cb_free(void *data)
> +{
> +       struct bt_bap_bis_cb *bis_cb =3D data;
> +
> +       if (bis_cb->destroy)
> +               bis_cb->destroy(bis_cb->data);
> +
> +       free(bis_cb);
> +}
> +
>  static void bap_ep_free(void *data)
>  {
>         struct bt_bap_endpoint *ep =3D data;
> @@ -4228,6 +4247,7 @@ static void bap_free(void *data)
>         queue_destroy(bap->pac_cbs, pac_changed_free);
>         queue_destroy(bap->ready_cbs, bap_ready_free);
>         queue_destroy(bap->state_cbs, bap_state_free);
> +       queue_destroy(bap->bis_cbs, bap_bis_cb_free);
>         queue_destroy(bap->local_eps, free);
>         queue_destroy(bap->remote_eps, bap_ep_free);
>
> @@ -4310,6 +4330,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, stru=
ct gatt_db *rdb)
>         bap->ready_cbs =3D queue_new();
>         bap->streams =3D queue_new();
>         bap->state_cbs =3D queue_new();
> +       bap->bis_cbs =3D queue_new();
>         bap->local_eps =3D queue_new();
>
>         if (!rdb)
> @@ -5519,6 +5540,82 @@ bool bt_bap_state_unregister(struct bt_bap *bap, u=
nsigned int id)
>         return false;
>  }
>
> +unsigned int bt_bap_bis_cb_register(struct bt_bap *bap,
> +                               bt_bap_bis_func_t probe,
> +                               bt_bap_func_t remove,
> +                               void *user_data,
> +                               bt_bap_destroy_func_t destroy)
> +{
> +       struct bt_bap_bis_cb *bis_cb;
> +       static unsigned int id;
> +
> +       if (!bap)
> +               return 0;
> +
> +       bis_cb =3D new0(struct bt_bap_bis_cb, 1);
> +       bis_cb->id =3D ++id ? id : ++id;
> +       bis_cb->probe =3D probe;
> +       bis_cb->remove =3D remove;
> +       bis_cb->destroy =3D destroy;
> +       bis_cb->data =3D user_data;
> +
> +       queue_push_tail(bap->bis_cbs, bis_cb);
> +
> +       return bis_cb->id;
> +}
> +
> +static bool match_bis_cb_id(const void *data, const void *match_data)
> +{
> +       const struct bt_bap_bis_cb *bis_cb =3D data;
> +       unsigned int id =3D PTR_TO_UINT(match_data);
> +
> +       return (bis_cb->id =3D=3D id);
> +}
> +
> +bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id)
> +{
> +       struct bt_bap_bis_cb *bis_cb;
> +
> +       if (!bap)
> +               return false;
> +
> +       bis_cb =3D queue_remove_if(bap->bis_cbs, match_bis_cb_id,
> +                                               UINT_TO_PTR(id));
> +       if (!bis_cb)
> +               return false;
> +
> +       bap_bis_cb_free(bis_cb);
> +
> +       return false;
> +}
> +
> +void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
> +       struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos)
> +{
> +       const struct queue_entry *entry;
> +
> +       for (entry =3D queue_get_entries(bap->bis_cbs); entry;
> +                                                       entry =3D entry->=
next) {
> +               struct bt_bap_bis_cb *cb =3D entry->data;
> +
> +               if (cb->probe)
> +                       cb->probe(bis, sgrp, caps, meta, qos, cb->data);

It is probably a good idea to take a reference before the for loop to
prevent bap instance from being destroyed by the callbacks if they
drop the reference to 0, also you may need to move the entry =3D
entry->next before the calling the cb since it may also call
unregister.

> +       }
> +}
> +
> +void bt_bap_bis_remove(struct bt_bap *bap)
> +{
> +       const struct queue_entry *entry;
> +
> +       for (entry =3D queue_get_entries(bap->bis_cbs); entry;
> +                                                       entry =3D entry->=
next) {
> +               struct bt_bap_bis_cb *cb =3D entry->data;
> +
> +               if (cb->remove)
> +                       cb->remove(bap, cb->data);
> +       }
> +}
> +
>  const char *bt_bap_stream_statestr(uint8_t state)
>  {
>         switch (state) {
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 200dc8f13..adb531b4c 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -4,7 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> - *  Copyright 2023-2024 NXP
> + *  Copyright 2023-2025 NXP
>   *
>   */
>
> @@ -269,3 +269,13 @@ bool bt_bap_parse_base(struct iovec *base,
>                         bt_bap_bis_func_t handler,
>                         void *user_data);
>
> +unsigned int bt_bap_bis_cb_register(struct bt_bap *bap,
> +                               bt_bap_bis_func_t probe,
> +                               bt_bap_func_t remove,
> +                               void *user_data,
> +                               bt_bap_destroy_func_t destroy);
> +bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id);
> +
> +void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
> +       struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos);
> +void bt_bap_bis_remove(struct bt_bap *bap);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
