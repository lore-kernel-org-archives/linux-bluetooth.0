Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED110277C8E
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749900637; cv=pass; b=XcT+ycbAGBGmKuuWDC48BgcuIB+lSiXZmP+oVMKHQwDztJ+nl/tDM/eFSxm0Ojdrbk94a9McILCXcwzpWuNjGswB69jMXSPWLpF0RNzXI0vBF6eqIiVSw7qYdH9zfNMWFbMH3xyGlOt7PSWQOvdJfP0NutDueuRcDO+59WPdI00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749900637; c=relaxed/simple;
	bh=bmOWzyXlYEuRvj6mctuSaudExdA1igtbL3Q1/1Bs4MY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i34vS3/Y9+mVL3vbc8+MIbfYYNdlwhgQKBgyM9BwT3wXE+PsSize6Qhk+wPd5W4puQWjFVYRuLX/7f0yh5+7omUnFRxQtJEskBKoK65IDwNi6XEsIUxA4vwd7q3Xpqq8mmLo1D6eqtPJsPXTQ28yHT7H4q3Jch4Yu/ZVSA9G7DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=kQJgGSYR; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="kQJgGSYR"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bKDb15V6lz49Pwm;
	Sat, 14 Jun 2025 14:30:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749900622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bmOWzyXlYEuRvj6mctuSaudExdA1igtbL3Q1/1Bs4MY=;
	b=kQJgGSYR24eoFsdYdu9ZHgIbN9HU8EHiAQ5SC9C464FHcOerhzHeqGmnZWCVJYgL33Sc4Q
	rM+sIucTGv00GLYAmWiEmMC3c9yy/15dYJOPAz7Sf8lZ3L8VZtvt5Jfog6q87+Q+C825ur
	qbHz/skOT4hUvVdvMYK9fYyrm56ZGQ7BKnn7LgLdAUBoiHkO4PvwC0VJawjsCjpUYS4mQ8
	jH8h0FeTZS9bEun2SCiNdfOQJS76+mGnxCFfVi2Vs9DunzWeBAm4LDxmCBvMhi6FI4UfiL
	WsNeDW4gHPZO+SJxpruIIzSha2nP68sbnvmfAVxlfatXMI6C1eM5oAgfZpsr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749900622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bmOWzyXlYEuRvj6mctuSaudExdA1igtbL3Q1/1Bs4MY=;
	b=Mq6WLwtkM7/bO/gk6VNOqNcmRemFeWqHjjyMAebpGDulSvkHOGYySdrMN+Gfq6DVk3z5JS
	ki3b+LL00IJdfdVEKwceKFwKBKErsbWja+HcjcX4eJOEHlVdZ12jEM6D3bC++BgkNK8ZoH
	rIod0289mBBZB2TaRZcbrWpvqePEw/Wesrmxm4Kz0YqyzIPPs4VKlsLoPzKe+DlQBb/g/w
	G/1togJHSShUZ7XEZy4Mh+I7DY9Y4Mp3OUB4FbhS8YO4jLe9g9mpNJn4tys8VXYmcajJ4M
	2jt9s1JcYsekXDVVmgMzRQJLi4cc9lYKCGoQ6FrgbztRxfTO6U1VUf23JcudWA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749900622; a=rsa-sha256;
	cv=none;
	b=l0F0pP7qZaFzcL5ySfWz3qO8YPcuCHSPj0gT4z7BKmZK8kWPX/ZtezjtQLAP0+dzG8UENe
	//G9E9U2vNYzAn9paN1TGQVcWUsSjrcYIrYtzynU5EZtmorioP6gPq+IHbMhkP/vPYJVQV
	oH3Py49Ruye5G+DiR31/cdbiN2NzEgVfpCo6BfW26caf4gMbETuD7QfmJPWeyVHXDMTGXI
	knXvPNwMcNJhRxlGsOXYFozivc7iBosZN1+sbPw04GEJLw61n+6n0WsY3V3n5vVtc8Pzgq
	qKwiZIR+AVvQOQDxaC+wxkhyddwoAU8G8g+pU2Dax9pDY4T2fDXKvhF1CVTvRw==
Message-ID: <6d9fd112f73fd56511318a0bc8f9681f7348de27.camel@iki.fi>
Subject: Re: [v1] bluetooth: hci_core: Fix use-after-free in vhci_flush().
From: Pauli Virtanen <pav@iki.fi>
To: Kuniyuki Iwashima <kuni1840@gmail.com>, bluez.test.bot@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 14 Jun 2025 14:30:18 +0300
In-Reply-To: <20250614022107.1368823-1-kuni1840@gmail.com>
References: <684cb56a.c80a0220.7fb1f.b9e7@mx.google.com>
	 <20250614022107.1368823-1-kuni1840@gmail.com>
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

pe, 2025-06-13 kello 19:20 -0700, Kuniyuki Iwashima kirjoitti:

[clip]
> > ##############################
> > Test: TestRunner_mesh-tester - FAIL
> > Desc: Run mesh-tester with test-runner
> > Output:
> > BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
> > WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x93e/0=
xba0
> > Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0
>=20
> It seems the same splat can be seen on other patches.
> https://lore.kernel.org/linux-bluetooth/?q=3DKASAN+run_timer_softirq
>=20
> Is this a known issue, or are we all making the same mistake ?
> If latter, can I get the full splat=C2=A0

https://github.com/BluezTestBot/bluetooth-next/pull/2887/checks

But probably it's an existing issue.

> and some guidance to run
> the same test locally (if it's easy to set up) ?

Please see
https://github.com/bluez/bluez/blob/master/doc/test-runner.rst#examples

I does not reproduce locally for me however.

--=20
Pauli Virtanen
