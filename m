Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB391EA84
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482276; cv=pass; b=YNdpqFonSaZsVfouUENIDy/b0r5Un5Ti3rUkyPiPQJgHFi6pnvGecECgG8qRi8xfVoypQFuqK9Jmb6hw3oMe4xHYwZeEIhI7mUiCVfVJ8EBABMaW/DRcb6KbXPuUxEBJXgXZNo7E5FR9LiB2M3QmUbZG3lLoOsGrytxGa5wMYlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482276; c=relaxed/simple;
	bh=Ax7Pu69WzAq8QIDirNcErYToQDB1mCc/wDn35W68gTU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sJ2GMD2TTgrjOExWuLxSSb6MlF6LEsLMsrbETTEiF3OOF5EJjMtXb0h/7yWt03VfxxPF3K86fvwkZLdNUyc+WwxHj/94TaiVk0gzazR0wteD2mkouszwwVPsBENnf4cGY2JVOs/VTb8kcBkU2rH/S8Bn0zZFUT24GXbyb4xEFPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nCfOlkjV; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nCfOlkjV"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cmTw22mncz49RGm;
	Wed, 15 Oct 2025 01:50:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1760482259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lPXH27yufNYhHQqZ57MdkFQYlaTNnqaVEbKktzHM4fc=;
	b=nCfOlkjVIYPJVEpYr0VhM73Kz8vTVYwtW3ItPSZzLbDt890bxI4m8B/og5io2hKCApdLVl
	CqEld7AI8EZ6dLt4MfRIRv5vQ21GFHfzoUcmuY54gHhQ1gs9ajX7QYaB3AFp54uvi3GAVq
	JdIg94jA4cHPZDoGs3DOK60VnIsQgkMDmYzdNgdxKUiUgXRL6Sz8I7Boxs22tdSz+T0QL/
	ZtDVe2MK4cD98hlljnYGd32NzDZDCkUldqPFgpoviEc2OKZ11xjUASDif/ZwAOjP6YXIDH
	Qw8DYoLs9f2+mepF4vDkgxi1IoAQnVBmg8TxOTpeptxt68MEGURmKG25nEOFkQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1760482259; a=rsa-sha256;
	cv=none;
	b=rKe4hSryeii5BbjzxouZvOerELw9UN1AMPDHfQimIitEfQsYIttHFCxUoDPdE6a2qEQh3W
	qFOOFfUDLKAyfDQhi3+QE2hKZxCnt8XnW2VfbUAwjlS2qfv3CosV2Ld5bFt9hxw/aSCpHY
	/0yMRwpTmCIfpeE2HMMvo1LLAyGLLR6FsukQZd9quyOTOWnJM3J1YwAjY6tOFL4VR1wnsc
	LnskihV7dJMuF5Dly/LvAUedQBp9CifkYEV3zq/1wkCWNY5Qz2vaXLBM+qGttv2H48b9+G
	3GD+sHw6ogwHkpyEJX+hQ/w9jCC51fKL4lNB/T2h3Z5NkXxCo5jBmAHDCRrLNg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1760482259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lPXH27yufNYhHQqZ57MdkFQYlaTNnqaVEbKktzHM4fc=;
	b=p58cbik6jVd4vSD4+wPZFVkJRn5xFjvgF8w6IhLrZ+4uppbBzPKOqiGuhqGqAfrQfAIabx
	RLXfxBLTTSmxYN/S4K1a3BQnSzCSRpajQOlQGPHUBXgyQWsVFQsS7CSH6LxxvBQg+R6Hhy
	JWL0N2zRSqjSwCcE1J3Lk7gU1rpBYNOYksDW/hyeC7612ph267nni7AUfmgdeCBjtBxhkQ
	VCO4ObnEuToPEAktSlZSeBn7kErPpxA9apfe8+EjlOqHP8XZT3UOH7YraV7eycgCWwzmdd
	6Q/txfROYksnehQPqPhQKWlsWU72Rv0NXQONIibsYI6wroxhFw/EXJLRySOapw==
Message-ID: <63576620e52a1d94874b00d0e4f4075b95696803.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1] transport: Attempt to reuse object paths
 whenever possible
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 15 Oct 2025 01:50:56 +0300
In-Reply-To: <20251014202551.423660-1-luiz.dentz@gmail.com>
References: <20251014202551.423660-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2025-10-14 kello 16:25 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This attempts to reuse object paths whenever possible to make
> scripting a little more predictable by not having the fd number
> being increased regardless of the actual number of transports.

This design adds possible race conditions, of the type:

BlueZ> remove transport /.../fd123
BlueZ> add transport  /.../fd123
Client> ClearConfiguration /.../fd123
Client> receive DBus message that /.../fd123 was removed
Client> receive DBus message that /.../fd123 was added
Client> receive DBus message that /.../fd123 was removed

so the client deleted the wrong transport (or made some other operation
on the wrong object).

AFAICS, there's no way around this race except unique ids.

From experience: Pipewire reuses object ids in a similar way.
Ultimately,=C2=A0the race conditions were too bad, and we had to attach
separate generation IDs to make the IDs unique. Luckily there was room
in the wire protocol so it could be hid there as an implementation
detail.

I looked at libdbus sources and couldn't see it has a race protection
like that, so it seems to me there's none and it's up to applications.

So I think it's better to keep using unique object paths.

For scripting, bluetoothctl maybe could have some special notation for
matching transports by glob or some "n-th since script start" notation.

> ---
>  profiles/audio/transport.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>=20
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index bc550b743981..83e3c9791a66 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -2582,7 +2582,7 @@ struct media_transport *media_transport_create(stru=
ct btd_device *device,
>  	struct media_endpoint *endpoint =3D data;
>  	struct media_transport *transport;
>  	const struct media_transport_ops *ops;
> -	static int fd =3D 0;
> +	int fd;
> =20
>  	transport =3D g_new0(struct media_transport, 1);
>  	if (device)
> @@ -2595,15 +2595,34 @@ struct media_transport *media_transport_create(st=
ruct btd_device *device,
>  	transport->size =3D size;
>  	transport->remote_endpoint =3D g_strdup(remote_endpoint);
> =20
> -	if (device)
> -		transport->path =3D g_strdup_printf("%s/fd%d",
> +	for (fd =3D g_slist_length(transports); fd < UINT8_MAX; fd++) {
> +		char *path;
> +
> +		if (device)
> +			path =3D g_strdup_printf("%s/fd%d",
>  					remote_endpoint ? remote_endpoint :
> -					device_get_path(device), fd++);
> -	else
> -		transport->path =3D g_strdup_printf("%s/fd%d",
> +					device_get_path(device),
> +					fd);
> +		else
> +			path =3D g_strdup_printf("%s/fd%d",
>  					remote_endpoint ? remote_endpoint :
>  					adapter_get_path(transport->adapter),
> -					fd++);
> +					fd);
> +
> +		/* Check if transport already exists */
> +		if (!find_transport_by_path(path)) {
> +			transport->path =3D path;
> +			break;
> +		}
> +
> +		g_free(path);
> +	}
> +
> +	if (!transport->path) {
> +		error("Unable to allocate transport path");
> +		goto fail;
> +	}
> +
>  	transport->fd =3D -1;
> =20
>  	ops =3D media_transport_find_ops(media_endpoint_get_uuid(endpoint));

--=20
Pauli Virtanen
