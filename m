Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64813DDAA
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253138; cv=none; b=AvT8d7YhTduquABwMZRo0OX23c21ByOQpZIGPnWAKYDmKJypvsPZ1FMWt6JOmSgsyiqrT4urZEtpLFidUslWF0af8XIb1ftgLk+crGdT4HzA8vr7M2/G6L9tq7d3r+ZPPY39z3q1bges2SyONSxqOOzfaN6Tx3Ueh3ENL3pLX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253138; c=relaxed/simple;
	bh=Z64pus08o99Jhi4n9UQucOvnw8ZW7VjxvtGH9r7DAI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7cGKCcKhe73W9XkcoQFgvGiz4P63+RBZZIxndPU1cVODs6y0NBOcECm8gEAixAFxlsaj9HTmqWr6m5giBMWU1aX6AaSmrJRvWDbq1AhFc5toVvjoNavK25Ot3UuucGyufwTTk+3jI1I0Af11GxAt77hp6E8kKNbDSwncco2RI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt8MnKsz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt8MnKsz"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso39258431fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253135; x=1722857935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMYSw+1f4IhVWrNDmJtVcfbhY7P9h6f9Vh7nMOY/hVk=;
        b=Zt8MnKszCE2ygHGWbBN6+3JnYkhaG/9C6gMgK0MkcFgre1lukAE7wdbXC/cwBk7FTg
         RW5a8P97NcNcD4u9jzaw26utjEPvF5TUibFSdngNDf6OD7fxX9pq79r5wjmAdD0J9/WL
         SLe4OWoEZ5xEsXuJjad9SurgMZfeRob9Zikeh2m7tpF0SnPcDGUkV8KEMkjgoP1ubYyG
         TJYhaAogq8EM8ApTvExvHdv7qk7LIp8AjrJhxgyVmLGyIqIEcq/aDau5dhrb7ZACGtMs
         tkGPB7MNc40A3NeBECP0p0tLfEMLCkte8bCUpRxJaYO8LEfZuZ1mBhA/R2WoTrc6rrE8
         Y7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253135; x=1722857935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMYSw+1f4IhVWrNDmJtVcfbhY7P9h6f9Vh7nMOY/hVk=;
        b=VdFGPiefRYWJ/v24j1bLfqRmm427h4b57UjjS9tcxH0DPDyDqjMRMadgrgYI3FOHVN
         ei8dJf7u8HcTcgnm+XkMSRPtPK3ZTLKSlWOJBTcjTkaaukkz3T9nnBzo2kIOa7W3pF+8
         q+G4jEb/Hhbd4nyk1TW3MhG2bwFqnUBw2b7zQ1TlGrOP6xOm0bLFuWR8r9KfbqXVibmi
         zGhkR2/zuFQAuTJ6GQSlE+4aLKZDVLpBt7o75+DK0mURNQ8qdl3hVMatHUWUS67WKmmm
         nbItHfUgIFEsowCw6S9lVD0N/fklYMtb7aiJtkoKp7IZMFBEZWWypC9+JnR/9cbFiGfl
         971A==
X-Gm-Message-State: AOJu0YypWoMCAUyupucTp8Ga6JEWL9udgN4flVp0FBEf/k9QRgwLHaNM
	8sdZT/b3ExslJSGMr9QjCNT79Ls5zJKh0QTiJe2AF+XsP4Cl3HpzQl8/UAdKrKAwexhopGOqTIG
	MBxRGc0Nolz0Q2NSnXwPu22Bw/UsNp+urdbQ=
X-Google-Smtp-Source: AGHT+IFKsThdEbovihafTwnV9yhf8rQcADPbEMx1nwQ+7E3DAZalfzb4tB/ol/j5+e6H+1ka1Cw/fHb5NLDdLCrcqjs=
X-Received: by 2002:a2e:2205:0:b0:2f0:25dc:1886 with SMTP id
 38308e7fff4ca-2f12edf7fadmr45878931fa.10.1722253134476; Mon, 29 Jul 2024
 04:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81bcbcb669a6f329b7900fb0f6ff0c469ec7201f.1722082241.git.pav@iki.fi>
In-Reply-To: <81bcbcb669a6f329b7900fb0f6ff0c469ec7201f.1722082241.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jul 2024 12:38:41 +0100
Message-ID: <CABBYNZJVuMaUAZde2QEZowR-2RSqOOwYrTKdh=edDWu6YYxQFA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: improve channel allocation logic in bt_bap_select()
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Jul 27, 2024 at 1:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Currently bt_bap_select() determines the need for multi-stream
> configurations in a way that depends on accidental GATT detail (whether
> Locations is read before or after the PAC) that shouldn't have any
> effect on the configuration.
>
> Whether a device gets configured with 1 (AC 1) or 2 (AC 6i) sink ASEs,
> consider two devices: Galaxy Buds2 Pro:
>
>     profiles/audio/bap.c:bap_attached() 0x60e000001c40
>     src/shared/bap.c:foreach_pacs_char() PAC Context found: handle 0x0050
>     src/shared/bap.c:foreach_pacs_char() PAC Supported Context found: han=
dle 0x0053
>     src/shared/bap.c:foreach_pacs_char() Sink PAC Location found: handle =
0x0056
>     src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x0059
>
>     Sink PACS Locations: 0x401
>     One local PAC, with Locations: all bits
>     rpac bt_bap_chan.location =3D=3D 0x401 (PACS Locations read before PA=
C)
>     -> bt_select() ChannelAllocation: 0x401
>
> Earfun Air Pro 3:
>
>     profiles/audio/bap.c:bap_attached() 0x60e000001e00
>     src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x004b
>     src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x004e
>     src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x0051
>     src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x0054
>     src/shared/bap.c:foreach_pacs_char() Sink PAC Location found: handle =
0x0057
>
>     Sink PACS Locations: 0x3
>     One local PAC, with Locations: all bits
>     rpac bt_bap_chan.location =3D=3D 0x0 (PACS Locations read after PAC)
>     -> bt_select() ChannelAllocation: 0x1 (ASE 1)
>     -> bt_select() ChannelAllocation: 0x2 (ASE 2)
>
> Both devices have 2+ Sink ASEs and two bits set in Locations, but
> bt_bap_select() configures them differently. This occurs due to the
> "if (!rc->location) { ... rc->location &=3D BIT(i);" logic which gets ent=
ered
> only because of the ordering in which characteristics was read.  Without
> "&=3D BIT(i)" branch, "map.location &=3D ~(map.location & rc->location)"
> causes only one ASE be configured.  The behavior appears accidental,
> and e.g. the BIT(i) logic in general is wrong as the rpac index i doesn't
> have a relation to channel locations.

Yeah, I have a change for this one though so we don't read based on
the order of attributes found but use a fixed order to prevent that
rc->location has not been set kind of problem.

> Rewrite the multi-ASE configuration logic, and make it independent of
> chr read ordering.
>
> Decide first whether to configure 1 or 2 ASE.  Use 2 ASE if locations
> contain left/right channel pair and only 1 channel per ASE is supported.
>
> The "right" result depends on what you want to do so this heuristic
> tries to aim for a "common" configuration. See eg the above two devices:
> their PAC/ASE data only differs in which two location bits are set, but
> they need to be configured differently.
>
> If 1 ASE, leave channel allocation to sound server.
>
> If multiple ASE, multiplex as many as possible on each of them.
>
> Remove bt_bap_chan as it's not needed -- also the PACS Locations
> is global to the whole device and there are no per-PAC Locations in the
> specification, so probably we shouldn't have something like that in the
> internal model.

Well per server, yes they are global, but we do have location per
record as we could have multi entities registering PAC records we do
have an abstration to diferentiate them. Anyway this is a separate
problem which we might want to discuss after we fix the order problem.

> ---
>
> Notes:
>     The BAP specification doesn't say that the ordering of characteristic=
s
>     in the PACS service should have a meaning, and the current logic look=
s
>     wrong to me.
>
>     From what's written in the spec, I don't see that there is a "right"
>     configuration here to pick, so it seems we are forced to use some
>     heuristic here.  It is hardcoded here, and we probably should make so=
me
>     changes later on to make it possible for the sound server to control
>     which locations exactly are selected.
>
>     One design could be to have the local PAC provide a list of Locations
>     bitmasks, and BlueZ checks *in order* if the remote device has all th=
e
>     bits set in its Locations. If a match is found, BlueZ assigns exactly
>     those bits to ASEs using multiple ASE, if needed. Otherwise, BlueZ us=
es
>     a single ASE and punts the channel decision to the sound server.
>
>     This would more or less be the same as what is done in this patch,
>     except that the configs[] array is provided by the sound server in th=
e
>     local Client PAC.
>
>     Also, if there are multiple codecs, bt_bap_select() probably should t=
ry
>     to select them in order, and stop at the first successful selection.
>
>     An alternative would be to leave all this to the sound server: change
>     API so that SelectProperties() can return a multi-ASE configuration.
>
>     The sound server already has to handle low-level details such as
>     deciding which PAC configuration is best. This choice however depends=
 on
>     whether ASE multiplexing is done or not, so trying to do the decision
>     partly in BlueZ and partly in sound server probably just makes things
>     more complicated than they need to be. Sound server can first decide
>     what Locations to connect, then allocate PACs multiplexing as much as
>     possible. BAP Sec. 3.5.3 guarantees there are enough ASEs for all
>     location bits.

Yeah, maybe we need a flag or something to indicate if the
ChannelAllocation shall be attempted by bluetoothd or not, for
bluetoothctl Id prefer it that bluetoothd deals with that just to make
it simpler for thing like testing with PTS, etc, anyway Im traveling
right so we need to get back to this once Im back.

>
>  src/shared/bap.c | 196 ++++++++++++++++++++++-------------------------
>  1 file changed, 93 insertions(+), 103 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 499e740c9..b64399193 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -187,11 +187,6 @@ struct bt_bap {
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
> @@ -3249,50 +3244,6 @@ static void *ltv_merge(struct iovec *data, struct =
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
> @@ -3302,9 +3253,6 @@ static void bap_pac_merge(struct bt_bap_pac *pac, s=
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
> @@ -4178,6 +4126,8 @@ static void read_source_pac_loc(bool success, uint8=
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
> @@ -4211,6 +4161,8 @@ static void read_sink_pac_loc(bool success, uint8_t=
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
> @@ -5386,12 +5338,53 @@ static bool match_pac(struct bt_bap_pac *lpac, st=
ruct bt_bap_pac *rpac,
>         return false;
>  }
>
> +static void bap_pac_ltv_ch_counts(size_t i, uint8_t l, uint8_t t, uint8_=
t *v,
> +                                                               void *use=
r_data)
> +{
> +       uint8_t *mask =3D user_data;
> +
> +       if (v)
> +               *mask =3D *v;
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
>  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
>                         int *count, bt_bap_pac_select_t func,
>                         void *user_data)
>  {
> -       const struct queue_entry *lchan, *rchan;
> -       int selected =3D 0;
> +       uint32_t locations;
> +       uint8_t ch_counts;
> +       unsigned int i, num_ase;
> +
> +       /* Hardcoded supported (multi-ASE) configurations: L/R channel pa=
irs */
> +       static const uint32_t configs[] =3D {
> +               0x1 | 0x2,
> +               0x10 | 0x20,
> +               0x40 | 0x80,
> +               0x400 | 0x800,
> +               0x1000 | 0x2000,
> +               0x10000 | 0x30000,
> +               0x40000 | 0x80000,
> +               0x400000 | 0x800000,
> +               0x1000000 | 0x2000000,
> +               0x4000000 | 0x8000000,
> +       };
>
>         if (!lpac || !rpac || !func)
>                 return -EINVAL;
> @@ -5399,66 +5392,63 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct=
 bt_bap_pac *rpac,
>         if (!lpac->ops || !lpac->ops->select)
>                 return -EOPNOTSUPP;
>
> -       for (lchan =3D queue_get_entries(lpac->channels); lchan;
> -                                       lchan =3D lchan->next) {
> -               struct bt_bap_chan *lc =3D lchan->data;
> -               struct bt_bap_chan map =3D *lc;
> -               int i;
> +       ch_counts =3D bap_pac_ch_counts(lpac) & bap_pac_ch_counts(rpac);
> +       locations =3D bt_bap_pac_get_locations(rpac) & lpac->qos.location=
;
> +       num_ase =3D 1;
>
> -               for (i =3D 0, rchan =3D queue_get_entries(rpac->channels)=
; rchan;
> -                                       rchan =3D rchan->next, i++) {
> -                       struct bt_bap_chan *rc =3D rchan->data;
> +       /* Check if multi-ASE configuration is needed */
> +       for (i =3D 0; i < ARRAY_SIZE(configs); ++i) {
> +               unsigned int n =3D __builtin_popcount(configs[i]);
>
> -                       /* Try matching the channel count */
> -                       if (!(map.count & rc->count))
> -                               break;
> +               if (n =3D=3D 0 || n > 8 || (ch_counts & BIT(n - 1)))
> +                       continue;
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
> +               if ((locations & configs[i]) =3D=3D configs[i]) {
> +                       num_ase =3D n;
> +                       locations =3D configs[i];
> +                       break;
> +               }
> +       }
>
> -                       /* Try matching the channel location */
> -                       if (!(map.location & rc->location))
> -                               continue;
> +       /* Otherwise leave channel allocation to sound server */
> +       if (!locations || !ch_counts || num_ase =3D=3D 1) {
> +               lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_d=
ata,
> +                                                       lpac->user_data);
> +               if (count)
> +                       (*count)++;
> +               return 0;
> +       }
>
> -                       lpac->ops->select(lpac, rpac, map.location &
> -                                               rc->location, &rpac->qos,
> -                                               func, user_data,
> -                                               lpac->user_data);
> -                       selected++;
> +       /* Allocate channels */
> +       while (locations && num_ase > 0) {
> +               uint32_t allocation =3D 0, alloc =3D 0;
> +               unsigned int n;
>
> -                       /* Check if there are any channels left to select=
 */
> -                       map.count &=3D ~(map.count & rc->count);
> -                       /* Check if there are any locations left to selec=
t */
> -                       map.location &=3D ~(map.location & rc->location);
> +               /* Multiplex as many as possible */
> +               for (i =3D 0, n =3D 0; i < 32 && n < 8; ++i) {
> +                       if (!(locations & BIT(i)))
> +                               continue;
>
> -                       if (!map.count || !map.location)
> -                               break;
> +                       alloc |=3D BIT(i);
> +                       if (BIT(n) & ch_counts)
> +                               allocation =3D alloc;
>
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
> +
> +               /* Select */
> +               lpac->ops->select(lpac, rpac, allocation, &rpac->qos,
> +                                       func, user_data, lpac->user_data)=
;
>
> -       if (count)
> -               *count +=3D selected;
> +               locations &=3D ~allocation;
> +               --num_ase;
> +
> +               if (count)
> +                       (*count)++;
> +       }
>
>         return 0;
>  }
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
