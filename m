Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E42228CBF
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813155; cv=pass; b=BapwVaJKvNTZ+mATgylwYnsoyqsvWNDFEHXsRUJ63mZPoWNv1M8TfTt3E3VatsaKzARIG72sMvgZkeIumDfp2cSFW6WKpqSqDCU/F2+lTy/zex26llauD3IaIuOmJ1lAKlmUwoO2Nn6NF6VM21XBJlI+m3RmtaG2wx7Bdzb6WGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813155; c=relaxed/simple;
	bh=r1CTxPcw/EzJvlbeYRtF/LB4bOhgioJnoxWOKT/zqwc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqSj3oGk/OMYVZmG40aYYerhrTmsoKbBNyq7uEzMlx2/etWIXmBsl81aCKfB68UKPLn/5/yRXCRy+hJxIfZt5J2l3n4ecbuNKu2WT1CNAbbhuD2Q57tP0aqHD3pFOvahBd8F+G5rPPS3RXmv61JINV01HlmVk5GJyKs9WK4xuQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=spuvjgtR; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="spuvjgtR"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YxV133yJHz49Px4;
	Mon, 17 Feb 2025 19:25:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739813143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r1CTxPcw/EzJvlbeYRtF/LB4bOhgioJnoxWOKT/zqwc=;
	b=spuvjgtRI2Kt1XTk0CzZa/xR0IpwoGHD1hj6BLpA8ZC6EGy/q0ZCMq7Bk8zFBvIMaoR2p2
	dq1DrWoPWHf5B9CTljpByRavIZOVkyIpjvcAM6ceDUie/Vig24HoFcDmWl+Z9Acy/wu2nf
	hbeRb5qk+GXMEYnpvYsh9hyEpl5eujB9xgCbfTk1/Dk4AxM8ATj7UFi9y2wSJz0YIKBP9H
	RGJhveZrW7i62xB9hQpv4WEa0RAwHtSc6/6PhKmgMRkceVa7FYLrZir7WWgWeN3lgthTsr
	xxP1k4PPY/3Hc++aFue10SQk1REx2IFNNUKg8xLP4AEqFSaq0YnpMJJj+7tQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739813143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r1CTxPcw/EzJvlbeYRtF/LB4bOhgioJnoxWOKT/zqwc=;
	b=TpUhrU2eTDkoXLQbEnx+5WO4V5/nCf9JFV3K75YHiAycPo8k5Rp6kQGcpqg3FmxLj+qdTZ
	i0eoOX/eB5TRmiUx9h0CsKjVKWo+SSjXt+MDv+eRpwBFjBoZlBqx49VHUnj19Zpfim78Ui
	YY/sLsuOI+qVVUjv+lWDpRGmaEQA7kvWWvNArce8DfvWpnxm9qsPoe+fUqmnxtXyHu4/7w
	3c961Q1OifKFC2DgeW3zqkryw6hhobax1D2s8nm0UN86wUejxQM0LOVDoZl1Gx8tdtYLvf
	g3OPEezKqusgMKuR5z71ocJmgO7pvCaqpyx3nsy9BjLtrJPL0zzH/u9F81wrCg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739813143; a=rsa-sha256;
	cv=none;
	b=RgEd4bUj6FKbN5Elxwxw8PPn940UlGwDt5ir4UBrXW0fEs+03YnFtKQ7UydT4ngDDyL9pE
	H2qHZR0IKgdjMf4c5GIN4/HK6aXm6j7Z8Ueji4bAgcW2WIyX1fPAcUt5MpPim/vLSl+gCP
	CrlhAUrMuULGNQcay0tlFvj1oIyr0/9mE4+un3/oAcM6c2G193QzcgTJ8BTMXtdRLtte0F
	c/PJTicOB1WjhrrO6tntvnJBZFiUQgSIm0spzDV0lVQMKjcPATZV40QkmhgWHPqdkO/0Sn
	uSfPtUkvhikT3Y8v53R+I/zL1zMoOgY3rucWUdOiIbEGthPjMoCutuuN5TOCIw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <3c1039e0cca1a88583710bb5f623d7ee1ff38c1b.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1] org.bluez.Device: Introduced PreferredBearer
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Bastien Nocera <hadess@hadess.net>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Date: Mon, 17 Feb 2025 19:25:42 +0200
In-Reply-To: <6b8b1f29602f8303eea241ae69a7fddcb15560c4.camel@hadess.net>
References: <20250214202129.968369-1-luiz.dentz@gmail.com>
			 <CABBYNZJmigw_3=5CZ5eaSGC8ZHTzmsZA11p558EtcET-FcrVEA@mail.gmail.com>
		 <3e36e6c2c9b201a5c06c0bc166cd4d38bb8067b3.camel@iki.fi>
	 <6b8b1f29602f8303eea241ae69a7fddcb15560c4.camel@hadess.net>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ma, 2025-02-17 kello 16:39 +0100, Bastien Nocera kirjoitti:
> Hey,
>=20
> On Sat, 2025-02-15 at 20:27 +0200, Pauli Virtanen wrote:
> > <snip>robably Gnome BT settings also would need to grow a
> > corresponding
> > setting. Labeling such setting so that people understand it is maybe
> > harder...
> >=20
> > There's a few questions:
> >=20
> > - Is there something that tells which bearers are available for a
> > device? It would probably be needed too if it doesn't exist.
> >=20
> > - Interaction with CSIP, if you pair initially with bredr I think you
> > don't get the other earbud paired. If you switch bearer + disconnect
> > +
> > connect, does it pair & connect the other one?
> >=20
> > - Who is going to be the agent that accepts the pairing of the other
> > CSIP devices? GNOME BT settings I think is not running all time (and
> > does it do CSIP accepts?).
> >=20
> > - Whether disconnect+reconnect should be needed to switch the bearer,
> > or if just changing the property is enough if already connected?
> > Maybe
> > it is needed?
>=20
> I don't have access to any CSIP supported devices, which is one of the
> reasons why gnome-bluetooth has no support for it.
>=20
> I think that the AX210 I have has support for CSIP on the adapter side,
> but I would need to know what cheap device I could get that supports
> it.
>=20
> This is tracked in:
> https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/130

Of the devices I have, Sony Linkbuds S has working CSIP + LE Audio.

It does not support duplex at 48 kHZ, so Pipewire needs to have some
config to disable input direction for it to work.
https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/LE-Audio-+-LC3-sup=
port

Samsung Galaxy Buds2 Pro, and Creative Zen Hybrid initially had
firmware that had working LE Audio, but the manufacturer broke it
somehow in later FW updates. These devices now refuse to Enable streams
or even connect. Not clear what the firmware of these devices is
expecting to get.

***

How it currently works in Gnome Settings:

Earbuds appear as two devices with the same name. If you pair one
earbud, it'll after some seconds ask if you accept that a device with
the same name as you just paired wants to pair.

If you connect one, also the other one usually connects after a few
seconds. Devices also autoconnect if they were previously connected.

If you disconnect one, though, it only disconnects one of the two
earbuds. The other one remains as available sound device, but now with
just one channel.

So the basics work, similarly as in bluetoothctl, but it may be
somewhat confusing to users.

--=20
Pauli Virtanen
