Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9783033D6
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787992780; cv=pass; b=Iq4o0J1kqHdcFuMyYi+zHBlQZuozLz4GSTNtLtfm1r1L9KbjktXhz9W6nsS2Dj0EN6wjJCbYn48hRRHdQ8qmBsTA66FU/3lTPiYTowiV5y4LrjsIHiAwTHD4QSrcLevqHlSTsyM9qUoS01xHnZ2c04ACZ+6xmij+8PQyXuOYEqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787992780; c=relaxed/simple;
	bh=Juw0GFEw0ejMT7+Sq4me+OJr0dHzhf8Y5vKSNReUV6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMHAoNeyKCZ1jGSz683+DKu/TcybORqN7K0QuO2ZmvbnF4QhBDxrevB/dAIiXc+JUQCuVrRj2fo7OLhrfLU6nWSlDx+4McYcbreuwG2gcJ+7EXlf6L1u2zvVR5v4/cKEkupsb/t1FglWd9GlK8G0qG9yGs/Ees6rxXnMzkQp320=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=TBiaT7oI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="TBiaT7oI"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hX7wB1WKwz49Q4V;
	Sat, 29 Aug 2026 11:39:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1787992763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKtrI6C8L1jmd/cSewYoczbRSxADXbNClhFLtZG0gb8=;
	b=TBiaT7oIwmrgFUh4/ot9KGSCNGxPfyklFPvibYY2uOER4C4q2uqry1oPlzDj+agoKgN92f
	lAZvIBI7Vj5+Fzjtu4Hhp3hVcS8q8SRYSRNeA+EHhJWe6d+eVmpdRvrvVaxIp0d8M5UUlW
	Znda4j7pfXMWAoo3x8MZ8Iwx9oF7UyI1h171zykkQOSlX0NY4u7+4bq8QDlq5Y+FeT6VsI
	cX0oPnOa2klEVwq8zY0pfWLycpVNGwQrKN6RtjcDYXSSvYUVJ1vSqBed9TCT4dk0L6eTRN
	a3Ft+uESHO1/Pco0UbdvjlP7dWaGcjqMQjNFSEDzSM4y0WuSIxJhtRvQu4cvxQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1787992763;
	b=l5Ex0DtFufGBK9CT69SKM94H8zUd0Yt96o+B5st1XW1i4Nc+VKeertZ0ojJeCb1XvQWHgP
	9TbEll86dm+OUYEjAdpXvxJcusaeAnzyWBfRvCa1L2bKjr5+S9b8ZmNqktLXQApFlyFn2b
	tMIrn/vFqgYNo6Ehy6IgLBrWIoCz6WcCMpIA7Dc/+NbpBVsGCvBiVEcHx72xWlzQtVJOOP
	9dDkEgUtMw7qiM7GlVaDxN6XiAfKx6ThBi/aRlVRSkewR2vQlAqciUEhD1d2Xgi6+JZUR0
	FyCVlrbVu2AN1o2wQRdZfP3qn1EzeGyj2ix5x4HIEzWCI1YLSql5GKeMcl63KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1787992763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKtrI6C8L1jmd/cSewYoczbRSxADXbNClhFLtZG0gb8=;
	b=fcTO+Iqnw82qP67EtZgnfRsJzwcUZ2rWnLfmEPkGqFIFaP/RJt3ROsocTPbLMekCKaNc+d
	lLicwH4QJJbjFfdH/lstFW6gPrdYTHkrjNPpQRuV382uWgsSusQJP4RoYz2cAaW2Dq0n99
	oVmO8eFtXrDljIGvw6kyT/7FrIh7SNNSJRydRZicUsbXaxc6SLZT6FiEPHKIVcMzpz8jea
	UlWXKn2u5oLZih1XUbFqILes9ybzw8PxkaKfnumlb37EZz/ncT5bQHtCOigGBvhEAutCdR
	m6ZVF+5xR1bMz5S7xzcuDM4c0FdU3ytIeIaNYhnBsdK5IlS8sfjqDFlsG9fmqA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <5d3fc19a91ac0cfa136ecc3ad7b87e94041546f1.camel@iki.fi>
Subject: Re: [PATCH v1 1/2] Bluetooth: SCO: require CAP_NET_BIND_SERVICE to
 bind
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Date: Sat, 29 Aug 2026 11:39:18 +0300
In-Reply-To: <CABBYNZK6R2GfeoJDLxW72BeYNcpEZvS7sdRac+Ka1E+e6idj3w@mail.gmail.com>
References: <20260827180149.415744-1-luiz.dentz@gmail.com>
	 <0186ef45e8d10fa469fe31f32d24b54c672157a3.camel@iki.fi>
	 <CABBYNZ+qzL04d0cdKd==wFr_Gtz9gCa3_iNv0B9rE=R8pdpajg@mail.gmail.com>
	 <78402f4521084b3f6d2cce7709cbba751d83836f.camel@iki.fi>
	 <CABBYNZK6R2GfeoJDLxW72BeYNcpEZvS7sdRac+Ka1E+e6idj3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pe, 2026-08-28 kello 12:46 -0400, Luiz Augusto von Dentz kirjoitti:
> On Fri, Aug 28, 2026 at 12:02=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrot=
e:
> > pe, 2026-08-28 kello 09:50 -0400, Luiz Augusto von Dentz kirjoitti:
> > > On Thu, Aug 27, 2026 at 7:41=E2=80=AFPM Pauli Virtanen <pav@iki.fi> w=
rote:
> > > > to, 2026-08-27 kello 14:01 -0400, Luiz Augusto von Dentz kirjoitti:
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >=20
> > > > > SCO sockets have no PSM or port namespace: binding one simply res=
erves
> > > > > the ability to accept any incoming eSCO/SCO connection on the ada=
pter.
> > > > > That is equivalent to listening on a well-known service, which L2=
CAP
> > > > > already restricts to CAP_NET_BIND_SERVICE in
> > > > > l2cap_validate_bredr_psm()/l2cap_validate_le_psm().
> > > >=20
> > > > In current Linux userspace, sound servers that do HFP listen on SCO
> > > > sockets, and I think often don't have CAP_NET_BIND_SERVICE.
> > > >=20
> > > > Do they continue working with this change?
> > >=20
> > > Good question, that said this is a part of security hardening
> > > otherwise any process could start listening to an SCO connection, and
> > > the sound server would stop working. Btw, does the sound server have
> > > any special capability to, let's say, open the sound card device so
> > > perhaps we can gate it on sound capability as well.
> >=20
> > For ALSA, the sound hardware access is controlled by device file
> > permissions in /dev/snd/*  Not sure if that's usable here, or if
> > there's some other per-user controlled solution that could be used.
>=20
> Ok, so you are saying anyone user with file access to /dev/snd/* can
> grab the hardware for itself, since pipewire is just a regular user it
> just works because it is the first one to open it?

Normally udev adjusts the /dev/snd/* file permissions, so that only the
user who has the current "active seat" ie virtual console, can access
them.

So they are not system-wide accessible to all users in mainstream
current distros.

If the user with active seat runs multiple applications that want
exclusive access to /dev/snd/*, they need to coordinate with themselves
who gets the access. There exists a DBus protocol for cooperatively
doing this, but usually everything just passes through the sound server
so it's not needed.

> > In most current distros sound server runs with user permissions without
> > special capabilities, and don't have CAP_NET_BIND_SERVICE, so I'd
> > expect this patch breaks userspace.
> >=20
> > Giving this capability to them allows binding to low network ports, so
> > it probably makes the hardening issue worse and not better.
>=20
> You would grant it to a specific set of binaries, probably via a
> systemd file. This would block other users, which currently might just
> be testing tools like isotest, where you just use sudo instead, or an
> AI agent trying to fabricate vulnerabilities.

That requires these binaries are hardened like suid-executables to only
use the capability for SCO ...

Granting capabilities with systemd AFAIK does not work for user
services, so not sure there's other alternative than setcap.

> > The next simplest is probably separate executable with setcap bit set,
> > which gives a SCO listen socket for those who can run it based on file
> > permissions.
>=20
> What file permission? Afaik a socket protocol doesn't have file
> permissions, or does it? The is no open just bind which is what we are
> trying to protect.

I mean the file permissions of the executable file.

... hardening like that is easier to do by moving it to separate "suid"
executable, which has setcap cap_net_bind_service=3Dp executable file
bits set, and chmod/chown permissions to restrict it to specific users.

> > For ISO bluetoothd manages this (so can be gated with DBus/selinux
> > policies), and it could make sense for it to be made to work like that
> > for SCO too.
>=20
> Yeah, bluetoothd manages this for ISO and I wish we did this for SCO
> too, maybe via Profle interface which I guess PipeWire registers, but
> it just for RFCOMM/AT commands, right? Anyway this is too late because
> we cannot break support of older versions of pipewire/bluetoothd + new
> kernel, so we need a way to determine if SCO usage is allowed or not.

If sound server developers have to start thinking about separate
executable/services for hardening this, it would be simpler to just add
new DBus API to bluetoothd that does just SCO bind.

So I'm not really seeing a way to add the hardening now,=C2=A0without this
type of ground work first, or accepting that distros have to
temporarily set cap_net_bind_service=3Dp (or some other capability) on
the executable files. Which then allows sound servers to do other
things like bind to low network ports as a side effect.

> > > > > Apply the same restriction to sco_sock_bind() so unprivileged pro=
cesses
> > > > > can no longer hijack incoming SCO links.
> > > > >=20
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > ---
> > > > >  net/bluetooth/sco.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >=20
> > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > index 3d4362a09df4..e4c26551e513 100644
> > > > > --- a/net/bluetooth/sco.c
> > > > > +++ b/net/bluetooth/sco.c
> > > > > @@ -667,6 +667,13 @@ static int sco_sock_bind(struct socket *sock=
, struct sockaddr_unsized *addr,
> > > > >=20
> > > > >       BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
> > > > >=20
> > > > > +     /* Binding a SCO socket reserves the ability to accept any =
incoming
> > > > > +      * eSCO/SCO connection on the adapter, so restrict it in th=
e same way
> > > > > +      * L2CAP restricts well-known PSMs.
> > > > > +      */
> > > > > +     if (!capable(CAP_NET_BIND_SERVICE))
> > > > > +             return -EACCES;
> > > > > +
> > > > >       lock_sock(sk);
> > > > >=20
> > > > >       if (sk->sk_state !=3D BT_OPEN) {
> > > >=20
> > > > --
> > > > Pauli Virtanen
> > >=20
> > >=20
>=20
>=20

--=20
Pauli Virtanen
