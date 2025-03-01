Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD81B3927
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846419; cv=pass; b=pDfjnpbUb2mxzEfkhBK0NNs1m0Aj/m3HqtiYJtnmdt28NcFZomkZAJLjn8IgJJ7me782FtrT9PQwIn6TNCfWW105R0gXD/2m9kFXGygVeupJ9UGhH1VcNoVniMLxDvseUvb3coFwHCCoS1580NBlxp0dDcJxNChzTlm6fZpSQQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846419; c=relaxed/simple;
	bh=6P3BEVCYEVtb+A82QfL/vrpqK0wX8i7Ey54EiYn33F8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJEst7d/ixh9wKui4L4vwZ9VDod+glCuGxZF5QUrc5s2OjoNYyBOBD2yjprKAA1jRyKibmwAOD5atd1hpqT28STziTseowjF8HhwN1SHVDgk9PUMDO5LReTJU98lA19p2LYlio5hVgXs9m19MAMio1azV+I4Ze5scHB+nTE+5BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=OG2nLS8m; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="OG2nLS8m"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4r7f5bcfz4BKH9
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 18:26:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740846415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yft6duKyF4ogVTG+O4TF5n+iZLnJEXyuHMaDz/0wIw0=;
	b=OG2nLS8mO3BKJRreYHAieaokcuMNAV5Fj1y9lrjaxk0iPRjyxzyG+LOA2fro1A2WksGNu8
	dp5JrfyYQx1zJOBJhftyREbuUGLVmUwEFX/uTmy3lBnY0nnguzXBfHgQLvL8lzMQCm9aHe
	iNDKijaAjGVv1SXhd/Xow5CwDM8u3TwUiepEMDADVVkwo5czSYGp87dA8JkhQZGTUhoG5u
	eMj4HKgo/8J4upPeJzH7hXqQRLGFAAgOw6LxxFZLN9oMYVRoMASYKw3lGe7bPV3AXsFgOn
	Ckqy3WnbFGgHA5lC8YjcqU6t0iSrEYAVX8Q4wujoYL5TRgxTjcsxG08o2z+Fig==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740846415; a=rsa-sha256;
	cv=none;
	b=rB9XQU2wkCt4rBRowp4cYD6C8cy3srUvpleKRfJvlDUVe3RkNYTJOMEKpQ5BU+QZHLO7/M
	J9wGeq3GM24KNf1lHvhXzX0Tcqmjo2EmRRchwCpnGQdT1aVZ6jJx0MBY+vJ+lVprM2UqF6
	hYIMVbNSw7K8L6obVc2ufQm932wxjhnTMQ1No3x4GvwpBULkN/JE7+z5hyZGJHRpZY9NGR
	wovzzNQIbe65/cwy8FZbHMKpYJeS7wSeBAAClcL1dbarQWg705/A/8gLeilCQFGx05g7WS
	B6lbPdT1ukipv12clolIeWF/VDmgOWcyQeD77B+xKSyOm4+Du5EuGoUkllLxYQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740846415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yft6duKyF4ogVTG+O4TF5n+iZLnJEXyuHMaDz/0wIw0=;
	b=QsLqzOTl/klFrh0oI6ck/OGKSXS9NOquuw+vOtX8GTPyqSRjSNl9Lx0UlW7wNM9/mE6dBp
	PycAz3/wEv/Tt8RcMLuexsIcPP1+cuzoHbX8JL8cA02v3UEJGvmdf9pBXoj/TG03ns2vHh
	zRTxTUa353obTlYyDkri4bwzGfpVz2SVMZHDp19an8A21P2QYv9AjLuExPcAK7I9w43BQE
	vRwLzW8tZkLQ4Z0Firgcs32uHFFWYdIrbF0nfHbSYWTYh+iOk5k3CYnKLxwihL7O3BT0Og
	eRK5KgwN6HVKUMYYkezu9i9LKoc/9qjH+Xs4lp9zLxpBQBftVejsEWABHNKKBQ==
Message-ID: <718e840dc3a3089f9a8bd24887191617e234c02a.camel@iki.fi>
Subject: Re: [RFC PATCH BlueZ 6/9] shared/bap: make sure ucast client stream
 is destroyed after releasing
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 01 Mar 2025 18:26:53 +0200
In-Reply-To: <5f103220d38f8eb549eb41ac971d1f4cf1e684ba.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
	 <5f103220d38f8eb549eb41ac971d1f4cf1e684ba.1740844616.git.pav@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

la, 2025-03-01 kello 17:57 +0200, Pauli Virtanen kirjoitti:
> Upper layer as Unicast Client needs to be able to destroy streams when
> it wants to reconfigure endpoints.
>=20
> This does not currently work right, because of Server issued
> Releasing->Config (caching) state transitions, which currently cause
> streams never enter Idle (so they are never destroyed).
>=20
> Fix this by considering Releasing->Config as Releasing->Idle->Config.
> Also do not make new streams from cached config data as Unicast Client,
> and leave all stream configuration to upper layer.

This change also implies the following, so that reconfiguring multi-ASE
configurations works right:

    shared/bap: ucast client streams always use a free ASE
   =20
    Because upper layer controls Unicast Client streams, bt_bap_stream_new(=
)
    should for unicast always allocate an unused ASE.

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4f44db07a..a85169009 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5836,29 +5836,6 @@ static bool find_ep_unused(const void *data, const v=
oid *user_data)
 		return true;
 }
=20
-static bool find_ep_pacs(const void *data, const void *user_data)
-{
-	const struct bt_bap_endpoint *ep =3D data;
-	const struct match_pac *match =3D user_data;
-
-	if (!ep->stream)
-		return false;
-
-	if (ep->stream->lpac !=3D match->lpac)
-		return false;
-
-	if (ep->stream->rpac !=3D match->rpac)
-		return false;
-
-	switch (ep->state) {
-	case BT_BAP_STREAM_STATE_CONFIG:
-	case BT_BAP_STREAM_STATE_QOS:
-		return true;
-	}
-
-	return false;
-}
-
 static bool find_ep_source(const void *data, const void *user_data)
 {
 	const struct bt_bap_endpoint *ep =3D data;
@@ -6053,15 +6030,11 @@ static struct bt_bap_stream *bap_ucast_stream_new(s=
truct bt_bap *bap,
 	match.lpac =3D lpac;
 	match.rpac =3D rpac;
=20
-	/* Check for existing stream */
-	ep =3D queue_find(bap->remote_eps, find_ep_pacs, &match);
+	/* Find unused ASE */
+	ep =3D queue_find(bap->remote_eps, find_ep_unused, &match);
 	if (!ep) {
-		/* Check for unused ASE */
-		ep =3D queue_find(bap->remote_eps, find_ep_unused, &match);
-		if (!ep) {
-			DBG(bap, "Unable to find unused ASE");
-			return NULL;
-		}
+		DBG(bap, "Unable to find unused ASE");
+		return NULL;
 	}
=20
 	stream =3D ep->stream;



> ---
>  src/shared/bap.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 54c6e8629..4f44db07a 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1363,6 +1363,31 @@ static void bap_stream_state_changed(struct bt_bap=
_stream *stream)
>  	struct bt_bap *bap =3D stream->bap;
>  	const struct queue_entry *entry;
> =20
> +	switch (stream->ep->old_state) {
> +	case BT_ASCS_ASE_STATE_RELEASING:
> +		/* After Releasing, Server may either transition to Config or
> +		 * Idle. Our Unicast Client streams shall be considered
> +		 * destroyed after Releasing, so that upper layer can control
> +		 * stream creation. Make the lifecycle management simpler by
> +		 * making sure the streams are destroyed by always emitting Idle
> +		 * to upper layer after Releasing, even if the remote ASE did
> +		 * not go through that state.
> +		 */
> +		if (stream->client &&
> +				stream->ep->state !=3D BT_ASCS_ASE_STATE_IDLE &&
> +				(stream->lpac->type & (BT_BAP_SINK |
> +							BT_BAP_SOURCE))) {
> +			struct bt_bap_endpoint *ep =3D stream->ep;
> +			uint8_t state =3D ep->state;
> +
> +			ep->state =3D BT_ASCS_ASE_STATE_IDLE;
> +			bap_stream_state_changed(stream);
> +			ep->state =3D state;
> +			return;
> +		}
> +		break;
> +	}
> +
>  	/* Pre notification updates */
>  	switch (stream->ep->state) {
>  	case BT_ASCS_ASE_STATE_IDLE:
> @@ -4851,7 +4876,8 @@ static void ep_status_config(struct bt_bap *bap, st=
ruct bt_bap_endpoint *ep,
>  	}
> =20
>  	/* Any previously applied codec configuration may be cached by the
> -	 * server.
> +	 * server. However, all Unicast Client stream creation shall be left to
> +	 * the upper layer.
>  	 */
>  	if (!ep->stream) {
>  		struct match_pac match;
> @@ -4866,7 +4892,9 @@ static void ep_status_config(struct bt_bap *bap, st=
ruct bt_bap_endpoint *ep,
>  		if (!match.lpac || !match.rpac)
>  			return;
> =20
> -		bap_stream_new(bap, ep, match.lpac, match.rpac, NULL, true);
> +		if (!(match.lpac->type & (BT_BAP_SINK | BT_BAP_SOURCE)))
> +			bap_stream_new(bap, ep, match.lpac, match.rpac,
> +								NULL, true);
>  	}
> =20
>  	if (!ep->stream)

