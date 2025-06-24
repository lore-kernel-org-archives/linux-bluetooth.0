Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91E274B47
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784109; cv=pass; b=ZlGfwYgrKdbE/rISlmoyPjZxmkZYAVDAO5E5YxXErXNQqoGlMfS27ZllRDTvRZFXgTYqQOkTVqGExnDWC7XXfkeXOKoz7bGnPZIDNdicUloxgiRJAXrcBn/vdcKLl4q5gqwy6xAQqVcozpRwJHrrWvawjFsPL2Rb7nLUZeF1BXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784109; c=relaxed/simple;
	bh=dODMh8OY0oOo2zl/ywZtvWaJ4V3J2NqyFuctBE6/eak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/pyB4esAZr3LK43gW3rd/lkCGPXdMsmalkonKlo23xK5yrwKB/XZ8AYN/fm7WDLZNQl3Xfv4lI3PsH3PoA5lYD05Tj7scsAvpoEsaT49y169fvTq+20O2zZlc+wCmR7MseDc/LOLfQ0SAUnRlqmP+ozTr7Ru7/RpAPsTu3dWPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iPMSzLKK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iPMSzLKK"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bRWK00c2sz49Q3m;
	Tue, 24 Jun 2025 19:54:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750784100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=73LMNCs20CgO0r/t378Ipdkumv0jLUk5UrU7bCgBVbw=;
	b=iPMSzLKKvodxhC7ybSW3Nym106XATY412iVMpPul1KuoS5ZQjdeJUYDzS2F53oSCJRSHLz
	wNKZFlUmhHYu+GF5ULJlXO78dUBFz7x/kC6y1hJSaqd1xwzDMsnb+1w9l7ygY6pIqVReM/
	cNGoN/KP5U7nNu0GfRiPpNhoM9oPHpK1yR92AWawAiKjNOXC8T6kOPFpTVLZvTo91u9FCx
	eex5h3a84VH9QgqSFW/+e+4x8Ix6CZlPSzzHDqnejIBafIVLePSm2tlWDXiZWFafwrqctW
	Dfh7vT2oSOvJ6hk55+40cFW+Al7EXdpsXwIXIRhKqN1EUxhk/mamnJ81c72jCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1750784100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=73LMNCs20CgO0r/t378Ipdkumv0jLUk5UrU7bCgBVbw=;
	b=NwhsjWZ4XEaEHTsJRS0aHpqqTSDgFUVp9fjw4B+wAbyqvwmfDsvf9vBYor/0JixoMs13L/
	QhMm7RX2XrB7Lc7iXrI5uPjgHmf+dhybFaPGYmMeTQbR6aT43YaLJ6mcPn/0RkYio7EEPy
	DkCyIH0RI8LUq3o/6cYtCqsZxnhZJqjeo9A91SSd2JtvwCAd01FugrjG8CqqqptqlRFHmv
	FNkjmX6oN+Gedcc0lzNsBvYFiMLAvY8VsVM2Dkveis2gwePx+lwdj0rQJyzpFwc9Fk5+Gr
	EVLtiKGejggY9NYVMH78u7v47r3PyT7PMlGnZpo0QUArpF9++QOQH1V3zQUc3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1750784100; a=rsa-sha256;
	cv=none;
	b=lLgT3WK9JIo4EDY9kKyPSLWKNns0Q4I/GVZetcseqt9EOyT15E/2UVMEWViUO0LNDsqgK4
	hDfFFRo6wL+FIl0Z5pf13lObff5YNPe67zTTYSfTiM+gd6MP2oiRpOjahXUCSsELFgzq3e
	e0h+6zvwVtYQX1ht1f2ztk+6FU8vjjFlEBDgKE2xAI205fT4HClFLxt0ulmUnFhj/HPhvU
	u/BjO95IlMfbq9W1I8lMbNq+ZKgpqBv07SHfthU8wHGK2Q1+UKpOF0khCG4MGNerfsrZ47
	bQ2+YY+rPYduE+nu7HYJvl9aDmcRyiA57SbdkZC0TDertcmblQJ2iDD+ohDOFA==
Message-ID: <b6b051caafbcdbb00b3a78b8a5982466435d0e28.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/1] obexd: Fix failure to register bt transport
From: Pauli Virtanen <pav@iki.fi>
To: Pete Beardmore <pete.beardmore@msn.com>, linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Date: Tue, 24 Jun 2025 19:54:58 +0300
In-Reply-To: <DBBPR05MB6283E530AA7B8138A19DAA008A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
References: 
	<DBBPR05MB62836AA5E235A13B44F962C88A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
	 <DBBPR05MB6283E530AA7B8138A19DAA008A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2025-06-24 kello 15:23 +0100, Pete Beardmore kirjoitti:
> On initial logind update, the internal 'active' state is FALSE. Where
> querying the current state (`sd_uid_get_state`) returns 'active' we do
> NOT want to short-circuit the update to the internal state value and
> ultimate transport initialisation.
> ---
>  obexd/src/logind.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/obexd/src/logind.c b/obexd/src/logind.c
> index b4279b209..e681dd39f 100644
> --- a/obexd/src/logind.c
> +++ b/obexd/src/logind.c
> @@ -68,7 +68,7 @@ static int update(void)
>  		return res;
> =20
>  	if (state_is_active) {
> -		if (!active)
> +		if (active)
>  			return 0;
>  	} else {
>  		res =3D sd_uid_get_seats(uid, 1, NULL);

Just above this line there appears to be

	state_is_active =3D g_strcmp0(state, "active");

which looks like it's inverted too.

What this function probably should do is to make it simpler and
something like

	state_is_active =3D (g_strcmp0(state, "active") =3D=3D 0);

	/* if active but no seat, consider as not active */
	if (state_is_active && sd_uid_get_seats(uid, 1, NULL) =3D=3D 0)
		state_is_active =3D FALSE;

	if (state_is_active =3D=3D active)
		return;

	active =3D state_is_active;
	emit callbacks;

--=20
Pauli Virtanen
