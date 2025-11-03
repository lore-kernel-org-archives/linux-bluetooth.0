Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C95661;
	Mon,  3 Nov 2025 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762128265; cv=pass; b=qYizB5zhJ2zpQv30T5C8XKYFzwlCbM7Qu7AvCONybGO8jhAhv3HNQTbdLOxuZbpbohHw5bt6blRmOIcYjgJJVqbnJLUMvAnhBlvnh0frWuTTGmp+AHsxJcgqdTRPSfDuaZp4Iz+QGYAaIvkTLZhCTrINFuGYCU/ygKfDqi4SLQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762128265; c=relaxed/simple;
	bh=P2L8lcgLo5CCSrq3qjQpPmMz4eLLMHYDyhkl7FnWY2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=toiv9eJPPZnodr9V8JoI9JobzM8a6T9ljz4X8wonq6wxwGI/10WBovpYry5nhU80jLqPGyOl2eq9PORIoALxYxE4/TA96CEnDu18O8P7dYDH9OyRnaG8ugd3CMafoRLk8dZL+oZADL5FnlBwcJqJ24T2gU0rZsPnupWP1C7wyMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=akamoLJh; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="akamoLJh"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d0Bds0r7Vz49Pxn;
	Mon,  3 Nov 2025 02:04:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1762128258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Qp8JM2z7f2ib5lLGR/Z98ydf+YbITesFUp+M3Musb4=;
	b=akamoLJhQ1J0vv67Chp2pOd3+ve1xKbOuSIyTGTDr72Fvk2Gq1gB9mH2f6WamXqNkoFUVj
	QOOUPOR1ZEiOUTGbT77Q9vFGClOjqVP3OXNupYB3Dwi2U4czfu6+OlGxsS3PxLYkhTEqFi
	6uv7GdCpBt2n/cFN10Y/M4oiOZNI4k5gr037uO7rwRcbpiHxJj8SRvrQwEAad547IYOKns
	fEo4xX34cyWu2fltlSXaBmRGLrNAhO82UbWy1SLyHluBDVxw1EwlUaZ2fz5hy9hEObJNCZ
	hj4kcnQBUu1cQUL+w0SdNqdNZtyOEUhXCwThEcIvqSucxxeDQpNu35vEup6DmQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1762128258; a=rsa-sha256;
	cv=none;
	b=W1qVgIlG4Cl2+ZdfZiP9iXruCn0xmdqXCh/5X36rpvvqJ1bt+QWOX2VIpHCm/FYlCrkD4W
	W94/COWORjsQydDevi+RraK4rwE86eUqoWJqYWSwEc+vnZ5ftEJK09B8+VnTYhVCwvBo90
	APwKb8jnwtt+sjQiXqdrKcNKHabWOls1wBSGNbC0Vy2suIiJ+3FEO6gl7qkns57dCM/MI0
	CFnim6MTrwdcnX0f53xFlneYJMBRbWWuFLasve9Whmm6Y+z1Thg7o/6WL//pZpnX/FU7NS
	/Qu3rUSxdy8Wa3HDuWmbre425IFBx8boxHW7ls8Ae7qZKggOb8uXESnaCYApzA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1762128258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Qp8JM2z7f2ib5lLGR/Z98ydf+YbITesFUp+M3Musb4=;
	b=BlRy4ZVuYywrUcl/s+qBZavJiL++WknUeSl+lBL4isOEaRvKepFlneJZVVwN9RyC9i0v2o
	KnC0np1iY5roM+HMvZL7BwDkKCeStpHrxvA/wz7L/jj4pw7wKdzHi5zMBnRqmbJSMydB3y
	2GjDAaJW+RbSwAVF60W3yLnmHynObAQwncv9G29OJY1/TcmOHNPp4JM72FZcEC+fXx5V8f
	dFIUZsclbF9jpVsxYAG6IQeITrRqfvfu4dO4oroWHKEikzAeGuE/i6J56MuQnr1kRd0Btg
	cyOIJH6ygJJMeTKo5SP6b+Bn8wC1hAxUvpTg0/WZz4/rj7lHJAl0IoKNDDwKow==
Message-ID: <76e031118390810ddd1d33b92d8a30c5d49d0425.camel@iki.fi>
Subject: Re: [PATCH v2 3/8] Bluetooth: mgmt: take lock and hold reference
 when handling hci_conn
From: Pauli Virtanen <pav@iki.fi>
To: Hillf Danton <hdanton@sina.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 03 Nov 2025 02:04:15 +0200
In-Reply-To: <20251102232137.8830-1-hdanton@sina.com>
References: <cover.1762100290.git.pav@iki.fi>
	 <20251102232137.8830-1-hdanton@sina.com>
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

ma, 2025-11-03 kello 07:21 +0800, Hillf Danton kirjoitti:
> On Sun,  2 Nov 2025 18:19:35 +0200 Pauli Virtanen wrote:
> > Take hdev/rcu lock to prevent concurrent deletion of the hci_conn we ar=
e
> > handling.
> >=20
> > When using hci_conn* pointers across critical sections, always take
> > refcount to keep the pointer valid.
> >=20
> > For hci_abort_conn() only hold refcount, as the function takes
> > hdev->lock itself.
> >=20
> > Fixes: 227a0cdf4a028 ("Bluetooth: MGMT: Fix not generating command comp=
lete for MGMT_OP_DISCONNECT")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >     v2:
> >     - no change
> >=20
> >  net/bluetooth/mgmt.c | 42 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 38 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 78b7af8bf45f..535c475c2d25 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -3081,6 +3081,8 @@ static int unpair_device_sync(struct hci_dev *hde=
v, void *data)
> >  	struct mgmt_cp_unpair_device *cp =3D cmd->param;
> >  	struct hci_conn *conn;
> > =20
> > +	rcu_read_lock();
> > +
> >  	if (cp->addr.type =3D=3D BDADDR_BREDR)
> >  		conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> >  					       &cp->addr.bdaddr);
> > @@ -3088,6 +3090,11 @@ static int unpair_device_sync(struct hci_dev *hd=
ev, void *data)
> >  		conn =3D hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
> >  					       le_addr_type(cp->addr.type));
> > =20
> > +	if (conn)
> > +		hci_conn_get(conn);
> > +
> > +	rcu_read_unlock();
> > +
> Given RCU in the lookup helpers, nested RCU makes no sense.
> Feel free to add the lookup_and_get helper instead to bump the refcnt up
> for the conn found.

RCU must be held until the refcount is increased. I don't think there
is difference in whether it's done by nesting or by duplicating all the
helpers without the rcu_read_lock().

The rcu_read_lock() in the helpers is probaly something that should be
done away with --- the caller needs to hold RCU or suitable other lock
if it wants to use the returned value safely.

> Another simpler option is -- add conn to hash with refcnt increased and
> correspondingly put conn after deleting it from hash.
>=20
> >  	if (!conn)
> >  		return 0;
> > =20
> > @@ -3095,6 +3102,7 @@ static int unpair_device_sync(struct hci_dev *hde=
v, void *data)
> >  	 * will clean up the connection no matter the error.
> >  	 */
> >  	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> > +	hci_conn_put(conn);
> > =20
> >  	return 0;
> >  }
> > @@ -3242,6 +3250,8 @@ static int disconnect_sync(struct hci_dev *hdev, =
void *data)
> >  	struct mgmt_cp_disconnect *cp =3D cmd->param;
> >  	struct hci_conn *conn;
> > =20
> > +	rcu_read_lock();
> > +
> >  	if (cp->addr.type =3D=3D BDADDR_BREDR)
> >  		conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> >  					       &cp->addr.bdaddr);
> > @@ -3249,6 +3259,11 @@ static int disconnect_sync(struct hci_dev *hdev,=
 void *data)
> >  		conn =3D hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
> >  					       le_addr_type(cp->addr.type));
> > =20
> > +	if (conn)
> > +		hci_conn_get(conn);
> > +
> > +	rcu_read_unlock();
> > +
> >  	if (!conn)
> >  		return -ENOTCONN;
> > =20
> > @@ -3256,6 +3271,7 @@ static int disconnect_sync(struct hci_dev *hdev, =
void *data)
> >  	 * will clean up the connection no matter the error.
> >  	 */
> >  	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> > +	hci_conn_put(conn);
> > =20
> >  	return 0;
> >  }
> > @@ -7372,6 +7388,9 @@ static void get_conn_info_complete(struct hci_dev=
 *hdev, void *data, int err)
> >  		rp.max_tx_power =3D HCI_TX_POWER_INVALID;
> >  	}
> > =20
> > +	if (conn)
> > +		hci_conn_put(conn);
> > +
> >  	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_GET_CONN_INFO, stat=
us,
> >  			  &rp, sizeof(rp));
> > =20
> > @@ -7386,6 +7405,8 @@ static int get_conn_info_sync(struct hci_dev *hde=
v, void *data)
> >  	int err;
> >  	__le16   handle;
> > =20
> > +	hci_dev_lock(hdev);
> > +
> >  	/* Make sure we are still connected */
> >  	if (cp->addr.type =3D=3D BDADDR_BREDR)
> >  		conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> > @@ -7393,12 +7414,16 @@ static int get_conn_info_sync(struct hci_dev *h=
dev, void *data)
> >  	else
> >  		conn =3D hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
> > =20
> > -	if (!conn || conn->state !=3D BT_CONNECTED)
> > +	if (!conn || conn->state !=3D BT_CONNECTED) {
> > +		hci_dev_unlock(hdev);
> >  		return MGMT_STATUS_NOT_CONNECTED;
> > +	}
> > =20
> > -	cmd->user_data =3D conn;
> > +	cmd->user_data =3D hci_conn_get(conn);
> >  	handle =3D cpu_to_le16(conn->handle);
> > =20
> > +	hci_dev_unlock(hdev);
> > +
> >  	/* Refresh RSSI each time */
> >  	err =3D hci_read_rssi_sync(hdev, handle);
> > =20
> > @@ -7532,6 +7557,9 @@ static void get_clock_info_complete(struct hci_de=
v *hdev, void *data, int err)
> >  	}
> > =20
> >  complete:
> > +	if (conn)
> > +		hci_conn_put(conn);
> > +
> >  	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status, &rp,
> >  			  sizeof(rp));
> > =20
> > @@ -7548,15 +7576,21 @@ static int get_clock_info_sync(struct hci_dev *=
hdev, void *data)
> >  	memset(&hci_cp, 0, sizeof(hci_cp));
> >  	hci_read_clock_sync(hdev, &hci_cp);
> > =20
> > +	hci_dev_lock(hdev);
> > +
> >  	/* Make sure connection still exists */
> >  	conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
> > -	if (!conn || conn->state !=3D BT_CONNECTED)
> > +	if (!conn || conn->state !=3D BT_CONNECTED) {
> > +		hci_dev_unlock(hdev);
> >  		return MGMT_STATUS_NOT_CONNECTED;
> > +	}
> > =20
> > -	cmd->user_data =3D conn;
> > +	cmd->user_data =3D hci_conn_get(conn);
> >  	hci_cp.handle =3D cpu_to_le16(conn->handle);
> >  	hci_cp.which =3D 0x01; /* Piconet clock */
> > =20
> > +	hci_dev_unlock(hdev);
> > +
> >  	return hci_read_clock_sync(hdev, &hci_cp);
> >  }
> > =20
> > --=20
> > 2.51.1

--=20
Pauli Virtanen
