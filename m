Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794510270;
	b=4oUC31gEGW1iIKYScbCUI8H9tYlQPsTINbOVEbMU5D4iuLb5cIctOiUwTkM8SZ0wGrMW
	 dRNB5RNs40UeCBZ4FcMICz8tePeqUf00LvhMywEfxbWyKRkFOsNBx0RlE6FvoeVv4TlQG
	 I/WVvj+kcrpUGz8m+ym9+7D3uRXBZai5Wl1/eF+f1GQ77BLlY/loEJR8+/oEZR1f9AB2d
	 yT1WRhDlg4Otnhb362/zegwECTrRzuY89zxLg3T54cq2JwGgcmWqU2sazHJKoSNy7WFy5
	 UQKXS8DYCqDECAUOGp32CoLAe0zR9Lr6LYYPKh95nOA8vlcsTj/VqQ6y5WWbgzh/znA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510270;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TRRgHAzIJZgmXBfIDhCJKk+90ACToQSi0feblazRET4=;
	b=mbpUFW1/EOvaXIq+eeajqSPy7AeJQlaNrWWibvQ20hvhufkaVWhCRo6sb4FeNM++3dpM
	 rMgn5g1zLcwfhIzrkn3dxTWlz34pR/D/9w3nFl9ThdzhBTspC5+EobfwjyvmWQQeix1n+
	 y5ef9mVV29OLgrpHdWh/8RdDf6j3WI9IjhP34pB3bhTfTbXgcrDSI2bZqcZrUpltIq0KD
	 5jUOmA3h6axFBJx+KCiJVAGW0/Opk26TI0WEnrsseiSkgrNGsoobmyr9cLrqZWSioruRV
	 CH7rMXQyE7Pf0kDjP/popjGEWLoIuq35WaW929wPxL2WgULOriQSa43ommm8RqAJtmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b="EXV/zlMq";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981E606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9981E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=EXV/zlMq
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4jQVDp4wp0z49Q0n;
	Thu, 12 Nov 2026 21:04:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1794510267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TRRgHAzIJZgmXBfIDhCJKk+90ACToQSi0feblazRET4=;
	b=EXV/zlMqxSjlO2Xep5XUDD7N0zwIpl/5ESRxrrBbwY1Co5Jva1w9OHckx19K3hGY/xHUKY
	IZtF6/EvZExqPHWSRfTZs4bR6h6KGhoD5OMzTVYTq2VFwKfjLGCBMmDhvmK0u/vPFokSuI
	R6ejRsP75jYm4RQtdux1d/nYRw3oO00yb6NOTI2iEI4nB3wjrjHF/DMGCQqKULKrsfGAGU
	C/RbFDjKfACTaH/UDKZXyBtPmmaLQdMWFvpPhsVSw+KxDJDFEwDMxoBoCBqh6FD7y0i2xM
	VKvO+n65tkEJIma1LIu8jWp5OenCspl0Vmdy7dwJ/3Las0+FuUiJ2hfXK4DGpQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1794510267;
	b=qbjDgA95x5d/ovoWEydAz3HGnYlFleYSjWoInt4lOF/ZUaVQVeflKQYTZrLU7SLLyPjgGG
	4LcLiV/zk49BmiuusPkCsZFC/yfU/dJVdnty/Ap2Csr0t9a16AJgvAPGxvWE81e7nMzlP6
	mbZPX6HmEYwt/h5tPA1mPhX36hEZokqXp9aQERjK5xhLgRjfOTh7ifNSnceR87lLNQWUvc
	hoTpMw4ZwzYcCn+3FkWpnVsgND83NZsLmQuxZ6KMFhAauyPWHPnRaGrFKWS6jGLo8MuNId
	csCevyI5DoD86EFQZLKSndMB04X7nVPYvZaL7bel0LGux6PdmqIYEy0aKK3RmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1794510267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TRRgHAzIJZgmXBfIDhCJKk+90ACToQSi0feblazRET4=;
	b=Z21CerlhIRw8MkMa0h7fxVAGn6G0LV7WqssLTWcwKKynBwn21Q+y8gaickVBBpU24f2YES
	fB/wstYDfEiZ5vLQc9q8XOmUR2l4e+pLOj/uwspRcpQ4gKMp4XLLW1L5bi+rUC5H50fKGn
	UJY0GFeMcqexiyDOitDjM2vYPV30K2eB2XdQ3gTSjwH+9WEDagOBuf/jhRMr25e92LfmDG
	lD3wiJnSQ58Nd82J9R9JQvCM326dApnFIjaP9P+BOetHrnzN0ZsT5A+z0xsIwpMbASSYFw
	TU7ujWQ4x9/J1D6csWaqtSgqn5+9jxwy/UbacySHXNj7nYG6fgs5Fc+I4kskkw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <fb7500035873e36482ca50348f156805c48c4af6.camel@iki.fi>
Subject: Re: [PATCH BlueZ v4 5/6] doc/functional-bap: Document clearing a
 cached configuration
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 21:04:24 +0200
In-Reply-To: <58959d386b3510668043b393074e097f773e09af.1794504552.git.luiz.von.dentz@intel.com>
References: <cover.1794504552.git.luiz.von.dentz@intel.com>
	 <58959d386b3510668043b393074e097f773e09af.1794504552.git.luiz.von.dentz@intel.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Luiz,

to, 2026-11-12 kello 13:14 -0500, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> Describe the test where the initiator clears an endpoint twice, the
> second time releasing the ASE whose codec configuration the acceptor
> cached.
>=20
> Assisted-by: Claude:claude-opus-5-5
> ---
>  doc/functional-bap.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
> index fc367e0f9181..eb04e6520aa8 100644
> --- a/doc/functional-bap.rst
> +++ b/doc/functional-bap.rst
> @@ -230,6 +230,30 @@ test_bap_unicast_desync
>  	single ASE of a CIS, so a failure of that one can be told apart
>  	from a failure of the initiator to enable the ASEs separately.
> =20
> +test_bap_unicast_clear_cached
> +-----------------------------
> +
> +:Setup: As above, with both transports created.
> +
> +:Steps:
> +	1. Initiator: ``endpoint.clear <remote PAC Source endpoint>``.
> +	2. Initiator: ``endpoint.clear <remote PAC Source endpoint>`` again.
> +
> +:Expected:
> +	1. ``Configuration cleared``, and the initiator removes the transport
> +	   of the Source ASE, which the acceptor moves to Codec Configured,
> +	   caching its codec configuration.
> +	2. ``Configuration cleared``, and the initiator releases the Source
> +	   ASE again from Codec Configured, so the acceptor moves it to Idle
> +	   and removes its transport. The Sink ASE transports are left in
> +	   ``State: idle``.

ASCS iiuc allows Release from Codec Configured to go Releasing, and
then back to Codec Configured, so it may not possible to get rid of the
configured endpoints.

Samsung Galaxy Buds2 Pro IIRC works like this, wasn't possible to get
endpoints go back to Idle.

In this case, does the current patchset accumulate pending
cached_releases?

> +
> +:Notes: Releasing an ASE in the Codec Configured state is permitted
> +	(ASCS Table 3.2, BAP 5.6.6) and is covered by BAP/UCL/SCC/BV-106-C
> +	and BV-107-C. Without it, an initiator could not get rid of the
> +	codec configuration an acceptor cached, as it no longer has a
> +	transport for it.
> +
>  test_bap_unicast_duplex_enable_one
>  ----------------------------------
> =20
