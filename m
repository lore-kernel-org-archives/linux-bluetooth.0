Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794919021;
	b=MqNiE/h3gitRjSoD5VnrfeJ+5XFLRiyrjNHTBEWlE/p2cgNcpd7czrFoUgfh4pn7SLDK
	 8GBa6Q9MJhREjqNwJO1sZfeiRGa9/7dWlv7ft1QHKPaZUj29DCfcGEx3MxjQrkUcRL1tW
	 ubkaxPCcJAj/8mUjo57AiAnpmObNYuCWLRlzcb6SxdNZfhhye6q+LqxpSuR01qvdN0gP/
	 WkbvM3w7IKdMehrF08emiwyYb6hbFula4xPyohqERVtY0PeNHOZt8Jkf7gaIMQqDhINut
	 YcB/UZiUAb/VBf7Fmt0pc2vhhCtSraBZ161LrXJ5au1OnBwnziTctgFeqt6Y3CRqVxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919021;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NXoozk8hY5S7C64sMTmSgvZ8u04sTsb6y4F9y+Imp+Y=;
	b=dm0air7HpJ2y7Tos/bPLi4/4ziVjMBpHmgfS95s+IGIY1tW0HmHsJaESNtDSygIARoEp
	 77X8nRhMtwhHJbmqHuUT+4TJhBlLFmO3GnBhZNfv35I3+d5VfqnrVKpZHwsDt5+MjIrEp
	 6LvW6q1p0c7nKtYrsWWC0vy/5QzFqAILhu1RdaOof896Nu5URRSoqbF03il9HiVS9OxYu
	 DCb7fbFXnFYUy5VfRqDwlvmWetcwAfCcpRV8StrVz4dcTxI9nDq5wFSOCgajHi4ZYwZlM
	 yCp8Rm8Bikd1hXaRgdLiAQ8Cw/PyoZdhaDT1IHADn/W0oYksZWs1MIT9wdDsUSPclLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RofesBBr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17723606A31C;
	Tue, 17 Nov 2026 12:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17723606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RofesBBr
Received: from [127.0.0.1] (unknown [IPv6:2a02:560:5d79:c700:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1F1AF201917;
	Tue, 17 Nov 2026 13:36:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794919018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXoozk8hY5S7C64sMTmSgvZ8u04sTsb6y4F9y+Imp+Y=;
	b=RofesBBrDx3ZuGMjyBJUn+hlTiGsBn4cOYS07FDLgzGPhT5TlWb70QKvYANvgAfoaIkL7O
	XMD8BPTGzW+7ob4YNRBzx2Br8OvDRWjsY5m3fWh9992QP+nLbwFxaIoO5viPpUAyTo/pUJ
	jh0T7wmpYm++rtq5uIpZ/D1/LGeF0GIrc/75KNymUrzNb89bBmXjYP7THU5mp5HxfkkAkm
	O98HV1wsE03u4qMAPRsT/4KSIvMXku2CLySK6Ede9Z3o8DeQob+T5LBH+/WxIt+bUnmKVX
	adpf47AfNu4kx/2Am1a2Fp/Cw3NM711EYHllEvRZlxNBOj/fyr9Y7HDFv8U56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794919018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXoozk8hY5S7C64sMTmSgvZ8u04sTsb6y4F9y+Imp+Y=;
	b=Ra5aNu5wXGsGFzI2wi77v2EQ9UwBQ34bypx+S+cEhAln1XMWkr5vkHCAz6Z+Adtc7pTRNI
	Mmex2fqQ756zAWIc/7lxctWVH1v9nWCFu9u3Xz3G+Z+Ux2rNkEhl5SbQkKlMgaGd8KvoLX
	U64jv0VYINZFspv0HtCm6jo1xiByiUdP+NisPhibOoJDKZ4pxUtcJRaQGsED8pYElBmNg7
	gO1xMjIQ6FQOHqOvtmpeinVtjLnUz+VrwhN5ZS2jUr4rYIYgx1H+6zfyTgg7Wihfz8hL11
	f9R99jSFBPwO4QLvAVE3xm6YtoowlhMIhbBBR7PVseIZztIltqpamEMYZuQSBA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794919018; a=rsa-sha256;
	cv=none;
	b=JLcwyPFLprBIk7JcRQ3mKInKxj9NjxWIHdjekg9eWliw4wJN64/c0YwjgKHZdtn/BajVgG
	JaA3e5ui9M+D8ir1qavYkUd8GL6GOADVj4aZZiFYhUrNlfsKv/KrrMqcE0GpojFOTqXUnu
	DYl1BbkuTzww1gfx0lkCd6UWA8FFfv9xwhPgyNmYuKNJ4u7ufXKh0NvNfjYHGOUpaEBSTi
	Jpwop9dC0zF03343XWELWspYGymQlwfAbq5bIR8RZVnJfWk85JWGGgXFo2YNshv+jJNyVm
	FZtN8s8RdEIiLzg1oYlH8nxoZzHW+8d+WjbtRlmsYv928yqy5hZ+OBbR48aCYQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sha@pengutronix.de smtp.mailfrom=s.hauer@pengutronix.de
Message-ID: <d7104aac-2efc-4e82-bd12-669ed7fd47fc@pengutronix.de>
From: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/1] Bluetooth: hci_mrvl: Leave the serdev port lifetime
 to hci_serdev
To: "Michael McAllister" <me@michaelmcallister.org>
Cc: markus.probst@posteo.de, luiz.dentz@gmail.com, marcel@holtmann.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <179467295519.97469.5747232754111917783.marvell-serdev-v1-1@michaelmcallister.org>
References: <341e56b1ff7d8a5b109e26e30dfed61faa54d603.camel@posteo.de>
 <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
 <179467295519.97469.5747232754111917783.marvell-serdev-v1-1@michaelmcallister.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:36:57 +0000
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list

On 2026-11-14 16:15, Michael McAllister wrote:
> hci_uart_register_device_priv() opens the port before calling mrvl_open(),
> so Marvell opens it twice. Likewise, mrvl_close() closes it before the
> transport closes it again during unregister or registration error cleanup.
>=20
> Remove the extra calls and let hci_serdev own the port lifetime. This also
> avoids failing probe when serdev rejects a second open with -EALREADY.
>=20
> Fixes: be70e5e774a6 ("Bluetooth: hci_mrvl: Add serdev support")
> Reported-by: Markus Probst <markus.probst@posteo.de>
> Closes: https://lore.kernel.org/341e56b1ff7d8a5b109e26e30dfed61faa54d603.=
camel@posteo.de/
> Assisted-by: LLM
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>

I don't have hardware anymore to test this on, but LGTM

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/bluetooth/hci_mrvl.c | 14 --------------
>  1 file changed, 14 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
> index 5798a8db0..def19907c 100644
> --- a/drivers/bluetooth/hci_mrvl.c
> +++ b/drivers/bluetooth/hci_mrvl.c
> @@ -57,7 +57,6 @@ struct hci_mrvl_pkt {
>  static int mrvl_open(struct hci_uart *hu)
>  {
>  	struct mrvl_data *mrvl;
> -	int ret;
> =20
>  	BT_DBG("hu %p", hu);
> =20
> @@ -75,17 +74,7 @@ static int mrvl_open(struct hci_uart *hu)
> =20
>  	hu->priv =3D mrvl;
> =20
> -	if (hu->serdev) {
> -		ret =3D serdev_device_open(hu->serdev);
> -		if (ret)
> -			goto err;
> -	}
> -
>  	return 0;
> -err:
> -	kfree(mrvl);
> -
> -	return ret;
>  }
> =20
>  static int mrvl_close(struct hci_uart *hu)
> @@ -94,9 +83,6 @@ static int mrvl_close(struct hci_uart *hu)
> =20
>  	BT_DBG("hu %p", hu);
> =20
> -	if (hu->serdev)
> -		serdev_device_close(hu->serdev);
> -
>  	skb_queue_purge(&mrvl->txq);
>  	skb_queue_purge(&mrvl->rawq);
>  	kfree_skb(mrvl->rx_skb);
> --=20
> 2.39.5
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

