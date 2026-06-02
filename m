Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419603D6461
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396842; cv=none; b=qmNUDI1lN5neIFi0agRzmgRtWs4uI/Qf/sELbbFunUlpLyV4aiU6IOlavBITyMGUWU40kytNpyoidaK0F/cxIhRaZkodL3mPazUYWZHD3aS6hI5Yao66as9dTvyGCVNfM5StqouBHPsq1och12Y6vpQNhrxD5bFNrHQRvhrbGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396842; c=relaxed/simple;
	bh=0WPgj0hwzXoW+5XRVbcvssT075VLyNx3R2lwvqXPdIA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BnrHUHr1dwd1aL0vQn4Mk9fbE9p0uV1PJ3MB9AbZu14BXPHH0l3PUu9rM0ySZlUpAbgSN+uQp4BNkPp14m1CAspG75m1jpRA85Ielhx5KhVU7zZnTLSHfkHsyKhpgVierEmwbQeYEWaQ5Lhj6BXU3zeA1bZb7TaI+cMqv5T+cdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A5A33EC5D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 10:40:38 +0000 (UTC)
Message-ID: <c477047212e595bceabc178759be44793ea423d5.camel@hadess.net>
Subject: Re: [BlueZ v2 1/2] mpris-proxy: Fix possible crash
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 02 Jun 2026 12:40:38 +0200
In-Reply-To: <20260505104847.2550550-1-hadess@hadess.net>
References: <20260505104847.2550550-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEDMnUW+AMS7bRh1Wrn/CSvC9hBxRmAKCKVAB3Qxunqct/4ChaGkkljFIJmKgJAlUnSNXpUUaDYm/Qi30vNSpShV5MyOq9d91Zz8UOWRfrAUzbrO8HuYdDbHL60OxDluDyoSomlnTjI+uKaIGX5JJDzs3AoGDmEf2PIvMmTPbScto1D8SNbqF40rhkYYpYGnT9l+OtwtbTl9pU8fLEDYamqilayitR2L6f3Sla+gDqUTHgKt30jz4ztZzaOyH2JKSWnI596HTDTqzcREadKEyzfndk8O5W4EK9Dp/OrlCgISnFVz+zb2G7GOqHWO6fifuHmfdMODnm6sHZMQHbMVR3dc5lN/O0En5DTCXZXpCx9SNew47RdF433UCO2/Q9M6j904JSy6TMH8CBbAoA7VDYvsPVRAn6A0IAPWbV6OyodrKTVIDSXGTJGVysVRgNBm89TGHecRq3/cWSCrhyuccIs/k2ea0gb3IEhiQWasri+Rn+/0SLMeFXHbcCy2AeSAQGKogbEFuarsMT5lqXfnENvhZ6tMymW01ycXdAIcWra9BdPNidwv5JW2ZVrC2/dzzG+cesdBsviS2FMASnYrCW6/Yf3FoPH6iziHZ33gkXjS8XMjZ51uBtDIuXG0UT66m8kLFrfQxZv2lKcPkP8QSSNyEqf4+2KRzHIL4+siLf6eA

On Tue, 2026-05-05 at 12:48 +0200, Bastien Nocera wrote:
> find_player_by_obex() doesn't check whether session->obex is a valid
> pointer before dereferecing it, but all code paths that assign it use

There's a small typo here, any other comments on those 2 patches?

Any OBEX experts?

> create_obex_session() to assign it, a function that can fail.
>=20
> Check whether session->obex is null before dereferencing it.
>=20
> =C2=A0#0 find_player_by_obex at tools/mpris-proxy.c:2819
> =C2=A0#1 obex_property_changed at tools/mpris-proxy.c:2929
> =C2=A0#2 add_property at gdbus/client.c:373
> =C2=A0#3 update_properties at gdbus/client.c:399
> =C2=A0#5 properties_changed at gdbus/client.c:537
> =C2=A0#6 signal_filter at gdbus/watch.c:416
> =C2=A0#7 message_filter at gdbus/watch.c:566
> =C2=A0#10 message_dispatch at gdbus/mainloop.c:59
> =C2=A0#13 g_main_context_dispatch_unlocked at ../glib/gmain.c:4451
> =C2=A0#14 g_main_context_iterate_unlocked at ../glib/gmain.c:4516
>=20
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2466640
> ---
> Changes since v1:
> - Fix missing space before =3D sign
>=20
> =C2=A0tools/mpris-proxy.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
> index 1d7a421e9278..eb607347aa32 100644
> --- a/tools/mpris-proxy.c
> +++ b/tools/mpris-proxy.c
> @@ -2816,8 +2816,12 @@ static struct player
> *find_player_by_obex(const char *path)
> =C2=A0	for (l =3D players; l; l =3D l->next) {
> =C2=A0		struct player *player =3D l->data;
> =C2=A0		struct obex_session *session =3D player->obex;
> -		const char *obex_path =3D
> g_dbus_proxy_get_path(session->obex);
> +		const char *obex_path =3D NULL;
> =C2=A0
> +		if (session =3D=3D NULL)
> +			continue;
> +
> +		obex_path =3D g_dbus_proxy_get_path(session->obex);
> =C2=A0		if (g_str_has_prefix(path, obex_path))
> =C2=A0			return player;
> =C2=A0	}
