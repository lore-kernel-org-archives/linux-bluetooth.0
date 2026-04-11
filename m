Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7F25392A
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775905651; cv=pass; b=Z+dJAzJ0Cej8smaErGjxeLxL5KN+kYs1/S49rhvlYrS7vpwnkkUbwk79NFvMyOZ6dLEP4xKy9PP/jxr1t1h8rSUbFi6n6IjEUDn6yyUexq/+hBXvdSkgLlG2IgWxOAtWvzPvM73+/XfT58+GvQ3QUePR0x4rIBcW3u68ObXLHIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775905651; c=relaxed/simple;
	bh=6zXTMlEnbK08bMMPvs3Aw2aXpSbaZx8CynldkouGPBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWxHtzVLIBbXzfOZINvCn0kE0DoDyRbkerIUkc2lBGeJ+19M/7F7XQlc7MUqGv/etWZ0xcqd2WQJFhQrPvnZ62jS2hy7TqA/T6jK5vdeMIZs4F9ZDizg7uA2mvVc78kQIuYdKDyuTBIJZx7dssTSWRxXV2MiWQ6rBd6HVm19Oyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Psi8HaGR; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Psi8HaGR"
Received: from [10.156.141.210] (mobile-access-2e844b-114.dhcp.inet.fi [46.132.75.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ft9qR6XNZz49PxH;
	Sat, 11 Apr 2026 14:07:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1775905636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VUpEqteWPm3K3K1SScIuiCscyqIICswe0Rfva57ngbs=;
	b=Psi8HaGRBsfgWeE8S9Vlkxor3H/7qOzClAJZJ0X1OHlw3M48eLHA9RfHWAyGYujJjdcQeN
	N03gOFTUPIUQfgQv6Boei6BFfv/zSXhv0AjiTlB3hhoanG3IHzT1BWROEiqv0OH4Aw46Vj
	juoU7h9HEW85vGyn4irxZxIhTzi57D5KitGFeXSm7w834Ctg9gTCE0mkSsjAOHwkhSh9Ux
	wEiSPdPIJRU5B8kFLhl4uhVTM7w5pSw+W3zCoEHKLJFfRKKLBLJd/j32/0TJoB9IGbsKT+
	jsKJyPj6OBmAbneF11BUyYDUUqOEb9CZltCO3eaGTB51auN/U2sP+B0g9/p/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1775905636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VUpEqteWPm3K3K1SScIuiCscyqIICswe0Rfva57ngbs=;
	b=Vb3UevXeQOwIN+5LlIJGKqYniItyO/EhAxEerQQgmHddKUNJPJ8fJ8tN/cOVPBbpzHvHQH
	dqE2rR+gtpgKJ49seyXMmfV0z+CNw25F2XXu8TB818dwrbjFJcfqkg7iT073E7PM8t58ws
	U4tBI2qv2C2cC0pk5Yv4FiN3FiMkOCxNifCN0Tb5vjHjOP+0ik6Xn81SBflET+HDOG3Cuo
	ysQGkwC6OTZNgWwLl/sC2v7HssNQelbwMMd/akYK+uxp1rI009nk/IOeozWW46ebQSWl0J
	6tCsJn7ss+bxs5vXrSDWNR91Sy7CVUxPymw7Uzlsb7Whc8LWDZJS46Zej3XnTQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1775905636;
	b=I3T13EVBynHb4BHo/5Gb8huEnH3d037HzlOtMf/e15cj+nxbDV2Jt4TcCz0dQVnsFuwIv7
	HwGFswKxhIk1Sa56OmAww5aEx7EevaRu95Jj8k+tBWEMpu8TcC2y4p73N8Q/qQeM1Q/UeV
	eR8skwjXkTQCSRnPWRacTgK9O/d36A+r0IIwYgoMm0eDoqEk6Mb1yavdJ28fZ+RagIffh4
	Xzf2VQNG1F5FJn6heGn17MVhRooUYgMOeAjFEYf4xpGr8NLiP17gXmGAoX8oKhRwQpJ0PZ
	JozdHa2D6U7YzlKlKZojG1tLfCFeFna2z0Hx8sfNXBc0wbgnxxw5WrTzC6pO6g==
Message-ID: <c8a8aca1bb455d72e5e902b4ae0487947457b0e6.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: hci_conn: fix potential UAF in
 create_big_sync
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: devnexen@gmail.com
Date: Sat, 11 Apr 2026 14:07:13 +0300
In-Reply-To: <20260410201343.229470-1-luiz.dentz@gmail.com>
References: <20260410201343.229470-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2026-04-10 kello 16:13 -0400, Luiz Augusto von Dentz kirjoitti:
> From: David Carlier <devnexen@gmail.com>
>=20
> Add hci_conn_valid() check in create_big_sync() to detect stale
> connections before proceeding with BIG creation. Fix
> create_big_complete() to handle the resulting -ECANCELED error
> and validate the connection under hci_dev_lock() before
> dereferencing, following the established pattern used by
> create_le_conn_complete() and create_pa_complete().
>=20
> Without this, create_big_complete() would unconditionally
> dereference the stale conn pointer on error, causing a
> use-after-free via hci_connect_cfm() and hci_conn_del().
>=20
> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connec=
tions")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_conn.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 3a0592599086..7e6b3542809c 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, vo=
id *data)
>  	u32 flags =3D 0;
>  	int err;
> =20
> +	if (!hci_conn_valid(hdev, conn))
> +		return -ECANCELED;
> +
>  	if (qos->bcast.out.phys =3D=3D BIT(1))
>  		flags |=3D MGMT_ADV_FLAG_SEC_2M;
> =20
> @@ -2204,11 +2207,17 @@ static void create_big_complete(struct hci_dev *h=
dev, void *data, int err)
> =20
>  	bt_dev_dbg(hdev, "conn %p", conn);
> =20
> +	if (err =3D=3D -ECANCELED)
> +		goto done;
> +
>  	if (err) {
>  		bt_dev_err(hdev, "Unable to create BIG: %d", err);
>  		hci_connect_cfm(conn, err);
>  		hci_conn_del(conn);

hci_conn_del() is called without hci_dev_lock() here.

It probably should take the lock and check hci_conn_valid() inside the
critical section before calling into hci_conn_del().

Probably hci_conn_del() should have=C2=A0lockdep_assert_held(&hdev->lock)

>  	}
> +
> +done:
> +	hci_conn_put(conn);
>  }
> =20
>  struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 =
sid,
> @@ -2336,10 +2345,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *=
hdev, bdaddr_t *dst,
>  				 BT_BOUND, &data);
> =20
>  	/* Queue start periodic advertising and create BIG */
> -	err =3D hci_cmd_sync_queue(hdev, create_big_sync, conn,
> +	err =3D hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(conn),
>  				 create_big_complete);
>  	if (err < 0) {
>  		hci_conn_drop(conn);
> +		hci_conn_put(conn);
>  		return ERR_PTR(err);
>  	}
> =20

--=20
Pauli Virtanen
