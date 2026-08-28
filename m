Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C137AA8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932978; cv=pass; b=mwq8XsJ1cUmZzw+eljrLFYt4tt/1DPk2i9nk8ipkfzIvurjrIbwair35K9zEe5iuaGS2VE1B2vTm0ZpgHr8PbazcN9lTnurkyCDY3Z9hOXzQWVANSwofBXMjx5iU8+5x0O7w2QIh6Cs4ycgnHQ8uk5QIoVEdoH5SemojMMco08E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932978; c=relaxed/simple;
	bh=esHDgAINVGdxGusqd/dTQnNfcJDy+WvlTDyBHC34xY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0K3RM78kZt6JhuPSFSQG83t6zQ7jVK8Dj4t3LXh/s1SKriULl7vytynkAM42NjPcrFfr1uiw9HwPV624Z+6/G9vtHfS/q/0gye3kAoYGi7TTk/c2y00Qd95JpZe3dk1f/y+Ztk2XsyYO5Y5fLeOXrxADW7okrCL7igpY7bm5ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=DK5M1n4+; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="DK5M1n4+"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hWjpH5HGBz49Pyc;
	Fri, 28 Aug 2026 19:02:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1787932968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FLkdXXOgFcQG6oCb7D5IXWplTWB3n/DOt2zphBtErE=;
	b=DK5M1n4+g3X40gHKNOricy7DxC9YDEXZQa5s/dPUqr4V3MMtcQZhTJmwvw94B2NEfMOmUN
	tSlA6RviNjIcyCgyeUx1T150D5dkPNQMrBzn+UrVP/AS/7CUo2BSjQsYpcitfyskiILgqy
	V0yIZFxeNnWDRR1xtg20v5MsG3VJw83q7z0GjtRqZYQJ8WyfNy45dKapFlxbF3KJlLJe6x
	sFwcEkxB6D5K3uSv2fAy2wrWOJLQbR5Sgw1FOs60Z9vjuTpv4amIO4zTk6gWaN98Reaejo
	vrZELx4L/EQqugBuDN0BQdVJK2xIFVTP4tR33xEuLbXVZRcbtoYwQWEMsluOUQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1787932968;
	b=jq6m+j+bJOGEo+9SHo0WRj4MA3FnRywKn6DZCa7AN83LeRJZ+Q5V41eNHVH2woLfgvEljM
	5ZPRffoqkHPiOjJnQkuQxA7SW92/JBTL8y715SqU/o++CM2F2LIbxmzOde+gXP/XoMs5dQ
	K4THZnzibtFoUK5niskpoN7xkjijkJthV1kRgE1u9mSIPRwLfiFmQwAXlGRNzGHfo0tzcJ
	6i0Ua0DorjLhxKbFhF6PjalLBUaYTQixS6Op21X2m5gvBzMzLb0urY+eznI8AKF5XJV7mj
	HcDAztfKtXyAxMg3Mep6zYpYD3sDy9o2i+XAiZWw4QSkT+nQSH4q0A0QolFjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1787932968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FLkdXXOgFcQG6oCb7D5IXWplTWB3n/DOt2zphBtErE=;
	b=LovGkjVW5Qua3MxEngRNrfVxtobCWXl263DxE16X3PKLB/5jUpFhn7FIXI9IMtYzilCCZP
	WpszOJvGIyJPORwkxn9/BnnsHYXWhGHZpDHzTPuT+UgEOL89VP3A5dn9LZz/2YhY2JOdSw
	jzlxoq2d8Xen8EucSqhjC8yjMMCfiVt+0r61oV84dk4Rjtjq8xo58mzW3KMZL3Inc60E20
	d8WHFebn/TMSKBLh8l8BAntti3lM2s7ALw3s6LZ3uV34P1tF0rCeAOIsGyur9fD5rLDYa6
	Azd18TUHCxLLk3+bsQzk6qdCryrrOhvq51OwcQahoegvu8X4CtUcxFpD3yoJzQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <78402f4521084b3f6d2cce7709cbba751d83836f.camel@iki.fi>
Subject: Re: [PATCH v1 1/2] Bluetooth: SCO: require CAP_NET_BIND_SERVICE to
 bind
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 28 Aug 2026 19:02:46 +0300
In-Reply-To: <CABBYNZ+qzL04d0cdKd==wFr_Gtz9gCa3_iNv0B9rE=R8pdpajg@mail.gmail.com>
References: <20260827180149.415744-1-luiz.dentz@gmail.com>
	 <0186ef45e8d10fa469fe31f32d24b54c672157a3.camel@iki.fi>
	 <CABBYNZ+qzL04d0cdKd==wFr_Gtz9gCa3_iNv0B9rE=R8pdpajg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2026-08-28 kello 09:50 -0400, Luiz Augusto von Dentz kirjoitti:
> On Thu, Aug 27, 2026 at 7:41=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> > to, 2026-08-27 kello 14:01 -0400, Luiz Augusto von Dentz kirjoitti:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >=20
> > > SCO sockets have no PSM or port namespace: binding one simply reserve=
s
> > > the ability to accept any incoming eSCO/SCO connection on the adapter=
.
> > > That is equivalent to listening on a well-known service, which L2CAP
> > > already restricts to CAP_NET_BIND_SERVICE in
> > > l2cap_validate_bredr_psm()/l2cap_validate_le_psm().
> >=20
> > In current Linux userspace, sound servers that do HFP listen on SCO
> > sockets, and I think often don't have CAP_NET_BIND_SERVICE.
> >=20
> > Do they continue working with this change?
>=20
> Good question, that said this is a part of security hardening
> otherwise any process could start listening to an SCO connection, and
> the sound server would stop working. Btw, does the sound server have
> any special capability to, let's say, open the sound card device so
> perhaps we can gate it on sound capability as well.

For ALSA, the sound hardware access is controlled by device file
permissions in /dev/snd/*  Not sure if=C2=A0that's usable here, or if
there's some other per-user controlled solution that could be used.

In most current distros sound server runs with user permissions without
special capabilities, and don't have CAP_NET_BIND_SERVICE, so I'd
expect this patch breaks userspace.

Giving this capability to them allows binding to low network ports, so
it probably makes the hardening issue worse and not better.

The next simplest is probably separate executable with setcap bit set,
which gives a SCO listen socket for those who can run it based on file
permissions.

For ISO bluetoothd manages this (so can be gated with DBus/selinux
policies),=C2=A0and it could make sense for it to be made to work like that
for SCO too.

> > > Apply the same restriction to sco_sock_bind() so unprivileged process=
es
> > > can no longer hijack incoming SCO links.
> > >=20
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/sco.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > index 3d4362a09df4..e4c26551e513 100644
> > > --- a/net/bluetooth/sco.c
> > > +++ b/net/bluetooth/sco.c
> > > @@ -667,6 +667,13 @@ static int sco_sock_bind(struct socket *sock, st=
ruct sockaddr_unsized *addr,
> > >=20
> > >       BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
> > >=20
> > > +     /* Binding a SCO socket reserves the ability to accept any inco=
ming
> > > +      * eSCO/SCO connection on the adapter, so restrict it in the sa=
me way
> > > +      * L2CAP restricts well-known PSMs.
> > > +      */
> > > +     if (!capable(CAP_NET_BIND_SERVICE))
> > > +             return -EACCES;
> > > +
> > >       lock_sock(sk);
> > >=20
> > >       if (sk->sk_state !=3D BT_OPEN) {
> >=20
> > --
> > Pauli Virtanen
>=20
>=20
