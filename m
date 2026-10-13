Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94D501F4D
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904009; cv=pass; b=CikHdPVO+ey3cqgF7gEBylYr040nrU7BsXS0E2AV/4zxGLXSb8U4+FepcFqcEDQyWGUUQcnkY83rNiPzhB7zvcsKL5EHn/yjk31G303Kwr4cbdsY5NUbn+bIcEYdd+hSOnPDPVAUG6P7fKwKbAZ/1iF0xmBGT2qreCxOosDSVB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904009; c=relaxed/simple;
	bh=4mZZyrx79ceMPFnWyqkyBHOPmLzkFgbakmXb1z+aQtA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H97AimjIYvy93GEaxD3j1QXp8LWi/bRG3xSgKKRaZ88O1n+6k+pcuWEPUQo2+8bKoGN/hRxpnpHozxOP6j4mpTkrFzN74iYNPoqBGvzbACVfxZPtnoQ6AjLKTFbmjewTF9ZWX637bdvGPwzQ92/EpPMdkukp3NaVyoNFha7qGe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qO2KNlgP; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qO2KNlgP"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:e011::d201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4j3yN94QlZz49Pxq;
	Tue, 13 Oct 2026 18:06:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1791903995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4mZZyrx79ceMPFnWyqkyBHOPmLzkFgbakmXb1z+aQtA=;
	b=qO2KNlgPwTFoBdkREsiXAhqCl9dPEmRxoe5vtp3IOqixyvvtct8qx2v1mdqV8IemaMArfD
	7DIf2NQ/yMObCjDWjzzb4B9ruWlfLk19z/RPLf3l+SiP+Y9RDBpOUCH3X8Xn7qZI7YuE1O
	VSzcYXyLJ15EuYdqhNh8BD+3kN3MA+IUXxK/N9EDtks0rNzT5u2WAt+h8+HzGpBFXE6rF+
	uYX/cvkrzr9z9opoDkF+iup8Da2LCTNF30weSAMcgLFkyOumJnZx2+sjY+l69YGi8atyFc
	3yr6KgozlEmjjnyT3AisVHnpvtDA4w70+EcXEfEhjN4lGcGl++ogzVOQKis+hg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1791903995;
	b=qWsigQ+/+d7JDcN5HT4WPo3A+oH7TC2bv44V/GRDzngCFkGlm2PfEYTRU4d1yC5lQDXakn
	XXv/6wo3vtuLge043RNvP+XvruE5NCSkEpFroXu1GCP3yMKvH04Dv3nt78fMh3wa7a8Gwi
	YnbPaak1q62bSo5XXHUTrBQUfYHfiEOlsx+DjD2YDP4tXuTsLhw/iy7My/1xgqNSgICneZ
	3iIIqkZWNdqn5gvZIOlhWGFT6m4jVFmm9UI9FY89eSEElZAAjS90kyypJHy5MsGUzGxL6+
	NeMRaLdsPI7ippnIp15kghdFPkGwh/uPoOkHPDguGJJpdjOcaHl+tsFkcvwUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1791903995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4mZZyrx79ceMPFnWyqkyBHOPmLzkFgbakmXb1z+aQtA=;
	b=AOoay+bR2c/cCELTNBGD8DB03mL/iGy5v3+EmVw3iZWcxu+X4AU3MyPGdJnxbbqlNYEFY6
	46fzsTBT53b1/8m8VUpfClffxjrATcKfTyuap/CBjG5Anx8qUpmmY8tGuON31IRPj4IVmN
	Q4F1jRlU9QEHID7bszj0gavov42MEdYFj4Tb9/cgm/TSwUuMIeGcXXqOd86kmGMAiJ5/9K
	viTt2Lpj32ngb1umew8Kal+bcNZNQoZCxX6frsdH9Q/oik8LNEyoDTTnLtxJwBKTzMlDe5
	eISILY1X9adg1528WiRaLuPugAKaE6qiNRQpyTEwsiIQ4yv6yZV2WphWkfj2+A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <52da32edbb99f514d1d60265ad16034a6ca637dc.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: btmtk: don't generate bogus ISO packets
 from zero padding
From: Pauli Virtanen <pav@iki.fi>
To: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
 "marcel@holtmann.org"
	 <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, 
 "linux-mediatek@lists.infradead.org"
	 <linux-mediatek@lists.infradead.org>
Date: Tue, 13 Oct 2026 18:06:31 +0300
In-Reply-To: <J3DTIOm26VPmRQxbaFuf_tTRFcN5sTc2wkM_6mtmgidrgPnZc7pgqR-LFI9BxR7grHfdq-H4BieuiZ5Gwa9_Qb9nDVQfN0KhREuXSFBlNbk=@proton.me>
References: 
	<fp1LLpMjte31CZfdRymzNx8DeLqozYHgFf2TAKxtIiHEkPcykA5jgtuDuZYcJTb5vPGpPkgB8GoVoX5_821oWe9NvenZdL4kwrxyCuanlw8=@proton.me>
	 <e4b4da9d018ab26c5376fef47476b8852222eb07.camel@iki.fi>
	 <J3DTIOm26VPmRQxbaFuf_tTRFcN5sTc2wkM_6mtmgidrgPnZc7pgqR-LFI9BxR7grHfdq-H4BieuiZ5Gwa9_Qb9nDVQfN0KhREuXSFBlNbk=@proton.me>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2026-10-13 kello 14:40 +0000, dt kirjoitti:
> Hi Pauli,
>=20
> Following up on 24 September: could you refresh/resend the MT7925 padding
> fix? If you are busy, I can prepare a refresh preserving your authorship.

Mediatek people appear to be working on it, and likely are in best
position to fix it as they know the firmware,

https://lore.kernel.org/linux-bluetooth/20261013081823.817996-1-chris.lu@me=
diatek.com/

>=20
> It is still absent from mainline, Bluetooth-next and stable v7.2.9,
> checked on 13 October. Our local adaptation removes the phantom handle-ze=
ro
> ISO packets; upstreaming would fix that parsing defect and let me retire
> the private driver rebuilt for kernel updates.
>=20
> I have not hardware-tested your exact v2. I can test the refreshed revisi=
on
> before supplying a Tested-by.
>=20
> Thanks,
> Derek
>=20

--=20
Pauli Virtanen
