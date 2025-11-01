Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127017A309;
	Sat,  1 Nov 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762012594; cv=pass; b=mHmeTSAl3J6meCHox+cAORbENaoH4y15GuqJr11DhRN6wYFlDyVGA/aOpQmmbDSHF8Tnm++aXEQA7DZqjdCwfiCmJKD0CwISPdZIcaqOvi+gqXYINkjv9HQmIi2/BUAU9QerDWAkSEzuShOCnhU8+nQ49alvKW66hdKv0xPJFEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762012594; c=relaxed/simple;
	bh=1ha4ALK3C+oEtXZa2qJ3bu7+W48OHpriuLnknBHFIKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAOCZBNNPbWSpe/EYfAVDxlA+VjG5eZ842aWtYcnZ1S4TZc24/ceXjsDuy7irUSJ+POPOmz65BqN+jrLRp8xa0wT2ui00TtZXTEryVU8Pka2iUkW9ZzJioe7tHJk/xIL1TOFYSmltygGe3DsI8sHnzj6glPO0p2v2+FJjSprQ0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=T3rL2oiB; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="T3rL2oiB"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4czMsL3W0Wz49Psw;
	Sat,  1 Nov 2025 17:56:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1762012584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6zDpjoD35hh+SQvtUogk0XkYosUJL06LmCHOYhssluQ=;
	b=T3rL2oiBqUQwfi5JS6C0MTjz4SOwrboBwAq6gU4ajMeKjUDvgGc9kf66g4rYiBTLNQL+zq
	FiWkwij620a5DdkOIBJEhNZwNlrzsr3gvMLrweH0bZyc7LZZuVtEB0ZSlu/RI+lu/cYzV8
	HXBSAgQ5iqC4nTF7pgaYbqm9CqtpT+wAm+ATL8uH2cES29mlHIl+E8LkYgB/ulz111ZOf0
	W3IRvLDjaNj3/W4XMAzGsH/gWRW8/4SqKLz9jtV/1VVS1WFW9QZf546tZ3LJ060Dc4fowT
	HIaoV5X/3VXx6boISu/6ciJWKrGiavtIIg4XE8CPLjB/urjkN7+Lzi5FO+0YEQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1762012584; a=rsa-sha256;
	cv=none;
	b=AKn6HpkST8VyzVNW6jR3ReyG1EINwcSY6aawGA3cpWybGPDj2lyEYdhzLWqUMGVgaXQb6r
	faoYNPLUsNuhEcPgcd3q4WQD8GYycHMSs+zYo3wzW0Ct7XBfGOrJ99Is2r9j4sEFTr6ZZy
	xf6Bx6KOUtD5q38FR6om1Oa4+7uNbcy97/fIdZ17ozrm+NXfZYj73xxIeCsKQTJZJtGtli
	PkeBgTE9DBnODQj+spdFrcYQQtqCkbPRyZmg8+Kzf/5SRr0sAKjcTObD6oD9AAoFL1e8pV
	4d/DUihwrXg52HtsjOy8xMOVy6/NACOovFF6MYpNFkx76bkcT7lqjiqLtiHAqQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1762012584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6zDpjoD35hh+SQvtUogk0XkYosUJL06LmCHOYhssluQ=;
	b=Pq3Z+NBcE5sWDO1XWNkBgrjyIUA+SVeOPyEAslZ0KlkEg3wE5BORr9w0a6+ljwUFOGpz1i
	+wPuqycbVjLt57e2zprWL+dXOhCiw/ACNY/5AhMaVwatmfCckIs49Zm4+Z++U+zASqdaEF
	xIff6Ub04SL2kO13igGCb0aqC1dte0T5GVo3WrpVejFjixfo05GKe/JZ0RtokmiHEeUc4c
	vxonZXZFZ20JIXrj1vpisOiEqP4R0eo6BCTTXynyyBYHGBQ3Wpi6CgfTmJWP8lW8xT6kX/
	WLSi5IzuwdIjtRvCCDOMFB2idUBhE9Bf2I9X2AuDvwRRgLEKh36YaZC2XRdk2w==
Message-ID: <9430e38fd2fb34abfac0d90bc84880667749294d.camel@iki.fi>
Subject: Re: [PATCH v3] bluetooth: sco: Serialize state check in
 sco_sock_connect to fix UAF
From: Pauli Virtanen <pav@iki.fi>
To: Cen Zhang <zzzccc427@163.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, 	johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com, 
	zhenghaoran154@gmail.com
Date: Sat, 01 Nov 2025 17:56:20 +0200
In-Reply-To: <20251101104522.174388-1-zzzccc427@163.com>
References: <20251101104522.174388-1-zzzccc427@163.com>
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

Hi,

la, 2025-11-01 kello 10:45 +0000, Cen Zhang kirjoitti:
> Concurrent sco_sock_connect() calls could race on the same socket since t=
he
> state checks (BT_OPEN/BT_BOUND) were done without holding the socket lock=
.
> This allowed two parallel connects to proceed and end up binding two
> separate sco_conn objects to the same sk. Later, when sk->conn had been
> updated to point to the second conn, closing the socket could free the
> second conn and the socket, while the first conn's connect confirm path
> still referenced the stale sk/conn, triggering a KASAN use-after-free.
>=20
> Fix by taking lock_sock(sk) before checking sk->sk_state and sk->sk_type,
> performing the destination address assignment under the lock, and releasi=
ng
> it before invoking sco_connect() (which will acquire the lock as needed).
> This serializes concurrent connect attempts for the same sk and prevents =
the
> interleaving that caused the double-attachment and subsequent UAF.
>=20
> Thread 1:               Thread 2:               Thread3:
> check sk_state          check sk_state
> sco_sock_connect(sk)    sco_sock_connect(sk)    sco_connect_cfm(sk->conn)
> conn1->sk =3D sk
>                         conn2->sk =3D sk
> sk->conn =3D conn1
>                         sk->conn =3D conn2
>                         sco_sock_release
>                         free conn2 and sk
>                                                 sco_connect_cfm
>                                                 sco_conn_del
>                                                 sco_conn_free
>                                                 UAF on sk=20
>=20
> The representative KASAN report excerpt:
>=20
>   BUG: KASAN: slab-use-after-free in sco_conn_free net/bluetooth/sco.c:94
>   ...
>   Write of size 8 at addr ffff88810d2be350 by task kworker/u25:1/88
>   ...
>   Call Trace:
>   sco_conn_free net/bluetooth/sco.c:94 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   sco_conn_put+0x49d/0xfc0 net/bluetooth/sco.c:115
>   sco_conn_del+0x46d/0x8d0 net/bluetooth/sco.c:280
>   sco_connect_cfm+0x83d/0x1ee0 net/bluetooth/sco.c:1468
>   hci_connect_cfm include/net/bluetooth/hci_core.h:2082 [inline]
>   ...
>   Allocated by task 294:
>   ...
>   sco_sock_create+0x22d/0xc00 net/bluetooth/sco.c:616
>   ...
>   Freed by task 295:
>   __sk_destruct+0x4b0/0x630 net/core/sock.c:2373
>   sock_put include/net/sock.h:1962 [inline]
>   sco_sock_kill+0x64d/0x9b0 net/bluetooth/sco.c:526
>   sco_sock_release+0x770/0xa50 net/bluetooth/sco.c:1359
>   ...
>=20
> Reported-by: Cen Zhang <zzzccc427@163.com>
> Signed-off-by: Cen Zhang <zzzccc427@163.com>
>=20
> ---
> v2 and v3:
>  - Fix the patch format
> ---
>=20
> ---
>  net/bluetooth/sco.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index ab0cf442d..0af266880 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -651,13 +651,18 @@ static int sco_sock_connect(struct socket *sock, st=
ruct sockaddr *addr, int alen
>  	    addr->sa_family !=3D AF_BLUETOOTH)
>  		return -EINVAL;
> =20
> -	if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND)
> +	lock_sock(sk);
> +
> +	if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND){
> +		release_sock(sk);
>  		return -EBADFD;
> +	}
> =20
> -	if (sk->sk_type !=3D SOCK_SEQPACKET)
> -		err =3D -EINVAL;
> +	if (sk->sk_type !=3D SOCK_SEQPACKET){
> +		release_sock(sk);
> +		return -EINVAL;
> +	}
> =20
> -	lock_sock(sk);
>  	/* Set destination address and psm */
>  	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
>  	release_sock(sk);

This looks correct in principle, sk_state shall be accessed only under
lock.

However, the lock is released before sco_connect, so looks like two
connect calls can still be at this point at the same time, so AFAICS
the above only restricts the time window for the race.

Probably something along the following is more sure.=C2=A0It's important th=
e
check is under same lock_sock() in sco_connect where sk_state is
modified; in addition sk_state check could be added (or maybe moved)
also there.

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ab0cf442d57b..06c20d99521d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -298,7 +298,7 @@ static int sco_chan_add(struct sco_conn *conn,
struct sock *sk,
        int err =3D 0;
=20
        sco_conn_lock(conn);
-       if (conn->sk)
+       if (conn->sk || sco_pi(sk)->conn)
                err =3D -EBUSY;
        else
                __sco_chan_add(conn, sk, parent);
@@ -356,6 +356,7 @@ static int sco_connect(struct sock *sk)
        err =3D sco_chan_add(conn, sk, NULL);
        if (err) {
                release_sock(sk);
+               hci_conn_drop(hcon);
                goto unlock;
        }

The test bot also says:

"Bluetooth: " prefix is not specified in the subject

The patch subject should start "Bluetooth: SCO:" not "bluetooth: sco:".

The following errors in test bot afaik are known pre-existing failures,
and can be ignored here:

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102
seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.196
seconds
Mesh - Send cancel - 1                               Timed out    2.022
seconds
Mesh - Send cancel - 2                               Timed out    1.996
seconds

--=20
Pauli Virtanen
