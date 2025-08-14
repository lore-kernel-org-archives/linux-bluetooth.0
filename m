Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265AD321428
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185212; cv=pass; b=dAqUT1grr3nQWzH4r+g/uxxzWERq5tkrgKmKEvn9HxiQ6Zpv/RTc6vDTBRy+bmF2R/Xby56Vkciab+Y5Y0vC/xgnlhH34OiWYCBxrjNJAdK/LJxIEKxyKa/AY/F2yuCuecMxB/lRp8OY3MN95HvprQu5euQsMiUaMwnhgo4bkrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185212; c=relaxed/simple;
	bh=vDkULUkg85QIuM4014QMSChiWqci7DaikJS9Udj8wcA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kiz6lPnTjuzeBKm4mODqvCzvUPwtTEzV7kvPnhZ9wcXFxH9n6NCvtY0hbC4EEQYfW32DTb1krhYRk0rcp15Y+TpmN2jIORMA/B1l2ex6aD70nUKvwas48DtJjt65bRAZCn7g8NFzZXlV1jN6G+rmmhnrsOHjfXd4GrsrqhLE6jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=gIzkeUl6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gIzkeUl6"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4c2pxR0wB3z49Q5Y;
	Thu, 14 Aug 2025 18:26:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1755185195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vwF6sCoR7/RWEoWcJYLH9F6x4t+TGvYmclD70ue5kys=;
	b=gIzkeUl6CzI2bxH3HfrG1i08Lt5b9B7qztJ3nVD19idoGtYupF9FZ+V3wj3L9gBbZzSTlr
	Cor3tkXEpEfMscSn1/MseVzYCwFZdjvxG7G8zHHb+cqbo5wM5fFvgDZuXvVFQ6lilWe+VM
	qEAchjIM96o0zod+8H7njfS3oB0tvpq3mHprW45ApkhE/JdtYR0WEHHAMiGpIgoKJUHRrZ
	WjOoCpvKhcPYmznl4UkHWXiaNwRhCU2UNfQEnZUoJmEwamJnLzflMvZ+osFvMQg0NoLM0t
	p15CASOhekKe5yJ/HBBUWnIgsckkih1DNOE9rKiuJA/iuRh0h1atZAXbidmeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1755185195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vwF6sCoR7/RWEoWcJYLH9F6x4t+TGvYmclD70ue5kys=;
	b=AlwoKY5Bcp2uFjtU3DmwlVDWG/c2l+qUKYGg8G2cuFM4mwm2OUnjSrqqUCd4hGfrKtWCaX
	Heqjl26Fabiv+J4QlD20dREHi/YCxa+qLOLd/VhsskSB4SpiI75p8EsvYq3ylSGUPMRc/r
	zUx4YmAaiW331ga0K8lg7drSZq0vhaD5dUO4rd5QfhmEjC70/+MZwMnWjj9pVBybMATaPF
	DbyUmihxG/mDQZ0HwKVFyNd47SqszsxITvgEu2094qm0vQYGxJj9QO4/v3jfXWC/0gy9LV
	LvC5CaTfsHsuks/EVneK4kfHKZb9YB60rGBRJDBahUezu3jwFALKL4JmGMNtmg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1755185195; a=rsa-sha256;
	cv=none;
	b=krAAlvIe0WisiKFQtQ1soNHgK+H97R1NEbpwLZumFAEpCOUmpJQlwxA7RlMvOnp6V3BgR7
	7Wk19FBS1nuxiBdev9hIou1hQX8gVcSoNdXFbOSdMCq1u0ADQhtV3RyZti6XTmrA6yT9xS
	FfZI1bZb+tLx8W3gGqFF4/wx3JloRMv0H51BAAsE4xSAEjoFaVOyp3+nuSXQ2kRcx8RIWK
	evMt08dbKIW3na66bEYpPjBhhgCzlC3r4kHALCp03tCgilzYBg6bOOokKBkCi+AA45KnCr
	FuVMD6zZe47c9+02N4iJvxpDtLvYUmgnsyXnksf38D2uKNP9hbtqVTkOc4x2hA==
Message-ID: <09686fe95fd6d79c9b271d6366bcd6dc4f890480.camel@iki.fi>
Subject: Re: [PATCH v3 1/5] Bluetooth: ISO: Don't initiate CIS connections
 if there are no buffers
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 14 Aug 2025 18:26:34 +0300
In-Reply-To: <20250813211511.90866-1-luiz.dentz@gmail.com>
References: <20250813211511.90866-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2025-08-13 kello 17:15 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> If the controller has no buffers left return -ENOBUFF to indicate that
> iso_cnt might be out of sync.
>=20
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/iso.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 5ce823ca3aaf..dff3fc4917d6 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -458,6 +458,13 @@ static int iso_connect_cis(struct sock *sk)
>  		goto unlock;
>  	}
> =20
> +	/* Check if there are available buffers for output/TX. */
> +	if (iso_pi(sk)->qos.ucast.out.sdu && !hci_conn_num(hdev, CIS_LINK) &&
> +	    (hdev->iso_pkts && !hdev->iso_cnt)) {

Also && !hci_conn_num(hdev, BIS_LINK) so it doesn't fail if a BIS is
saturating the buffers?

Does PA_LINK have ISO packet TX/RX?

> +		err =3D -ENOBUFS;
> +		goto unlock;
> +	}
> +
>  	/* Just bind if DEFER_SETUP has been set */
>  	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
>  		hcon =3D hci_bind_cis(hdev, &iso_pi(sk)->dst,

--=20
Pauli Virtanen
