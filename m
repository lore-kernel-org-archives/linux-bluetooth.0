Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4E266EE8
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860286; cv=pass; b=NRMy9wdXLSW/fdJeY/39pzZiDVkGkDKtGUA2sCXjD7hvD7qWt96M2lj9xuDnF+jkz5nfw1IWULw8jweI2sa7f+xyeL61gcsWir75MVLNGbq8L6ihuZNc6FlBIm8ILmTLoam/58xJjwin2RzOVCNKzVE5nxm4K/CDXA83jB4Qus8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860286; c=relaxed/simple;
	bh=KW1W/3c3JiUQt2hU5G8ISkQJ0SYXByeE0MnZaPv8EPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knLAWuiXcGBBNDo9IXaNpJXyzVrvu07Rn7wr1/CmzWbSAlFGZ9oDXKOwRITSMOgCov7COB7gyYDR0yL010sPsitLhQIW4wSIUKWJACQrWeEUpZj5pydxIKDyUCEneHkokyP9vx5z6q4ZcddVbJ51MlCTBLOjGphZk8eFgpjXodI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AmfiT9Rg; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AmfiT9Rg"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZmVN52w9Lz49Pxs;
	Mon, 28 Apr 2025 20:11:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745860278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uEjh5lvsBF2zsUkzRO4LKA3Z4u6gM46Ts6Tkkwvr9Ns=;
	b=AmfiT9RgF4WiiP76l5J0DsradAF6Vk+PTthyBfF+5dU8s1rZMExamwEnOGbe+tuhvzSS2s
	ktUNVxu31hz1WJTtpzXmhirfyZPHeMDdZGUiVTOQwTq4qi/8B60IWoqoI0nFvRdaha/LPG
	xd9j5I6GwSkWrYTrxuj4si5SYU40oLzDYtqbZyTtvhV65iGlPr6opM9PcdQnOPjss24VRg
	c/CJy+7tiFsmagLnN3due77hUtzqivb2z/ORRsVJ8BDaCyJOTyypmd4SC4+3TTjhtX7F3s
	2FDb/BsUq4kiE3VN+BIFWEcjt0I3F7ET5UTr4UlnOCemSPWGe1gdskqrBAPK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745860278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uEjh5lvsBF2zsUkzRO4LKA3Z4u6gM46Ts6Tkkwvr9Ns=;
	b=aTSp23Gzst0pXoOP6cpyWiKOJCHC0xbDoFlOzQe3v+v5hvH1dJ9ZQl9MbShMK70Gy2emBg
	TbBC6XpyW2kwrlgXIYFjQsTSpvWFVb/1WcB7+UuhAgLRjs2d13HX2Qb5faxDtWKPJaOJrU
	cbX7sg8kEUE8O8+CSDwxJbiph6V5FxCCOACS66JF1vYIJsTevlGTQkWpiLKdMGUtWdccFN
	4mnSv8xxUExsov/YpqYm64/t89Azx0ppqbsFuO89ry9o7QS3VmeI6QyxWFfEMryQUKEcCW
	TqN00Yyaj7Ru+n3SYwiuxFEu4S6+Df2QIGlwyPae9byXkWIekNGQwh7/kLh92A==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745860278; a=rsa-sha256;
	cv=none;
	b=vZhScohphzLN03mrX9HskxlV0FY1E/plffJJ9ydodGrnISe9B5/H5uxZb5uUofAeeVRhdN
	+EJNxdUq7NxEqvyzj7wOwxg6GSgPANAnLPJgmEmYSvwPjCiODDaat33epLXjTBIRo0GCCA
	zF3ynmBpSEMr1uyJ5jBaLM0hK+VnpzhZG7GKH0xcsa8MaC69KZyvQaWg90mPiPXDWI5BTE
	CllaIddfvg75uBiv0OnS7zmFfE3/hJJKZRZV5u407r+ZqXGLpdwiUPcqFGur8lD0QYmZXz
	J//wUlFn9r3cbfPFwA/ojfgzQC368VOUYRe1eTa9NesE03JKDYHkFmI8bLrU5Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <f2bc9aef282119b14e46cd4bc489b7fb2e09a0b4.camel@iki.fi>
Subject: Re: [PATCH BlueZ v4 5/6] obexd: Support
 sd_login_monitor_get_timeout()
From: Pauli Virtanen <pav@iki.fi>
To: Andrew Sayers <kernel.org@pileofstuff.org>, 
	linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Date: Mon, 28 Apr 2025 20:11:15 +0300
In-Reply-To: <20250428131842.488921-6-kernel.org@pileofstuff.org>
References: <20250428131842.488921-1-kernel.org@pileofstuff.org>
	 <20250428131842.488921-6-kernel.org@pileofstuff.org>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-04-28 kello 14:15 +0100, Andrew Sayers kirjoitti:
> The documentation for sd_login_monitor_get_timeout() implies the API
> may need to be checked after some time, even if no events have been
> received via the fd.
>=20
> In practice, the implementation has always returned a dummy value,
> and changing it now would cause enough breakage in other projects
> to make it unlikely to ever happen.
>=20
> Add a handler for that case, even though it can't currently
> happen in the real world.

It should be also OK to do things properly and add also the timeout, as
here.

> Cc: Pauli Virtanen <pav@iki.fi>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>  obexd/src/logind.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/obexd/src/logind.c b/obexd/src/logind.c
> index eb4924684..5bb9a5986 100644
> --- a/obexd/src/logind.c
> +++ b/obexd/src/logind.c
> @@ -101,6 +101,37 @@ static gboolean event_handler(GIOChannel *source, GI=
OCondition condition,
>  	return TRUE;
>  }
> =20
> +static gboolean timeout_handler(gpointer user_data)

I think the intent of the systemd API is that=C2=A0every time you want to
wait for monitor event, both poll() and if get_timeout()!=3D-1 also
timeout shall be enabled.

So one probably should reschedule the timer on every wakeup, also in
event_handler(). (In theory I guess also the poll event flags might
change on every wakeup. This looks a bit less clumsy in the lower level
GSource API, but I think one shouldn't bikeshed too much on this...)

> +{
> +	uint64_t timeout_usec;
> +	int res;
> +
> +	if (!event_handler(NULL, 0, NULL))
> +		return FALSE;
> +
> +	res =3D sd_login_monitor_get_timeout(monitor, &timeout_usec);
> +	if (res < 0) {
> +		error("sd_login_monitor_get_timeout(): %s", strerror(-res));
> +		return FALSE;
> +	}
> +
> +	if (timeout_usec !=3D (uint64_t)-1) {
> +		uint64_t time_usec;
> +		struct timespec ts;
> +
> +		res =3D clock_gettime(CLOCK_MONOTONIC, &ts);
> +		if (res < 0)
> +			return -errno;
> +		time_usec =3D (uint64_t) ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
> +		if (time_usec > timeout_usec)
> +			return timeout_handler(user_data);
> +		g_timeout_add((timeout_usec - time_usec + 999) / 1000,
> +				timeout_handler, user_data);
> +	}
> +
> +	return FALSE;
> +}
> +
>  static int logind_init(void)
>  {
>  	GIOChannel *channel;
> @@ -146,7 +177,7 @@ static int logind_init(void)
> =20
>  	g_io_channel_unref(channel);
> =20
> -	event_handler(NULL, 0, NULL);
> +	timeout_handler(NULL);
> =20
>  	return 0;
> =20

--=20
Pauli Virtanen
