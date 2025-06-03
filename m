Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6E2397A4
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962540; cv=none; b=rsU4ljAY+H6UE6hL92NqdOWA9fmAofPvZrSgLZeU2yPPD+lRZJGb7EuljhwiXMjiUJqBVA34mxqFYj3s2/qh/fem4dA7HKoZkjMBoRg+rZo9fjZARisjrQmr6Ng3ksZvNuKtisnpRHksvWL8hIAlg/b1iG8qe1OcnSAIFIg29RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962540; c=relaxed/simple;
	bh=ZYjSCtonXUf479hOIUz32gqODta/0hjpKBxf8mLYKwo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxj5PIRptf3BLFKZknmyYdSQWwX9yQ+wWYxuR+hmJFzWtuN1RPhIRcbP72NavrKdVssnNFsyxxeN73zFGMNnZLxezC3EFWDkhQvWkJ7eKjTm44WcmiujzU49hbUek8hLL6V0RavEFpL/m0Z9c2sA/VKG8Mf8ZfGigcMFvynT1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=P4Ae9ZYJ; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="P4Ae9ZYJ"
Received: from [192.168.1.2] (Beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id D0AE5103FE94B0;
	Tue, 03 Jun 2025 17:55:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1748962533; bh=ZYjSCtonXUf479hOIUz32gqODta/0hjpKBxf8mLYKwo=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References;
	b=P4Ae9ZYJjP+lpuKhPUh/+Ap3S9hMx9nxNAFiC70W1fkVU78djw8G8S9VN6sv1l0Is
	 ZVc8xS0S+BEsg5Xi1DRnJt63o94iGJpwsarUCZsZIhy2/D9nS1xsmrOQmiM4y+LA9k
	 8KXItoGdVCKagMuM4c9NPLe4mMuaTeV2sqWBgurI=
Message-ID: <c8b55be8b9abdb73bc57e8a2d455770199a2b21b.camel@sdore.me>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for
 DualSense
From: Egor Vorontsov <sdoregor@sdore.me>
Reply-To: sdoregor@sdore.me
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 03 Jun 2025 17:55:33 +0300
In-Reply-To: <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com>
References: <20250603095617.92785-1-sdoregor@sdore.me>
	 <20250603095617.92785-3-sdoregor@sdore.me>
	 <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com>
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

On Tue, 2025-06-03 at 10:40 -0400, Luiz Augusto von Dentz wrote:
> > +       /* TODO: we could put the key here but
> > +          there is no way to force a re-loading
> > +          of link keys to the kernel from here. */
>=20
> Not quite following, what key are you talking about? I thought the
> link keys are still generated over Bluetooth, or are you talking about
> passkeys here?

Hi Luiz, thank you for the quick response!

If you look a little bit upper, in the `ds4_set_central_bdaddr', you'll
see the exact same comment. As I pointed out, I decided to just
duplicate the code for now, as a proper general implementation might
require some further refactoring of somewhat unrelated code.

From my understanding of the original author's thoughts combined with
the experimentation I've done, it is about the possibility to directly
provide a generated link key, completely skipping the usual BT bonding
process (that, I positively tested with my script by writing directly
to BlueZ's device `/info' file), instead of writing all zeros and
relying on (I assume?) Just Works repairing on the following connect.

My knowledge in terms of Kernel Bluetooth subsystem doesn't go so far
to actually tackle the problem; it might require implementing a key
reloading ABI in the kernel. On the other hand, there's `btmgmt keys'
command which, I assume, does pretty much that, but I didn't have any
success using it in my testing -- only a full restart of `bluetoothd'
did the thing.

I'm up to further investigation of this nitpick, as I'd love to see a
seamless pairing process just like it was intended, but I'd need some
assistance in locating the appropriate showstoppers mentioned in that
comment. That said, I don't see this as a stopper for the patch itself.

--=20
Egor Vorontsov <sdoregor@sdore.me>
