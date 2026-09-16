Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EC4C33C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580439; cv=pass; b=ePM/Ludz2TpV9APXbtEAUMMUxiJE23vytvtpCl2cIfpw1Z9P4RZefGIb5ngVOjFeJeB461lbcylHRr7G2Ki6CsVRZigy0UaHWW2cbkylwDXQRjcjVIq74vVhA39cr26vocJaMveFsjmPyG+MeHZJ7Z+m++9cW+7iVxvc/+GWqs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580439; c=relaxed/simple;
	bh=rl5Ciemjw9Py7rna5vZMNP0jzB/YgcIkCwQy79rmRNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3tumPOve6As66xIikjdRkufiqzE6eZOCgmHUVtXh1ux2BvZlPyTpxqHwUMaSaGZDWtCzwMfeF+P7/x6CENTV0YKDHU30pdKaPCBWi/F7/cCeJVRu0QeElOaUCy/w0zzqMpGHavS9L70Kx6vFkdnAYyvhfQexe/Dcf3GJbN01YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VJmO7K/F; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VJmO7K/F"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hlR423YTpz49QKP;
	Wed, 16 Sep 2026 20:40:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789580419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rl5Ciemjw9Py7rna5vZMNP0jzB/YgcIkCwQy79rmRNY=;
	b=VJmO7K/F6FzwsQ0UP0UcIKqK3ZOxa1+DQP8I1Rz4SLV4asi30rEPyXxKAvdONuzgqgCgsF
	7FowAoKDbmENEwIPXg9yO+tAo6BzYp1yZ5ulo2C8J1oZ6l94auDKdhYFh2OhaE930CRE0d
	4pccip3TwUUZ73ld4o1CpU/IygTpMwBY+QTuCLWQRtYM3j7wtudqqbG1aXjFFS4vi+7YXN
	anmE0CT75PW/Lg65fuYnkWPipy/jx8jVvmmCul4xUjsylq0uKzd5gOrsyqlK54hX8EXNoP
	lYjYedlIulGfLc/DUS6BYE7RxKhDE8sRRqLuYIVsCdeYNO4n3if2x0ckCjWtgw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789580419;
	b=s12S4/lSoSMo6bDONZNdAk5s8D+oKrihNJgRFH1vtCIC16RhXkZzS06+FKd0Jd9MZXJIJe
	nqQHGkxSoqD4sbcCJoGp2iiVdscmymbLOzThtLqclhSsQrYqd9MQ5ksRxPPjkAIRz37r+n
	V5d0KpryzIdu+cfK/IFd3FtPxAZ2bsX7PkczCIJ+IuZpLjYLwUZZfBx3utzoVT+Nhy8Eyl
	BEXxaQOpuNiGqSmDAy5HIP+7+cYO3LYGetbBtgWoNaE0xba4OT5tmFOxzkYciENRP2N61d
	bUfN3LenejCPrPmBn3ZVCeWhanli5j0o1MACWbVbTL3RfLuiaiO5BHFQm0YE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789580419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rl5Ciemjw9Py7rna5vZMNP0jzB/YgcIkCwQy79rmRNY=;
	b=q7lbyn74etGzMP6HOlGafrIXpCWXFdZ/Xa3xbQoGZ4v07/OaJrgdK1YL38XHYwZASEgYmI
	DpP6mxzAF/quxxvoimmFND7BIIu4iK5FEHDkop/WIHLsI9So2FRrrAAnKl96uN8BcNKy5I
	wiBC9sSmm9BTA0IdKob9H8dyRKpRfmFiwAe+MOc8mlIUOwZGej/G0Oo766EvfGw1XTk118
	QQ1QVYeMFwi7epSPIn74l0ChVIg+k+/jnIXBCcRwpuEN6Ukduo/c1lXoc36xmBQWDRAVsv
	pBS6Jzs572J/ttBAYmGCYfBk78tYVRobHjtnYAf88+COFCbKbSMQDDhLxNVFig==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <e4b4da9d018ab26c5376fef47476b8852222eb07.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: btmtk: don't generate bogus ISO packets
 from zero padding
From: Pauli Virtanen <pav@iki.fi>
To: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
 "marcel@holtmann.org"
	 <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, 
 "linux-mediatek@lists.infradead.org"
	 <linux-mediatek@lists.infradead.org>
Date: Wed, 16 Sep 2026 20:40:15 +0300
In-Reply-To: <fp1LLpMjte31CZfdRymzNx8DeLqozYHgFf2TAKxtIiHEkPcykA5jgtuDuZYcJTb5vPGpPkgB8GoVoX5_821oWe9NvenZdL4kwrxyCuanlw8=@proton.me>
References: 
	<fp1LLpMjte31CZfdRymzNx8DeLqozYHgFf2TAKxtIiHEkPcykA5jgtuDuZYcJTb5vPGpPkgB8GoVoX5_821oWe9NvenZdL4kwrxyCuanlw8=@proton.me>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
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

ke, 2026-09-16 kello 10:34 +0000, dt kirjoitti:
> Following up on your v2 proposal:
> https://www.spinics.net/lists/linux-bluetooth/msg129361.html
>=20
> Additional evidence for the MT7925 padding issue, from an MT7925 using
> LE Audio on kernel 7.2.4-3-cachyos:
>=20
> Before filtering, a capture contained 206,325 spurious handle-zero ISO
> packets. The count matches interpreting the zero remainder of 264-byte
> transfers as four-byte headers: 3,633 genuine 60-byte SDUs and 507 empty
> SDUs give 3633 * 48 + 507 * 63 =3D 206325. USB URB boundaries were not
> captured, so this is byte-accounting evidence for the padding explanation=
.
>=20
> A local adaptation of this proposal eliminates the phantom packets in
> two subsequent capture summaries, which contain only the real ISO handles
> and no short or truncated ISO headers.
>=20
> The tested variant differs from this v2: it uses the existing dev_id to
> restrict filtering to MT7925, leaves btmtk.h unchanged, and omits the
> once-per-device warning. It retains the original 264-byte transfer check
> and discards an all-zero remainder only after consuming some data and
> reaching a new packet boundary. The original v2 itself was not tested.
>=20
> The complete local setup has also passed reboot, reconnect and duplex
> profile-switch testing. Separate PipeWire, WirePlumber and BlueZ fixes
> were involved, so the specific result attributable to this filter is the
> removal of the bogus padding packets.
>=20
> As of 2026-09-16, the receive loops in bluetooth-next at 2e63b55654e0
> and Linux at 9b87fdc9af2f still lack a trailing-padding check. Would a
> refresh of this proposal be useful? Has MediaTek confirmed whether the
> fixed-size zero padding is intentional, which would inform retaining or
> removing the warning?

It's probably intentional since IIRC the host -> controller direction
has same padding.

There was no comment / fix from Mediatek, so it probably should be
resent since it seems like driver bug.

BTW, did you test the latest 20260813113236 firmware version too?
https://gitlab.com/kernel-firmware/linux-firmware/-/tree/main/mediatek/mt79=
25

--=20
Pauli Virtanen
