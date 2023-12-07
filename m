Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Po+Aa79Y"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208B612E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 10:00:15 -0800 (PST)
Received: from [192.168.1.195] (unknown [IPv6:2a02:20c8:4124::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SmMW13Frhz49Q2v;
	Thu,  7 Dec 2023 20:00:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1701972013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+dDRZOcKiOav8unEYIzqYpBiNuFEDqWThe+ibvnSpYc=;
	b=Po+Aa79YQ/h8Gbrf4Dp+G8UykYzxQqkfQjMpzu9qmt2fZ/iLMkS0klmOhv3jAuqTV1rHMp
	m+DjS4+c+aAwaDhV+DI2IRbavQAW7DkF8a4d+Ko0e/koPpBs7KI7GdiGXp3kMTm6DgNgJO
	depoRlRor2sdrBXri97Vhp4KkarJ7tHU9+ihR232J7zrpv4GXwaW8tPqn5CVRyhI5OfQKi
	z5GNdl0m1XEtFXl/uBEV9DdrTsTj/LLkGCvJs26wu+KaD7I0v9esS2YR0YdSuhlODlrGg6
	jNlJtCebnNLt0qEWFKdN79OvAW1jxkEsJyxKj9JODxzs9CTRYm3ybEcJjkF06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1701972013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+dDRZOcKiOav8unEYIzqYpBiNuFEDqWThe+ibvnSpYc=;
	b=M/9d99/2xniqMIJ320f+lpF4Y6FmBb8Zb4kkJkHIfdpMluV5hpsQ3Vb6/+3lAzyMayDKyx
	Xj+gbOeChWSWaIWuRN0HLybJZBECZOG8+9nmIafB80JXBtZcGjRc0w4uBAw3ErnpbGRO5G
	lQEp88EE1MBmUFES7mNgmG3+i5nIzxncRCOyTCdQvsDIl0diF5sxwv6kIt+5cMfl1NbMv/
	UzP5WxjA/7+THUPhGLaBiV1sTL522dEfiZQvOMCSCLyTIIiGdCXS+XAMiW1Dqw9QvP1DY3
	J4rsjpI8WHeDvqXKvvY1izH82klLwnHuny+p1iAYH15AcOV6fDV2QuyrQZj0QA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1701972013; a=rsa-sha256;
	cv=none;
	b=HoulA1LIw0lFC2LF3hALlZTsP9jvirAD/WDntHSzuHRuoB2ZwfmoNzw65+ahkGT70JOQjk
	K3JbgRvCTbbrR4mLF2DSEbCpoC182IAU0/C+FALMFTpKnuKr9XRSp9iEDnPl7DllizpcOd
	YFWQTSLzUuenB+9vZfyz+IxpMwGIVXyeFCzrIjySdK0KXttWMV9B6lmpfgg1IHSThHa9mw
	uAjmLQ/INBEmxE4wCIWg3VlygL+3On0HXrHoQvo4wHNRDMZrHG9pzjuOsV8ZRASttlxsJK
	MyPZ2KoqJsWI6Dh+wBy7V4bN7j/5JuBHK0NyjWsBxB8lzk9PLA7ckBcJdAx8ww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <ddfb204f3692f6a96e4ab0a72553fe9f6f224329.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1 2/2] shared/bap: Make bt_bap_select match the
 channel map
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 07 Dec 2023 20:00:12 +0200
In-Reply-To: <20231206220325.3712902-2-luiz.dentz@gmail.com>
References: <20231206220325.3712902-1-luiz.dentz@gmail.com>
	 <20231206220325.3712902-2-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ke, 2023-12-06 kello 17:03 -0500, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> bt_bap_pac may actually map to multiple PAC records and each may have a
> different channel count that needs to be matched separately, for
> instance when trying with EarFun Air Pro:
>=20
> < ACL Data TX: Handle 2048 flags 0x00 dlen 85
>       ATT: Write Command (0x52) len 80
>         Handle: 0x0098 Type: ASE Control Point (0x2bc6)
>           Data: 010405020206000000000a020103020201030428000602020600000
> 	  0000a0201030202010304280001020206000000000a020103020201030428
> 	  0002020206000000000a02010302020103042800
>             Opcode: Codec Configuration (0x01)
>             Number of ASE(s): 4
>             ASE: #0
>             ASE ID: 0x05
>             Target Latency: Balance Latency/Reliability (0x02)
>             PHY: 0x02
>             LE 2M PHY (0x02)
>             Codec: LC3 (0x06)
>             Codec Specific Configuration: #0: len 0x02 type 0x01
>               Sampling Frequency: 16 Khz (0x03)
>             Codec Specific Configuration: #1: len 0x02 type 0x02
>               Frame Duration: 10 ms (0x01)
>             Codec Specific Configuration: #2: len 0x03 type 0x04
>               Frame Length: 40 (0x0028)
>             ASE: #1
>             ASE ID: 0x06
>             Target Latency: Balance Latency/Reliability (0x02)
>             PHY: 0x02
>             LE 2M PHY (0x02)
>             Codec: LC3 (0x06)
>             Codec Specific Configuration: #0: len 0x02 type 0x01
>               Sampling Frequency: 16 Khz (0x03)
>             Codec Specific Configuration: #1: len 0x02 type 0x02
>               Frame Duration: 10 ms (0x01)
>             Codec Specific Configuration: #2: len 0x03 type 0x04
>               Frame Length: 40 (0x0028)
>             ASE: #2
>             ASE ID: 0x01
>             Target Latency: Balance Latency/Reliability (0x02)
>             PHY: 0x02
>             LE 2M PHY (0x02)
>             Codec: LC3 (0x06)
>             Codec Specific Configuration: #0: len 0x02 type 0x01
>               Sampling Frequency: 16 Khz (0x03)
>             Codec Specific Configuration: #1: len 0x02 type 0x02
>               Frame Duration: 10 ms (0x01)
>             Codec Specific Configuration: #2: len 0x03 type 0x04
>               Frame Length: 40 (0x0028)
>             ASE: #3
>             ASE ID: 0x02
>             Target Latency: Balance Latency/Reliability (0x02)
>             PHY: 0x02
>             LE 2M PHY (0x02)
>             Codec: LC3 (0x06)
>             Codec Specific Configuration: #0: len 0x02 type 0x01
>               Sampling Frequency: 16 Khz (0x03)
>             Codec Specific Configuration: #1: len 0x02 type 0x02
>               Frame Duration: 10 ms (0x01)
>             Codec Specific Configuration: #2: len 0x03 type 0x04
>               Frame Length: 40 (0x0028)
>=20
> Fixes: https://github.com/bluez/bluez/issues/612
> ---
>  profiles/audio/bap.c |  6 +--
>  src/shared/bap.c     | 87 ++++++++++++++++++++++++++++++++++++++++----
>  src/shared/bap.h     |  3 +-
>  src/shared/util.c    | 43 ++++++++++++++++++++++
>  src/shared/util.h    |  6 +++
>  5 files changed, 132 insertions(+), 13 deletions(-)
>=20
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 965d7efe6561..16c5faee45f9 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1290,10 +1290,8 @@ static bool pac_found(struct bt_bap_pac *lpac, str=
uct bt_bap_pac *rpac,
>  	}
> =20
>  	/* TODO: Cache LRU? */
> -	if (btd_service_is_initiator(service)) {
> -		if (!bt_bap_select(lpac, rpac, select_cb, ep))
> -			ep->data->selecting++;
> -	}
> +	if (btd_service_is_initiator(service))
> +		bt_bap_select(lpac, rpac, &ep->data->selecting, select_cb, ep);
> =20
>  	return true;
>  }
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index a1495ca84bcc..2450b53232e3 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -185,6 +185,7 @@ struct bt_bap_pac {
>  	struct bt_bap_pac_qos qos;
>  	struct iovec *data;
>  	struct iovec *metadata;
> +	struct queue *chan_map;
>  	struct bt_bap_pac_ops *ops;
>  	void *user_data;
>  };
> @@ -2417,6 +2418,33 @@ static void *ltv_merge(struct iovec *data, struct =
iovec *cont)
>  	return iov_append(data, cont->iov_len, cont->iov_base);
>  }
> =20
> +static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint=
8_t *v,
> +					void *user_data)
> +{
> +	struct bt_bap_pac *pac =3D user_data;
> +
> +	if (!v)
> +		return;
> +
> +	if (!pac->chan_map)
> +		pac->chan_map =3D queue_new();
> +
> +	printf("PAC %p chan_map 0x%02x\n", pac, *v);
> +
> +	queue_push_tail(pac->chan_map, UINT_TO_PTR(*v));
> +}
> +
> +static void bap_pac_update_chan_map(struct bt_bap_pac *pac, struct iovec=
 *data)
> +{
> +	uint8_t type =3D 0x03;
> +
> +	if (!data)
> +		return;
> +
> +	util_ltv_foreach(data->iov_base, data->iov_len, &type,
> +				bap_pac_foreach_channel, pac);
> +}

Hmm, I though Supported_Audio_Channel_Counts (0x3) is not a channel
mapping, but enumerates what number of channels each PAC supports?

So e.g. 0x3 =3D supports 1 or 2 channels, and the PAC could be used to
configure either case.


IIUC in BAP v1.0.1 Sec. 4.4 the configuration is supposed to work like
this:

1. From the bits set in PACS Sink/Source Locations, select which
channels we are going to configure for sink and source directions.

2. Decide which channel goes to which ASE.

3. Supported_Audio_Channel_Counts in PACs limit how many channels we
can put on a single ASE.

4. The outcome probably should prefer the standard stream
configurations defined in BAP.

5. For each ASE Config Codec, set the channel bits in
Audio_Channel_Allocation to indicate which channels the ASE got.

From the specification I don't quite see how the PACs play role
otherwise in the channel allocation, but maybe I am missing something.


I think there's a difficulty in how to split the work between BlueZ and
the sound server here, e.g., if SelectProperties is called many times
how can it set the audio channel allocation correctly.


> +
>  static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
>  					struct iovec *metadata)
>  {
> @@ -2426,6 +2454,9 @@ static void bap_pac_merge(struct bt_bap_pac *pac, s=
truct iovec *data,
>  	else
>  		pac->data =3D util_iov_dup(data, 1);
> =20
> +	/* Update channel map */
> +	bap_pac_update_chan_map(pac, data);
> +
>  	/* Merge metadata into existing record */
>  	if (pac->metadata)
>  		ltv_merge(pac->metadata, metadata);
> @@ -2448,10 +2479,9 @@ static struct bt_bap_pac *bap_pac_new(struct bt_ba=
p_db *bdb, const char *name,
>  	pac->type =3D type;
>  	if (codec)
>  		pac->codec =3D *codec;
> -	if (data)
> -		pac->data =3D util_iov_dup(data, 1);
> -	if (metadata)
> -		pac->metadata =3D util_iov_dup(metadata, 1);
> +
> +	bap_pac_merge(pac, data, metadata);
> +
>  	if (qos)
>  		pac->qos =3D *qos;
> =20
> @@ -2465,6 +2495,7 @@ static void bap_pac_free(void *data)
>  	free(pac->name);
>  	util_iov_free(pac->metadata, 1);
>  	util_iov_free(pac->data, 1);
> +	queue_destroy(pac->chan_map, NULL);
>  	free(pac);
>  }
> =20
> @@ -4505,7 +4536,16 @@ static bool find_ep_pacs(const void *data, const v=
oid *user_data)
>  	if (ep->stream->lpac !=3D match->lpac)
>  		return false;
> =20
> -	return ep->stream->rpac =3D=3D match->rpac;
> +	if (ep->stream->rpac !=3D match->rpac)
> +		return false;
> +
> +	switch (ep->state) {
> +	case BT_BAP_STREAM_STATE_CONFIG:
> +	case BT_BAP_STREAM_STATE_QOS:
> +		return true;
> +	}
> +
> +	return false;
>  }
> =20
>  static struct bt_bap_req *bap_req_new(struct bt_bap_stream *stream,
> @@ -4626,16 +4666,47 @@ static bool match_pac(struct bt_bap_pac *lpac, st=
ruct bt_bap_pac *rpac,
>  }
> =20
>  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> -			bt_bap_pac_select_t func, void *user_data)
> +			int *count, bt_bap_pac_select_t func,
> +			void *user_data)
>  {
> +	const struct queue_entry *lchan, *rchan;
> +
>  	if (!lpac || !rpac || !func)
>  		return -EINVAL;
> =20
>  	if (!lpac->ops || !lpac->ops->select)
>  		return -EOPNOTSUPP;
> =20
> -	lpac->ops->select(lpac, rpac, &rpac->qos,
> -					func, user_data, lpac->user_data);
> +	for (lchan =3D queue_get_entries(lpac->chan_map); lchan;
> +					lchan =3D lchan->next) {
> +		uint8_t lmap =3D PTR_TO_UINT(lchan->data);
> +
> +		for (rchan =3D queue_get_entries(rpac->chan_map); rchan;
> +					rchan =3D rchan->next) {
> +			uint8_t rmap =3D PTR_TO_UINT(rchan->data);
> +
> +			printf("lmap 0x%02x rmap 0x%02x\n", lmap, rmap);
> +
> +			/* Try matching the channel mapping */
> +			if (lmap & rmap) {
> +				lpac->ops->select(lpac, rpac, &rpac->qos,
> +							func, user_data,
> +							lpac->user_data);
> +				if (count)
> +					(*count)++;
> +
> +				/* Check if there are any channels left */
> +				lmap &=3D ~(lmap & rmap);
> +				if (!lmap)
> +					break;
> +
> +				/* Check if device require AC*(i) settings */
> +				if (rmap =3D=3D 0x01)
> +					lmap =3D lmap >> 1;
> +			} else
> +				break;
> +		}
> +	}
> =20
>  	return 0;
>  }
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 2c8f9208e6ba..470313e66fc0 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -234,7 +234,8 @@ void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac=
);
> =20
>  /* Stream related functions */
>  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> -			bt_bap_pac_select_t func, void *user_data);
> +			int *count, bt_bap_pac_select_t func,
> +			void *user_data);
> =20
>  struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
>  					struct bt_bap_pac *lpac,
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 34491f4e5a56..c0c2c4a17f12 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -175,6 +175,49 @@ ltv_debugger(const struct util_ltv_debugger *debugge=
r, size_t num, uint8_t type)
>  	return NULL;
>  }
> =20
> +/* Helper to itertate over LTV entries */
> +bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *type,
> +			util_ltv_func_t func, void *user_data)
> +{
> +	struct iovec iov;
> +	int i;
> +
> +	if (!func)
> +		return false;
> +
> +	iov.iov_base =3D (void *) data;
> +	iov.iov_len =3D len;
> +
> +	for (i =3D 0; iov.iov_len; i++) {
> +		uint8_t l, t, *v;
> +
> +		if (!util_iov_pull_u8(&iov, &l))
> +			return false;
> +
> +		if (!l) {
> +			func(i, l, 0, NULL, user_data);
> +			continue;
> +		}
> +
> +		if (!util_iov_pull_u8(&iov, &t))
> +			return false;
> +
> +		l--;
> +
> +		if (l) {
> +			v =3D util_iov_pull_mem(&iov, l);
> +			if (!v)
> +				return false;
> +		} else
> +			v =3D NULL;
> +
> +		if (!type || *type =3D=3D t)
> +			func(i, l, t, v, user_data);
> +	}
> +
> +	return true;
> +}
> +
>  /* Helper to print debug information of LTV entries */
>  bool util_debug_ltv(const uint8_t *data, uint8_t len,
>  			const struct util_ltv_debugger *debugger, size_t num,
> diff --git a/src/shared/util.h b/src/shared/util.h
> index 6698d00415de..596663b8519c 100644
> --- a/src/shared/util.h
> +++ b/src/shared/util.h
> @@ -138,6 +138,12 @@ bool util_debug_ltv(const uint8_t *data, uint8_t len=
,
>  			const struct util_ltv_debugger *debugger, size_t num,
>  			util_debug_func_t function, void *user_data);
> =20
> +typedef void (*util_ltv_func_t)(size_t i, uint8_t l, uint8_t t, uint8_t =
*v,
> +					void *user_data);
> +
> +bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *type,
> +			util_ltv_func_t func, void *user_data);
> +
>  unsigned char util_get_dt(const char *parent, const char *name);
> =20
>  ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags);

--=20
Pauli Virtanen
