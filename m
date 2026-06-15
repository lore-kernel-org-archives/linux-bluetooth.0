Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66C192B75
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552762; cv=pass; b=Rf7INqG288WlyR1zQs7uZPcSwFa07869BBsCjKsc2Da0+UqPbRl75zr+T3IgODXix+afgwzFr5kD8PILw/euEwOme9AnlFIlFj/Iea2tLKGDawX/4vEOBL4A0zMNcw3PNVVk7mrN6wkxxd0gr5ojuU4S74e+c7w3utd3MqoxabQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552762; c=relaxed/simple;
	bh=csx4djcsWOo9rTSj56KpS/pHa1b4l8PmEAIPJx7t8CA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkcpE+r5umim5HvFtcVkMch1xX7HGGZQm2CxogJuc5FPNGRnZhquSz9lh9Dh77CBFZasIxGkZUrRjNEotTa8mfaLJgNLLV5cpqQ71n3ZB9fLpUgQwFr0vN+LQm4XAlaAh6qmfa6EV2g8fRACLnoxN1njqYYQF3oNS358NJH0Cyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=OoznGKNg; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="OoznGKNg"
Received: from [192.168.1.196] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gfLFk6BY6z49Q0G;
	Mon, 15 Jun 2026 22:45:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781552747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xw6+PeZ2OX8a2go7Laza+D2Lknz7gYVHxgjdPrvGrhs=;
	b=OoznGKNggYzsxbR1v3OkN58Hx0nTUv45zuS35tLS4KeINGK1LhU3CY2fluRBA9x2SYQvYf
	MihF0dboYAwsPNvWhyxgYpOQUZp4YmJ0x781KKk+sc0akdGqvcqwUifyicMgqE1ad8w+T3
	5LT909f2CosantZHqSzCuhM9nfxW4/5YiVPqgjuk7Jh9lzpOzhBLtkcaU9e82RLfcJyMAH
	k3LJZPPThpCmMqor/qX80VZVbLPPO4Dq8k4d/oRe6Ir5OVv9DpheNqAiz3U0XYeFbLQKTy
	Sqhl7yqJ17ui+iOA2ty2vaDe/7XOwofUOIuruJNZM6iGfRWjm/o2e9rOpH8N3w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781552747;
	b=BHLGWaVxd2CSVF7RKXl3BLLWtXnWrVto3mNsAQ4c8jrGGMGOZ/+mPE9QWO0KhjUbQ2Eta4
	jameveyxxvcWRp1f4mUC/2qIcfkH2ZQBxTSxFQXKWcP/a6RWkZrN1heex6rj62uQkuo0/J
	YFXmto3DIk7uVVK0LRFezHCq6miBFWo60c4CzYh0hddpUxbVZH06HknAJm1Ap8PrqSv+Xc
	1eknA5RfXu3ryohO9HdrkbP37fiqQbbZvSnAEOPvuxX9bJ0xFZ+BY+hg0IWf3B8Gn+NVcP
	UUD0ujp7xqs0k/CwAIGiaUUHDmR+u7xuA3IYVroQxyg8XxAXnUQ5Yubf+C1hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781552747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xw6+PeZ2OX8a2go7Laza+D2Lknz7gYVHxgjdPrvGrhs=;
	b=Oxch5WaDa2L8joXfmQHHcPiibOiTG5Dp0AW0M+BnWy0eNFIHDYMZnkM8JFOLeN028RGVEZ
	lPPDan7vzC16idQCXFQXAZVEitAgpVEoeyZCeA2TUefdP9cHmu6ddOu3dX44dZ3iQIXem6
	wEWzlyIFSsrk8qmR0HPxZhW3RQqvkrU5nkrT9LSHUpC9Fv0XHVPFkiHeshn3qwUSsExfD9
	42QgX4bOEE1VY43mlfQXkrCCJB5IsytmKCEEJ/4ltAaMsZ+YhS+D21M01mTtsv8Qa1xIq0
	wFx0x0VUmFgzU1x50ip5kBqsy/j2HfQgYTxYpEAXNhrGx4AAe+RBMnh/S0JmtA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <8e9a1ab463060b9918e6569ae2ea3f37d5d70a52.camel@iki.fi>
Subject: Re: [PATCH BlueZ v6 3/6] build: add functional testing target
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 15 Jun 2026 22:45:45 +0300
In-Reply-To: <CABBYNZ+6Bp6yV4kzB4Y53XD+6i0mbhNTFoU=qpXq4Qu5o3=6og@mail.gmail.com>
References: <cover.1781365708.git.pav@iki.fi>
	 <199523aaa32d2be835216f583dfe9bf7d9eacf42.1781365708.git.pav@iki.fi>
	 <CABBYNZ+6Bp6yV4kzB4Y53XD+6i0mbhNTFoU=qpXq4Qu5o3=6og@mail.gmail.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
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

ma, 2026-06-15 kello 15:08 -0400, Luiz Augusto von Dentz kirjoitti:
[clip]
>=20
> Seems to be working if I do ./bootstrap-configure
> --enable-functional-testing=3D../linux:
>=20
> platform linux -- Python 3.13.13, pytest-8.3.3, pluggy-1.5.0 -- /usr/bin/=
python3
> cachedir: .pytest_cache
> rootdir: /home/vudentz/git/bluez/test
> configfile: pytest.ini
> plugins: venv-0.3, anyio-4.8.0
> collected 13 items
>=20
[clip]
> test/functional/test_tests.py::test_formatting SKIPPED (could not
> import 'black': No module named 'black')
>=20
>=20
> [  7%]
> test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_show[hosts1-vm=
1]
> PASSED
[clip]

> I wonder why the first one is being skipped though, since I did install:
>=20
> python3 -mpip install -r test/functional/requirements.txt

Right, the requirements file could have `black` added to it.

> That said maybe we could run it as part of a container that builds the
> kernel environment, which would download and build bluetooth-next.
> Even better, that could load a prebuilt kernel image (pushed by CI)
> but it perhaps needs to detect if the prebuilt image needs updating;
> if so, it builds it locally or something.

Having some docker image that builds/downloads the kernel image and
runs these=C2=A0could make sense, which could then run on some schedule on
CI.

If it should be integrated with Patchwork and run on every patch, then
it may be simplest to do it in the action-ci together with the other
testers.

Otherwise, probably separate image + separate Github action.

If running locally, you can say=C2=A0
`test/test-functional --kernel-build=3Dforce` and it'll pull & build
bluetooth-next kernel, with ccache it rebuilds in reasonable time.

--=20
Pauli Virtanen
