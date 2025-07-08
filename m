Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4B1548C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994772; cv=pass; b=PJNFn2IZ57xwLh8JsMawRoF95lGY0Xfs4H0Qa+HEv68jl4YLRCB4Br9t86J2aWubXZhRLPMolzcvmb2D1+wJeqBk+EtJ9mCJvdqXyHRE3/ptloHZOAcs6zayPplZbYlbwqrAjlSYC0MO96GTtKGxNEGV8yKERctPOdeFADmAies=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994772; c=relaxed/simple;
	bh=nSha9NtD9EdaaiNRlmqavJXbm3BTdAoUMfVQpsW1ywU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CNq50D0GKjK/BL4NtKrLouswsmZOPEqWnviR3vQ3GWV5OI/8KTcFhzsVf0BwaqiCePHyqQuxN4phMf2AB2WV4ltLDnLPDVcsKdxUmUQzXO8is8zR9IQ9oDtCPVSTT9VBMoHuOPeerwnGQIbJ+tusOLpkNgob6KvOpqv9ltNqoLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Q3LJjwYV; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Q3LJjwYV"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bc72z34nLz49Psw;
	Tue,  8 Jul 2025 20:12:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1751994764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tdDc240K4VveHOv3ygFmjMccPyxtFGZnVtv5ITdo+Gw=;
	b=Q3LJjwYVIGrV4qTCiwzNIQ/zhrp47UsbIK08RZhyc/5q0uALVSVTQT4asq6cmic1Vewyuv
	+8mlBYLbs8uT9qMYF4/Y3lAgusQOxS6SMa0YGugQwEiLmOJJUpkn+ZnqWrpTlhshvf4aFZ
	KiJ0AKoRarkZYV8bCTyYxe85oPynVOPsp/IQYK4BwAAZcH7q9co10L8GJI2pzyTmYMeRGK
	wgO4KBwjCflTfc6CcoAkh/yb/BkN4JIKDMKW1lIGxKRKbI5ceEq9YWtOlBeATtbCIsRaST
	NDF/kNT15+IZ/QLLwXIqqSX/3IIs/Cf2eVjC5++rZSw/kMtntIB0FQLldvo3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1751994764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tdDc240K4VveHOv3ygFmjMccPyxtFGZnVtv5ITdo+Gw=;
	b=hzYihuNoz2m74NKXRep3+/XAWSXU4Iizc8+xguFkDq2dQhlicYRE+oP33oE/f/sAFAO2ZN
	A65VkAa/vLXeh6FTdbL4rH68Gl7VA8/CFWUj9xz09SBH7ilj1eeqtAuk1C9g6ge9HcUVsY
	eeTJv2B3FOmF6tm5hcBt0Hyoo16bLXp3XL+4V9cy+2KkwifAIhP1Ga4d6tkUlE9OqbYp/2
	4KedXCJAkryFRrGDUmVAblyy0vZo3O3akPL/KJRb75Lj4s0VM7ZlpenPyA8JqoCMjEq22v
	NY4wnksD+FnHsBqNNeH2usA9bjvyjP863GHz3HVUuXXa40jC6gvf6e6J6avs0w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1751994764; a=rsa-sha256;
	cv=none;
	b=Hr1pKsue5sFQq/7Rl5tcomLxjYDFadBJfHMl5HmVanaNPJo6i5e6Gz99YWjYxWUSDHLlXl
	FtPJ8z1ieWYMSmRAQcWV3ACSipvXGOZeqRKmSVysugvoV4jUk62j2yHNZ6oMKy6Zt57c6x
	hnfYLVGRnzjbd9HjVec3YhAcYGkfbMphXhREwh67Ac0tGLiF+TZ6rEaDgQopTUfmIE5oV3
	7ememNJH6uKhW07UMhOIQqzVRZw3sdGFJ/nJpZPCtVSySx9QCIgbez7bBnlUl5DopyODWd
	wOL4z/xaJ2Folx+G475IdBK3G7jGZi2wdla57jQJBcCLH2gsXV3p9j9KZCcwLw==
Message-ID: <c721fd3eca1fd4e6555ddafdf3cd640e4457c1fc.camel@iki.fi>
Subject: Re: [PATCH BlueZ v3 6/7] shared/ad: Use strtoutf8 for name
From: Pauli Virtanen <pav@iki.fi>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jul 2025 20:12:41 +0300
In-Reply-To: <20250708154308.238963-7-frederic.danis@collabora.com>
References: <20250708154308.238963-1-frederic.danis@collabora.com>
	 <20250708154308.238963-7-frederic.danis@collabora.com>
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

Hi,

ti, 2025-07-08 kello 17:43 +0200, Fr=C3=A9d=C3=A9ric Danis kirjoitti:
> Truncate the string to first character before invalid UTF-8 one
> instead of replacing non ascii characters by spaces.
> ---
>  src/shared/ad.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index 3f0064dd9..6952a0dab 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -276,7 +276,6 @@ static bool ad_replace_uuid128(struct bt_ad *ad, stru=
ct iovec *iov)
>  static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
>  {
>  	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
> -	int i;
> =20
>  	memset(utf8_name, 0, sizeof(utf8_name));
>  	strncpy(utf8_name, (const char *)iov->iov_base, iov->iov_len);
> @@ -284,11 +283,7 @@ static bool ad_replace_name(struct bt_ad *ad, struct=
 iovec *iov)
>  	if (strisutf8(utf8_name, iov->iov_len))
>  		goto done;
> =20
> -	/* Assume ASCII, and replace all non-ASCII with spaces */
> -	for (i =3D 0; utf8_name[i] !=3D '\0'; i++) {
> -		if (!isascii(utf8_name[i]))
> -			utf8_name[i] =3D ' ';
> -	}
> +	strtoutf8(utf8_name, iov->iov_len);

Looks like potential out-of-bounds access --- strtoutf8()=C2=A0
may access iov->iov_base[iov->iov_len]

Cf. for (size_t j =3D 1; j < size; ++j) loop in strtoutf8().

Also strisutf8() has same problem here.

> =20
>  	/* Remove leading and trailing whitespace characters */
>  	strstrip(utf8_name);

--=20
Pauli Virtanen
