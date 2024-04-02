Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8515A484
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078229; cv=pass; b=LsFszl4hBg31NAlwzQIfMFukm4FqCsn5lPigVjWwUjxUZiqftMxBi+p11+dXHmDhY9yCHzemDSFz18Zo16EMZ6hl2/bLh+gcyIShJyrqULBUHVnaeocLPkaZMJqMGOa4PH+I7eqjfpO896+r+21W++9oVeaa85das6kZOlySDR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078229; c=relaxed/simple;
	bh=jEMbLMwfs7/XXLXWCsnSMO1y/bK7MhyggD6f1Y640Hw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L60LghPPj6oz272GGGlEvwNy4FGZx4J2125CX60b9OcaYWCCLXeznLwUBTyeqO2/UXOUTpxVi9gi7U70qVnPWKlTTTtxKygPStIevF0vvaAZDpUr7E/n7gIIVKd9R1EF0TozWdkxc9aWJjwPCKl6ntEhv6Fj1wHcIFiLViNt6ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=B89efq5N; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="B89efq5N"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8F171FCpz49Psw;
	Tue,  2 Apr 2024 20:16:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712078219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5lKGOOu0W1t6D45wSjwhcjYLL3GUcVntIEcGd+4kZQQ=;
	b=B89efq5NDUS3nhJ/hRPeeBNpLSqfil2Yxd9yPqYLSIn9mmRvfVusKVRv+6tbFxRD6zvksf
	lUmy8LjnDIQKYxDi6I8nv81bsojdp6wiJY3+1jvyTjPWHGjgy48Cfas+KRZInW9+wY67en
	QMCjz2jSfKs4rJlzgbMjEF1yfaOTw/cNOTjVKWVNr1ReCx5AXAS1fy7RSE+msmo0Ega/Za
	rY1ppzgOl3hhGw33Qy5B4HWYoCPSODvcXXaAtbC6sKzoB5t7VOUIuco58QakDm5ar5TdL6
	VI8NKyrFOmOBKZ13LHRlGXpBZQnyRWMdl9X+0RzVFRQeGH27Ts5Kkm2IjNURNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712078219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5lKGOOu0W1t6D45wSjwhcjYLL3GUcVntIEcGd+4kZQQ=;
	b=tBrzgwb8zepLQfQdlRwUPtMnZ1mPBUXudXIFmFu24jWmrhg2emrnqrB1K5v4vWeXOrXEGb
	SrfXaqrSzJ9I6kZ/8XJbQ/+GTHXD0Waa7sJS+L3F2GpyRIMxQp+VzWdi5LCOrpXi1ZZSgy
	3ARSnOrDGJ7+jt/Kpxbw3u27997R2seOL7ai/+VvPEQY5JZqBK5THdfUskjhrAp3jlvCSV
	eQb9jU4bVFKkR+RC1X/T0eoIxkyxl9YWV27L8Hz+i0IYe+617KyeBPUueFiypu3NqAc531
	oLtmbXWJ0h26ViJFPf1nO6FQk0VrFGvykMpMdLvHwX/sdYT0W/RswT7hl8++eg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712078219; a=rsa-sha256;
	cv=none;
	b=E9mr0OS3VOcoywlvQdFHhSVah3s1xkUWK055LnuWofXTH0QKpjDx6CUvqAd9DAn0jzNgt2
	7OCom2Z6uW0FhfUp+2cqu51zLmVpFsFFyyE1uNljwE2FoOI0mcNwkHwrtWHuzZiV3xZ/G/
	TCFdIPvXL3ZrukNKZkShe/E/SsX9zaryOwaMx5/ZfT3Dm6uqq4TRuvDye77th9hBy/VLtC
	unco1e34HmHqL+HU7K+rB/bmdJ3F8mhHh6GKMaB15gPGpffcgBtITPyLRuAUKJsGvbcvy7
	0HP3PFhiD1tl4WAlTa43B/nuJqn28RyUVQdRetRmMK3RAPDqtsJEBKtmg7e4Hg==
Message-ID: <0fd88d1ed7704938f54460e0e42a2f934690bf01.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: btintel: Add devices to
 HCI_QUIRK_BROKEN_LE_CODED
From: Pauli Virtanen <pav@iki.fi>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 02 Apr 2024 20:16:57 +0300
In-Reply-To: <29d54137-f3b9-4556-b99e-61a0f681f164@tuxedocomputers.com>
References: <20240328131800.63328-1-wse@tuxedocomputers.com>
	 <CABBYNZ+OaJ9QVE_KmBNL8QbBv4r5erL57u3BzFv0AnmUzY=PTA@mail.gmail.com>
	 <29d54137-f3b9-4556-b99e-61a0f681f164@tuxedocomputers.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pe, 2024-03-29 kello 00:20 +0100, Werner Sembach kirjoitti:
> Hi Luiz,
>=20
> Am 28.03.24 um 15:17 schrieb Luiz Augusto von Dentz:
> > Hi Werner,
> >=20
> > On Thu, Mar 28, 2024 at 9:18=E2=80=AFAM Werner Sembach <wse@tuxedocompu=
ters.com> wrote:
> > > From: Christoffer Sandberg <cs@tuxedo.de>
> > >=20
> > > For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
> > > connection issues when enabled. This patch disables it through
> > > the existing quirk.
> > >=20
> > > Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> > > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > > Cc: <stable@vger.kernel.org>
> > > ---
> > >   drivers/bluetooth/btintel.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.=
c
> > > index cdc5c08824a0a..6dbfb74d0adf9 100644
> > > --- a/drivers/bluetooth/btintel.c
> > > +++ b/drivers/bluetooth/btintel.c
> > > @@ -2881,6 +2881,8 @@ static int btintel_setup_combined(struct hci_de=
v *hdev)
> > >          case 0x17:
> > >          case 0x18:
> > >          case 0x19:
> > > +               /* 0x17, 0x18 and 0x19 have issues when LE Coded PHY =
is enabled */
> > > +               set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
> > If it is just these 3 then we are missing a break here.
>=20
> The cases are not added by the patch, the fallthrough was here before. Th=
is=20
> patch just adds this quirk for these 3 cases on top to the other things d=
one=20
> below, aka the fallthrough is intentional.

See

https://docs.kernel.org/next/process/deprecated.html#implicit-switch-case-f=
all-through


>=20
> Best regards,
>=20
> Werner
>=20
> >=20
> > >          case 0x1b:
> > >          case 0x1c:
> > >                  /* Display version information of TLV type */
> > > --
> > > 2.34.1
> > >=20
> >=20

--=20
Pauli Virtanen
