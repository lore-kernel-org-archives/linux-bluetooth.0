Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56295FBA6
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126606; cv=pass; b=azzBWgoMQ/DlpmL8i8aH+caN2mPnIVJbiiydpBCQdXeDA2QW/Hk8DRu0NNDnEv0KuVF3oy9iyqbnoS49Zd5hSYLRw8AWxesmzQlYu5iAo3u7kOPY1Da0NrGeC0CQVcJHziLlr3xX3CRfY3JhUX+FaENJt9BKAwOkLKiyDI8DnXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126606; c=relaxed/simple;
	bh=HmDNysnwr+eVJcVyvuwoimUCmEosTGDIBGwT0Gd9eIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUhEYKcj51Kj6zbfUigVEwZil3iTD7eU9DM0tpMArljpUTR2kMr/5PdbwqQHBg2HbPSWaQmfOUBC5ABr+XTIhCZiZRh07lSw/Ufng9/6LPsrPgyqpcQ0BZDNpA4brSIpl1Njkp4e3O+wvfMeJw1AcHT67hvowhosnM51HNBh8FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=JR3R3gWg; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="JR3R3gWg"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V1T4d5VRbz49Q08;
	Fri, 22 Mar 2024 18:56:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1711126594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vk5QPa8Ddpr3Tv3fxWVghmAqzj4yb5xmWGUamAaWZs=;
	b=JR3R3gWgJls8uKpb9Ovre5pZt013xIHxkPsvNo0w6EAHaznBfQZYcJmr1Od8nV/vqCRFZ0
	6BLDQdRm2einipBX1uHF00PMF96t3u6waOySFmAsjVWKfXqIBuU76oAjUqT18Li4IbMOvk
	L56nJgN9Ne3SqigDJs58FWw9t88UyMrDNAOw8H7zjmgDg6PSIzvcX7zFbOvsUQF8+L9SxC
	59E/UFuCz6QL8bZU9zX80p5UAfK6Ic9fv79MPlEIShuWADGWCI7YVHAM3g9VEbYNE2DfyU
	y/wtxxvXuGqM8CKFWBXaWmXDeI1jdKFmp0mGJTkile9Dq5XZDCtQlHYe/GH4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1711126594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vk5QPa8Ddpr3Tv3fxWVghmAqzj4yb5xmWGUamAaWZs=;
	b=bNoVnhevvShLUQc1SaCwcOaFfeaEtYePHah2KJmWR85I0Ra3eFrcmPb41+MKiLT1rOazWA
	BhBnwhz+aA+CiwXU4mTBZmyXk7BbEek5cmdZ2I5GsXVHFh6tQTbn94yialHCu+wz65bXYv
	leGj+n5xo3UwPoHcD92VuD1pnUM+h4T3Xm7gzNYbOOnbjR2TNFZ0yJqM5ChgPZ1PWZBi7L
	fAQNBjYHiq3Xe/O4+QN4aLSCsJAsaaFv+2ukcdn4T71sBQ5ufsZRn8/vbNTMgbqohW0BKF
	OP93yUFEgtW/rk8bcPn3bxDp45wxyoLsdEP9F2M+ptFvpzZxyE9pNXrUqzPWjA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1711126594; a=rsa-sha256;
	cv=none;
	b=qBaubpczSjHdof2JZRBR3+FDxjguHXHVEkBnKmgxs4Ud0gpPPGwg1wmVFlBcFsmZML8JlR
	dUliqT013nwB2uj9eQWJfzHPLZXl1Aezg3ItWM+TO+wrHwc5stledMRA28vrWxF7IyCkhO
	/R0sLdkqGUDI0fnwGNtL7jcO1JwUEO9cmTs81laZsGsEw+nbavdRFMVmNKXqjvRMcI6+gl
	oG8cPYtG950ldAp+7TH9wv6yvakwvCf8x9h85E/AuKuciwMIWsPDxq+KF2WAvGLzpiwRLA
	cpaKJ5mS7VX9boXTKJ3XXPsz2iCwYO9VwmdkaVhX7s3yIb+sCECFCr0d4fT1QQ==
Message-ID: <713b1d0333eb2f12e63bc8a7b8f423e1240abae0.camel@iki.fi>
Subject: Re: [PATCH v2 0/5] Bluetooth: add TX timestamping for ISO/SCO/L2CAP
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 22 Mar 2024 18:56:31 +0200
In-Reply-To: <cover.1710440392.git.pav@iki.fi>
References: <cover.1710440392.git.pav@iki.fi>
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

to, 2024-03-14 kello 20:20 +0200, Pauli Virtanen kirjoitti:
> Add support for TX timestamping in ISO/SCO/L2CAP sockets.
>=20
> These patches allow fixing / working around controller(?) issue where
> two ISO streams in same group get desynchronized. It also gives user
> applications the best latency information as available to kernel.
>=20
> Also add sockopt BT_NO_ERRQUEUE_POLL to optionally disable POLLERR
> wakeup on TX timestamp arrival, which is mainly a nuisance in the use
> case here.  The alternative to this seems be to deal with the POLLERR
> wakeups in BlueZ side, but this seems hard as it's always enabled in
> poll() flags so not clear if anything else than polling at regular
> intervals can be done there.

Any suggestions what the plan here should be?

The suggestions so far:

1. Socket TX timestamping & deal with POLLERR in BlueZ

2. Socket TX timestamping & disable POLLERR via setsockopt

3. Some custom latency reporting mechanism


> Pipewire side:
> https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-ts-test2
>=20
> With this change, https://github.com/bluez/bluez/issues/515 is more or
> less fixed, and the sound server can figure out the total latency to
> audio rendering (tx latency + transport latency + presentation delay).
>=20
> For ISO, we can later use LE Read ISO TX Sync to provide hardware
> timestamps, but this requires figuring out the sequence number
> synchronization first.
>=20
> v2:
> - Rename *tx_comp* -> *tx*
> - Add hci_send_conn_frame() and handle all link types
> - Add SCO timestamping. Deal with no flow control -> no Num_Comp_* events
> - Handle HCI_FLOW_CTL_MODE_BLOCK_BASED
> - Add BT_NO_ERRQUEUE_POLL
>=20
> Pauli Virtanen (5):
>   Bluetooth: add support for skb TX timestamping
>   Bluetooth: ISO: add TX timestamping
>   Bluetooth: L2CAP: add TX timestamping
>   Bluetooth: SCO: add TX timestamping
>   Bluetooth: add BT_NO_ERRQUEUE_POLL socket option
>=20
>  include/net/bluetooth/bluetooth.h |  10 ++-
>  include/net/bluetooth/hci_core.h  |  12 ++++
>  include/net/bluetooth/l2cap.h     |   3 +-
>  net/bluetooth/6lowpan.c           |   2 +-
>  net/bluetooth/af_bluetooth.c      |  72 ++++++++++++++++++-
>  net/bluetooth/hci_conn.c          | 111 ++++++++++++++++++++++++++++++
>  net/bluetooth/hci_core.c          |  19 +++--
>  net/bluetooth/hci_event.c         |  11 ++-
>  net/bluetooth/iso.c               |  32 ++++++---
>  net/bluetooth/l2cap_core.c        |  11 ++-
>  net/bluetooth/l2cap_sock.c        |  23 +++++--
>  net/bluetooth/sco.c               |  27 ++++++--
>  net/bluetooth/smp.c               |   2 +-
>  13 files changed, 303 insertions(+), 32 deletions(-)
>=20

--=20
Pauli Virtanen
