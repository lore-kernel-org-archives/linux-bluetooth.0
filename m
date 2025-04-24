Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56F202C5C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527439; cv=pass; b=lfS2hXK6bwnTVecm22CWnx4uy1TYcs4t3zgWiwQ75MYpH5aU2dhLe1CwygyHm4tIF3GUR8Tqa9bZGckFrPw5rKStsLukYkNWhXKPAm6cN/6vcs2cxeeuB6ZTJ+7eaP4UPNnw/pzGzkSX3lGJqezjIoqnubhm26zXTm6G38FT8Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527439; c=relaxed/simple;
	bh=ygA57Kjv56TuY/FNJ3BoT/duAMX/GHdsoIc5rbAykRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gw6eMCaJqcmwYyqwrBUd7lL+C/M+jC186KB5HUVoy3JIT4iHymcmqb/Iq8qlQ96LD3w1kJXnh0l5POTyxWzdpHSSNtX5dvyIjQEEtgbTgJNiWFsr7urzr32yhri79++XkSkk1JEG5gc2ec8Rdh374jXjT6gurntc1oKrahx6q4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=MB9OWUgk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="MB9OWUgk"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zk7HB08Ygz49Psw;
	Thu, 24 Apr 2025 23:43:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745527430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqI60/Jke2ESMkhuK8WSF1zcRzCxb7FegIrnGJ64tC4=;
	b=MB9OWUgk4caBcmyjcxGnFGcUv5Ymqks/u6LMyQ36b7SUS8Lt4/l6LHO4AYfho/Ib1HVHJn
	oa0krBiWOiULB9PN6Fr0Yj+GzLaAXnNFSAmjWV1ISRrH9Cf5S5tVY8Y3mPelquWR9Za9dL
	tYY+ESJHI8Bj4YYXiUXjsem07RXCTdldMHm5zbZ9lpT5nCsGZlAUF2USY0IgPNVWMpQf5i
	jNZwhohJRMX38RR4FLkANnLx2J5VRE8OU+Jmrb1H/UcNpMv+rM4FHHJxoYjtbRZ06bCyQK
	5IftNg4KYyS6y7qyDINXeAKBNy8JGgDyIAeWinUAbkHgCAOyOtyflJBn3HP/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745527430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqI60/Jke2ESMkhuK8WSF1zcRzCxb7FegIrnGJ64tC4=;
	b=opR01jIhuOLkgVln/PKE3aZUQRqfwN7zpcAGq6LWLpnfy8E9xTorsg0xv9wH6IQR8dWr0M
	6sOjr3nM9lsgGs2DkC6qo4Z5X8mgyajURIJ/+foZZOeBiCEyLOgvrz/HevduUj1EV8f7rv
	WCd6SQ4WMiu+LBD/nifBAgT7Ze9At9YVHyYjcxefAi0f38vqnUgoXAJ4bxxzOm3ATCmh+C
	iQa+YkotT4wthH/yx0TNfCCHa/oRqWYguEZAHY2+m/qYpjBVvJdmDlWKuZNCloKmpUhx6h
	/4VSAMumK1l37mzGzVk9iWuAQaTonFsAjse4OtjK/nX7WKlBMlmgReLecYnAPw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745527430; a=rsa-sha256;
	cv=none;
	b=Bvo3vfK98Ok1QeUEtbBlz3EjGZM/E88LnqI+0nYC6n946rkExB4ua3lsDpWXntQ5NUxCVN
	R7Dzq39lMJrB5/bDxaFvzoW4PMBtLPIZd+KuqRGeGBd3dlLTnbqbrYGeIyY8wFtJySNc6A
	wUCOX3S0kv5UQKZqd1nVsuOUvIGfUleH4cXeFIhlRmjj34mwKuFi5zCHYzZglK9uMpeL2e
	cAO7+dtF7P0yZ3o0I/h6TkoTM4mzCob9BIn1xqdg4AjDOQz6MFD59Z2tZ+sIGBP/z7ID7p
	5XWOg7nxFKv/i2oXm3e7k09wT3ggSEBJXs0+LIlItH7GdGi/1MJBBhYmko9wMQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <a19c84b9214708ac13270a024c15619daaa2c231.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: L2CAP: copy RX timestamp to new fragments
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 24 Apr 2025 23:43:48 +0300
In-Reply-To: <CABBYNZKRDZRUW-H9gXaS3kjxgcK8UXieQ0_S2Gtdjvbctgks-g@mail.gmail.com>
References: 
	<01117138d56019a8598f24f0df2dd289713cfab4.1745524193.git.pav@iki.fi>
	 <CABBYNZKRDZRUW-H9gXaS3kjxgcK8UXieQ0_S2Gtdjvbctgks-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

to, 2025-04-24 kello 16:19 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Apr 24, 2025 at 3:59=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Copy timestamp too when allocating new skb for received fragment.
> > Fixes missing RX timestamps with fragmentation.
> >=20
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
>=20
> Hmm I though it only matters for TX timestamp but this is actually
> different,  anyway I don't think it would be possible to backport to
> that old patch, so we might need to use a more recent one when we
> introduced l2cap_recv_frag to make sure it properly backported:
>=20
> Fixes: 4d7ea8ee90e4 ("Bluetooth: L2CAP: Fix handling fragmented length")
>=20
> I can fix it up in place though, so don't bother spinning a new one,

Yes, that's probably first where the patch applies directly. The bug
itself is old.

> btw shall we replace the __net_timestamp with skb_set_delivery_time?

AFAICS the __net_timestamp() in hci_recv_frame() is correct as it is
now.

> > ---
> >  net/bluetooth/l2cap_core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 5ca7ac43c58d..73472756618a 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -7415,6 +7415,9 @@ static int l2cap_recv_frag(struct l2cap_conn *con=
n, struct sk_buff *skb,
> >                         return -ENOMEM;
> >                 /* Init rx_len */
> >                 conn->rx_len =3D len;
> > +
> > +               skb_set_delivery_time(conn->rx_skb, skb->tstamp,
> > +                                     skb->tstamp_type);
> >         }
> >=20
> >         /* Copy as much as the rx_skb can hold */
> > --
> > 2.49.0
> >=20
> >=20
>=20

--=20
Pauli Virtanen
