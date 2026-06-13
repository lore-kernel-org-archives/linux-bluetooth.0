Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE175801
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781368453; cv=pass; b=M6Q4oo9OXiUiPyn0Y6dyhCayf0X/eR081CLE+WwfEIiOOR6SzvcHbaQHiH04st1+KUdM9uLkWVQFQrMEF5FY4PAgH/SwuP7VJ/G4+NWz6XnydJ9ClbRZAz8VzIg5EA3rhhq0HZZfHtfGD/yLj/o6SG9A/AiqJVZSZEgj0FBLC4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781368453; c=relaxed/simple;
	bh=WT9mAbyZd9UcuSN+iOdMTQcBFgV4KPOg0QvR2WOROiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Crp1baSuYF+Whs/PMDCsgeMydmQsqmNjeE8oVNWAkT2E2veE8GbyKrBKUZOH5dkLv25gOD3nx8c2NP++6/+c0c27FToCtDtmuz/Y73hLUwO+bfM9OuIp2qUr0gNJJmSW13f6cJDn+DEFU1GXLjFLTC+Iq/JIzSWcAG/WER0VOq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VCgvKDuC; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VCgvKDuC"
Received: from [192.168.1.196] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gd25R4FCrz49Q86;
	Sat, 13 Jun 2026 19:34:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781368443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rSXqfQzrzBHAbexRXcUxlZhp6x9w75gmTQuX/pRYDCU=;
	b=VCgvKDuClFhX3ULmyGVm9M6I9Ax5CjMakc1Wy9p22SSFXF8ojMOmDGJ1ZaZsF0Xt1X0SmC
	M9R1DO4CxLHDfup9tFrf8CxdFgOu27ER9yRcAliMkOuRU0uc+K4422A8+clmeRukrQh/2u
	HXSeI61lx2Pm+tZ8pKkB5/7v1fqV9v1yZJzAE7/pvKq6+EONJAtWigWY5nQp5wfmsJm6no
	4f9LrualbgER0EjcC4eQXfaHY5seG2a86NK82Lc+HVmP+Ar3sNfGcu5wsE/XyUlXA6Gn2H
	Mw8W5bH7xNqrwYqu+8owdA8d44bA6KtlnlOq8WWsIA4159mmhHBqWa3pu58p6w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781368443;
	b=Yx0/X3IkuRdOFaXhIEtBbP2I1Y4Gz4hZOYF3gRoAz2QQxwX/ZjqSDTutKRoUjtpeaj9VHQ
	ht1BwfDc1wkPniTWqZODiM6ilDGtIEo5z5JrVdx3AQFKGAu/G/tkL60tfau42414kS3P/q
	lmw3xjHejodTtK4aqaAWrGbM5/5L3+Xiatz/NUb8mmwoxHHgy0TM52oNOR0uTB0Xl4ViMs
	3D7myLZj/3v2ZOVgLxO4idRUqAGWjp0d8wJKLUCdIBK8+LFPYLTsdPv/q0bzZmNH+hn8qf
	A4pGSOgYb4G7n/6YRBG+fhONSIbxJo6dEJMQ/D4lD9Ieu2RDC04vPHO46+oDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781368443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rSXqfQzrzBHAbexRXcUxlZhp6x9w75gmTQuX/pRYDCU=;
	b=ZaKgR7d4+c+fO9SCYxp3tLc2mJ7gF6OaH/rWiffxy/WDrZaxPvd7hOvVY7lXuyTW3HyGlt
	z1nGaxGcQVTo/Xp2fQ9JViiVPiXG0yC7Dq6Mf0w3NVGtchfALsGkWzpxWiW2vDR4+8gcQr
	hgeQ7k1QbnRBMKwDHsJwfD0rOhhLbj/QdDnKLOS+HXYdrU18sUf7tJ06vET6PHkkvt6qvB
	sA/K8wGdUwUfevgaZDOsQ4fQkNvrfAcLHwWfspBiYAqOhSaQmwtfuxFROaFlAU5BukLKEg
	q4KdUeTFPh4U5rvjfj78JUmvnTcG2UewuWLMtMwHyfB6pel9S/JU6Q7pu6nY5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <2f6235246c233b7c2d6c666a9c861026940ffe5c.camel@iki.fi>
Subject: Re: [PATCH BlueZ v5 00/16] Functional/integration testing
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 13 Jun 2026 19:34:01 +0300
In-Reply-To: <CABBYNZLBeuYHTNaBAkX_KC06rrQMMZn_Ks0sz2KQPTLpga5Lrw@mail.gmail.com>
References: <cover.1778688966.git.pav@iki.fi>
	 <CABBYNZLBeuYHTNaBAkX_KC06rrQMMZn_Ks0sz2KQPTLpga5Lrw@mail.gmail.com>
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

pe, 2026-06-12 kello 17:13 -0300, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, May 13, 2026 at 1:35=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add framework for writing tests simulating "real" environments where
> > BlueZ and other parts of the stack run on different virtual machine
> > hosts that communicate with each other.
[clip]
> >=20
> >  21 files changed, 1177 insertions(+), 86 deletions(-)
> >  create mode 100644 doc/test-functional.rst
> >  create mode 100644 test/functional/__init__.py
> >  create mode 100644 test/functional/conftest.py
> >  create mode 100644 test/functional/requirements.txt
> >  create mode 100644 test/functional/test_agent.py
> >  create mode 100644 test/functional/test_bluetoothctl_vm.py
> >  create mode 100644 test/functional/test_btmgmt_vm.py
> >  create mode 100644 test/functional/test_obex.py
> >  create mode 100644 test/functional/test_tests.py
> >  create mode 100644 test/pytest.ini
> >  create mode 100755 test/test-functional
> >  create mode 100755 test/test-functional-attach
> >=20
> > --
> > 2.54.0
>=20
> Do you mind resending the remaining changes? I'd like to see how it
> works; it seems you've already integrated with things like `make
> check`, right?

Sent v6.

Note it's failing on current bluetooth-next kernel due to hci_uart bug
introduced recently, needs something like this to fix it:

https://lore.kernel.org/linux-bluetooth/6888691461070a011d31632e6dcbfd73016=
dcc6e.1781364475.git.pav@iki.fi/
