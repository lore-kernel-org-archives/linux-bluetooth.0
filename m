Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBF3CBE74
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874082; cv=pass; b=OAFZKDPLEwBvH/TTT55rpAOrVAh3LPVT0bg1ERpRfkbGx9fpNg3jfa3IEt2CE404IENhBGKggV44EYIIEm5Whi+pueLa630+vcxoLCz45Pb2S+G2/Uy7iXfOp/Uofk49M6A9QbIXAPUW5+zJQE4IE0fS48LsFJvXA0a7UkzRZxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874082; c=relaxed/simple;
	bh=MH083J1CMQ1SKEWf+Bo0isn3AAmPcUJsZ7swFZVRFks=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFTqpvAVplPkyc5Q4bMWeNiCkb8O66+5zX3KQjzTY2bHzfWI+ifWlGY2b4D0P2DDu9UghzSIrqHox0alazQ97iXYPvJivRSeE4cd95AlMgM4NXk5IYuC5aUfrNzqeqr+YRQskvIAOXRo7bIMKwQElUE8zyTLeeHQDFVydwFPyQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ESa4G1TK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ESa4G1TK"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hWJ1b1cLyz49Q38;
	Fri, 28 Aug 2026 02:41:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1787874067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lvDfa0AVECbU6+awk7SoI2F5u7j11XEf/n19TDcrFwU=;
	b=ESa4G1TK0EZAnOImymDZME5YMbNmAdmu0MFVTYOCGVVYNFGSE/nMe4naiBhNl1E3xbneiU
	YZbr6TxMCuPNgwzlBfpcsKYp1eH0tp+2bI/z+AllK1fJ4kdUUCwH6SyhDvdxwmBdKV0qFn
	jK4JqcVRESrzBPbTcpbtdvjj7HIEYopzJK6H9owN8Oyqj2Gzgkn9lWod7mqAYUJwQvvpH/
	GtYJBcduS5Pe12IDEj+/tSUwWkA5stix4XjJeDGeiRcbvPvulSSx9i7ndX36i1Mw9cOb6s
	3qFXpXjeqjiPTEIbM8NHxonAcTU9+yAc54aTPeJke8b4aLIcHgMlQQKb6FV+eA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1787874067;
	b=DzYa2uIrHx02k0nPhImpe34ywLJVXzMXQP2gZdikpksrTHlszeCvNnWQJxAXSEoMBTXPne
	ySVYZKPnaSwDUZSLqenqZcDGwOffBKWnTP7V33VDx3YdBDACzEIy6ptWqg1n9QcNqYDtNe
	hEY8w0b+VLoYBvDUG9DNXh2xHHCDempe8tvXW/+PnFHGT9lDySywT7YSXsKg2VtK2vWhKS
	zRtrJKikaikK2pIbinrDlabobsE5fr9ljn99Ade0uKtu64kiY9/h8+aQ3k1K52rtNRBYJV
	ms0kcVVY7IGLEAKaNwmGsTwPequ0tVy+TBwLeIhEC/g9lle/prZkjFW5geW5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1787874067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lvDfa0AVECbU6+awk7SoI2F5u7j11XEf/n19TDcrFwU=;
	b=bLlgpLrXQ2F18zCZi0i9pjP6Rrq7vjo7/rV/869mJvFx0fETjqkuCl/TFD1ZMy3h79t+aG
	0TJ4UYIqKSetfT/VYuTJd/dWelYk2Jm7Lao0CbY6Mmm7+fN7enhfaL9P9thCg2z9Lxwhsa
	s5CrUnOcJor3hf9xBr2kr33IkvYFKIm/MxghGZQ8j8HD0UqCLxfyVBaow/FG7ryBgQIqF2
	CxUL+5/zrSJOcnTfS1iSXZRxQcZ+ypgLN5Zaz1UAFBaVcH/5y8KClGuU6HqQRaINBMM1eG
	qm/MYXhwtZoGcjdFhDX7mTrVH4eIDWyhTyEyh7561W7qps0iGlMgil4MrNlqVA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <0186ef45e8d10fa469fe31f32d24b54c672157a3.camel@iki.fi>
Subject: Re: [PATCH v1 1/2] Bluetooth: SCO: require CAP_NET_BIND_SERVICE to
 bind
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 28 Aug 2026 02:41:05 +0300
In-Reply-To: <20260827180149.415744-1-luiz.dentz@gmail.com>
References: <20260827180149.415744-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2026-08-27 kello 14:01 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> SCO sockets have no PSM or port namespace: binding one simply reserves
> the ability to accept any incoming eSCO/SCO connection on the adapter.
> That is equivalent to listening on a well-known service, which L2CAP
> already restricts to CAP_NET_BIND_SERVICE in
> l2cap_validate_bredr_psm()/l2cap_validate_le_psm().

In current Linux userspace, sound servers that do HFP listen on SCO
sockets, and I think often don't have CAP_NET_BIND_SERVICE.

Do they continue working with this change?

> Apply the same restriction to sco_sock_bind() so unprivileged processes
> can no longer hijack incoming SCO links.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/sco.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 3d4362a09df4..e4c26551e513 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -667,6 +667,13 @@ static int sco_sock_bind(struct socket *sock, struct=
 sockaddr_unsized *addr,
> =20
>  	BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
> =20
> +	/* Binding a SCO socket reserves the ability to accept any incoming
> +	 * eSCO/SCO connection on the adapter, so restrict it in the same way
> +	 * L2CAP restricts well-known PSMs.
> +	 */
> +	if (!capable(CAP_NET_BIND_SERVICE))
> +		return -EACCES;
> +
>  	lock_sock(sk);
> =20
>  	if (sk->sk_state !=3D BT_OPEN) {

--=20
Pauli Virtanen
