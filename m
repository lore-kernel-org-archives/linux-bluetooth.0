Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AC17588
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926001; cv=pass; b=MGQ/gKvnK8Yjwh0cnGKdisBcXccC3o+Tz2FATcyrKmpzrx/UFhcM1Nto5HsTkLV32njdhCn+3060c+RHgm+TE5FaKNor+zhogE6yKMOMLmAeiI40iGfoUlJwJ5+qzYTJdV6fsHPtBGh2xOoSTcNdk7DEwKLJo81wCNgW03mYbZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926001; c=relaxed/simple;
	bh=5aCvZhDk2VxtLkLeoQcUyBq3XgxsMrot5TwJP77XOgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KSIECvsAzD/GSfUAZCm5hFhewTikk8f9GyWizfReSRbfo1ZxKzd7a4E8O3mRwchTgXit33/f45k79CsTOPMnLqdqWA8UQ2c4wnXQnOe1VGjnlSCI6V4O5S/b6p7WnzJdBab902lI/5gKetMa705hm/vwDiaiB+lXZXEWrvBYpKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=m2ey0e0Q; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="m2ey0e0Q"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WVGxH1VmHz49Q30;
	Thu, 25 Jul 2024 19:46:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1721925988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuBtHcU1zfwuFuNHS7HwX5I7QbcSVP6wFII68Qabago=;
	b=m2ey0e0QG6KzjhyjiHntVYpFVbQYESs013UXfJeMmtTx5O5hTmT51H2CVQ/N1+SasYldKW
	vK1kBVIvUuEhoMAxyrXQ0Ke2dZRMPRctogACsgjleFKJUbs5ZP3Q5GIWrHaBpmTVPJ7QX4
	R/Le3/c+7xuFo3HReZ4fs5w6H/ZdEYf2Z0LF26TlPVt6UQat9nSwjJ1grLAm0D+TYetuKV
	mesBuayihiO8vOBE5pc5VyeUa7nVJylC13UhRw54Ea6WT9uUKZujpfum9N7s9TRubKeA2p
	ClGWYBqYX+DWeOQ9ChmA7koT5gyzNGFuWN03R0pQGWTL6CCiHTwnAVVdgTj+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1721925988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuBtHcU1zfwuFuNHS7HwX5I7QbcSVP6wFII68Qabago=;
	b=InjYvpBjExC/qdcGkIOdnpZ9Et4vo5I4hD2UIwX52886T0MA+TiKNSgCESRfSgBlr0dkx+
	yUEkFTKxiWg3n+G3p0IcN4pmV6D/+NReixqEfU/Hx884goDHlZOKgvFZBDUtX99v1XYPXq
	GF17nD6vnd9tFTsD1TQ02zKwz7XGBzmmNOU9jh50uHHcSjvyLJvm/oC1tz9dzuPyS1KhMa
	XwvBw8pRS0FMLPPd5xuQIXenjpHCaZHfkKliW+Tpty+cn43EBiBJTpOIXvqTrdmBVf3HfG
	Nd0N7vGT+l/dUWv7IQFO8qEqqGLc8dMCCpwzu8d/CbH8f+SevYY0rTWjCuWwHQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1721925988; a=rsa-sha256;
	cv=none;
	b=NMpit7k5YGKpnQN7ti1yViHr8i41rd1TQSWipO3wnvHPOmYTF6KXPTC8Njtqg9zzDFd021
	67GKwF7UfqBYRgzMjGbG9UAwY8mpaR9Qb8anFKt0fWWB4oQD98r0fp2X69r+/8bjY6h63L
	zQqPPwrLIDFDI43zPSfGiR08Npy0uq5rkSCowG3xClSoOnwCtf7O3efkq62bPyIYHu91/h
	2Ppb6RYYzZr8mEA/8P7JZqLYfKXTsKQCxu5IoJKg42DlS5DjhMd438F2/OX5dY4onXUJ7U
	vZN/zpTtV5YuyoaWhz3vzVT6jmGGpXWaabChO+LlLPDzTHlT/SgxGPT6zyfssg==
Message-ID: <de813bd5a9a3b966a109b26cac9003bad7d5e198.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 1/5] doc/media: Add 'broadcasting' state and
 'Select' method
From: Pauli Virtanen <pav@iki.fi>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>, linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com, iulia.tanasescu@nxp.com, 
	andrei.istodorescu@nxp.com, luiz.dentz@gmail.com
Date: Thu, 25 Jul 2024 19:46:23 +0300
In-Reply-To: <20240725115854.234781-2-vlad.pruteanu@nxp.com>
References: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
	 <20240725115854.234781-2-vlad.pruteanu@nxp.com>
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

to, 2024-07-25 kello 14:58 +0300, Vlad Pruteanu kirjoitti:
> This adds a new state for transports created by the Broadcast
> Sink. Such transports will remain  in the 'idle' state until the
> user calls 'Select' on them, at which point they will be moved to
> 'broadcasting'. This allows the user to select the desired BIS as
> the audio server automatically acquires transports that are in this
> state.
> ---
>  doc/org.bluez.MediaTransport.rst | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransp=
ort.rst
> index 6e95df8f2..47346d36b 100644
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
> @@ -51,6 +51,18 @@ void Release()
> =20
>  	Releases file descriptor.
> =20
> +void Select()
> +``````````````
> +
> +	Applicable only for transports created by a broadcast sink. This moves
> +	the transport from 'idle' to 'broadcasting'. Since the audio server
> +	automatically acquires transports that are in this state, the user can
> +	thus select which BISes he wishes to sync to.
> +
> +	Possible Errors:
> +
> +	:org.bluez.Error.NotAuthorized:

Should there also be Unselect() that forces the transport back to
"idle"?=C2=A0

IIRC, BlueZ as A2DP Sink/ACP behaves like that --- when remote INT
stops audio stream the transport goes back to "idle". So it would be
similar, with the difference that a local application --- instead of
the remote side --- is controlling whether the stream is "playing".

I guess the design question here is whether local apps shall to talk to
BlueZ or the sound server to enable specific audio streams.

Having the "enable" flag either in BlueZ or on audio server side is
possible, esp. if it is question of transport acquire.

As audio server, we could e.g. expose it as the device "on/off" profile
state, which user can turn on/off e.g. in pavucontrol.

***

Note that the current Pipewire BAP Broadcast behavior I think is work
in progress. Acquiring the transport on PENDING I think is maybe
accidental --- it is using the BAP Unicast Server code path, and in one
of the bcast sink patches from NXP I see there seems to be intent to
use BAP Unicast Client like behavior, but probably it's not quite right
if you see the acquire-on-pending behavior.

(As "server" Pipewire will expose audio streams similarly as
application audio streams, and by default direct them to available
audio speakers. As "client" Pipewire exposes the audio streams as
virtual microphone devices, which the user can manually record from or
link to speakers.)

> +
>  Properties
>  ----------
> =20
> @@ -84,6 +96,8 @@ string State [readonly]
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
