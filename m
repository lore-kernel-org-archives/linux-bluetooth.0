Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960DC5474F
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771229903; cv=none; b=jqbJBEFhaaIx/59Yx4Psou1P/b1ywPoYKWrMWdNjp4VeuRMxNk7M6KV6UmoA7oJ8HL8d4uFvyVCEx8luCjHOJXKedMJWO9aO5I4v+mgBc6D05EfsN7vZ1fvVCM4wGxhwNNpKvXE/CZMqI096nRMQAKz4wUiGr0cAv1lF4nAHhBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771229903; c=relaxed/simple;
	bh=4ZZBXV9LxfuEAaGvGbp4HtGZAUGKocVr7DYfiilApro=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kZdFgZTLagQGblIQQ0Puih3aEx4gNJIpkJPykpU7jp/BOrTMoJ2IvYZsO/UrV5KVB4yjV/qCIcE6wUwJBF6Qwk5J/CWlCht1YZ5WmrMCxI/76OT6vuJaWzW/mwvU5XeYYVlj5rXPTxMwVxyBMXqsDSXIlcCQjvgO232+DoKrMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=185.67.36.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B1D06240027
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 09:16:55 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fDwbq1bdwz9rxR
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 09:16:55 +0100 (CET)
Message-ID: <9728aa9a3d9bbd8034ea9760eb6206e44e859eb4.camel@iki.fi>
Subject: Re: [PATCH BlueZ] a2dp: start connecting sink profile before source
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Feb 2026 08:16:55 +0000
In-Reply-To: <0b3d55690ff2f0ed72271f2760ace8f76a81fb43.1771160059.git.pav@iki.fi>
References: 
	<0b3d55690ff2f0ed72271f2760ace8f76a81fb43.1771160059.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

su, 2026-02-15 kello 14:54 +0200, Pauli Virtanen kirjoitti:
> Since cdcd845f87ee the order in which profiles with the same priority are
> connected is the same order as btd_profile_register() is called, instead
> of being the opposite order.
>=20
> When initiating connections, we want to prefer a2dp-sink profile over
> a2dp-source, as connecting both at the same time does not work
> currently.
>=20
> So swap the order of registration, to restore the previous behavior.

Or maybe it's better to be more explicit, as in following -> v2

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 7a37003a2..1e6300657 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -3769,6 +3769,8 @@ static struct btd_profile a2dp_source_profile =3D {
=20
        .adapter_probe  =3D a2dp_sink_server_probe,
        .adapter_remove =3D a2dp_sink_server_remove,
+
+       .after_services =3D BTD_PROFILE_UUID_CB(NULL, A2DP_SINK_UUID),
 };
=20
 static struct btd_profile a2dp_sink_profile =3D {

>=20
> Fixes: https://github.com/bluez/bluez/issues/1898
> ---
>  profiles/audio/a2dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 7a37003a2..7216ed017 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -3796,8 +3796,8 @@ static struct btd_adapter_driver media_driver =3D {
>  static int a2dp_init(void)
>  {
>  	btd_register_adapter_driver(&media_driver);
> -	btd_profile_register(&a2dp_source_profile);
>  	btd_profile_register(&a2dp_sink_profile);
> +	btd_profile_register(&a2dp_source_profile);
> =20
>  	return 0;
>  }

--=20
Pauli Virtanen

