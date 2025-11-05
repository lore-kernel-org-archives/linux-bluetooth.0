Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28B263F30;
	Wed,  5 Nov 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371395; cv=pass; b=SqDeV0mGXn+GOMuSZZ1nvH/4JEeqBwaSwLkLMIOu9lGnWFC5YemgjC4cWef0SkzndlvqJJHLH+igxC3srBuuXU4eWKofRblWivtk9YCNLpYHZbsGTZ5l378h4d5zMShA4Xp3rEoz9Awz7LetmxuqeV8Z10n6ZP4prbt5jRlJ5AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371395; c=relaxed/simple;
	bh=xkYj+8SDXQPbonT6FgJmRgGbw/qgkW61tNYCcxZyim8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ii0qdJHaQ7W9QQeaPG/cPBFGiiUrchfPcIYtAwcMERYqojKOMY+bQHEEmLblyt+M4xf/VNkyshYOkVp+I4K1YTiaUn+aPx4jAH7H6yZJ/19nNEpe2BClOLH+HXWi9iAnUq6EkH/d2lmsMgvqEV7dHf0qAGgvNmy0DmuwfQW1e4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=R5sY4jAT; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="R5sY4jAT"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d1wYN438Nz49Q7N;
	Wed,  5 Nov 2025 21:36:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1762371385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RqJ93xJX5OuqZg0mBGT/lR+PWBGKlPoVMo6IMD3egmE=;
	b=R5sY4jATQEUld5Rp8xiHIk/3q055tdxIdyP85h3pC3qvlCO+mHkES3wRlO28HfeEoVI8P5
	m4Phr1EAOeFmg+SlIF4YgsmVq2Qas4SUN6kLszQEJzF/+7QfAwyZqyHwVj8mWTBCV5HzxK
	ALK0g1MDj9BnvhPgj2ji+RxhhJVMDKNzbjC6FIr3GMyMtuVBPvgJduPLo1+/V61TkmQiMq
	/cz704o6tFR3StfzIIMVyJaIPnInlbYMRtgv2Yp0Kupc3h2AGvIbXFvtlQCxeGpFSTv3ww
	69RMu3ZLU7jSZ49WiRmWSKjprQbPEk5Qw+O6W6ckzH/oH7tyQNzKpZcXEGyLJg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1762371385; a=rsa-sha256;
	cv=none;
	b=mOaODOuP7Lqj1bYwzHXEFDDdESZkWHkeTQR/gIIuDULmbxnpLgVD3xlpslp8rE/7N78ovG
	k0XM0iKqwo+QKQ1tDKS6SRuhZ2d3Mnu5VQXVnbSNln5pCjdpK/Hb0oiBud3fly+ESFL0I8
	bIuHC1zKM8JVM276NQ9Y0Pypn+8AGYnhlHr0NE+ftb4lG8UGOzcLtEHybe9DPSoI/Mg8GB
	lES9Y39LQa/0LwbKy0wQ9+Xfh3qnkMGFkfdw3GMTAHEVDi6SbCi35dxIFcC6LGbmW4uQ8u
	QSuDGot7NX8ctotlx5ORYC1t3QhQsxHfe2JXYWBguGgrX8droNT9LFLvQ2slQw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1762371385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RqJ93xJX5OuqZg0mBGT/lR+PWBGKlPoVMo6IMD3egmE=;
	b=eEdP23Pr3mRFg8pbhwNRCDokSINP571+515LrmVjW0ud7H2Of01Mq3hE71HsJGSKefcJrW
	bcKolFky7RNxkHNrgtSYgfhXVuayKfsQWttXeKv9E1WggPgKQ9l+0NgMt8RdNGQxXADAec
	MlGF6VJsyX4/BWhTHfWVAH8vd/y6vZmus+6YOMClfIOSGOgCk9NNZx9qPH4xr2ANYcpAbh
	QULcc2fulBD7/oPmJIGa8iokucQR/0C7Tk5ZrQJb8HQFNPO8aJ+AbbUmizyuF4tXjuJxOb
	sJSTiUCpfmrltuPD31XlK09z1TTRfVmmxz+eEPPaYri89Xbmq3YMgPCiM81OSg==
Message-ID: <e795d2b600d98bfaf9b63088929e8ac0e8d4e3ba.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_unregister_user
From: Pauli Virtanen <pav@iki.fi>
To: ssrane_b23@ee.vjti.ac.in
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Date: Wed, 05 Nov 2025 21:36:23 +0200
In-Reply-To: <20251105142251.101852-1-ssranevjti@gmail.com>
References: <20251105142251.101852-1-ssranevjti@gmail.com>
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

ke, 2025-11-05 kello 19:52 +0530, ssrane_b23@ee.vjti.ac.in kirjoitti:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>=20
> Syzbot reported a use-after-free in l2cap_unregister_user(), caused by
> missing reference counting on the associated hci_dev. If the device is
> unregistered while L2CAP users are still active, l2cap_unregister_user()
> may access a freed hci_dev when taking its lock.
>=20
> Fix this by taking a device reference in l2cap_register_user() using
> hci_dev_hold(), and releasing it in l2cap_unregister_user() via
> hci_dev_put(). This ensures the hci_dev remains valid for the lifetime
> of registered L2CAP users.
>=20
> Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce23c
> Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to ha=
ndle Command Complete")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
>  net/bluetooth/l2cap_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 805c752ac0a9..6a880f8ab6c2 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1688,6 +1688,11 @@ int l2cap_register_user(struct l2cap_conn *conn, s=
truct l2cap_user *user)
>  	struct hci_dev *hdev =3D conn->hcon->hdev;
>  	int ret;
> =20
> +	/* Hold a reference to hdev to prevent it from being freed while
> +	 * we have registered users.
> +	 */
> +	hci_dev_hold(hdev);
> +
>  	/* We need to check whether l2cap_conn is registered. If it is not, we
>  	 * must not register the l2cap_user. l2cap_conn_del() is unregisters
>  	 * l2cap_conn objects, but doesn't provide its own locking. Instead, it

The old comment here seems out of date since commit ab4eedb790cae,
currently l2cap_conn_del() appears to be using conn->lock to do

	mutex_lock(&conn->lock);
	...
	l2cap_unregister_all_users(conn);
	...
        hci_chan_del(conn->hchan);
        conn->hchan =3D NULL;
	...
	mutex_unlock(&conn->lock);

so it looks likely also taking conn->lock could avoid the races with
conn->users and conn->hchan.

> @@ -1717,6 +1722,10 @@ int l2cap_register_user(struct l2cap_conn *conn, s=
truct l2cap_user *user)
> =20
>  out_unlock:
>  	hci_dev_unlock(hdev);
> +
> +	if (ret)
> +		hci_dev_put(hdev);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(l2cap_register_user);
> @@ -1735,6 +1744,9 @@ void l2cap_unregister_user(struct l2cap_conn *conn,=
 struct l2cap_user *user)
> =20
>  out_unlock:
>  	hci_dev_unlock(hdev);
> +
> +	/* Release the reference we took in l2cap_register_user */
> +	hci_dev_put(hdev);
>  }
>  EXPORT_SYMBOL(l2cap_unregister_user);
> =20

--=20
Pauli Virtanen
