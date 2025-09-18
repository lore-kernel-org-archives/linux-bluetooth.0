Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933D2D193B
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219060; cv=pass; b=kWKR1vzBy/PVPoGks7ZmZdGOHhfSSL8LR5TWaoUWvK0ldM5TJs+ZsPVE+z8QdHEHdEGA2hx5774s/+Gl86ryW+o8ubmMZa+l9MxcGiO+YkPpobuUnNJhhgCqYLvi9h5Ig4TLchrMLE1/W9weFvGwSwzkDgA82R41Y1rk0zFrEc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219060; c=relaxed/simple;
	bh=m1QPFxhP+XOK8TmKVZyxl+sj+RpoUkSPTozM35WtaXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfSAqLZfQvAoBMm/+ixs6bnoyBoREw7Ep5Wizypm5tgQMSLI1hS3QTCou8K5rJHmxACvZXzOvkRirquaTZXCDjUhBz4PFLUaqJb13X7X2ptk6wz+ethqMrWlxFSRHocgHJuvAFmSpQVe3F3EpK3lDKcOknuWzjRqQCyw7mQcNuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=tP0JChoP; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="tP0JChoP"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cSNwh2H9Nz49QFQ;
	Thu, 18 Sep 2025 21:10:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758219044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e2oLl24xSLnj1oL0Diq9RS6OzlFbL/TcuiOZjcAQLw4=;
	b=tP0JChoPewIAAPqCP6Hp0K9abeDdHExt303RX7VPyX4xuOM+xyPhAJVyX0TueRDoHSMQt8
	O9OL5TBYLb0uylSiZDF3QeKQpsUqVbrKeKYQBKpHWGCrGLPObbcRCiWZgciKnALLY2DFfR
	ERI5Hjwgdnl4+3IorS4l7vlNUeesD6DDAe41Jy7Y/GBuWoXkvbiLyK5e6Oz2IT1Blm4c1O
	moCC/3VY+ZjANLPgy88+8kD+nD6MEgrYihWhld1EpzzBVEzmcSMtTCbGZJT+bdu1gmyxAk
	1mPclIyglGRGWpWM6tPFPTaWWZ/emCpRgKL/FRBMFdMDQkKJYek1cCWvIi243Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758219044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e2oLl24xSLnj1oL0Diq9RS6OzlFbL/TcuiOZjcAQLw4=;
	b=FQ24124mY2cppDhRXtb/rWiIPzROYyxnzXIoMFwJ0Eq5eeT0d3swq39Z/mt1B1azHlNDGx
	lc6cr02S17ZmPhhuWX3zK0s/0r8s7R1fbWSJ6j2CJ7S805tw68WPWB3+UZOugcz9h+c+xC
	AF7jbnPwJc/w6WkTVjLTjePGqSHZy7vKgkQPRvC4BA3oYx4U8wJLJhcN4yQ/+u49zmJM0V
	bjbEHS5PCWxV6E6j8igm5fyLE/ifHwqQslR3PIj32l+MPKAC38pyMNDyBw76j7QPjotv1a
	d/po1nmJ5Hv+5AhjAZu6R4w8X9DcMKytPnex54iLSlr90F3i+NQkZzIB9exx5A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758219044; a=rsa-sha256;
	cv=none;
	b=grSEqTdYm1gKHzBRfcPorj+fUFKinCUkWhHa23Tvw9bHepXk3ldUkx0bS4zUeBIghpAWFT
	Y5snYWYpEDi7WDC6gIBe9tQszaMPgupxw/qzG/GY5H5v2P9GsoduUa7oAHvSTkKd/fwQJE
	2Ou7wS8xojs3ICXo8GGvAbEcObKN0lBDOUUZ14H8Q4lK0OthVtPV9Yjpkju7CvteTT4iz8
	I3+/WG9kinMOHiGD7rmfCRi8SX3ViGeyXosB1PdFYY2y0dpBZCF83/8hjMHvCN+tQyHKkG
	fRshZdW8wbbUYcMi24ndA+/gZxl4rV+2ChBl/v+0RTu48wMaoCSXsZPMqJQGJA==
Message-ID: <c234cdf8c79f4d73e4ef32be757ec0ae2dde4935.camel@iki.fi>
Subject: Re: [PATCH BlueZ] media: fix pac_config_cb() error code return
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Date: Thu, 18 Sep 2025 21:10:42 +0300
In-Reply-To: <a9a2cc5fe58b706247b74adeaa5f0b774432f837.1758215957.git.pav@iki.fi>
References: 
	<a9a2cc5fe58b706247b74adeaa5f0b774432f837.1758215957.git.pav@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
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

Looks like BlueZ 5.84 was just tagged. Unfortunately BAP was in broken
state at commit da5daf532409812c41a237a6a6126868f6867079, see below.

to, 2025-09-18 kello 20:19 +0300, Pauli Virtanen kirjoitti:
> Fixes: a887b1a1b91f ("audio: Add support for specific error codes for A2D=
P configuration")
> ---
>  profiles/audio/media.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 332f643bb..deb321e6c 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1110,7 +1110,7 @@ static void pac_config_cb(struct media_endpoint *en=
dpoint, void *ret, int size,
>  	if (!transport)
>  		return;
> =20
> -	data->cb(data->stream, error_code =3D=3D 0 ? 0 : -EINVAL);
> +	data->cb(data->stream, (error_code && *error_code =3D=3D 0) ? 0 : -EINV=
AL);
>  }
> =20
>  static struct media_transport *pac_ucast_config(struct bt_bap_stream *st=
ream,

--=20
Pauli Virtanen
