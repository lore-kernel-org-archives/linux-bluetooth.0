Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2234CFB3
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466114; cv=pass; b=XR4c6am6JR5tpuvzQV8JKsmUDeBIPu9oSHPkXv4LD4O2Qc7K66x0zF1UdtxESjiRK/PviC3+DCrB1+BaQhTShmIiaXHVjydEEDcXnHd3a5WKjl7S1oSODiI+RKpo3ajO5vjAcVak3eQbKb+/v6wBIw8EfkWViFFfD42dj8qZqXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466114; c=relaxed/simple;
	bh=17uL7JqHbOdiM2LCamOjd/sRNjP9sKh1QCAnUmr3srQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJwJwmOWM+irKGQNaWH6KBKVBQGR5ToLleL6TBDFNON62n7efzBO9htHRK3ZZt0ICNiN6FOF52zYquCGKBRqDcXfOJ2v46thknocaj7YYqXwzHoOlw12Sf1KcK9Jd4u22mPGgWtQfkWUw0M9qfEmReT6iy/ce1LfOxp39YfZg98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KvYxG0ac; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KvYxG0ac"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fgxSB4fsMz49Q53;
	Wed, 25 Mar 2026 21:15:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774466107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yPKFZksGAfP47am+szcwpVl/SftLS/BdJnxM9VS0F3I=;
	b=KvYxG0ac6KzC4z4XXoprL1TwARAodzBcbDPx2qhTnofnQyPAGKosNh4+cilLHZiZuSfnBv
	VqM+iAX0mS67he657Vdbgnac1WIUQcnU3FZPBR7MrgZBaIbELnoXchhXHMC+6UjwmLQHJF
	aXwpPi+ph4bJvyvbTyQkgP5AOu6+A0HR7RYhmDu+A8NRe/2tTN4IIvAxw/Wz7kDm5xUNpj
	H3h2aV+FvzJkMt1e6bpiF/4lp2kfCAD3vMO3U9TmvSFOX957oHS1vKbxDe3u5p1if9DP9w
	vgv31AiC6eo2ZW/py2jQ5kk9yoECvV/ARVKoPYepbYSdNJqCtUSfw92p5OnnYw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774466107;
	b=SksPYvF0UxmFKBV2ZuUUzoPlCXDFvCZ7AGV01BTA3ilyoadykn1wzIQ6YaG4YEUJVY019L
	xKTgmpGAFgOQ4+4qt9hwNsrnTxzb2mPoMnzkIAj5RjRNEailjAen7H/3XzGIgDoxlgMJ/m
	sAOS3QDJXZ8xpSOhZhKG5C+X20Y8JD0GBVAy5aJTp2WNaTDG2tPNjrxH2XdtAKfqzB9X09
	l6m2VcW5GOmjmTqi2J1s8zLz4IbNgkq2tmfj2KAZOnQDbC8uxubOAvwx9CsXdLiyeb/ptf
	22vk8uvcaFj1mrm7MzBmjDDP2fZHMILsqJ4/DPKRD4kULXJr4Uw6qD6sPHoK8g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1774466107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yPKFZksGAfP47am+szcwpVl/SftLS/BdJnxM9VS0F3I=;
	b=YdbUInDuAkri8htp3Xi38S/AnFbgZzfAYAF3+45RJKEPMN98MdG47tb4Ud13IBhc4XtHR3
	96L4hVPHNFmFcCWHYnO6KWkcYs7YuLUBWtUgUlNTBMVMAT7aT+gdE4HlMsyQnUP8U47Kg0
	PVe4sX+YgDM1c4hIkMEyD8BIEf1P1QTDQb24ySK72SeRIc/1rOuLMxgVdNYVW1vuM+E6l9
	sb15iANi7m43hXv6iNKAHjLTHmkbkGjgMJklQr4Ofz1uYVg+1J81X0u5so2Sdx50kvEQqb
	hr4VbX448HKDmU9SMC5/DhGhknLep/6ktP81Qm7SbGfjabuJjFMW2Bzfd2MGtA==
Message-ID: <96256cdd679395e70b8317db7655ec6dfc4c9386.camel@iki.fi>
Subject: Re: [PATCH 3/3] Bluetooth: hci_sync: make hci_cmd_sync_run_once
 return -EEXIST if exists
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 25 Mar 2026 21:15:05 +0200
In-Reply-To: <CABBYNZ+aBV2C6NQ=Pv_1ZRhhnntcd46bkOS2gj1sj_X4PoUjjw@mail.gmail.com>
References: 
	<f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774459946.git.pav@iki.fi>
	 <1eec5447ed02666ef9463bbc96c25971ce9c0d1f.1774459946.git.pav@iki.fi>
	 <CABBYNZ+aBV2C6NQ=Pv_1ZRhhnntcd46bkOS2gj1sj_X4PoUjjw@mail.gmail.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
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
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2026-03-25 kello 14:43 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, Mar 25, 2026 at 1:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > hci_cmd_sync_run_once() needs to indicate whether a queue item was
> > added, so caller can know if callbacks are called, so it can avoid
> > leaking resources.
> >=20
> > Change the function to return -EEXIST if queue item already exists.
> >=20
> > hci_cmd_sync_run() may run the work immediately. If so, make it behave
> > as if item was queued successfully. Change it to call also destroy() an=
d
> > return 0.
> >=20
> > Modify all callsites vs. the changes.
> >=20
> > The only callsite is hci_abort_conn(), and this changes its return
> > value. However, its return value is not used except as the return value
> > for hci_disconnect(), and nothing uses the return value of
> > hci_disconnect(). Hence there should be no behavior change anywhere.
> >=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  net/bluetooth/hci_conn.c |  4 +++-
> >  net/bluetooth/hci_sync.c | 13 ++++++++++---
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index e6393f17576b..8cc2cc58c3f8 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -3077,6 +3077,7 @@ static int abort_conn_sync(struct hci_dev *hdev, =
void *data)
> >  int hci_abort_conn(struct hci_conn *conn, u8 reason)
> >  {
> >         struct hci_dev *hdev =3D conn->hdev;
> > +       int err;
> >=20
> >         /* If abort_reason has already been set it means the connection=
 is
> >          * already being aborted so don't attempt to overwrite it.
> > @@ -3113,7 +3114,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reas=
on)
> >          * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
> >          * already queue its callback on cmd_sync_work.
> >          */
> > -       return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL)=
;
> > +       err =3D hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL=
);
> > +       return (err =3D=3D -EEXIST) ? 0 : err;
> >  }
> >=20
> >  void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 0b28495197c2..47d902310b19 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -801,8 +801,15 @@ int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd=
_sync_work_func_t func,
> >                 return -ENETDOWN;
> >=20
> >         /* If on cmd_sync_work then run immediately otherwise queue */
> > -       if (current_work() =3D=3D &hdev->cmd_sync_work)
> > -               return func(hdev, data);
> > +       if (current_work() =3D=3D &hdev->cmd_sync_work) {
> > +               int err;
> > +
> > +               err =3D func(hdev, data);
> > +               if (destroy)
> > +                       destroy(hdev, data, err);
>=20
> It is probably worth splitting this change into its own commit so we
> can add a Fixes: tag and backport it.

Ok.

Btw, sashiko produced valid comments on pre-existing usage of
queue_once, maybe some of these should be hci_cmd_sync_queue or
queue_once needs custom comparison API

https://sashiko.dev/#/patchset/f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.177=
4459946.git.pav%40iki.fi

>=20
> > +               return 0;
> > +       }
> >=20
> >         return hci_cmd_sync_submit(hdev, func, data, destroy);
> >  }
> > @@ -818,7 +825,7 @@ int hci_cmd_sync_run_once(struct hci_dev *hdev, hci=
_cmd_sync_work_func_t func,
> >                           void *data, hci_cmd_sync_work_destroy_t destr=
oy)
> >  {
> >         if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
> > -               return 0;
> > +               return -EEXIST;
> >=20
> >         return hci_cmd_sync_run(hdev, func, data, destroy);
> >  }
> > --
> > 2.53.0
> >=20
> >=20
>=20

--=20
Pauli Virtanen
