Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EB3B5F59
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758329; cv=pass; b=t2rqF7GV6CjVxkbeyHApJpu7sVPiQTW+rE2qo4l1vHdeAkaI25YuMVY6yhHALlIAB6vNR9NI6a9qbNzvG6pevdTDl3nWgIjjTz2nnx/Sh3FQ7d3psS0ad+q5gw++tTNaxj5R18FqmudAOp2s63ssBWrRu2OqLgy1FjdcKRLlRYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758329; c=relaxed/simple;
	bh=1K7U2u1HiL+hGC3pWr+icbyCJNHo/EoogqSuOiEzbpI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcXlqJ7657rQdqIb1BP/HzdcI4LkIYUshcdZZ7PyKOv1dbrJy6U91ylV7CjM20o/nMBL2UjpAzi+2n/9OknhOjdYwMtBdFl6CKj6mSy7jBIhpLZkXPDBQm153Y4zu0B9EV3LuIgL9Z3CNe7JAbTVll37vVbowtnq6c6p3kJG4tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=go9iEjr7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="go9iEjr7"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gGSph1x5Hz49Q5j;
	Thu, 14 May 2026 14:31:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1778758316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w18W0ppHYTGFlBVkNDNWrGpgA37cThZBUjoZzxNBQSk=;
	b=go9iEjr7zFIiZ5dLJb7RiRXoxviwrpOwdCEbNGIM+8mCCsOwGhltv4tX8sjLrz9UCKqtcI
	z5CNXJjlvYFz6A5hylJ5g8cN+75DpdG5GUkVjHJ+CK6MvozNimd77CCp5vYU8kxqcdoXk+
	t3xqnViDysDnpTECBus49ApaoVOgStoGn9bZdclJp5VJLZeVnZwdF3GcD3e1NrTlsdxiCp
	E0vxAi33CpMeDRHRFCrgAUQq9h/Oqnm+bFX4i9MLPCsiOfxxZVzSPrIQ2qiSVTvWIVmpok
	qTP14hTfWHWTmKfk9lRJllvL3AS52B5bwpXtUePbEZdwf34H7cE+E20sENV+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1778758316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w18W0ppHYTGFlBVkNDNWrGpgA37cThZBUjoZzxNBQSk=;
	b=G+kbedV0HO/V56vC/0x5CLaO802MtE8p4b1M54mwXy+o6ibLP8S2zb8guhLzdE0Xb4R+GU
	UCjEfhIRatkEVevxmXuN1Z9X5g2Kim5MQTHZbBvCxEvQRoJ3YAJLmHyLpFmHEpmTemsB24
	ikiTRfT7VJRzbirRbgWSHmx8qC3AlgXQ5oNH0Qm2IzXSti9lwuzQf5pMi3F3ttSz5fXpfV
	van6M5WRiO8OFSDkoFqGb0MlWxsnkJQuN6d05jfvCQco3XrRR3Iil/jbV/FP1lHEPUu1qc
	kWn7jE97HLarheoL/U9fvmlFn9F6yPO2cXkpCiOxq3Oa0oCZysFeTIyzg4X1og==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1778758316;
	b=M94bK47UvCmGfi543uOCAVmeHsV36I/VniwsyTdCKfftC6ABZOV/S5UFDawzvKVZHH//KE
	Cmu4euwVPNhfqBfA9HlJA9ftKToGQeP06QQpjCoKvDl2mATBwPWjWMSsbA4HyGgLfLX8w6
	UzFyukz4Uq6IiCB4ekAkQVzGRPcRmkFgsEb1sw7MmTLTSKCgpUJ5G2Lhio2jxt13a2czW7
	cWKcOZwTkjHchcynWFzUBTRQi9R7i5aflhw+qCYSUDJVPn8clCRLfE9sVQMn3nMmUTRKIZ
	+pUAm7pUYGa1CZyp5Ex4QWCdM3vqQr3qzNC6VrpSMe+LC6ejLhcSGqhJxrBkIg==
Message-ID: <3da9180c46e0b3651a3ee4d552bb5cf5f8b70186.camel@iki.fi>
Subject: Re: MT7922 does not work in 7.1-rc3, works ok in 7.0
From: Pauli Virtanen <pav@iki.fi>
To: Taneli =?ISO-8859-1?Q?V=E4h=E4kangas?= <taneli@vii.li>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 14 May 2026 14:31:55 +0300
In-Reply-To: <46f7ee10-3fa8-490c-bb17-5929229206fa@vii.li>
References: <46f7ee10-3fa8-490c-bb17-5929229206fa@vii.li>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2026-05-14 kello 12:57 +0300, Taneli V=C3=A4h=C3=A4kangas kirjoitti:
> Hey, this might be also a mishap on my side, not yet familiar enough=20
> with pacman to say with certainty I didn't mess up something (like=20
> firmware loading), but here goes anyway.
>=20
> Bluetooth is provided by:
> Bus 001 Device 003: ID 0e8d:0616 MediaTek Inc. Wireless_Device
> I believe. This is a gmktec nucbox k8 plus by dmi information.
>=20
> With distribution's 7.0 kernel bluetooth shows up fine in Gnome and I=20
> can connect my headphones and get audio. Using "linux-git" package,=20
> which built 7.1-rc3 (+ some commits on top in torvalds tree). Booting to=
=20
> it, bluetooth can't be enabled in Gnome, everything stays grayed out and=
=20
> no devices are shown. (I tried 7.1-rc1 earlier, which also didn't work,=
=20
> but I didn't take any notes back then.)
>=20
> The difference in dmesg is that on 7.0:
> [    6.152649] Bluetooth: hci0: Device setup in 173263 usecs
> [    6.152661] Bluetooth: hci0: HCI Enhanced Setup Synchronous=20
> Connection command is advertised, but not supported.
> [    6.216582] Bluetooth: hci0: AOSP extensions version v1.00
> [    6.216593] Bluetooth: hci0: AOSP quality report is supported
> 8<-- 8<--
>=20
> And on 7.1-rc3:
> [    6.270455] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
> [    6.270466] Bluetooth: hci0: HCI Enhanced Setup Synchronous=20
> Connection command is advertised, but not supported.
> 8<-- 8<--

This has fix pending
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D162b1adeb057d28ad84fd8a03f3c50cf08db5c62

>=20
> There are some changes in btmtk.c between these versions, but can't see=
=20
> on glance anything wrong with them, only adding support for MT6639.
>=20
> I'm not on the list, please Cc: if I can provide more info.
>=20
> Cheers,
>=20
> 	Taneli

--=20
Pauli Virtanen
