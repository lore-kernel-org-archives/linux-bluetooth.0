Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091A31F980;
	Tue, 14 Apr 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198406; cv=pass; b=HBts8SJokVbiNy9LN0+DytpPAKl8RnOEJNrCNoNHh0QauUlgFplIWgs5dwee3GAf7KmsJZJ5fPcI0DP6U5PUn8bNPTW46+mlQitKR+0opO5YGiYOFNGld/pv8wQdhFRLJ3vWi/tICoZT3SprLjMy5Bix+oXtnT76UQkRKSs2WK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198406; c=relaxed/simple;
	bh=aPDQIthwUdQtrFXCpIzvLSpfpmEtwA/DNzNaRBvGy8s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihSYaBkCEJl1Be7c/dM4XDeOGmOaJVSnNvceuxK5YOftyfGXFKguum958Nj1CnCcwxqKtqxat9jm2W9BqoRwLud2qF22syxT/CMyhHbkGW9cSfGpn0dV0+hXKd2LgTW5lZ/kbQhDjTR+34qRu6DZ3get97XGum/SiGPQm2ESFro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=LVhaRYVV; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="LVhaRYVV"
Received: from [10.156.141.210] (mobile-access-2e844b-114.dhcp.inet.fi [46.132.75.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fwG5L038Kz49Q3p;
	Tue, 14 Apr 2026 23:26:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776198390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=28Ho1vZ7pHeTed+DDe3M3jsFAxXEmlGLqCRh2NfOgYM=;
	b=LVhaRYVVLn4rIeK2QUqvjYHQgr5l6ORGu+O9RP+LeTnnrCVsD3iqs8PM9mEcPewNNdzLJK
	uQYPhKwi3uyW/3/MvT3f8iVofPOs4HZ/gVIcxlY0V1rDWcS+3GoGjaQ2ZDCMehOEZ9PueM
	NQ8vsUL8aFyX/HNVP5wIbctJ3y5IVOdeu20LR++plvui4i8Mqm3b8aPFQ64HI+HK2z55qZ
	PPMBgerGa3WvMJMnJ+FGHnJagwyJyfIYNjkUo7VL0Jrrk7cK1XuQcBq6tS6ak0WqhgS95K
	1VM9a+9OIGgBS6ca0sHs6KypmC5F+ytHYR/C4rAWaLqkb1Py4Me9qc4rACyDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776198390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=28Ho1vZ7pHeTed+DDe3M3jsFAxXEmlGLqCRh2NfOgYM=;
	b=ng044318RBIIA1qbIY1bXz/8lScCzFClKiXsyGI6iaQ5hkboKtuAJyG6K5LwqjxYg/qIYA
	r7MztQvC5sDCxIMVglHnCmDuLKoKGV76pCxZ6yVHN4IqQzzRnaMHiEFTaHVkAvoo6KBCGn
	4kvqW9BV9ANo97IPlV9DiIQ80A0yVccvdBB+XVMhui3Oj7F8/ESlFMJl8LUxDaD57Uxe+h
	US0ukaPUviF7T1vtuwiUc02kM4Tn3UBQ6WqNe//Eu+Z+Z24p3gREMEBo+SdRrxblCsjgrs
	oNxLYYH1UoRQXDWqVI6UFDG5J2kcqYfyKARqMRrCag2TmQjNJQAoXBFqclR2lw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776198390;
	b=VBbxF3RTN8iHdfFCyBlkJLoTEuItLEwJswfKOy1Gt4NYc43Y0fuRMDjw6RUsJdL65J8zEY
	7b2RR7rqcOFWMXKDephwoGy2EKispj2vDBrV8B6bR3aCw4HLwtwwmvQe3GSlU/GcZY/lHH
	T5+N++ykiBWtfjKw41Kg8sTtkBt3bYFbiAHsyHlSvu3kSJ/y+xOVt/KUIvK+/C3EVQKG5q
	o8P57GxLzRcRyssCXV6qfIfYahjxIsJ9EuR9vWhkTNT0xeHgPJdPIVbCCvGClmY1sZRnVs
	d3lajI14iWjJso+tVqOtqGk7ogt29dBeGOTFe3iBAhL/9sPKH1bIRYBU8T6djQ==
Message-ID: <4ab9bc90237c575f5d508b1dd93d4ab71fb6f961.camel@iki.fi>
Subject: Re: [PATCH v4] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
From: Pauli Virtanen <pav@iki.fi>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, luiz.dentz@gmail.com, 
	marcel@holtmann.org
Cc: pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 14 Apr 2026 23:26:22 +0300
In-Reply-To: <20260414184415.17114-1-mikhail.v.gavrilov@gmail.com>
References: <20260414184415.17114-1-mikhail.v.gavrilov@gmail.com>
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

ti, 2026-04-14 kello 23:43 +0500, Mikhail Gavrilov kirjoitti:
> When a BLE peripheral sends an L2CAP Connection Parameter Update Request
> the processing path is:
>=20
>   process_pending_rx()          [takes conn->lock]
>     l2cap_le_sig_channel()
>       l2cap_conn_param_update_req()
>         hci_le_conn_update()    [takes hdev->lock]
>=20
> Meanwhile other code paths take the locks in the opposite order:
>=20
>   l2cap_chan_connect()          [takes hdev->lock]
>     ...
>       mutex_lock(&conn->lock)
>=20
>   l2cap_conn_ready()            [hdev->lock via hci_cb_list_lock]
>     ...
>       mutex_lock(&conn->lock)
>=20
> This is a classic AB/BA deadlock which lockdep reports as a circular
> locking dependency when connecting a BLE MIDI keyboard (Carry-On FC-49).
>=20
> Fix this by making hci_le_conn_update() defer the HCI command through
> hci_cmd_sync_queue() so it no longer needs to take hdev->lock in the
> caller context.  The sync callback uses __hci_cmd_sync_status_sk() to
> wait for the HCI_EV_LE_CONN_UPDATE_COMPLETE event, then updates the
> stored connection parameters (hci_conn_params) and notifies userspace
> (mgmt_new_conn_param) only after the controller has confirmed the update.
>=20
> A reference on hci_conn is held via hci_conn_get()/hci_conn_put() for
> the lifetime of the queued work to prevent use-after-free, and
> hci_conn_valid() is checked before proceeding in case the connection was
> removed while the work was pending.
>=20
> Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in=
 connection params")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>=20
> Changes in v4 (Luiz Augusto von Dentz, Sashiko/Gemini AI review):
> - Use hci_conn_get()/hci_conn_put() to hold a reference while work is que=
ued
> - Use __hci_cmd_sync_status_sk() to wait for HCI_EV_LE_CONN_UPDATE_COMPLE=
TE,
>   then do params update + mgmt notification in the sync callback =E2=80=
=94 removes the
>   need for hci_event.c changes and hci_sent_cmd_data()
> - Use kzalloc_obj() per checkpatch recommendation
> - Fix checkpatch alignment issues
> =20
> Changes in v3 (Luiz Augusto von Dentz):
> - Move hci_cmd_sync_queue into hci_le_conn_update itself instead of open-=
coding
>   the deferral in l2cap_core.c
> - Move conn_params update and mgmt_new_conn_param into
>   hci_le_conn_update_complete_evt, using hci_sent_cmd_data to retrieve
>   the originally requested parameters
> =20
> Changes in v2 (Paul Menzel, Sashiko/Gemini AI review):
> - Allocate before sending ACCEPTED response to avoid state mismatch on OO=
M
> - Verify connection handle and address in sync callback against reuse rac=
e
> - Expand commit message with implementation details
>=20
>  include/net/bluetooth/hci_core.h |  2 +-
>  net/bluetooth/hci_conn.c         | 98 +++++++++++++++++++++++++-------
>  net/bluetooth/l2cap_core.c       | 12 +---
>  3 files changed, 82 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index a7bffb908c1e..aa600fbf9a53 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2495,7 +2495,7 @@ void mgmt_adv_monitor_device_lost(struct hci_dev *h=
dev, u16 handle,
>  				  bdaddr_t *bdaddr, u8 addr_type);
> =20
>  int hci_abort_conn(struct hci_conn *conn, u8 reason);
> -u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 laten=
cy,
> +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
>  		      u16 to_multiplier);
>  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
>  		      __u8 ltk[16], __u8 key_size);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 11d3ad8d2551..c9cc18fab1f2 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -480,40 +480,100 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 h=
andle)
>  	return hci_setup_sync_conn(conn, handle);
>  }
> =20
> -u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 laten=
cy,
> -		      u16 to_multiplier)
> +struct le_conn_update_data {
> +	struct hci_conn *conn;
> +	u16	min;
> +	u16	max;
> +	u16	latency;
> +	u16	to_multiplier;
> +};
> +
> +static int le_conn_update_sync(struct hci_dev *hdev, void *data)
>  {
> -	struct hci_dev *hdev =3D conn->hdev;
> +	struct le_conn_update_data *d =3D data;
> +	struct hci_conn *conn =3D d->conn;
>  	struct hci_conn_params *params;
>  	struct hci_cp_le_conn_update cp;
> +	u8 store_hint;
> +	int err;
> =20
> +	/* Verify connection is still alive. */
>  	hci_dev_lock(hdev);
> -
> -	params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
> -	if (params) {
> -		params->conn_min_interval =3D min;
> -		params->conn_max_interval =3D max;
> -		params->conn_latency =3D latency;
> -		params->supervision_timeout =3D to_multiplier;
> +	if (!hci_conn_valid(hdev, conn)) {
> +		hci_dev_unlock(hdev);
> +		return -ECANCELED;
>  	}
> -
>  	hci_dev_unlock(hdev);
> =20
>  	memset(&cp, 0, sizeof(cp));
>  	cp.handle		=3D cpu_to_le16(conn->handle);

hci_conn_valid() should be in the same hci_dev_lock() critical section
as where the conn is dereferenced, otherwise the lock is not doing
something useful.

> -	cp.conn_interval_min	=3D cpu_to_le16(min);
> -	cp.conn_interval_max	=3D cpu_to_le16(max);
> -	cp.conn_latency		=3D cpu_to_le16(latency);
> -	cp.supervision_timeout	=3D cpu_to_le16(to_multiplier);
> +	cp.conn_interval_min	=3D cpu_to_le16(d->min);
> +	cp.conn_interval_max	=3D cpu_to_le16(d->max);
> +	cp.conn_latency		=3D cpu_to_le16(d->latency);
> +	cp.supervision_timeout	=3D cpu_to_le16(d->to_multiplier);
>  	cp.min_ce_len		=3D cpu_to_le16(0x0000);
>  	cp.max_ce_len		=3D cpu_to_le16(0x0000);
> =20
> -	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
> +	err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CONN_UPDATE,
> +				       sizeof(cp), &cp,
> +				       HCI_EV_LE_CONN_UPDATE_COMPLETE,
> +				       HCI_CMD_TIMEOUT, NULL);
> +	if (err)
> +		return err;
> +
> +	/* Update stored connection parameters after the controller has
> +	 * confirmed the update via the LE Connection Update Complete event.
> +	 */
> +	hci_dev_lock(hdev);
> =20
> -	if (params)
> -		return 0x01;
> +	params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
> +	if (params) {
> +		params->conn_min_interval =3D d->min;
> +		params->conn_max_interval =3D d->max;
> +		params->conn_latency =3D d->latency;
> +		params->supervision_timeout =3D d->to_multiplier;
> +		store_hint =3D 0x01;
> +	} else {
> +		store_hint =3D 0x00;
> +	}
> =20
> -	return 0x00;
> +	hci_dev_unlock(hdev);
> +
> +	mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type, store_hint,
> +			    d->min, d->max, d->latency, d->to_multiplier);
> +
> +	return 0;
> +}
> +
> +static void le_conn_update_complete(struct hci_dev *hdev, void *data, in=
t err)
> +{
> +	struct le_conn_update_data *d =3D data;
> +
> +	hci_conn_put(d->conn);
> +	kfree(d);
> +}
> +
> +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
> +			u16 to_multiplier)
> +{
> +	struct le_conn_update_data *d;
> +
> +	d =3D kzalloc_obj(*d);
> +	if (!d)
> +		return;
> +
> +	hci_conn_get(conn);
> +	d->conn =3D conn;
> +	d->min =3D min;
> +	d->max =3D max;
> +	d->latency =3D latency;
> +	d->to_multiplier =3D to_multiplier;
> +
> +	if (hci_cmd_sync_queue(conn->hdev, le_conn_update_sync, d,
> +			       le_conn_update_complete) < 0) {
> +		hci_conn_put(conn);
> +		kfree(d);
> +	}
>  }
> =20
>  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..aac2db1d6fbb 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4706,16 +4706,8 @@ static inline int l2cap_conn_param_update_req(stru=
ct l2cap_conn *conn,
>  	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
>  		       sizeof(rsp), &rsp);
> =20
> -	if (!err) {
> -		u8 store_hint;
> -
> -		store_hint =3D hci_le_conn_update(hcon, min, max, latency,
> -						to_multiplier);
> -		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
> -				    store_hint, min, max, latency,
> -				    to_multiplier);
> -
> -	}
> +	if (!err)
> +		hci_le_conn_update(hcon, min, max, latency, to_multiplier);
> =20
>  	return 0;
>  }
