Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A192E6112
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923502; cv=none; b=pXdX7DqniC9n6tVpRht28MfCClkAkRUmnV18cUFM0gkO8M5vs95NCWa/E8UQrsy/lUF0XZPDrLWuEl0KSz0+GYZ88+i431IziB+owGFB3LcmdMIgHb81VapRP6ZGPaj5d+D/bt5NdSLIpqavYlMDkqm/sPcqSTJvggOqjGwMii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923502; c=relaxed/simple;
	bh=ePUlYZZQkWZ9QZzmM1dxCgI3RGbxgPRI4OQykMrHTys=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+LzW+ppXSCAub4UWgWaCw2zxidhokg9zRhoiL9vNn/KCM9+pFh7X6yBXt+1Fnks4QgrIh4RLX5zdgfSaGiqi3yVVyQdMNvjM9TOea8TnAf1qn6kVpG83zncT0lYbbR+uBCWSQtK+oT/24ucwPiSZiMqCeTvoVV9pAf23OXqvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D83E244464;
	Mon, 15 Sep 2025 08:04:51 +0000 (UTC)
Message-ID: <7aa2bc23a4988168e28f1bb144a39c3223a4fbb1.camel@hadess.net>
Subject: Re: [PATCH BlueZ] audio: Fix typos in A2DP error messages
From: Bastien Nocera <hadess@hadess.net>
To: Per =?ISO-8859-1?Q?Waag=F8?= <pwaago@cisco.com>, 
	linux-bluetooth@vger.kernel.org
Date: Mon, 15 Sep 2025 10:04:51 +0200
In-Reply-To: <20250915075553.1636970-1-pwaago@cisco.com>
References: <20250915075553.1636970-1-pwaago@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepphifrggrghhosegtihhstghordgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

Looks good to me

On Mon, 2025-09-15 at 09:55 +0200, Per Waag=C3=B8 wrote:
> ---
> =C2=A0doc/org.bluez.MediaEndpoint.rst | 8 ++++----
> =C2=A0profiles/audio/a2dp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 8 ++++----
> =C2=A0profiles/audio/a2dp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 8 ++++----
> =C2=A03 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/doc/org.bluez.MediaEndpoint.rst
> b/doc/org.bluez.MediaEndpoint.rst
> index bbe00b637..c1ce1d562 100644
> --- a/doc/org.bluez.MediaEndpoint.rst
> +++ b/doc/org.bluez.MediaEndpoint.rst
> @@ -69,11 +69,11 @@ Possible errors for A2DP endpoints:
> =C2=A0	:org.bluez.Error.A2DP.NotSupportedMinimumBitpoolValue:
> =C2=A0	:org.bluez.Error.A2DP.InvalidMaximumBitpoolValue:
> =C2=A0	:org.bluez.Error.A2DP.NotSupportedMaximumBitpoolValue:
> -	:org.bluez.Error.A2DP.InvalidInvalidLayer:
> +	:org.bluez.Error.A2DP.InvalidLayer:
> =C2=A0	:org.bluez.Error.A2DP.NotSupportedLayer:
> -	:org.bluez.Error.A2DP.NotSupporterdCRC:
> -	:org.bluez.Error.A2DP.NotSupporterdMPF:
> -	:org.bluez.Error.A2DP.NotSupporterdVBR:
> +	:org.bluez.Error.A2DP.NotSupportedCRC:
> +	:org.bluez.Error.A2DP.NotSupportedMPF:
> +	:org.bluez.Error.A2DP.NotSupportedVBR:
> =C2=A0	:org.bluez.Error.A2DP.InvalidBitRate:
> =C2=A0	:org.bluez.Error.A2DP.NotSupportedBitRate:
> =C2=A0	:org.bluez.Error.A2DP.InvalidObjectType:
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 661843a89..6661a95d2 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -183,11 +183,11 @@ static struct a2dp_error config_errors[] =3D {
> =C2=A0	{"InvalidMaximumBitpoolValue",
> A2DP_INVALID_MAXIMUM_BITPOOL_VALUE},
> =C2=A0	{"NotSupportedMaximumBitpoolValue",
> =C2=A0				A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_V
> ALUE},
> -	{"InvalidInvalidLayer", A2DP_INVALID_INVALID_LAYER},
> +	{"InvalidLayer", A2DP_INVALID_LAYER},
> =C2=A0	{"NotSupportedLayer", A2DP_NOT_SUPPORTED_LAYER},
> -	{"NotSupporterdCRC", A2DP_NOT_SUPPORTERD_CRC},
> -	{"NotSupporterdMPF", A2DP_NOT_SUPPORTERD_MPF},
> -	{"NotSupporterdVBR", A2DP_NOT_SUPPORTERD_VBR},
> +	{"NotSupportedCRC", A2DP_NOT_SUPPORTED_CRC},
> +	{"NotSupportedMPF", A2DP_NOT_SUPPORTED_MPF},
> +	{"NotSupportedVBR", A2DP_NOT_SUPPORTED_VBR},
> =C2=A0	{"InvalidBitRate", A2DP_INVALID_BIT_RATE},
> =C2=A0	{"NotSupportedBitRate", A2DP_NOT_SUPPORTED_BIT_RATE},
> =C2=A0	{"InvalidObjectType", A2DP_INVALID_OBJECT_TYPE},
> diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
> index bcdb4d43f..e742b5dfc 100644
> --- a/profiles/audio/a2dp.h
> +++ b/profiles/audio/a2dp.h
> @@ -102,11 +102,11 @@ enum a2dp_error_codes {
> =C2=A0	A2DP_NOT_SUPPORTED_MINIMUM_BITPOOL_VALUE =3D 0xcc,
> =C2=A0	A2DP_INVALID_MAXIMUM_BITPOOL_VALUE =3D 0xcd,
> =C2=A0	A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VALUE =3D 0xce,
> -	A2DP_INVALID_INVALID_LAYER =3D 0xcf,
> +	A2DP_INVALID_LAYER =3D 0xcf,
> =C2=A0	A2DP_NOT_SUPPORTED_LAYER =3D 0xd0,
> -	A2DP_NOT_SUPPORTERD_CRC =3D 0xd1,
> -	A2DP_NOT_SUPPORTERD_MPF =3D 0xd2,
> -	A2DP_NOT_SUPPORTERD_VBR =3D 0xd3,
> +	A2DP_NOT_SUPPORTED_CRC =3D 0xd1,
> +	A2DP_NOT_SUPPORTED_MPF =3D 0xd2,
> +	A2DP_NOT_SUPPORTED_VBR =3D 0xd3,
> =C2=A0	A2DP_INVALID_BIT_RATE =3D 0xd4,
> =C2=A0	A2DP_NOT_SUPPORTED_BIT_RATE =3D 0xd5,
> =C2=A0	A2DP_INVALID_OBJECT_TYPE =3D 0xd6,
