Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE93A75A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189928; cv=none; b=qOe+uAeu//Ohb1kHrbuJELaZIj+d8JO/LUuF+XS5TODMOiUsg+f4eI3XqPu03xPeGQfni3tCuqhy68y6rn7KWWAiqpid3P1so9+QTKA6lHR47vT/Xi2jOLCPidCFH9+rqEaCQbC7dEMt2SSp4fLQPguFwl/nwZETDYgS9JCa7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189928; c=relaxed/simple;
	bh=+NcvSBYLjpNMQeNQpo+KTA3M/kjHqoEcAEUk38s4aL0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSDbwr2l5UrYnTh6w5as4r/hePuSOHRCZ2lmumIhXbi0/JeSM02IFyfQBDul0bSmhEzGiqYREusB1rK1ZCcQZxwTPvPEqV/JC4dMYaB1bSJsUdWQ8S52fVNjJfFl5bwNkaWwRJHvI8F/4RukyGa7Ka6njLqYHQYM3x6lJoqvBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E8343EE12;
	Thu, 11 Jun 2026 14:58:44 +0000 (UTC)
Message-ID: <be062e2aa08e5cfba7ac4d92352e811350ad0c74.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 1/4] btio: Handle EOPNOTSUPP from accept() to
 prevent busy loop
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 11 Jun 2026 16:58:43 +0200
In-Reply-To: <20260609185313.155105-1-luiz.dentz@gmail.com>
References: <20260609185313.155105-1-luiz.dentz@gmail.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFRPoW6mpOPwFj+4werirHuBzl8EBB8qaJAHrM75JSI9x/TT0+uzSW01rp74Ou4gSVcZLz0njrdq75V0IlwZnlJv2fhTvDIfwa3DRFFhcAh/CpSlqu0Ygn7tGrYNX1znThbdkfBFFAHKs6qzTzYXbgaqnxWjVld4yGAb3or3Z2jvyLsL9qwB6gDoCqijD9gFg0BOQ6A5nSAic7OXhekLDwSBaAcT93dFtXd4pd3vfq/aW9oahOtIHoq/hI5Dyfp31UWnTBq/PWmRV8lqjv97bwyI+SlT0JpSYKn/Q59UCVfIc23I2ktndvHYNz7AOh7rC4FPbo65KrgBZDjDGMCEVdiHQ+7B3js2pWMrDE3kZYE6HGSvG7ZNkYA3MhgN9tHHdyz8Zf3u8JQfKPB8dng0SjqRb44VNwoh/RhVFaFFAWKCOd492cOccjmX9mvaMOWIk6SZLDUcP7Qkjsp4jxfuqGVeQwI6/O/OpFJlB6QAQbFMry/3pTNjas3wOElu8QsjIe5y0iu0aasRCbJERVODudkY3aW0WvXh1FQf79N+cEGcB5bfrySKgkVVzYfIR1jD6GoVOENK9KQZcoSr7bUXi1+ZjIYZLT1k56aNd4UFKE/W2VCLDQVRDZIN71SQuC+MaX5xLWQH5QTE3M0qbDLijj9ckTUVbYwUBlACXG7LD83Zw

On Tue, 2026-06-09 at 14:53 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> When accept() returns EOPNOTSUPP on an L2CAP SEQPACKET server socket
> (e.g. AVCTP browsing channel, PSM 0x1b), the error is permanent and
> retrying will never succeed. Previously, only EBADFD was treated as
> fatal, causing server_cb to return TRUE for EOPNOTSUPP. Since the fd
> remains readable, this creates an infinite busy loop that hangs
> bluetoothd.
>=20
> Treat EOPNOTSUPP the same as EBADFD by returning FALSE to remove the
> GLib IO watch and stop the loop.

This was the infinite loop that was happening on startup, right?

Were there specific circumstances for it to hang like this? I was
wondering whether this was something I could reproduce in the
integration tests I put together for the meson port.

> ---
> =C2=A0btio/btio.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/btio/btio.c b/btio/btio.c
> index 39d4411f790b..4c69d60350f8 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -274,7 +274,7 @@ static gboolean server_cb(GIOChannel *io,
> GIOCondition cond,
> =C2=A0
> =C2=A0	cli_sock =3D accept(srv_sock, NULL, NULL);
> =C2=A0	if (cli_sock < 0) {
> -		if (errno =3D=3D EBADFD)
> +		if (errno =3D=3D EBADFD || errno =3D=3D EOPNOTSUPP)
> =C2=A0			return FALSE;
> =C2=A0		return TRUE;
> =C2=A0	}
