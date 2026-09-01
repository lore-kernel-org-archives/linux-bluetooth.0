Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C739021C
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299322; cv=pass; b=JOGyK+SAvu6v2Qn++mDc+Q8LGQ2vTcrGsLputZuBgJVQV9eEYeXg6aSO8Kd2smvaQIAQ2gwT1eJdmhwH6WCC1CU41EQH4K5qYxIxRzgyVidFY3AqQHh1cZYYJZO+ZAj9C0h8gQh7oPXYpp8RCA9PU4AfrSM3uXnO9CPCbxxixBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299322; c=relaxed/simple;
	bh=MSsNNLgenitskl3OcPGQyfSjGrVmfyhDrxCCJaNAWMI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqB8UzjLwGVLNapyQTxapLWEXeXbS1Ru8jRc5uxJkP+8CIhnekqZz2SrCrboFGZ+ZuiPrm5TqEf0AlDdNIHc4C0wvjve85s7bJP6TevXB4VN9jL+o1o7eGP0VuPEd6+ylcQkeW/FxTt9U5yawD66Vn6/3WF6sJTrmTEA5ISNQcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=wgZj0eM7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="wgZj0eM7"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:4:f011::dd01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZKHN2Gs9z49Q0Y;
	Wed, 02 Sep 2026 00:48:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788299312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X19pm7BWbWhg7xV8lQKVLDiux29xBmIcwbbNU3GvrE8=;
	b=wgZj0eM72pqMTntNWaY7yQm/6Kt6T6MfTtnN3EN4tdA+BdJKcJ1BP3p9XAcgmUOaH0I3pS
	AKIhJgxmoiI0cxVVDHiwXPDA9Cb16kFzs3JAp8qPR49JxPNPVg47vbyd1p2K55yU2Tc0Qq
	jIMR/0GBSmqOa3u3VFe2GLCcMvfhbD2rHQECBS/IGv+SK4zdTXjkfAzr31PJEyGDQD877u
	3dhKcz0wJ/f/X239zzB77RGeeYDVlYvNzzvuZafwZ4+fgWOhA5pQVU5zBVSAGkmbUFjUDx
	hchwC8gGDeKltQxoRCKwCVn6qrqEC+Im99Ps4rprEB42+Y54Ayedaro31D4zxQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788299312;
	b=P9zxONmwCuQ+4ddum5tcT7tUKOczZMo8unvZXYXIxsYV17pFItjjx5McArBr6uZ1g0sD2K
	7ht3abp5xIlsLAmrXdDeA5RTpmjW++C3FHPSel+L5INqtdCaBosiElUDzraQne/WO+71Kj
	9DjuewVTktX/gQlOKTmioQxuYx233Fod+XVSp6qU7qIs6CvG12VbHqQhKfF46ERWU/7PwU
	Ev/+RcZCuCSV6uK/roHSiEaqHp40JknZZru6XqaSyd9zKfBkbrcrgIfIsz1yYpS/r1o6Yv
	QiStY2CEoXzWyKU6nTPkFIoGPyQha8nA3hrkwXPThAGUzGFcmojn8VhMRPJZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788299312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X19pm7BWbWhg7xV8lQKVLDiux29xBmIcwbbNU3GvrE8=;
	b=tx20g1O/wVtFZbit7cuseSOWj0+PitkjG/fYzzeAC9fceCw1yPVF0X8cXAWtTdxo0SPmZa
	LT0Y+A7mVWFCqyA32xNFS9dtvRrYmZoKZgnuf5qJIbuRphSSn78w+YCngpo+5EO1hR5DJZ
	kVyA+YO0L1dKKHr16gzhwFkg7ae2rAWiOliMxLfT4TlJIzPfTuCsLYfPAB5rL9LcF9vl4b
	8iF+h7fptahSyky0F64Cs8WVF/TmvIsVCDVfJ6zhNWYHP5n2Z6ihswWuERlK36pWdawBMF
	CiTb1Hn+aR2Z7DEV98HQeOJk8pQ2hI/ic3r0zD+RTCWhSKCoytk/xtSCvBw2Vw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <82e061d0cb5d8a10ca6c745843843ed7bf1b1bea.camel@iki.fi>
Subject: Re: [PATCH 0/4] Bluetooth: L2CAP: part 2 of l2cap_conn::chan_l
 locking fixes
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Date: Wed, 02 Sep 2026 00:48:31 +0300
In-Reply-To: <cover.1788296635.git.pav@iki.fi>
References: <cover.1788296635.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ke, 2026-09-02 kello 00:04 +0300, Pauli Virtanen kirjoitti:
> Rebase to fix conflict in remaining commits from series
> https://lore.kernel.org/linux-bluetooth/cover.1788013041.git.pav@iki.fi/
>=20
> Fixed minor conflict vs. moved mutex_lock + l2cap_chan_lock in diff
> context
> commit ddaccd985bb0 ("Bluetooth: L2CAP: fix out-of-bounds write in l2cap_=
ecred_connect")
>=20
> No other changes than resolving that.
>=20
> Pauli Virtanen (4):
>   Bluetooth: L2CAP: take lock for l2cap_chan_del in
>     l2cap_ecred_rsp_defer
>   Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
>   Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks

Sashiko report comments that some callbacks in functions in l2cap_ops
are not marked with __must_hold(chan->lock) annotation.

That comment is not correct, e.g. l2cap_chan_send is called from
6lowpan.c and smp.c without holding chan->lock, so the annotations
cannot be added, it'd need solving locking issues first.

>   Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
>=20
>  include/net/bluetooth/l2cap.h |  65 +++++++++++--------
>  net/bluetooth/6lowpan.c       |   2 +
>  net/bluetooth/l2cap_core.c    | 113 ++++++++++++++++++++++++++++++++--
>  net/bluetooth/l2cap_sock.c    |   2 +
>  4 files changed, 150 insertions(+), 32 deletions(-)

--=20
Pauli Virtanen
