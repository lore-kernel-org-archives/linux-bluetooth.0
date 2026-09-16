Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7EF4A7C92;
	Wed, 16 Sep 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578696; cv=pass; b=FUnOE/C3hCm0wu09Rc4oqoLhzSmp/iTb1XofAd+Hx496u9aLf2zIXS8d/+UdVD+eef7hgJBzdaq/R6a0GO/A3tp4XEAme/5QW88fXHIwbyqxcJGM6GIZx74an9eo+0ZVsG92h4hEG575Dn818YT3jp3MvVq/WX63sb3/jsoVzVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578696; c=relaxed/simple;
	bh=GxZVsYyO+dGhZVkNFl2G7bu9vGg6fGca6a+LddvN29s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kHFoeX9nJjDxLsUAEtCkrUux7TQHooDtASBTeQ+WwHvncvD+JnhSW+5Ex0ma7XQG0yL1GcNURIDZfKJZ+QDWxs48YZ17Bke5NLGFfR2Hv+hPHuSueYpVeC5y4K1wcWMtPVgDTPx2Xj/ST6TP0fYgGg93l87carRFKHZobn+9gFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ncBipncI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ncBipncI"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hlQQV48rFz49QKP;
	Wed, 16 Sep 2026 20:11:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789578676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ar4Xh04LVpsbbU5iorLfnkyCYqpy81z9xWfcNsmO9XI=;
	b=ncBipncIjxOjuNySr7ee/BLe6QwEEIUOqwHK5kX4+7hZG7OpgecH5raGMVe12IkBqjZIk/
	5ATVJg/MXMNLVAyEOWFEI9Necmp//xsarbo0PP2SJgUhQXGxBBM9bAh4LdUhClQ/zSjifa
	vs2WGHnALVNVFX+aooYVxGphmlMTktthlcYPLdfPgw/xzwsWbKRjKzGfcIGbXscHHrsRTg
	E4HHEehzeQtc7xQ7jM/n6Oe6AjKjZAL3lXjY6Pnje4oZiAk6bfCJOR9/I6FQ9HD9itXF47
	MMkIisCCbaH0NErIguFBoQ4U0Cr7rpQ6Gw/jPHOvUiOSsry2oQ6l8lLcvyJEkg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789578676;
	b=Lv7b3Z8PzWZdH5ghCl6V5/44sggZgV7p6bLpV5Dxo2BcBMKKYExrpLDBapTWd1zufcbosB
	Xo3EjwGqxFJ5QO1hipEx6vhwYHAaUcuJzEvSGyjnf27puLFIbk83/LlIsiAMLOp5P6d+S0
	MVu1YQQQ9AYxHXTZP6NFaslnDEltRBsUkZC/S8kPYcb46p4tdvGJVVDsKcrJ/txZbttIH1
	ec4FOaelm8OpB/uFhWzUIub85OPEuvzJPXSozZrh0LvEAJzksombKuEJ+3QKzaKnY7rYtK
	tRdgDUwDqgXGWhH4e0nd+cb7zN1FxPubBKFh03qld0me7vG5r3DABDTHSFGbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789578676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ar4Xh04LVpsbbU5iorLfnkyCYqpy81z9xWfcNsmO9XI=;
	b=diO2BS0ueli/KdnFA2fwvTCDyze49/k/9oniOO7g+A2XDSJvvLP6tp2eP/2nWab20ZSd7U
	XBo1X3K1Nh/QOoYtGpr68RpxYkLyBklbnZqOwoXWPQw1mT8s9Ze4aIt+ZC6kkRROlOVrvQ
	Kcs1WBeUkMIXX4RSJgjgkXgGUof1ITJSzNEIKwLZN01Im6nmGlj4Eq+3Us21t+G8q0pci6
	ZP3J+6nl/gYMuSZRVXBpcPhVou8WZrTQDCBWFrwkodhDcMp25r+M1RupuqecxQqLUg1zH4
	HxvVfzISdCIRRwceSAJPyF/9I0bGWVVBren/2N32TuTLxHPHU28c1AsDkgUqMA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <1baff112d1ebd255575c7e52936b13db10f218b7.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: af_bluetooth: hold a reference on parent in
 accept_q
From: Pauli Virtanen <pav@iki.fi>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, Marcel Holtmann
	 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
	syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Wed, 16 Sep 2026 20:11:13 +0300
In-Reply-To: <20260916153818.24916-1-ngocthang2710.1999@gmail.com>
References: <20260916153818.24916-1-ngocthang2710.1999@gmail.com>
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

ke, 2026-09-16 kello 22:38 +0700, Nguyen Ngoc Thang kirjoitti:
> bt_sk(sk)->parent is a raw pointer with no refcount backing it, so a
> child sitting in the listening socket's accept_q can outlive it. When
> the child's channel is torn down independently (e.g. hci_error_reset()
> -> l2cap_conn_del() -> l2cap_sock_teardown_cb()), bt_accept_unlink()
> dereferences the freed parent, corrupting its accept_q_lock and list.
>
> Take a reference on parent in bt_accept_enqueue() and drop it in
> bt_accept_unlink() to keep it alive for as long as a child points to
> it.

AFAIK the UAF described above cannot occur in current kernel:

https://lore.kernel.org/linux-bluetooth/3674f5d34d731403bfa0e680c9e57182376=
12315.camel@iki.fi/

> Reported-by: syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D534002670dd34a114fdc
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
>  net/bluetooth/af_bluetooth.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 411d66f24393..f9aae18c6733 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -224,6 +224,10 @@ void bt_accept_enqueue(struct sock *parent, struct s=
ock *sk, bool bh)
>  	else
>  		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> =20
> +	/* Hold a reference on parent so it cannot be freed while sk keeps
> +	 * a raw pointer to it via bt_sk(sk)->parent.
> +	 */
> +	sock_hold(parent);
>  	bt_sk(sk)->parent =3D parent;
> =20
>  	spin_lock_bh(&par->accept_q_lock);
> @@ -265,6 +269,7 @@ void bt_accept_unlink(struct sock *sk)
>  	sk_acceptq_removed(parent);
>  	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
>  	bt_sk(sk)->parent =3D NULL;
> +	sock_put(parent);
>  	sock_put(sk);
>  }
>  EXPORT_SYMBOL(bt_accept_unlink);

--=20
Pauli Virtanen
