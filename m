Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B522A4C5;
	Fri,  9 May 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805579; cv=pass; b=nJQYFUY1SRxNqyFAG8Rx8VSDpm/65FUoI1XGYrVZTiDFqoGz+qpK8xMcvHd8JvV2sU6jBgaEEkNVbRZ+SbVEKrNa/ytWOLwYk1wRm7xb+eOBX4mnGPgbjiv84a7qXO7B6k95d/PrOYXftCNbwKoKQRjJK+DdiJoNlPpOMNzQuDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805579; c=relaxed/simple;
	bh=DPYNWDRVpgNJxo5l3xf63xXUDqf6j9yasxwS7GdK+qc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2eXv79kcCh4BXMj4pGcLQ8r/gsWl7PYkb0IHoLjzx0U6U8dSRXVfHc4sCctysOQv1bfljOVzjrqSFo6/apZ3mhhH1DrZpxW0RkhpL8oPWMIv62eijEdlU9xPggdwyIP9i6UEgDHvQgmZBBlVvrr/VAECHDzn3do7RxnA5TyEQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=izHavs5P; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="izHavs5P"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZvCyl4kVRz49PyG;
	Fri,  9 May 2025 18:46:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1746805569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dzJoEJI7/e8x2ibK1JWACDD3ve2/JsxJ86YTI7pkVwg=;
	b=izHavs5Pt3k0Y/z2P41v+XQpq2gtTCChcomJT602gzMXscpgA5Ia7Rrvp9edv2d1xw3+X5
	Q1wjfTDYEohJaHdQXhNVryZTMdloaZMrbGMIO6rwVv3EcvpIv6e6LUUe1CKRLDLsoD4NW7
	4gNta+ZVH6f5pE75yzzKZXpfBGpJyFNDb7SRgO2Ov0KbnWIHIFThW/+sAi/NWyMqKnp/ZF
	MW+nm2zm3/QXnadkPQCcBq39iP3ylpBxE35x1fnxiIhFuM2TA55adKlas8gURF11lo4h01
	cLTNPBkg1ZMNptFQOiiD1CpbTw/g/TQNe3yHetlc0VVucXZ6C4sdMVA4sfuLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1746805568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dzJoEJI7/e8x2ibK1JWACDD3ve2/JsxJ86YTI7pkVwg=;
	b=MG6wIPaSmxgDOubp5j2wmaCWzcJMh81IL79+i5Y75dKWEQW09U/jdtgGDRAJz7BKbemwCr
	PBmZXLlqcawLj/Y7hbPvxhdEYGcptEL6Iq7KJprQ9ZkPn57luvjFWXlkjaUIR6dqXhex8X
	Tcn8O2LhsR9aYiu0mPcZSiABYIOdou6y15CfeTVzyR7W0tdXFBS0ubVBnm1QxbzwOVhnqX
	YPNbhorNyGG77NENjZExRyzNHpCSC0HEVa89ROA9M497POSh5QeorvXurdt97rCbKFDEJL
	oeGXtECCgO46bB4sFuZdnW9ydmEpuJjarLllL9+XdFLAXkW/eze5++I4/hvEbQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1746805569; a=rsa-sha256;
	cv=none;
	b=XNlC79vvvB+zzccpxydSvrjKH/fFFxR4YZcEV9lARjJpQ5IvwO0G30eHqo4Rr6o/+uLsDZ
	Ci244hIaYAUCXw0/xU7EyR5VH7rO8a2sD9GnrTbvz32kd5raP1oPHeingQP4wv8Qnki0UR
	kDi8Q/G6trBMzlkfJZ71JtyKPCKuFyaqjXf/eUSK9/X3T0EzFu/hR2YLTvDc9zx0s90Kzn
	ZM2K7aDr1m3YTjCZzOXzg88EMCtBEfM6GKayIkF/N5SG3ZKol4+50hkzFnArBULB3DDrFb
	oiXkfHiJXisl/07sgq/TY6HBbMbjlLXz0PQTj6tglLpw+8KakcBoO3Y+bO5C2A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <772853441dbc7bef7dc49741d2a76aedaf92525d.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: fix socket matching ambiguity between BIS
 and CIS
From: Pauli Virtanen <pav@iki.fi>
To: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 May 2025 18:46:03 +0300
In-Reply-To: <20250509-iso-v2-1-da53bd18c193@amlogic.com>
References: <20250509-iso-v2-1-da53bd18c193@amlogic.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2025-05-09 kello 18:17 +0800, Yang Li via B4 Relay kirjoitti:
> From: Yang Li <yang.li@amlogic.com>
>=20
> When the DUT acts as a sink device, and a BIS already exists,
> creating a CIS connection can cause the kernel to incorrectly
> reference the BIS socket. This occurs because the socket
> lookup only checks for state =3D=3D BT_LISTEN, without
> distinguishing between BIS and CIS socket types.
>=20
> To fix this, match the destination address (dst addr) during
> ISO socket lookup to differentiate between BIS and CIS sockets
> properly.

Does it work if you have both CIS and BIS established between the same
two machines?

Now that CIS_LINK and BIS_LINK are separate hci_conn types, it could
make sense to introduce `__u8 hcon_type;` in iso_pinfo, maybe set in
iso_connect/listen so that also the socket types won't be confused.

>=20
> Link: https://github.com/bluez/bluez/issues/1224
>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v2:
> - Fix compilation errors
> - Improved the problem description for clarity.
> - Link to v1: https://lore.kernel.org/r/20250507-iso-v1-1-6f60d243e037@am=
logic.com
> ---
>  net/bluetooth/hci_event.c | 34 +++++++++++++++++++---------------
>  net/bluetooth/iso.c       | 12 +++++++++---
>  2 files changed, 28 insertions(+), 18 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..6b26344ad69f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6413,6 +6413,8 @@ static void hci_le_pa_sync_estabilished_evt(struct =
hci_dev *hdev, void *data,
> =20
>  	conn->sync_handle =3D le16_to_cpu(ev->handle);
>  	conn->sid =3D HCI_SID_INVALID;
> +	conn->dst =3D ev->bdaddr;
> +	conn->dst_type =3D ev->bdaddr_type;
>=20
>  	mask |=3D hci_proto_connect_ind(hdev, &ev->bdaddr, BIS_LINK,
>  				      &flags);
> @@ -6425,7 +6427,7 @@ static void hci_le_pa_sync_estabilished_evt(struct =
hci_dev *hdev, void *data,
>  		goto unlock;
> =20
>  	/* Add connection to indicate PA sync event */
> -	pa_sync =3D hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
> +	pa_sync =3D hci_conn_add_unset(hdev, BIS_LINK, &ev->bdaddr,
>  				     HCI_ROLE_SLAVE);

Do these make the update of conn->dst in iso_conn_ready() unnecessary?

It should be documented somewhere what are the different types of
BIS_LINK hci_conn that exist, and what are their invariants...

>  	if (IS_ERR(pa_sync))
> @@ -6456,13 +6458,6 @@ static void hci_le_per_adv_report_evt(struct hci_d=
ev *hdev, void *data,
> =20
>  	hci_dev_lock(hdev);
> =20
> -	mask |=3D hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
> -	if (!(mask & HCI_LM_ACCEPT))
> -		goto unlock;
> -
> -	if (!(flags & HCI_PROTO_DEFER))
> -		goto unlock;
> -
>  	pa_sync =3D hci_conn_hash_lookup_pa_sync_handle
>  			(hdev,
>  			le16_to_cpu(ev->sync_handle));
> @@ -6470,6 +6465,13 @@ static void hci_le_per_adv_report_evt(struct hci_d=
ev *hdev, void *data,
>  	if (!pa_sync)
>  		goto unlock;
> =20
> +	mask |=3D hci_proto_connect_ind(hdev, &pa_sync->dst, BIS_LINK, &flags);
> +	if (!(mask & HCI_LM_ACCEPT))
> +		goto unlock;
> +
> +	if (!(flags & HCI_PROTO_DEFER))
> +		goto unlock;
> +

Commit message should explain what this reordering of *_ind after
pa_sync lookup/update are for.

>  	if (ev->data_status =3D=3D LE_PA_DATA_COMPLETE &&
>  	    !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
>  		/* Notify iso layer */
> @@ -6993,6 +6995,8 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>  			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
> =20
>  		bis->sync_handle =3D conn->sync_handle;
> +		bis->dst =3D conn->dst;
> +		bis->dst_type =3D conn->dst_type;
>  		bis->iso_qos.bcast.big =3D ev->handle;
>  		memset(&interval, 0, sizeof(interval));
>  		memcpy(&interval, ev->latency, sizeof(ev->latency));
> @@ -7038,13 +7042,6 @@ static void hci_le_big_info_adv_report_evt(struct =
hci_dev *hdev, void *data,
> =20
>  	hci_dev_lock(hdev);
> =20
> -	mask |=3D hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
> -	if (!(mask & HCI_LM_ACCEPT))
> -		goto unlock;
> -
> -	if (!(flags & HCI_PROTO_DEFER))
> -		goto unlock;
> -
>  	pa_sync =3D hci_conn_hash_lookup_pa_sync_handle
>  			(hdev,
>  			le16_to_cpu(ev->sync_handle));
> @@ -7054,6 +7051,13 @@ static void hci_le_big_info_adv_report_evt(struct =
hci_dev *hdev, void *data,
> =20
>  	pa_sync->iso_qos.bcast.encryption =3D ev->encryption;
> =20
> +	mask |=3D hci_proto_connect_ind(hdev, &pa_sync->dst, BIS_LINK, &flags);
> +	if (!(mask & HCI_LM_ACCEPT))
> +		goto unlock;
> +
> +	if (!(flags & HCI_PROTO_DEFER))
> +		goto unlock;
> +
>
>  	/* Notify iso layer */
>  	hci_connect_cfm(pa_sync, 0);
> =20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 6e2c752aaa8f..1dc233f04dbe 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -641,11 +641,12 @@ static struct sock *iso_get_sock(bdaddr_t *src, bda=
ddr_t *dst,
>  			continue;
> =20
>  		/* Exact match. */
> -		if (!bacmp(&iso_pi(sk)->src, src)) {
> +		if (!bacmp(&iso_pi(sk)->src, src)
> +		     && !bacmp(&iso_pi(sk)->dst, dst)
> +			){

Code style issues here.

>  			sock_hold(sk);
>  			break;
>  		}
> -
>  		/* Closest match */
>  		if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY)) {
>  			if (sk1)
> @@ -1962,7 +1963,7 @@ static void iso_conn_ready(struct iso_conn *conn)
>  		}
> =20
>  		if (!parent)
> -			parent =3D iso_get_sock(&hcon->src, BDADDR_ANY,
> +			parent =3D iso_get_sock(&hcon->src, &hcon->dst,
>  					      BT_LISTEN, NULL, NULL);

I think the code here would be more clear if it's refactored to handle
hcon->type =3D=3D CIS_LINK and hcon->type =3D=3D BIS_LINK with explicitly
separate code path.

What happens here if we have a BIS listener socket for `dst`, and `dst`
initiates a CIS connection? Won't the CIS connection get resolved to
the BIS listener socket?

IIUC CIS listeners always have dst =3D=3D BDADDR_ANY. BIS listeners have
dst !=3D BDADDR_ANY.

Perhaps there could also be `__u8 hcon_type` in iso_pinfo that gets set
to CIS_LINK or BIS_LINK in iso_connect/listen.

> =20
>  		if (!parent)
> @@ -2203,6 +2204,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t=
 *bdaddr, __u8 *flags)
>  	} else {
>  		sk =3D iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
>  				  BT_LISTEN, NULL, NULL);
> +		if (!sk)
> +			sk =3D iso_get_sock(&hdev->bdaddr, bdaddr,
> +					  BT_LISTEN, NULL, NULL);
> +		else
> +			iso_pi(sk)->dst =3D *bdaddr;

This updates the listener socket dst address with that of the
connecting device? I think what is set in bind() shouldn't be modified
later on.

Isn't this wrong for CIS, won't it block connecting another device?

>  	}
> =20
>  done:
>=20
> ---
> base-commit: f3daca9b490154fbb0459848cc2ed61e8367bddc
> change-id: 20250506-iso-6515893b5bb3
>=20
> Best regards,

--=20
Pauli Virtanen
