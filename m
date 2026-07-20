Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6A18871F;
	Mon, 20 Jul 2026 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578129; cv=pass; b=L0nkow2mHARCpseKcUuIfaAQRyDZpxdHglPMJUCcq1ysXkSxvMhl2/AtGi3p4MIJ0VA8PpNqnJ3LaT1jNEx65jBaAeoYZ+ZWbjX2o+ubUmmCtDice7ALoTtrYcuWLFjsJvBr71ddTbzGjZek50DUBn/rM0YTAklZYwSNvYpfa4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578129; c=relaxed/simple;
	bh=D/T2Vy0cL9ejkZEPjrbVDh8Zi4rCg4WdhBl8wsxaZyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EP0BhXrq3XIlSOWI66fWNCgNBRX1AjTPV2W/26LRWGLLtx/QZqyrbEYiyMILLGsjXT1uXPBTDA5C0KderjrsqcHUSNpGoA7QNR2aCIXYPcJoNhujrSXbO5W9HzesD2suxLcEfxCrc4X9SOL+SCkWCcD9KrM2WJDGzF3eJ1vOqt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ME9UVb89; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ME9UVb89"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h3s5y66Qpz4BKLm;
	Mon, 20 Jul 2026 23:08:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784578119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FJPHvrd4K1UnTPo+tRz1yVzPhok/nBAvRnQxE8iclkY=;
	b=ME9UVb89+JV7vCtyfI3GhB8jqB/IoeA0fxyOxpZBVWsarowPi6zWkKJSlyN1zadYytCBiu
	6PsByMx01dfYtzJOnHCsUKH2B3GMJwuQoRwLkfy+9cZ8+JVr74vKqUW4BXVAQoNbY2as+K
	Jo+RpGKjLbMyORAN/IlHc+u+5wCXilEZY546Sb2FXlE4c+BjIUV5nKOW7eN+B3QkOjifJQ
	pT+0QpBd6QhNExFfX8ypvu5wFitcpJ9Xq9/Gki4U2/pA4Lhd4+M9VK/LlAuRdc4wPR+7i8
	h9hjMt4KEN8P9eC9beZGOwCBIuet0nMLPeAV+jDb5yHU0z/fi5jMBCAYG3CZTA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784578119;
	b=YKdeMOugbAxwWEJwKlFtqrAOhMDbqnO1Nn7F7FgK+eODvI67ylufjA3Nk+uIIKheXjNH03
	TezuGB/SawHdEyfDB3XK9lzoPHW0FKUGVwpggGvpxi9ejtAJMSN9lXt+LXvpPJvUNe08b8
	DhMnxlgrnEbyBNamXaYuCouCQrOZDrcuxJb5Dj86i1fMC6pIjPb3jgrhywR9oghHSBPH+b
	s1pAqv20ha1HaIUXE18Bw5tZeCdve4GTgR4IBKU8OEumg/KClutNYNh64TphefLJkXpleu
	BbV5hX7juzEYv7rFulPkVvIxa9WsfThd8UpQhRd5GANW0XfWz9fIiCOTLli2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784578119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FJPHvrd4K1UnTPo+tRz1yVzPhok/nBAvRnQxE8iclkY=;
	b=nzYKONpeLcSrgBYFLuO2RW3qpn57icicSI4ZfmFxKJqNiYk4CskTQ/z1ijp0NBW2Ny/b8z
	hk4wuvVzRQEF/GkiX2NeW2Io+1Iel3zoR+wHXa/Pogb4NfUmZygGrIxpFKRR7oXYRAqti+
	7rq952qtg0jO3QMlO2f93SGknkbDDEUOxAS5s8KNoxM6aUl+2N29Qby8YoAJvfFkGIMb0e
	57M0mxYJshrP63BQSY3yR7hfNL7udlFSMpSPyGc8cL94zIv9KC5q9QhJENmHbIM3Acf5hO
	0TGqaQlIkFEKnyF7xSaz0Toq1pgQAKqpAjsZ1+y5g1p/ElSbxCFVNRNa+i9IrQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <bdf9806d5f2de01e355f0e835201df692f0b2744.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: ISO: fix UAF on socket close before
 shutdown completes
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	iulia.tanasescu@nxp.com, linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 23:08:35 +0300
In-Reply-To: <CABBYNZKtXwpnz9PH3eR31ETKAvPOoCnWebKf0UUDpe7tPQs3Kg@mail.gmail.com>
References: 
	<4d96c545ad1a2fed02440a3478905853286aa0c7.1784571683.git.pav@iki.fi>
	 <CABBYNZKtXwpnz9PH3eR31ETKAvPOoCnWebKf0UUDpe7tPQs3Kg@mail.gmail.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
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

Hi Luiz,

ma, 2026-07-20 kello 15:37 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Mon, Jul 20, 2026 at 2:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > iso_sock_disconn() aims to disconnect the hcon by dropping it, which
> > triggers iso_conn_del() once the HCI operation completes, requiring
> > valid hcon->iso_data to do socket cleanup.  iso_sock_disconn() sets
> > conn->hcon =3D NULL to avoid a second drop, but also preventing clearin=
g
> > hcon->iso_data on socket release. Closing the socket before
> > iso_conn_del() runs then results to UAF.
> >=20
> > Fix by using a separate flag to track the hcon drop status, instead of
> > clearing conn->hcon.
> >=20
> > Log: (BlueZ iso-tester ISO Connect Close - Success)
> > BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero
> > ...
> >  iso_conn_hold_unless_zero (net/bluetooth/iso.c:138)
> >  iso_conn_del (net/bluetooth/iso.c:270)
> >  hci_conn_failed (net/bluetooth/hci_conn.c:1408)
> >  hci_abort_conn_sync (net/bluetooth/hci_sync.c:5817)
> >=20
> > Allocated by task 34:
> >  iso_conn_add (net/bluetooth/iso.c:216)
> >  iso_connect_cis (net/bluetooth/iso.c:507)
> >  iso_sock_connect (net/bluetooth/iso.c:1211)
> >  __sys_connect (net/socket.c:2148)
> >=20
> > Freed by task 34:
> >  iso_chan_del (net/bluetooth/iso.c:248)
> >  iso_sock_close (net/bluetooth/iso.c:885)
> >  iso_sock_release (net/bluetooth/iso.c:2022)
> >  sock_close (net/socket.c:722)
> >=20
> > Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA sy=
nc and BIG sync")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  net/bluetooth/iso.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 2e95a153912c..6abc2b1f59bc 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -30,6 +30,7 @@ struct iso_conn {
> >         /* @lock: spinlock protecting changes to iso_conn fields */
> >         spinlock_t      lock;
> >         struct sock     *sk;
> > +       bool            hcon_dropped;
>=20
> It might be safer to add a flag or something so we can perform atomic
> operations to check if dropping is necessary.

It is serialized by iso_conn::lock + kref, so AFAICS it is safe. I can
change it to test_and_set_bit() regardless if still preferable.

The lock is not taken in iso_conn_free() ---=C2=A0at that point nobody is
holding a reference so there should be no concurrent modification, so
AFAIK it is taken care of by the refcount memory ordering (see comment
in include/linux/refcount.h), otherwise conn->hcon etc would also be
wrong.

The
comment=C2=A0https://sashiko.dev/#/patchset/4d96c545ad1a2fed02440a347890585=
3286aa0c7.1784571683.git.pav%40iki.fi
on Sashiko seems to miss that iso_connect_cfm / iso_disconn_cfm ->
iso_conn_del() are called before hci_conn is deleted, and should make
sure there's no dangling reference to the hci_conn. It would be same as
for remote disconnect. Maybe the prompts it uses in
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/blueto=
oth.md
could be improved vs hci_conn and socket life cycles.

> >         struct delayed_work     timeout_work;
> >=20
> > @@ -107,7 +108,8 @@ static void iso_conn_free(struct kref *ref)
> >=20
> >         if (conn->hcon) {
> >                 conn->hcon->iso_data =3D NULL;
> > -               hci_conn_drop(conn->hcon);
> > +               if (!conn->hcon_dropped)
> > +                       hci_conn_drop(conn->hcon);
> >         }
> >=20
> >         /* Ensure no more work items will run since hci_conn has been d=
ropped */
> > @@ -306,6 +308,7 @@ static int __iso_chan_add(struct iso_conn *conn, st=
ruct sock *sk,
> >=20
> >         iso_pi(sk)->conn =3D conn;
> >         conn->sk =3D sk;
> > +       conn->hcon_dropped =3D false;
> >=20
> >         if (parent)
> >                 bt_accept_enqueue(parent, sk, true);
> > @@ -836,8 +839,10 @@ static void iso_sock_disconn(struct sock *sk)
> >=20
> >         sk->sk_state =3D BT_DISCONN;
> >         iso_conn_lock(iso_pi(sk)->conn);
> > -       hci_conn_drop(iso_pi(sk)->conn->hcon);
> > -       iso_pi(sk)->conn->hcon =3D NULL;
> > +       if (!iso_pi(sk)->conn->hcon_dropped) {
> > +               iso_pi(sk)->conn->hcon_dropped =3D true;
> > +               hci_conn_drop(iso_pi(sk)->conn->hcon);
> > +       }
> >         iso_conn_unlock(iso_pi(sk)->conn);
> >  }
> >=20
> > --
> > 2.55.0
> >=20
>=20
