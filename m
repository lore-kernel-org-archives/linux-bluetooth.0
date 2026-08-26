Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CB380FC3
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750512; cv=none; b=f+4rvnQNjq3IsWmcQD4du2mZ0Bm02PFO+KdeFRbSudY1msyp0Y/+6QDulAJ0N3oPwyLY1IfscCwkWxH9FnKKJH931fYXeNuJF0JyADpW5SJCUgstjioezU2vfx9fTqM2j2qG90l68GaT0DXLi/nFvj+rhHMa/WxdCUN1dji4fX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750512; c=relaxed/simple;
	bh=oY3iies8kcdMgx4iObyhex+xKcZxFjhtd0NL3q+Dcog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCRY83yoyfLQE0DQguw+e4Ral8KU17EWDnrw79pSMalKZvLvojyi5NS1C2EnskNLShmfNIzYZpztowgoZDfPmwcXvP0cucYBl9nq6im8B3Djzn5f3KuC2O39nmu8qT+SWZ4kYcaNCIsTsxRn+una7YZPvT4oj4AAUhEu4R3HlLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F6B13ECBE;
	Wed, 26 Aug 2026 13:21:48 +0000 (UTC)
Message-ID: <06aa2f63a02022e2e34879cd8615dbc16c8619d3.camel@hadess.net>
Subject: Re: Use-after-free in avdtp_connect_cb() (profiles/audio/avdtp.c)
 via unreferenced transport connect callback
From: Bastien Nocera <hadess@hadess.net>
To: BUGPWN <vuln.bugpwn@gmail.com>, security@bluez.org
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 26 Aug 2026 15:21:48 +0200
In-Reply-To: <CAOZc4ksrOkoK8u3Mm5C5bGH_xNL1tn15Pq68oCtijoFpxSGBFA@mail.gmail.com>
References: 
	<CAOZc4ksrOkoK8u3Mm5C5bGH_xNL1tn15Pq68oCtijoFpxSGBFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEWc98sF3wt3zV0+jMphQON0OSz90cFem/6eacB2QGEvpKA9frCp01SaZziFC75NZf7Gu3HOJG2o0emPNJPhM2hD462xbF3l0ik/xvcgeUOPs5OlOvZ064HrzCXBaus+Jo7Tjlhp5BLigyqvGP2gMyiNP0VPxQPkJzqJ/+mrXiCbdVepEqnLaQh3/GbKItrC8FCyKWQRKYEBpq4+lMV2UexxZh5UAfQIzkzBrQZCEwRuseLWb8ilM9T4/+46k4HQZ8oTDpo9aQu3LGTDAIlFKwx2nTqGwZMZDeqOlhyu6kuAkkOsDm8chCaBc2OIh0KRYrTlKQE1fs/S00385JjajRNSQkrxdl6H6J7nabezMaotLkuPIQKeaLtIweoKDMKkBxVdWUjfj2tsmqnqCvRo20mFMefrds1ypaeWolKE9yVNLh5B/k6UVZuuOUECpyyV4dY/P8SudhASCU5wUblqw1awVW1kqYvVpqLKBCaNQps223JrqxtkdJgi9J1qagaDxP5KwA19Ye4tSvjBFZ4b4RWVB26gFfi6YfeqxXuCC0eh6t+hXxQ/PyHbAz8an/4jDcJI8HpHMU+nOGK/NMYmiyA2n3xta0SIvSKpD/Q2yJSjIsrtwHFYowWNyh2VeuZWnvGtKawLt7+q4QGYce7l55HaF0TVUI2cPuSXyDyZ+cWeQ
X-GND-State: clean

On Tue, 2026-08-25 at 12:36 +0100, BUGPWN wrote:
> Summary
> -------
>=20
> profiles/audio/avdtp.c contains a use-after-free in
> avdtp_connect_cb(), reachable when
> an AVDTP session is torn down (e.g. the remote peer closes the
> signaling channel) while
> an asynchronous transport channel connect, started by
> l2cap_connect(),
> is still in
> flight. The transport connect's callback is registered without a
> reference on the
> session object and without a destroy notifier, so it can fire after
> the session has
> already been freed.
>=20
> Also submitted via GitHub's private vulnerability reporting.

What's the link to that report?
>=20
<snip>
> Reproducing this over real L2CAP sockets and glib timing would
> require a virtual
> controller (vhci) and a fake peer (bthost/btdev) with precise
> two-channel timing.

Can this even be triggered without using vHCI?

Regards
