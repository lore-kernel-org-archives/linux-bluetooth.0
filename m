Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAF127453
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487356; cv=pass; b=uOfOoVTeeoppaK5JBIUmuJ0yEdemU4/QIOX7y5u8TLGI0BIKLVsZEBLBoRUM6dgumBAfsSJ6Ieeen9cbUmY0IpeN442vocBDmZ/yBBktDyZMnZ+Tq/UQTc+5lbkGDBUDgzr2qXAT0VFP6IFkS782pq7GrTd63mEzd10CQ5ycKl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487356; c=relaxed/simple;
	bh=rdeNGdh7v0rV1LfuC3DiIatWjNbMQl40M1nB7rm/6+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uvrl52Mkf4uUGmrjeJZ3QuDM2+x1RcfrDp48bxN22ESDod5ffQpIk76iNoCKxsZHhP64xo1McxZqQB9AsjVBiUdXa4My11FvXE6VfhiJvHARRlA7752+nB0YXoIfz3Bw1kx9+cQJ6CVVhrOU+mBzVROsG2uE+A4PEZNqMwJTyh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SGfpKUUY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SGfpKUUY"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dbBkS2lS6z49PsK;
	Tue, 23 Dec 2025 12:55:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1766487344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R+fhDpl7GLgHFUZHucUBamGboOCE+6rGWq8C1mAW08k=;
	b=SGfpKUUYyiAVaBvtNC3UxEuEXlk7mPeoEH5RRRueOR5OdnTkGT2aZP7arOJicRq3tdkY13
	T46SQVtbqmSeTPcnHc3egil2Q6bzlaG330JcnHyvTA2nWplDq45rGVwQIQM+7tmL3ocjc/
	0mucdVUvF9eVGBP/eyFjsMdvkDuiKRepujPCLfuf7FewvPG2TvXatcGzgsYQtubsL5+JPZ
	rH7Fa8D0NeF1C7quIBf0STi2a6eGsArcM/gmJHkkm2BbTLrXzRX0YYhKJs3/YKTTHNU1PX
	lfnaoWzTThm1/2NhE4PqtT13/rPJbaA8WN+ILhDU+5/RQGkKxDQ7b3ayHmU85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1766487344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R+fhDpl7GLgHFUZHucUBamGboOCE+6rGWq8C1mAW08k=;
	b=wIl/6voHXaOq2G+nxxuIrYWSU5hNXfEMadwW5vXzpJh6mhCdE3RZwI0HHwLoU5ApfP/QIX
	ES0PMIgi+lCH/4t7Pme1sQQVP4ojmeq6vk6y7w+F8IssFg0hmz0L/Zctrm87pGjTxdbQK7
	9eWJc/jbQOY3suW+0ffs0+hEuumSf9IQRaETB6VQ0bp+aaEJueNPktbgZdrZbn3xOpYo0f
	Cw5ImKfUa1v/dxVG2t72Pr8JI4V0y8DpclmgcvBA0xpC9w5OrB3oDUQKZLXUMhOcGKf09L
	Nxrlx+f7mAv6F5LyorvMfXhVUvrFpWBNYBor+KPUKbNoN2uPvyjjXnkC70ycQw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1766487344;
	b=kyZYEmHGeP6PvATmuBTqOupKMJiGQnAum/LLNczViR7QzxIf11RpxQZWQu4C24VWRvz0/l
	f03B35jR5QPJCQ9TfbRBDppaBQUfVPzOqBkj4exf4z7JVV5QkWDZ/rLH45wrZCJsxO9L6p
	EOZ2MIjE+HzrUgHf50JiuPWePfXe55KdJXe3nirijtJC0zkqZeeM8ZJAxIlos2jmruyY6t
	itsBkn9euQCuNkz8BpMQAeigeh+UT78yCc2MihQewqryYy6tWy3UUabpK6O6KGIGQJ6OWL
	YhviulE8jytprAio5ve6X6PCzhvS+Qha7zKebWYW/YBtHPN4i6jBMpsApB4GMQ==
Message-ID: <a0ee7d9d9451215a38cdf51c60691f3d4ab433ab.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel NCM865
From: Pauli Virtanen <pav@iki.fi>
To: Frank Tornack <f-tornack@t-online.de>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Dec 2025 12:55:43 +0200
In-Reply-To: <20251223094535.91725-1-f-tornack@t-online.de>
References: <694a366a.e90a0220.1a6835.f67f@mx.google.com>
	 <20251223094535.91725-1-f-tornack@t-online.de>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2025-12-23 kello 10:45 +0100, Frank Tornack kirjoitti:
> Add the USB ID 2c7c:0130 for the Quectel NCM865 module to the btusb_devic=
e_table. This device is based on the Qualcomm WCN785x (FastConnect 7800) an=
d requires the BTUSB_QCA_WCN6855 flag.
>=20
> Signed-off-by: Frank Tornack <f-tornack@t-online.de>
>=20
> v2: Fixed merge conflict with current bluetooth-next HEAD.
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)

Changelog "v2:" should go below the "---" so it's not included in the
commit message.

/sys/kernel/debug/usb/devices excerpt for the device should be added,
see for example

https://lore.kernel.org/linux-bluetooth/20251210202225.135637-1-elantsew.an=
drew@gmail.com/

>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 646de80c7..70feeb9a9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -172,6 +172,9 @@ static const struct usb_device_id btusb_table[] =3D {
>  	{ USB_DEVICE(0x8087, 0x0a5a),
>  	  .driver_info =3D BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
> =20
> +	/* Quectel NCM865 */
> +	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info =3D BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
>  	{ }	/* Terminating entry */

This should be added in the position in the list where the other
BTUSB_QCA_WCN6855 entries are, trying to keep them sorted by vendor +
device ID.

>  };
> =20

--=20
Pauli Virtanen
