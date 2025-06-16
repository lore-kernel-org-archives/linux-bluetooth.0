Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3528851F
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097547; cv=pass; b=MiK2iC3kQ9yh0ZO88+Cd3VoC+K+hlRmMKOEL18oRqKK5phQbp/yti/qD6FyfdYEwJ2eK3URxhGECeBoFYk7xRd0SKIQJN8o73GJUL9lP3NKsLsth5aK4J+vftfq5TBAoqQAPGa9PL4h/6U5lNEs/7vHQmzZcMfCVZCCegayrN2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097547; c=relaxed/simple;
	bh=kG52W+K2XzYg4RsuRQJ5n849u6kSRgnUzFtIJipT3FA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aXxBUsRAI6Tx01g0kjbP1nw9LTnPuLbv9mibBoPhNqRe8p/AWS/RMn2cfaE2lgKcrjFxXwlfIr7kibph/oF3DwpO6KdWmQeiDg+pjQ6XIOLBvR91Lx/fpNbdkwhnRwTq5/vh27wpUBpIT+wEZBdVtgSTf7CarbDEZJBvRH3rhJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=LBQVccdO; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="LBQVccdO"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bLdPm3Qpcz49PyD;
	Mon, 16 Jun 2025 21:12:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750097533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Gvvw8JOVzbiflDg8O4r26/Cfo/IDdfnAJ78ZfsPjjc=;
	b=LBQVccdO4jAfkclbu68zU3/T6RLkxSlwiYJR/b01fbtIw/queV3oWrXz+YaR9XVfAb1d+O
	qy3Ldhl3NcR8mpLP6sOhScImwxkEwH6Vyp6vcyxMq2A8ODLSLHa8Mo675tm5UfFrdC4qru
	RhWxm+oUpEdb0HacO899WWyjdBd1Esnp1yfaQbn/riBawFgzx+dpyIoZ7wyoIrcoBwaU2a
	4t8g3tIZlljpL1K5sU9sG91ZvrQ+Wc94DFY6wJWjL504J1MxC6sUslxJ+JNSF3reFB4a3W
	7jLbaxR117SnmdVmHpKVTIie5ut96z3iDDcVJfh7UBXnMA7/sKUGJGAZI0gvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1750097533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Gvvw8JOVzbiflDg8O4r26/Cfo/IDdfnAJ78ZfsPjjc=;
	b=gtw/f51zrWYKVuVk+fMjIrba6G2coR+C64OkFzlgvXHYVMyw4BkY6YE5zTlChbOq9sHu5m
	fhX+4P0RmxsdORXcqgCI9PksBo7HkQ4nH+AYLZC3RFzDpgF1A+LTcdOiqoKB7dz5gzbduH
	96M94m6ueXspPIzuphWvyeOZ8nkUITsd4Be7XfkElsATl2SqlgT58Vhi26FyUB2Ae8V9HT
	Odplvjkru5NcSYHshVIanKp74nX5gZOabIvofZHJVxFu2zRPLA7gUC7s1udSjx3gKGE1HH
	PQhA+gTo12xLiIVOLiAl81mLksEEEcHwS0ZiGvMP9hvDFNY5LQ8PgiczqvtyeQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1750097533; a=rsa-sha256;
	cv=none;
	b=Ww0DToU27MCIwMLH5u2z/XnTcRH97/lc/RuzpWOAmic9F/tEXRG2ADVH9YvgWXzf4gXwCS
	YaPbIPW0BQaateAoqlI9S5geA3h8EE1ktik3C+WugUmuz2Tcv2GNjrivcwkqBp8AM+zxyY
	jxXZHZ+AOBIBu0g35hRpBEveWMuqsSDh6ZhT25LwFaqcZn09mub9MXgnTHoa3nFhiX+fBf
	p3tmTOt/hvkcMsHu8bNlH1mg01r0nQuWKSSOHIpZH2ukITH4UsiTY0HOdI/HMr3Hx+jkdz
	UXmXnsVZz6Fy1w2QyHe8eq3+ftKZI/d0UughcYLaZSOF7m29TJcBPDUWZX2fmw==
Message-ID: <b964dbbad90d2561b28386d6d254048596d0897c.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in
 vhci_flush()
From: Pauli Virtanen <pav@iki.fi>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Date: Mon, 16 Jun 2025 21:12:10 +0300
In-Reply-To: <20250616173803.928382-1-kuni1840@gmail.com>
References: <20250616173803.928382-1-kuni1840@gmail.com>
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

ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti:
> From: Kuniyuki Iwashima <kuniyu@google.com>
>=20
> syzbot reported use-after-free in vhci_flush() without repro. [0]
>=20
[clip]
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 07a8b4281a39..d648b514e2df 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> =20
>  /* Get HCI device by index.
>   * Device is held on return. */
> -struct hci_dev *hci_dev_get(int index)
> +static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
>  {
> -	struct hci_dev *hdev =3D NULL, *d;
> +	struct hci_dev *hdev =3D NULL;
> =20
>  	BT_DBG("%d", index);
> =20
> @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
>  		return NULL;
> =20
>  	read_lock(&hci_dev_list_lock);
> -	list_for_each_entry(d, &hci_dev_list, list) {
> -		if (d->id =3D=3D index) {
> -			hdev =3D hci_dev_hold(d);
> +	list_for_each_entry(hdev, &hci_dev_list, list) {
> +		if (hdev->id =3D=3D index) {
> +			hci_dev_hold(hdev);
> +			if (srcu_index)
> +				*srcu_index =3D srcu_read_lock(&hdev->srcu);
>  			break;
>  		}
>  	}
> @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
>  	return hdev;
>  }

If no list item has `hdev->id =3D=3D index`, doesn't this now return the
list head=C2=A0-> crash?

--=20
Pauli Virtanen
