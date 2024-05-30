Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92DA3B1A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088236; cv=pass; b=NYB/ssRJwi5qk3bA5vH0Jlx3UKFrctRwFXDfh3gj1OIiOhw41kcTj2jdR2d1OWOcjchKa6Y+JJwD5yn3wI2p0enm8rQH2VNdAsZ+0tEPH9hPqLlHTQloD92yLZr8c3cuzKzDhJ9CGdJPMHwb25FrrjITL0LqLpmd8jenI9QGXA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088236; c=relaxed/simple;
	bh=3iy1LEfyUHPpr5QUcGmaYe0nSQwItZbGWBzHhVkrQiU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGC3O2Gj+vM3HMOm+Afu5+2nq+Gqgc4+lGW37RKL6Nc3nUSn5G2SORpxzNL1HVy7dxgm73EUFS78tjjhN96zX6B8RlyO3OiOWXGJGjjbamMS1mKwNxjv1Le/mj/sggYDlRHU+ZRNyryT5bhm0yXVtqhB64hNekanbXIYKeIMYQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=X70kpsw8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="X70kpsw8"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VqsqN5ZMbz49Q5n;
	Thu, 30 May 2024 19:57:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1717088224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CbW2b58xbqKDslQhZb37zurMZg8ROq3m9DCMKuld0dk=;
	b=X70kpsw8Yq0vvwAtgBTy68VJ+UBKRbg7A31eP6V6gHHWNh1KA7O0fvD5NgpD3McfAlUbjn
	/7g9kSSvahhzvC5TPulOtozvKGvkjbTvkLn+3kxJ3HwPZhC/4ErqCLNKzRRx//S4qVSb9J
	UwK/RlL1uOHUXdvVF6kWtatWjlxs7sDhixa2N1+XRKPCc1qYwpqmaVWgOyrWNF2/h7ej1K
	UldkbyE5ohAw6893rC/ZpspCY++mYF6XxsmVYyQuaKdvrlz9qoblSvd07QIX1H3xpQbFWg
	DwfwKB9sgrS1ogyrQZmVHLO31wzANkN8Kn+XI+LoTwAe3eCgzNuAxq6E4PO3Aw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1717088224; a=rsa-sha256;
	cv=none;
	b=HCRuOrfaXEM9mOElODhuQZKbkAQnOhDEYfu60GRITRcNPMcq2lN7+i+NTTffdgGFoLpcbB
	UZk+kuTHRO6cl7fLvzl6YjT8gZjnh7/TiJDNfn9A5+sny/s7kN6Xox1la+2XAfv2uWAcyS
	Y59CXw7kbLUrHovfUBbmBLPSX9shOufQi8UdWX34zopLaG9hnQfXYbIMp7jRJOvpWingIK
	oUkUbb7XV7mSoGCcBZ6IEEK0s02Vt/71qCqDdnGQAj5v9wJ7WsU4kNJFASen507bQRJBhh
	pmUNt2eQQU3vHJeQz/LSuD2io9Tfs+8AvroUV4fB9B0b84Jk/YzUyQk7rNl5Gw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1717088224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CbW2b58xbqKDslQhZb37zurMZg8ROq3m9DCMKuld0dk=;
	b=PO3P7TyLFBhIQuOw05gakfhzfatOacz+frcj5WDHfQUxg3P91jco6LnWdDAtNtl/vbTpO7
	boqd/J3PEnMHio2YVHPHqIP5t9D+kI/NdfUHNR/oVQsu6OGT2xAKRdb/B6Kf+X7aPrDiDz
	FwhmJxHwefzHVZxX3F07oUvFVwsKa4hhOHh0h5dnsaYj7rRKV0CKFRPCVDposCLxfTOLS3
	6qhG/iN2EQpsAYe7merU2G4hP19L6lZwc4InDWAKsJ3X2ItYihivjxe9Z9c2kFfiPjvtyB
	WOg5PiL/QrFmihV8598ZajHjgVCsacHUGbWj5w0iiEMhxgFR0o10IVkNPGl7IQ==
Message-ID: <8c979897beeb8316616bb7c15f60093be177577c.camel@iki.fi>
Subject: Re: [BlueZ 9/9] avdtp: Fix manipulating struct as an array
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Thu, 30 May 2024 19:57:04 +0300
In-Reply-To: <20240530150057.444585-10-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
	 <20240530150057.444585-10-hadess@hadess.net>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2024-05-30 kello 16:58 +0200, Bastien Nocera kirjoitti:
> Don't manipulate the "req" structs as if they were flat arrays, static
> analysis and humans are both equally confused by this kind of usage.

struct start_req {
	union {
		struct seid required[1];
		struct seid seids[0];
	};
} __attribute__ ((packed));

and access only via req->seids?

>=20
> Error: ARRAY_VS_SINGLETON (CWE-119): [#def26] [important]
> bluez-5.76/profiles/audio/avdtp.c:1675:2: address_of: Taking address with=
 "&start->first_seid" yields a singleton pointer.
> bluez-5.76/profiles/audio/avdtp.c:1675:2: assign: Assigning: "seid" =3D "=
&start->first_seid".
> bluez-5.76/profiles/audio/avdtp.c:1679:25: ptr_arith: Using "seid" as an =
array.  This might corrupt or misinterpret adjacent memory locations.
> 1677|           int i;
> 1678|
> 1679|->         for (i =3D 0; i < count; i++, seid++) {
> 1680|                   if (seid->seid =3D=3D id) {
> 1681|                           req->collided =3D TRUE;
>=20
> Error: ARRAY_VS_SINGLETON (CWE-119): [#def27] [important]
> bluez-5.76/profiles/audio/avdtp.c:1690:2: address_of: Taking address with=
 "&suspend->first_seid" yields a singleton pointer.
> bluez-5.76/profiles/audio/avdtp.c:1690:2: assign: Assigning: "seid" =3D "=
&suspend->first_seid".
> bluez-5.76/profiles/audio/avdtp.c:1694:25: ptr_arith: Using "seid" as an =
array.  This might corrupt or misinterpret adjacent memory locations.
> 1692|		int i;
> 1693|
> 1694|->		for (i =3D 0; i < count; i++, seid++) {
> 1695|			if (seid->seid =3D=3D id) {
> 1696|				req->collided =3D TRUE;
>=20
> Error: ARRAY_VS_SINGLETON (CWE-119): [#def28] [important]
> bluez-5.76/profiles/audio/avdtp.c:1799:2: address_of: Taking address with=
 "&req->first_seid" yields a singleton pointer.
> bluez-5.76/profiles/audio/avdtp.c:1799:2: assign: Assigning: "seid" =3D "=
&req->first_seid".
> bluez-5.76/profiles/audio/avdtp.c:1801:30: ptr_arith: Using "seid" as an =
array.  This might corrupt or misinterpret adjacent memory locations.
> 1799|		seid =3D &req->first_seid;
> 1800|
> 1801|->		for (i =3D 0; i < seid_count; i++, seid++) {
> 1802|			failed_seid =3D seid->seid;
> 1803|
>=20
> Error: ARRAY_VS_SINGLETON (CWE-119): [#def29] [important]
> bluez-5.76/profiles/audio/avdtp.c:1912:2: address_of: Taking address with=
 "&req->first_seid" yields a singleton pointer.
> bluez-5.76/profiles/audio/avdtp.c:1912:2: assign: Assigning: "seid" =3D "=
&req->first_seid".
> bluez-5.76/profiles/audio/avdtp.c:1914:30: ptr_arith: Using "seid" as an =
array.  This might corrupt or misinterpret adjacent memory locations.
> 1912|		seid =3D &req->first_seid;
> 1913|
> 1914|->	for (i =3D 0; i < seid_count; i++, seid++) {
> 1915|			failed_seid =3D seid->seid;
> 1916|
> ---
>  profiles/audio/avdtp.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>=20
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 3667e08400dd..38c1870e619d 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -429,6 +429,20 @@ static void avdtp_sep_set_state(struct avdtp *sessio=
n,
>  				struct avdtp_local_sep *sep,
>  				avdtp_state_t state);
> =20
> +#define REQ_GET_NTH_SEID(x)						\
> +	static struct seid *						\
> +	x##_req_get_nth_seid(struct x##_req *req, int count, int i)	\
> +	{								\
> +		if (count =3D=3D 0 || i >=3D count)				\
> +			return NULL;					\
> +		if (i =3D=3D 1)						\
> +			return &req->first_seid;			\
> +		return &req->other_seids[i];				\

(i =3D=3D 0) and [i - 1]?

> +	}
> +
> +REQ_GET_NTH_SEID(start)
> +REQ_GET_NTH_SEID(suspend)
> +
>  static const char *avdtp_statestr(avdtp_state_t state)
>  {
>  	switch (state) {
> @@ -1672,11 +1686,11 @@ static void check_seid_collision(struct pending_r=
eq *req, uint8_t id)
>  static void check_start_collision(struct pending_req *req, uint8_t id)
>  {
>  	struct start_req *start =3D req->data;
> -	struct seid *seid =3D &start->first_seid;
>  	int count =3D 1 + req->data_size - sizeof(struct start_req);
>  	int i;
> =20
> -	for (i =3D 0; i < count; i++, seid++) {
> +	for (i =3D 0; i < count; i++) {
> +		struct seid *seid =3D start_req_get_nth_seid(start, count, i);
>  		if (seid->seid =3D=3D id) {
>  			req->collided =3D TRUE;
>  			return;
> @@ -1687,11 +1701,11 @@ static void check_start_collision(struct pending_=
req *req, uint8_t id)
>  static void check_suspend_collision(struct pending_req *req, uint8_t id)
>  {
>  	struct suspend_req *suspend =3D req->data;
> -	struct seid *seid =3D &suspend->first_seid;
>  	int count =3D 1 + req->data_size - sizeof(struct suspend_req);
>  	int i;
> =20
> -	for (i =3D 0; i < count; i++, seid++) {
> +	for (i =3D 0; i < count; i++) {
> +		struct seid *seid =3D suspend_req_get_nth_seid(suspend, count, i);
>  		if (seid->seid =3D=3D id) {
>  			req->collided =3D TRUE;
>  			return;
> @@ -1785,7 +1799,6 @@ static gboolean avdtp_start_cmd(struct avdtp *sessi=
on, uint8_t transaction,
>  	struct avdtp_local_sep *sep;
>  	struct avdtp_stream *stream;
>  	struct stream_rej rej;
> -	struct seid *seid;
>  	uint8_t err, failed_seid;
>  	int seid_count, i;
> =20
> @@ -1796,9 +1809,9 @@ static gboolean avdtp_start_cmd(struct avdtp *sessi=
on, uint8_t transaction,
> =20
>  	seid_count =3D 1 + size - sizeof(struct start_req);
> =20
> -	seid =3D &req->first_seid;
> +	for (i =3D 0; i < seid_count; i++) {
> +		struct seid *seid =3D start_req_get_nth_seid(req, seid_count, i);
> =20
> -	for (i =3D 0; i < seid_count; i++, seid++) {
>  		failed_seid =3D seid->seid;
> =20
>  		sep =3D find_local_sep_by_seid(session, seid->seid);
> @@ -1898,7 +1911,6 @@ static gboolean avdtp_suspend_cmd(struct avdtp *ses=
sion, uint8_t transaction,
>  	struct avdtp_local_sep *sep;
>  	struct avdtp_stream *stream;
>  	struct stream_rej rej;
> -	struct seid *seid;
>  	uint8_t err, failed_seid;
>  	int seid_count, i;
> =20
> @@ -1909,9 +1921,8 @@ static gboolean avdtp_suspend_cmd(struct avdtp *ses=
sion, uint8_t transaction,
> =20
>  	seid_count =3D 1 + size - sizeof(struct suspend_req);
> =20
> -	seid =3D &req->first_seid;
> -
> -	for (i =3D 0; i < seid_count; i++, seid++) {
> +	for (i =3D 0; i < seid_count; i++) {
> +		struct seid *seid =3D suspend_req_get_nth_seid(req, seid_count, i);
>  		failed_seid =3D seid->seid;
> =20
>  		sep =3D find_local_sep_by_seid(session, seid->seid);

