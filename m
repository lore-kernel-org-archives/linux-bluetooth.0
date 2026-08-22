Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563C37E317;
	Sat, 22 Aug 2026 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787386972; cv=pass; b=aLGetybdVUXrti+hSFI/eKR2Ra5YsM7TU6fpnTGU3y6mLF+6g1QGy4dy0IHo5zJ7KxRO1BxmCcV/lld5yJ+J5vryMaAhhVlOgJt2DcydK6i5iYYthXmvm5IhkrqViidCjlOIbKQOTD3W7+m9GU2GEnM/5bjA1jZU7KuNOIzcz8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787386972; c=relaxed/simple;
	bh=ffaw5rnAoVVBEKNPZDvlaUq56DAHst103+3TAyH/LMc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JwBWaLXyZqQ8cCC6s9lDjZdlgy133GZfUJ0JT/e4xV8lNkMlQvANPm3ggRSl3PQX7CbACOh+eqQYqMTakFNsX3uA8gurAd6vuJWnIgNn3ynfYeyZlX1sorsVA90JG/Th8q58yhj4Fg8IVUheN9qE4ziCB4qp79KdzL+Ez2Ed0v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AWm8eoAT; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AWm8eoAT"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hRqsx2pQZz49PwQ;
	Sat, 22 Aug 2026 11:22:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1787386950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/Gs/OEFNLY/W20WD8R7cHvoYJdpBWo5h4GLtIb+3RN0=;
	b=AWm8eoATsFcyD4X7v7p4OJ73JF9L5CQz3Rj7ry8keDTWVCij6VNoHQBKyKlICPFKGY80nw
	KvN/rjJrF1WZdwLne5STEJ3IPAy7uRNvAZ6FV5eXMRihzdY+oyMNQEedtSyi+ziM/5ZDyx
	2d1wcXW5D1frKgbBL5T7NN+uL8QtL8R6eJzms5HX7slrHzUr+g9Nt7PXFSKYSNBPxjMVJQ
	0HWtQu8KNBkldCoA6T68eEdb1f9NRKbDNRdvavPiXvKgtUQpzVCXEEqEiU2rq1B06SlBIG
	7//kYc4B/kcpKHaIH4cjzX34GsdsN+rzG6rbctrkbyFiLN017A3NU0NDXoN2HQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1787386950;
	b=fd27mgDkal/pbWuS0/sGk0VidgCVzPd4fYCCpYjtP9QjZg2lbKPfTQ3cw3IwWw3C9AgX3m
	YPL5K6fZ77SminlmRLcFPCbtY65vfImU4eIkrzxeJLlDTYFvAmO3dHyHe7sV7DTGH7Q0s+
	dWvIdlbRTZMEJlo3GToMrj3qNU1tY+Izu+oioTOWp/oCEIkIWyOcTu+BAmAroOK4V6byNJ
	YpjZ7NbqgMurIRKWq3zMZgKux46T/XG9jZY2nLKnhNYobGlgIKUYxxZf4auIFVMgOmKH7S
	FJoEh/GIvtff+74Lu/dO+hA/DDRRVULTbNKi4uJeFbUjD1rbCSjuqoWtWUdgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1787386950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/Gs/OEFNLY/W20WD8R7cHvoYJdpBWo5h4GLtIb+3RN0=;
	b=ZUxAlxoPlV4QQ+71iPtr+I119PGgBghyRyFJhTCEgAleMQiawFWS+DjwUIuB9uO+MY+UfO
	eWBQBAk9R1hsftg7GjSneI/MDQIiNy6b8c1aSdigO4FHJm6EAXG6s4xtn02TCgEBdFPMZy
	RbBhsyKPFySLwzmLru8xXxccPoa96l9qHXa0X+bTdurFYins3XoR35NjgyXTVqW+3Ipt7+
	ihIe0OkYY8LR93VYCuZPvG1LHCkkxHc/D5yHJl6iQYew0tPbawjjbluyAaKMjpDnNPI3Ls
	8UNGwx6dtRPHGnYnpWCvFXPDAGNoPRn38s2/kJM9uN19Ox3oOatXEKyyuOekgg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <3994a6f5f051dad3070166c966a69da466702674.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize session teardown
From: Pauli Virtanen <pav@iki.fi>
To: Chengfeng Ye <nicoyip.dev@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>,  Luiz Augusto von Dentz	 <luiz.dentz@gmail.com>, Ali
 Ahmet Memis <ali@iusegentoo.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 22 Aug 2026 11:22:26 +0300
In-Reply-To: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
References: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
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

Hi,

la, 2026-08-22 kello 01:45 +0800, Chengfeng Ye kirjoitti:
> rfcomm_kill_listener() walks session_list and deletes every session
> without holding rfcomm_mutex.  A connect task holds that mutex while
> rfcomm_session_create() adds a session and while its error path deletes
> the session, but the unlocked teardown can still observe the object
> between those operations.

Reviewed-by: Pauli Virtanen <pav@iki.fi>

While looking at these locking bugs, please also consider using LLVM
context analysis to globally audit the locking of the structure, to
catch the other related data races:

https://docs.kernel.org/dev-tools/context-analysis.html
https://mirrors.edge.kernel.org/pub/tools/llvm/

I think adding the annotations probably should usually go in separate
patch to make backporting of the fix easier.

For example, adding here:

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 0e496b85e6ce..6b5c44f0d89a 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -47,7 +47,7 @@ static DEFINE_MUTEX(rfcomm_mutex);
 #define rfcomm_unlock()        mutex_unlock(&rfcomm_mutex)
=20
=20
-static LIST_HEAD(session_list);
+static __guarded_by(&rfcomm_mutex) LIST_HEAD(session_list);
=20
 static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len);
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
@@ -676,6 +676,7 @@ int rfcomm_dlc_get_modem_status(struct rfcomm_dlc *d, u=
8 *v24_sig)
=20
 /* ---- RFCOMM sessions ---- */
 static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int =
state)
+       __must_hold(&rfcomm_mutex)
 {
        struct rfcomm_session *s =3D kzalloc_obj(*s);
=20
plus other __must_hold(&rfcomm_mutex) annotations to functions where
needed, compiler warnings show the session_list is accessed without
holding rfcomm_mutex also from

rfcomm_run() -> rfcomm_session_add()

rfcomm_security_cfm() -> rfcomm_session_get()

Are these reachable? Former is probably theoretical, the latter could
be reachable. Also if unreachable, in my view, taking the lock may be
better than relying on a possibly brittle and hard to understand
invariant to protect the access.

>=20
> The race can proceed as follows:
>=20
>   connect task                    krfcommd
>   ------------                    --------
>   rfcomm_lock()
>   rfcomm_session_add()
>                                   fetch session from session_list
>   kernel_connect() fails
>   rfcomm_session_del()
>     remove and free session
>                                   rfcomm_session_del(session)
>=20
> The final call then reads the freed session and may corrupt the list.
>=20
> KASAN reported:
>=20
>   BUG: KASAN: slab-use-after-free in rfcomm_session_del+0x15f/0x170
>   Read of size 8 at addr ffff8881019e9b40 by task krfcommd/87
>   Call Trace:
>    rfcomm_session_del+0x15f/0x170
>    rfcomm_run+0x16d5/0x3de0
>    kthread+0x2c6/0x3b0
>    ret_from_fork+0x36e/0x5a0
>   Allocated by task 96:
>    rfcomm_session_add+0x9e/0x300
>    rfcomm_dlc_open+0x8b1/0xdf0
>    rfcomm_sock_connect+0x34c/0x530
>   Freed by task 96:
>    kfree+0x131/0x3c0
>    rfcomm_session_del+0x109/0x170
>    rfcomm_dlc_open+0x9eb/0xdf0
>    rfcomm_sock_connect+0x34c/0x530
>=20
> Hold rfcomm_mutex across the teardown traversal, matching the locking
> used by normal session processing and connect error cleanup.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/bluetooth/rfcomm/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 9cdfea666a2c..5fe2758e8c47 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -2178,8 +2178,10 @@ static void rfcomm_kill_listener(void)
> =20
>  	BT_DBG("");
> =20
> +	rfcomm_lock();
>  	list_for_each_entry_safe(s, n, &session_list, list)
>  		rfcomm_session_del(s);
> +	rfcomm_unlock();
>  }
> =20
>  static int rfcomm_run(void *unused)

--=20
Pauli Virtanen
