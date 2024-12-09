Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D1233139
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760651; cv=none; b=HSrK2xzINAY7F6E/RJ1g1piAjo2vfmlDzlh9dhGoT79IyQs/riohrSfOZgI2v5Pz+adE2NS0TNV6mV5DPYat86/yddDM0Wy/mMu+b0ePGRCPHTBHODpZJi81StUIZJYuTCMm4nF/WVYxMIojIQPzCMV5Q7WaTpEmAYTzTRw9idA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760651; c=relaxed/simple;
	bh=MqwitMFrNUJNwaAJ0Uk/q0gDOssWBP/ll60E4Z0ibuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I051scqZbI0d9VcUoC0w+z2NY5DDDmCcvFT4uhsDVbB75OroNLl1teJwbaJxdrUNBlEr6bVabV0utUtKDROP95ggvX9i2nCgIkeGZXMT7OLyYtikkK3rWBjDwihMHsox7ijDn3yrjAAeiEHUTd4ZE4YIp8+L3HItHOP3Gk8ljE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95CD91C0009;
	Mon,  9 Dec 2024 16:10:47 +0000 (UTC)
Message-ID: <07c2b19d3923e0954ea927b42825078a6c137420.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2] Leave config files writable for owner
From: Bastien Nocera <hadess@hadess.net>
To: Fiona Klute <fiona.klute@gmx.de>, linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 09 Dec 2024 17:10:47 +0100
In-Reply-To: <20241209154043.105358-1-fiona.klute@gmx.de>
References: <20241209154043.105358-1-fiona.klute@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Mon, 2024-12-09 at 16:40 +0100, Fiona Klute wrote:
> This is needed for builds running as non-root users, so the build
> process and any distribution tools can create/move/delete files in
> the
> config directory without adjusting permissions separately. Limiting
> writes from the running service needs to be done in the systemd unit
> (already the case) or init script.
>=20
> See also:
> https://lore.kernel.org/linux-bluetooth/4d1206df-598b-4a68-8655-74981b62e=
cca@gmx.de/T/
> ---
> Changes v1 -> v2:
> * Explicitly mention in commit message that write permission is
> needed
> =C2=A0 for build as non-root user.
>=20
> =C2=A0Makefile.am | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 297d0774c..29018a91c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -32,7 +32,7 @@ confdir =3D $(sysconfdir)/bluetooth
> =C2=A0statedir =3D $(localstatedir)/lib/bluetooth
> =C2=A0
> =C2=A0bluetoothd-fix-permissions:
> -	install -dm555 $(DESTDIR)$(confdir)
> +	install -dm755 $(DESTDIR)$(confdir)
> =C2=A0	install -dm700 $(DESTDIR)$(statedir)


Reviewed-by: Bastien Nocera <hadess@hadess.net>
