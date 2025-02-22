Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431241DC985;
	Sat, 22 Feb 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227467; cv=pass; b=MwJh23e4oMnSRsLEQbex/6+ZBPgFbiTFbCCN8z1+06IfBi8q8g4UG2e3n7TrtrKeco31Mm3RCY3WCaZlvknbYPGHxM0LTY/SSSDgZZdnhamAt4dVlYX06B7a68H04FLMV+yzVVaVNe2Wohj9GiOU5j3jS0Cal6A5zN7x/lDHgNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227467; c=relaxed/simple;
	bh=d4LrR1/JyyklKSSAPMrX79W6JK9ixNKrx/3Wk9E74f4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+xhkIK3EMWE1xC4KiZOPADHKdc4IvjEKUp6rjI4wo81NChIsbOzpiK29zhZSg2om4I5eAs6RIi9dnEJZ+9M1JVYWuSh0FUmGeLUDCPfh9p8bVQTOP+fipkD4QXEsDmQx7vJE1iT29ALYTipUX/woxw/06jdRmBkvq+/hD/TK/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=a/FollCo; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="a/FollCo"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z0R1S1ZZ2z49Pyv;
	Sat, 22 Feb 2025 14:21:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740226878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sJRsNtmPYOGIyLDoSNhjS/zQsaRUE47FT/Dx+pfvFTc=;
	b=a/FollCofaPcsEoNjK0gxZaMJwrovASKR0gnTnC17g7QMB3OaTX1wm89BiKdZ+9x081470
	4saGSNhyI5T/Ry+TONEMh65YZZRix6TAdddts0e6tjfzDsBz+SuevBE1KRlgbSmzRKon6i
	ogJRvNS3qCL9G1myl4ccZjVjI8Fv9HdvTShnz3IJ4BnZA+aQokOlqLa0Qy8oi3r2MndRrO
	IkjTQRBZraPjHriFLz6ePWcC4iBKCRyEdWMm5W3DjX+wknY83StxfkzESDWUC2sOv5t80j
	Cjl3RRIR18Pbs3DvIl6XjLUj5L+rBpl7dzz5KVUPcUcTLdP/L36hvD0PP/xbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740226878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sJRsNtmPYOGIyLDoSNhjS/zQsaRUE47FT/Dx+pfvFTc=;
	b=sxfiZ24uHtO9e49tzHwgb9x+xBzAr/m6JFm3eYe9/d15EqoyXKKnUJ+L/8qnJvsMg7aloT
	WAFncMRMZ9FqT4MmyAyed1yAyQb2/2IQBd3XTSuj1hAiP7pw6xSF6Fa6A+5/0gPkRrka+v
	KOb2+P07R+NT0drohqqEVpRY82qiKNt4158udJ1pO1eg8SO9vjqgZ87Iwb+Z2HpFisAM3V
	qZiaFuRsclhLzURCOKzhqTzvf3tg64Mme3jUdt/b1SjUCKQFHoYgBwlvaRyA7qOMMuK6Z+
	IamvAeIY+128+eUTeXsaR/DZ7XJcWhhunsP3UkMnLCZtv6J1hSu2aON6i4EJ4A==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740226878; a=rsa-sha256;
	cv=none;
	b=LJs3sHhn12LnuxtnHPylgDwDStSPyJv9jwI85gqTMFFyqS4xhhYcquzfQMimTHsgiwzquO
	CQ6yw7ezmBXoTpJQFeZA8CUZGFTYsBRnfIrAS4eRE5O/6P5L/S+ZMP44DGQp/s67MCOPOb
	qGvchdPu2fcff5pPfXsP4zsLIVcf0P2a3dpkDQdDxHY0qTWLAX5hYqPZKsDjxtehMDeO5m
	4cNcu83hIwQ/RAMdBSbFVibrWZlcRBdZOVbWAqbpn4Rfay6hNTCRw//Hm5UPZo920rvNTw
	8UkRw1w61QVm6D6sKGgBVCV70VEc1u0DJWkr9J6KBlHz2TliTxeMmUZ7kAqMLA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <7e57d93a41b45650506de4fc68dd04fbbc6b55fc.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: SCO: fix ABBA deadlock in sco_connect_cfm
From: Pauli Virtanen <pav@iki.fi>
To: Jeongjun Park <aha310510@gmail.com>, marcel@holtmann.org, 
	johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: gustavo.padovan@collabora.co.uk, andre.guedes@openbossa.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 22 Feb 2025 14:21:13 +0200
In-Reply-To: <20250222114809.11634-1-aha310510@gmail.com>
References: <20250222114809.11634-1-aha310510@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

la, 2025-02-22 kello 20:48 +0900, Jeongjun Park kirjoitti:
> Caused by previous commit 405280887f8f causes ABBA deadlock. So we need t=
o=20
> change the lock order to prevent deadlock.

The lock ordering eg. in sco_conn_del() or sco_sock_close() is

	hdev_lock > lock_sock > sco_conn_lock

IIRC this is the lock ordering assumed elsewhere in this file, except
the part touched by 405280887f8f (however, it's locking the parent
socket there so not clear if this causes deadlock, can you clarify if
you have observation/proof of deadlock).

In this patch you have

	sco_conn_lock > lock_sock

Does that also cause a deadlock?

>=20
> Fixes: 405280887f8f ("Bluetooth: Reduce critical section in sco_conn_read=
y")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  net/bluetooth/sco.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index aa7bfe26cb40..8f1377f4a27c 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -289,13 +289,11 @@ static int sco_chan_add(struct sco_conn *conn, stru=
ct sock *sk,
>  {
>  	int err =3D 0;
> =20
> -	sco_conn_lock(conn);
>  	if (conn->sk)
>  		err =3D -EBUSY;
>  	else
>  		__sco_chan_add(conn, sk, parent);
> =20
> -	sco_conn_unlock(conn);
>  	return err;
>  }
> =20
> @@ -343,11 +341,13 @@ static int sco_connect(struct sock *sk)
>  		goto unlock;
>  	}
> =20
> +	sco_conn_lock(conn);
>  	lock_sock(sk);
> =20
>  	err =3D sco_chan_add(conn, sk, NULL);
>  	if (err) {
>  		release_sock(sk);
> +		sco_conn_unlock(conn);
>  		goto unlock;
>  	}
> =20
> @@ -363,6 +363,7 @@ static int sco_connect(struct sock *sk)
>  	}
> =20
>  	release_sock(sk);
> +	sco_conn_unlock(conn);
> =20
>  unlock:
>  	hci_dev_unlock(hdev);
> --

--=20
Pauli Virtanen
