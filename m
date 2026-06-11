Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17E34BA5A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193959; cv=pass; b=eEJDmfgpChbaCWa0MPT6cXci1ciazvpv+1kQl2FCinUQFImfrIN1K9n0OgVHz0quiQyAQUJwWjPTtVv0m6M9zVkIHwxvCEiHmt6ovQBNA/56opw+qAn5ZEqSc/4oU8OzsG4u8mdQlo+mDGLzjKfmFDyRavXJ2f29munqYpLlCJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193959; c=relaxed/simple;
	bh=HWnbH51dKbIX4eefisMlgtUUotKeGqhl5TrdpPegMFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjQtM9Hj3qqeuJncePL4LqGFVH7gPtf36C9xKcXERb5Mpn3prhiZNZQ3wd+rpLjwr7azwqsjzTXMfMvfVJNfEVw4hFTJ6AlQ/144efmXCmFraX6NHQILYcl6F+CzmCugIhzYaqng+O4HnB4M9vJD9KLwj3FrusH7F0fTH2dulOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=wH1b6m3B; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="wH1b6m3B"
Received: from [10.74.32.127] (unknown [185.65.133.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gbnYf5HGrz49PtM;
	Thu, 11 Jun 2026 19:05:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781193942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAVbF39/pJpIW6FYHAz9KmwBrZK7wzGQlybEm9L2Aw4=;
	b=wH1b6m3BhN62d2wLTc1BkzCzNNTb8BEEKtwMgeaRN3r8b1Vcbs9lW7g5foWE/C+QqtAFew
	Te7onjD7W0NykP7PbRE4zSDnknBw+GXj8qSS5ajmdwueKa8X21OmW3gDFSs61aFdbUpS39
	zKOrXA3mkiG9OhzzRvlrHP4NaDioB9V5gQ0r6/IelEXMoqQbYuE0xBETqy5PCbQzcLGuPK
	2rt0DvVKd2XbK52VmseMww2eonf5Z9CRYmjRFTegtixzepx9W6kpnWEj5fLowUTA6vYheM
	y/KJkdg2koj6fPBSPwQlnARSGP4g2zoz1qCX77SSD1TcVsLtCgQqA1d/XvWjNg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781193942;
	b=CyjS/AbVYcS11gZQBw29N0fe5J6H3FU/bV/+EmAk4FrqnHJWPEuhvd5/BgiCUCLJnSYIJf
	BSrzemBM7mgbZl02dZdVuZB1kp0sPvR1hwmTQ7nX58YEDQgoH8hEx104NMkXSzmCkbRm2R
	4ZfZaLFsnooPKycRlmKE3GAJKpASHf/78kb5Z7YS/nTAPBFyGtlCyyuiJ2VqvEhA9JLRae
	EKWjI9vh6BCb8NiMPht92xkj25zlpPMIHBUkFCzJLNlMbutge042+kDNzC/luMhxiurb/6
	fhN2VLZCPIcIP9Ib9ygV8u/eoAg73juYdARm5fgyXdJ8obiF8OB07mP6pYQjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781193942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAVbF39/pJpIW6FYHAz9KmwBrZK7wzGQlybEm9L2Aw4=;
	b=UkuBUzVXs7r+8iVBxim47l4sA49/RYdsKQyungQXDq7A/OUC4h1qos73D/ZpGi8ss7nNIk
	UJu1eQfZuYpa6AV0vT3H1MfDTwF5dO2F0AExbVVXysQXTxAPqB/HQ/iMiPBvft7XTuMWMH
	4Nlss5WY+IRNHcISetwaz1WgGvMOQa8jkyL/p1t0FiHv1C/i5M9bkM1rQQvHbfBGoeB1lf
	yhbSGkWVO/MHXhPq0+V5TkXeDWiNqK/DtgWiPdDBAP0XuyX/m0ZoA4mS85Ic5C2WSL/edU
	tC+Vr8knDdc4ihbascMNLCVlQamXs8kuNpSM6PBr1P351S8Frnhke2pjBTpj0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <98da64161113e83dd3c554528b90f1abc4da2c91.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: hci_conn: Fix null ptr deref in
 hci_abort_conn()
From: Pauli Virtanen <pav@iki.fi>
To: Siwei Zhang <oss@fourdim.xyz>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 11 Jun 2026 19:05:42 +0300
In-Reply-To: <20260611152039.2176565-1-oss@fourdim.xyz>
References: <20260611152039.2176565-1-oss@fourdim.xyz>
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

to, 2026-06-11 kello 11:19 -0400, Siwei Zhang kirjoitti:
> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
> was pending, but hdev->sent_cmd can be NULL while req_status is still
> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
> protection fault from the hci_rx_work() receive path.
>=20
> Instead of inspecting hdev->sent_cmd, track the in-flight create
> connection command with a new per-connection HCI_CONN_CREATE flag and
> route all cancellation through hci_cancel_connect_sync(), which
> dequeues
> the command if still queued, or cancels the pending request if this
> connection owns the in-flight create command. CIS uses the same path
> via the existing HCI_CONN_CREATE_CIS flag.
>=20
> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
> aborting connections")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
> =C2=A0include/net/bluetooth/hci_core.h |=C2=A0 1 +
> =C2=A0net/bluetooth/hci_conn.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 21 ++--------
> =C2=A0net/bluetooth/hci_sync.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 66 ++++++++++++++++++++++++++----
> --
> =C2=A03 files changed, 58 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h
> b/include/net/bluetooth/hci_core.h
> index aa600fbf9a53..aa554c34f9ec 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -988,6 +988,7 @@ enum {
> =C2=A0	HCI_CONN_AUTH_FAILURE,
> =C2=A0	HCI_CONN_PER_ADV,
> =C2=A0	HCI_CONN_BIG_CREATED,
> +	HCI_CONN_CREATE,
> =C2=A0	HCI_CONN_CREATE_CIS,
> =C2=A0	HCI_CONN_CREATE_BIG_SYNC,
> =C2=A0	HCI_CONN_BIG_SYNC,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 54eabaa46960..eba4a548bef5 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, u8
> reason)
> =C2=A0
> =C2=A0	conn->abort_reason =3D reason;
> =C2=A0
> -	/* If the connection is pending check the command opcode
> since that
> -	 * might be blocking on hci_cmd_sync_work while waiting its
> respective
> -	 * event so we need to hci_cmd_sync_cancel to cancel it.
> -	 *
> -	 * hci_connect_le serializes the connection attempts so only
> one
> -	 * connection can be in BT_CONNECT at time.
> +	/* Cancel the connect attempt. A return of 0 means the
> create command
> +	 * was still queued and got dequeued, so there is nothing to
> disconnect.
> =C2=A0	 */
> -	if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_status)
> =3D=3D HCI_REQ_PEND) {
> -		switch (hci_skb_event(hdev->sent_cmd)) {
> -		case HCI_EV_CONN_COMPLETE:
> -		case HCI_EV_LE_CONN_COMPLETE:
> -		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
> -		case HCI_EVT_LE_CIS_ESTABLISHED:
> -			hci_cmd_sync_cancel(hdev, ECANCELED);
> -			break;
> -		}
> -	/* Cancel connect attempt if still queued/pending */
> -	} else if (!hci_cancel_connect_sync(hdev, conn)) {
> +	if (!hci_cancel_connect_sync(hdev, conn))
> =C2=A0		return 0;
> -	}
> =C2=A0
> =C2=A0	/* Run immediately if on cmd_sync_work since this may be
> called
> =C2=A0	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which
> does
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index df23245d6ccd..1fe19ddbbc2c 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6668,6 +6668,12 @@ static int hci_le_create_conn_sync(struct
> hci_dev *hdev, void *data)
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 &own_addr_type);
> =C2=A0	if (err)
> =C2=A0		goto done;
> +
> +	/* Mark create connection in flight so
> hci_cancel_connect_sync() can
> +	 * cancel it while blocking on the connection complete
> event.
> +	 */
> +	set_bit(HCI_CONN_CREATE, &conn->flags);
> +
> =C2=A0	/* Send command LE Extended Create Connection if supported
> */
> =C2=A0	if (use_ext_conn(hdev)) {
> =C2=A0		err =3D hci_le_ext_create_conn_sync(hdev, conn,
> own_addr_type);
> @@ -6703,6 +6709,8 @@ static int hci_le_create_conn_sync(struct
> hci_dev *hdev, void *data)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conn->conn_timeout, NULL);
> =C2=A0
> =C2=A0done:
> +	clear_bit(HCI_CONN_CREATE, &conn->flags);
> +
> =C2=A0	if (err =3D=3D -ETIMEDOUT)
> =C2=A0		hci_le_connect_cancel_sync(hdev, conn, 0x00);
> =C2=A0
> @@ -6982,10 +6990,19 @@ static int hci_acl_create_conn_sync(struct
> hci_dev *hdev, void *data)
> =C2=A0	else
> =C2=A0		cp.role_switch =3D 0x00;
> =C2=A0
> -	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> -					sizeof(cp), &cp,
> -					HCI_EV_CONN_COMPLETE,
> -					conn->conn_timeout, NULL);
> +	/* Mark create connection in flight so
> hci_cancel_connect_sync() can
> +	 * cancel it while blocking on the connection complete
> event.
> +	 */
> +	set_bit(HCI_CONN_CREATE, &conn->flags);
> +
> +	err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(cp), &cp,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HCI_EV_CONN_COMPLETE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conn->conn_timeout, NULL);
> +
> +	clear_bit(HCI_CONN_CREATE, &conn->flags);
> +
> +	return err;
> =C2=A0}
> =C2=A0
> =C2=A0int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn
> *conn)
> @@ -7039,20 +7056,45 @@ int hci_connect_le_sync(struct hci_dev *hdev,
> struct hci_conn *conn)
> =C2=A0
> =C2=A0int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn
> *conn)
> =C2=A0{
> -	if (conn->state !=3D BT_OPEN)
> -		return -EINVAL;
> +	hci_cmd_sync_work_func_t func =3D NULL;
> +	hci_cmd_sync_work_destroy_t destroy =3D NULL;
> +	int create_flag =3D -1;
> =C2=A0
> =C2=A0	switch (conn->type) {
> =C2=A0	case ACL_LINK:
> -		return !hci_cmd_sync_dequeue_once(hdev,
> -						=C2=A0
> hci_acl_create_conn_sync,
> -						=C2=A0 conn, NULL);
> +		func =3D hci_acl_create_conn_sync;
> +		create_flag =3D HCI_CONN_CREATE;
> +		break;
> =C2=A0	case LE_LINK:
> -		return !hci_cmd_sync_dequeue_once(hdev,
> hci_le_create_conn_sync,
> -						=C2=A0 conn,
> create_le_conn_complete);
> +		func =3D hci_le_create_conn_sync;
> +		destroy =3D create_le_conn_complete;
> +		create_flag =3D HCI_CONN_CREATE;
> +		break;
> +	case CIS_LINK:
> +		/* LE Create CIS is shared by the whole CIG and
> cannot be
> +		 * dequeued per-connection; only cancel it in-flight
> below.
> +		 */
> +		create_flag =3D HCI_CONN_CREATE_CIS;
> +		break;
> +	default:
> +		return -ENOENT;
> =C2=A0	}
> =C2=A0
> -	return -ENOENT;
> +	/* The create command is in exactly one of two states: still
> queued, or
> +	 * in flight. The create flag is only set once the worker
> has dequeued
> +	 * the entry and started running it, so the two states are
> mutually
> +	 * exclusive. Try to dequeue first: if it succeeds the
> command had not
> +	 * started yet and we are done. Otherwise the worker already
> pulled it
> +	 * off the queue (the dequeue is a no-op here), so if this
> connection
> +	 * owns the in-flight create command, cancel the pending
> request.

This may run from context with no synchronization (kernel default event
workqueue), the tests below don't run in a critical section, so not
clear the reasoning is strictly valid.

Eg. hci_cmd_sync_cancel() could cancel unintended command if hci_sync
finished just after we test_bit here.

> +	 */
> +	if (func && hci_cmd_sync_dequeue_once(hdev, func, conn,
> destroy))
> +		return 0;
> +
> +	if (create_flag >=3D 0 && test_bit(create_flag, &conn->flags))
> +		hci_cmd_sync_cancel(hdev, ECANCELED);
> +
> +	return -EBUSY;
> =C2=A0}
> =C2=A0
> =C2=A0int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn
> *conn,

--=20
Pauli Virtanen

