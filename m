Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2293546EA;
	Sat, 25 Jul 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784978491; cv=pass; b=fXdaioldRiRfwxGR5b09AROWPBuL+6xWLCR7ch0B2kXhnEGD7Ku7cEyfJ005A7bm6gSvVyHFGHBej7nqUBSQwOJ7bKjjEWprs7R4mu16ACEEEmp9Dp69EUNJ01mvDGdrrbunGfNbkdgvjAKEzQALNBqPOKXePWGuJGpeVGpS6tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784978491; c=relaxed/simple;
	bh=JejLCo/eexvyEpdLq5sAhZBCHPdlMrUiM6XMmqfoWYg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r303wwpSkA9tfhQB0KFPZrW/ElnzwFIucjdLHBc3LB2S7BS86c+o7q+q9wYidkEEdoz+3MWT/ZUJOWPqMhMkuZ88EB0U+xl5KkHVkt13o3xlcWiVnxRFHcNDgR7PwRoALqvCltEPfGICxdJ2jQoaB1X14niMLk6hgpT3t4YzxpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Di4hL+PB; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Di4hL+PB"
Received: from [192.168.1.195] (unknown [45.83.220.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h6j9G0t3gz49QK5;
	Sat, 25 Jul 2026 14:21:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784978482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yGzVfLsgVwmgX4Qm7Hbm4pmzq4g+u9V32HWgEEt2HeY=;
	b=Di4hL+PBDxKAAh+wSV02IlTgbLa3qpxex1kcnEw2ETRKZT4rsieZBv/cfnoh1gLht2ZkeP
	+Ghx0or8ibPtwaHJPGnmlkENbFnWYYgLsNcspKgj8E1SIphLvMfDPp2odD2ivsT837UeFN
	96g/ovfKmh5jzQLdHY7/Wq/NHaes1ysKnahS6pGsg784h1t+5fMx3CKQRpZPUyTWcBn3/c
	86OW6zH+7Ch6b0A+xSCioXeWna6W6c5dwHFEtfZ6t1mbsflmaNr3JZ8qWEKWB40lInrHEs
	SI4LAPRktylWHcXBgCGbMiKNchYvICbEtjjRcmc+dPNaE6qR+ndBo/IHR2SnrA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784978482;
	b=JemzIV7jchBfCt2ESFxBZJpUsU1EpV/IEjOQ8T73GFMwac7ziJevuVwFH5TdJI82BN4k0m
	3s04eKwuLjgVG7fL9hATCoRiCIdIhH2rlG2YD/k5xS7KcMcOCwzHowd9vqUiWGFIegM0Qi
	NLuNr/ZB/kHsaeUXF/3m2Al0D2VvKeofzhUgtczuGPzBvR3P5dHV7RsRpbhnIv1fpz7WXx
	EwTySb6mDOgZpsYz5tnQLfMlopKxqw0ve+nKN2v/qhc7OTpZULtb5d2K5xvp5WvQEpeYFL
	+0VcpRuOZc6Cj9ZcqrXr7BS2vOVNG/kfa5R9vxI1G1PRYeMHo+YSWPCZs7FhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784978482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yGzVfLsgVwmgX4Qm7Hbm4pmzq4g+u9V32HWgEEt2HeY=;
	b=YQmPjfiVskUAlykcUzZ3vfRf545BjoSIV5co4eyGHwBTxrPClU6j4iMna9PzMwRWUUIzUe
	v6ZBnS+VC6NkvzDs/FQ8M2XL13vRPZWGfpe9/ziNnoDtTjkCOfdd7Rz6Y/DBg4Atp1XWiQ
	eDxmjuB+JO8We687WWydpoLUjEojk2CitKLBg2iEYcamDW5Wfe7fEnNe49s5UeKNTthAQq
	OozLT7usUJ4a11dz3KWvNOh3mo1i+olnrSWm/abJTHYff0ZLtrypfminusX2+X6h2vRSGp
	X1KSPuXWfhhnEDH8nvAALCz+Db7Ifh/NUsQCn4MmrUuWonA4uZttJwRH36Rayg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <85848db4c55a05c6116e00f5344df93b57d0f65a.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: ISO: fix UAF in iso_conn_ready
From: Pauli Virtanen <pav@iki.fi>
To: Jiale Yao <yaojiale02@163.com>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 25 Jul 2026 14:21:06 +0300
In-Reply-To: <20260725105127.434136-1-yaojiale02@163.com>
References: <20260725105127.434136-1-yaojiale02@163.com>
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

la, 2026-07-25 kello 18:51 +0800, Jiale Yao kirjoitti:
> When iso_connect_cfm() calls iso_conn_ready(), the latter reads
> conn->sk without holding a reference. A concurrent close() on the
> ISO socket triggers iso_sock_kill() which frees sk, leading to a
> use-after-free when iso_conn_ready() subsequently accesses the
> freed sk via lock_sock() and iso_sock_ready().
>=20
> This was triggered by a vhci-based PoC that races
> LE Setup ISO Data Path (0x206e) command completion against
> close() on the ISO socket. The crash manifests as a KASAN
> null-ptr-deref in iso_connect_cfm() at offset 0x3c from a NULL
> pointer, with the call trace:
>=20
>  iso_connect_cfm+0x311/0x15f0
>  hci_cc_le_setup_iso_path+0x46d/0x6f0
>  hci_cmd_complete_evt+0x26d/0x990
>  hci_event_packet+0x468/0xb40
>  hci_rx_work+0x255/0x6e0
>=20
> Fix by replacing the bare pointer read with iso_sock_hold(conn)
> under iso_conn_lock, which atomically elevates the refcount,
> and add sock_put() on the exit path where the hold succeeded.
>=20
> Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  net/bluetooth/iso.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 2e95a153912c..c8103de41cdd 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2074,7 +2074,7 @@ static bool iso_match_dst(struct sock *sk, void *da=
ta)
>  static void iso_conn_ready(struct iso_conn *conn)
>  {
>  	struct sock *parent =3D NULL;
> -	struct sock *sk =3D conn->sk;
> +	struct sock *sk;
>  	struct hci_ev_le_big_sync_established *ev =3D NULL;
>  	struct hci_ev_le_pa_sync_established *ev2 =3D NULL;
>  	struct hci_ev_le_per_adv_report *ev3 =3D NULL;
> @@ -2083,6 +2083,10 @@ static void iso_conn_ready(struct iso_conn *conn)
> =20
>  	BT_DBG("conn %p", conn);
> =20
> +	iso_conn_lock(conn);
> +	sk =3D iso_sock_hold(conn);
> +	iso_conn_unlock(conn);
> +
>  	if (sk) {
>  		/* Attempt to update source address in case of BIS Sender if
>  		 * the advertisement is using a random address.
> @@ -2103,7 +2107,8 @@ static void iso_conn_ready(struct iso_conn *conn)
>  			}
>  		}
> =20
> -		iso_sock_ready(conn->sk);
> +		iso_sock_ready(sk);

This should re-check conn->sk and socket state again after acquiring
lock_sock to avoid state transition on closed socket.

See
https://lore.kernel.org/linux-bluetooth/b9341fe78dbe1ddd550b5099e6c87006fdb=
4b3e5.camel@iki.fi/T/#m4ddb5fb1add7bd2375de3ce5a92335922dd14abd


> +		sock_put(sk);
>  	} else {
>  		hcon =3D conn->hcon;
>  		if (!hcon)

--=20
Pauli Virtanen
