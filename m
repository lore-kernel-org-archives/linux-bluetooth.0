Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308117764B
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451237; cv=none; b=EM3IQYXZRIXigcS4RZZTpTqarNTgwY0bEMbQ+9rXDucMtn0aDqB68iXC/rLjk20/MfHtBFup4YxD9TgmqQWCSu6tBDsGiiuJQt2r2xm1TZV71wWyEWBEw6FryXKbUQs21KF1NuuJAw8dqgbMdAqwNZEclMgwbvsZ9IVD2XitG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451237; c=relaxed/simple;
	bh=cwYQrjcG3exWXfP7SFUtxU9ycjwaGoOMj05C9WWz60E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYSqnSR3BO4qVnxcOyPZG+sznNqSpdKftNlmW9G9FFdzdlThKJcq+usrIaXjI+WiPMLLcKIeOfFYmG7XtSnJ/6esVQlZIqy6UXIFaDDDHK2HABwPbhVfgK3vdGYlgrPoUx1nQYrWrnDQqszkun48NxbuEMoLB1MOBnxnBTcvRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm0bqrNi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm0bqrNi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d208d0b282so77172601fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 09:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708451233; x=1709056033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBwVJoxbiC6t6CTkmDck4eqLivGVSVQ+mzckD5Jh4s8=;
        b=Hm0bqrNiqp0TedI5ja+cK6YdxQH5mAjaJBA+VTlKg+4vP5zFtr22wgK2DHLtm0xCpj
         lekM3o4r+26ug09o6oQMvw8ke7Ygtnzyh3Mu+a4zCdoT2SqW7JnGNS70ROOuYzAJZc47
         C0yE/ri7zEkAnGxk6PiqhVguKd3MW4GZQ8ugXXQpCPwnlrq+aCuIp49GCOwVWlZ2WGFs
         Kli1ySJVUFz4ggwIY7Ng8bbBSjx3l7Ila1z+DLj/HbuXzaB5qbVIAA+5nwtG3LHE89cz
         P0yd+1v8awiolVrF2ASv5oNQl4ASKlJpMS+5JHE/7iSBA0YTCCR/7BvRnB5cnUlQUu7M
         3rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708451233; x=1709056033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBwVJoxbiC6t6CTkmDck4eqLivGVSVQ+mzckD5Jh4s8=;
        b=vk0Pt4ovaoKX4qMCpd7zyTwhSumFaIoH1fkiqEl6EN8PlbjHaEcXw1yC/j1EFmVuYL
         ZY6bOWhCyntSbQ628rK2OtZh8aUq8CBhUpd0gTSPIpVkKAk6dYU2w9Jc/7zF+7y92a+P
         ol/+97/H0ggAdOrGGquH2RSUPXMC2HXa1Pq5w9bqGt5jCP5csYvGARfXGrPAYd0gilkd
         nOLqsrmPcks3gktG6FSlCCxFjU2bUS+NbdzGKLAIQ969eT/0PHw0BS3rb3ffyEeu1Jpn
         0QCJEx9BjmCoArSIDCFL7LcyoYR7ufxOA0/11TRo6JyN13GtfdPPc5Ro/Yi6yzIV9Or/
         kegA==
X-Gm-Message-State: AOJu0YzDv74cShosNJ2QOEnxVJutZuZArxMlCsTDp1WT1ng64dVDUjlH
	izWi1Bgcx12DyObOacycXSPSf1il0lwSeTkZD+v/dctsdW8aGZvmezqLhN8yqhipx/xbgodg1Yg
	XC8jcamizmRNIy6/kW/+oImB627rEatCx
X-Google-Smtp-Source: AGHT+IHx904TQ9ogoBA2RA29z5B8cxZBz6d9AY+NOt5X+v1XEbRE1vRdjgHNLCLzsolw2IO5+NX+SHI8romzLIh9QDI=
X-Received: by 2002:a2e:86d0:0:b0:2d2:3d1c:148f with SMTP id
 n16-20020a2e86d0000000b002d23d1c148fmr3772795ljj.42.1708451232882; Tue, 20
 Feb 2024 09:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219121509.5702-1-andrei.istodorescu@nxp.com> <20240219121509.5702-3-andrei.istodorescu@nxp.com>
In-Reply-To: <20240219121509.5702-3-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Feb 2024 12:47:00 -0500
Message-ID: <CABBYNZJqiCk3K5BAbwJJNONJnGkDYoRqnKTD0TMMWx5gguzCFg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/4] shared/bap: Add API to convert parsed BASE
 into pac data
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Mon, Feb 19, 2024 at 7:15=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> Create one remote endpoint for each BIS present in the BASE which matches
> the local sink capabilities. Add API to get the PAC metadata and
> capabilities.
> ---
>  src/shared/bap.c | 497 ++++++++++++++++++++++++++++++++++-------------
>  src/shared/bap.h |  11 +-
>  2 files changed, 375 insertions(+), 133 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index f688e1ad53fb..c3d96c08fddc 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -48,6 +48,11 @@
>
>  #define BAP_PROCESS_TIMEOUT 10
>
> +#define BAP_FREQ_LTV_TYPE 1
> +#define BAP_DURATION_LTV_TYPE 2
> +#define BAP_CHANNEL_ALLOCATION_LTV_TYPE 3
> +#define BAP_FRAME_LEN_LTV_TYPE 4
> +
>  struct bt_bap_pac_changed {
>         unsigned int id;
>         bt_bap_pac_func_t added;
> @@ -3282,6 +3287,13 @@ static void bap_add_broadcast_source(struct bt_bap=
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
> @@ -3433,6 +3445,16 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct b=
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
> @@ -5872,8 +5894,9 @@ static void add_new_subgroup(struct bt_bap_base *ba=
se,
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
> @@ -5892,7 +5915,7 @@ static void match_ltv(size_t i, uint8_t l, uint8_t =
t, uint8_t *v,
>         if (ltv_match->l !=3D l)
>                 return;
>
> -       if (!memcmp(v, ltv_match->v, l))
> +       if (!memcmp(v, ltv_match->data, l))
>                 ltv_match->found =3D true;
>  }
>
> @@ -5904,7 +5927,7 @@ static void search_ltv(size_t i, uint8_t l, uint8_t=
 t, uint8_t *v,
>
>         ltv_match.found =3D false;
>         ltv_match.l =3D l;
> -       ltv_match.v =3D v;
> +       ltv_match.data =3D v;
>
>         util_ltv_foreach(ltv_search->iov->iov_base,
>                         ltv_search->iov->iov_len, &t,
> @@ -5945,8 +5968,10 @@ static bool compare_ltv(struct iovec *iov1,
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
> @@ -5958,7 +5983,7 @@ static void extract_ltv(size_t i, uint8_t l, uint8_=
t t, uint8_t *v,
>
>         ltv_match.found =3D false;
>         ltv_match.l =3D l;
> -       ltv_match.v =3D v;
> +       ltv_match.data =3D v;
>
>         /* Search each BIS caps ltv in subgroup caps
>          * to extract the one that are BIS specific
> @@ -6112,12 +6137,16 @@ static void cleanup_subgroup(struct bt_bap_subgro=
up *subgroup)
>                 free(subgroup);
>  }
>
> +static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> +               void *user_data)
> +{
> +       util_debug(user_data, NULL, "CC #%zu: l:%u t:%u", i, l, t);
> +       util_hexdump(' ', v, l, user_data, NULL);
> +}
> +
>  bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
>                 util_debug_func_t func, struct bt_bap_base *base)
>  {
> -       uint8_t num_subgroups;
> -       uint8_t num_bis;
> -
>         struct iovec iov =3D {
>                 .iov_base =3D data,
>                 .iov_len =3D len,
> @@ -6132,161 +6161,369 @@ bool bt_bap_parse_base(struct bt_bap *bap, void=
 *data, size_t len,
>
>         if (!util_iov_pull_u8(&iov, &base->num_subgroups))
>                 return false;
> -       util_debug(func, NULL, "NumSubgroups %d", base->num_subgroups);
> -       num_subgroups =3D base->num_subgroups;
> +       util_debug(func, NULL, "Number of Subgroups: %d", base->num_subgr=
oups);
>
> -       for (int sg =3D 0; sg < num_subgroups; sg++) {
> -               struct bt_bap_subgroup *sub_group =3D new0(
> +       for (int idx =3D 0; idx < base->num_subgroups; idx++) {
> +               struct bt_bap_subgroup *subgroup =3D new0(
>                                                 struct bt_bap_subgroup, 1=
);
> -               uint8_t caps_len, metaLen;
> -               uint8_t *hexstream;
>
> -               sub_group->subgroup_index =3D sg;
> +               subgroup->index =3D idx;
>
> -               util_debug(func, NULL, "Subgroup #%d", sg);
> -               sub_group->bap =3D bap;
> -               sub_group->bises =3D queue_new();
> +               util_debug(func, NULL, "Subgroup #%d", idx);
> +               subgroup->bap =3D bap;
> +               subgroup->bises =3D queue_new();
>
> -               if (!util_iov_pull_u8(&iov, &num_bis)) {
> -                       cleanup_subgroup(sub_group);
> +               if (!util_iov_pull_u8(&iov, &subgroup->num_bises))
>                         goto fail;
> -               }
> -               util_debug(func, NULL, "NumBis %d", num_bis);
> -               sub_group->num_bises =3D num_bis;
> -
> -               memcpy(&sub_group->codec, util_iov_pull_mem(&iov,
> -               sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec)=
);
> -               util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x=
",
> -                       "Codec", sub_group->codec.id, sub_group->codec.ci=
d,
> -                               sub_group->codec.vid);
> -               if (!util_iov_pull_u8(&iov, &caps_len)) {
> -                       cleanup_subgroup(sub_group);
> -                       goto fail;
> -               }
>
> -               util_debug(func, NULL, "CC Len %d", caps_len);
> +               util_debug(func, NULL, "Number of BISes: %d",
> +                               subgroup->num_bises);
>
> -               /*
> -                * Copy the Codec Specific configurations from base
> -                */
> -               sub_group->caps =3D new0(struct iovec, 1);
> -               util_iov_memcpy(sub_group->caps, iov.iov_base, caps_len);
> -               util_debug(func, NULL, "subgroup caps len %ld",
> -                               sub_group->caps->iov_len);
> -
> -               for (int i =3D 0; caps_len > 1; i++) {
> -                       struct bt_ltv *ltv =3D util_iov_pull_mem(&iov,
> -                                                               sizeof(*l=
tv));
> -                       uint8_t *caps;
> -
> -                       if (!ltv) {
> -                               util_debug(func, NULL, "Unable to parse %=
s",
> -                                                       "Capabilities");
> -                               cleanup_subgroup(sub_group);
> -                               goto fail;
> -                       }
> +               memcpy(&subgroup->codec, util_iov_pull_mem(&iov,
> +                               sizeof(struct bt_bap_codec)),
> +                               sizeof(struct bt_bap_codec));
> +               util_debug(func, NULL, "Codec: ID %d CID 0x%2.2x VID 0x%2=
.2x",
> +                               subgroup->codec.id, subgroup->codec.cid,
> +                               subgroup->codec.vid);
>
> -                       util_debug(func, NULL, "%s #%u: len %u type %u",
> -                                               "CC", i, ltv->len, ltv->t=
ype);
> +               /* BASE Level 2 */
> +               /* Read Codec Specific Configuration */
> +               subgroup->caps =3D new0(struct iovec, 1);
> +               if (!util_iov_pull_u8(&iov, (void *)&subgroup->caps->iov_=
len))
> +                       goto fail;
>
> -                       caps =3D util_iov_pull_mem(&iov, ltv->len - 1);
> -                       if (!caps) {
> -                               util_debug(func, NULL, "Unable to parse %=
s",
> -                                                                       "=
CC");
> -                               cleanup_subgroup(sub_group);
> -                               goto fail;
> -                       }
> -                       util_hexdump(' ', caps, ltv->len - 1, func, NULL)=
;
> +               util_iov_memcpy(subgroup->caps,
> +                               util_iov_pull_mem(&iov,
> +                               subgroup->caps->iov_len),
> +                               subgroup->caps->iov_len);
>
> -                       caps_len -=3D (ltv->len + 1);
> -               }
> +               /* Print Codec Specific Configuration */
> +               util_debug(func, NULL, "CC len: %ld",
> +                               subgroup->caps->iov_len);
> +               util_ltv_foreach(subgroup->caps->iov_base,
> +                               subgroup->caps->iov_len, NULL, print_ltv,=
 func);
>
> -               if (!util_iov_pull_u8(&iov, &metaLen)) {
> -                       cleanup_subgroup(sub_group);
> +               /* Read Metadata */
> +               subgroup->meta =3D new0(struct iovec, 1);
> +               if (!util_iov_pull_u8(&iov, (void *)&subgroup->meta->iov_=
len))
>                         goto fail;
> -               }
> -               util_debug(func, NULL, "Metadata Len %d", metaLen);
>
> -               sub_group->meta =3D new0(struct iovec, 1);
> -               sub_group->meta->iov_len =3D metaLen;
> -               sub_group->meta->iov_base =3D iov.iov_base;
> +               util_iov_memcpy(subgroup->meta,
> +                               util_iov_pull_mem(&iov,
> +                                               subgroup->meta->iov_len),
> +                               subgroup->meta->iov_len);
>
> -               hexstream =3D util_iov_pull_mem(&iov, metaLen);
> -               if (!hexstream) {
> -                       cleanup_subgroup(sub_group);
> -                       goto fail;
> -               }
> -               util_hexdump(' ', hexstream, metaLen, func, NULL);
> +               /* Print Metadata */
> +               util_debug(func, NULL, "Metadata len: %i",
> +                               (uint8_t)subgroup->meta->iov_len);
> +               util_hexdump(' ', subgroup->meta->iov_base,
> +                               subgroup->meta->iov_len, func, NULL);
>
> -               for (int bis_sg =3D 0; bis_sg < sub_group->num_bises; bis=
_sg++) {
> +               /* BASE Level 3 */
> +               for (int bis_sg =3D 0; bis_sg < subgroup->num_bises; bis_=
sg++) {
>                         struct bt_bap_bis *bis;
> -                       uint8_t caps_len;
> -                       uint8_t crt_bis;
>
> -                       if (!util_iov_pull_u8(&iov, &crt_bis)) {
> -                               cleanup_subgroup(sub_group);
> +                       bis =3D new0(struct bt_bap_bis, 1);
> +                       if (!util_iov_pull_u8(&iov, &bis->index))
>                                 goto fail;
> -                       }
> -                       util_debug(func, NULL, "BIS #%d", crt_bis);
>
> -                       bis =3D new0(struct bt_bap_bis, 1);
> -                       bis->index =3D crt_bis;
> +                       util_debug(func, NULL, "BIS #%d", bis->index);
>
> -                       if (!util_iov_pull_u8(&iov, &caps_len)) {
> -                               cleanup_subgroup(sub_group);
> +                       /* Read Codec Specific Configuration */
> +                       bis->caps =3D new0(struct iovec, 1);
> +                       if (!util_iov_pull_u8(&iov,
> +                                       (void *)&bis->caps->iov_len))
>                                 goto fail;
> -                       }
> -                       util_debug(func, NULL, "CC Len %d", caps_len);
>
> -                       bis->caps =3D new0(struct iovec, 1);
> -                       bis->caps->iov_len =3D caps_len;
> -                       util_iov_memcpy(bis->caps, iov.iov_base, caps_len=
);
> -                       util_debug(func, NULL, "bis caps len %ld",
> +                       util_iov_memcpy(bis->caps,
> +                                       util_iov_pull_mem(&iov,
> +                                       bis->caps->iov_len),
>                                         bis->caps->iov_len);
>
> -                       for (int i =3D 0; caps_len > 1; i++) {
> -                               struct bt_ltv *ltv =3D util_iov_pull_mem(=
&iov,
> -                                                               sizeof(*l=
tv));
> -                               uint8_t *caps;
> -
> -                               if (!ltv) {
> -                                       util_debug(func, NULL, "Unable to=
 parse %s",
> -                                                               "Capabili=
ties");
> -                                       cleanup_subgroup(sub_group);
> -                                       goto fail;
> -                               }
> -
> -                               util_debug(func, NULL, "%s #%u: len %u ty=
pe %u",
> -                                               "CC", i, ltv->len, ltv->t=
ype);
> -
> -                               caps =3D util_iov_pull_mem(&iov, ltv->len=
 - 1);
> -                               if (!caps) {
> -                                       util_debug(func, NULL,
> -                                               "Unable to parse %s", "CC=
");
> -                                       cleanup_subgroup(sub_group);
> -                                       goto fail;
> -                               }
> -                               util_hexdump(' ', caps, ltv->len - 1, fun=
c,
> -                                                                       N=
ULL);
> -
> -                               caps_len -=3D (ltv->len + 1);
> -                       }
> +                       /* Print Codec Specific Configuration */
> +                       util_debug(func, NULL, "CC Len: %d",
> +                                       (uint8_t)bis->caps->iov_len);
> +                       util_ltv_foreach(bis->caps->iov_base,
> +                                       bis->caps->iov_len, NULL, print_l=
tv,
> +                                       func);
>
> -                       queue_push_tail(sub_group->bises, bis);
> +                       queue_push_tail(subgroup->bises, bis);
>                 }
>
> -               queue_push_tail(base->subgroups, sub_group);
> +               queue_push_tail(base->subgroups, subgroup);
>         }
>         return true;
>
>  fail:
> -       while (!queue_isempty(base->subgroups)) {
> -               struct bt_bap_subgroup *subGroup =3D
> -                               queue_peek_head(base->subgroups);
> -               cleanup_subgroup(subGroup);
> -               base->num_subgroups--;
> -       }
>         util_debug(func, NULL, "Unable to parse %s", "Base");
>
>         return false;
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
> +
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
> +#define Codec_Specific_Configuration_Check_Mask (\
> +               (1<<BAP_FREQ_LTV_TYPE)|\
> +               (1<<BAP_DURATION_LTV_TYPE)|\
> +               (1<<BAP_FRAME_LEN_LTV_TYPE))

Not really a fan of having macros inside a function like above.

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
> +                       Codec_Specific_Configuration_Check_Mask) =3D=3D
> +                       Codec_Specific_Configuration_Check_Mask)
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

It would be better to do le32_to_cpu here instead of twice below.

> +
> +       /* If all the bits in the received bitmask are found in
> +        * the local bitmask then we have a match
> +        */
> +       if ((le32_to_cpu(location32) & data->data32) =3D=3D
> +                       le32_to_cpu(location32))
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
> +static void bis_to_pac(void *data, void *user_data)
> +{
> +       struct bt_bap_bis *bis =3D data;
> +       struct bt_bap_subgroup *subgroup =3D user_data;
> +       struct bt_bap_pac *pac_source_bis;
> +       struct bt_bap_endpoint *ep;
> +       int err =3D 0;
> +       struct bt_bap_pac_qos bis_qos =3D {0};
> +       uint8_t type =3D 0;
> +       struct bt_ltv_extract merge_data =3D {0};
> +
> +       merge_data.src =3D bis->caps;
> +       merge_data.result =3D new0(struct iovec, 1);
> +
> +       /* Create a Codec Specific Configuration with LTVs at level 2 (su=
bgroup)
> +        * overwritten by LTVs at level 3 (BIS)
> +        */
> +       util_ltv_foreach(subgroup->caps->iov_base,
> +                       subgroup->caps->iov_len,
> +                       NULL,
> +                       bap_sink_check_level2_ltv, &merge_data);
> +
> +       /* Check each BIS Codec Specific Configuration LTVs against our C=
odec
> +        * Specific Capabilities and if the BIS matches create a PAC with=
 it
> +        */
> +       if (bap_check_bis(subgroup->bap->ldb, merge_data.result) =3D=3D f=
alse)
> +               goto cleanup;
> +
> +       DBG(subgroup->bap, "Matching BIS %i", bis->index);
> +
> +       /* Create a QoS structure based on the received BIS information t=
o
> +        * specify the desired channel for this BIS/PAC
> +        */
> +       type =3D BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> +       util_ltv_foreach(merge_data.result->iov_base,
> +                       merge_data.result->iov_len, &type,
> +                       bap_sink_get_allocation, &bis_qos.location);
> +
> +       /* Create a remote PAC */
> +       pac_source_bis =3D bap_pac_new(subgroup->bap->rdb, NULL,
> +                               BT_BAP_BCAST_SOURCE, &subgroup->codec, &b=
is_qos,
> +                               merge_data.result, subgroup->meta);
> +
> +       err =3D asprintf(&pac_source_bis->name, "%d", bis->index);
> +
> +       if (err < 0) {
> +               DBG(subgroup->bap, "error in asprintf");
> +               goto cleanup;
> +       }
> +
> +       /* Add remote source endpoint */
> +       if (!subgroup->bap->rdb->broadcast_sources)
> +               subgroup->bap->rdb->broadcast_sources =3D queue_new();
> +       queue_push_tail(subgroup->bap->rdb->broadcast_sources, pac_source=
_bis);
> +
> +       queue_foreach(subgroup->bap->pac_cbs, notify_pac_added, pac_sourc=
e_bis);
> +       /* Push remote endpoint with direction sink */
> +       ep =3D bap_endpoint_new_broadcast(subgroup->bap->rdb, BT_BAP_BCAS=
T_SINK);
> +
> +       if (ep)
> +               queue_push_tail(subgroup->bap->remote_eps, ep);
> +
> +cleanup:
> +       util_iov_free(merge_data.result, 1);
> +}
> +
> +/*
> + * Parse each subgroup, check if we can create PACs from its BISes and t=
hen
> + * clear the subgroup data.
> + */
> +void bt_bap_parse_bis(void *data, void *user_data)
> +{
> +       struct bt_bap_subgroup *subgroup =3D data;
> +
> +       queue_foreach(subgroup->bises, bis_to_pac, subgroup);
> +       cleanup_subgroup(subgroup);
> +}
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index b13fef688da3..aed3bf52b8d9 100644
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
> @@ -101,13 +101,13 @@ struct bt_bap_qos {
>  struct bt_bap_base {
>         uint32_t pres_delay;
>         uint8_t big_id;
> -       uint8_t num_subgroups;
>         uint8_t next_bis_index;
> +       uint8_t num_subgroups;
>         struct queue *subgroups;
>  };
>
>  struct bt_bap_subgroup {
> -       uint8_t subgroup_index;
> +       uint8_t index;
>         struct bt_bap *bap;
>         uint8_t num_bises;
>         struct bt_bap_codec codec;

Do we really need bt_bap_base and bt_bap_subgroup to be public?

> @@ -198,6 +198,10 @@ uint16_t bt_bap_pac_get_context(struct bt_bap_pac *p=
ac);
>
>  struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
>
> +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
> +
> +struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
> +
>  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
>
>  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
> @@ -349,4 +353,5 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_st=
ream *stream);
>
>  bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
>                 util_debug_func_t func, struct bt_bap_base *base);
> +void bt_bap_parse_bis(void *data, void *user_data);

Don't really like where this is going, bt_bap_parse_base seem to
assume the data would be handled elsewhere instead of inside of bap
instance, Id done it like bt_bap_add_pac e.g. bt_bap_add_base which
would then end up enumerating multiple records, in fact perhaps we
should rethink if we should enumerate the BIS instances as PAC records
or just got with streams directly and then skip MediaEndpoint entirely
and just have MediaTransport objects representing each BIS found with
no parent endpoints, obviously this would require a lot more
decoupling of Broadcast and Unicast stream logic but that was already
my idea with use of bt_bap_streamp_ops,

> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
