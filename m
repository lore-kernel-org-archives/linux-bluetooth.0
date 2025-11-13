Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390CA272813
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058903; cv=none; b=Gdh1ngJ0miMBgTsNEPXg/gz+kc3+84vw4a6tl3Eu79qOgreHFVb5+oo9Cd3T/mLQzcRBjPwZyabKTpgxqOlzxz198aVnthBPIia4x9mKfp3iPA5st/GQfboo/LWObHNrjt2WXXhTO7dUhGznDjEtI0oMGQlw/Qgz3tiNGiNiXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058903; c=relaxed/simple;
	bh=772c7OysDjunoEpFxI18YpjOnW+iz6P0gOUDNpHjiB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/IoIkLAvrMSaovUyleUnSJ6DTDIvIU8JMFN2cqAXBnAgG/MaBtMtVdPF7GCvA19v6LheaiEvNslTq1z0UKc1YwVvLS63V9j1THESb9MCqjjg+1/umr/Vc0cRAh1fAVUrcGgivcunyE3KUu5wTYPVG6JTS40FkHgmmgMKZjLGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+wensSi; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+wensSi"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a56a475e8so11030691fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 10:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763058899; x=1763663699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgcFdvI/se+RMNreKkVNYSUg4bE2duHdZhksBnLYSNU=;
        b=J+wensSiqyaINBCOuINkjaqZ0khhjelTTPs44RHW8Pfw+Dm+U7EakNFAczpYXLZGZU
         jL47foeGoVcjaKiSSOg89qbLKw6mJVXk6R3Qui5IlmRUPPVo4y7iaaGCn9a/RUrmHNju
         BzRHd9GT7FkUzRfGSadDAuUbhBVjTr3C8jYMFQebAe6XgaAganPJSTdd1C+EmO9bLbRf
         0j5xj4f4nXlLYKGzUx68L/4357mzG1us4FXOopZ7n7UMgUwuR6Sh3UfOcA5gMeJj+JFH
         g34olSWVVv3W5WQEYomYclABKjCQyK0QtBd8hQn9Zz2KO8GeROl+Yo4o6KLre6PDmFEm
         6q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058899; x=1763663699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vgcFdvI/se+RMNreKkVNYSUg4bE2duHdZhksBnLYSNU=;
        b=UVtYDaIVXY605PMxMGmuYI2Nvzd4ZdPPidTaoWPr5gcYPAZBRLgAJ5NYi/r975BET8
         zIp99iL9X6cUVmt2LJHuSEztnOUk2dRQLA8g4XcJevq7kDBAp/K9hvq05X+6/FaoKAmO
         mfYQQXZb9mhyvqlWDoYTl0VrkmqKm1Km8UUYZr4QjZzyHGbNxebbI65q1Li2X4XLGkmY
         pysnn7h2wf4JgLA8uVOYYp4YCsuKWHLpccXa0Xa9tC4K366Rp0Z7J44mSpZh5W6zztCY
         4OILC/1sLGnOBSKRdmAl6C80SIsHZJKis2BNOR22ILsSZ54jUJTMwpbeTWTS5P18RHsa
         qoQg==
X-Gm-Message-State: AOJu0YzKNXYGNI9q0YDFnkE8ktMCwRyS5z+3GjWzgHc6vpJLOaIf9JO+
	zEQvwldEc5+ggPba+t7tBPtuej9FLZDJJUyj/KSWXfWMr9Wg2nPLcrcazhBA04NqbqxS4X/+foe
	qWFKPc/YhKIDdmNqlcrlC34oxWn9r9G+8HmA5
X-Gm-Gg: ASbGncs11xe+gGSpR7YTDrqtYBP62sqJjz+QlbRt5HSg9sI+6b2ztV8tnqD9yIN1Ycj
	PILHiWBWVVnxq9kvsj+Dg96m1DpIsQhkPOj+UDv3D9kPdIw8tx0UKjaJ7a4qIrcR6jpoAK7rO3a
	EI3gXPUTFwGlFtrUD2viJ1hUtO1dWz7mkfI7L+tL4VAh5f0wvpITDpTjweEiJF4C/U85mYMOOEA
	TMxayFG0tNa6sBldO8cRuGi/MzjopXl/mMuo4J614M1s+sINY9LwVQrPew=
X-Google-Smtp-Source: AGHT+IGYo7E7Ikp+1GVK57l97NyPuPvkGessBPw0ZxkIdzJ3zV9qQICVsMGQhq/xxyxTHb6rzTn4VD3HOETGJUYriy8=
X-Received: by 2002:a2e:b5d2:0:b0:37b:970f:d33b with SMTP id
 38308e7fff4ca-37b970fd472mr11472411fa.3.1763058898990; Thu, 13 Nov 2025
 10:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 13 Nov 2025 13:34:45 -0500
X-Gm-Features: AWmQ_blnYJfmyMatgMUFHaL5fWNjApIOa4GZlHEgRQBXhz_OencgeS6Qexf50lw
Message-ID: <CABBYNZJMK-D_RwgWbmRU-tkN68UBC+9ys5WyV8O9uvhNqdwJ6A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/4] shared/bap: fix channel allocation logic in bt_bap_select()
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Nov 13, 2025 at 12:59=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> bt_bap_select() does not correctly determine the need for multi-stream
> configurations 6,7,8,9,11(i), as its result depends on whether Audio
> Locations is read before or after the PACs, doesn't work with general
> location bits, etc.
>
> Fix the procedure to be simpler: create streams for all locations, up to
> a specific number of channels.  By default, limit to max 2 channels per
> direction for compatibility (BAP doesn't have explicit AC with larger
> channel counts.) Also simplify the code.
>
> Ignore lpac Locations when selecting: the value mostly makes sense for
> Unicast Server role, but Client and Server cannot use the same value as
> only a few bits can be set. As Client, we should be able to configure
> any Location bits.  The sound server can simply ignore our suggested
> channel allocation if really needed, or use SetConfiguration() API to
> build custom configurations.

Have you tried with any headset that actually supports AC #(i)? Afaik
those are the ones, e.g.  EarFun Air Pro 3, where the current setup
was tested against.

> ---
>
> Notes:
>     v2:
>     - fix getting number of ASEs
>
>  profiles/audio/bap.c |   3 +-
>  src/shared/bap.c     | 205 +++++++++++++++++++++----------------------
>  src/shared/bap.h     |   7 +-
>  3 files changed, 104 insertions(+), 111 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 85bba9543..ec3502b06 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1919,7 +1919,8 @@ static bool pac_select(struct bt_bap_pac *lpac, str=
uct bt_bap_pac *rpac,
>                 queue_push_tail(select->eps, ep);
>         }
>
> -       bt_bap_select(lpac, rpac, &select->remaining, select_cb, ep);
> +       bt_bap_select(data->bap, lpac, rpac, 0, &select->remaining,
> +                                                               select_cb=
, ep);
>
>         return true;
>  }
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index a18f393f7..b779f6716 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -204,11 +204,6 @@ struct bt_bap {
>         void *user_data;
>  };
>
> -struct bt_bap_chan {
> -       uint8_t count;
> -       uint32_t location;
> -};
> -
>  struct bt_bap_pac {
>         struct bt_bap_db *bdb;
>         char *name;
> @@ -3848,50 +3843,6 @@ static void *ltv_merge(struct iovec *data, struct =
iovec *cont)
>         return util_iov_append(data, cont->iov_base, cont->iov_len);
>  }
>
> -static void bap_pac_chan_add(struct bt_bap_pac *pac, uint8_t count,
> -                               uint32_t location)
> -{
> -       struct bt_bap_chan *chan;
> -
> -       if (!pac->channels)
> -               pac->channels =3D queue_new();
> -
> -       chan =3D new0(struct bt_bap_chan, 1);
> -       chan->count =3D count;
> -       chan->location =3D location;
> -
> -       queue_push_tail(pac->channels, chan);
> -}
> -
> -static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint=
8_t *v,
> -                                       void *user_data)
> -{
> -       struct bt_bap_pac *pac =3D user_data;
> -
> -       if (!v)
> -               return;
> -
> -       bap_pac_chan_add(pac, *v, bt_bap_pac_get_locations(pac));
> -}
> -
> -static void bap_pac_update_channels(struct bt_bap_pac *pac, struct iovec=
 *data)
> -{
> -       uint8_t type =3D 0x03;
> -
> -       if (!data)
> -               return;
> -
> -       util_ltv_foreach(data->iov_base, data->iov_len, &type,
> -                               bap_pac_foreach_channel, pac);
> -
> -       /* If record didn't set a channel count but set a location use th=
at as
> -        * channel count.
> -        */
> -       if (queue_isempty(pac->channels) && pac->qos.location)
> -               bap_pac_chan_add(pac, pac->qos.location, pac->qos.locatio=
n);
> -
> -}
> -
>  static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
>                                         struct iovec *metadata)
>  {
> @@ -3901,9 +3852,6 @@ static void bap_pac_merge(struct bt_bap_pac *pac, s=
truct iovec *data,
>         else
>                 pac->data =3D util_iov_dup(data, 1);
>
> -       /* Update channels */
> -       bap_pac_update_channels(pac, data);
> -
>         /* Merge metadata into existing record */
>         if (pac->metadata)
>                 ltv_merge(pac->metadata, metadata);
> @@ -4845,6 +4793,8 @@ static void read_source_pac_loc(bool success, uint8=
_t att_ecode,
>
>         pacs->source_loc_value =3D get_le32(value);
>
> +       DBG(bap, "PACS Source Locations: 0x%08x", pacs->source_loc_value)=
;
> +
>         /* Resume reading sinks if supported but for some reason is empty=
 */
>         if (pacs->source && queue_isempty(bap->rdb->sources)) {
>                 uint16_t value_handle;
> @@ -4878,6 +4828,8 @@ static void read_sink_pac_loc(bool success, uint8_t=
 att_ecode,
>
>         pacs->sink_loc_value =3D get_le32(value);
>
> +       DBG(bap, "PACS Sink Locations: 0x%08x", pacs->sink_loc_value);
> +
>         /* Resume reading sinks if supported but for some reason is empty=
 */
>         if (pacs->sink && queue_isempty(bap->rdb->sinks)) {
>                 uint16_t value_handle;
> @@ -4911,6 +4863,9 @@ static void read_pac_context(bool success, uint8_t =
att_ecode,
>
>         pacs->sink_context_value =3D le16_to_cpu(ctx->snk);
>         pacs->source_context_value =3D le16_to_cpu(ctx->src);
> +
> +       DBG(bap, "PACS Sink Context: 0x%04x", pacs->sink_context_value);
> +       DBG(bap, "PACS Source Context: 0x%04x", pacs->source_context_valu=
e);
>  }
>
>  static void read_pac_supported_context(bool success, uint8_t att_ecode,
> @@ -4934,6 +4889,11 @@ static void read_pac_supported_context(bool succes=
s, uint8_t att_ecode,
>
>         pacs->supported_sink_context_value =3D le16_to_cpu(ctx->snk);
>         pacs->supported_source_context_value =3D le16_to_cpu(ctx->src);
> +
> +       DBG(bap, "PACS Supported Sink Context: 0x%04x",
> +                                       pacs->supported_sink_context_valu=
e);
> +       DBG(bap, "PACS Supported Source Context: 0x%04x",
> +                                       pacs->supported_source_context_va=
lue);
>  }
>
>  static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user=
_data)
> @@ -6113,12 +6073,55 @@ static bool match_pac(struct bt_bap_pac *lpac, st=
ruct bt_bap_pac *rpac,
>         return false;
>  }
>
> -int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> -                       int *count, bt_bap_pac_select_t func,
> -                       void *user_data)
> +static void bap_pac_ltv_ch_counts(size_t i, uint8_t l, uint8_t t, uint8_=
t *v,
> +                                                               void *use=
r_data)
>  {
> -       const struct queue_entry *lchan, *rchan;
> -       int selected =3D 0;
> +       uint8_t *mask =3D user_data;
> +
> +       if (v)
> +               *mask |=3D *v;
> +}
> +
> +static uint8_t bap_pac_ch_counts(struct bt_bap_pac *pac)
> +{
> +       uint8_t type =3D 0x03;
> +       uint8_t mask =3D 0;
> +
> +       if (!pac->data)
> +               return 0;
> +
> +       util_ltv_foreach(pac->data->iov_base, pac->data->iov_len, &type,
> +                                               bap_pac_ltv_ch_counts, &m=
ask);
> +
> +       if (!mask)
> +               mask =3D 0x01;  /* default (BAP v1.0.1 Sec 4.3.1) */
> +
> +       return mask;
> +}
> +
> +static unsigned int bap_count_eps(struct queue *eps, uint8_t dir)
> +{
> +       const struct queue_entry *entry;
> +       unsigned int count =3D 0;
> +
> +       for (entry =3D queue_get_entries(eps); entry; entry =3D entry->ne=
xt) {
> +               struct bt_bap_endpoint *ep =3D entry->data;
> +
> +               if (ep->dir =3D=3D dir)
> +                       count++;
> +       }
> +
> +       return count;
> +}
> +
> +int bt_bap_select(struct bt_bap *bap,
> +                       struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> +                       unsigned int max_channels, int *count,
> +                       bt_bap_pac_select_t func, void *user_data)
> +{
> +       uint32_t locations;
> +       uint8_t ch_counts;
> +       unsigned int num_ase;
>
>         if (!lpac || !rpac || !func)
>                 return -EINVAL;
> @@ -6126,66 +6129,54 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct=
 bt_bap_pac *rpac,
>         if (!lpac->ops || !lpac->ops->select)
>                 return -EOPNOTSUPP;
>
> -       for (lchan =3D queue_get_entries(lpac->channels); lchan;
> -                                       lchan =3D lchan->next) {
> -               struct bt_bap_chan *lc =3D lchan->data;
> -               struct bt_bap_chan map =3D *lc;
> -               int i;
> +       if (!max_channels)
> +               max_channels =3D 2;  /* By default: don't go beyond BAP A=
C */
>
> -               for (i =3D 0, rchan =3D queue_get_entries(rpac->channels)=
; rchan;
> -                                       rchan =3D rchan->next, i++) {
> -                       struct bt_bap_chan *rc =3D rchan->data;
> +       ch_counts =3D bap_pac_ch_counts(lpac) & bap_pac_ch_counts(rpac);
> +       locations =3D bt_bap_pac_get_locations(rpac);
> +       num_ase =3D bap_count_eps(bap->remote_eps, rpac->type);
>
> -                       /* Try matching the channel count */
> -                       if (!(map.count & rc->count))
> -                               break;
> +       /* Fallback to unspecified/mono allocation if nothing is matching=
 */
> +       if (!locations || !ch_counts) {
> +               lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_d=
ata,
> +                                                       lpac->user_data);
> +               if (count)
> +                       (*count)++;
> +               return 0;
> +       }
>
> -                       /* Check if location was set otherwise attempt to
> -                        * assign one based on the number of channels it
> -                        * supports.
> -                        */
> -                       if (!rc->location) {
> -                               rc->location =3D bt_bap_pac_get_locations=
(rpac);
> -                               /* If channel count is 1 use a single
> -                                * location
> -                                */
> -                               if (rc->count =3D=3D 0x01)
> -                                       rc->location &=3D BIT(i);
> -                       }
> +       /* Allocate all locations to streams */
> +       while (num_ase) {
> +               uint32_t allocation =3D 0, alloc =3D 0;
> +               unsigned int i, n;
>
> -                       /* Try matching the channel location */
> -                       if (!(map.location & rc->location))
> +               /* Put max number of channels per stream */
> +               for (i =3D 0, n =3D 0; i < 32 && n < 8; ++i) {
> +                       uint32_t loc =3D (1LL << i);
> +
> +                       if (!(locations & loc))
>                                 continue;
>
> -                       lpac->ops->select(lpac, rpac, map.location &
> -                                               rc->location, &rpac->qos,
> -                                               func, user_data,
> -                                               lpac->user_data);
> -                       selected++;
> +                       alloc |=3D loc;
> +                       if ((BIT(n) & ch_counts) && n < max_channels)
> +                               allocation =3D alloc;
>
> -                       /* Check if there are any channels left to select=
 */
> -                       map.count &=3D ~(map.count & rc->count);
> -                       /* Check if there are any locations left to selec=
t */
> -                       map.location &=3D ~(map.location & rc->location);
> -
> -                       if (!map.count || !map.location)
> -                               break;
> -
> -                       /* Check if device require AC*(i) settings */
> -                       if (rc->count =3D=3D 0x01)
> -                               map.count =3D map.count >> 1;
> +                       ++n;
>                 }
> -       }
>
> -       /* Fallback to no channel allocation since none could be matched.=
 */
> -       if (!selected) {
> -               lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_d=
ata,
> -                                       lpac->user_data);
> -               selected++;
> -       }
> +               if (!allocation)
> +                       break;
>
> -       if (count)
> -               *count +=3D selected;
> +               /* Configure stream */
> +               lpac->ops->select(lpac, rpac, allocation, &rpac->qos,
> +                                       func, user_data, lpac->user_data)=
;
> +               if (count)
> +                       (*count)++;
> +
> +               locations &=3D ~allocation;
> +               max_channels -=3D __builtin_popcount(allocation);
> +               num_ase--;
> +       }
>
>         return 0;
>  }
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index efeed604d..80e91f10a 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -172,9 +172,10 @@ void bt_bap_pac_set_user_data(struct bt_bap_pac *pac=
, void *user_data);
>  void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
>
>  /* Stream related functions */
> -int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> -                       int *count, bt_bap_pac_select_t func,
> -                       void *user_data);
> +int bt_bap_select(struct bt_bap *bap,
> +                       struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> +                       unsigned int max_channels, int *count,
> +                       bt_bap_pac_select_t func, void *user_data);
>
>  void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t f=
unc,
>                         void *user_data);
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
