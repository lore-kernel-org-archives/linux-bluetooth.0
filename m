Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421430DD2E
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061835; cv=pass; b=F7CO/KbjRIyWHSqqYKdjuBqElQdIdsKUHbEH/WVBQA9jijdOHpGQuVijngwEcKs8aX2qPxgscFJKaoJcp8Hw7496DCojDwMpQUlt1MdnwX9ItCcUsdKCTqwiPrwSjbwaGdtVVz0Kiy+XlrdDwCjHYTwCh0rohpxcsdBTnJDfQMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061835; c=relaxed/simple;
	bh=/tttduubOGy20Hlqnx1Ys9s+FMGDBfvGw/LgR4+PYqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FlkfVNnr1JnRaOWnxbmn6Vi6q4yM+crxHDYjqrXGFmSclvARjR2mShtJxVHRldStMza6iChS/YBo2uILj1VWe/jd83g4cS91LplpCLi0rexnESLqcq1nk7dCA96AdJDVW4uLRubt7wcmKvr3zao06+1IlhUviqtHIHxXSHyHd4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=v3gtQNiW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="v3gtQNiW"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d6qv70vDYz49Pwn;
	Thu, 13 Nov 2025 21:23:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1763061827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zzweijwFf7eaYiEC5S9bMBZfLJh0xDJ87tfz52bkmA=;
	b=v3gtQNiW4ZWqb5OvtPhshrGa8VGYqLshSQAHwSl5GRznYEF7/cdRV7tqrj881trRz5CEYS
	xubxbGtrWAa5jwl36teqUyTdv+IeybZ7qPbY5IBS9un1l0xlFpHv2dpo8b453/GdFFryxN
	Kc/J0CpHKQqNyLMtfjtydgl0oMtCznxpkxKaO80+pfpZ1bVzRyq0dDEbq+mjniQQyrCwTh
	8rK6qhaYzaucWu+PwjD9aFmqkVBomIbMDKm+FobszRMc2/4+zRES6XWVW3nuqlCJTL22rI
	LLzBgG+rUDhCU7w7qJBK518Q1+caWMnK3DFxH7HzONYPE0kJCQLzySN63plgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1763061827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zzweijwFf7eaYiEC5S9bMBZfLJh0xDJ87tfz52bkmA=;
	b=sDXn5DOLJFiVXiDcON4xOnY6PZznrQyDpJecXGKmpj2JdMdHbYKHtW6JWOijgcOSlSFlIW
	U+0Cw4zNuyB5vnpvIfSicGgAJAEq/5KrZn5WtJC8GiQEfuqZy1r7AKm5ElXUiNT3xU/riC
	QAwb7+Rh0XZ8wkwsphZQ6hL+Ar+py2lKduI7DlfHPtKEK7JakU52XT+ycP8tOHedlJA3eL
	8xMOlxOTGIJOGzcPTQGoZ/nOP/9hy0w4Nipsyxw5mHVh3tgj8qLjpbdvJi51RwBA5OewDg
	1xP/Ef40lf0BH+3fkA9vlNrt0yyOjpRGZFiwgjwf+uvfmTKIX53yXUvNlphBnQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1763061827;
	b=GOZV520n4ehzjeVpcV/MwAGSkESDen2IWRXfbOfQniU5pTP53RJKT8Ps9oJOpPUa1r91NM
	A8tLVI5Kb5JrX6O3UbFam4MVyfUAcQ8B6mvBaIpmGvp4Wb2UTYhiMlvEGXeQZwNlj2M4pv
	xV61mH2JsmsefFqcM8cNkZ3IUHLNkGF0e8dx3uz7rDKosTETyDieCogwuNQST39/bwG/t4
	S70jXV8MBzvyGjO2Nlfq5qR/zPrFpwwCmY6hevDqjpJJLN7Nzsc7V5Osi/qKAinLxLNxDk
	i1zdsVxt8pkDs85W5xlztnKJhnNQ9FRXnNcWPuOFIhcKAd6UYdz9wRQsfwpFhg==
Message-ID: <2f50eaa140bbd6de7ad3248d4b3800fcf4c916a5.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 1/4] shared/bap: fix channel allocation logic
 in bt_bap_select()
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 13 Nov 2025 21:23:46 +0200
In-Reply-To: <CABBYNZJMK-D_RwgWbmRU-tkN68UBC+9ys5WyV8O9uvhNqdwJ6A@mail.gmail.com>
References: 
	<69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
	 <CABBYNZJMK-D_RwgWbmRU-tkN68UBC+9ys5WyV8O9uvhNqdwJ6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

to, 2025-11-13 kello 13:34 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Nov 13, 2025 at 12:59=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > bt_bap_select() does not correctly determine the need for multi-stream
> > configurations 6,7,8,9,11(i), as its result depends on whether Audio
> > Locations is read before or after the PACs, doesn't work with general
> > location bits, etc.
> >=20
> > Fix the procedure to be simpler: create streams for all locations, up t=
o
> > a specific number of channels.  By default, limit to max 2 channels per
> > direction for compatibility (BAP doesn't have explicit AC with larger
> > channel counts.) Also simplify the code.
> >=20
> > Ignore lpac Locations when selecting: the value mostly makes sense for
> > Unicast Server role, but Client and Server cannot use the same value as
> > only a few bits can be set. As Client, we should be able to configure
> > any Location bits.  The sound server can simply ignore our suggested
> > channel allocation if really needed, or use SetConfiguration() API to
> > build custom configurations.
>=20
> Have you tried with any headset that actually supports AC #(i)? Afaik
> those are the ones, e.g.  EarFun Air Pro 3, where the current setup
> was tested against.

I tested this with Pipewire (which uses the channel allocation given by
BlueZ) and

- Samsung Galaxy Buds2 Pro
- Sony Linkbuds S
- EarFun Air Pro 3  (dev firmware, iirc official didn't have LE Audio)
- EarFun Air Pro 4  (official firmware)
- Pipewire <-> Pipewire

Samsung & Sony get AC 6(ii) and 11(ii), depending on selected profile
in pactl.

Both EarFun devices get AC 6(i) and AC 11(i).

Pipewire<->Pipewire gets AC 4. For the duplex case it gets FL/FR SNK +
FL/FR SRC which is not one of the examples in BAP, due to the SNK/SRC
Audio Locations PW exports as server by default. This is not new
behavior though, it worked like this also before this patch.

We might actually want to start moving more of the logic that the sound
server currently has to figure out to bt_bap_select(), like filtering
PACs=C2=A0to mandatory supported configurations, eg 48kHz PACs don't
necessarily work in bidirectional configurations unless the device has
UGT 80 kbps Source in its GMAP service.

> > ---
> >=20
> > Notes:
> >     v2:
> >     - fix getting number of ASEs
> >=20
> >  profiles/audio/bap.c |   3 +-
> >  src/shared/bap.c     | 205 +++++++++++++++++++++----------------------
> >  src/shared/bap.h     |   7 +-
> >  3 files changed, 104 insertions(+), 111 deletions(-)
> >=20
> > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> > index 85bba9543..ec3502b06 100644
> > --- a/profiles/audio/bap.c
> > +++ b/profiles/audio/bap.c
> > @@ -1919,7 +1919,8 @@ static bool pac_select(struct bt_bap_pac *lpac, s=
truct bt_bap_pac *rpac,
> >                 queue_push_tail(select->eps, ep);
> >         }
> >=20
> > -       bt_bap_select(lpac, rpac, &select->remaining, select_cb, ep);
> > +       bt_bap_select(data->bap, lpac, rpac, 0, &select->remaining,
> > +                                                               select_=
cb, ep);
> >=20
> >         return true;
> >  }
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index a18f393f7..b779f6716 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -204,11 +204,6 @@ struct bt_bap {
> >         void *user_data;
> >  };
> >=20
> > -struct bt_bap_chan {
> > -       uint8_t count;
> > -       uint32_t location;
> > -};
> > -
> >  struct bt_bap_pac {
> >         struct bt_bap_db *bdb;
> >         char *name;
> > @@ -3848,50 +3843,6 @@ static void *ltv_merge(struct iovec *data, struc=
t iovec *cont)
> >         return util_iov_append(data, cont->iov_base, cont->iov_len);
> >  }
> >=20
> > -static void bap_pac_chan_add(struct bt_bap_pac *pac, uint8_t count,
> > -                               uint32_t location)
> > -{
> > -       struct bt_bap_chan *chan;
> > -
> > -       if (!pac->channels)
> > -               pac->channels =3D queue_new();
> > -
> > -       chan =3D new0(struct bt_bap_chan, 1);
> > -       chan->count =3D count;
> > -       chan->location =3D location;
> > -
> > -       queue_push_tail(pac->channels, chan);
> > -}
> > -
> > -static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, ui=
nt8_t *v,
> > -                                       void *user_data)
> > -{
> > -       struct bt_bap_pac *pac =3D user_data;
> > -
> > -       if (!v)
> > -               return;
> > -
> > -       bap_pac_chan_add(pac, *v, bt_bap_pac_get_locations(pac));
> > -}
> > -
> > -static void bap_pac_update_channels(struct bt_bap_pac *pac, struct iov=
ec *data)
> > -{
> > -       uint8_t type =3D 0x03;
> > -
> > -       if (!data)
> > -               return;
> > -
> > -       util_ltv_foreach(data->iov_base, data->iov_len, &type,
> > -                               bap_pac_foreach_channel, pac);
> > -
> > -       /* If record didn't set a channel count but set a location use =
that as
> > -        * channel count.
> > -        */
> > -       if (queue_isempty(pac->channels) && pac->qos.location)
> > -               bap_pac_chan_add(pac, pac->qos.location, pac->qos.locat=
ion);
> > -
> > -}
> > -
> >  static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
> >                                         struct iovec *metadata)
> >  {
> > @@ -3901,9 +3852,6 @@ static void bap_pac_merge(struct bt_bap_pac *pac,=
 struct iovec *data,
> >         else
> >                 pac->data =3D util_iov_dup(data, 1);
> >=20
> > -       /* Update channels */
> > -       bap_pac_update_channels(pac, data);
> > -
> >         /* Merge metadata into existing record */
> >         if (pac->metadata)
> >                 ltv_merge(pac->metadata, metadata);
> > @@ -4845,6 +4793,8 @@ static void read_source_pac_loc(bool success, uin=
t8_t att_ecode,
> >=20
> >         pacs->source_loc_value =3D get_le32(value);
> >=20
> > +       DBG(bap, "PACS Source Locations: 0x%08x", pacs->source_loc_valu=
e);
> > +
> >         /* Resume reading sinks if supported but for some reason is emp=
ty */
> >         if (pacs->source && queue_isempty(bap->rdb->sources)) {
> >                 uint16_t value_handle;
> > @@ -4878,6 +4828,8 @@ static void read_sink_pac_loc(bool success, uint8=
_t att_ecode,
> >=20
> >         pacs->sink_loc_value =3D get_le32(value);
> >=20
> > +       DBG(bap, "PACS Sink Locations: 0x%08x", pacs->sink_loc_value);
> > +
> >         /* Resume reading sinks if supported but for some reason is emp=
ty */
> >         if (pacs->sink && queue_isempty(bap->rdb->sinks)) {
> >                 uint16_t value_handle;
> > @@ -4911,6 +4863,9 @@ static void read_pac_context(bool success, uint8_=
t att_ecode,
> >=20
> >         pacs->sink_context_value =3D le16_to_cpu(ctx->snk);
> >         pacs->source_context_value =3D le16_to_cpu(ctx->src);
> > +
> > +       DBG(bap, "PACS Sink Context: 0x%04x", pacs->sink_context_value)=
;
> > +       DBG(bap, "PACS Source Context: 0x%04x", pacs->source_context_va=
lue);
> >  }
> >=20
> >  static void read_pac_supported_context(bool success, uint8_t att_ecode=
,
> > @@ -4934,6 +4889,11 @@ static void read_pac_supported_context(bool succ=
ess, uint8_t att_ecode,
> >=20
> >         pacs->supported_sink_context_value =3D le16_to_cpu(ctx->snk);
> >         pacs->supported_source_context_value =3D le16_to_cpu(ctx->src);
> > +
> > +       DBG(bap, "PACS Supported Sink Context: 0x%04x",
> > +                                       pacs->supported_sink_context_va=
lue);
> > +       DBG(bap, "PACS Supported Source Context: 0x%04x",
> > +                                       pacs->supported_source_context_=
value);
> >  }
> >=20
> >  static void foreach_pacs_char(struct gatt_db_attribute *attr, void *us=
er_data)
> > @@ -6113,12 +6073,55 @@ static bool match_pac(struct bt_bap_pac *lpac, =
struct bt_bap_pac *rpac,
> >         return false;
> >  }
> >=20
> > -int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> > -                       int *count, bt_bap_pac_select_t func,
> > -                       void *user_data)
> > +static void bap_pac_ltv_ch_counts(size_t i, uint8_t l, uint8_t t, uint=
8_t *v,
> > +                                                               void *u=
ser_data)
> >  {
> > -       const struct queue_entry *lchan, *rchan;
> > -       int selected =3D 0;
> > +       uint8_t *mask =3D user_data;
> > +
> > +       if (v)
> > +               *mask |=3D *v;
> > +}
> > +
> > +static uint8_t bap_pac_ch_counts(struct bt_bap_pac *pac)
> > +{
> > +       uint8_t type =3D 0x03;
> > +       uint8_t mask =3D 0;
> > +
> > +       if (!pac->data)
> > +               return 0;
> > +
> > +       util_ltv_foreach(pac->data->iov_base, pac->data->iov_len, &type=
,
> > +                                               bap_pac_ltv_ch_counts, =
&mask);
> > +
> > +       if (!mask)
> > +               mask =3D 0x01;  /* default (BAP v1.0.1 Sec 4.3.1) */
> > +
> > +       return mask;
> > +}
> > +
> > +static unsigned int bap_count_eps(struct queue *eps, uint8_t dir)
> > +{
> > +       const struct queue_entry *entry;
> > +       unsigned int count =3D 0;
> > +
> > +       for (entry =3D queue_get_entries(eps); entry; entry =3D entry->=
next) {
> > +               struct bt_bap_endpoint *ep =3D entry->data;
> > +
> > +               if (ep->dir =3D=3D dir)
> > +                       count++;
> > +       }
> > +
> > +       return count;
> > +}
> > +
> > +int bt_bap_select(struct bt_bap *bap,
> > +                       struct bt_bap_pac *lpac, struct bt_bap_pac *rpa=
c,
> > +                       unsigned int max_channels, int *count,
> > +                       bt_bap_pac_select_t func, void *user_data)
> > +{
> > +       uint32_t locations;
> > +       uint8_t ch_counts;
> > +       unsigned int num_ase;
> >=20
> >         if (!lpac || !rpac || !func)
> >                 return -EINVAL;
> > @@ -6126,66 +6129,54 @@ int bt_bap_select(struct bt_bap_pac *lpac, stru=
ct bt_bap_pac *rpac,
> >         if (!lpac->ops || !lpac->ops->select)
> >                 return -EOPNOTSUPP;
> >=20
> > -       for (lchan =3D queue_get_entries(lpac->channels); lchan;
> > -                                       lchan =3D lchan->next) {
> > -               struct bt_bap_chan *lc =3D lchan->data;
> > -               struct bt_bap_chan map =3D *lc;
> > -               int i;
> > +       if (!max_channels)
> > +               max_channels =3D 2;  /* By default: don't go beyond BAP=
 AC */
> >=20
> > -               for (i =3D 0, rchan =3D queue_get_entries(rpac->channel=
s); rchan;
> > -                                       rchan =3D rchan->next, i++) {
> > -                       struct bt_bap_chan *rc =3D rchan->data;
> > +       ch_counts =3D bap_pac_ch_counts(lpac) & bap_pac_ch_counts(rpac)=
;
> > +       locations =3D bt_bap_pac_get_locations(rpac);
> > +       num_ase =3D bap_count_eps(bap->remote_eps, rpac->type);
> >=20
> > -                       /* Try matching the channel count */
> > -                       if (!(map.count & rc->count))
> > -                               break;
> > +       /* Fallback to unspecified/mono allocation if nothing is matchi=
ng */
> > +       if (!locations || !ch_counts) {
> > +               lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user=
_data,
> > +                                                       lpac->user_data=
);
> > +               if (count)
> > +                       (*count)++;
> > +               return 0;
> > +       }
> >=20
> > -                       /* Check if location was set otherwise attempt =
to
> > -                        * assign one based on the number of channels i=
t
> > -                        * supports.
> > -                        */
> > -                       if (!rc->location) {
> > -                               rc->location =3D bt_bap_pac_get_locatio=
ns(rpac);
> > -                               /* If channel count is 1 use a single
> > -                                * location
> > -                                */
> > -                               if (rc->count =3D=3D 0x01)
> > -                                       rc->location &=3D BIT(i);
> > -                       }
> > +       /* Allocate all locations to streams */
> > +       while (num_ase) {
> > +               uint32_t allocation =3D 0, alloc =3D 0;
> > +               unsigned int i, n;
> >=20
> > -                       /* Try matching the channel location */
> > -                       if (!(map.location & rc->location))
> > +               /* Put max number of channels per stream */
> > +               for (i =3D 0, n =3D 0; i < 32 && n < 8; ++i) {
> > +                       uint32_t loc =3D (1LL << i);
> > +
> > +                       if (!(locations & loc))
> >                                 continue;
> >=20
> > -                       lpac->ops->select(lpac, rpac, map.location &
> > -                                               rc->location, &rpac->qo=
s,
> > -                                               func, user_data,
> > -                                               lpac->user_data);
> > -                       selected++;
> > +                       alloc |=3D loc;
> > +                       if ((BIT(n) & ch_counts) && n < max_channels)
> > +                               allocation =3D alloc;
> >=20
> > -                       /* Check if there are any channels left to sele=
ct */
> > -                       map.count &=3D ~(map.count & rc->count);
> > -                       /* Check if there are any locations left to sel=
ect */
> > -                       map.location &=3D ~(map.location & rc->location=
);
> > -
> > -                       if (!map.count || !map.location)
> > -                               break;
> > -
> > -                       /* Check if device require AC*(i) settings */
> > -                       if (rc->count =3D=3D 0x01)
> > -                               map.count =3D map.count >> 1;
> > +                       ++n;
> >                 }
> > -       }
> >=20
> > -       /* Fallback to no channel allocation since none could be matche=
d. */
> > -       if (!selected) {
> > -               lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user=
_data,
> > -                                       lpac->user_data);
> > -               selected++;
> > -       }
> > +               if (!allocation)
> > +                       break;
> >=20
> > -       if (count)
> > -               *count +=3D selected;
> > +               /* Configure stream */
> > +               lpac->ops->select(lpac, rpac, allocation, &rpac->qos,
> > +                                       func, user_data, lpac->user_dat=
a);
> > +               if (count)
> > +                       (*count)++;
> > +
> > +               locations &=3D ~allocation;
> > +               max_channels -=3D __builtin_popcount(allocation);
> > +               num_ase--;
> > +       }
> >=20
> >         return 0;
> >  }
> > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > index efeed604d..80e91f10a 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -172,9 +172,10 @@ void bt_bap_pac_set_user_data(struct bt_bap_pac *p=
ac, void *user_data);
> >  void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
> >=20
> >  /* Stream related functions */
> > -int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> > -                       int *count, bt_bap_pac_select_t func,
> > -                       void *user_data);
> > +int bt_bap_select(struct bt_bap *bap,
> > +                       struct bt_bap_pac *lpac, struct bt_bap_pac *rpa=
c,
> > +                       unsigned int max_channels, int *count,
> > +                       bt_bap_pac_select_t func, void *user_data);
> >=20
> >  void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t=
 func,
> >                         void *user_data);
> > --
> > 2.51.1
> >=20
> >=20
>=20
