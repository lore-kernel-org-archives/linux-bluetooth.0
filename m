Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A22F84F;
	Sun, 30 Aug 2026 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121011; cv=pass; b=lo64LUnHPc42P/rjmlb37GlcV7dto9ClIrwOsm3xUVnZV+Pa9UZI2yzZ1xTAvvm2Nv9LgN2JC28X2mWdVqmQmBkSNQLF4cFYgnwveAJqTjgv6GwWqRd/OHKhB8dBmy5Rz21M4ttMJztGJ9JuTLL4oB39vM8U3TWyEbi1WWfuF0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121011; c=relaxed/simple;
	bh=q5HS9wZYiMzB4FfzI3jJFk9Ghr531l64AIY2O/u7HIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mn+t9Gu+YOXTz0mo0chhVtX/W33qa8mXKApVRneh00fmmP5Qjwb6CGovqNJZcVZ9BUbBScq48wD8hHdczbShFa6Wi0w8gBVV+L6I/nqzkeLF1s7Phn5dw9FS2vMbyFXYynoHbxt9IPfbnPjwM2JhzN/MwBtuoVxS4ifREsklgRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ltRNXGdO; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ltRNXGdO"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hY3LC58RVz49PwP;
	Sun, 30 Aug 2026 23:16:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788120996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiCJyOkOHEeqBfbW3UlbnVrxtTzZnyHMaai1tg83Gmw=;
	b=ltRNXGdOnYymxZG8HKd0ohJ4VI7x2UXam8VaTOlvnuboOuxrJyZg2a13or2Hocc6SwVmqP
	xwoYVgTTPKZCVbIwW8Vc/B1dHoB8n96Ri9YM8TJupicrdA8b4WbXavitfOgpbNWZg0hsEq
	BVNNyyL/VPMFKJ1MTPa5ApTVeEPuk3T20GD8R/bqz1P6uBpHuRMgha5DHgKDoCWPXcPERW
	WiphusuSdy9yTeNKUj9DDT3gTdaQVlJ1KrPy1jSSOzvyrrkqmltmtKhB6BdGk80bnu0Ara
	HRb8wUnY4OhJFgyBTegw/WUzp6ikSGyEJcX6BwFRuyn06KF89DJ6heCsiFlevg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788120996;
	b=lbXBQEzJTNyHP2AYECnV4i2qXtBdwy1IL9D37WA6QyhcGV+Ea1Dz78OCqH9iqubKwwAnZn
	am5Y/KVcQjEVG41jTmgqU8EabVDAGoHsDwHvqaFbVW+dVu0XO+Qfi1+vrh0sVNnHj/sUIj
	6VXwEeigHTjlXbQWDeWe4nNM6hm38TiCbnr0iYMIw0HIMEJdNc4Tu7FtdnPtJWNa1CoHG4
	oF7OFcQQLEfvNwt94V6xSVm1klmSSEj91Ljwgu1kJpmhEj4mE9uCX6tsQc9Yp6mFGnxToW
	glLrhZrv+nufQ7tkNGilT+rvtlpw13GvkJLWrB311PiZuqYO8GeTtjadKL3CBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788120996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiCJyOkOHEeqBfbW3UlbnVrxtTzZnyHMaai1tg83Gmw=;
	b=v5NjcQm4Lpo+b+vZsSQfKvkeUKmRyFTYFKZnjIUuM0gWmCOAEJF35bnE1Zve2zz+KTYFsu
	DFM3Te1jiicI3T8O1mj49pRkNI0r7lyoYqCKgKMljwzBaPn49QqeI3zUTmpO7wEIKQf8SA
	Pht6W1mrXDa4GG4I/d1c4SYp9/p9UG1UljAIqgfViF09N1N6d1/ZTu/9ojsQNUoQorbYRa
	RW7li5VgmHzL3YZmy2N+ELBT1RhqFbQyRNw3P33rOliKNOtRYgKthzXx48SHHQ0jsoJzEW
	WRhPJ3acrLBrDymCDQpmLu5ZA1XlC3ndORlwJCMzZJ3r0q6DWkY8smPidiL0Kg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <5eecb554a888f1d7bb09bca47e8a901d0af4713b.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ +
 EXT_FLOWCTL pchan
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
Date: Sun, 30 Aug 2026 23:16:33 +0300
In-Reply-To: <b30626af1ee0165d56dbfc15e5d16ae6efbd726b.1788109840.git.pav@iki.fi>
References: 
	<b30626af1ee0165d56dbfc15e5d16ae6efbd726b.1788109840.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

su, 2026-08-30 kello 20:11 +0300, Pauli Virtanen kirjoitti:
> l2cap_new_connection() sets default value of channel mode to match the
> parent channel.  l2cap_le_connect_req() left this at the default, and
> created L2CAP_MODE_EXT_FLOWCTL channels if listening pchan has that
> mode.  This causes FLAG_DEFER_SETUP channels to reply to
> L2CAP_LE_CONN_REQ with L2CAP_ECRED_CONN_RSP, which is incorrect.
>=20
> It can also result to stack OOB write (of l2cap_alloc_cid determined
> values) in l2cap_ecred_rsp_defer(), as l2cap_le_connect_req() does not
> limit maximum number of deferred channels or check for duplicate ident.
>=20
> Fix by setting chan->mode correctly in l2cap_le_connect_req().
>=20
> Also check channel mode in l2cap_ecred_rsp_defer(), and do WARN_ON_ONCE
> instead of OOB write to make it less brittle.

On Sashiko review comments:

> > +	/* Unreachable, check in l2cap_ecred_conn_req. If reached, drop rest =
*/
> > +	if (WARN_ON_ONCE(rsp->count >=3D ARRAY_SIZE(rsp->pdu.scid)))
> > +		rsp->pdu.rsp.result =3D cpu_to_le16(L2CAP_CR_LE_NO_MEM);
> > +
> >  	/* Include all channels pending with the same ident */
> >  	if (!rsp->pdu.rsp.result)
> >  		rsp_flex->dcid[rsp->count++] =3D cpu_to_le16(chan->scid);
> >  	else
> >  		l2cap_chan_del(chan, ECONNRESET);
>=20
> Can this lead to a self-deadlock and list corruption?
> If the WARN_ON_ONCE condition is met, the result is set to L2CAP_CR_LE_NO=
_MEM,
> causing the code to fall through to the else branch and call l2cap_chan_d=
el().
> When an L2CAP LE socket is created with BT_SK_DEFER_SETUP, the deferred
> setup path calls l2cap_sock_recvmsg() which acquires the socket lock, and
> then it calls __l2cap_ecred_conn_rsp_defer() without acquiring conn->lock=
.
> Calling l2cap_chan_del() here unconditionally calls list_del() on the
> unprotected channel list, which corrupts the list. Furthermore, it invoke=
s
> the teardown callback, which attempts to acquire the socket lock again,
> resulting in a self-deadlock since l2cap_sock_recvmsg() already holds it.

This is about the l2cap_chan_del() call there which=C2=A0indeed can
deadlock, but it is pre-existing issue. The WARN_ON should also be
unreachable.

The pre-existing deadlock is reachable on bluetooth-next/master, as in
this test:

https://lore.kernel.org/linux-bluetooth/3d6b440c7c3a077daf91a47bbc578a2cd40=
f2a01.1788119838.git.pav@iki.fi/

The locking is fixed in

https://lore.kernel.org/linux-bluetooth/3213ea451b4db947b3333c002ab19678431=
781eb.1788013041.git.pav@iki.fi/

> >  	chan->ident =3D cmd->ident;
> > +	chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> > =20
> >  	if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
> >  		l2cap_state_change(chan, BT_CONNECT2);
>=20
> This isn't a bug introduced by this patch, but does locklessly assigning
> fields like chan->mode here create a data race?
> In l2cap_le_connect_req(), l2cap_new_connection() is called earlier, whic=
h
> invokes l2cap_sock_new_connection_cb() and immediately enqueues the socke=
t
> into the parent's accept queue. This exposes the socket to userspace befo=
re
> initialization is complete.
> If userspace accepts the socket and calls setsockopt(), could it race wit=
h
> these lockless initializations, allowing userspace to observe or corrupt
> the uninitialized socket state? This patch exacerbates the issue by addin=
g
> another unprotected assignment.

These data races should be cleaned up later, probably adding
__guarded_by() annotations at the same time.

> Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Cre=
dit Based Mode")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>=20
> Notes:
>     This is another pre-existing issue from sashiko.dev reviews
>=20
>  net/bluetooth/l2cap_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 358b11eabd4f..fa7dbf5f448e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3886,6 +3886,9 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan=
 *chan, void *data)
>  	struct l2cap_ecred_conn_rsp *rsp_flex =3D
>  		container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
> =20
> +	if (chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL)
> +		return;
> +
>  	/* Check if channel for outgoing connection or if it wasn't deferred
>  	 * since in those cases it must be skipped.
>  	 */
> @@ -3896,6 +3899,10 @@ static void l2cap_ecred_rsp_defer(struct l2cap_cha=
n *chan, void *data)
>  	/* Reset ident so only one response is sent */
>  	chan->ident =3D 0;
> =20
> +	/* Unreachable, check in l2cap_ecred_conn_req. If reached, drop rest */
> +	if (WARN_ON_ONCE(rsp->count >=3D ARRAY_SIZE(rsp->pdu.scid)))
> +		rsp->pdu.rsp.result =3D cpu_to_le16(L2CAP_CR_LE_NO_MEM);
> +
>  	/* Include all channels pending with the same ident */
>  	if (!rsp->pdu.rsp.result)
>  		rsp_flex->dcid[rsp->count++] =3D cpu_to_le16(chan->scid);
> @@ -5064,6 +5071,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>  	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
> =20
>  	chan->ident =3D cmd->ident;
> +	chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> =20
>  	if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
>  		l2cap_state_change(chan, BT_CONNECT2);

--=20
Pauli Virtanen
