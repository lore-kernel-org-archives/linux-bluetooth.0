Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0113540F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Mar 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741527; cv=pass; b=Cs0QRVvRq8v+ZovardwSa9uG/HJCdjJqzo35p8twKqV/hEWpauadHaaGph/PPnUyVTGHmj3uYrmvTMAaQsq8DbHLmmmh4LAvJ1RHcPxYtrou4Ie55pKPWR/LRDHgZ6eb/lJxINbsjdYotdMf6DfaXQc2Gc4ii+ND1l0QuGrROgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741527; c=relaxed/simple;
	bh=uHf4KDeEOa/MoEOXQGzFoMXWxUiFYSOrDBR45jqzh4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1y6uR3W888tRPMH9dxxK4Ph9ThiCt3LkKux1h1ru7OTga1DtDlrWzqXBMuJCv+ev7o7FJ8T5ONoat3Krd7V1xnFFB5kczVZ3PsXuQXM++wWh+HNaMqzzd+8n4CmYQIs6+7Wvv5qC4JbnvO8mhluWQPp0Xvn7vO0DPDwv1Jdm3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=W220bvl1; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="W220bvl1"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TqcrW004qz49Pyl;
	Wed,  6 Mar 2024 18:11:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1709741515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mDUPzqcu1e80xDjzWwKQ7BvEndaKyK9WEBXv5YEz6As=;
	b=W220bvl1KnVt4y7/NYbZkxUojaB9WxIbCmZMkKw7tzISq9RuIRKmPLyXCJTmysmc870sd8
	T8M9rVKEnRZRn5W0AG/jWNPCGaY7bpf/ESUcsGJzghMrDqt+jykwROuGxbYle2itSLdSFO
	O71YLOrk9LpxquCLEkcRQ4S8bAORBtY34DqB12t7cx85xVmUeQ8O30VsSbuzD+9246qqOV
	oUeaK6yc+6QTaaTQXrel7HwNG0VxglhoQgyxy1Q4lsLLikL5Jh4nLMzj1fBm0xZWG6KMw6
	abUQ4cwme2DfjuUMpiBg7CRom3wiJdsYrrmj8O+osX/yw4CxFuj+ooFcjo4wbw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1709741515; a=rsa-sha256;
	cv=none;
	b=cGyHWwiZsp2JLlAuuB+rSMCLcm5aC2t5BOaKouR1xvgarn/w0HPfGb3LeblMZ7Zf7nRDyF
	xz7MQokWNCEbucxYHideWJhJWL5xtSRInWfHNv+mvJ9LcMpWRvQKvYNTnAFBAy+wunWNwx
	MtiAmZf5M65Z6qsjsstA2tRyovVeyvQ7+j2KzT9FreQhnn0lvlHqvgvyj3dTvmOF9CCHv4
	a9TbWC3LsjmYuWQd6JLPXRSa10+hDcPyNWCW0gL1csOsrE2jnNkDMbLLa69qgjrH952Jq1
	kRJztpf3HCNOqE/5lPhrT4JGvxZtC942GuoCVKTTgtTP9/skYnfJkHLC1nUBkA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1709741515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mDUPzqcu1e80xDjzWwKQ7BvEndaKyK9WEBXv5YEz6As=;
	b=fL5uABJdz2N81Vnb+lpx3KEi4ElyO3yFj9orEmQNd7NRwWQLXQJj2LdfcZlOm4VuJayfEp
	Yjd9XM51S46C4oGziBrN9YrIlWSvfeSinyefYx1mo7S05bgF66uqPSwhK/SKDbXhozoeVx
	Vk5hdwPTZc0ne23Kw3rOOoDrQVfbFCrCNGu8LXsE/EgKywbnz/AKI783V5EySAN5n5tU+l
	h+s3jPvfslQkNQ6iy/3F4Kss6xADpITzwQwL1TZVFyMNTkuMAzTkeNzD8Z9iA+L+rjR1bT
	tlLwx8Ph+Yz/BnVfCKF9lJ7FGzByrRZINhgogbnIuZKhY4jr0HeLQABuBCOIQw==
Message-ID: <67057b99a60736a9b4ce8dae59cee93eed4373f8.camel@iki.fi>
Subject: Re: [PATCH v2 1/2] Bluetooth: ISO: Fix circular locking dependency
 warning
From: Pauli Virtanen <pav@iki.fi>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 06 Mar 2024 18:11:52 +0200
In-Reply-To: <20240305140939.5090-2-iulia.tanasescu@nxp.com>
References: <20240305140939.5090-1-iulia.tanasescu@nxp.com>
	 <20240305140939.5090-2-iulia.tanasescu@nxp.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2024-03-05 kello 16:09 +0200, Iulia Tanasescu kirjoitti:
> This fixes the circular locking dependency warning caused
> by iso_listen_bis acquiring the hdev lock while the socket
> has been locked in the caller function.

I think the commit message and the comment should explain why there is
no deadlock, and that the lockdep warning is a false positive.

E.g. fuzzer calling connect() and listen() at the same time seems it
would be dangerous here?

>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.8.0-rc5+ #1 Not tainted
> ------------------------------------------------------
> iso-tester/2950 is trying to acquire lock:
> ffff88817a048080 (&hdev->lock){+.+.}-{3:3}, at: iso_sock_listen+0x305/0x8=
d0
>=20
>                but task is already holding lock:
> ffff888197c39278 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0},
>                at: iso_sock_listen+0x91/0x8d0
>=20
>                which lock already depends on the new lock.
>=20
>                the existing dependency chain (in reverse order) is:
>=20
>  -> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
>         lock_sock_nested+0x3b/0xb0
>         iso_connect_cis+0x185/0x540
>         iso_sock_connect+0x445/0x7e0
>         __sys_connect_file+0xd5/0x100
>         __sys_connect+0x11e/0x150
>         __x64_sys_connect+0x42/0x60
>         do_syscall_64+0x8d/0x150
>         entry_SYSCALL_64_after_hwframe+0x6e/0x76
>=20
> -> #0 (&hdev->lock){+.+.}-{3:3}:
>         __lock_acquire+0x208f/0x3720
>         lock_acquire+0x16d/0x3f0
>         __mutex_lock+0x155/0x1310
>         mutex_lock_nested+0x1b/0x30
>         iso_sock_listen+0x305/0x8d0
>         __sys_listen+0x106/0x190
>         __x64_sys_listen+0x30/0x40
>         do_syscall_64+0x8d/0x150
>         entry_SYSCALL_64_after_hwframe+0x6e/0x76
>=20
>         other info that might help us debug this:
>=20
> Possible unsafe locking scenario:
>=20
>         CPU0                    CPU1
>         ----                    ----
>    lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
>                                 lock(&hdev->lock);
>                                 lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
>    lock(&hdev->lock);
>=20
>                 *** DEADLOCK ***
>=20
> 1 lock held by iso-tester/2950:
> 0: ffff888197c39278 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0},
>                 at: iso_sock_listen+0x91/0x8d0
>=20
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/iso.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 8af75d37b14c..5ca7bb0806b0 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1095,7 +1095,10 @@ static int iso_listen_bis(struct sock *sk)
>  	if (!hdev)
>  		return -EHOSTUNREACH;
> =20
> -	hci_dev_lock(hdev);
> +	/* To avoid circular locking dependency warnings,
> +	 * use nested lock for hdev.
> +	 */
> +	mutex_lock_nested(&hdev->lock, SINGLE_DEPTH_NESTING);
> =20
>  	/* Fail if user set invalid QoS */
>  	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {

--=20
Pauli Virtanen
