Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265B1DFE0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1566001
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 10:48:05 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 90818240027
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 19:48:02 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SRnrd6n2lz9rxL
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 19:48:01 +0100 (CET)
Message-ID: <efaad61ec6bc258b66d9563194aacb0ce99212a6.camel@iki.fi>
Subject: Re: [PATCH BlueZ 3/4] bap: obtain BAP ucast client QoS via calling
 endpoint SelectQoS()
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 10 Nov 2023 18:48:01 +0000
In-Reply-To: <f1d34641642d675a9e3259c91519a4caa7ffa3fe.1698503903.git.pav@iki.fi>
References: 
	<6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
	 <f1d34641642d675a9e3259c91519a4caa7ffa3fe.1698503903.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

la, 2023-10-28 kello 17:39 +0300, Pauli Virtanen kirjoitti:
> Enable the client endpoint to implement SelectQoS() to configure
> the QoS as a second step in the configuration flow.
>=20
> Remove the QoS parameter from SelectProperties(), as the values
> are not actually know at that point of the configuration flow.
>=20
> If the client does not implement SelectQoS() we will just use all the
> QoS values returned by SelectProperties().  If they are one of the
> mandatory configurations, then maybe devices will accept them.
> ---
>  profiles/audio/bap.c   |  98 +++++++++++++-------
>  profiles/audio/media.c | 201 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 225 insertions(+), 74 deletions(-)
>=20
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index b74498c4c..a289daf15 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -725,23 +725,17 @@ fail:
>  	return -EINVAL;
>  }
> =20
> -static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t r=
eason,
> -					void *user_data)
> +static void ep_reply_msg(struct bap_ep *ep, const char *error)
>  {
> -	struct bap_ep *ep =3D user_data;
>  	DBusMessage *reply;
> =20
> -	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
> -
> -	ep->id =3D 0;
> -
>  	if (!ep->msg)
>  		return;
> =20
> -	if (!code)
> +	if (!error)
>  		reply =3D dbus_message_new_method_return(ep->msg);
>  	else
> -		reply =3D btd_error_failed(ep->msg, "Unable to configure");
> +		reply =3D btd_error_failed(ep->msg, error);
> =20
>  	g_dbus_send_message(btd_get_dbus_connection(), reply);
> =20
> @@ -749,28 +743,30 @@ static void qos_cb(struct bt_bap_stream *stream, ui=
nt8_t code, uint8_t reason,
>  	ep->msg =3D NULL;
>  }
> =20
> -static void config_cb(struct bt_bap_stream *stream,
> -					uint8_t code, uint8_t reason,
> +static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t r=
eason,
>  					void *user_data)
>  {
>  	struct bap_ep *ep =3D user_data;
> -	DBusMessage *reply;
> =20
>  	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
> =20
>  	ep->id =3D 0;
> =20
> -	if (!code)
> -		return;
> +	ep_reply_msg(ep, code ? "Unable to configure" : NULL);
> +}
> =20
> -	if (!ep->msg)
> -		return;
> +static void config_cb(struct bt_bap_stream *stream,
> +					uint8_t code, uint8_t reason,
> +					void *user_data)
> +{
> +	struct bap_ep *ep =3D user_data;
> =20
> -	reply =3D btd_error_failed(ep->msg, "Unable to configure");
> -	g_dbus_send_message(btd_get_dbus_connection(), reply);
> +	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
> =20
> -	dbus_message_unref(ep->msg);
> -	ep->msg =3D NULL;
> +	ep->id =3D 0;
> +
> +	if (code)
> +		ep_reply_msg(ep, "Unable to configure");
>  }
> =20
>  static void bap_io_close(struct bap_ep *ep)
> @@ -1202,7 +1198,7 @@ static void bap_config(void *data, void *user_data)
>  	bt_bap_stream_set_user_data(ep->stream, ep->path);
>  }
> =20
> -static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *cap=
s,
> +static void select_codec_cb(struct bt_bap_pac *pac, int err, struct iove=
c *caps,
>  				struct iovec *metadata, struct bt_bap_qos *qos,
>  				void *user_data)
>  {
> @@ -1252,7 +1248,7 @@ static bool pac_found(struct bt_bap_pac *lpac, stru=
ct bt_bap_pac *rpac,
> =20
>  	/* TODO: Cache LRU? */
>  	if (btd_service_is_initiator(service)) {
> -		if (!bt_bap_select(lpac, rpac, select_cb, ep))
> +		if (!bt_bap_select_codec(lpac, rpac, select_codec_cb, ep))
>  			ep->data->selecting++;
>  	}
> =20
> @@ -1877,6 +1873,36 @@ static void bap_create_io(struct bap_data *data, s=
truct bap_ep *ep,
>  	}
>  }
> =20
> +static void select_qos_cb(struct bt_bap_stream *stream, int err,
> +					struct bt_bap_qos *qos, void *user_data)
> +{
> +	struct bap_ep *ep =3D user_data;
> +
> +	DBG("stream %p err %d qos %p", stream, err, qos);
> +
> +	if (err || ep->id)
> +		goto fail;
> +
> +	if (qos)
> +		ep->qos =3D *qos;
> +
> +	bap_create_io(ep->data, ep, stream, true);

This uses old QoS values, needs to be fixed.

For v2.

> +	if (!ep->io) {
> +		error("Unable to create io");
> +		goto fail;
> +	}
> +
> +	ep->id =3D bt_bap_stream_qos(stream, &ep->qos, qos_cb, ep);
> +	if (!ep->id)
> +		goto fail;
> +
> +	return;
> +
> +fail:
> +	error("Failed to Configure QoS");
> +	ep_reply_msg(ep, "Unable to configure");
> +}
> +
>  static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
>  				uint8_t new_state, void *user_data)
>  {
> @@ -1902,25 +1928,27 @@ static void bap_state(struct bt_bap_stream *strea=
m, uint8_t old_state,
>  			queue_remove(data->streams, stream);
>  		break;
>  	case BT_BAP_STREAM_STATE_CONFIG:
> -		if (ep && !ep->id) {
> +		if (!ep || ep->id)
> +			break;
> +
> +		switch (bt_bap_stream_get_type(stream)) {
> +		case BT_BAP_STREAM_TYPE_UCAST:
> +			if (bt_bap_stream_select_qos(stream,
> +							select_qos_cb, ep)) {
> +				error("Failed to Configure QoS");
> +				bt_bap_stream_release(stream,
> +						NULL, NULL);
> +				return;
> +			}
> +			break;
> +		case BT_BAP_STREAM_TYPE_BCAST:
>  			bap_create_io(data, ep, stream, true);
>  			if (!ep->io) {
>  				error("Unable to create io");
>  				bt_bap_stream_release(stream, NULL, NULL);
>  				return;
>  			}
> -
> -			if (bt_bap_stream_get_type(stream) =3D=3D
> -					BT_BAP_STREAM_TYPE_UCAST) {
> -				/* Wait QoS response to respond */
> -				ep->id =3D bt_bap_stream_qos(stream, &ep->qos,
> -								qos_cb,	ep);
> -				if (!ep->id) {
> -					error("Failed to Configure QoS");
> -					bt_bap_stream_release(stream,
> -								NULL, NULL);
> -				}
> -			}
> +			break;
>  		}
>  		break;
>  	case BT_BAP_STREAM_STATE_QOS:
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 4d9a6aa03..42bc21386 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -318,6 +318,17 @@ static void endpoint_reply(DBusPendingCall *call, vo=
id *user_data)
> =20
>  	dbus_error_init(&err);
>  	if (dbus_set_error_from_message(&err, reply)) {
> +		/* Endpoint is not required to implement SelectQoS */
> +		if (dbus_error_has_name(&err, DBUS_ERROR_UNKNOWN_METHOD) &&
> +		    dbus_message_is_method_call(request->msg,
> +				    MEDIA_ENDPOINT_INTERFACE, "SelectQoS")) {
> +			dbus_error_free(&err);
> +			value =3D FALSE;
> +			size =3D sizeof(value);
> +			ret =3D &value;
> +			goto done;
> +		}
> +
>  		error("Endpoint replied with an error: %s",
>  				err.name);
> =20
> @@ -358,6 +369,13 @@ static void endpoint_reply(DBusPendingCall *call, vo=
id *user_data)
>  		dbus_message_iter_recurse(&args, &props);
>  		ret =3D &props;
>  		goto done;
> +	} else if (dbus_message_is_method_call(request->msg,
> +						MEDIA_ENDPOINT_INTERFACE,
> +						"SelectQoS")) {
> +		dbus_message_iter_init(reply, &args);
> +		dbus_message_iter_recurse(&args, &props);
> +		ret =3D &props;
> +		goto done;
>  	} else if (!dbus_message_get_args(reply, &err, DBUS_TYPE_INVALID)) {
>  		error("Wrong reply signature: %s", err.message);
>  		dbus_error_free(&err);
> @@ -725,9 +743,9 @@ static bool endpoint_init_a2dp_sink(struct media_endp=
oint *endpoint, int *err)
>  	return true;
>  }
> =20
> -struct pac_select_data {
> +struct pac_select_codec_data {
>  	struct bt_bap_pac *pac;
> -	bt_bap_pac_select_t cb;
> +	bt_bap_pac_select_codec_t cb;
>  	void *user_data;
>  };
> =20
> @@ -881,10 +899,10 @@ fail:
>  	return -EINVAL;
>  }
> =20
> -static void pac_select_cb(struct media_endpoint *endpoint, void *ret, in=
t size,
> -							void *user_data)
> +static void pac_select_codec_cb(struct media_endpoint *endpoint, void *r=
et,
> +						int size, void *user_data)
>  {
> -	struct pac_select_data *data =3D user_data;
> +	struct pac_select_codec_data *data =3D user_data;
>  	DBusMessageIter *iter =3D ret;
>  	int err;
>  	struct iovec caps, meta;
> @@ -920,15 +938,15 @@ done:
>  	data->cb(data->pac, err, &caps, &meta, &qos, data->user_data);
>  }
> =20
> -static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> -			struct bt_bap_pac_qos *qos,
> -			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
> +static int pac_select_codec(struct bt_bap_pac *lpac, struct bt_bap_pac *=
rpac,
> +			bt_bap_pac_select_codec_t cb, void *cb_data,
> +			void *user_data)
>  {
>  	struct media_endpoint *endpoint =3D user_data;
>  	struct iovec *caps;
>  	struct iovec *metadata;
>  	const char *endpoint_path;
> -	struct pac_select_data *data;
> +	struct pac_select_codec_data *data;
>  	DBusMessage *msg;
>  	DBusMessageIter iter, dict;
>  	const char *key =3D "Capabilities";
> @@ -946,7 +964,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct=
 bt_bap_pac *rpac,
>  		return -ENOMEM;
>  	}
> =20
> -	data =3D new0(struct pac_select_data, 1);
> +	data =3D new0(struct pac_select_codec_data, 1);
>  	data->pac =3D lpac;
>  	data->cb =3D cb;
>  	data->user_data =3D cb_data;
> @@ -977,47 +995,151 @@ static int pac_select(struct bt_bap_pac *lpac, str=
uct bt_bap_pac *rpac,
>  						metadata->iov_len);
>  	}
> =20
> -	if (qos && qos->phy) {
> -		DBusMessageIter entry, variant, qos_dict;
> +	dbus_message_iter_close_container(&iter, &dict);
> +
> +	return media_endpoint_async_call(msg, endpoint, NULL,
> +					pac_select_codec_cb, data, free);
> +}
> +
> +struct pac_select_qos_data {
> +	struct bt_bap_stream *stream;
> +	bt_bap_pac_select_qos_t cb;
> +	void *user_data;
> +};
> +
> +static void pac_select_qos_cb(struct media_endpoint *endpoint, void *ret=
,
> +						int size, void *user_data)
> +{
> +	struct pac_select_qos_data *data =3D user_data;
> +	DBusMessageIter *iter =3D ret;
> +	int err;
> +	struct bt_bap_qos qos;
> +
> +	if (!ret) {
> +		data->cb(data->stream, -EPERM, NULL, data->user_data);
> +		return;
> +	} else if (size > 0) {
> +		/* Endpoint doesn't implement the method, use old values */
> +		data->cb(data->stream, 0, NULL, data->user_data);
> +		return;
> +	}
> +
> +	if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_DICT_ENTRY) {
> +		DBG("Unexpected argument type: %c !=3D %c",
> +			    dbus_message_iter_get_arg_type(iter),
> +			    DBUS_TYPE_DICT_ENTRY);
> +		data->cb(data->stream, -EINVAL, NULL, data->user_data);
> +		return;
> +	}
> +
> +	memset(&qos, 0, sizeof(qos));
> +
> +	/* Mark CIG and CIS to be auto assigned */
> +	qos.ucast.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> +	qos.ucast.cis_id =3D BT_ISO_QOS_CIS_UNSET;
> +
> +	err =3D parse_select_properties(iter, NULL, NULL, &qos);
> +	if (err < 0)
> +		DBG("Unable to parse properties");
> +
> +	data->cb(data->stream, err, &qos, data->user_data);
> +}
> =20
> -		key =3D "QoS";
> -		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
> -								NULL, &entry);
> -		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> -		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
> -							"a{sv}", &variant);
> -		dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
> -							"{sv}", &qos_dict);
> +static int pac_select_qos(struct bt_bap_stream *stream,
> +			struct bt_bap_pac_qos *qos, bt_bap_pac_select_qos_t cb,
> +			void *cb_data, void *user_data)
> +{
> +	struct media_endpoint *endpoint =3D user_data;
> +	struct bt_bap_pac *rpac;
> +	const char *endpoint_path;
> +	struct pac_select_qos_data *data;
> +	struct iovec *caps, *metadata;
> +	DBusMessage *msg;
> +	DBusMessageIter iter, dict;
> +	DBusMessageIter entry, variant, qos_dict;
> +	const char *key =3D "Capabilities";
> +
> +	rpac =3D bt_bap_stream_get_rpac(stream);
> +	if (!rpac)
> +		return -EINVAL;
> =20
> -		g_dbus_dict_append_entry(&qos_dict, "Framing", DBUS_TYPE_BYTE,
> -							&qos->framing);
> +	caps =3D bt_bap_stream_get_config(stream);
> +	if (!caps)
> +		return -EINVAL;
> =20
> -		g_dbus_dict_append_entry(&qos_dict, "PHY", DBUS_TYPE_BYTE,
> -							&qos->phy);
> +	msg =3D dbus_message_new_method_call(endpoint->sender, endpoint->path,
> +						MEDIA_ENDPOINT_INTERFACE,
> +						"SelectQoS");
> +	if (msg =3D=3D NULL) {
> +		error("Couldn't allocate D-Bus message");
> +		return -ENOMEM;
> +	}
> =20
> -		g_dbus_dict_append_entry(&qos_dict, "MaximumLatency",
> -					DBUS_TYPE_UINT16, &qos->latency);
> +	data =3D new0(struct pac_select_qos_data, 1);
> +	data->stream =3D stream;
> +	data->cb =3D cb;
> +	data->user_data =3D cb_data;
> =20
> -		g_dbus_dict_append_entry(&qos_dict, "MinimumDelay",
> -					DBUS_TYPE_UINT32, &qos->pd_min);
> +	dbus_message_iter_init_append(msg, &iter);
> =20
> -		g_dbus_dict_append_entry(&qos_dict, "MaximumDelay",
> -					DBUS_TYPE_UINT32, &qos->pd_max);
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict)=
;
> =20
> -		g_dbus_dict_append_entry(&qos_dict, "PreferredMinimumDelay",
> -					DBUS_TYPE_UINT32, &qos->ppd_min);
> +	endpoint_path =3D bt_bap_pac_get_user_data(rpac);
> +	if (endpoint_path)
> +		g_dbus_dict_append_entry(&dict, "Endpoint",
> +					DBUS_TYPE_OBJECT_PATH, &endpoint_path);
> =20
> -		g_dbus_dict_append_entry(&qos_dict, "PreferredMaximumDelay",
> -					DBUS_TYPE_UINT32, &qos->ppd_max);
> +	key =3D "Capabilities";
> +	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
> +						DBUS_TYPE_BYTE, &caps->iov_base,
> +						caps->iov_len);
> =20
> -		dbus_message_iter_close_container(&variant, &qos_dict);
> -		dbus_message_iter_close_container(&entry, &variant);
> -		dbus_message_iter_close_container(&dict, &entry);
> +	metadata =3D bt_bap_stream_get_metadata(stream);
> +	if (metadata) {
> +		key =3D "Metadata";
> +		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
> +						DBUS_TYPE_BYTE,
> +						&metadata->iov_base,
> +						metadata->iov_len);
>  	}
> =20
> +	key =3D "QoS";
> +	dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
> +			NULL, &entry);
> +	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
> +			"a{sv}", &variant);
> +	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
> +			"{sv}", &qos_dict);
> +
> +	g_dbus_dict_append_entry(&qos_dict, "Framing", DBUS_TYPE_BYTE,
> +			&qos->framing);
> +
> +	g_dbus_dict_append_entry(&qos_dict, "PHY", DBUS_TYPE_BYTE,
> +			&qos->phy);
> +
> +	g_dbus_dict_append_entry(&qos_dict, "MaximumLatency",
> +			DBUS_TYPE_UINT16, &qos->latency);
> +
> +	g_dbus_dict_append_entry(&qos_dict, "MinimumDelay",
> +			DBUS_TYPE_UINT32, &qos->pd_min);
> +
> +	g_dbus_dict_append_entry(&qos_dict, "MaximumDelay",
> +			DBUS_TYPE_UINT32, &qos->pd_max);
> +
> +	g_dbus_dict_append_entry(&qos_dict, "PreferredMinimumDelay",
> +			DBUS_TYPE_UINT32, &qos->ppd_min);
> +
> +	g_dbus_dict_append_entry(&qos_dict, "PreferredMaximumDelay",
> +			DBUS_TYPE_UINT32, &qos->ppd_max);
> +
> +	dbus_message_iter_close_container(&variant, &qos_dict);
> +	dbus_message_iter_close_container(&entry, &variant);
> +	dbus_message_iter_close_container(&dict, &entry);
> +
>  	dbus_message_iter_close_container(&iter, &dict);
> =20
> -	return media_endpoint_async_call(msg, endpoint, NULL, pac_select_cb,
> +	return media_endpoint_async_call(msg, endpoint, NULL, pac_select_qos_cb=
,
>  								data, free);
>  }
> =20
> @@ -1187,8 +1309,9 @@ static void pac_clear(struct bt_bap_stream *stream,=
 void *user_data)
>  }
> =20
>  static struct bt_bap_pac_ops pac_ops =3D {
> -	.select =3D pac_select,
> +	.select_codec =3D pac_select_codec,
>  	.config =3D pac_config,
> +	.select_qos =3D pac_select_qos,
>  	.clear =3D pac_clear,
>  };
> =20

