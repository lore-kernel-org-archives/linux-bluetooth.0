Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FF10E9
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jun 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749077413; cv=none; b=kat9nCfVoNrRVX5f2GiDITOl66N4PqQMt6ElT1Pql2gaGM8DfhEemVuv/+KPn6X8L9WwzarW10zZvAU7u0IPNIDnpIC+Xl0oMH6djS9xnan2yhpTmxGWP176zEQqV0n8kjvzsYqVy6161GCX8NIdnKmLhzRS2yDtJumGE9lSz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749077413; c=relaxed/simple;
	bh=UYxDd3jzSeD0BQcOEp3rTrjCmYpfh9xUEzlDBhLx/WA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txFPYDIkMWZ6E8HO9BAQoIH2NNMqwQii1ZICj+ql6vyj9Vict1cktC6SJSBFcOuZm5hAgH6KNrnYKw53pKv6l9cnI1BHwwh6BVsCwYOytqKenFAoQ5VtsChiXwQ462iXbGkL9ekFOqgx8ZU20QwQyJeHrs9wKQwD6waK/0NcE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=iot/V3h7; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="iot/V3h7"
Received: from [192.168.1.2] (Beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id 508071044945AE;
	Thu, 05 Jun 2025 01:50:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1749077400; bh=UYxDd3jzSeD0BQcOEp3rTrjCmYpfh9xUEzlDBhLx/WA=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References;
	b=iot/V3h73URtDps3RmUCmQU/V1hfZcW84iS+qVwoLazgKShW7Hg1/y6vtpfYe0tMv
	 kZmWlwGhvrn6Cst5Bvt8Rs87WkkPBr/ik7SJq5iPr1tYFoLMBBYCzVhlzdGdaJVzbo
	 dhs/4mGP0Y3OlQqgixfPc72ZZ5zpIBwac/rnhmbk=
Message-ID: <5284d0fedf1e044e40aa6839d39f010626e6f637.camel@sdore.me>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for
 DualSense
From: Egor Vorontsov <sdoregor@sdore.me>
Reply-To: sdoregor@sdore.me
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jun 2025 01:50:00 +0300
In-Reply-To: <CABBYNZL++r5p=opkw-saPK8yqKQWEPrU-AvcQvPK_x+0yXEUkQ@mail.gmail.com>
References: <20250603095617.92785-1-sdoregor@sdore.me>
	 <20250603095617.92785-3-sdoregor@sdore.me>
	 <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com>
	 <c8b55be8b9abdb73bc57e8a2d455770199a2b21b.camel@sdore.me>
	 <CABBYNZKL2gYmWPfP1owAUSAieWgt4ARaFp0-T5+vQ+rgjWnNHw@mail.gmail.com>
	 <4c6bec3c1c02243cf57e1618d1fd35a2f12bdf22.camel@sdore.me>
	 <CABBYNZL++r5p=opkw-saPK8yqKQWEPrU-AvcQvPK_x+0yXEUkQ@mail.gmail.com>
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

On Wed, 2025-06-04 at 08:41 -0400, Luiz Augusto von Dentz wrote:
> Hmm, not so sure this is secure though, I mean it could be a rogue USB
> device pretending to be a controller so it would automatically be
> considered paired if we just self generate the keys without asking for
> user confirmation.

We can generate whatever we want, unless BlueZ will treat the key as
bonded no question asked. Read on to see what I mean.

> Yeah, the zero-click bond might be a security concern though, so I
> think having the user do a confirmation for each step is sort of
> assuring he knows (or at least pretend) what is going on.

I strongly believe you only should confirm once. Especially since the
first one doesn't actually pair or trust anything, instead it just
creates the device record for it to be able to initiate a bonding
connection to us without discoverable being on (as far as I understand
it).

The painful re-re-pairing process is so strongly tied with Bluetooth in
our minds, so I really don't want to further increase its awkwardness.

> When would we generate the confirmation though? I sort of trust more
> the Bluetooth process to generate and exchange keys.

That's exactly what I'd love to hear from someone, honestly :)

I see a possible solution where we trigger agent on the first connect,
even though the link key is already established. It might be a special
flag for the device, or even just another value in the `LinkKey.Type'
field -- meaning, "key was generated by us, should reconfirm pairing".

--=20
Egor Vorontsov <sdoregor@sdore.me>
