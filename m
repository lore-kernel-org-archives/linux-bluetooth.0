Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1841760
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702782; cv=pass; b=j2Ep6TClByTP6i+ZBG2Eziz8dfxuAtrxL3ix4Sem2g9b7UGLhn8hiQ/5JXZ4Ey8lLRwjEXyidjXajZLKtx571yOZ0s8gMWSBy1GccyqHgiuqEbYBZcR+yT3jMZQDNxb1RT5JI4IXtAfYlhY0XEjaWVpVJvGyKyqrpU9zsIFl0hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702782; c=relaxed/simple;
	bh=+XvI0CjoQ34X9sc751F9ZURp/Fpv3ZL+Rqh5i00QJs4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aa38dvIGBB7gDqbWu8kURHNNJKJhJaSSbABtuplamg0JY/ATOthYbjVU/uLVErv7C927fSVRyG3HGNQYJJ3TVJhDDTOiuTZnBv54JaftOLrZ8UR1B+Ml+u/KrkmTIKrzGNjZkkKwXfx5ln7unc6HyetFdXUBka81k9xZJ+Li8aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=BHW7LD9/; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="BHW7LD9/"
Received: from [10.71.62.38] (unknown [185.65.133.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fzrd05T1rz49PwS;
	Mon, 20 Apr 2026 19:32:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776702773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EL5nW40SV/viF0D+VXh0pT7q/MAL8xwm+f8w6LMCnU0=;
	b=BHW7LD9/dN7Ir9MDZDSgSj/vyPkin6z8DrNdat3bJO7SPZujgPbfD+l0E/HPbY7WhPeHZH
	P/K8V+R9kp+VWgV2QEXOvb5BvIIy8KVzd/EFgVZC4s7ffahOKYvk8Wd8gjGoXtITSAwY+B
	25iq+oZfV9zz82hVFen1Tb+CLyHGsl3F0xEoDlJN8wJbcjQXo7RJBv0p7zrsLsoC0AYZeo
	jU+hMAXdsWbJPzxTEZ44vnYgKC+gnN+il/I2ziOK9tTULmuWlGDCH82dovO//RJmg+2hOu
	YsgmSiNe6VuHgpGY5ror8mRJD+15AMg6/elCR6tPYGP/8QJg/ohf9qYr4pb8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776702773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EL5nW40SV/viF0D+VXh0pT7q/MAL8xwm+f8w6LMCnU0=;
	b=FUxhc21I+o7Kpv3Y+dDhZ4jA/dNdjBYMI0lyEmIkhtW5zFSV2p7mNCmnRNNP5V2d6jLN/P
	uwtSlvkdgoabbkY7zMl4GPoEKiCf9i6Ahft0ejqmVGHHfKnfe8mJ8peNZPyeqsARgEpbIa
	Owv6RjFgBZRqLwEup/64ITDqh6gdJAXYvAPl+5ra9PT6TxNeJmuS9u4Ne2UghaNlVe4zaG
	HxBZ+QIBxAxsrqoRfTuIZWAc89+LN4vh+OmAaXG08AFrFsiXaMzReTALHH50q697DAO4qD
	OqoxVixfmrF0SHni9zIDXo7sUvN7NvgS7r2mYiVKzv1a1LDK+2+xG7ji2mDMYw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776702773;
	b=Op1fhqhpToUHi9ydW+5A68iFobQuFEc91hZcyb1lCz3EmZd+z8UP+2WjEV3NLjqmuN/pOD
	/GYT5i6NcI4ATdGvPplyjgl3s0OTfNQL5fkIf7yBVQy6CLRO0iocjwJIiAXNz2QxnggJY1
	en5eMfe1Dniw8VPHNDW9aV883DJsVF7AS6Fyb/8GSycngeOXqgXyHW/iNc0Y8H0JpSOAOR
	K3mOvEvffjh29EL2TaEUHMjIhXVt41VGVsCodOylA+0Sl4PIC9ttJGsdGUbozY9L0BRX41
	LrR61R1owooLp2ZMPC3J5bncUO+Bxf+2HmzAE34OJo8ddVM2pfHSysKwrAhDog==
Message-ID: <af80f4c5bdab56eb525102ffcf3dbcd2f92ca06e.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/3] audio: Add ability to force CIS transport
 Links property
From: Pauli Virtanen <pav@iki.fi>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Date: Mon, 20 Apr 2026 19:32:35 +0300
In-Reply-To: <20260420161345.145089-1-frederic.danis@collabora.com>
References: <20260420161345.145089-1-frederic.danis@collabora.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-04-20 kello 18:13 +0200, Fr=C3=A9d=C3=A9ric Danis kirjoitti:
> If bluetoothd is started in testing mode the Links property for CIS
> is readwrite and can be used to force transport objects Links.
> This can used to unlink transport objects by sending an empty array.
>=20
> For unlinked transport objects, each transports needs to be acquired
> separately.
>=20
> This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
> ---
>  profiles/audio/bap.c       | 44 +++++++++++++++++++++++++++++
>  profiles/audio/transport.c | 57 +++++++++++++++++++++++++++++++-------
>  2 files changed, 91 insertions(+), 10 deletions(-)
>=20
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 375026440..8f1f75240 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -2651,13 +2651,57 @@ static void bap_connect_bcast_io_cb(GIOChannel *c=
han, GError *err,
>  	iso_connect_bcast_cb(chan, err, setup->stream);
>  }
> =20
> +struct connect_io_data {
> +	GIOChannel *chan;
> +	GError *err;
> +	uint8_t cig_id;
> +};
> +
> +static bool find_enabling_stream(const void *data, const void *match_dat=
a)
> +{
> +	const struct bap_setup *setup =3D data;
> +	const struct connect_io_data *d =3D match_data;
> +	uint8_t state;
> +
> +	state =3D bt_bap_stream_get_state(setup->stream);
> +	if (state =3D=3D BT_BAP_STREAM_STATE_ENABLING &&
> +			setup->qos.ucast.cig_id =3D=3D d->cig_id)
> +		iso_connect_cb(d->chan, d->err, setup->stream);
> +
> +	return false;
> +}
> +
> +static bool find_enabling_ep(const void *data, const void *match_data)
> +{
> +	const struct bap_ep *ep =3D data;
> +
> +	if (ep->setups)
> +		queue_find(ep->setups, find_enabling_stream, match_data);
> +
> +	return false;
> +}
> +
>  static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer us=
er_data)
>  {
>  	struct bap_setup *setup =3D user_data;
> +	struct connect_io_data data;
> =20
>  	if (!setup->stream)
>  		return;
> =20
> +	if (bt_bap_stream_get_state(setup->stream) !=3D
> +			 BT_BAP_STREAM_STATE_ENABLING) {

The order of transition to STATE_STREAMING and iso_connect_cb() has
been reported to be nondeterministic=20

https://github.com/bluez/bluez/issues/1506

and it appears in normal usage sometimes the state is STATE_STREAMING
here.

Probably the order in which the Glib mainloop handles the fd wakeups is
unspecified if the events arrive too close to each other, regardless of
the order in which kernel sees the events.

It's probably not right to assume here !=3D ENABLING means the testing
feature is used, but it probably should check some extra unlink flag.

> +		/* The stream may have manually been unliked for tests and the
> +		 * connect event refers to another stream of the CIG.
> +		 */
> +		data.chan =3D chan;
> +		data.err =3D err;
> +		data.cig_id =3D setup->qos.ucast.cig_id;
> +		queue_find(setup->ep->data->snks, find_enabling_ep, &data);
> +		queue_find(setup->ep->data->srcs, find_enabling_ep, &data);
> +		return;
> +	}
> +
>  	iso_connect_cb(chan, err, setup->stream);
>  }
> =20
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index d9feef768..794c492af 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -37,6 +37,7 @@
>  #include "src/shared/bap.h"
>  #include "src/shared/bass.h"
>  #include "src/shared/io.h"
> +#include "src/btd.h"
> =20
>  #ifdef HAVE_A2DP
>  #include "avdtp.h"
> @@ -114,6 +115,7 @@ struct bap_transport {
>  struct media_transport_ops {
>  	const char *uuid;
>  	const GDBusPropertyTable *properties;
> +	const GDBusPropertyTable *test_properties;
>  	void (*set_owner)(struct media_transport *transport,
>  				struct media_owner *owner);
>  	void (*remove_owner)(struct media_transport *transport,
> @@ -1417,6 +1419,9 @@ static struct media_transport *find_transport_by_pa=
th(const char *path)
>  	return NULL;
>  }
> =20
> +static void bap_update_links(const struct media_transport *transport);
> +static void transport_unlink(void *data, void *user_data);
> +
>  static void set_links(const GDBusPropertyTable *property,
>  				DBusMessageIter *iter,
>  				GDBusPendingPropertySet id, void *user_data)
> @@ -1434,6 +1439,16 @@ static void set_links(const GDBusPropertyTable *pr=
operty,
> =20
>  	dbus_message_iter_recurse(iter, &array);
> =20
> +	if (dbus_message_iter_get_arg_type(&array) =3D=3D DBUS_TYPE_INVALID) {
> +		struct queue *links =3D bt_bap_stream_io_get_links(bap->stream);
> +
> +		/* Unlink stream from all its links */
> +		queue_foreach(links, transport_unlink, bap->stream);
> +
> +		bt_bap_stream_io_unlink(bap->stream, NULL);
> +		bap_update_links(transport);
> +	}
> +
>  	while (dbus_message_iter_get_arg_type(&array) =3D=3D
>  						DBUS_TYPE_OBJECT_PATH) {
>  		struct media_transport *link;
> @@ -1484,6 +1499,21 @@ static const GDBusPropertyTable transport_bap_uc_p=
roperties[] =3D {
>  	{ }
>  };
> =20
> +static const GDBusPropertyTable transport_bap_uc_test_properties[] =3D {
> +	{ "Device", "o", get_device },
> +	{ "UUID", "s", get_uuid },
> +	{ "Codec", "y", get_codec },
> +	{ "Configuration", "ay", get_configuration },
> +	{ "State", "s", get_state },
> +	{ "QoS", "a{sv}", get_ucast_qos, NULL, qos_ucast_exists },
> +	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
> +	{ "Location", "u", get_location },
> +	{ "Metadata", "ay", get_metadata, set_metadata },
> +	{ "Links", "ao", get_links, set_links, links_exists },
> +	{ "Volume", "q", get_volume, set_volume, volume_exists },
> +	{ }
> +};
> +
>  static gboolean get_bcast_qos(const GDBusPropertyTable *property,
>  					DBusMessageIter *iter, void *data)
>  {
> @@ -1879,8 +1909,6 @@ static void bap_resume_complete(struct media_transp=
ort *transport)
>  	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
>  }
> =20
> -static void bap_update_links(const struct media_transport *transport);
> -
>  static bool match_link_transport(const void *data, const void *user_data=
)
>  {
>  	const struct bt_bap_stream *stream =3D data;
> @@ -2535,10 +2563,11 @@ static void *transport_asha_init(struct media_tra=
nsport *transport, void *data)
>  #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
>  		      _resume, _suspend, _cancel, _set_state, _get_stream, \
>  		      _get_volume, _set_volume, _set_delay, _update_links, \
> -		      _destroy) \
> +		      _destroy, _test_props) \
>  { \
>  	.uuid =3D _uuid, \
>  	.properties =3D _props, \
> +	.test_properties =3D _test_props, \
>  	.set_owner =3D _set_owner, \
>  	.remove_owner =3D _remove_owner, \
>  	.init =3D _init, \
> @@ -2560,26 +2589,28 @@ static void *transport_asha_init(struct media_tra=
nsport *transport, void *data)
>  			transport_a2dp_resume, transport_a2dp_suspend, \
>  			transport_a2dp_cancel, NULL, \
>  			transport_a2dp_get_stream, transport_a2dp_get_volume, \
> -			_set_volume, _set_delay, NULL, _destroy)
> +			_set_volume, _set_delay, NULL, _destroy, NULL)
> =20
>  #define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links,=
 \
> -		_set_state) \
> +		_set_state, _test_props) \
>  	TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
>  			transport_bap_init, \
>  			transport_bap_resume, transport_bap_suspend, \
>  			transport_bap_cancel, _set_state, \
>  			transport_bap_get_stream, transport_bap_get_volume, \
>  			transport_bap_set_volume, NULL, \
> -			_update_links, transport_bap_destroy)
> +			_update_links, transport_bap_destroy, _test_props)
> =20
>  #define BAP_UC_OPS(_uuid) \
>  	BAP_OPS(_uuid, transport_bap_uc_properties, \
>  			transport_bap_set_owner, transport_bap_remove_owner, \
> -			transport_bap_update_links_uc, transport_bap_set_state)
> +			transport_bap_update_links_uc, \
> +			transport_bap_set_state, \
> +			transport_bap_uc_test_properties)
> =20
>  #define BAP_BC_OPS(_uuid) \
>  	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL, \
> -			transport_bap_update_links_bc, NULL)
> +			transport_bap_update_links_bc, NULL, NULL)
> =20
>  #define ASHA_OPS(_uuid) \
>  	TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
> @@ -2587,7 +2618,7 @@ static void *transport_asha_init(struct media_trans=
port *transport, void *data)
>  			transport_asha_resume, transport_asha_suspend, \
>  			transport_asha_cancel, NULL, NULL, \
>  			transport_asha_get_volume, transport_asha_set_volume, \
> -			NULL, NULL, NULL)
> +			NULL, NULL, NULL, NULL)
> =20
>  static const struct media_transport_ops transport_ops[] =3D {
>  #ifdef HAVE_A2DP
> @@ -2642,6 +2673,7 @@ struct media_transport *media_transport_create(stru=
ct btd_device *device,
>  	struct media_transport *transport;
>  	const struct media_transport_ops *ops;
>  	int fd;
> +	const GDBusPropertyTable *properties;
> =20
>  	transport =3D g_new0(struct media_transport, 1);
>  	if (device)
> @@ -2696,9 +2728,14 @@ struct media_transport *media_transport_create(str=
uct btd_device *device,
>  			goto fail;
>  	}
> =20
> +	if (btd_opts.testing && ops->test_properties)
> +		properties =3D ops->test_properties;
> +	else
> +		properties =3D ops->properties;
> +
>  	if (g_dbus_register_interface(btd_get_dbus_connection(),
>  				transport->path, MEDIA_TRANSPORT_INTERFACE,
> -				transport_methods, NULL, ops->properties,
> +				transport_methods, NULL, properties,
>  				transport, media_transport_free) =3D=3D FALSE) {
>  		error("Could not register transport %s", transport->path);
>  		goto fail;

--=20
Pauli Virtanen
