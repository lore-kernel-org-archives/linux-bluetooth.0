Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF01C700C
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512630; cv=pass; b=l1zsxa0RVTRg2caOSGELS3qq5t29DmlpqmsYG5yZxeM/JrnGfR4m8/q46mAX1sItMFY7A5Ap2AdxcY9pkaJupXpj5KDbH/1S1yDl4uBcFA/5asxoPWVWZegMRYB7/13Kk1A7p2OpKDx6xDhqfIB9f21xLyB8mKGECEjONa+0Wds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512630; c=relaxed/simple;
	bh=SYbIChKh0bwF2Dxpx59t5+CI4cH+575QwoNdNXnatNs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxOjQNbcTuqHpfaX3oMRdGSFcEfapI92JEEow0NpijY7hwdcZeXYlV6kYMXnb9ZUAG74CiQmRBoOebna7m9DnpdzCl9MIXJVWqCTSKdczrwF/9kC7QZL8ct6gOssSA9EP85ObhQV7NCb6Sv70jUzqZi2oU+EpjiOqN9SX/3+KNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=g2SIr0aW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="g2SIr0aW"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cdbK26ZbDz49QFl;
	Fri,  3 Oct 2025 20:30:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1759512615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=04FNavaW2Li4UsgfTdtkz0KSNZQ2m4jswtLfoF+W93w=;
	b=g2SIr0aW2sanMmhH3i8NuzcSLWX8s1RSEMn/RE9Jpe0Qm0GruuF+4AvS9RbdYU9F5vFX0W
	pO+nigpB26wnsK1KdWhD4IW3ewp1I2rXt7cfW4kWUikI/7opATZ2lrPdmW7WwX8YmbkFUM
	LmjCnwYnHepOl9hysb4GwREPYgL41veLASY+xkkI8+bwGWYSRaA5BUq053eTtAMrqw7w+q
	upXNuekdfB6hLtwDtdZbkpzcgM3Qkk4MVflFk7nbyUPjWnvn1jnV+9tNhTdaXAbxR9ElKC
	vwXxdyo8nWjjyx+It8fiZs0jOMhPEUWO68+vvf29HzsaIDwq9NC9QiMLgEfbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1759512615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=04FNavaW2Li4UsgfTdtkz0KSNZQ2m4jswtLfoF+W93w=;
	b=whqUhhrhAK8LCwdtzSAjZTBjbgZOxIri28qcY0290OW3Sh8utcm0axCJ/+A/nIMkkZKROt
	vMY0BMErmtfrU8fckKXqfxoOJ8KmkyRH1bWLy9afG6GRwar3R/PdIgZusCw37C/O8e5R7u
	F6QaVWArpDk0DyJNTucliVwUq2kf0ebf0J+1yQjcqQFiY4sk58v8Gy8D+SFHGgU2E2sMee
	sYsQXMXFgtY+RcwzgBRZ2/ZGYZKpxp5L/GkciESBEe311AZANPB/nPdcdNK5WNdrMUisr4
	UXJV47XTOfOY4zcaFhylGz0Tld3KWaMUoAtrBJ3wC34ZF5eCgtK1beyPAQ0yQw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1759512615; a=rsa-sha256;
	cv=none;
	b=etuR7LfYVjDtszinPl6qgrWnJq6WjNH8XzBx2l4ZXvMIei/xRyvGuDXXR2AvBhrbVPVp7r
	/nSVS1Is6YGldIsrAEj3V2j6OUXql2SVUkCr9ducQAUTbAEJIqs2UssnGPp2doUgRsEJEn
	+gApmk01CDxA1IzkVMiwxYd3lINvT8YrmYKwSDRZepIjeaEFLkRV0EWEouvBCUYROPooFL
	VlA2hOot/E8YNFkAxSs+23tQi5Jb4YQQXAQHAoFEKOkU0X2qx1k85Z3XR5o4VNlhz5xB3C
	kk17Kf80gi4Xxowj4SyvdKm2vwVAPkwZ8lgRQoddZWZNO6gyNl87zs+rhHf7bQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <998ff7d8bb8c26f449ddc869fdd7c525b2868d19.camel@iki.fi>
Subject: Re: [PATCH v1 3/5] Bluetooth: ISO: Add support to bind to trigger
 PAST
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 03 Oct 2025 20:30:14 +0300
In-Reply-To: <20251003153424.470938-3-luiz.dentz@gmail.com>
References: <20251003153424.470938-1-luiz.dentz@gmail.com>
	 <20251003153424.470938-3-luiz.dentz@gmail.com>
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

Hi Luiz,

pe, 2025-10-03 kello 11:34 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This makes it possible to bind to a different destination address
> after being connected (BT_CONNECTED, BT_CONNECT2) which then triggers
> PAST Sender proceedure to transfer the PA Sync to the destination
> address.
>=20
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_sync.h |  1 +
>  net/bluetooth/hci_sync.c         | 74 ++++++++++++++++++++++++++++++++
>  net/bluetooth/iso.c              | 62 ++++++++++++++++++--------
>  3 files changed, 120 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci=
_sync.h
> index e352a4e0ef8d..3133f40fa9f9 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -188,3 +188,4 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, str=
uct hci_conn *conn,
> =20
>  int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
>  int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
> +int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5051413f1a97..aad9689af610 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -7228,3 +7228,77 @@ int hci_connect_big_sync(struct hci_dev *hdev, str=
uct hci_conn *conn)
>  	return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
>  				       create_big_complete);
>  }
> +
> +struct past_data {
> +	struct hci_conn *conn;
> +	struct hci_conn *le;
> +};
> +
> +static void past_complete(struct hci_dev *hdev, void *data, int err)
> +{
> +	struct past_data *past =3D data;
> +
> +	bt_dev_dbg(hdev, "err %d", err);

Looks like past_data should hold references, otherwise it's UAF below:

hci_conn_put(past->conn);
hci_conn_put(past->le);

> +
> +	kfree(past);
> +}
> +
> +static int hci_le_past_set_info_sync(struct hci_dev *hdev, void *data)
> +{
> +	struct past_data *past =3D data;
> +	struct hci_cp_le_past_set_info cp;

hci_dev_lock(hdev) here otherwise it's UAF if conn/le are deleted
concurrently

> +
> +	if (!hci_conn_valid(hdev, past->conn) ||
> +	    !hci_conn_valid(hdev, past->le))
> +		return -ECANCELED;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.handle =3D past->le->handle;
> +	cp.adv_handle =3D past->conn->iso_qos.bcast.bis;

hci_dev_unlock(hdev)

> +
> +	return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST_SET_INFO,
> +				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> +static int hci_le_past_sync(struct hci_dev *hdev, void *data)
> +{
> +	struct past_data *past =3D data;
> +	struct hci_cp_le_past cp;

hci_dev_lock(hdev) also here

> +
> +	if (!hci_conn_valid(hdev, past->conn) ||
> +	    !hci_conn_valid(hdev, past->le))
> +		return -ECANCELED;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.handle =3D past->le->handle;
> +	cp.sync_handle =3D cpu_to_le16(past->conn->sync_handle);
> +

hci_dev_unlock(hdev)

> +	return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST,
> +				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> +int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
> +{
> +	struct past_data *data;
> +
> +	if (conn->type !=3D BIS_LINK && conn->type !=3D PA_LINK)
> +		return -EINVAL;
> +
> +	if (!past_sender_capable(conn->hdev))
> +		return -EOPNOTSUPP;
> +
> +	data =3D kmalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->conn =3D conn;
> +	data->le =3D le;

data->conn =3D hci_conn_get(conn);
data->le =3D hci_conn_get(le);

> +
> +	if (conn->role =3D=3D HCI_ROLE_MASTER)
> +		return hci_cmd_sync_queue_once(conn->hdev,
> +					       hci_le_past_set_info_sync, data,
> +					       past_complete);
> +
> +	return hci_cmd_sync_queue_once(conn->hdev, hci_le_past_sync, data,
> +					       past_complete);

`data` is leaked here if command was already queued or queueing fails.

> +}
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 7f66f287c14e..318b5b914cc4 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -987,20 +987,13 @@ static int iso_sock_bind_bc(struct socket *sock, st=
ruct sockaddr *addr,
>  	return 0;
>  }
> =20
> -static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
> +static int iso_sock_rebind_bis(struct sock *sk, struct sockaddr_iso *sa,
>  			       int addr_len)
>  {
>  	int err =3D 0;
> =20
> -	if (sk->sk_type !=3D SOCK_SEQPACKET) {
> -		err =3D -EINVAL;
> -		goto done;
> -	}
> -
> -	if (addr_len !=3D sizeof(*sa) + sizeof(*sa->iso_bc)) {
> -		err =3D -EINVAL;
> -		goto done;
> -	}
> +	if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> +		return -EBADFD;
> =20
>  	if (sa->iso_bc->bc_num_bis > ISO_MAX_NUM_BIS) {
>  		err =3D -EINVAL;
> @@ -1023,6 +1016,42 @@ static int iso_sock_bind_pa_sk(struct sock *sk, st=
ruct sockaddr_iso *sa,
>  	return err;
>  }
> =20
> +static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
> +			      int addr_len)
> +{
> +	struct hci_conn *le;
> +
> +	if (sk->sk_type !=3D SOCK_SEQPACKET)
> +		return -EINVAL;
> +
> +	/* Check if it is really a Broadcast address being requested */
> +	if (addr_len !=3D sizeof(*sa) + sizeof(*sa->iso_bc))
> +		return -EINVAL;
> +
> +	/* Check if the address hasn't changed then perhaps only the number of
> +	 * bis has changed.
> +	 */
> +	if (!bacmp(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr) ||
> +	    !bacmp(&sa->iso_bc->bc_bdaddr, BDADDR_ANY))
> +		return iso_sock_rebind_bis(sk, sa, addr_len);
> +
> +	/* Check if the address type is of LE type */
> +	if (!bdaddr_type_is_le(sa->iso_bc->bc_bdaddr_type))
> +		return -EINVAL;

hci_dev_lock(hdev) here otherwise le may be deleted concurrently I
think

> +
> +	/* Lookup existing LE connection to rebind to */
> +	le =3D hci_conn_hash_lookup_le(iso_pi(sk)->conn->hcon->hdev,
> +				     &sa->iso_bc->bc_bdaddr,
> +				     le_addr_type(sa->iso_bc->bc_bdaddr_type));
> +	if (!le)
> +		return -EINVAL;
> +
> +	BT_DBG("sk %p %pMR type %u", sk, &sa->iso_bc->bc_bdaddr,
> +	       sa->iso_bc->bc_bdaddr_type);
> +
> +	return hci_past_sync(iso_pi(sk)->conn->hcon, le);

hci_dev_unlock(hdev);

> +}
> +
>  static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
>  			 int addr_len)
>  {
> @@ -1038,13 +1067,12 @@ static int iso_sock_bind(struct socket *sock, str=
uct sockaddr *addr,
> =20
>  	lock_sock(sk);
> =20
> -	/* Allow the user to bind a PA sync socket to a number
> -	 * of BISes to sync to.
> -	 */
> -	if ((sk->sk_state =3D=3D BT_CONNECT2 ||
> -	     sk->sk_state =3D=3D BT_CONNECTED) &&
> -	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
> -		err =3D iso_sock_bind_pa_sk(sk, sa, addr_len);
> +	if ((sk->sk_state =3D=3D BT_CONNECT2 || sk->sk_state =3D=3D BT_CONNECTE=
D) &&
> +	    addr_len > sizeof(*sa)) {
> +		/* Allow the user to rebind to a different address using
> +		 * PAST procedures.
> +		 */
> +		err =3D iso_sock_rebind_bc(sk, sa, addr_len);
>  		goto done;
>  	}
> =20
