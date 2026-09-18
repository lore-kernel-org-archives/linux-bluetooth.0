Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C24F96B4;
	Fri, 18 Sep 2026 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745712; cv=pass; b=kY6dQyaq7haclVyeQTjvmJQAL6aa5SuLc8MSwoUAi8aOo4TKK7njJHQ3sgywtzJP85Iv7+13XWPdva5FbO2GMkiVh9+6R3yDr6h6g364kLqMyL/PgHiPaQrn/73FeAnDetWAWWnTksgUGocDqrsYzAYfeRvRwVQNkJn/nrf1yaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745712; c=relaxed/simple;
	bh=/uICbTJnOJHvz94YClvo4iTFMIU7tZmrHcfspO7/LKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9+pHRzMSjnU0XR4+homBuGFzSIcfRhA4Aq7dlzMHIydaiVwWit8OtbHuHHvO5bgYhIZAbux7o2ZZNvdAqPP7kQM6j7fcFRPSzpCiOjvenwogfr8aDtacW25x633dOOkWcXX/I+TkxsN605TS0eF6nGbL4mz6Li6nzn/bGPBfZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=vjs9u89Q; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="vjs9u89Q"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:f410::d101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hmcBW65qqz4BKFc;
	Fri, 18 Sep 2026 18:34:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789745701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PjuTV6n3RwxbESCi1/LCiypvfS9qjgx4e8znG64rbjM=;
	b=vjs9u89QlbezoWlPKyV9HxMB4q3sTaYjuUA8WlgYzdqarxpZDCbF/Ds5x2ijHwjvE0XmIl
	U1uZ12hWylT0JpU6yJBX2g8SrqmUuB0RMOU/wnvayHNaX/B0EJ5JaCsgOVV0QMkhrmutaY
	+3p/NrTNAYfim3aekoFqfTBbZkcevuC1+pTnanKSL3sFUASGO6UvCaQugpVNGmlEdTLjTG
	R11MmhHvGrbcunY2bpZwP4Bq9Z/ebczlBQWH2mUGPgWQO4XrMzYUsq0s0HbPsgEiXhjI0O
	r+x88VlyjWwMT2Hqb0MJc0z4Rk0B0uTCfPs/DXR3xG3qQes/Q/VigWcOP3RlJg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789745701;
	b=YcFc7SfKlxWB656o+dSmy4Wa796GRVI9f83Bo6+SRqytV0i1cT8AmS8+fcIuY7fUgVf9O/
	o9U5SQ5DpWBruE65CBs9cHItH4CW81FDMSZsjd5d2HgP0raHma6ARv/sUDauZV7o9jXcrO
	gCcV7Za2O2HTcYBghqrS96il53tCD8PfPBiL5DSwX661lE4rJNZ3JSI1jYN08GNjqwsq9A
	3gtDffQHVJC3EEeE+GTVmY8ibKiilJcawInT9nGFjjJ+PiqS7VxoYcc3T+FAaMFAkJs+2K
	3WFkvd2PBRHk7QoTtFYhitj/rM4WvyE5WRvNl4L6T+eDNVqaHwEmRoHZU0pmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789745701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PjuTV6n3RwxbESCi1/LCiypvfS9qjgx4e8znG64rbjM=;
	b=CkxwWfl6y3hL6ugHaDVhfTmeBjkt2uw9jkk6C1GZLXnltqOkkS9fJ55mDuCt4+kYft8Ldm
	J2kRVpfTtJmlk8XvKf9bF7/KRmYTNYCt0VQP5S4cuY1CT7LDpUub7CecPqgosjZLuUL+4f
	mn+jOzcnLBaCyBu2AM4BXa+nHuerKy89CBylOUMn6BxRwK+j9yOhuvORIU21XCZeXELfJ7
	CL9DrxgufvP2oCD4/ntBghF7CEpcWnPn1ume68Dl8JtabfwEj50aeOgcwhGn2GTTGyM/G6
	8RDLVYa2GdVfY7gkma7x4J8s00AKMW/r1oonQ6GgW7gZWGvVvN+x05F/qU1EAQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <1a654fabd259836313ca20f9d6fd0e40ceb4b760.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: af_bluetooth: Fix double list_del and UAF
 in accept_q
From: Pauli Virtanen <pav@iki.fi>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 	syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Fri, 18 Sep 2026 18:34:57 +0300
In-Reply-To: <20260918104736.958613-1-ngocthang2710.1999@gmail.com>
References: <20260918104736.958613-1-ngocthang2710.1999@gmail.com>
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

pe, 2026-09-18 kello 17:47 +0700, Nguyen Ngoc Thang kirjoitti:
> bt_sk(sk)->parent is a raw pointer with no refcount backing it, so a
> child sitting in the listening socket's accept_q can outlive it. When
> the child's channel is torn down independently (e.g. hci_error_reset()
> -> l2cap_conn_del() -> l2cap_sock_teardown_cb()), bt_accept_unlink()
> dereferences the freed parent, corrupting its accept_q_lock and list.

This was resent without replying to previous comments:

https://lore.kernel.org/linux-bluetooth/1baff112d1ebd255575c7e52936b13db10f=
218b7.camel@iki.fi/

AFAIK the issue is already fixed upstream in a different way.

> Additionally, if multiple threads concurrently tear down the child
> socket, bt_accept_unlink() can be called multiple times. Without
> checking if the socket is still in the list, the second thread will
> perform a double list_del_init(), causing list_del corruption (kernel BUG=
).
>=20
> Fix this by:
> 1. Taking a reference on parent in bt_accept_enqueue() and dropping it
>    only when actually unlinked in bt_accept_unlink().
> 2. Checking !list_empty(&bt_sk(sk)->accept_q) inside the accept_q_lock
>    to prevent double unlinking.
> 3. Moving sock_put() outside of the spinlock to avoid sleeping in an
>    atomic context.

These don't look right: eg. sock_put() was not inside spinlock even
before.

> Reported-by: syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D534002670dd34a114fdc
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>=20
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
>  net/bluetooth/af_bluetooth.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 411d66f24393..7797b1052808 100644
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
> @@ -257,15 +261,24 @@ EXPORT_SYMBOL(bt_accept_enqueue);
>  void bt_accept_unlink(struct sock *sk)
>  {
>  	struct sock *parent =3D bt_sk(sk)->parent;
> +	bool unlinked =3D false;
> =20
> -	BT_DBG("sk %p state %d", sk, sk->sk_state);
> +	if (!parent)
> +		return;
> =20
>  	spin_lock_bh(&bt_sk(parent)->accept_q_lock);
> -	list_del_init(&bt_sk(sk)->accept_q);
> -	sk_acceptq_removed(parent);
> +	if (!list_empty(&bt_sk(sk)->accept_q)) {
> +		list_del_init(&bt_sk(sk)->accept_q);
> +		sk_acceptq_removed(parent);
> +		unlinked =3D true;
> +	}
>  	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
> -	bt_sk(sk)->parent =3D NULL;
> -	sock_put(sk);
> +
> +	if (unlinked) {
> +		bt_sk(sk)->parent =3D NULL;
> +		sock_put(parent);
> +		sock_put(sk);
> +	}
>  }
>  EXPORT_SYMBOL(bt_accept_unlink);
> =20

--=20
Pauli Virtanen
