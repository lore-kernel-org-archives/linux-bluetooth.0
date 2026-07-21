Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294F433BCA
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784671409; cv=pass; b=TAg4vImtI0zXbufFJAh726vgn3tNKHyivH/+EEnDa+o8o9qgCzUoXgYlM7gIxxH1CNjR+O0HP4cZEBQXe+Mj+Ud7agRBdaQHcFu79uSR9N6k8OIYlekrkdAigJLzOaU8e+IfBjK8adWXgwUO7tZ7rq+dFY175+6UlbctfH2p8aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784671409; c=relaxed/simple;
	bh=rI9jeh8i2zsoQUULh9O5Soadz68HN6s/+jSCTDJ86SU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ho2w1DFedZ7+D7xs6hWW0Lv0rbFILT0c2/9VgKPwgU8B++Wl4h5yxwXIwBdvFJJYLKX+fU+GQp7HuLE7IQd3JaNzxUzX3wUVXGXuW7i1iDnrZE5kB5z4SMe0oBA/dOpExPFYDVT3hqf+d0XcQPzAS20v89ipSHzkOrNTjg4Ut04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=k7RSBxlk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="k7RSBxlk"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h4Wbj29tlz49Pxf;
	Wed, 22 Jul 2026 01:03:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784671393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n58rDKPT3dMIhZLPrhQRZ79sr5GcCZh4NxA7qyLTR7w=;
	b=k7RSBxlk8+cxkblG4GiEtYgph0FjCnNAXqYYfK9ErQN0SLt7QJCPJp87+5bqoHSeNleDyJ
	HrjkeT/Nf4nIZdRTkpNdBdb2MZ9UTLAbP654mG5k/0FjUl0f/pcdQ68f9uOUqsBMSxdBLq
	C56rYtZQTMMiRImMYFH0tQihsmt2qlT/l9PfIOIh7zRwEecRl6FBBW8mMCKVvpwtQk2r0S
	KyF1CCK7yhTS0JflNTnFSOHHdc9QZDRd3+qA1hvrvit5RWPoURpYwT74Mi1UxhpOE/Y7Nj
	Q5hK42NdFkFBpnL4QTMItbJ1ewYvUf64JQVkFrKlC/KMN1eNNCX9k4j4gaU9jw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784671393;
	b=ImOQ4AV324ExjaONxdus+gRBCebSxqJeVuu/32tDBqvxxUctcixzO75Y/8PYRNf5OV2VH1
	K59a2R1re2mnpxrbIngyy7+akugI3pTJo6C4hlRLCtLpcqBjCKHm5/w5HD+DuWxvb1QJIW
	xwZEa/Fat3483WCYQRv6kVgfFv1KQ+FRFFvLvC1OqT1OfkNj6Wp1R2hmZ6NBV8wNY6TwnD
	cMCiLR3C/XdcWBGDRzt35aB4eEAcR2ro+T5FrqByeNsR8sKM6wEIjT7GX73m7GhCrJO4wZ
	gI157wkv8gZOw8dVTPQ1+t5S+zDYrfL+mY1BVhzRR9WmiIT/b3BEd+YrmrjWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784671393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n58rDKPT3dMIhZLPrhQRZ79sr5GcCZh4NxA7qyLTR7w=;
	b=K0P1dvhRenoSAoujR6K9SdLoDAuCTH0OTTSCGqihsJdFOxiNwfysvmKzqm9ttOJqHfeohP
	+Lfii9odlJW+rHkQhgz00d0EWM5o6+vdXdXMQxQZCdj3Dfv7FLbykX8TCIOCpKQj5ylcRg
	2N5gABmo/iu8MCZRPUNAIsrNhgB8moZ0vBQoCU95VjTk+t1Ki4sdJzvO3zFtAXRX+heA3s
	6hng00iR8zhUFesatNPXQMY/mmiJV4XmpAAIJdJpsxkqNIREV0cSLey4T5FrhEY4rST3LO
	BcUA2Fst0c68WohDiyLSvnFB0j/4yNERvHDa8gSh1pGd1E1GpAPRRdpVIWo7Zg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <09cfe8ec607004f1be5fd14459799b3fca6157b4.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: ISO: clear iso_data always when detaching
 conn from hcon
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: patchwork-bot+bluetooth@kernel.org
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Date: Wed, 22 Jul 2026 01:03:10 +0300
In-Reply-To: <178466283139.1001510.13531091802205452302.git-patchwork-notify@kernel.org>
References: 
	<f3d8d52dcb2a5464393623a56369ea244c144460.1784559155.git.pav@iki.fi>
	 <178466283139.1001510.13531091802205452302.git-patchwork-notify@kernel.org>
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

ti, 2026-07-21 kello 19:40 +0000, patchwork-bot+bluetooth@kernel.org
kirjoitti:
> Hello:
>=20
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>=20
> On Mon, 20 Jul 2026 17:53:33 +0300 you wrote:
> > When setting conn->hcon =3D NULL, also conn->hcon->iso_data =3D NULL is
> > necessary, otherwise later iso_conn_free() will UAF.
> >=20
> > Fix clearing of iso_data in iso_sock_disconn()
> >=20
> > Fixes KASAN: slab-use-after-free in iso_conn_hold_unless_zero on
> > iso_sock_release() followed by hci_abort_conn_sync().
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - Bluetooth: ISO: clear iso_data always when detaching conn from hcon
>     https://git.kernel.org/bluetooth/bluetooth-next/c/e824c0bbe0ec
>=20
> You are awesome, thank you!

Was this version of the patch picked accidentally?

This v1 breaks transition to BT_CLOSED state (tested via the new ISO
Connect Linger - Success iso-tester patch), since iso_chan_del() is not
necessarily called

https://lore.kernel.org/linux-bluetooth/4463dae062ffcb12ad82c843052e35b550b=
7924b.camel@iki.fi/

The later versions changed title to "Bluetooth: ISO: fix UAF on socket
close before shutdown completes". Sorry about the unclarity.

***

There's some remaining problems related to ISO socket teardown, present
also in previous bluetooth-next/master versions (don't have patches for
these yet):

1)

iso_sock_kill(sk) has

	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket ||
	    sock_flag(sk, SOCK_DEAD))
		return;

which always returns early, since sk->sk_socket is NULL after
sock_orphan(), but sock_orphan() sets SOCK_DEAD. Looks like
iso_sock_destruct() never runs in iso-tester. (SOCK_DEAD ->
SOCK_DESTROY probably works here, likely should hold lock_sock for the
whole segment).

2)

iso_conn_del() doesn't call sco_sock_kill(), so suspecting that release
of sk in BT_CONNECTED state without preceding shutdown does not free
the socket.

3)

Correctness of iso_conn_del() requires reasoning about "who has the
last reference" with race conditions, which is maybe too complicated,
perhaps it should directly clear iso_conn::hcon

--=20
Pauli Virtanen
