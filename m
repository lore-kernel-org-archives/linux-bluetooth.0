Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9F39E6CD
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043346; cv=pass; b=TQUr9BHLoK2bX9/L2nj8rsjwtFjK+pPS5SAIxRwcOKwr64BfDXDnLuGKlcqNf7wYnLECVagVPo1GHMnwBGz2Q6ZQevYEcdjGUo2hSO57XKiUNd4avOhR5WA5Ud14Q0DE3EMUtqnW31VsXi3eO6U/YF9AG0sETCGjmi5s/zNAV+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043346; c=relaxed/simple;
	bh=N7Rqz0mvkNO1Xlm1bopTE5CSBm6oFsjw8EY+DS49XKA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHhIg91e/axxqlyIuiuLbMmSROc3PREpie9qJfaePcI3DhDBAE39K2ffYRImJyN9rt2xGiIiS1skD28AWfrEHYt0qznjuWURl+Kzk23RBjIKxCdv6vt7S3527Fd7qmWuEghYWqFdikI0xkqAFiX6HnykyYFHRFq/OFuWH6avJ8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=vgw7d9ez; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="vgw7d9ez"
Received: from [192.168.1.196] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gZjsV3cVvz49PyY;
	Wed, 10 Jun 2026 01:15:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781043342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iz0tW5hCi5O97fHsPw+jzX5HkPgDYuI4Ov1EZ+M8oE4=;
	b=vgw7d9ezT8gnqoWE7cqQa4HNbrWhnWzo+om/7AxvIot5CPehfw6/TlR9DmOC9h+C7/CYXJ
	tamlV8OxK/B3z7rxcJRRMrAHOhh4xtnVSkR3ep/5TkQjDZcCD30rEdAf+66fLnZ7cvHSXS
	w2ZYdES/3ehcPNKM9Ms3s+2vScNf2bFxMPxIFaT1ELCmo0DZR53KXQRGWJ88fhRb0uHDi0
	RzXcuYolKLh5p21B/q661gdC1jWwsYTB31DaT/txTK/+EvBoXqoTLXtOmD0AFBKg2fH/Qp
	H5lNBO/xdmWFj79V70h0/O65Id3WytMWeqk8UYjpJZZ8OWwhdQwaV2K0CcOEdQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781043342;
	b=kbldflEaGHcpUxXhlsZJ7bRg8aRiA7rY3qGFju6zDT+/Mp3n2UPKWWaB3Kk0G2ojhxte4T
	9GeqjCjoYtFThgTSPSx9RLXQ4dCUP4jlPROtvHLvVB4jXhFp25Ea32UeeSGUTUIhAPsNvF
	PH28WJ0fDheEEJwCE1rjj3zTugSQ89nkUPBXKJ2pWUfuOQsoq+92XbhNpNYrLPVESClMBA
	WsG/zNPY7gSw4Fu+UA68QoSDR8B2xWHsmy2AjbMJ28hGWurDkO9bXsvK30XO+3CFNEaocK
	qCR6JSe9zsW5Kretaf7IQ7Q3rsi2CDoepy+EqHUYsReo3rRITG0F+2S5kkeMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781043342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iz0tW5hCi5O97fHsPw+jzX5HkPgDYuI4Ov1EZ+M8oE4=;
	b=f4ZGHQ1zqpPdYwwJEo8sLkOs/U8A7/mVvVPceWnG18JYlr+IrHnauGyOm6PF0b7okaBxZI
	JZcXC2eTu0+PVs9Et6PQf3Z2Tt0ZZF6wbH3jB76+y1ogBxBnsFYs6RyNmy4/Fk/cSBogjC
	F2hYCsE1TcJJbyC6EsNjqI9fCeK67MwwCJNHs6DmgB4MeW6bRfnvg9zkrnpdSreSkaUJhp
	73H7/fd9Xpis/dZiBuCtfdqXg6pMcRcOTgwhh+PjkNLRweXsCkxd1kZRybGtLZfWQfqdJX
	Sizn6Bh3c02KVQNNFQgu/FTVuDHYC9BlLfe1KXJytrYxwsxoUrEPkvcFP3nQiw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <e89af328197d3fb429c08b7a3107d7fd8e05ac00.camel@iki.fi>
Subject: Re: [PATCH BlueZ] shared/bap: Transition ASE to QoS Configured on
 CIS loss
From: Pauli Virtanen <pav@iki.fi>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 10 Jun 2026 01:15:42 +0300
In-Reply-To: <20260609211120.3887737-1-simon.mikuda@streamunlimited.com>
References: <20260609211120.3887737-1-simon.mikuda@streamunlimited.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2026-06-09 kello 23:11 +0200, Simon Mikuda kirjoitti:
> stream_io_disconnected() only handled the Releasing state, leaving
> Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
> unexpectedly. The ASE shall autonomously move to QoS Configured on loss
> of the CIS and notify the peer; add that transition.
>=20
> Fixes PTS test BAP/USR/SCC/BV-167-C
> ---
>  src/shared/bap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index deb85b264..350ed53d9 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -6779,6 +6779,14 @@ static bool stream_io_disconnected(struct io *io, =
void *user_data)
>  	if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
>  		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> =20
> +	/* On loss of the CIS the ASE shall autonomously transition to QoS
> +	 * Configured and notify the peer.
> +	 */
> +	if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_STREAMING ||
> +			stream->ep->state =3D=3D BT_ASCS_ASE_STATE_ENABLING ||
> +			stream->ep->state =3D=3D BT_ASCS_ASE_STATE_DISABLING)
> +		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> +
>  	bt_bap_stream_set_io(stream, -1);
>  	return false;
>  }

iirc it may be also broadcast source here, does it do the right thing?

--=20
Pauli Virtanen
