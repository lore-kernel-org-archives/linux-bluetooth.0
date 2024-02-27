Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669C16423
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044742; cv=none; b=derDMOeBjk/FqAOCdjTH53KMIXIoWc/eg1PsfXABORTb9Pixw+9a8/G4nk9sOB3mD9ii7gxGnDLExoS7sorTD/mxa7qJrI5tCy7uisOd0KU/AaOWn645V6OhsTWE3weuhKq47qqEMn+U0HrW2yfys10l23s6n2KgpG6LbGF/t7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044742; c=relaxed/simple;
	bh=lkVr+5YePnQ4lGkuTzzYUaILdMTFbs1RO85Kdbwnf4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCPDCpQSjV3FZGt199uXxZnzWsoKvIPIOf76bAVtooRlkF+qWpZNRu2kIAtW0d/Wo25c261+PP5SvG5TOJ1rXjF7jni/70a5r7tB0vQ4MCqTB/nBwpGU25sb1mAyBXJghoSvofFapkfE5Gx0rhzntnyxqICsb6KYO94xLF4R9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRweo+8V; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRweo+8V"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d2509c66daso62722241fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709044738; x=1709649538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o6yuWgBdu8v40GVdQzdUAwl6aHtEp8uus4s6K+o8TU=;
        b=dRweo+8VVfVHzV7Z+bHPrVIjnrU+7MEOz/90m6tj9Qq4PfNKC7gzJIvqXH5y/2jhN7
         juKqdiyb/efpjR7fmHqTJ6jMf7oa74C7Ex43iMiyAsjYuZaqps5o33BLspK5/kxXm0IK
         z+mM8w0or+HzhfDU0x86Z4mETw0PfBNDjvZOnuxEe261mHmaESSYmB9t1ylKpSKY+QMB
         bV80VEn3uBkN2nJbGUkMGL7W7B8PsNP+zwSJZXgZymUDT8O3TUwgNOlLs/YTt+5S8jtk
         hQg95w7fWaqu2pmjK+3el6JjRYx+mSsLrXy2+f1rBroCt2JdtP9mmaa6khbZLaM0Yjkq
         hfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709044738; x=1709649538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o6yuWgBdu8v40GVdQzdUAwl6aHtEp8uus4s6K+o8TU=;
        b=jF+YupQvwdjJeJmZKVEiAGlfL4Ljd+bMKXtIQkDXKZeQx7JfYkDQ/E/vFHDxWtO91U
         pjlPVhcQigbhQXgN55BDP75PgAmRUtEtKEL0otGqoKe7lNg1pB+gKJKIu1FgPuumHQ0g
         ncxb40mMvtrNM/BPsyMlcBJ/JVrypH/kamCvyeRP+2HiDPvN8hPc6you8Ht9fWc0BeTa
         6cwr7p48VLJ23HiZN7ZC54A1HnBJDMTsnUSZoCJDxHTEFqmlzCEk/Z/CqBp/YnuXKryY
         M28aEZjHZwphoADmbqtWUoY/fhAl4VTevL05t8GFynUKIZKOwaSoheLxfvylOuVIvYcK
         1A5g==
X-Gm-Message-State: AOJu0Yw5LCpX4cmr4zb3QojUA1zKd+cTZsdz7c3HVJ56WZIF+EBeKl5s
	9WfP3+IF8kxKXF3UALgpDDQ9gw1YTIv7huVqZbXoYYgOACVeiKrgbvBO2m6y30D6wI1G0YB7FDK
	f7kVsbtM4i6OM1TlWaoG0YalTsKNCbCPX
X-Google-Smtp-Source: AGHT+IE+a9dhXYcdjT3r6ckpP7HbVtWae5yahI8SaUo8pTiRS6ag+lzKtBhynHPKErAtd9jaq50nm5XLuJ0/RMNjlwQ=
X-Received: by 2002:a2e:b60b:0:b0:2d2:9906:6dbf with SMTP id
 r11-20020a2eb60b000000b002d299066dbfmr1400320ljn.29.1709044738225; Tue, 27
 Feb 2024 06:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223153450.86694-1-andrei.istodorescu@nxp.com> <20240223153450.86694-2-andrei.istodorescu@nxp.com>
In-Reply-To: <20240223153450.86694-2-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Feb 2024 09:38:45 -0500
Message-ID: <CABBYNZ+0mMAw4ftbwGE_s49QOQrRZAFGRVEXucxWkv=6YEG+iA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 1/2] shared/bap: Add API to add an observed BIS
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Fri, Feb 23, 2024 at 10:34=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> Add API to add a PAC for each observed BIS that is supported by the
> local PACS data.
> Each BIS observed capabilities LTV is compared to the local capabilities
> and when we have a full LTVs match a PAC record is created for that BIS.
> Also a MediaEndpoint is registered over DBUS and the stream can be
> enabled using the SetConfiguration DBUS call.
> ---
>  src/shared/bap.c | 304 ++++++++++++++++++++++++++++++++++++++++++++---
>  src/shared/bap.h |  13 +-
>  2 files changed, 302 insertions(+), 15 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index f5fc1402701c..853919111835 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -48,6 +48,15 @@
>
>  #define BAP_PROCESS_TIMEOUT 10
>
> +#define BAP_FREQ_LTV_TYPE 1
> +#define BAP_DURATION_LTV_TYPE 2
> +#define BAP_CHANNEL_ALLOCATION_LTV_TYPE 3
> +#define BAP_FRAME_LEN_LTV_TYPE 4
> +#define CODEC_SPECIFIC_CONFIGURATION_MASK (\
> +               (1<<BAP_FREQ_LTV_TYPE)|\
> +               (1<<BAP_DURATION_LTV_TYPE)|\
> +               (1<<BAP_FRAME_LEN_LTV_TYPE))
> +
>  struct bt_bap_pac_changed {
>         unsigned int id;
>         bt_bap_pac_func_t added;
> @@ -1692,11 +1701,8 @@ static unsigned int bap_bcast_config(struct bt_bap=
_stream *stream,
>                                      bt_bap_stream_func_t func, void *use=
r_data)
>  {
>         stream->qos =3D *qos;
> -       if (stream->lpac->type =3D=3D BT_BAP_BCAST_SINK) {
> -               if (data)
> -                       stream_config(stream, data, NULL);
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> -       }
> +       stream->lpac->ops->config(stream, stream->cc, &stream->qos,
> +                       ep_config_cb, stream->lpac->user_data);
>
>         return 1;
>  }
> @@ -3302,6 +3308,13 @@ static void bap_add_broadcast_source(struct bt_bap=
_pac *pac)
>  static void bap_add_broadcast_sink(struct bt_bap_pac *pac)
>  {
>         queue_push_tail(pac->bdb->broadcast_sinks, pac);
> +
> +       /* Update local PACS for broadcast sink also, when registering an
> +        * endpoint
> +        */
> +       pacs_add_sink_location(pac->bdb->pacs, pac->qos.location);
> +       pacs_add_sink_supported_context(pac->bdb->pacs,
> +                       pac->qos.supported_context);
>  }
>
>  static void notify_pac_added(void *data, void *user_data)
> @@ -3453,6 +3466,16 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct b=
t_bap_pac *pac)
>         return &pac->qos;
>  }
>
> +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac)
> +{
> +       return pac->data;
> +}
> +
> +struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac)
> +{
> +       return pac->metadata;
> +}
> +
>  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
>  {
>         if (!stream)
> @@ -5253,10 +5276,6 @@ bool bt_bap_stream_set_user_data(struct bt_bap_str=
eam *stream, void *user_data)
>
>         stream->user_data =3D user_data;
>
> -       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BCAS=
T)
> -               stream->lpac->ops->config(stream, stream->cc, &stream->qo=
s,
> -                                       ep_config_cb, stream->lpac->user_=
data);
> -
>         return true;
>  }
>
> @@ -5892,8 +5911,9 @@ static void add_new_subgroup(struct bt_base *base,
>
>  struct bt_ltv_match {
>         uint8_t l;
> -       uint8_t *v;
> +       void *data;
>         bool found;
> +       uint32_t data32;
>  };
>
>  struct bt_ltv_search {
> @@ -5912,7 +5932,7 @@ static void match_ltv(size_t i, uint8_t l, uint8_t =
t, uint8_t *v,
>         if (ltv_match->l !=3D l)
>                 return;
>
> -       if (!memcmp(v, ltv_match->v, l))
> +       if (!memcmp(v, ltv_match->data, l))
>                 ltv_match->found =3D true;
>  }
>
> @@ -5924,7 +5944,7 @@ static void search_ltv(size_t i, uint8_t l, uint8_t=
 t, uint8_t *v,
>
>         ltv_match.found =3D false;
>         ltv_match.l =3D l;
> -       ltv_match.v =3D v;
> +       ltv_match.data =3D v;
>
>         util_ltv_foreach(ltv_search->iov->iov_base,
>                         ltv_search->iov->iov_len, &t,
> @@ -5965,8 +5985,10 @@ static bool compare_ltv(struct iovec *iov1,
>  }
>
>  struct bt_ltv_extract {
> -       struct iovec *result;
>         struct iovec *src;
> +       void *value;
> +       uint8_t len;
> +       struct iovec *result;
>  };
>
>  static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> @@ -5978,7 +6000,7 @@ static void extract_ltv(size_t i, uint8_t l, uint8_=
t t, uint8_t *v,
>
>         ltv_match.found =3D false;
>         ltv_match.l =3D l;
> -       ltv_match.v =3D v;
> +       ltv_match.data =3D v;
>
>         /* Search each BIS caps ltv in subgroup caps
>          * to extract the one that are BIS specific
> @@ -6111,3 +6133,257 @@ struct iovec *bt_bap_stream_get_base(struct bt_ba=
p_stream *stream)
>
>         return base_iov;
>  }
> +
> +static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
> +               uint8_t *v, void *user_data)
> +{
> +       uint32_t location32;
> +
> +       if (!v)
> +               return;
> +
> +       memcpy(&location32, v, l);
> +       *((uint32_t *)user_data) =3D le32_to_cpu(location32);
> +}
> +
> +/*
> + * This function compares PAC Codec Specific Capabilities, with the Code=
c
> + * Specific Configuration LTVs received in the BASE of the BAP Source. T=
he
> + * result is accumulated in data32 which is a bitmask of types.
> + */
> +static void check_pac_caps_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *=
v,
> +                                       void *user_data)
> +{
> +       struct bt_ltv_match *compare_data =3D user_data;
> +       uint8_t *bis_v =3D compare_data->data;
> +
> +       switch (t) {
> +       case BAP_FREQ_LTV_TYPE:
> +       {
> +               uint16_t mask =3D *((uint16_t *)v);
> +
> +               mask =3D le16_to_cpu(mask);
> +               if (mask & (1 << (bis_v[0] - 1)))
> +                       compare_data->data32 |=3D 1<<t;
> +       }
> +       break;
> +       case BAP_DURATION_LTV_TYPE:
> +               if ((v[0]) & (1 << bis_v[0]))
> +                       compare_data->data32 |=3D 1<<t;
> +               break;
> +       case BAP_FRAME_LEN_LTV_TYPE:
> +       {
> +               uint16_t min =3D *((uint16_t *)v);
> +               uint16_t max =3D *((uint16_t *)(&v[2]));
> +               uint16_t frame_len =3D *((uint16_t *)bis_v);
> +
> +               min =3D le16_to_cpu(min);
> +               max =3D le16_to_cpu(max);
> +               frame_len =3D le16_to_cpu(frame_len);
> +               if ((frame_len >=3D min) &&
> +                               (frame_len <=3D max))
> +                       compare_data->data32 |=3D 1<<t;
> +       }

Don't create new scopes inside a switch statement, that makes it hard
to follow the code, if you really think that would help have a helper
function to check each field.

> +       break;
> +       }
> +}
> +
> +static void check_source_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> +                                       void *user_data)
> +{
> +       struct bt_ltv_match *local_data =3D user_data;
> +       struct iovec *pac_caps =3D local_data->data;
> +       struct bt_ltv_match compare_data;
> +
> +       compare_data.data =3D v;
> +
> +       /* Search inside local PAC's caps for LTV of type t */
> +       util_ltv_foreach(pac_caps->iov_base, pac_caps->iov_len, &t,
> +                                       check_pac_caps_ltv, &compare_data=
);
> +
> +       local_data->data32 |=3D compare_data.data32;
> +}
> +
> +static void bap_sink_check_level3_ltv(size_t i, uint8_t l, uint8_t t,
> +               uint8_t *v, void *user_data)
> +{
> +       struct bt_ltv_extract *merge_data =3D user_data;
> +
> +       merge_data->value =3D v;
> +       merge_data->len =3D l;
> +}
> +
> +static void bap_push_ltv(struct iovec *output, uint8_t l, uint8_t t, voi=
d *v)
> +{
> +       l++;
> +       iov_append(output, 1, &l);
> +       iov_append(output, 1, &t);
> +       iov_append(output, l - 1, v);
> +}

Perhaps we should create a helper function to do this sort of thing,
maybe util_ltv_push?

> +static void bap_sink_check_level2_ltv(size_t i, uint8_t l, uint8_t t,
> +               uint8_t *v, void *user_data)
> +{
> +       struct bt_ltv_extract *merge_data =3D user_data;
> +
> +       merge_data->value =3D NULL;
> +       util_ltv_foreach(merge_data->src->iov_base,
> +                       merge_data->src->iov_len,
> +                       &t,
> +                       bap_sink_check_level3_ltv, user_data);
> +
> +       /* If the LTV at level 2 was found at level 3 add the one from le=
vel 3,
> +        * otherwise add the one at level 2
> +        */
> +       if (merge_data->value)
> +               bap_push_ltv(merge_data->result, merge_data->len,
> +                               t, merge_data->value);
> +       else
> +               bap_push_ltv(merge_data->result, l, t, v);
> +}
> +
> +static void check_local_pac(void *data, void *user_data)
> +{
> +       struct bt_ltv_match *compare_data =3D user_data;
> +       struct iovec *bis_data =3D (struct iovec *)compare_data->data;
> +       const struct bt_bap_pac *pac =3D data;
> +
> +       /* Keep searching for a matching PAC if one wasn't found
> +        * in previous PAC element
> +        */
> +       if (compare_data->found =3D=3D false) {
> +               struct bt_ltv_match bis_compare_data =3D {
> +                               .data =3D pac->data,
> +                               .data32 =3D 0, /* LTVs bitmask result */
> +                               .found =3D false
> +               };
> +
> +               /* loop each BIS LTV */
> +               util_ltv_foreach(bis_data->iov_base, bis_data->iov_len, N=
ULL,
> +                               check_source_ltv, &bis_compare_data);
> +
> +               /* We have a match if all selected LTVs have a match */
> +               if ((bis_compare_data.data32 &
> +                       CODEC_SPECIFIC_CONFIGURATION_MASK) =3D=3D
> +                       CODEC_SPECIFIC_CONFIGURATION_MASK)
> +                       compare_data->found =3D true;
> +       }
> +}
> +
> +static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
> +               uint8_t *v, void *user_data)
> +{
> +       struct bt_ltv_match *data =3D user_data;
> +       uint32_t location32;
> +
> +       if (!v)
> +               return;
> +
> +       memcpy(&location32, v, l);
> +       location32 =3D le32_to_cpu(location32);
> +
> +       /* If all the bits in the received bitmask are found in
> +        * the local bitmask then we have a match
> +        */
> +       if ((location32 & data->data32) =3D=3D location32)
> +               data->found =3D true;
> +       else
> +               data->found =3D false;
> +}
> +
> +static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
> +{
> +       struct bt_ltv_match compare_data =3D {};
> +
> +       /* Check channel allocation against the PACS location.
> +        * If we don't have a location set we can accept any BIS location=
.
> +        * If the BIS doesn't have a location set we also accept it
> +        */
> +       compare_data.found =3D true;
> +
> +       if (ldb->pacs->sink_loc_value) {
> +               uint8_t type =3D BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> +
> +               compare_data.data32 =3D ldb->pacs->sink_loc_value;
> +               util_ltv_foreach(bis_data->iov_base, bis_data->iov_len, &=
type,
> +                               bap_sink_match_allocation, &compare_data)=
;
> +       }
> +
> +       /* Check remaining LTVs against the PACs list */
> +       if (compare_data.found) {
> +               compare_data.data =3D bis_data;
> +               compare_data.found =3D false;
> +               queue_foreach(ldb->broadcast_sinks, check_local_pac,
> +                               &compare_data);
> +       }
> +
> +       return compare_data.found;
> +}
> +
> +void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
> +               struct bt_bap_codec *codec,
> +               struct iovec *l2_caps,
> +               struct iovec *l3_caps,
> +               struct iovec *meta)
> +{
> +       struct bt_bap_pac *pac_source_bis;
> +       struct bt_bap_endpoint *ep;
> +       int err =3D 0;
> +       struct bt_bap_pac_qos bis_qos =3D {0};
> +       uint8_t type =3D 0;
> +       struct bt_ltv_extract merge_data =3D {0};
> +
> +       merge_data.src =3D l3_caps;
> +       merge_data.result =3D new0(struct iovec, 1);
> +
> +       /* Create a Codec Specific Configuration with LTVs at level 2 (su=
bgroup)
> +        * overwritten by LTVs at level 3 (BIS)
> +        */
> +       util_ltv_foreach(l2_caps->iov_base,
> +                       l2_caps->iov_len,
> +                       NULL,
> +                       bap_sink_check_level2_ltv, &merge_data);
> +
> +       /* Check each BIS Codec Specific Configuration LTVs against our C=
odec
> +        * Specific Capabilities and if the BIS matches create a PAC with=
 it
> +        */
> +       if (bap_check_bis(bap->ldb, merge_data.result) =3D=3D false)
> +               goto cleanup;
> +
> +       DBG(bap, "Matching BIS %i", bis_index);
> +
> +       /* Create a QoS structure based on the received BIS information t=
o
> +        * specify the desired channel for this BIS/PAC
> +        */
> +       type =3D BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> +       util_ltv_foreach(merge_data.result->iov_base,
> +                       merge_data.result->iov_len, &type,
> +                       bap_sink_get_allocation, &bis_qos.location);

Isn't it better to parse this inline with the use of util_iov_pull_*?
If you don't want to change the iovec passed, which shall be made a
const if that is intention, then just create a dup and parse it.

> +       /* Create a remote PAC */
> +       pac_source_bis =3D bap_pac_new(bap->rdb, NULL,
> +                               BT_BAP_BCAST_SOURCE, codec, &bis_qos,
> +                               merge_data.result, meta);
> +
> +       err =3D asprintf(&pac_source_bis->name, "%d", bis_index);
> +
> +       if (err < 0) {
> +               DBG(bap, "error in asprintf");
> +               goto cleanup;
> +       }
> +
> +       /* Add remote source endpoint */
> +       if (!bap->rdb->broadcast_sources)
> +               bap->rdb->broadcast_sources =3D queue_new();
> +       queue_push_tail(bap->rdb->broadcast_sources, pac_source_bis);
> +
> +       queue_foreach(bap->pac_cbs, notify_pac_added, pac_source_bis);
> +       /* Push remote endpoint with direction sink */
> +       ep =3D bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
> +
> +       if (ep)
> +               queue_push_tail(bap->remote_eps, ep);
> +
> +cleanup:
> +       util_iov_free(merge_data.result, 1);
> +}
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 2c3550921f07..b2826719f84f 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -4,7 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> - *  Copyright 2023 NXP
> + *  Copyright 2023-2024 NXP
>   *
>   */
>
> @@ -175,6 +175,10 @@ uint16_t bt_bap_pac_get_context(struct bt_bap_pac *p=
ac);
>
>  struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
>
> +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
> +
> +struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);

Have these 2 functions above in a separate patch.

>  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
>
>  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
> @@ -323,3 +327,10 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *p=
ac,
>  bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pa=
c);
>
>  struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
> +
> +void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
> +               struct bt_bap_codec *codec,
> +               struct iovec *l2_caps,
> +               struct iovec *l3_caps,
> +               struct iovec *meta);
> +
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
