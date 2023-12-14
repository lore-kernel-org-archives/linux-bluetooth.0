Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="uFG8+Tom"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CFA8E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 08:55:24 -0800 (PST)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Srdkw6bvCz49Q3t;
	Thu, 14 Dec 2023 18:55:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1702572921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/qLcC+OjSMj1sv51SLAUZNNnRFrqCu+n3okXya4P46Y=;
	b=uFG8+Tome4Ugvnrda2GShGrfect97Fi/rXN8mkKd9DE9z1DQWUyGpX4o96C6gj28ILA74S
	aGWnbMsLESA5Nl3hjfum1y55g7TfLnKrT9F8+fraZLQMhkKjkPDfmhaW4edrZISAO2meXy
	u4fMUMpV5YhKzWhpMiYgkWTHIoKTlMBjgQHpONZCJDQdKdHJiNihdkBrhJOXA3o6Up2KG+
	36ubACx0RXap2o0rw4dmeFwWh1zg6qUcsi3jL3ZANnQywZMdY6V3IupxFKPX4e3zg+AkHg
	SBNam6qVdjdoNEyvMZX2D4ifU2yEngw/X8tN000x/Wgq471DQ5n0K3S65AhwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1702572921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/qLcC+OjSMj1sv51SLAUZNNnRFrqCu+n3okXya4P46Y=;
	b=vWdjvG+yENO8MG7Nh/lOF+t6YAb62YGteM0XOXlUtbeHgHOWm6h6qo/YhHnIUIINy8OPJd
	v4ECNqFRqAIN86GnppsDPD06rcRJHqjSZK/fgunDwQYoAErgUuxvks8hkGh1FaWGWoXXbE
	0110nlohswRtHHe9ysoZp5Kcq0WjrX3v5nye40gXDmJrll6R942divqwMuzCTY5ANDI9kp
	yaCZebPTibbw+VynYCSl+Yv+CkXtHfO3XC8u7FsfZbMjGyfT+zZ06OXMOKQi5iJvKQ6hzf
	1HRIVYoLaYVjK3LbDPRoQFbnsPDtIOeAcVVqDSwfeausGs19tbAzDP1outQgaA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1702572921; a=rsa-sha256;
	cv=none;
	b=CV+neXU5/fBmxBNk8mEK+4APevtIRzfr22k7RTZi8Wk5Pr8nZVxOfMxwKLJHCItzNkNN8d
	X9QI5PchIjjL29IlSLL52sOHQy5drrjqd6g/M05sfuVTaCF5aOc51chnz3mtvrQ6ykfukL
	NnDdGq9GUXlUpicJ6X2ZMXL+7oDpSXxXpFFzde4I03qH6qziXBkzHAdiJndITl3wFsaYOu
	zapDEUIfpSTOnDk1B/lXlaK4nWTyNh25e2bf5pQAxpoXBzgyAx4j7Ej32wIKozsgcsSI1q
	4DBGYtJnLprMhEP6B0EG5Rg1vYNCGx5L1XvlhYbbHZEHtSqrOnL29ixQrzYm+Q==
Message-ID: <c1cb409b1b76f7825ea84b13b0b2d94146eda2a7.camel@iki.fi>
Subject: Re: [PATCH BlueZ v4 4/6] shared/bap: Make bt_bap_select select a
 location
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 14 Dec 2023 18:55:17 +0200
In-Reply-To: <20231211212516.577426-4-luiz.dentz@gmail.com>
References: <20231211212516.577426-1-luiz.dentz@gmail.com>
	 <20231211212516.577426-4-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2023-12-11 kello 16:25 -0500, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > This makes bt_bap_select select a location based on the PAC channel
> > count and PACS locations, this is then passed to the Endpoint as a
> > recommended ChannelAllocation.
> > ---
> >  profiles/audio/media.c |  6 ++-
> >  src/shared/bap.c       | 88 +++++++++++++++++++++++++++---------------
> >  src/shared/bap.h       |  2 +-
> >  3 files changed, 63 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 62f53defa7af..b17c555b63e4 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -921,7 +921,7 @@ done:
> >  }
> > =20
> >  static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac=
,
> > -			struct bt_bap_pac_qos *qos,
> > +			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
> >  			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
> >  {
> >  	struct media_endpoint *endpoint =3D user_data;
> > @@ -969,6 +969,10 @@ static int pac_select(struct bt_bap_pac *lpac, str=
uct bt_bap_pac *rpac,
> >  		g_dbus_dict_append_entry(&dict, "Locations", DBUS_TYPE_UINT32,
> >  									&loc);
> > =20
> > +	if (chan_alloc)
> > +		g_dbus_dict_append_entry(&dict, "ChannelAllocation",
> > +					 DBUS_TYPE_UINT32, &chan_alloc);
> > +
> >  	if (metadata) {
> >  		key =3D "Metadata";
> >  		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index cb505d1564d6..e1dad95aca99 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -177,6 +177,11 @@ struct bt_bap {
> >  	void *user_data;
> >  };
> > =20
> > +struct bt_bap_chan {
> > +	uint8_t count;
> > +	uint32_t location;
> > +};
> > +
> >  struct bt_bap_pac {
> >  	struct bt_bap_db *bdb;
> >  	char *name;
> > @@ -185,7 +190,7 @@ struct bt_bap_pac {
> >  	struct bt_bap_pac_qos qos;
> >  	struct iovec *data;
> >  	struct iovec *metadata;
> > -	struct queue *chan_map;
> > +	struct queue *channels;
> >  	struct bt_bap_pac_ops *ops;
> >  	void *user_data;
> >  };
> > @@ -2422,19 +2427,22 @@ static void bap_pac_foreach_channel(size_t i, u=
int8_t l, uint8_t t, uint8_t *v,
> >  					void *user_data)
> >  {
> >  	struct bt_bap_pac *pac =3D user_data;
> > +	struct bt_bap_chan *chan;
> > =20
> >  	if (!v)
> >  		return;
> > =20
> > -	if (!pac->chan_map)
> > -		pac->chan_map =3D queue_new();
> > +	if (!pac->channels)
> > +		pac->channels =3D queue_new();
> > =20
> > -	printf("PAC %p chan_map 0x%02x\n", pac, *v);
> > +	chan =3D new0(struct bt_bap_chan, 1);
> > +	chan->count =3D *v;
> > +	chan->location =3D bt_bap_pac_get_locations(pac) ? : pac->qos.locatio=
n;
> > =20
> > -	queue_push_tail(pac->chan_map, UINT_TO_PTR(*v));
> > +	queue_push_tail(pac->channels, chan);
> >  }
> > =20
> > -static void bap_pac_update_chan_map(struct bt_bap_pac *pac, struct iov=
ec *data)
> > +static void bap_pac_update_channels(struct bt_bap_pac *pac, struct iov=
ec *data)
> >  {
> >  	uint8_t type =3D 0x03;
> > =20
> > @@ -2454,8 +2462,8 @@ static void bap_pac_merge(struct bt_bap_pac *pac,=
 struct iovec *data,
> >  	else
> >  		pac->data =3D util_iov_dup(data, 1);
> > =20
> > -	/* Update channel map */
> > -	bap_pac_update_chan_map(pac, data);
> > +	/* Update channels */
> > +	bap_pac_update_channels(pac, data);
> > =20
> >  	/* Merge metadata into existing record */
> >  	if (pac->metadata)
> > @@ -2495,7 +2503,7 @@ static void bap_pac_free(void *data)
> >  	free(pac->name);
> >  	util_iov_free(pac->metadata, 1);
> >  	util_iov_free(pac->data, 1);
> > -	queue_destroy(pac->chan_map, NULL);
> > +	queue_destroy(pac->channels, free);
> >  	free(pac);
> >  }
> > =20
> > @@ -4677,34 +4685,52 @@ int bt_bap_select(struct bt_bap_pac *lpac, stru=
ct bt_bap_pac *rpac,
> >  	if (!lpac->ops || !lpac->ops->select)
> >  		return -EOPNOTSUPP;
> > =20
> > -	for (lchan =3D queue_get_entries(lpac->chan_map); lchan;
> > +	for (lchan =3D queue_get_entries(lpac->channels); lchan;
> >  					lchan =3D lchan->next) {
> > -		uint8_t lmap =3D PTR_TO_UINT(lchan->data);
> > +		struct bt_bap_chan *lc =3D lchan->data;
> > +		uint8_t lmap =3D lc->count;
> > +		int i;
> > =20
> > -		for (rchan =3D queue_get_entries(rpac->chan_map); rchan;
> > -					rchan =3D rchan->next) {
> > -			uint8_t rmap =3D PTR_TO_UINT(rchan->data);
> > +		printf("lmap 0x%02x\n", lmap);
> > =20
> > -			printf("lmap 0x%02x rmap 0x%02x\n", lmap, rmap);
> > +		for (i =3D 0, rchan =3D queue_get_entries(rpac->channels); rchan;
> > +					rchan =3D rchan->next, i++) {
> > +			struct bt_bap_chan *rc =3D rchan->data;
> > =20
> > -			/* Try matching the channel mapping */
> > -			if (lmap & rmap) {
> > -				lpac->ops->select(lpac, rpac, &rpac->qos,
> > -							func, user_data,
> > -							lpac->user_data);
> > -				if (count)
> > -					(*count)++;
> > +			printf("rc->count 0x%02x\n", rc->count);
> > =20
> > -				/* Check if there are any channels left */
> > -				lmap &=3D ~(lmap & rmap);
> > -				if (!lmap)
> > -					break;
> > -
> > -				/* Check if device require AC*(i) settings */
> > -				if (rmap =3D=3D 0x01)
> > -					lmap =3D lmap >> 1;
> > -			} else
> > +			/* Try matching the channel count */
> > +			if (!(lmap & rc->count))
> >  				break;
> > +
> > +			/* Check if location was set otherwise attempt to
> > +			 * assign one based on the number of channels it
> > +			 * supports.
> > +			 */
> > +			if (!rc->location) {
> > +				rc->location =3D bt_bap_pac_get_locations(rpac);
> > +				/* If channel count is 1 use a single
> > +				 * location
> > +				 */
> > +				if (rc->count =3D=3D 0x01)
> > +					rc->location &=3D BIT(i);
> > +			}
> > +
> > +			lpac->ops->select(lpac, rpac, lc->location &
> > +						rc->location, &rpac->qos,
> > +						func, user_data,
> > +						lpac->user_data);
> > +			if (count)
> > +				(*count)++;

If sound server PAC supports both 1 and 2 channels, and remote PAC only
support 1 channel, and two streams are set up: then it looks like sound
server would be called two times with same ChannelAllocation so it'd
likely set up two left channels.

This code perhaps should first decide the bitmask of locations that
will be set up, and then in each call to select() pass only the so far
unallocated location bits.

I'll try to find some time to set things up to test this in Pipewire,
where we need some changes to enable multiple streams per device but it
should be straightforward.

> > +
> > +			/* Check if there are any channels left to select */
> > +			lmap &=3D ~(lmap & rc->count);
> > +			if (!lmap)
> > +				break;
> > +
> > +			/* Check if device require AC*(i) settings */
> > +			if (rc->count =3D=3D 0x01)
> > +				lmap =3D lmap >> 1;
> >  		}
> >  	}
> > =20
> > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > index 470313e66fc0..9be198cec72c 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -151,7 +151,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *d=
b, const char *name,
> > =20
> >  struct bt_bap_pac_ops {
> >  	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> > -			struct bt_bap_pac_qos *qos,
> > +			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
> >  			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
> >  	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
> >  			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,

--=20
Pauli Virtanen
