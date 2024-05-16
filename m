Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8292914D45E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875221; cv=pass; b=ZmXosQS2zVOxc0F90kBhelZl6vPd01fXJeZp75j22RpHWpPWeBwOaFXdfwJ5R1sB74WnLT2RvEQVlLn6hYIinb8U4lEhkVsMNK1uUScur6aTlq/Zj2afHEbxdS30xLP9TOvuWSPBq1N0TTWvlkHLWZ1jMB4qF9x3wvrsDecuscY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875221; c=relaxed/simple;
	bh=k0JQcN14OsqtVBdNVS345clT+N3t4Yqhsuxfyf2Grpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGCfNDhQ4QANZfnMG827p7yOT7/gqgVcleSNJniqls2GJZI2qXgHxEUke9ErYulFbBPnefTMU/AfKPhfOGx1DtZN76jlbsB6oifxtkaOzFeRCKE27fNvBN2RbLBx/JVWD3+++U6bPXK3W46g8mobNCM4FTgS7l9aiOG5mgjoAtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=unvBmXoh; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="unvBmXoh"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VgFD809Rnz49Q5W;
	Thu, 16 May 2024 19:00:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1715875209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Jgby1G4S9dU8I4NXJikeU1oTrOGj0yg2PcN0u1/EsE=;
	b=unvBmXohGMTQrktDYFJ8MmQ2nccP6klVt+Ko/ba0s6gN02h46hRdbWdQnd1C01EUJOrl6V
	DgnEqrudifpsYUuuSD9Oe9/34ZJn49uazO05vp1w5+TPVsm3HiD6wtayLJJ+LjPAJxm6bR
	TPpKc0u0taklPstHW3VnUitlFsOkL8b/i3XRyUn1RlmWNkg58ZdcimH1xvIOuEO8DalN8L
	411k8o4OkEph3MLWMZV72opmrTEo4dq+ahEYP3TCYJs7Cvdy3Y0+J7xLbzPIXiCSMc96sw
	LBbT/7ZNumzhj5L4N3/UWoJr2HAM4h3dRfw1zZVaQFGHTDZ1cbF8f5h8ndkRBQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1715875209; a=rsa-sha256;
	cv=none;
	b=qKnXICLvpnYyBn8Zlj0QZSYrbm1+dtr0tNSnieKyBkRt1dwKc/33YZRK0TAzKuTL//ozMw
	JLXNoY4jfGkVIga5ZgzTNO4Nh2SVabJB8Tfp0RYoHPyl0145DIJILN9rfzmT8o9i8r8N4s
	FUL89PhBPAW+EfqheJgWDH/wbOoNLuVOT0MdbM7URzlforbKim2PGBhRVdbBmhRLh7Ud/x
	z3RaVXPDXT1VZEY0WP5ByuwJQy5aPxBOGpq8M7dc7mdiQ9qk1+d/hPvxQIf0wb9Im6gtEy
	TESZVEtZ57QPjutj0iF5iHBo7gglzUbsCLHLqFNxRMtfOEQOxFNm+KyaYWJHXw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1715875209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Jgby1G4S9dU8I4NXJikeU1oTrOGj0yg2PcN0u1/EsE=;
	b=eAoK7XSM6I7YCk2FhOAMuFCOvqSQo7dcG3o6SEJWx//2Be+jRMBng+vuSC+dxyUKW0qlnh
	zX986WCLMHq0RXz8hbU5D7iFHRc/ilg0pCdDuhxDpqzQUg+LA5CjSC/3nKA7iTemNyYXqr
	BPjWEYU2X1AHSG2Cycsama1YMDjxVzQYAp/gkFf2VsAx6AODnxgkTepr15RGWaFD9aZB3V
	F+/f9RmZ++rk/Doa2sE2esCuKlqRVU2UpjNK+qO7b1fsX/viNWhDLxLbVSG411hWI6gBFG
	JE6vFlWvN1bYtA+G1/42evcZ/g0BKDmROS3lY7cEqY8ixJwv3S7zwaszGFfgZg==
Message-ID: <99abd5269d6b72f391b39cec2c5f608654995beb.camel@iki.fi>
Subject: Re: seid structure in profiles/audio/avdtp.c
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 16 May 2024 19:00:04 +0300
In-Reply-To: <78e4c9a65b6e7509a1f743f945270568a8548f26.camel@hadess.net>
References: <78e4c9a65b6e7509a1f743f945270568a8548f26.camel@hadess.net>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2024-05-16 kello 11:13 +0200, Bastien Nocera kirjoitti:
> I was looking at the code in profiles/audio/avdtp.c surrounding those
> static analyser warnings, and couldn't understand how the seid arrays
> were constructed.
>=20
> There's similar code in android/ which might also need fixing.
>=20
> I could only find the code that assigned ".first_seid", nothing about
> how the rest of the structure is allocated and assigned.

These structs are from AVDTP spec, see eg. =C2=A78.13 for Start Stream
Command <-> struct start_req.

IIUC, they're actually arrays of struct seid, but the first element is
defined as a separate field. I guess the static checker chokes on that,
and not sure right now if this is even strictly allowed in C.

The structures are allocated in send_request() for the outgoing
messages and the bounds checking is via req->data_size. For incoming
messages they're raw message data from the remote device.


> Cheers
>=20
> PS: Please CC: on the answer, as I'm not subscribed to the list
>=20
> Error: ARRAY_VS_SINGLETON (CWE-119): [#def29] [important]
> bluez-5.75/profiles/audio/avdtp.c:1675:2: address_of: Taking address with=
 "&start->first_seid" yields a singleton pointer.
> bluez-5.75/profiles/audio/avdtp.c:1675:2: assign: Assigning: "seid" =3D "=
&start->first_seid".
> bluez-5.75/profiles/audio/avdtp.c:1679:25: ptr_arith: Using "seid" as an =
array.  This might corrupt or misinterpret adjacent memory locations.
> # 1677|   	int i;
> # 1678|  =20
> # 1679|-> 	for (i =3D 0; i < count; i++, seid++) {
> # 1680|   		if (seid->seid =3D=3D id) {
> # 1681|   			req->collided =3D TRUE;
>=20
> Error: ARRAY_VS_SINGLETON (CWE-119): [#def30] [important]
> bluez-5.75/profiles/audio/avdtp.c:1690:2: address_of: Taking address with=
 "&suspend->first_seid" yields a singleton pointer.
> bluez-5.75/profiles/audio/avdtp.c:1690:2: assign: Assigning: "seid" =3D "=
&suspend->first_seid".
> bluez-5.75/profiles/audio/avdtp.c:1694:25: ptr_arith: Using "seid" as an =
array.  This might corrupt or misinterpret adjacent memory locations.
> # 1692|   	int i;
> # 1693|  =20
> # 1694|-> 	for (i =3D 0; i < count; i++, seid++) {
> # 1695|   		if (seid->seid =3D=3D id) {
> # 1696|   			req->collided =3D TRUE;
>=20
> Error: ARRAY_VS_SINGLETON (CWE-119): [#def31] [important]
> bluez-5.75/profiles/audio/avdtp.c:1799:2: address_of: Taking address with=
 "&req->first_seid" yields a singleton pointer.
> bluez-5.75/profiles/audio/avdtp.c:1799:2: assign: Assigning: "seid" =3D "=
&req->first_seid".
> bluez-5.75/profiles/audio/avdtp.c:1801:30: ptr_arith: Using "seid" as an =
array.  This might corrupt or misinterpret adjacent memory locations.
> # 1799|   	seid =3D &req->first_seid;
> # 1800|  =20
> # 1801|-> 	for (i =3D 0; i < seid_count; i++, seid++) {
> # 1802|   		failed_seid =3D seid->seid;
> # 1803|  =20
>=20
> Error: ARRAY_VS_SINGLETON (CWE-119): [#def32] [important]
> bluez-5.75/profiles/audio/avdtp.c:1912:2: address_of: Taking address with=
 "&req->first_seid" yields a singleton pointer.
> bluez-5.75/profiles/audio/avdtp.c:1912:2: assign: Assigning: "seid" =3D "=
&req->first_seid".
> bluez-5.75/profiles/audio/avdtp.c:1914:30: ptr_arith: Using "seid" as an =
array.  This might corrupt or misinterpret adjacent memory locations.
> # 1912|   	seid =3D &req->first_seid;
> # 1913|  =20
> # 1914|-> 	for (i =3D 0; i < seid_count; i++, seid++) {
> # 1915|   		failed_seid =3D seid->seid;
> # 1916|  =20

--=20
Pauli Virtanen
