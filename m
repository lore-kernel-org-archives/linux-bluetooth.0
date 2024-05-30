Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD0F17F50F
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081760; cv=none; b=qRh4o+r5g/IGvHzhjgm3LMadcLV//s6zeB5XJhZAIAW2bSxeoJfM2iNPSFRRkHGuwp40To754694GBENzrZjIIs6dZ/J/KCIhj5cFL5/WdRsIyWs/9q4z5WLF5GQpN5LvThyjc6ZgKlQYSWE2jY3kOcpbmnTRpaV//ETozWztrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081760; c=relaxed/simple;
	bh=kTYde7nSy3+7SVe3cRrdkF8Tx+ZhriZABu1OCff60qE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nDkDNam6HVW1KnZBT2FxCjZ3aKWLnSTHZoY8uYqJpvBiRYwAtJoS3PJVVlpmjp3DRmdEa24RL+TlljKGogEOJDwBI96LAbdWugFxvz5vm/DDAj/0rMiOJ4VN23GYeh1ad1QPIg+nLw9KZ5zP1Mljb8NMAAcU4Vznhyg30uQhfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5213F1BF20C;
	Thu, 30 May 2024 15:09:11 +0000 (UTC)
Message-ID: <6697d926f56bbbc074fed95645468541a72d3c98.camel@hadess.net>
Subject: Re: seid structure in profiles/audio/avdtp.c
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 30 May 2024 17:09:10 +0200
In-Reply-To: <99abd5269d6b72f391b39cec2c5f608654995beb.camel@iki.fi>
References: <78e4c9a65b6e7509a1f743f945270568a8548f26.camel@hadess.net>
	 <99abd5269d6b72f391b39cec2c5f608654995beb.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Thu, 2024-05-16 at 19:00 +0300, Pauli Virtanen wrote:
> Hi,
>=20
> to, 2024-05-16 kello 11:13 +0200, Bastien Nocera kirjoitti:
> > I was looking at the code in profiles/audio/avdtp.c surrounding
> > those
> > static analyser warnings, and couldn't understand how the seid
> > arrays
> > were constructed.
> >=20
> > There's similar code in android/ which might also need fixing.
> >=20
> > I could only find the code that assigned ".first_seid", nothing
> > about
> > how the rest of the structure is allocated and assigned.
>=20
> These structs are from AVDTP spec, see eg. =C2=A78.13 for Start Stream
> Command <-> struct start_req.
>=20
> IIUC, they're actually arrays of struct seid, but the first element
> is
> defined as a separate field. I guess the static checker chokes on
> that,
> and not sure right now if this is even strictly allowed in C.
>=20
> The structures are allocated in send_request() for the outgoing
> messages and the bounds checking is via req->data_size. For incoming
> messages they're raw message data from the remote device.

Thanks Pauli for the explanation.

The static analysers didn't like that construct, and I've attempted to
fix it in:
https://lore.kernel.org/linux-bluetooth/20240530150057.444585-10-hadess@had=
ess.net/T/#u

If that doesn't pass muster, we can also do a simple "#define start_seq
suspend_seq" and have a single actual struct type for both cases.

Cheers

>=20
>=20
> > Cheers
> >=20
> > PS: Please CC: on the answer, as I'm not subscribed to the list
> >=20
> > Error: ARRAY_VS_SINGLETON (CWE-119): [#def29] [important]
> > bluez-5.75/profiles/audio/avdtp.c:1675:2: address_of: Taking
> > address with "&start->first_seid" yields a singleton pointer.
> > bluez-5.75/profiles/audio/avdtp.c:1675:2: assign: Assigning: "seid"
> > =3D "&start->first_seid".
> > bluez-5.75/profiles/audio/avdtp.c:1679:25: ptr_arith: Using "seid"
> > as an array.=C2=A0 This might corrupt or misinterpret adjacent memory
> > locations.
> > # 1677|=C2=A0=C2=A0=C2=A0	int i;
> > # 1678|=C2=A0=C2=A0=20
> > # 1679|->=C2=A0	for (i =3D 0; i < count; i++, seid++) {
> > # 1680|=C2=A0=C2=A0=C2=A0		if (seid->seid =3D=3D id) {
> > # 1681|=C2=A0=C2=A0=C2=A0			req->collided =3D TRUE;
> >=20
> > Error: ARRAY_VS_SINGLETON (CWE-119): [#def30] [important]
> > bluez-5.75/profiles/audio/avdtp.c:1690:2: address_of: Taking
> > address with "&suspend->first_seid" yields a singleton pointer.
> > bluez-5.75/profiles/audio/avdtp.c:1690:2: assign: Assigning: "seid"
> > =3D "&suspend->first_seid".
> > bluez-5.75/profiles/audio/avdtp.c:1694:25: ptr_arith: Using "seid"
> > as an array.=C2=A0 This might corrupt or misinterpret adjacent memory
> > locations.
> > # 1692|=C2=A0=C2=A0=C2=A0	int i;
> > # 1693|=C2=A0=C2=A0=20
> > # 1694|->=C2=A0	for (i =3D 0; i < count; i++, seid++) {
> > # 1695|=C2=A0=C2=A0=C2=A0		if (seid->seid =3D=3D id) {
> > # 1696|=C2=A0=C2=A0=C2=A0			req->collided =3D TRUE;
> >=20
> > Error: ARRAY_VS_SINGLETON (CWE-119): [#def31] [important]
> > bluez-5.75/profiles/audio/avdtp.c:1799:2: address_of: Taking
> > address with "&req->first_seid" yields a singleton pointer.
> > bluez-5.75/profiles/audio/avdtp.c:1799:2: assign: Assigning: "seid"
> > =3D "&req->first_seid".
> > bluez-5.75/profiles/audio/avdtp.c:1801:30: ptr_arith: Using "seid"
> > as an array.=C2=A0 This might corrupt or misinterpret adjacent memory
> > locations.
> > # 1799|=C2=A0=C2=A0=C2=A0	seid =3D &req->first_seid;
> > # 1800|=C2=A0=C2=A0=20
> > # 1801|->=C2=A0	for (i =3D 0; i < seid_count; i++, seid++) {
> > # 1802|=C2=A0=C2=A0=C2=A0		failed_seid =3D seid->seid;
> > # 1803|=C2=A0=C2=A0=20
> >=20
> > Error: ARRAY_VS_SINGLETON (CWE-119): [#def32] [important]
> > bluez-5.75/profiles/audio/avdtp.c:1912:2: address_of: Taking
> > address with "&req->first_seid" yields a singleton pointer.
> > bluez-5.75/profiles/audio/avdtp.c:1912:2: assign: Assigning: "seid"
> > =3D "&req->first_seid".
> > bluez-5.75/profiles/audio/avdtp.c:1914:30: ptr_arith: Using "seid"
> > as an array.=C2=A0 This might corrupt or misinterpret adjacent memory
> > locations.
> > # 1912|=C2=A0=C2=A0=C2=A0	seid =3D &req->first_seid;
> > # 1913|=C2=A0=C2=A0=20
> > # 1914|->=C2=A0	for (i =3D 0; i < seid_count; i++, seid++) {
> > # 1915|=C2=A0=C2=A0=C2=A0		failed_seid =3D seid->seid;
> > # 1916|=C2=A0=C2=A0=20
>=20

