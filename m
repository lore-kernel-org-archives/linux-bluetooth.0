Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6339CD13;
	Fri, 24 Jul 2026 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931073; cv=pass; b=VdSCS3/CMPBu3sG9qQyJRdwupVhtHzZYS5U93C1DF5XUZDWKd75UhgFztZ3fvs3RUY3I8IEQqUAG8MhdJHU40UMxL8V0zBzW8rLS9W9O2SdPogu2GzlpaiinEnHcFi5M88nRP1W4FcayhmEExM0a1Ucs+DWZf6VRViLkJvrrd5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931073; c=relaxed/simple;
	bh=wlGL93uSh23HvmNn4KXLLnPVlzcLqAdvtK3GBMyf7QM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/hzKcmYPGrFqNmvuJjc8JwnQwKh0G9Oj2xMfgncUjKkodIpTGEZj4xRwg7n1IuC2aT/wvuU+ybN7hEvqoPcwF0qIxlMpFryKECXbbJE7CP+S0Wz57MwfgJMmAIVTuDIL0o1Q+Lt+vfsr+KDLA0Me4CmQIXavjpUP+KbiP4MlO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=BE0lnP+c; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="BE0lnP+c"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h6MdL3jWPz49Qdj;
	Sat, 25 Jul 2026 01:11:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784931063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QINf6xaPaBz3ZSSKvN6ESJ7LmtuO3QAzk+X2758GF8A=;
	b=BE0lnP+cnVTZ4degtsU+GB7Xd6f+LIkgbDtaZ2k8r3a0Y8GvIJoCxtYCxpuf+CxBWoL6Qz
	B6Bbx9098zuuwpDLBHzjaJrQP7vXpa1XvEHnrlaigyfvRUqv0GDO4xLY/SOtNpsrq7EdXw
	/TiNpk/nOWCuaBqBq7bOLkx8wotQBbw4EgwhcvfHB3KuwpC4iYrQ4M3fAhnKkDtFHFI0rS
	pZNZllD4igxzLS5ndZb46HVQTbZqz+q8YjGv3MKds3w44Z2hKyUS8TuNykh9YqcJubOZJN
	pUl0581s/arEy1eKCofRCjt/z3M+owRljwVcGD8+B1AtOYR4GwnofqI7pWbogA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784931063;
	b=OphG5/Clww29pB76C+tTflZYfNPwu6NacfVQgiMGS1IkS9OOjBuvCq1npR8XfKuEaNFpLf
	Dg0EUoxGOehHJl4IyM7GTtlExT/FAWPxokcJKQxr4kPF/b+HxfQUELO60YFEwXHKPeIS5C
	9HqTQjgxZDzi73WxJ3kLrvTvwxp0nb7lbDLIaAmS9LoSMiZr1Us5hR06GC5YT5ZgLIu0PW
	SLosGOBntsQNin7Yj+26vGDlpkGCgJP1f2U0RXrxN10H6jFg76RNuFFteNHkNgKS8x8yPG
	pmVE36CouYy+tBidUknX33vz/CqPjEvHeinXUP0bT43GDHl1PLrCdzyac59dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784931063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QINf6xaPaBz3ZSSKvN6ESJ7LmtuO3QAzk+X2758GF8A=;
	b=E4FQ4X+gCIhHKAVhwDha6QhZbXTu6UTQ9MXMtekOGB7ZIrSMUAHW9nuQXZsdZOLCAZMYl1
	hRXK6oDyg71VVErTNeoobaxGUbd5PCx53zFZ1YJuDzvQ79aG8rvTPCGlC36HyI1lSnxcxp
	iEpXTS7kPm3oVzIHlKqiw4wmMdUphmzm0W+/GqbLlwz0ESeGirI9EImfDP4NusJMpdAF28
	tsgZyUJ+Tlo/Yp1t2/SZFllbwRqXi468cC9UmQ4T+HdWGZoob8ZRTA50CzkKgPppb7dhaC
	zWYZyBEBq5UNLoAP63kSBly215P1SXI4gHmd9I+x1W0hUkDMzPyIFRtDIBHOag==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <b9341fe78dbe1ddd550b5099e6c87006fdb4b3e5.camel@iki.fi>
Subject: Re: [PATCH 00/11] Bluetooth: ISO: fix HUP on socket
 release/shutdown + UAF/locking fixes
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
Date: Sat, 25 Jul 2026 01:10:59 +0300
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
References: <cover.1784923689.git.pav@iki.fi>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pe, 2026-07-24 kello 23:20 +0300, Pauli Virtanen kirjoitti:
> The retracted patch in commit e824c0bbe0ec9 ("Bluetooth: ISO: clear
> iso_data always when detaching conn from hcon") merged in
> bluetooth-next/master broke ISO socket transition to BT_CLOSED so they
> don't send POLLHUP properly any more, as seen in "ISO Disconnect -
> Success" test.

On Sashiko comments:
https://sashiko.dev/#/patchset/cover.1784923689.git.pav%40iki.fi

Patch 3: pre-existing issue, not UAF/locking issue so maybe should be
in separate series.

Patch 9: the comment appears to be the UAF which is fixed by the next
Patch 10 as described in its commit message. This was also pre-existing
(SCO has the same race).

Patch 10: these comments seem confused (no rcu_read_lock in
iso_conn_put in this patch, doesn't seem to notice synchronize_rcu in
hci_conn_hash_del?), but remaining UAF/locking issues should be fixed
by Patch 11.

Patch 11: the comment is about hci_conn_hold/drop refcount when
iso_conn_free and iso_conn_add happen to execute exactly at the same
time, with the same pre-existing hci_conn.

hci_connect_cis/bis don't give a new refcount when the hci_conn is pre-
existing and usable,=C2=A0which should mitigate this, the refcount stays at
1 and becomes owned by the new iso_conn. IIUC it should be OK as it is.


> This is rebased version of and supercedes
> https://lore.kernel.org/linux-bluetooth/fbd9dd573bb1ce5f38370128dd35447e2=
ddfed9c.1784625576.git.pav@iki.fi/
>=20
> The first commit in this series fixes that, and subsequent mostly
> independent commits other minor issues found looking at the ISO socket
> code.
>=20
> The last three fix UAF issues. The locking/lifetime of iso_conn
> complicates the code here and the last three patches can be replaced by
> somewhat simpler solution with bigger diff that removes iso_conn
> https://github.com/pv/linux/commit/e4b460b5f7aaba060b958229aaec6b22176421=
78
>=20
> Fixed issues aside BT_CONNECT, these appear to be pre-existing in
> several previous kernel releases:
>=20
> - sk is always leaked on socket release
>=20
> - timeout_work may deadlock under certain conditions
>=20
> - correctness of iso_conn_del() vs UAF requires somewhat too complex
>   reasoning about race conditions, and it's not quite correct
>=20
>         [Task 1]                      [Task hdev->workqueue]
>         iso_sock_timeout              iso_conn_del
>           iso_conn_hold_unless_zero     iso_chan_del
>                            `------------> iso_conn_put
>                                       caller frees hcon
>           iso_conn_put
>             iso_conn_free
>               conn->hcon->iso_data =3D NULL; /* UAF */
>=20
> - attempt to free iso_conn in iso_conn_del() races with iso_conn_del
>   with potential UAF
>=20
> - iso_sock_ready() gets conn->sk without requisite locks, this should
>   be done like in sco.c
>=20
> - iso_sock_getname, iso_connect_ind are missing lock_sock and NULL
>   checks
>=20
> - kref_get_unless_zero(&((struct iso_conn *)hcon->iso_data)->ref)
>   requires synchronization primitive.
>=20
> Tested vs iso-tester, Pipewire Qemu ucast/bcast audio tests, and real
> ucast audio streaming, which pass without KASAN/locking splats. Also
> checked iso-tester produces balanced iso_sock_init / iso_sock_destruct
> kprints.
>=20
> Pauli Virtanen (11):
>   Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release
>   Bluetooth: ISO: lock sk in iso_sock_getname
>   Bluetooth: ISO: lock sk in iso_connect_ind
>   Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
>   Bluetooth: ISO: validate sockaddr_iso first in iso_sock_rebind_bis()
>   Bluetooth: ISO: hold sk properly in iso_conn_ready
>   Bluetooth: ISO: fix leaking sk after socket release
>   Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
>   Bluetooth: ISO: ensure no dangling hcon references in iso_conn
>   Bluetooth: ISO: fix refcounting of iso_conn
>   Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero
>=20
>  include/net/bluetooth/hci_core.h |   4 +-
>  net/bluetooth/hci_conn.c         |   2 +
>  net/bluetooth/iso.c              | 274 ++++++++++++++++++++++---------
>  3 files changed, 197 insertions(+), 83 deletions(-)

--=20
Pauli Virtanen
