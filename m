Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A171AA3D5
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365124; cv=pass; b=VbLfPBeLE/Yhjl6cNtfTWvKYDwSG0gIys97/6A12M/f5zb35Tdlwvj4f29FP+YTQnYwtOuFir1HDD/HrWyEeYHTLsXXkasHJZJ+YuBBmf/iltvK8qdztCdafUAAD/624mjoKYxzhB0vWV9juI5lhf1zXjBlscBbLTMLXWgOKm88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365124; c=relaxed/simple;
	bh=/V8aliHYIXleKyquGFpnP7e+yYiGFY7bXBfcRNIGrTE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SqxsKUFycTuvDYAhgE/zfQ6xW3xiMSaMsfCYPd2henQ0OssLD008YTbaxffjfplh+1wjyIRjd5qu3RRs1FWUKd3AiQdO8uLgYzeFdkLfitRRhoz2jB4uGvAr+vvUZujkULaZ9SYyFoIRky0ewerxi6Y+8q3bDRUyutM2oMn49uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=WE3WZoxB; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="WE3WZoxB"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WYPL03KTGz49Pxq;
	Tue, 30 Jul 2024 21:45:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1722365114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+uneNZVH9LYaO02j+qdhq0o6H8rMHG32INe5+vBuTNE=;
	b=WE3WZoxB5Ma7fNhl29BuRb6jLsacVE8r8Afm6SKyWmbW1ro31ejXZzymV02zTCOSmzfYFL
	vp4jylbVhoWm9UJF+WEqIwCCXsvYI+Qy26t+YX4sjIKYpjP0ZMCkwEEAoyUMGEMfXJfAh8
	plCl41CVnmTtSe0cWpYiE/uw536J5BA0O0c8iK4v4DvBIHBkX/Z45/WU6UGoQhDy7/z167
	BKktxIC2dnEKp2BHUSGQSFoLDCJF5nJsqghmCz5MpfW0s7cmohRGGsyM+9d2ed/M+iYDGj
	Rs/bBnRtPtBc/zbaDzNIDa3cZeB3sjSPp/FK7m15XO5k+D/QQssB1hfBfhqfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1722365114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+uneNZVH9LYaO02j+qdhq0o6H8rMHG32INe5+vBuTNE=;
	b=sbUiBW5NcNspXzHy/AhD2SB+xYjy7tu6XIMZh42QcceY1kL6utxMO6cCQvR8vgmSa6hJBS
	qyboIhUz65DKMp+hTFhjq0WYDKxyf71VhlmumbJU1DvGbuI1rbyOz5SCOFGYjyPx34h83V
	aIKRaSiflq9ru8AF2XmEf9rVp0ABLOsJ1kT2z9iXtoohduO0vY4HnThlNSW/gqR3KayzAr
	Xmu/ZOiCdyGHW/lg/VTaB32ROc0K/QdVjGoiIl/17UySL/h6Yqkuj8mGgCJcOOUhnipjEE
	HNIKfIJq7yKH7zaj8nNShQrLwDN0UPw+Wxov68dI5SO7Fv7ud3VfHz3/v+s/Eg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1722365114; a=rsa-sha256;
	cv=none;
	b=gL2+zJbPyfbmmFvB8SOCrJI+QMx56bZLSe3RTZBAa9X3LQK8Zp3o/ZJAWfUC//ZWTtLVcu
	q+sS8/sa2MMmRC4t9somkYSUNiCwXG0sJjhFggp6cl9kBfugSOPajBukBK6F5Pn59R8S/X
	rMHFSRK8TdrcuZIyRSh1YPPa9SCrE+55ND3S/bHGzD9zOedYoN1avlB9l9i6aAFW3dJdlR
	rYC1CcByEAjm8fUIlvaZGI0VUmnQfFyZq5SZA7S/rTJL9mL/6jN9D+U1+d1Rr6lA4HQPuO
	3klpm3VoRoeWIx+1TzB7PzwkHrCCkMnV8QJTM+WArMD12BJrX8oT+nHFbYdpHw==
Message-ID: <efffe9727c4f26064d9db2d73f0a9404ea045064.camel@iki.fi>
Subject: Re: [PATCH BlueZ v4 1/8] doc/media: Add 'broadcasting' state and
 'select' method
From: Pauli Virtanen <pav@iki.fi>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>, linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com, iulia.tanasescu@nxp.com, 
	andrei.istodorescu@nxp.com, luiz.dentz@gmail.com
Date: Tue, 30 Jul 2024 21:45:09 +0300
In-Reply-To: <20240730140947.411655-2-vlad.pruteanu@nxp.com>
References: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
	 <20240730140947.411655-2-vlad.pruteanu@nxp.com>
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

ti, 2024-07-30 kello 17:09 +0300, Vlad Pruteanu kirjoitti:
> This adds a new state for transports created by the Broadcast
> Sink. Such transports will remain  in the 'idle' state until the
> user calls 'select' on them, at which point they will be moved to
> 'broadcasting'. This allows the user to select the desired BIS as
> the audio server automatically acquires transports that are in this
> state.
> ---
>  doc/org.bluez.MediaTransport.rst | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransp=
ort.rst
> index 6e95df8f2..c23d1f59f 100644
> --- a/doc/org.bluez.MediaTransport.rst
> +++ b/doc/org.bluez.MediaTransport.rst
> @@ -7,7 +7,7 @@ BlueZ D-Bus MediaTransport API documentation
>  --------------------------------------------
> =20
>  :Version: BlueZ
> -:Date: September 2023
> +:Date: July 2024
>  :Manual section: 5
>  :Manual group: Linux System Administration
> =20
> @@ -51,6 +51,20 @@ void Release()
> =20
>  	Releases file descriptor.
> =20
> +void Select_transport()

In the code I see the DBus method names actually are:

Select()
Unselect()

The DBus names are also conventionally in CamelCase().

> +```````````````````````
> +
> +	Applicable only for transports created by a broadcast sink. This moves
> +	the transport from 'idle' to 'broadcasting'. This allows the user to
> +	select which BISes he wishes to sync to via a 2 step process:
> +	1) the user calls this method, changing the transport's state to idle
> +	2) the audio server detects that the transport is in the 'broadcasting'
> +	state and automatically acquires it
> +
> +	Possible Errors:
> +
> +	:org.bluez.Error.NotAuthorized:
> +
>  Properties
>  ----------
> =20
> @@ -84,6 +98,8 @@ string State [readonly]
> =20
>  	:"idle": not streaming
>  	:"pending": streaming but not acquired
> +	:"broadcasting": streaming but not acquired, applicable only for transp=
orts
> +		created by a broadcast sink
>  	:"active": streaming and acquired
> =20
>  uint16 Delay [readwrite, optional]

--=20
Pauli Virtanen
