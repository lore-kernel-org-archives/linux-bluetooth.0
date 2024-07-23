Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BC14D431
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754759; cv=pass; b=KnQsWlAw4XDSFFMjaIdQJks86jFSupEjRoa2UKwXXLfbETLRRyKADo3XACvfISskn2qSN8rHoT/ISPt10P5+KfUiv9pmCmBuoW22Ra6CFy4chJ4/dRyTmEz2iAPtp/SBEtSCF9Sm/bQy1LzSvZXx0n3pqEZvTXaWAQR0lnXczAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754759; c=relaxed/simple;
	bh=qG83C0wB2xNzHu1Vg7Asn9xOrr43s9phqnsJnLY+1iA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1mSYFkdAfrjZbfqatmndvXdlK/s2jnoX6J1sXppPMiPg0qE1WNoNze+uxPeUo9zY+JJHgv3BetOzgbKSHE1aSe6+jiz6ep9K7ylClMl+Tj2RQFgCKf5ANj7Wts/oeKiTKi5p6G4bz3q2eknxLLR3eJnC4br2teyFxvsC9LfWvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HYdaVjPe; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HYdaVjPe"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WT3c95XFGz49Q08;
	Tue, 23 Jul 2024 20:12:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1721754746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lw1clEPY3GVYsW53sLKIsZxKonyelvIS3NobWLLxR6E=;
	b=HYdaVjPe3hpi3n+rxqAg9T0CuKRNDZVto3TxjoAY5Prpq11xAlClXG4N1zH+czuQh7EFTC
	B5eppL8Jx5yfkBPMT+X1SYGtAjt9o6GIA7Pq97HycZnAHNjm6DscXJIOiT7vhMT4Z4ILsN
	b4gUIAjQHmkiQD/BroE/FEi/sxWGZ/Y7XBXzNWun7j+8pNJMhDuYzy5ToQwl0ZoPwaG+fh
	fn4Z5Cq+48exBoNXZ4lkonPY7mDKeGp26IJxMtVZOC4m5vYqnvI53MJsmSuuy5vdKsm+MR
	LaIATAhfJ/SmgRgm/HKGZQrhKuFas6bipHHJ5RyvvTVdLe7NETJ080xPn34I/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1721754746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lw1clEPY3GVYsW53sLKIsZxKonyelvIS3NobWLLxR6E=;
	b=fIoeqUfqHYpOsSi3q6d7f3KbqaMWPBPSxxq5x7ETEsULcnw9WQ6A3xdaTrZn18bH54RxYY
	a38WuUP3UybzJR51oIrFqQpzesq3Du8FjKP28bOSCObF3bZibzTMzTMIT4DM/YdZo8w20q
	ik+KPfHncTRD+jLmx5bdB5+FjT8J3Yuzdgb692qD5HkuoEac0bimVpvPg2pnbE/cXukfH3
	T9EFy+kk8c2tAVr4mnQR8RA6/CSSrl7LBSqboz+niy5Tg2L+rNKpYcYfxSl5Tq3kMMoJQ+
	93Pd8LzqN7b/rJNEErJREXAebrCk7AMIF7Pn90+/Ixf+d6U7TVXGmma7HqrgZg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1721754746; a=rsa-sha256;
	cv=none;
	b=hgwTFlFD1tMohQ6MyjEZ336owtpcjqpEdx99j4ztYZ7416wyLfqm/9yKZ5iyMl+NuwwzWM
	GYaKA7DaCa5w36J9yXbl2EnB6XRJXfpIbGJqWGeSnWQiby+qqDsD7WE9nUAvPmgqsUCc+s
	t2cZ0NQo7YyBbeIVPDa45zIjH9juMX4MnckMmtjiI5F7A+r1sRtlK65TOeaq/Aic0z1jR/
	46Z/kNitca2RFjFWXvsCpjOcG/pQvGZxZIY7CdELM9fMGw5+F3u3pHqz+R93f8muBVPRMd
	Igajq+5SrV+gqR8Z7CUsrMu21ggZdiDS92ms80xypTRnHvw+K/UsMWTGrn/rhA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <1ed90b39ad0fab41f1cab18adf12f7d95f9e99d0.camel@iki.fi>
Subject: Re: [PATCH BlueZ v5] obex: Move size emit signal to plugins instead
 of obex.c
From: Pauli Virtanen <pav@iki.fi>
To: Amisha Jain <quic_amisjain@quicinc.com>, linux-bluetooth@vger.kernel.org
Date: Tue, 23 Jul 2024 20:12:22 +0300
In-Reply-To: <20240723110514.8598-1-quic_amisjain@quicinc.com>
References: <20240723110514.8598-1-quic_amisjain@quicinc.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2024-07-23 kello 16:35 +0530, Amisha Jain kirjoitti:
> Instead of emitting the property "Size" from obex_put_stream_start(),
> Call the function manager_emit_transfer_property() from plugins/*.c
> wherever plugin has transfer object present.
> Remove the code from obex.c which is generic for all profiles.
>=20
> This change resolves the type mismatch issue when calling the
> manager_emit_transfer_property from obex.c. We are passing
> 'os->service_data' of plugin session type but the
> manager_emit_transfer_property() expects the 'obex_transfer'
> type, therefore size is not set properly and might cause
> crash/disconnection.
>=20
> ---
>  obexd/plugins/ftp.c | 5 +++++
>  obexd/plugins/opp.c | 5 +++++
>  obexd/src/obex.c    | 3 ---
>  3 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
> index 874fe2b8b..127bb9aaf 100644
> --- a/obexd/plugins/ftp.c
> +++ b/obexd/plugins/ftp.c
> @@ -175,6 +175,11 @@ int ftp_chkput(struct obex_session *os, void *user_d=
ata)
> =20
>  	ret =3D obex_put_stream_start(os, path);
> =20
> +	if (obex_get_size(os) !=3D OBJECT_SIZE_DELETE &&
> +				obex_get_size(os) !=3D OBJECT_SIZE_UNKNOWN) {
> +		manager_emit_transfer_property(ftp->transfer, "Size");
> +	}

This probably should check ret =3D=3D 0, to be exactly equivalent to what
it was before.

> +
>  	if (ret =3D=3D 0)
>  		manager_emit_transfer_started(ftp->transfer);
> =20
> diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
> index 777f5f8ed..74b2f805b 100644
> --- a/obexd/plugins/opp.c
> +++ b/obexd/plugins/opp.c
> @@ -87,6 +87,11 @@ skip_auth:
> =20
>  	err =3D obex_put_stream_start(os, path);
> =20
> +	if (obex_get_size(os) !=3D OBJECT_SIZE_DELETE &&
> +				obex_get_size(os) !=3D OBJECT_SIZE_UNKNOWN) {
> +		manager_emit_transfer_property(user_data, "Size");
> +	}
> +

Similarly err =3D=3D 0 here.

Based on looking at the code looks otherwise OK, but haven't tested
this myself in practice.

>  	g_free(path);
> =20
>  	if (err < 0)
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index 98d6245a4..370bfac9e 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -716,9 +716,6 @@ int obex_put_stream_start(struct obex_session *os, co=
nst char *filename)
>  		return err;
>  	}
> =20
> -	if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SIZE_UNKNO=
WN)
> -		manager_emit_transfer_property(os->service_data, "Size");
> -
>  	os->path =3D g_strdup(filename);
> =20
>  	return 0;

--=20
Pauli Virtanen
