Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DA32C958
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496482; cv=pass; b=NSGXDrXLuf1dENbMHwmov6WWFPLAycyl1TtRJfRXS/7tNFsGKYR3Au6wreJiTGo0vPNyITLAqBHaLuJPY4XO5fDVPMlz9IH3HE6F+OkX3Po9y6dVoeOixy4THLOur+mC0eapAawk4tzA/FcxxOyDm3X+Ya68riJGIc6YQ7/XcYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496482; c=relaxed/simple;
	bh=mU+ub8VfcnqvUHGc5B4V0tDSvtJ21j0mdS1WrmFJyyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHZx0++F834mhreCii1Wa5FjzT459AK6JzQJe9OLGpqfCFYMGmZDVS9mA79Km8m1LdaNmthY6W2d5Y7Pb8a9UZHPoKDaH7pCgtrabkbmdASx2K1HaGoi7bH+C3UIJWO7Ko00ybYPoQE20lJQJkgu+xvR1X3cHoLgaUZMVgXFaxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=sFc5UFAe; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="sFc5UFAe"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dbG5z3fgWz49PyD;
	Tue, 23 Dec 2025 15:27:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1766496471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mU+ub8VfcnqvUHGc5B4V0tDSvtJ21j0mdS1WrmFJyyQ=;
	b=sFc5UFAeBgJrlBd7PY/JdfTcwXBpuGzSPqYe+LPMeWZiMSFg4keheBLZIAOCTpTFxs4JUo
	FZkvkN6VLQJS4p/GtiHZ4Hnmau6TSC/cx6HN9Yfl5dgbrCuwmydxmwtX4Cs4pByw88DtPl
	SeciD6RdYXzJ9PQrxU5GjQyunRalCifn7OvnHKK9ZQVMeFUiNnHooIj+QkscPF6bag45JM
	dhtHaKkaRkBSaf9dwC/9O6TtMaa2xcnJKEa/UM1yIzVkcFiCS2WsNHoU7R11zB8LWTHWi3
	4gTLW0IevydDc7xfTD40JGQ2Lq7/aD5xHHJ7lAesCJCzL7p/x2RDPz+2pL8MYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1766496471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mU+ub8VfcnqvUHGc5B4V0tDSvtJ21j0mdS1WrmFJyyQ=;
	b=RCC2zDG/gx0zL4ftmFdG2kWFfGMxcMDuiRjc5yKQSmh8PQ5zPtT0vGflBaUk8aQMICMCUI
	Yd84hPInBr6iMibdFfYoYvTxId+sx/sI9dANqjebcRQP7Na9V/dE6vXzumM/pMPI6kk1th
	sY4e2vTdbmgdd4x+eUP32MjL/c1YFd7i+k1Nrr9VOAkkGEhU6xOCG9gDjIo5TJ2kce4feo
	5VIsiny8lVbBytrvKfH6enfR9S+DDRhA/OpHoCxleivLI5VpAofe3TX4+5RKK1ekfyxcmM
	sio79Y2h5YZZZ+iKK/zcafph6rRQGMiNWUcHHefeQxO6FrKIBo32wHXv9XeE+g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1766496471;
	b=RIgE5ufRFk+ajzr+axaioc5SbEpNB4E/0EYBSdUXIs5Hv13yTdtrmq+ELbm5OQ1KZhTA8A
	RPn2sEV0GwJBaMoPgaEyp53Pl8XDXWjzS4sGdCvp81EqB+XuhexctMkJ7XSPzEcFNCxnS+
	iSn4KD0dGyKJhvkpoyMTkjjSYNT1Jfj8E9bXJ75MtsaKOQKbK0iMjEnW9HG9HweUzF8rM8
	YxN2sjxSY50gQ9UL/98zyYXLqs/LV2rA5R8zNx/DGZSBT6o07rT73CtzylSbj7kN6mvA46
	ejC9Fj4enBYBamnQYx46x8ICiDTiMN3tMvzD+3sfnm2VldWAhL64EpM6yEzRFQ==
Message-ID: <2051d4d464090c4a84d508e7648e9580f50c14a0.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel NCM865
From: Pauli Virtanen <pav@iki.fi>
To: f-tornack@t-online.de
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Dec 2025 15:27:49 +0200
In-Reply-To: <31553bc66935b6287f0723984388a98b5f720e39.camel@t-online.de>
References: <694a366a.e90a0220.1a6835.f67f@mx.google.com>
			 <20251223094535.91725-1-f-tornack@t-online.de>
		 <a0ee7d9d9451215a38cdf51c60691f3d4ab433ab.camel@iki.fi>
	 <31553bc66935b6287f0723984388a98b5f720e39.camel@t-online.de>
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

ti, 2025-12-23 kello 13:38 +0100, Frank Tornack kirjoitti:
> Hi Pauli,
>=20
> Thank you very much for your quick and helpful feedback on my patch.
>=20
> Before sending a v3, I'd like to clarify a point. In the bluetooth-next
> tree I'm working with, an entry for the USB ID 2c7c:0130 already exists
> in the quirks_table.
>=20
> However, this entry alone does not seem to be sufficient for the device
> to be correctly initialized in my setup (tested with a DKMS module on
> Arch Linux). I found that adding an additional, identical entry to the
> btusb_table resolves the issue and allows the module to function as
> expected. My v2 patch therefore adds this entry to the btusb_table.
>=20
> Given this, I'd like to ask for your guidance on how to proceed. Should
> I submit a v3 patch that keeps the entry in the btusb_table and
> explains this necessity in the commit log? Or do you perhaps see a
> better approach to address this specific behavior?

That's surprising, usb_match_id() returns the first match so second
identical entry should do nothing.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/usb/core/driver.c#n815

I'd suggest to double check the patch actually does something, eg.
change the added entry to `USB_DEVICE(0x1234, 0x5678)`.

If it does something it's necessary to understand why. Easiest would be
to add some printk(KERN_WARNING "some message") debug prints to
suitable places in the code to trace what goes wrong, or use some other
debugging mechanism.

--=20
Pauli Virtanen
