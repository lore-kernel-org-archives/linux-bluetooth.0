Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01B1386DA
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427752; cv=pass; b=Sx8mknlE3mqRSQE44r81KbAGzz5C8EcN94FmpsrTNuCQD+/LhWOug/e/FUi3eZuckORkU1zsU3gkK9fEmMwwEDfcXGsS37e12QTvLQseYT8uw/bFAocREYcmyH6clouLfE3I+54xTywtFMgxj7bIBsun6/A8MJHldImNFkQ0m1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427752; c=relaxed/simple;
	bh=azosZQqj9xrWZVyHKA5dZeMq8KJ1jKowjGTF+pHOh2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j04o5MgGoafGvPx5y9p780+1wcjnobu0culfthXQ8PNI3nUTxfS7J0KW4xwybQ2Mim2Q4mKwKhswONfClw0WMLhFEjsnPzXSswGO1z3ceWIORvTAxYMiLWzp9DvQcab6vYa6a0i+AhzTJ2WNrfdXpoSG02eEpIjx+YXUgXR59L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qehs3AT+; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qehs3AT+"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZjQQ062XYz49PyD;
	Wed, 23 Apr 2025 20:02:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745427737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HswHlVArjyhrRdQN9ckTyAbqLNh7bQzhX3mAuGG5vbw=;
	b=qehs3AT+o1yWiSPbVIBBUfF6eC8KRNP+ty8Pb6wxUDbvcYgPFeDgKp5yQxEllNmTk1hfZd
	Tm4IUaHYfDpUEp2IWs3gmeCDRSd7WSjQIvp7Z8JbJvhKeK5uSWW7oTLIXOAHRYjvaEgv8W
	C/Orjh6U+Wt+7y/083lop5vDnCibDEEN2XYSiohux1CMY2JHkEbqzYNBHZrdrNObpE96Zv
	eEVgUz0Wf0O6rKsN7WbD7g5Aw8to8KDjbh0obaYgjVFDMyKUgZ7LTa3lINPyIxoWwUje0c
	k1DpPMBRfiJ0EG4LezPyxL4jHGNJRgKduAdlzsraR+J5E48yQdCmMVuh6NyrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745427737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HswHlVArjyhrRdQN9ckTyAbqLNh7bQzhX3mAuGG5vbw=;
	b=jC50f/1emDmRDRFKwZtbxcKbUryhi3b+1KuyMHxnXDqvhM4h5K1mOzR96AFalzXMLF95R4
	70TI/Jsal85wExrPG7mNjWvcjPs2Odn4aiGMBbhavwJC7vlYKAeMnWbDngwoCOajViOmj3
	dXgwdAZ+OL5jB0BeEzds4l5JmrH6DlotQkNBykIKuO/p0gAI2QtR9OKMgn6RsfcElfUbS7
	ZUCm7u7iy6UddTPWchu9DoPAOJkU5y5AMQuphQMB684J+pBsbki1Crib9NaOwNCbGrZUEz
	ZQs5tGP9QtVjJQ7hQXJE01uC+fb1owY2q/moJ1hudvMC8K3yN+VTA2DLlJM4Tg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745427737; a=rsa-sha256;
	cv=none;
	b=Bf4ZuPqyKx6ynC5rcWk9vbIHjOXhxKhwBauS5J9e+Owrzks9UiCKFoGy6S3WObFCuCo0ew
	+9tVP9RcKfVDZ+2kxRxswkkSLFnC1lod+4CFmcF2l44fy9pmND/ie6O9NuaK+m76UDW1Z1
	2W9v4dsXC71OVwZNTPoYp3uMbReHXJ9cnd7c4KZFwC4WdDxHoC+YTiqIn2IZh/MEujDCNB
	Pt+VTrec/IB1B2hrDmI9byASBvmP69vrSCe9nEaJoU2y9X2nt7Z1IcKRlUipQsjt4wyXor
	5ZEDnL/F7Ug/iUyNgQDva7OUHepvUi6WYNKzPlJbPJ8yes2dbFFoC2ZVYOjXwA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <ae15a9fa4bf0bd509dd3d44f1f364e241e50956c.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/4] pbap: Support calling pbap_init() after
 pbap_exit()
From: Pauli Virtanen <pav@iki.fi>
To: Andrew Sayers <kernel.org@pileofstuff.org>, 
	linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Date: Wed, 23 Apr 2025 20:02:15 +0300
In-Reply-To: <20250423163343.4160595-2-kernel.org@pileofstuff.org>
References: <20250423163343.4160595-1-kernel.org@pileofstuff.org>
	 <20250423163343.4160595-2-kernel.org@pileofstuff.org>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ke, 2025-04-23 kello 17:33 +0100, Andrew Sayers kirjoitti:
> pbap_exit() didn't previously unregister itself thoroughly.  That
> was fine if it was only called when the service was about to exit,
> because everything was implicitly unregistered when the process ended.
> But we need to be more scrupulous if this can be called throughout
> the program's lifecycle.
>=20
> Send the UnregisterProfile message directly from pbap_exit(),
> then call unregister_profile().
>=20
> The UnregisterProfile message can't be sent directly from
> unregister_profile(), because that also needs to be called when
> register_profile() fails halfway through.
>=20
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>  obexd/client/pbap.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 2f234fadf..e2a3c1b90 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -1483,8 +1483,28 @@ int pbap_init(void)
> =20
>  void pbap_exit(void)
>  {
> +	DBusMessage *msg;
> +	DBusMessageIter iter;
> +	char *uuid =3D PBAP_CLIENT_UUID;
> +
>  	DBG("");
> =20
> +	client_path =3D g_strconcat("/org/bluez/obex/", uuid, NULL);
> +	g_strdelimit(client_path, "-", '_');
> +
> +	msg =3D dbus_message_new_method_call("org.bluez", "/org/bluez",
> +						"org.bluez.ProfileManager1",
> +						"UnregisterProfile");

It was observed in Pipewire that calling UnregisterProfile on exit may
result to long delays on system shutdown, where bluetoothd may be
shutting down at the same time.

IIRC bluetoothd unregisters the profile automatically if you shutdown
the DBus connection, which may be a faster way to teardown.

> +
> +	dbus_message_iter_init_append(msg, &iter);
> +
> +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
> +							&client_path);
> +
> +	g_dbus_send_message(system_conn, msg);
> +
> +	unregister_profile();
> +
>  	dbus_connection_unref(conn);
>  	conn =3D NULL;
> =20

--=20
Pauli Virtanen
