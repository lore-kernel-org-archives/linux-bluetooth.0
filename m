Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C642165E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992992; cv=pass; b=Pkh+0xXhF5P1IhhjtGVRi8pC2dH/qFHqJTV1xsuUqNJQ+lcnV18agYF43Sy4cSGalFJn9Pk2MOu6Uu/lLzB3ph1j3w7Y+H53DnSfZ3QmyP9z8ACYkL5hheqbMgp4dubvquiEh6kXdKpT/IlmTtLHsJjSaSsT0v+C+HKn8weO9VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992992; c=relaxed/simple;
	bh=qO9OfM8JAXZOgKJB2FDVil8GlW5SQrXfYSAkWOuELmI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5ABuj+r0hrQWwiQVF1TpaR/VmBQ7egFyut8Ip4cceBTf6bcmSm/eqtnAjS4oy5UQdIkBW1XMlJibX+E2xB1J7BvkTMC0C0Hok0TqY+DJLDFdwMXeaVSoNKAGEeMoyyxc+Kva+2HNf5dAUnCc9mn1l3ZuIeo3dMDaeBHte6CV+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=GUk9EFi/; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="GUk9EFi/"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZfKdD0Gnlz49Pv9;
	Fri, 18 Apr 2025 19:16:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1744992976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L9xV/RVoewqgsAw1+AmE7wyATnntSR3XtaySxuMk1bs=;
	b=GUk9EFi/G4+WjpPybjdjd2AKEsntXZKRx1brmYB1yJ+W+z9zuRjptFphAee5oIzL5fRT0S
	aYgxPNaaq20tneoe8fQVEUMreFykG87h+cgirkl0oYFGs2T9EVJ8iq5pL9y5OjV6duiKZz
	+XMol59kFy+unIM3buDcvj3CvlGVVSm7UXgw5f5IToFFaEoEzJcsxjOJ9Bitat657rMLmu
	SGqCZhVktp7CyJTNmEUbir/DLRjLNCeiLAZLBF/DGQRPTThby7dt2m24CPoxHTWrCgIDCd
	Qu1Xha6VE4pDu5xfpl712h2vJZ8drzYi3l/OyOqQsN8EWZ7VP1UtpOu6WLFeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1744992976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L9xV/RVoewqgsAw1+AmE7wyATnntSR3XtaySxuMk1bs=;
	b=qaZ75jP+KOVrma8/wkTyYjg9mP/6LBtWgymofM+7hWDhMw0FB6+pcZIW7Ku7vkm9dHD9Kp
	68Lpsak26e62uHJi6FX/hHT/JIVQIeC4SlkFoAmnEhecs21VF0Z9oeaK8Og1b0jPGO7tqA
	aMKP5t6ItZRsYSfkq+jej/Yzxsb4c0U+5VlNd6KteZtB4CmTcUvshZmrEEocRLlmWHHiqQ
	PUBa+AVJCiiLdXxInYeK/5wDWrc1RpWowdt4RuvH3aAY89mKwg3FVin2YWF91LqIySU565
	uEQYdXiKI9CEORe8K+7ip2s88pSw3t8efALOhJpQ6Q3xXu0xGuTgEyUyLTBfnw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1744992976; a=rsa-sha256;
	cv=none;
	b=F+NfBqnMG/pBzPMqqdDhMd1piYx63utE4w0tyDzkze7MI2bhy2SLPtaRg1YMWQKuXNa0D/
	5Y9uDt4CyGw5h82C0QiSvdRb/QL+upjH/S/Fn+rqGicn/kARlL2mTS7Ob73VtqFmNx2EkZ
	JEeS3ZnrK1rqVV2qMguNd6u04iU9VCHe4apW61uCbhaG+vhkjZbpdNqI4YmWx4hC5JnJcf
	2sySIH61SgLS34oj3RSWz28fCU3dpa61xKsxUEvKU5+Gd9brI+MjhzYS1c/uFINS5gxG3z
	vR0Jg5SFn9+Ri/X7TM7AK4S8advcEUp3ntgd9U1QvEMAe0xNDqDxnKo5B7m4mA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <b6ef92f938a53a0038a247ea6555e609791c9325.camel@iki.fi>
Subject: Re: [PATCH v2 BlueZ 0/2] obexd: only run one instance at once
From: Pauli Virtanen <pav@iki.fi>
To: Andrew Sayers <kernel.org@pileofstuff.org>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 18 Apr 2025 19:16:12 +0300
In-Reply-To: <20250418153115.1714964-1-kernel.org@pileofstuff.org>
References: <20250418153115.1714964-1-kernel.org@pileofstuff.org>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2025-04-18 kello 16:30 +0100, Andrew Sayers kirjoitti:
> Obex is a device-oriented protocol, so only one instance can run per devi=
ce.
> But Linux file security is user-oriented, so obexd should be a user servi=
ce.
> Tell systemd to only run this service for the first non-system user to lo=
g in.

Sound servers have this same problem.=C2=A0As there's no concept of multipl=
e
users in BlueZ, the solution there is to monitor systemd/elogind seat
state, and detach the user process from bluetoothd if the seat is
inactive.

How to do the monitoring, see:
https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/modules/m=
odule-logind.c#L52

>=20
> This series causes systemd not to run obexd if it would just generate err=
ors,
> after adding a new bluez.tmpfiles file that distributors will need to ins=
tall.
>=20
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>=20
> V1 -> V2 add a hint in obex.service.in about installing the tmpfile
>          (recommended by Luiz Augusto von Dentz)
>=20
> Andrew Sayers (2):
>       build: add bluez.tmpfiles
>       obexd: only run one instance at once
>=20
>  .gitignore                | 1 +
>  configure.ac              | 1 +
>  obexd/src/obex.service.in | 9 +++++++++
>  tools/bluez.tmpfiles.in   | 1 +
>  4 files changed, 12 insertions(+)
