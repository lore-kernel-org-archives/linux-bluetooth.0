Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490221361C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159147; cv=pass; b=KgLzBYrWbUXzS4pmJ4/tGUpqwlPFcHhJBUnafl1vHYKK537RslYIb1Ys4Y2CwpDtvunr7o/ttwcrcCDJbrxMq8i4PSEHm3OL+Fe8wUJIHYxyObSMgDwtOwjIPTTBr+tIpLBiGEk++uRJPMchS+mUOg9vFzB5pnpJ9lrf+QK78Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159147; c=relaxed/simple;
	bh=l1hfCEkilmg9EMIzL5dnKpmPoJsE4jPSHseVKlxGGhc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s51JpBa5PtjH1ZKqMYdojwSwY0vdGcMLQJzi5M9MgRRV4xqS6RpBsN14JAm7DgAFVDnQxRBpmxOrJzwA6Qu6Yqp9MwMC8iObCq8H9CtJKHb6aobGkagUIu5fc9VaqQxFefjle6LjxsRAr1i1ylEWSbkK4wgGsIxGiJ+cZRx6pAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=bxyDfSr6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="bxyDfSr6"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TlTFR1KdFz49Pvb;
	Thu, 29 Feb 2024 00:15:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1709158539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyBYZ1JYbMT7eQI4qc+qjmaSIgRE53lnRD7s9CHU8V4=;
	b=bxyDfSr6585FcazAnZ1szHbtaFI1yKZ/ngKZpW5tmRTX+TJjwAAbx/PHLklFWr6Y1lbfdk
	ggFLdLIMNJaVgps8SN9Le/jY3p8GtEbXad0dlym5sASgTfbMd2Xe2YKYyvWPxlCXRcGvJJ
	gr3FzQ9QD7tVQrTCuCt3bheSAUPAgvSizrkfwxeFKul07goIgRQGOZa1EIzU1kgVrfmJgP
	QcHzy/o+tLEZq4BhKXSn12jk+l2vLx3iuV7TVzNVFkB17BbokJjrZPD/A6gM+hY6FTtWzH
	nXVjq28ZAtTkKrDrEMAmle9SKS7lOvGzCWNFO8Y6liYk0d2OHhnnyJ128qNnNg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1709158539; a=rsa-sha256;
	cv=none;
	b=rLyJWfO4Pea2XUTqV2fgzXH2RqtUwtvgQ2v3uC2Tc0VycrB598/OzN1G1VYWLmDkXzfNwy
	2yO9PZBKnpsVFBpW7b9N+tHD3eThD1G8j04z7Af5Ak0F2wpa1HKla2jlaUgoKcif41Vr7f
	YUEAzZ/0pmk0A4eZER6ZbwdXBaY+sATrBvL/Xp0xs//Y0w+bPwSd8pkPZRaqlizKlsVgXh
	MJ3drCjn5IxcFVyzpXYs/AeRI5WmvLj/bRG/TUaMS8WCYFPZcNg1we9bP/GRff1FlV6ziB
	IMgKin9hPBzCtR8qUIX68LI3PhWUtwUmdpNNNmZzPFfzf6s08poNwEPhqIu3Ng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1709158539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyBYZ1JYbMT7eQI4qc+qjmaSIgRE53lnRD7s9CHU8V4=;
	b=Bah7bHUXhCSPRCiHKVlZha8iAXrO6bzFv91TRSk4+2TRtTWBilQZfjyLyxEclmBEAH4oir
	uYkBWZa4rihw3xt/HRd2GBupdiNq+UTuQNzQJOuqeXUqZ2tVlCKenwcn2inyc1+D0nHgU1
	ForreVczvcJ44uLFa0tmRSjmRBVU6s9IirxS9JTR+mDXWi3KEUzsmL2BRtFKpqFboGXcZY
	45If4phMZg1qxWZndP6KQap6BC64JnNndOgnD6+AjmF2xuRMnX67xm1eoZKcyJ/0UJGVgS
	PKPY4ZDj4Pnar4NWTRQ9hfXF5Zy1/n8f1BOIK09KKf/XxALveW+llD4SAnHI3w==
Message-ID: <07dd649a13a138bdd0e0cd6b55715d38770706cd.camel@iki.fi>
Subject: Re: [RFC PATCH 0/3] Bluetooth: add transmission latency tracking
 for ISO & L2CAP
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 29 Feb 2024 00:15:36 +0200
In-Reply-To: <CABBYNZ+J_SUi_T987ND3hyN228zvX0gD62QNqk5D=GDc+nypTQ@mail.gmail.com>
References: <cover.1709150574.git.pav@iki.fi>
	 <CABBYNZ+J_SUi_T987ND3hyN228zvX0gD62QNqk5D=GDc+nypTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ke, 2024-02-28 kello 15:31 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, Feb 28, 2024 at 3:11=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add ISO/L2CAP socket ioctl() BTGETTXINFO which informs the user how lon=
g
> > it took the kernel and controller to complete their sendmsg(), and how
> > many sendmsg() are in socket and controller queues.
> >=20
> > This currently provides information of the latest packet only, in
> > principle there could be a ringbuffer containing few latest packets, no=
t
> > clear if that would be useful.
> >=20
> > These patches allow fixing / working around controller(?) issue where
> > two ISO streams in same group get desynchronized.  Having accurate
> > knowledge of the packet queue lengths, user application can drop packet=
s
> > if it detects the ISO streams are not in sync.
> >=20
> > Pipewire side:
> > https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-ts-test
> >=20
> > With this change, https://github.com/bluez/bluez/issues/515 is more or
> > less fixed, and the sound server can figure out the total latency to
> > audio rendering (tx latency + transport latency + presentation delay).
> >=20
> > For ISO, this can be changed to use LE Read ISO TX Sync, when the clock
> > and sequence number synchronization issues there are figured out, and a
> > quirk is added for controllers with nonfunctional implementation.
> >=20
> > For the L2CAP latency, I'll need to think a bit more what is the audio
> > use case. Motivation was that AVDTP delay report values appear to be of=
f
> > by ~0..40 ms compared to observed audio latency and this amount can var=
y
> > per connection and time, so not explained by unaccounted code
> > algorithmic delays etc. Currently it's not clear if there is relation t=
o
> > TX side latency, so it may be down to receiver side implementation.
> >=20
> > This needs a bit more work to figure out, but the L2CAP patch is anyway
> > here.  Due to the possible fragmentation in ISO sendmsg(), it seems we
> > anyway need the tx_info_queue thing and can't easily do it by counting
> > packets, and L2CAP required part is small addition on top of that.
>=20
> That is not how it is normally done with sockets, normally this is
> done with use of SO_TIMESTAMPING which is then reported using the
> socket error queue:
>=20
> https://www.kernel.org/doc/html/latest/networking/timestamping.html
>=20
> Sorry to tell you just now, you might have lost a lot of time doing
> all of the changes, next time just drop and RFC early on with the
> general design so you don't spend too much time before getting any
> feedback.

Thanks, looks like I missed that was not just for RX timestamping.

We then need to hang on to the skbs to be timestamped in hci_core until
packet completion. Looks like skb_queue_* is used by drivers, so
probably skb_get and ringbuffer like in this patchset then.

> > TBD: iso-tester / l2cap-tester tests
> >=20
> > Pauli Virtanen (3):
> >   Bluetooth: add transmission latency tracking for ISO and ACL
> >   Bluetooth: ISO: add new ioctl() for reading tx latency
> >   Bluetooth: L2CAP: add new ioctl() for reading tx latency
> >=20
> >  include/net/bluetooth/bluetooth.h |  39 +++++++++++
> >  include/net/bluetooth/hci_core.h  |  30 ++++++++
> >  net/bluetooth/hci_conn.c          | 110 +++++++++++++++++++++++++++++-
> >  net/bluetooth/hci_core.c          |  14 ++++
> >  net/bluetooth/hci_event.c         |  66 ++++++++++++++++++
> >  net/bluetooth/iso.c               |  58 ++++++++++++++--
> >  net/bluetooth/l2cap_core.c        |  12 ++++
> >  net/bluetooth/l2cap_sock.c        |  50 +++++++++++++-
> >  8 files changed, 372 insertions(+), 7 deletions(-)
> >=20
> > --
> > 2.44.0
> >=20
> >=20
>=20
>=20

--=20
Pauli Virtanen
