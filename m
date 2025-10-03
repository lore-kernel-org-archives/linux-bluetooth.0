Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590932D878D
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513035; cv=pass; b=r6C6h2dQmrn4qP9iIob2TRXiWITScRdkNA22eBUgI0XbTEnr35l6U39lqSOYYM5unr/tqFrZBzalTyxb94YZyq4mjCroDFk61hbZP2mwNTcdP8oxq/2/VZVZbWG2vylCDE4ERxPyu3+FLz7a4J6a7rAsnMuzNRQ5tlD1kMlG4q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513035; c=relaxed/simple;
	bh=M/ytuXgeK77/7NFNSpqr40GSPvCb+3x36WcyltjOq4Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hyCFB363hI9luISfyDjuXOxGQ5ZMEsi80Ou4/Mt7dr++nq55PG9g4DajkOxKcFntZHFQoE7LF1ZdWlJBYkhIaVWk/MCr/WdvaC39zq0dNAF55PHBIti73O1izD8BEu+zVv650VNMWe0d4Tg93C7JX/C2cN2+piK3n1Ti6BByVgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=atsmZi+k; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="atsmZi+k"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cdbSy5Pxzz49Q4h;
	Fri,  3 Oct 2025 20:37:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1759513026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/zEYGR3qrQTXM0tX91j/702xNw26XBRdyE0/YDtnDAU=;
	b=atsmZi+klcRRhFAj6B7PFm2NoaObOw5euxTEZSMB1/BNFohUjcLr6J7e3glu4sEUb7oPG3
	vfySGIE4RnZcGC/9uuaRdcZ9ZQyAMI4bdvO7HtV08Ao8siQMfWsNIdTnOHqsCdNyRD27PF
	1ToiZBsbAMHaXQr7f3lG3lMkmHqF5/WpN3LvKVGi/NbsE8pHKeDbPZ5+DORls2nnuUc/x2
	7XZdKit81mNX9TtQQT+ggiDvsdMn4LlsUTYvXRgBDV3/HWwr5kRooohhZZiksIz9OdU/+R
	ny6S+lk4VM8KjYzUbFpC4isbHRYIwl6VbOXkwwFGTfoDr40V1juA51mgPnK1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1759513026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/zEYGR3qrQTXM0tX91j/702xNw26XBRdyE0/YDtnDAU=;
	b=fwQoSAsFSdZrjhmgCi+XNHsjY/PuSBk5C4GjiW0xVgFVPQ4dKsq8xn8qi0n2a6DtHtWkIg
	/5IKrSLuV4He1BlBEkepShhpOTSLoQiMX5be8iE/Xag4H9gQFTvVYIoKpj/L75UPFy1tQh
	feUKP28tTVsqDTK1ZiM1IABpTdqy/CBT+8K51ywfzDlJ01oi+ZVCrrK3Dc8upololVWCl4
	a+5//C/QtGqsqyN8BW6d5oIpd6yRJyjN9M3cTXGQ+NQndW3MMGkAeeJjTquZaY7saQx650
	c/gjFXMUeLDfa5jf/FaVmKLpBVBhn76d9zZFfMoZCmTOL9jJyoX8hBWLDJdEmw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1759513026; a=rsa-sha256;
	cv=none;
	b=OrykowqSrz7VJoMLp/6x52nC9fMxkI1tkDY8Sc/gHwVOitIAcr5SPUsgDrmP+NlBwuZsb4
	xHYTNJpcvP2uMm+byuVwH9n9GjKF62gwwh1B5e+lPnNlBQDViLV1EYaqfM0l7YtP+NkHMX
	eS6tUyGP8a6VdBgYY+ezL9fe3IycUHXSEW+98gEoMSiYKjVMarym5Xqs6fvb5INqZZTO+a
	Wc/9266aZtAsIfNZYAVJhwZnt/aD7x+1sD9ffkmWDaorC7162kV27iH6b/tHoASWfUP8re
	iVezAsJjsY2/YbiK1DbPiSi7MgPFbZsDamdubFZuu7rN6GrEu8NqObCz3UHFWA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <dc169498016816be47233eb761285899164e654d.camel@iki.fi>
Subject: Re: [PATCH v1 3/5] Bluetooth: ISO: Add support to bind to trigger
 PAST
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 03 Oct 2025 20:37:06 +0300
In-Reply-To: <998ff7d8bb8c26f449ddc869fdd7c525b2868d19.camel@iki.fi>
References: <20251003153424.470938-1-luiz.dentz@gmail.com>
		 <20251003153424.470938-3-luiz.dentz@gmail.com>
	 <998ff7d8bb8c26f449ddc869fdd7c525b2868d19.camel@iki.fi>
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

pe, 2025-10-03 kello 20:30 +0300, Pauli Virtanen kirjoitti:
> Hi Luiz,
>=20
> pe, 2025-10-03 kello 11:34 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > This makes it possible to bind to a different destination address
> > after being connected (BT_CONNECTED, BT_CONNECT2) which then triggers
> > PAST Sender proceedure to transfer the PA Sync to the destination
> > address.
> >=20
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci_sync.h |  1 +
> >  net/bluetooth/hci_sync.c         | 74 ++++++++++++++++++++++++++++++++
> >  net/bluetooth/iso.c              | 62 ++++++++++++++++++--------
> >  3 files changed, 120 insertions(+), 17 deletions(-)
> >=20
[clip]
> > =20
> > +static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa=
,
> > +			      int addr_len)
> > +{
> > +	struct hci_conn *le;
> > +
> > +	if (sk->sk_type !=3D SOCK_SEQPACKET)
> > +		return -EINVAL;
> > +
> > +	/* Check if it is really a Broadcast address being requested */
> > +	if (addr_len !=3D sizeof(*sa) + sizeof(*sa->iso_bc))
> > +		return -EINVAL;
> > +
> > +	/* Check if the address hasn't changed then perhaps only the number o=
f
> > +	 * bis has changed.
> > +	 */
> > +	if (!bacmp(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr) ||
> > +	    !bacmp(&sa->iso_bc->bc_bdaddr, BDADDR_ANY))
> > +		return iso_sock_rebind_bis(sk, sa, addr_len);
> > +
> > +	/* Check if the address type is of LE type */
> > +	if (!bdaddr_type_is_le(sa->iso_bc->bc_bdaddr_type))
> > +		return -EINVAL;
>=20
> hci_dev_lock(hdev) here otherwise le may be deleted concurrently I
> think

Actually it probably needs to be taken in the caller iso_sock_bind(),
as it must be taken before lock_sock(sk) for proper lock ordering

--=20
Pauli Virtanen
