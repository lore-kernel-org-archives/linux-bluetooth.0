Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0C14B078
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095930; cv=pass; b=u2XIjUua8eBb71Wadb4Wa1jtlOKr7l21ra06yWFGYlX2D3+3+eAY0oJMkwwXavxgum3HwpBmQHop9qsdmyryeEsmPvhSzvszLpYtboCA2v/wNWhR8q4ErORaieLifm8C4zNLaIPN5QUhNyNWOzdci3Qp1qKxDzDA3FdjEYEoDyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095930; c=relaxed/simple;
	bh=jSXzIYplBxaIPl+fC2a0K+WFckM2GJBn00sQ3wHfVvY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXvjotw3ykxkOT8SgYCl/xFJchOgKf+oJBL4mMOylqEo3nS42ibopf8c2pFwejS/B/vfmnsXURCZyfSnEg3her2Oi2tFZk6eq7H14fEaBACQN89lLvQzxQYWcOpJ2HCvCeflZQtaArVTeGdSG6IsPMBSXp+i2y7301OY12B5Mes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rH0RoQTi; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rH0RoQTi"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WFG7b1WWlzySG;
	Thu,  4 Jul 2024 15:25:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1720095917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ygO+GB4lfaDBAdl9Pnx9XfPe8jBkYzQb6Flz3TsHJ5k=;
	b=rH0RoQTi0xCsfIFTqUuNoE67vVL9WPr5o+S9bqF7te5tNgSiIFEGd2qf+zq9ddHrdRpw45
	MgQxbNHYUrtTbDfZAMKbbrOHeSANMwX1s43zLXGcAopMOuy8T1kC9E6cJdNWaudkiGo+wC
	RiJzzpNbcxw71l1uN9Hfb4bM7nHvhxg=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1720095917; a=rsa-sha256; cv=none;
	b=akKxpma2rB7sB7WGRL4vUlcOA6qkOaLRIy6Vq/aB2/mX+w+j3/yj09UkAXnQKblaaJ4pqq
	+PxJGZrTH8HC1eQrmyVI4mWmpqpNuKFSCyOxOp2VrgKymfIZJzpTJxFhvA/d8zy5MC6Iz4
	Oa0sF2/G9ANMlYcTXAa3ziwG4ge+bFM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1720095917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ygO+GB4lfaDBAdl9Pnx9XfPe8jBkYzQb6Flz3TsHJ5k=;
	b=sD3+7a9yzSIYxzwB9QysmwsbTRuCar+GLCGDRd5TzA8PuLOVbRalcb+WGT0tnGKQEpj7bq
	8QOfv7qKSGTeqN1OaD2WVSdJvws4vdAtIX7N5v0LGrthPGmd5M8jR5vvM+iabSUx8DqFdd
	93Aijdacc+CwWxgVAgrfzcuk0d4qOKs=
Message-ID: <1d92694f4c71324970862724d693c45c423f94ae.camel@iki.fi>
Subject: Re: [BlueZ 01/12] gatt-server: Don't allocate negative data
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Thu, 04 Jul 2024 15:25:14 +0300
In-Reply-To: <20240704102617.1132337-2-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
	 <20240704102617.1132337-2-hadess@hadess.net>
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

to, 2024-07-04 kello 12:24 +0200, Bastien Nocera kirjoitti:
> Set a lower-bound to the data MTU to avoid allocating -1 elements if
> bt_att_get_mtu() returns zero.
>=20
> Error: OVERRUN (CWE-119): [#def36] [important]
> bluez-5.76/src/shared/gatt-server.c:1121:2: zero_return: Function call "b=
t_att_get_mtu(server->att)" returns 0.
> bluez-5.76/src/shared/gatt-server.c:1121:2: assignment: Assigning: "data-=
>mtu" =3D "bt_att_get_mtu(server->att)". The value of "data->mtu" is now 0.
> bluez-5.76/src/shared/gatt-server.c:1123:19: assignment: Assigning: "__n"=
 =3D "(size_t)(data->mtu - 1UL)". The value of "__n" is now 184467440737095=
51615.
> bluez-5.76/src/shared/gatt-server.c:1123:19: assignment: Assigning: "__s"=
 =3D "1UL".
> bluez-5.76/src/shared/gatt-server.c:1123:19: overrun-buffer-arg: Calling =
"memset" with "__p" and "__n * __s" is suspicious because of the very large=
 index, 18446744073709551615. The index may be due to a negative parameter =
being interpreted as unsigned. [Note: The source code implementation of the=
 function has been overridden by a builtin model.]
> 1121|		data->mtu =3D bt_att_get_mtu(server->att);
> 1122|		data->length =3D 0;
> 1123|->		data->rsp_data =3D new0(uint8_t, data->mtu - 1);
> 1124|
> 1125|		return data;
> ---
>  src/shared/gatt-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 3a53d5dfde6b..c587553d655d 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1118,7 +1118,7 @@ static struct read_mult_data *read_mult_data_new(st=
ruct bt_gatt_server *server,
>  	data->server =3D server;
>  	data->num_handles =3D num_handles;
>  	data->cur_handle =3D 0;
> -	data->mtu =3D bt_att_get_mtu(server->att);
> +	data->mtu =3D MAX(bt_att_get_mtu(server->att), BT_ATT_DEFAULT_LE_MTU);

Is this correct, probably MTU less than default are valid?

>  	data->length =3D 0;
>  	data->rsp_data =3D new0(uint8_t, data->mtu - 1);
> =20

Might be better to instead: MAX(data->mtu, 1) - 1

--=20
Pauli Virtanen
