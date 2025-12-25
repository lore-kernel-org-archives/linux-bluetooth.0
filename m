Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7526FA4B
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766702405; cv=pass; b=ERP14+sCM1UZzYgrpVnnYZHLSHNEBAmlaZc6XhAok8C8wd2/kK4OVkCpsbANha86USDI4vhZkBDSURm/CWFCkwJBUMJV9MFWE2L50PLz4XiR5Mc9nNyZAkPsef6U08hvyBuSZRENu/W7jhPVfBaTRQHy6VAoy1y08ybXF2JPKuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766702405; c=relaxed/simple;
	bh=CiZ6bs1db63Xz/HRK6avzfGiiZf1j8T9IFs5zap8s7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PtGdcNoESSNRr+kMpglYwa/Y+f0nSueV4iWxyoWRmBC1FySf0tZHuqFh1gF+3wYx4nlTPtmEfYOLhXyQ78k1R+3ElJyJLHmZXwXxGJHWWfD2BTIlHW39awYePH56Igc+Niu1u/dqGHd403XXJgUmtD4JYRbpNlmkGzXOuUUYsB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rd49Did3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rd49Did3"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dckG028ZPz49Pxf;
	Fri, 26 Dec 2025 00:39:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1766702392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QR3BzFrsFFmMboEe41VVacpMKrSHM3PTQJWD9uz6yf8=;
	b=rd49Did3pDw1l1PW0isu4yTSauhg9OAnVStqKHQR6SiT4Qnh6nuv5fq85B94t3ENESIJaO
	ks7KmheFxLLuttF5uKvFV+MfkJrm7GZJfbCDhSPOxTRED7GOsv8FAQcp4M4b8xkVbFiK7J
	/aeaQ+aevBDp0+ojNTuupC5gj9bRbWmIHk0GQqGuyFJs3exbP6HE+QBxP+AYxXN59THHxI
	o2xj0OhCvqKoaEaA/wztcInnqWLZmgZnIhWDtq6DLngKhycQFuiV3NuT5FZ+/S08i43GeK
	WSSoxXS2Jj6lc/P6uju51hTe2M2yyU4JfEZBKBiZqqsmbUsnDxGoQcs9wUloSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1766702392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QR3BzFrsFFmMboEe41VVacpMKrSHM3PTQJWD9uz6yf8=;
	b=XX67k5pxIPsRspB70PSAW1LEOiJfBFfoesD2CqSJH0IW3WXom9DVNlMqywJ042HUwwVlmd
	z1qzO52lRQBD1KYIRCeqBl+Il8OICbAfTTNSa1lHpk9gqQyoLpZGX3EgxYeCOO680kNEF6
	dLTBJr0qdnf6+/LgjuAXIcJFoa+9/34MEQ5si/UCChKo2Oa6YbXbDnHK+a01RKGwLXgqqb
	CA5lB3AwsmYFLJ+Z78+tJxyiZNM1Qa5rsy5tVXaVZWdnP4KlPYd2nLlb3R+mY4USzztDEE
	7/hl+Jujv8IfWZPetBsKGBDWhZigiVoT2LOgeX0vQJhcHlLgbXeCdmbRT5vv5Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1766702392;
	b=Y7TDdhn0wLVKOnfzS7HE2WkFvnB4Wk/1cJTTjnbPh+QP9p1HBAAVu5KCbarnFAcNfFYd1C
	gijpb0HAnuSUPd/sBzKJokL4ig1HIHZC40yVNfPhx5WCD7ztePW/GIks2ky20jcOIOOfB4
	IWF2LVw93ATcXfVvi/X8WtcZQC+teG9a+uEjWMQeUlcTuOzpmlYsmL9dS0AEAGd3ah8KAq
	yPP9VAE+shUN8+hx4inCQy0GNz1W+hDzOdfdDovbq5+vXL3Abl31aX10mZ79uun1XD+P1F
	BJWi4imRIIjW6jkwo2o1snZ2yINBSl4CTpDSDJtHIc8B8bS18o/UZtQB97xlEw==
Message-ID: <07af8a83302ab5ab009af26e2e82525a151450dc.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_core: Fix slab-use-after-free in
 hci_cmd_work
From: Pauli Virtanen <pav@iki.fi>
To: Szymon Wilczek <swilczek.lx@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 26 Dec 2025 00:39:51 +0200
In-Reply-To: <20251224235407.46333-1-swilczek.lx@gmail.com>
References: <20251224235407.46333-1-swilczek.lx@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2025-12-25 kello 00:54 +0100, Szymon Wilczek kirjoitti:
> syzbot reported a slab-use-after-free in hci_cmd_work.
> The issue is that hci_send_cmd_sync() consumes the skb reference
> (either by passing it to the driver which frees it, or by calling
>=20
>=20
> kfree_skb() on error), but the skb might be accessed after the call
> in certain configurations or due to race conditions with the freeing
> process (e.g. vhci_read).
>=20
> Explicitly hold a reference to the skb using skb_get() before calling
> hci_send_cmd_sync() and release it with kfree_skb() afterwards. This
> ensures the skb object remains valid throughout the function call,
> regardless of how hci_send_cmd_sync() handles the original reference.
>=20
> Reported-by: syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4d6b203d625d2f57d4ca
> Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>

IIRC this was already fixed by 275ddfeb3fdc274050c2173ffd985b1e80a9aa37

Indeed, syzkaller has no crashes on this since 2025-11-19.

> ---
>  net/bluetooth/hci_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8ccec73dce45..af4ef31295c4 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4149,7 +4149,10 @@ static void hci_cmd_work(struct work_struct *work)
>  		if (!skb)
>  			return;
> =20
> +		skb_get(skb);
>  		err =3D hci_send_cmd_sync(hdev, skb);
> +		kfree_skb(skb);
> +
>  		if (err)
>  			return;
> =20

--=20
Pauli Virtanen
