Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795F296BA2
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931957; cv=pass; b=ju3D9zhVrZTHICKkOQO+INIEkMxLQOjYAvcz7DeVdbTkrMLY5ETxdiGb8RsxlISh1coOtYoWZPHt5N2POUtULPOuGMCu5uwadi4GssPq/YP58fEIF7+aywBSPcDAHtSvEf3TOhbC2AQAB689swVQkkc2DPTUVRptccgcvcDCSrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931957; c=relaxed/simple;
	bh=OzmDr7asAh8QRdjIoi2K7kIlqDJzH+9YnZtMRvevOAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZfkVG/diaxX1ir3ozbckv5/I5ia/kiyEJjAOshysmmrfB7pkkHHxIxRgyPd8NZvg7mCN6AvAJN8RnUp1eFgpTIs9EurWImTqPcJbcoXN28KFc78UAxZWlYUD4tk2WuWAqyI78b9LhK5kPql6mXqY2kCkCkg9QCmVc+bw67c9nSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=smD4sho9; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="smD4sho9"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4c11HJ4w05z49Pxf;
	Mon, 11 Aug 2025 20:05:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754931948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H0ATPgLUZfniQjBJuuNT2naf4IjyXnxN/BHhxhnZasw=;
	b=smD4sho9jCv5TRgUaV2aqx4ZVAm+0vFbG6V6Yn8cZ6Xo5n96X/z0HTA/vKATwe6hN9GP4S
	XoaupfMIKpLubCs1oUUelZaAf5jGdv4sGRJkorMc2ceWomdrsYVyYXlzo5phuD2dapdnHe
	oNAkX1VFb26GDBS4eidGW7OJhczMEVEVpK3zCeypW8OWZT/nVvAw/0kJswOHC6YpUJHJ8e
	CbiDBqjL9s9JLmegdBDk0+uv9f+bApRgsndpFcQzfHH61tj/bEAL2KwvDNT/ZpRIe+4sgZ
	PMKOFxhuR2ykjiphvmt4sUFGk/d4rfYimBjf/FlBy0FtMw99IcH0tsLB8fspyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754931948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H0ATPgLUZfniQjBJuuNT2naf4IjyXnxN/BHhxhnZasw=;
	b=cP27zpc7BhycT6Y9YyXfTrMXEVRpa4Vqs2pkANA1Ok7pXelp/8LXbfIDZrgRHqliD3plYQ
	ORyQHC4qWLzGjEG1MuJsnS1zmq0rajfNAlwASR85aEvuw3xDIXT976wzDv0w2NviPdoa6z
	vn3tnvtJntTy1r1HTenC4NFDOv6y74ub7B3OQ+YCPPAyISvt/vTE0nWkEqkS4wo+xrAGVu
	TJabQ3MrWrfPBD2q3d7YfytHW7zAt708e92KtS0uit5Q4B9wiGwW+IuNI/B/vsCMRR37/C
	BzJ1CCerWCRnNvYHGmdbdEES6ZuU8WKwBCW1ABjh+hhpIbZ1TTyaaUbxnqEKng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754931948; a=rsa-sha256;
	cv=none;
	b=QqQoY3nxN1K+vsh8ul/+YCWPX6/h2tsNW02xnBoN8vMRISPRhOHxHbKJYCJgNf8uGo/DNs
	0md2zpBjlocclHk1JZlOFTTcxqp8K0quE1l5J0YPGxbnEYAbDLOaIou1412CxTTr7CRHDf
	o2GQeY1XhxIiUB+gZs76cSvApQKpCoz98VzMArUlbwS/0TCPXii8MkPIytMnM6R8UL7K+a
	aXeXAggdcXqnXafmfYaK6axHSyy0a+AqOaXxcGkvmpubLs+HQNXrEuX21NVY2yTqdeRQFO
	kwqbKKsSNQW5ECewdrDJBoGUSk5WSK/cpixo0Ucz4p8rXN8J+UCZWidJYWu0dA==
Message-ID: <84edc0cd137307d7baba0b8d3a002e7a3593d111.camel@iki.fi>
Subject: Re: [PATCH BlueZ] shared/bap: reset local ep states on bap session
 detach
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 11 Aug 2025 20:05:48 +0300
In-Reply-To: <17eac95c2065b3a21f3d647a3422b3f099cccb46.camel@iki.fi>
References: 
	<d31b0994cc4ffa178f044be156e95324bdc0e64b.1754849783.git.pav@iki.fi>
		 <CABBYNZKpYS=55P06PendXTT-VF+hyMqd4n94koXWrtbc9Li14Q@mail.gmail.com>
	 <17eac95c2065b3a21f3d647a3422b3f099cccb46.camel@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
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

ma, 2025-08-11 kello 19:54 +0300, Pauli Virtanen kirjoitti:

[clip]
> We could reset the endpoint state in stream_set_state() if there is no
> session, if that sounds better, instead of doing it in bt_bap_detach()
> like here.
>=20
> IIUC stream_set_state() is supposed to be called only for streams to
> local endpoints, but not 100% sure if it's so in practice (re:
> broadcast or stream_io_disconnected).

Well, now that I wrote it down, of course bt_bap_detach() itself calls
stream_set_state() also as BAP Client. That would change remote EP
states, and not sure if we want to do that.

> > > Fix by resetting all ASE to IDLE state after detaching all streams.
> > > ---
> > >  src/shared/bap.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > > index ed5c322b4..d4beb9818 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -5664,6 +5664,14 @@ static void stream_foreach_detach(void *data, =
void *user_data)
> > >         stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> > >  }
> > >=20
> > > +static void ep_foreach_detach(void *data, void *user_data)
> > > +{
> > > +       struct bt_bap_endpoint *ep =3D data;
> > > +
> > > +       ep->state =3D BT_ASCS_ASE_STATE_IDLE;
> > > +       ep->old_state =3D BT_ASCS_ASE_STATE_IDLE;
> > > +}
> > > +
> > >  static void bap_req_detach(void *data)
> > >  {
> > >         struct bt_bap_req *req =3D data;
> > > @@ -5696,6 +5704,7 @@ void bt_bap_detach(struct bt_bap *bap)
> > >         bap->att =3D NULL;
> > >=20
> > >         queue_foreach(bap->streams, stream_foreach_detach, bap);
> > > +       queue_foreach(bap->local_eps, ep_foreach_detach, bap);
> >=20
> > This sounds more like a workaround though, the stream_foreach_detach
> > should have cleaned up all existing streams and their endpoints, we
> > could perhaps print a message if the ep->state is not idle then it
> > means something is not quite right.
> >=20
> > >         queue_foreach(bap_cbs, bap_detached, bap);
> > >  }
> > >=20
> > > --
> > > 2.50.1
> > >=20
> > >=20
> >=20

--=20
Pauli Virtanen
