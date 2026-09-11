Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBA582B98;
	Fri, 11 Sep 2026 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156605; cv=pass; b=gKCqJYzk2mQWJvdFW+ZuW9ZJZe0COvL8sc19q6C8M5am2BUJ3oRVmDEf2Ej4tA/Y6YZuyAEQ112q145zNw/viDKL3Y4NRQYazLOnre0SOH+wuai6ak5WRe36VZYPUoKoFcC2w6uju94wnBbnr3RaRM4cQ57NMnPmneiaZp2CbnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156605; c=relaxed/simple;
	bh=UIdudTzdNH4gipP1faAe+Hnlz/Hi7ayLLCa9/fXfE84=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sObP59YepN0ktvH/pVlksSUK9T8GZ1SX3UzizbNnBXCYaks3h1WIxjcvXO38PuRrHRC7peSU5UlvI+2VMz73rBMLXufXP/PYewkvz2SA9EbvIHxcPkikDA0q2yw5gjo1VkilDs89LqS+e17cRAjCFUNAFd0Ri2uv1nCOy8+Hu2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=kUu1r14N; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="kUu1r14N"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:9::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hhQKD4JH8z49Q6x;
	Fri, 11 Sep 2026 22:56:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789156577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0MV3Gx0q4t6grnOE1aiY7WQIUKmmgDhyNhU3Q0wrZI=;
	b=kUu1r14NHPTBsd5ckVhGOKkmsR2IlDdTVfECjS+NXjj0dUsdS1XIjIxmoG3y6ezDIxshsF
	hY9ChQzdaHejyEKHvDoCxWFhLZOhVDFj6dLuwyT7imORcDrvnFRRLynANHkBDfzoL7kV1a
	FwMkVL8HJyhILcZDz9SeN1a7ZHkWY95CumK5z+38eNsrvgdEBkgQMFImUPhzmam7kIFQhH
	1vT00GfSC829zvPPeYxk2mjaCEiXXbcl92dIzX04oXDWuIUlnTiqAJFowjjoF02rqaoRDg
	SUOMYAk+TZpHgjiwxLSclSNQDXOv4qFiuxFjFP0qLuG3CiLID/4ZkOBL3nWcgw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789156577;
	b=nMGMqgv1u0Cdpfx/7f/p3qhj/yIoI/sNCzzI29TC81z8k5VQypwAuHto0vWvt0zsNqTDEJ
	06d9e41FHxk78kZlKShv6ZDiHxsUqd5hIGhPKIgN5HcndzjMcOk8YI+qOXZ7FugUWtrNk+
	Pqs+YUTvFeEcYPZBq8t89uzg6markwkvL0Rg3/miyr6KlqfIo5+9PFK1m8vuJ2261HUcKr
	8mp8v5CASYkMA+2VQLq2Cxhyxkp8CycDech8rk1GcHgYGgtrBj9QrHLySIBHcGEFXMTnMJ
	7jMcfaLh1iIE1WTQBgkIn6ElpekAAja69ghRQHYNSO4uAIDQtEuZpBsAwge/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789156577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0MV3Gx0q4t6grnOE1aiY7WQIUKmmgDhyNhU3Q0wrZI=;
	b=J2pz6OnCrDmvJa5duFBOaBFB9wQmOd28K9D74/dcu1z/WN2/awI/t3JWs6H6/6tJM39Zfu
	phpjy3YpqejtgQLfsXLduTARNMq70VlaKj7YCBiUyNyX6eSk4nwiy4tOPXq++INPq1LWjV
	6nTfF2zAXAX7per6pE86ETJ63OJD9EgX5/MimxZnDKnX/m9cWR27jAueP+GtrLQ7psREel
	KJcBkOnxrr5W0lhuq/YawtlB1s4YjDFRZvSX5qurJvIBw6S2Q9tMkCEEdwksrkOIVn4RHv
	3B0JpUQbgRbJ7IApV96xKzOyx8mxhwdalKUMmqIVLf7egkFtF1Hmw11nmdaDNw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <7bfc5ec0438b830386ae2899756bb9a7c4b9e123.camel@iki.fi>
Subject: Re: [PATCH v5 4/4] Bluetooth: btusb: Add support for Qualcomm
 multi-subsystem QCC2072
From: Pauli Virtanen <pav@iki.fi>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>, Marcel Holtmann
 <marcel@holtmann.org>,  Luiz Augusto von Dentz	 <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 22:56:14 +0300
In-Reply-To: <20260911-btusb_qcc2072-v5-4-422754f4e938@oss.qualcomm.com>
References: <20260911-btusb_qcc2072-v5-0-422754f4e938@oss.qualcomm.com>
	 <20260911-btusb_qcc2072-v5-4-422754f4e938@oss.qualcomm.com>
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
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2026-09-11 kello 01:00 -0700, Zijun Hu kirjoitti:
> QCC2072 has a Peripheral (PERI) subsystem to support the BT function
> unit, the transport wire is owned by PERI and carries both BT-HCI and
> PERI-HCI frames, as shown below:
>=20
>                  _______________________________
>        USB I/F	|	   internal link	|
> BTHOST --------	|---- PERI -------------- BT	|
> 		|_______________________________|
>                 (other on-chip subsystems omitted)
>=20
> PERI has its own command/event/ACL traffic, memdump, and firmware
> (PATCH and NVM), all different from BT's own, and BTHOST needs to
> interact with PERI directly.
>=20
> To support multi-subsystem controllers, add btusb_qcom.c/.h as a new
> transport-specific design:
>=20
> - Multi-subsystem memdump collection.
> - Generic PERI event handling, and sending a PERI frame then
>   syncing an event sequence.
> - Downloading PERI firmware (rampatch and NVM).
> - Recovery on command timeout or hardware error event.
[clip]
>=20
> +/*
> + * btusb_qcom_send_frame - send a frame for BT or PERI
> + * @hdev: the HCI device
> + * @skb: the frame to send
> + *
> + * Implements hdev->send().
> + *
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int btusb_qcom_send_frame(struct hci_dev *hdev, struct sk_buff *skb)

This one should have __context_unsafe(/* conditional locking */)
annotation, or no if (need_lock), to avoid warnings on LLVM 23.

> +{
> +	struct btusb_qcom *xport_data =3D btusb_qcom_xport_data(hdev);
> +	struct btqcom_data *qbt_data =3D hci_get_priv(hdev);
> +	bool is_vendor;
> +	bool need_lock;
> +	u8 pkt_type;
> +	int ret;
> +
> +	if (qbt_data->category !=3D QBTC_CAT_MSUBSYS)
> +		return xport_data->send_bt_frame(hdev, skb);
> +
> +	pkt_type =3D hci_skb_pkt_type(skb);
> +	is_vendor =3D pkt_type =3D=3D HCI_VENDOR_PKT;
> +	/* an empty vendor packet has no path to reach here */
> +	if (is_vendor)
> +		hci_skb_pkt_type(skb) =3D *(const u8 *)skb_pull_data(skb, 1);
> +
> +	pkt_type =3D hci_skb_pkt_type(skb);
> +	need_lock =3D pkt_type =3D=3D HCI_COMMAND_PKT ||
> +		    pkt_type =3D=3D QPERI_COMMAND_PKT;
> +
> +	if (need_lock)
> +		mutex_lock(&xport_data->tx_mutex);
> +
> +	if (is_vendor)
> +		ret =3D xport_data->send_vendor_frame(hdev, skb);
> +	else
> +		ret =3D xport_data->send_bt_frame(hdev, skb);
> +
> +	if (need_lock)
> +		mutex_unlock(&xport_data->tx_mutex);
> +
> +	return ret;
> +}

--=20
Pauli Virtanen
