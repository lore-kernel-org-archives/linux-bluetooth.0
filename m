Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F026738D
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006627; cv=pass; b=L5e5CsJYU1CUQq+7WMGUTweg5Ur5T5hazituQLBdafHMBQgHgliE3Z2l+wKfjC/UKpD3thqlIQk3W7hQJMgn/gw/qHcwnXZNtclByCMLTopQxYnf1WVuZm1676zmHt7mRGFK8BN9VWYV60EYAHUEji2FWoGayJH6RcDZYvY/OeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006627; c=relaxed/simple;
	bh=DGvHmPtjMuTjBfZFmkTe/Ak7ZfLznfgcakZkpPcunJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HovzwvrFoW3t4bU0ElMrS4aji1PQMPHC/oxVVzLlyVwLZopPBwjZB7X0Exg1EteSJxJatgfNB897mfcie8B4BCbCVUQ2BJdbFI/AFBw8N2sAdnO2S6cHtrb4rhSCHPDjqi0CPNVphXmugIW2B8CJJjB1SG3UIfILlhpUSt/pNUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=cL4m7Lj6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="cL4m7Lj6"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fCL3X05jqz49Q5c;
	Fri, 13 Feb 2026 20:16:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1771006616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JuYOyBxxbxwjl/HjAdAs9LfYbrA3M/s5aZOaNF6KsII=;
	b=cL4m7Lj6gvmXf8SBKhnkVLaBH1aKZXYVQV0+wAdM+EQjeNWM+vB+wQUzo9PoMmiPNACKNH
	PV4V3uvMDpCwox2vRkQJotcciN8C1pCREPFCK3Vl9K2Nz7DgdXTyQ1CTiwggoOQ/kMs4rC
	q9f4KQTg/mgcCZe6vADibO7Tb03bawELKkLuhkWDRZpp7ZilkjsA4hmXPuBvHrjNU7dNZb
	y+NdzHgLN7tJtdakF5AFv/fgTiYF8qrtzV5uISRHwNYVw1O6SlocqI6WmFgssC/AzXFcIo
	rWhm3zvuuQgMoAITdHQaY7GFDWsNRz1vbsdLsWRkLMn8zqUeORYnvamc1mindA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1771006616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JuYOyBxxbxwjl/HjAdAs9LfYbrA3M/s5aZOaNF6KsII=;
	b=pR3H0n+AurTJXSZc0hco0ICoKnyu2yzafAMHkN20iRjlSpIfeoGHalxuWyP56UB/JWCwgK
	nmemBSuc0jX39e7sgjeBfmMqDri9nG3B5e+Tn1z+53pLKBuClGk1gUU0+L3dosdqB6+zP6
	DYS5emniuYyOT2KmuyLIlCoMY9tPgdIiBkUKYJCKn/4D2DPEyENzaKD7/3cbfzBweX+SRx
	I3KFptuIU0wRFxJuSf+Bo2AJrSVp6V4mrQ7+SCKV4BPS1Y2ZsBXnLRBedjIubmb3KNhbn9
	C512RgOFZ/5kLA0FYcLfvhWK7vbTIdPY1g6iMC6bLoCWDJrItcB+VYjobwSUgw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1771006616;
	b=t3epWioJtwHmU6Rcf4M3bps8MNUnFSthP6fW6KXPMaBrgJj4+e3SvRqo4oTxFUU8qdzFvB
	Pk0EG0jBbL+e0KOO6TCwH3OpSfRLEHL12/koOt8OFCzUoSaCZ45DTItbFJZ9k5PeDpOsyV
	PK5jl3MCH+gZLPjae+XUO+RcRZpGG1vMAphu4rDuPevneIt9iVcj91LS8IdaUU1RHuXJHO
	7w0R32dVqiXTOwpPmoGSDZNPYamhEHFwxDNfHz8dJaKcCy0xwbGa2gWVqf9HL2rhfeU3xn
	HtNkRWQhMWcDI+0ophtu5CB/XJ4kmksOcyRHL8+sCuQ3B1HQzthkfvp/W9RLQQ==
Message-ID: <4ca527098ac88f029a5055bcbb8db75ef5f66634.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1 1/1] bap: Fix use-after-free in broadcast sink
 cleanup
From: Pauli Virtanen <pav@iki.fi>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>, 
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: vinit.mehta@nxp.com, devyani.godbole@nxp.com
Date: Fri, 13 Feb 2026 20:16:53 +0200
In-Reply-To: <20260213164120.502-2-sarveshwar.bajaj@nxp.com>
References: <20260213164120.502-1-sarveshwar.bajaj@nxp.com>
	 <20260213164120.502-2-sarveshwar.bajaj@nxp.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2026-02-13 kello 22:11 +0530, Sarveshwar Bajaj kirjoitti:
> bap_data_free() was calling bt_bap_detach() before destroying
> bcast_snks queue. bt_bap_detach() frees all streams but broadcast
> sink setups in bcast_snks queue were still holding pointers to these
> streams. When queue_destroy() calls setup_free() as its destructor,
> it attempts to access these already-freed stream pointers, causing
> a use-after-free.
>=20
> Fix this by destroying the bcast_snks queue before calling
> bt_bap_detach() and ensuring stream references are released while the
> streams are still valid. This matches the cleanup order already used
> for unicast.
>=20
> Crash trace:
>   AddressSanitizer: heap-use-after-free
>   #0 bt_bap_stream_unlock src/shared/bap.c:6384
>   #1 setup_free profiles/audio/bap.c:1123
>   #2 queue_destroy src/shared/queue.c:60
>   #3 bap_data_free profiles/audio/bap.c:210
>=20
> https://github.com/bluez/bluez/issues/1866
> ---
>  profiles/audio/bap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 90a978667..9108bf729 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -3822,6 +3822,12 @@ static void bap_bcast_remove(struct btd_service *s=
ervice)
>  		return;
>  	}
> =20
> +	/* Clean up before bis_remove and data_remove */
> +	if (data->bcast_snks) {
> +		queue_destroy(data->bcast_snks, setup_free);
> +		data->bcast_snks =3D NULL;

This probably should be done as in bap_data_free() since setup_free
also removes the entry from data->bcast_snks,

	struct queue *bcast_snks =3D data->bcast_snks;
	data->bcast_snks =3D NULL;
	queue_destroy(bcast_snks, setup_free);

as nested queue_destroy() -> queue_remove() is probably not safe.

> +	}
> +
>  	bt_bap_bis_remove(data->bap);
> =20
>  	bap_data_remove(data);
> @@ -3938,6 +3944,11 @@ static int bap_bcast_disconnect(struct btd_service=
 *service)
>  		error("BAP service not handled by profile");
>  		return -EINVAL;
>  	}
> +	/* Clean up broadcast sinks before detach (like unicast does) */
> +	if (data->bcast_snks) {
> +		queue_destroy(data->bcast_snks, setup_free);
> +		data->bcast_snks =3D NULL;
> +	}
> =20
>  	bt_bap_detach(data->bap);
> =20

--=20
Pauli Virtanen
