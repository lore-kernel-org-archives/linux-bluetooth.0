Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455526E64A
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691372; cv=pass; b=YVeALJQ/kY/FX8WtQg07VmxNwb7SPgGkyuS31uOFsY6N2W+mYZKEon8TEXeG8+4fF1SUYwV+d1cy1wD8PjWKMAatD0m2RQ+FB3gPBhpsRUJc7bFBz8ng5YRw5bTIkPoJvQ9xwf/s0HzZwwRinFYPggl8IQGqQ6mPkrRtvZsYAPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691372; c=relaxed/simple;
	bh=QkjGFs6ZUcQggylKPzwYDtAXFzOUDML892aurwMu98g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=suJu5DmOtgnFuB6zz636zPKbG8IX4nqQX87EkwYehtK8efgYXUYWp3W0yHZ2XiaQdOPYWIarCuUSwt13K7G41DnZ6mwf/Twyg2jh6lUWfTSPCQKOEJ/FlHJY4jBfbd2nYJCT6eEVMUgDx/sDCmrDtT+UruusNb7PW0b5zg3MJsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nqOSfoLV; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nqOSfoLV"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z3knx2z0fz4BKJL;
	Thu, 27 Feb 2025 23:22:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740691366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TXDjPo9W7XMMW7IUhR1tBaz7/8AqEYvYe+AC+oAoUUU=;
	b=nqOSfoLVNTAsHLJ+wdg4M4MP2RsLDfLCHn2wubMtGttRSPPPgYiITrJ80+CMWpVi4pVku0
	cXgaDRDHUjK/DTbM8l2xQeVCyUBZDg6Vip0l8iHDq+OVUCJpCsMBX3qiLoVdFLAzgIklz7
	8fYJEaq8ljLns+IlOnI3o/BdTxt+xOkI+0K+rQcccfKJGuyguLME6YwwMZuBG0pqcsu7G4
	6a6YYG74pwpOZs5qxHGvC8ub+/8rMdz75fIs9JB+eSaRT9kS0/yP2tQPbhofUtQxCj5eaU
	okYSrWHG/BfAufnBAhSGOodZYvUusUJFlCMYxEzzYP5uWEVmwKsgfrsz5JyCSw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740691366; a=rsa-sha256;
	cv=none;
	b=dN8ITZmstw1a/tpsUkvXj2qdYZwSSI7+wOiFHPExnF+pInshBWTISMMIVDOIxrjuHI1/fO
	eUnqWuoxRvRZPwrxKP5MGBbeGEgQsbk+RML7lVwcAFElpVm144Tv0sy49diUWKq4DVEZin
	dT3xej0YUvsE4VMFWd9sUrxdbbL8LMAYz0XoAWVJFManoJmP5Lfx9WXqg4YLDLPm23z9Ax
	NtxUOH3L+yNAO4JLTWKXZ8vj2D4px4aMzlOcu6ESRFWm+Zv/ldPNWBcw0AZz0m1kjz/KMv
	ozVjyO15faHnv3B48KkFAZ1cwFCbQdPV0FWg9LSDZCjjITJsbA6/V5ChwxLLvw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740691366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TXDjPo9W7XMMW7IUhR1tBaz7/8AqEYvYe+AC+oAoUUU=;
	b=tIw7RQdw3c535KqVwBIo5xWdVBX3S+/Xaw0V4cEMlZfmcIaOryqlrQhVjlQZEwlVnhiQP8
	rAKV5V+M2vBc47/lwecWSCheAnMsYb4BqOTE5hpIv5j2PV8wsiD6K4bpl2WlEySngjOXJR
	WshrG/Aofs/g1iuZP97vvMDa9+KHD0ny35XBP0op2ZMw7/omQnxvBzUDirGKDKV6y9ICeZ
	w4cADZLi5hUaXrzZ0cq3xcVcfJ/eiwG90hobQRK30+J/cRioGbmovm70nM9cFAIX5JHoC7
	Rz3a8mEYdrlTDwQGcpzf0pbvdBy177uw1P+BlhrIwQZ1Nr3EvSdmc/BEusaDVQ==
Message-ID: <e351e931add011a719c6ddb26b023a2d62884109.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: SCO: fix sco_conn refcounting on
 sco_conn_ready
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, eadavis@qq.com, luiz.von.dentz@intel.com
Date: Thu, 27 Feb 2025 23:22:42 +0200
In-Reply-To: <CABBYNZJ=zqw1YN-S2JaA=swQk8+T+hL3+757t2y2P1ZMJzeoJg@mail.gmail.com>
References: 
	<dd9eaa0aee1e2fbeeb2015b807a3a2701af3a1bf.1740686998.git.pav@iki.fi>
	 <CABBYNZJ=zqw1YN-S2JaA=swQk8+T+hL3+757t2y2P1ZMJzeoJg@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
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

Hi,

pe, 2025-02-28 kello 01:38 +0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Feb 27, 2025 at 3:12=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > sco_conn refcount shall not be incremented a second time if the sk
> > already owns the refcount.
> >=20
> > Fixes SCO socket shutdown not actually closing the SCO socket.
> >=20
> > Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco=
_conn")
> > ---
> >=20
> > Notes:
> >     Making the sco_conn_add refcounts consistent in ed9588554943 expose=
d the
> >     issue here.
> >=20
> >     I think this should fix the situation, but didn't yet test this in =
real
> >     use, only the sco-tester test case.

I now tested this, it seems OK.

> >=20
> >  net/bluetooth/sco.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index aa7bfe26cb40..ad09b1b8e89a 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -1353,6 +1353,7 @@ static void sco_conn_ready(struct sco_conn *conn)
> >                 bacpy(&sco_pi(sk)->src, &conn->hcon->src);
> >                 bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
> >=20
> > +               sco_conn_hold_unless_zero(conn);
>=20
> Shouldn't it check if the result is NULL otherwise perhaps we should
> add sco_conn_hold which doesn't use kref_get_unless_zero.

It's guaranteed to have positive refcount here, as the sco_conn_add()
from connect_cfm keeps it alive.

I'll add sco_conn_hold() to indicate that. Also need Signed-off-by...

>=20
> >                 hci_conn_hold(conn->hcon);
> >                 __sco_chan_add(conn, sk, parent);
> >=20
> > @@ -1411,8 +1412,10 @@ static void sco_connect_cfm(struct hci_conn *hco=
n, __u8 status)
> >                 struct sco_conn *conn;
> >=20
> >                 conn =3D sco_conn_add(hcon);
> > -               if (conn)
> > +               if (conn) {
> >                         sco_conn_ready(conn);
> > +                       sco_conn_put(conn);
>=20
> Well we did this a little bit differently in iso:
>=20
>     conn =3D iso_conn_hold_unless_zero(conn);
>     if (conn) {
>         if (!conn->hcon) {
>             iso_conn_lock(conn);
>             conn->hcon =3D hcon;
>             iso_conn_unlock(conn);
>         }
>         iso_conn_put(conn);
>         return conn;
>=20
> But it looks like we changed that with ed9588554943 ("Bluetooth: SCO:
> remove the redundant sco_conn_put"), I wonder if we have something
> similar in ISO as well.

Probably making sco_conn_add() always return the extra refcount as in
ed9588554943 makes sense.

AFAICS the current ISO code is OK vs. this issue, although it would be
best to keep them in sync here.

>=20
> > +               }
> >         } else
> >                 sco_conn_del(hcon, bt_to_errno(status));
> >  }
> > --
> > 2.48.1
> >=20
> >=20
>=20
>=20

--=20
Pauli Virtanen
