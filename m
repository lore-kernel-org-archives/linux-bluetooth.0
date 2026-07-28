Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A7330668
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254480; cv=none; b=eQ7i1/QvyWBYGds1UzjwUSUJIXBR1L6BGxEuhzfW/fPzYHVqFI26I48an0KDdIRQPbV3k4eBvG8jH4Q79ysgWylPKfV9yWoaYLpt8TkgpDckayTeS2BWLwuiW2Jt4Q1Sq0Vp9Oe9/8N+GF68dmhBxSXcA7kiVhaAwaUIOgZcoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254480; c=relaxed/simple;
	bh=0UbX4+Fy4W6oJOwGg0BCEyRPI+BqZg4b5igrMxafkAE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sjhkilSec0/TMOO8cOxZhBpX2/FQuU02gn8YM1t6y9dKgjJqZHRqUH0fjRuFES9Tefh/9ypYuSB8oHUa5HiXAywPjzSY/9V4KEMd5AlhH9rdVRaetKHe1a3NRrl3xd6TX0vMCS0wUmAGa+U5r+3Ux+msSCIqzEUuv3/VwvZwMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE0973EDA5;
	Tue, 28 Jul 2026 16:01:09 +0000 (UTC)
Message-ID: <12e961a0fdd2211fbca60a5ace35ae4490e53c1a.camel@hadess.net>
Subject: Re: [PATCH BlueZ bluez v3] bap: Start BIG sync after receiving
 BIGInfo
From: Bastien Nocera <hadess@hadess.net>
To: yang.li@amlogic.com, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Date: Tue, 28 Jul 2026 18:01:09 +0200
In-Reply-To: <20260728-big_sync-v3-1-c2da19f3c00b@amlogic.com>
References: <20260728-big_sync-v3-1-c2da19f3c00b@amlogic.com>
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
X-GND-Cause: dmFkZTGJH3z8ACo8l0V5C5m9CZuIiwPpz8VP1Zdpp6sLk2PSqHN2nhYSoxYD3Fqm/ySTt0ASiRUbuclbRnM17pQnPlHdvlzE1sGaEL0YUOoWWH5WnHCWVFdUiXgQ/8+n6/uU/ceaY3Xq8KDItvQdbxpWh7vI070fM71Gx0ALYXAjiXGRa7BUgml5+I+IV9V4n4RFQpKK24x8rq14fSnnYCT3fAhdc8fFnWCcyhatx8MMK+c7e6XsSCmag6wwA/UZJJMFMkBvE5PDKyWSH32/pJZ261F/wNUGiTyGRjTa/Bf36QsDF1NSuEjOqhCvnK7m9DCja1Up/BcmvCYFRR6eEU5bvoZPHgAngL3NYXK2ajVT7j94aZW+gemEJsft5U3WkOFK8R8xgDNNXrHtYQEm4tkZZdmKWDlXndBfY3iYiQG/GyLQFTEbGEYdtekE5Njb5VpvjqJh/QEKsMPO8XTRh6QRBDncEedlWZOkHYjMOND0sE6EXkrJt1bXReXESCKKuVu5MCMRwgO2KebQkUAWO/S5kA+VOKIGED0gArb0hJP/gtie22q5pNu3gBWrW4ERuMMruf8sncWlJlpOxGzKrifasRmqA5ePgTxe+ElL3GEpkTs2S8hRZLcHFjE+oL41t/5TMiywegV6gs8BgcRLyfs4qD55TpiNFEU+zKe5R1EgSpg8Lw



On Tue, 2026-07-28 at 14:26 +0800, Yang Li via B4 Relay wrote:
> From: Yang Li <yang.li@amlogic.com>
>=20
> The current implementation starts BIG sync before receiving a BIGInfo
> report. According to the Bluetooth Core Specification, BIG sync
> should
> only be initiated after BIGInfo has been received.
>=20
> Starting BIG sync too early may cause unexpected controller behavior.
>=20
> Trigger BIG sync from the BIGInfo callback, following the same
> approach
> used by the short PA flow.
>=20
> Fixes: https://github.com/bluez/bluez/issues/2345
>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v3:
> - Fixed coding style warning.
> - Link to v2:
> https://patch.msgid.link/20260727-big_sync-v2-1-053fd3bcc3be@amlogic.com
>=20
> Changes in v2:
> - Fixed build error.
> - Link to v1:
> https://patch.msgid.link/20260724-big_sync-v1-1-0a35013e30ba@amlogic.com
> ---
> =C2=A0profiles/audio/bap.c | 25 +++++++++++++++++++++----
> =C2=A01 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index dd4b3c8ff..473e4cfc2 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -3650,7 +3650,8 @@ static void setup_refresh_qos(void *data, void
> *user_data)
> =C2=A0	setup->qos =3D *bt_bap_stream_get_qos(stream);
> =C2=A0}
> =C2=A0
> -static void iso_do_big_sync(GIOChannel *io, void *user_data)
> +static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
> +						void *user_data)

The return here is for:
"The function should return FALSE if the event source should be
removed."
Not success or failure.

See:
https://docs.gtk.org/glib/callback.IOFunc.html
https://docs.gtk.org/glib/func.io_add_watch.html

> =C2=A0{
> =C2=A0	GError *err =3D NULL;
> =C2=A0	struct bap_setup *setup =3D user_data;
> @@ -3659,7 +3660,7 @@ static void iso_do_big_sync(GIOChannel *io,
> void *user_data)
> =C2=A0	struct bt_iso_qos qos;
> =C2=A0	struct queue *links =3D bt_bap_stream_io_get_links(setup-
> >stream);
> =C2=A0
> -	DBG("PA Sync done");
> +	DBG("BIG info received, do BIG sync");
> =C2=A0
> =C2=A0	g_io_channel_unref(data->listen_io);
> =C2=A0	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
> @@ -3682,6 +3683,7 @@ static void iso_do_big_sync(GIOChannel *io,
> void *user_data)
> =C2=A0			BT_IO_OPT_INVALID)) {
> =C2=A0		error("bt_io_set: %s", err->message);
> =C2=A0		g_error_free(err);
> +		return FALSE;

This is wrong, this should be TRUE or better G_SOURCE_REMOVE.

> =C2=A0	}
> =C2=A0
> =C2=A0	if (!bt_io_bcast_accept(io,
> @@ -3692,16 +3694,31 @@ static void iso_do_big_sync(GIOChannel *io,
> void *user_data)
> =C2=A0			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
> =C2=A0		error("bt_io_bcast_accept: %s", err->message);
> =C2=A0		g_error_free(err);
> +		return FALSE;

Here too.

> =C2=A0	}
> +
> +	return TRUE;
> +}
> +
> +static void long_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
> +{
> +	struct bap_setup *setup =3D user_data;
> +	struct bap_data *data =3D setup->data;
> +
> +	DBG("Long PA Sync done");
> +
> +	/* store io and add watch that will call iso_do_big_sync */
> +	data->io_id =3D g_io_add_watch(io, G_IO_OUT, iso_do_big_sync,
> +							setup);
> =C2=A0}
> =C2=A0
> =C2=A0static void pa_and_big_sync(struct bap_setup *setup)
> =C2=A0{
> =C2=A0	GError *err =3D NULL;
> =C2=A0	struct bap_data *bap_data =3D setup->data;
> -
> =C2=A0	DBG("Create PA sync with this source");
> -	bap_data->listen_io =3D bt_io_listen(NULL, iso_do_big_sync,
> setup,
> +
> +	bap_data->listen_io =3D bt_io_listen(NULL,
> long_pa_sync_confirm_cb, setup,
> =C2=A0			NULL, &err,
> =C2=A0			BT_IO_OPT_SOURCE_BDADDR,
> =C2=A0			btd_adapter_get_address(bap_data->adapter),
>=20
> ---
> base-commit: 89d477bb5494eef0b24e5667be62f854da250a97
> change-id: 20260724-big_sync-45c24ec09121
>=20
> Best regards,
