Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DEA3E5580
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042654; cv=pass; b=iS6G2Ktst028o1Q0GLjQxUOkXJPzx1BnXolnit0Y3vJSKE/pEUypPV2q9N2Lhs5+2HXIJcQ/Z8XecKjBaGPYOwTnhnCH3+J1kFiGi5XRKhE/Tb6Yp3DS52fHyjdtw1PXMNjrjU7czgENyztSWrkGX9GdykbPvBPgyZXCAgcNGP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042654; c=relaxed/simple;
	bh=Ik3worYWs96zl/Ou9Wj5xYIruL34kfrLTiQyY8gBfeE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZ4eJg3C5fVJJw+KOxRG3deROXcM6U1lmRXNlJ65W1IK6Y7rGsKvl7SZklmQBDlQQQG+EvlVPlvaMsjiJk4gmwgQa+iofrLIC/CGiPsRU7sNKtwA/+pqCUTd5GTQHq1noQ282cCFwrx4qdMY9RaH0lU0IPMYNT21aTsieGEzwdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=OcRQhJXU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="OcRQhJXU"
Received: from [192.168.1.196] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gZjc000DKz49PyY;
	Wed, 10 Jun 2026 01:03:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781042640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zkKgowm8Mu2M8wRAQOyojPBXmYjB2jpIeXGg696uOgU=;
	b=OcRQhJXUT6ItuMKtFuMOW+FHNycVAkWYNAwOfHI9E24Iir9CofbQwPeVOBm434KGWU8Lco
	bpcZU6PQIO8hp4hKz/Imrne1vOKR76vsw9lGGZ1iKQ4OrYZCoGq43NTFVWfkMebeqyc7pr
	NoefsOXnb11ad1Y/IZ5oehT84ZpUdsdTu6tjv5t0I7DYFyGaphv62gsBhtyx4XtXurQYS/
	TqAjDvSNOjMKby/7fhV7HlnF+qIyTfWKqMXnVo2DVQDONkrwEN4tRT0E2RCTFrdl0jPmfX
	jXxrQuj5bEVQgby4W4VCeghJGR5VPoNET/DyGBSk6feFRh49+R4gnZnt9MRqKg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781042640;
	b=gXRRSeflHTDQx5W1uhahUgIayYQoEUvXVJif52wkyu+giArp1rkv5vC+UtODGpV/WO0mBT
	dcVOthdbOLOFNyMR9E+r93sv+EvOWBc0OnBMMS64OEwqzd+FRdu7znFNQ7YJ7QoiOO3jyt
	jr7P8iXwwEHVRkGxyr1JF9P6CsT8VRB7FMI3Nc1EoIJQHHI5QRH3ZXbVil4amRzo1bUf52
	ihHAzlfKW+lfSukBlHQuU5QcmxLZ0s+EFPgqabF/NM5Y/9DyvDHfgadds5S18Ulq9Iyuez
	BdX24t7FkIz9HkU4lA20SJuPt1wS8+9JCfN5XtYY7bnVNdiZf9xm45FISRXAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781042640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zkKgowm8Mu2M8wRAQOyojPBXmYjB2jpIeXGg696uOgU=;
	b=RPe1XEE+mZx3rU5SY7+YDRybVtUH4GdaDKeY7DVEuB2zUjSgGOSc51Kcblk9A8KyGVmX0O
	L8qlgBOn1IqHAcrRmvrj+spjsGMWjXlO+Na/Wdu8mylz1bqy0CoJa6qabRRfyDNsscELkB
	NKknKTHs3RLEgDrIW90MCELd86YRFLnHRPkrndhOmX48ZW6EkiE6DhxW11S7+DRlS+AJl8
	BVK2nkPPKNJp9c0DHiJGVV/2xQMVAXa0aiFwWAn07JUcqLHXEHGozRJwr2fUw1kAtipcm/
	0UZYNAX1bjJKPefI1lJo1yFsUrs7NWpLFRI4KmZSt3bv0V/E/LSdn6T2E3Oe8g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <0744a915b7ea628647a17fa9aad0aa4365f83989.camel@iki.fi>
Subject: Re: [PATCH BlueZ] shared/bap: Don't link ucast streams before CIS
 IDs are assigned
From: Pauli Virtanen <pav@iki.fi>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 10 Jun 2026 01:03:58 +0300
In-Reply-To: <20260609211111.3887657-1-simon.mikuda@streamunlimited.com>
References: <20260609211111.3887657-1-simon.mikuda@streamunlimited.com>
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

ti, 2026-06-09 kello 23:11 +0200, Simon Mikuda kirjoitti:
> bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
> are unset in Codec Configured state, so a Sink and Source bound for
> different CISes get linked. The stray link later propagates a
> disconnect to the wrong ASE and breaks Receiver Start Ready.
>=20
> Skip linking until QoS Configured assigns the IDs.
>=20
> Fixes PTS test BAP/USR/STR/BV-362-C
> ---
>  src/shared/bap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index deb85b264..98537de60 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2679,6 +2679,12 @@ static int bap_ucast_io_link(struct bt_bap_stream =
*stream,
>  			stream->ep->dir =3D=3D link->ep->dir)
>  		return -EINVAL;
> =20
> +	/* Don't link until QoS Configured assigns the CIS IDs; while unset
> +	 * the check above would pair unrelated streams.
> +	 */
> +	if (!stream->qos.ucast.cis_id || !link->qos.ucast.cis_id)
> +		return -EINVAL;

Zero is valid CIS ID?

> +
>  	if (stream->client && !(stream->locked && link->locked))
>  		return -EINVAL;
> =20

--=20
Pauli Virtanen
