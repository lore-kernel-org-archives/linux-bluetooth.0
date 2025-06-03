Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BB1E7C10
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975732; cv=none; b=RSMI0L4yS7NZRB+ay2eDzdLsJpcmT2XotgWVZhl5UcK1UN3bH2rvzrYyoWLqLkEEuz7UsRskD1U9Iatd16NrbiO33v7+szP1awk5XyOJyhlTkmztvC7RLXBtdusDZ/kRnZMlsCmQwr9zXRYsFsLKd/h5zS3scUaZnhNo8OmRDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975732; c=relaxed/simple;
	bh=RWY1HPmzFoiELt7C4msRrJvGomLmjKHqbPymmkR8DkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QoA8wxL3SWJvQgOjqV3ra1FXScGNrIhiy6yyY8Kz3vd5UQYF7I9DmlcF1BfBrr7OSRCH0488rVVxoVajQ6i7hhnZ4V5fns2J23gMpzWWQnlsV4iVokvfrOS3aJZiUVPv8yKDka82aOoJN/ETmwKNG1kD2hp5dLPkDbtUu0F9qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=EGge9H0l; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="EGge9H0l"
Received: from [192.168.1.2] (Beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id A00AA10408BEA9;
	Tue, 03 Jun 2025 21:35:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1748975725; bh=RWY1HPmzFoiELt7C4msRrJvGomLmjKHqbPymmkR8DkQ=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References;
	b=EGge9H0lkxfpZdYXA7nDsq1usnwH+q9cgHvo9OxjddbQEwoZ4uHUBipYp8J22SwmU
	 21VJBnf4A0eBXBjOi2vMVzT/I49T5q6UCukPqfkK70S8/BcrOahcSZv6WlE8PBoarm
	 pCeCEFx+ANYXYJb/CYAsFZUFP1h80Jptlfe+aQkg=
Message-ID: <4c6bec3c1c02243cf57e1618d1fd35a2f12bdf22.camel@sdore.me>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for
 DualSense
From: Egor Vorontsov <sdoregor@sdore.me>
Reply-To: sdoregor@sdore.me
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 03 Jun 2025 21:35:25 +0300
In-Reply-To: <CABBYNZKL2gYmWPfP1owAUSAieWgt4ARaFp0-T5+vQ+rgjWnNHw@mail.gmail.com>
References: <20250603095617.92785-1-sdoregor@sdore.me>
	 <20250603095617.92785-3-sdoregor@sdore.me>
	 <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com>
	 <c8b55be8b9abdb73bc57e8a2d455770199a2b21b.camel@sdore.me>
	 <CABBYNZKL2gYmWPfP1owAUSAieWgt4ARaFp0-T5+vQ+rgjWnNHw@mail.gmail.com>
Autocrypt: addr=sdoregor@sdore.me; prefer-encrypt=mutual;
 keydata=mQINBGDSFnMBEADfvtLiuRL6CHdMzETKrux7sNHWG+eJ2+pgRZ3Nc9pH/YWqjoed8OpFx
 OLeUxr9YSQ3uMD//JEe3+Sgte29Z3PAAHVkCwKBIucCnhHpXbcQZgC9xYMCd6GWR5+DpXN9szOIyb
 kvnEtuqTddz6Q7fYsaFDs0pH3jUUWmSAyCn2JCIRfT22XgO44B/yoqnM3JXHAayeHbEAQOzMe81q3
 deauI9W7SC9ScRT6VkgLuc+SxqH99el/OkiKTe/QpO6I6cVS8leesqnOGffkRPos/o2eRonqgDu0e
 Mw4YTu0x5iNr8Lbr4TefU2W1l6M3MNwOsLmI+58+3fK1vh0QqZ70NC4eyD9UEXk3mJyV7epfNU6fY
 0mFJbAhGV1TXomcy2MlOD1rDixw85zdK5uUwp0tfEkpxqKtihJmrTdApOTTVed303CLzgDsMokTIe
 aUOPqVZoWFDkvOzq6IppBkApJHBf1lcLlgwEn3cLQlGpYRSSi5NY3+UYtcOEZLDbF3TO6ncY8W2h3
 yQH/sAcSllfKKvkhdqEz4/Mha3GbZQXWgjrLy9BcISsQFj+DBN54I6a6kLm2n5wXH99sOp7s3jMeN
 zSU6PtuxZq4Gkt2K5JGT8yrIdfJfOH7yRUVm+8JqKNKqd6oczlDKV+lzRk9M/kjb8VQivaNSNwTo9
 3NxEuft0+tZgwARAQABtCJFZ29yIFZvcm9udHNvdiA8c2RvcmVnb3JAc2RvcmUubWU+iQJOBBMBCA
 A4FiEEXlTCjXwaPBiJP3U33a9iH2xv60MFAmDSFnMCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4A
 ACgkQ3a9iH2xv60OquRAAgbgenXi+Ud0tYoAz6giuFKYqzuEYuoSVkjxYvZq90ODrzbu7EdvMVuKA
 qNqYjs3VRBPBMHXhJKEftKbX4bZwCoC2o2wB5oV5O13jVN083r49FTLCxmOoufCkaqscBBxi/X2T6
 +i0n5Nqx5NLBL0kE4NMTk1jxEEyuEjv7bBMs196G/d3EpNJT3YGkLXBUibpaSaVjE6zBr3UygieLD
 2QXNkRJubx2d0FoD8TezSt5hsHWg9FOElsW6ZImRI+5q+ptL39K3cpjxHMKyhmo7xypD5XNWdmsmV
 1+STnK7R+id18xs7JUDxHBtG7Z/3K6txgF5CPbPvtaEi9fB3K/uS03BnIzsY2/cY3r9UHHrHa/sP6
 DhDwj9dr2xIFG5w6ZNh4mUTHEJoWKEEsYKwXy2eJCB3XvP7GURAm8fXdIapONbHDYj7XX49Mj+LBr
 s4PNBuKaZTFgGQ6RSc7LpAR56xaEDR93m7zNy84mQtpab/owaox1A+BEujzKK/vEDvj9f8EWlWZRa
 DH2auNNAxdr2ACR8RzkojcFDCErAgc5sFQrgVUlvNmMdn3VL0CWmndzEQxsOdgVk9SwoHHYpHf4Cg
 gtchq3pTQ5XSRaP/wxOtQpzqJWq5uFERBTLU8WRXYv3mM3KMdvtTJadF8+P+KSSnn+/yHahR0HKVx
 PtHSH7Px/vI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-03 at 11:38 -0400, Luiz Augusto von Dentz wrote:
> Perhaps it is possible to write the link keys directly via cable but
> then we need the OOB data, etc, to generate the keys which in my
> opinion it just extra work that doesn't really add anything if just
> works, or autopair, is used.

In my experimental PoC I just generated a random 128-bit string and
used it as the link key for both sides (placed into `LinkKey=3D' in
BlueZ's `/info' and sent to DualSense over USB), which showed to be
working perfectly.

> Is it not seamless right now? Doesn't it use 'just works'/autopair?

It is kind of seamless, but you still have to accept the pairing
manually (e.g. be discoverable and with an active agent). In terms of
security I'd say this behavior is indeed preferable (otherwise one
could spoof the VID:PID and zero-click bond with the host), but it
still requires two separate confirmations.

If we could generate a static key, place it to both devices BUT at the
same time mark the device as unconfirmed/untrusted/etc. locally, so
that it is still going to trigger one and only one interactive pairing
confirmation, that'd be the intended design at least in my view.

Another possible way would be to automatically accept the first, dummy
pairing request that doesn't bear a link key yet -- so no security risk
there, but still more seamless experience for the user.

--=20
Egor Vorontsov <sdoregor@sdore.me>
