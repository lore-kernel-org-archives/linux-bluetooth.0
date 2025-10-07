Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A62E718E
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853818; cv=pass; b=D0Smc7SpR2ycYqkT/gfaGBQepNjkmyJau0gan/U+Qg3x1EfiSdrVQEG5HxqtmFeObUSNHK9pdJ9oCZr2Dn0KPsqV+S3HwS16v949xYcoCry8lWuPDp+Ac/jqB4GQVmGa55N6FlKe1ocUFWLyFTPj+KHkwyNnDoRYhu8RVpF7pz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853818; c=relaxed/simple;
	bh=HZUknjH7Wrl7N3nUYiHk0d0RjaNFz7tgoW4h7aaLhJ0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r52+3VbSQj+HD2L4z32+isLMga/Z38JJMc2l7CiMgEzJxTOki2c82IYjxvfMglAXaO50xvytmErq3xoB4ejdZOZCaDiS3KT5SCAOaYxUxYIWsaRKtmZ7SGqIjEmJq57b46AbFSVyKoJOa0ytqW9pGQSsjLjlv//fqb04laAxmbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=hQl5F/pk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="hQl5F/pk"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ch1VK63ncz49Q4h;
	Tue,  7 Oct 2025 19:16:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1759853802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UqNPI/5+vli1kG1vRpHF/LN7CkYyqBTdi9P3T1cjazU=;
	b=hQl5F/pkRxIVwynhWydryFb8wbqKnAwW5VT46oq251jcatLO7qtrrt5QUVjizBh/8PRRt7
	q4GmanIMvBR+LAwjh7tx6s0rhGqSY3zj99ZPWlAZWh1qbE8Sf/NBRo2/5wuvUlWQdH7NVM
	uIZeXqfz0Hd8hw5BMcjvgW/f+hri+0WcmcE4kEX+IAhwMA/rQcQH7gXtAxISlu7VRi5AJX
	lTnbLw8CdJeg+4wjcMeEcXq9zVt3QIz0yKrZUpJW/WDuMfQ7DaEqH3ace5b/zG1VZmwlRE
	HUqwyyx56FEkQymCdeAekFH73My71HEqPZds6e5way5cSr4f6CIrHdiwy9OTkA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1759853802; a=rsa-sha256;
	cv=none;
	b=dL2r2HYGJWgLNvq1qzNR+vmoN24YSSeFgbBhwNTttR01w2DfHS3xVFzCcoMGm49rb595t3
	gKzUngIVwlj7iBcaXOOIloHuQqiFpnEUvEaYudPT5EGMye97fSx+9cqHHJ0B7DEBGt+DRT
	YUFVOC+njKLZR75qFbEwVV72Mt9FNDKZ2jBgJHzcbj4DSJnE/KwuHmiA0kkHEhQoBVM5Z/
	2xoCG91Tmnpiimp104vbYoGwKcExis1Sdqm9lWRR5nSdd5pph+1fFcdYoyqrK1VlEHCT0E
	ZCvVftpGx5AcZngKhesr7mDKNEqDl1yYMWJj5xxUMm202C1GbURztohLxG6JjQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1759853802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UqNPI/5+vli1kG1vRpHF/LN7CkYyqBTdi9P3T1cjazU=;
	b=reECGDmdPwf35LOek7MwhWKx4mFCmbBQrH8kV9WSll8mFEQw5Vk8/iVpC93lTTHABvwIUu
	cOvutCbrVowfwp5xc1l/D5dUGrTnYlaUfjvDJVd1Q57Ui0WSzXV6Tpou9ZEMqgaw8KdpaF
	ZLuIF5W3LK9UO8Q2DwEL1AmEM8hcpfLTHfvMlsfQhkIx1PH1AxES8cO5K5/gS7RJKKTt+y
	dRaHx58Ptbh40TRLV8Pvv6sXcD5WlotSCUWahRJ0jZSjnqbMlmDCy87JqqNZsHqSDgat49
	sNk3RpBoZqjlYxXndXFUPUD1MeIUdv/XFJ1i+xHPZ/02oNuYiuRYDwxiLdoY/g==
Message-ID: <00e427f14250d2e81c520a6f66f67337366f1c53.camel@iki.fi>
Subject: Re: [PATCH v2 3/7] Bluetooth: ISO: Add support to bind to trigger
 PAST
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 07 Oct 2025 19:16:41 +0300
In-Reply-To: <20251007144930.1378274-3-luiz.dentz@gmail.com>
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
	 <20251007144930.1378274-3-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
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

ti, 2025-10-07 kello 10:49 -0400, Luiz Augusto von Dentz kirjoitti:
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
>  net/bluetooth/hci_sync.c         | 90 ++++++++++++++++++++++++++++++++
>  net/bluetooth/iso.c              | 80 +++++++++++++++++++++-------
>  3 files changed, 153 insertions(+), 18 deletions(-)
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
> index 5051413f1a97..571e07f81523 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -7228,3 +7228,93 @@ int hci_connect_big_sync(struct hci_dev *hdev, str=
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
> +
> +	kfree(past);
> +}
> +
> +static int hci_le_past_set_info_sync(struct hci_dev *hdev, void *data)
> +{
> +	struct past_data *past =3D data;
> +	struct hci_cp_le_past_set_info cp;
> +
> +	hci_dev_lock(hdev);
> +
> +	if (!hci_conn_valid(hdev, past->conn) ||
> +	    !hci_conn_valid(hdev, past->le)) {
> +		hci_dev_unlock(hdev);
> +		return -ECANCELED;
> +	}
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.handle =3D cpu_to_le16(past->le->handle);
> +	cp.adv_handle =3D past->conn->iso_qos.bcast.bis;
> +
> +	hci_dev_unlock(hdev);
> +
> +	return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST_SET_INFO,
> +				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> +static int hci_le_past_sync(struct hci_dev *hdev, void *data)
> +{
> +	struct past_data *past =3D data;
> +	struct hci_cp_le_past cp;
> +
> +	hci_dev_lock(hdev);
> +
> +	if (!hci_conn_valid(hdev, past->conn) ||
> +	    !hci_conn_valid(hdev, past->le))
> +		return -ECANCELED;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.handle =3D past->le->handle;
> +	cp.sync_handle =3D cpu_to_le16(past->conn->sync_handle);
> +
> +	hci_dev_unlock(hdev);
> +
> +	return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST,
> +				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> +int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
> +{
> +	struct past_data *data;
> +	int err;
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
> +
> +	if (conn->role =3D=3D HCI_ROLE_MASTER)
> +		err =3D hci_cmd_sync_queue_once(conn->hdev,
> +					      hci_le_past_set_info_sync, data,
> +					      past_complete);
> +	else
> +		err =3D hci_cmd_sync_queue_once(conn->hdev, hci_le_past_sync,
> +					      data, past_complete);
> +
> +	if (err)
> +		kfree(data);
> +
> +	return err;
> +}
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 7f66f287c14e..d4c8772152bd 100644
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
> @@ -1023,6 +1016,58 @@ static int iso_sock_bind_pa_sk(struct sock *sk, st=
ruct sockaddr_iso *sa,
>  	return err;
>  }
> =20
> +static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
> +			      int addr_len)
> +{
> +	struct hci_conn *bis;
> +	struct hci_conn *le;
> +	int err;
> +
> +	if (sk->sk_type !=3D SOCK_SEQPACKET || !iso_pi(sk)->conn)
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
> +
> +	iso_conn_lock(iso_pi(sk)->conn);
> +	bis =3D iso_pi(sk)->conn->hcon;
> +	iso_conn_unlock(iso_pi(sk)->conn);
> +
> +	if (!bis)
> +		return -EINVAL;
> +
> +	hci_dev_lock(bis->hdev);

No lock is held here before hdev lock. If bis is freed concurrently,
this is UAF.

Maybe:

	hdev =3D hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
			     iso_pi(sk)->src_type);
	if (!hdev)
		return -EHOSTUNREACH;

	hci_dev_lock(hdev);

	iso_conn_lock(iso_pi(sk)->conn);
	bis =3D iso_pi(sk)->conn->hcon;
	if (bis->hdev !=3D hdev)
		bis =3D NULL;
	iso_conn_unlock(iso_pi(sk)->conn);

	if (!bis) {
		hci_dev_unlock(hdev);
		hci_dev_put(hdev);
		return -EINVAL;
	}

	...

	hci_dev_put(hdev);

Or maybe hdev can be get also from iso_pi(sk)->conn->hcon, how the
locking and ownership seem to work currently for iso_conn need
contortions:

/* Must be called on unlocked sk */
static struct hci_conn *iso_get_sk_hdev(struct sock *sk)
{
	struct hci_dev *hdev =3D NULL;

	/* Lock sk: access to iso_pi(sk)->conn needs sk lock because
	 * iso_disconn_cfm() -> iso_conn_del() -> iso_chan_del()
	 * sets iso_pi(sk)->conn =3D NULL under hdev->lock & sk lock
	 */
	lock_sock(sk);

	conn =3D iso_pi(sk)->conn;

	/* Lock conn: does not seem to be really necessary as code
	 * paths that touch conn->hcon seem to all hold sk lock
	 * based on a quick look
	 */
	iso_conn_lock(conn);
	if (conn->hcon)
		hdev =3D hci_dev_hold(conn->hcon->hdev);
	iso_conn_unlock(conn);

	release_sock(sk);

	return hdev;
}

> +
> +	/* Lookup existing LE connection to rebind to */
> +	le =3D hci_conn_hash_lookup_le(bis->hdev, &sa->iso_bc->bc_bdaddr,
> +				     le_addr_type(sa->iso_bc->bc_bdaddr_type));
> +	if (!le) {
> +		hci_dev_unlock(bis->hdev);
> +		return -EINVAL;
> +	}
> +
> +	BT_DBG("sk %p %pMR type %u", sk, &sa->iso_bc->bc_bdaddr,
> +	       sa->iso_bc->bc_bdaddr_type);
> +
> +	err =3D hci_past_sync(bis, le);
> +
> +	hci_dev_unlock(bis->hdev);
> +
> +	return err;
> +}
> +
>  static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
>  			 int addr_len)
>  {
> @@ -1038,14 +1083,13 @@ static int iso_sock_bind(struct socket *sock, str=
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
> -		goto done;
> +	if ((sk->sk_state =3D=3D BT_CONNECT2 || sk->sk_state =3D=3D BT_CONNECTE=
D) &&
> +	    addr_len > sizeof(*sa)) {
> +		release_sock(sk);
> +		/* Allow the user to rebind to a different address using
> +		 * PAST procedures.
> +		 */
> +		return iso_sock_rebind_bc(sk, sa, addr_len);
>  	}
> =20
>  	if (sk->sk_state !=3D BT_OPEN) {
