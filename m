Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC601D934B
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160170; cv=pass; b=S1XX4V3WtyBGbMQb4NljURNL0UQsIfYWTnQouKYenQNOHir7szGLmZ6mUvT0IKhurnhNx00gG3HB+Vn3c1Xg6f7/+GXSssXJymL2PJ1cgrv5acvYJg9DLmQYNvgKo10zl4ozzNGXjSvi7jvpnlzjZ9gSSg54tY1W2ZGf0mke+eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160170; c=relaxed/simple;
	bh=PN4ym7M50Mz6rjV/mTsZNXrOS7X5TK7fWv/q8TNLdCg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEWF28xWCxi4CDvKC7JCJwfikQqXPV7yUiI35htB6QqU1bSuEE18NiqB9na3pz2yjEPrHSZ5QLhcz6Q70XMpz/3Rg8yAhunbHRESj+LPw/h8yFM080D21DxJJANFU0jhyQzdhdVgbjCYozITA4FnItv8TUNKZRwR2TjME45e4bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=cBTQKJK1; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="cBTQKJK1"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YRW3L0BZkz49Pv9;
	Mon,  6 Jan 2025 12:42:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1736160158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZTabNSEKlpNUC9sLzHFWHK1CoK+x2xuNUvATYLyRUFg=;
	b=cBTQKJK1FOaVE5BP/cIJwb+73pQ4UPHbOEwhtbiWzoDZH39OuSC94MirEtEEfcKzE9xE+/
	tT3qGm+1+XO5u3QQXCFxOneeEWlATXvis2QnjdSF1IMFzkgeS3NukAt9WggNrgLXUnryop
	u3mZZLUuJ773bFTwGwVqzE7slrH08NM3hgnvJEfVsihLyTEDe8q8AKprEqEPo2fo8HBDTQ
	+Xoetb5RCSP67ue7zMnZfcGyvFEh0JIIEuZZphjAXjOwOmg1OwSwD9t6HXJ7ixbEyxhr8g
	p8S1iKwrfHV+fRw4hqS2wvXWfCWK0hxrD94kpLY4mVr3MSxXFZrZR+vhVmVFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1736160158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZTabNSEKlpNUC9sLzHFWHK1CoK+x2xuNUvATYLyRUFg=;
	b=aYzI28a6E1AgaP4RAzeRiL4MF/hSlmLu/gdp4V/EE8VqJ0k8rD6SYk6CWAjxxgAMjE1IAV
	FqZTO4N+m5chvpK116czlEj7W2R1AZ4N3vtpEUpfxGeqy6jXyZiCZLNQDCL8SxYG3uJ4Dz
	P5ThgcrPm6AYb9bhktCdtNGIzgX0BoE8CsE9dTuztO0JtsgsDWyeKAy2ALK849FA0JkmX3
	EMKJJmyhVgigHgFQ6Zg4kLalh2x4O06BM71eNHPGiN7BcIPN+45yhO6pRyJ8v1yzvUk4Li
	At11FcswZK/oScmx3mw8fRMp+gJHgP6iRsEZCvMQJRWH3DB1XPrV02TFuDuI1w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1736160158; a=rsa-sha256;
	cv=none;
	b=lFZWjqIfCuMTY94WtkTeFP+YR5UsHxzMHoJocRdFp2WjPr0n10PyisdPxb0M5ZABwf19Yn
	kWyhscFBvoMdeGTic5+Gmpy2Q29dU/an3UinxKJjFzIOOIwKRL65Pnb5EHjC9dgaXNc7W0
	DVKHkHInhD73lT+L1IXJ8pWlzeDaCwGfm94b4wx4z3nvtwpYzFT5oAsQIQwMnnd64qbW96
	0JAqFlRyg3F75ldwle14zKrsJsABGoUD0NC6PTgAPRrQKa71YLGPdEjXQKBSvd1iFkCmOL
	1AfLbQYVQ3mEi4pYzMOT7n0kYf9ypgZSa22ycjuuaPbt4trbbeDh1e6cUgbJTg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <3a4176205845541cb9c8b34b9f2b38d7c83b9088.camel@iki.fi>
Subject: Re: [PATCH BlueZ bluez] bap: fixed issue of muting music silent
 after pause and resume.
From: Pauli Virtanen <pav@iki.fi>
To: yang.li@amlogic.com, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Date: Mon, 06 Jan 2025 12:42:36 +0200
In-Reply-To: <20250106-upstream-v1-1-a16879b78ffd@amlogic.com>
References: <20250106-upstream-v1-1-a16879b78ffd@amlogic.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-01-06 kello 10:50 +0800, Yang Li via B4 Relay kirjoitti:
> From: Yang Li <yang.li@amlogic.com>
>=20
> CIS sink need caching the Codec Configured when releasing by Pixel,
> state machine is releasing -> Codec. If streamming -> idle, CIS sink
> was silent after resume music.

AFAIK, ASCS v1.0.1 =C2=A75.9 does not require that codec configuration be
cached.

>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  src/shared/bap.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>=20
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 167501282..a7f5dec92 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1063,6 +1063,28 @@ static void stream_notify_metadata(struct bt_bap_s=
tream *stream)
>  	free(status);
>  }
> =20
> +static void stream_notify_release(struct bt_bap_stream *stream)
> +{
> +	struct bt_bap_endpoint *ep =3D stream->ep;
> +	struct bt_ascs_ase_status *status;
> +	size_t len;
> +
> +	DBG(stream->bap, "stream %p", stream);
> +
> +	len =3D sizeof(*status);
> +	status =3D malloc(len);
> +
> +	memset(status, 0, len);
> +	status->id =3D ep->id;
> +	ep->state =3D BT_BAP_STREAM_STATE_RELEASING;
> +	status->state =3D ep->state;
> +
> +	gatt_db_attribute_notify(ep->attr, (void *) status, len,
> +					bt_bap_get_att(stream->bap));
> +
> +	free(status);

No need for malloc above.

> +}
> +
>  static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
>  {
>  	if (!bap || !bap->ref_count || !queue_find(sessions, NULL, bap))
> @@ -1634,7 +1656,7 @@ static bool stream_notify_state(void *data)
>  	struct bt_bap_stream *stream =3D data;
>  	struct bt_bap_endpoint *ep =3D stream->ep;
> =20
> -	DBG(stream->bap, "stream %p", stream);
> +	DBG(stream->bap, "stream %p status %d", stream, ep->state);
> =20
>  	if (stream->state_id) {
>  		timeout_remove(stream->state_id);
> @@ -1655,6 +1677,9 @@ static bool stream_notify_state(void *data)
>  	case BT_ASCS_ASE_STATE_DISABLING:
>  		stream_notify_metadata(stream);
>  		break;
> +	case BT_ASCS_ASE_STATE_RELEASING:
> +		stream_notify_release(stream);
> +		break;
>  	}
> =20
>  	return false;
> @@ -1936,9 +1961,7 @@ static uint8_t stream_disable(struct bt_bap_stream =
*stream, struct iovec *rsp)
>  	/* Sink can autonomously transit to QOS while source needs to go to
>  	 * Disabling until BT_ASCS_STOP is received.
>  	 */
> -	if (stream->ep->dir =3D=3D BT_BAP_SINK)
> -		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> -	else
> +	if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
>  		stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);

This looks like it makes ASCS Disable for BAP_SINK to only send the
accept response, but not make any state transition?

But ASCS v1.0.1 =C2=A75.5 seems to require it:
--------------------
If the server accepts the requested Disable operation parameter values
for a Sink ASE, or if the server autonomously initiates the Disable
operation for a Sink ASE, the server shall:

=E2=80=A2 Transition the ASE to the QoS Configured state and write a value =
of
0x02 (QoS Configured) to the ASE_State field.

=E2=80=A2 Write the previously accepted Config QoS operation parameter valu=
es
to the matching Additional_ASE_Parameters fields defined in Table 4.4.
--------------------

> =20
>  	return 0;
> @@ -2068,17 +2091,11 @@ static unsigned int bap_ucast_metadata(struct bt_=
bap_stream *stream,
> =20
>  static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec=
 *rsp)
>  {
> -	struct bt_bap_pac *pac;
> -
>  	DBG(stream->bap, "stream %p", stream);
> =20
>  	ascs_ase_rsp_success(rsp, stream->ep->id);
> =20
> -	pac =3D stream->lpac;
> -	if (pac->ops && pac->ops->clear)
> -		pac->ops->clear(stream, pac->user_data);
> -
> -	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> +	stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
> =20
>  	return 0;
>  }
> @@ -6172,8 +6189,10 @@ static bool stream_io_disconnected(struct io *io, =
void *user_data)
> =20
>  	DBG(stream->bap, "stream %p io disconnected", stream);
> =20
> -	bt_bap_stream_set_io(stream, -1);
> +	if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
> +		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> =20
> +	bt_bap_stream_set_io(stream, -1);
>  	return false;
>  }
> =20
>=20
> ---
> base-commit: dfb1ffdc95a00bc06d81a75c11ab5ad2e24d37bf
> change-id: 20250106-upstream-1ec9ae96cda4
>=20
> Best regards,

