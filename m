Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49C5CDB474
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjJPQNu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjJPQNt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 12:13:49 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E25EA
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 09:13:47 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S8Mc80YYDz49Q67;
        Mon, 16 Oct 2023 19:13:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1697472824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qdwKOgh/lQDkrDsjScObQFWifoAGyvlX/ub3dihGpPI=;
        b=ShhjgVxzx6ZmtXyw0dto4y8oVycyFg/l1ANrmcl+p+fJ1DPxqZkH0NL9hyBMil1tXkxJ4v
        aQWlQlohkStlpgAC4O/L2gyet8kW/gOpAQLdswEVcx5kFx0vMugZt28qZQwGULE5oAjgoU
        kPQvWXcYSoNoiMog/3GxW6gLIsEDqAbYw2KkOBJ5vT9YUtj93H9lS3ZYwGf4XAb6BpqpYc
        KhEODg1A4wfHdC/J+mcF5MnNRvwrP0ots7EOnj20ny2uDDlKuvAcr1wuQHurdGAfwfwdWv
        Gyu96yScjfFPT/0TshqAQI4Tek8xShzWPG6z2GCPz2l3m31kh208VCoKJ2X7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1697472824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qdwKOgh/lQDkrDsjScObQFWifoAGyvlX/ub3dihGpPI=;
        b=tmpwLHYSXsvyN06nDOG+lKll1WpLqVszMtvehq2gtYcz93Ri+0JmTMhVcP9S/4dqcXP5PS
        LY81SB56C0wdn5NoknAw0ljhbDXxUsGmnoNQe3HYmsT3UBd/s02f4e7XpzxVhlsfSELQ0m
        q40NHf5mqXGIbOJGhyDle5bIpyWrZxVJmjOMc5+hdQZhSt63aQtujDK8aer7vQW+9bipkT
        /9VszMvesDNXoVUCxd9xuDO7/eaEb1yRPod6cbwNVssKcjnPXANUECz+emV+vUm+oYQ+z5
        R9BMs4Gvb03Dr8nCQqXWev/XZcV8VFuA5UYjxGnh7yzABwRP32ot8W9DxCvgRQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1697472824; a=rsa-sha256;
        cv=none;
        b=cFJMjE38L09ok3dkhIYhZY1mVasgX6l0w5l4arj44vBX8XktWUO3z6JK3VEK7XHq/JcyVj
        QrQoupVXlLsf9d3p/mNe22Cal86HSi0UrkCQhbvDdwuNiN9ewSsqqZ2i7skso6RUxVf5mF
        vKNKEe2WO6065jgRLJ8oKIciFhqWtLuJH+gfWQ/NDlC4R9tn54wc2fJuKq+YdNMu9Ns1U9
        dudLpgAZnEOI+vUsKDkkqt0tGCPqU2qqidONNomdUaQn+mTQUch7RFtURlqQF60DeZzmwL
        1F6/V2ZpbROIB4KBzpbWmsbYtYfeeJ76xzKgjm49AtT2MADPTSbDxxxHSxg0Fw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <d5878355969cfb3fec5c05fd312f8665b1bd4398.camel@iki.fi>
Subject: Re: [PATCH 1/2] profiles: Add support for Audio Locations
From:   Pauli Virtanen <pav@iki.fi>
To:     Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Date:   Mon, 16 Oct 2023 19:13:40 +0300
In-Reply-To: <20231016065228.424400-1-kiran.k@intel.com>
References: <20231016065228.424400-1-kiran.k@intel.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (3.50.0-1.fc39) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

ma, 2023-10-16 kello 12:22 +0530, Kiran K kirjoitti:
> This adds support to provide Audio Locations for BAP Sink and Source Endp=
oints
> ---
>  profiles/audio/media.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 1d98ac5a1a70..51e3ab65d12d 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -99,6 +99,7 @@ struct media_endpoint {
>  	size_t			size;		/* Endpoint capabilities size */
>  	uint8_t                 *metadata;      /* Endpoint property metadata *=
/
>  	size_t                  metadata_size;  /* Endpoint metadata size */
> +	uint32_t		location;	/* Endpoint location */
>  	guint			hs_watch;
>  	guint			ag_watch;
>  	guint			watch;
> @@ -1445,6 +1446,7 @@ media_endpoint_create(struct media_adapter *adapter=
,
>  						int size,
>  						uint8_t *metadata,
>  						int metadata_size,
> +						uint32_t location,
>  						int *err)
>  {
>  	struct media_endpoint *endpoint;
> @@ -1460,6 +1462,7 @@ media_endpoint_create(struct media_adapter *adapter=
,
>  	endpoint->cid =3D cid;
>  	endpoint->vid =3D vid;
>  	endpoint->delay_reporting =3D delay_reporting;
> +	endpoint->location =3D location;
> =20
>  	if (qos)
>  		endpoint->qos =3D *qos;
> @@ -1525,7 +1528,8 @@ static int parse_properties(DBusMessageIter *props,=
 const char **uuid,
>  				uint16_t *cid, uint16_t *vid,
>  				struct bt_bap_pac_qos *qos,
>  				uint8_t **capabilities, int *size,
> -				uint8_t **metadata, int *metadata_size)
> +				uint8_t **metadata, int *metadata_size,
> +				uint32_t *location)
>  {
>  	gboolean has_uuid =3D FALSE;
>  	gboolean has_codec =3D FALSE;
> @@ -1609,6 +1613,10 @@ static int parse_properties(DBusMessageIter *props=
, const char **uuid,
>  			if (var !=3D DBUS_TYPE_UINT16)
>  				return -EINVAL;
>  			dbus_message_iter_get_basic(&value, &qos->ppd_max);
> +		} else if (strcasecmp(key, "Location") =3D=3D 0) {

This should be "Locations" to match the documented endpoint property
names. Maybe also the variable names.

The bitmap can contain multiple supported locations, the client will
selects in Config Codec which ones it wants.

> +			if (var !=3D DBUS_TYPE_UINT32)
> +				return -EINVAL;
> +			dbus_message_iter_get_basic(&value, location);
>  		}
> =20
>  		dbus_message_iter_next(props);
> @@ -1633,6 +1641,7 @@ static DBusMessage *register_endpoint(DBusConnectio=
n *conn, DBusMessage *msg,
>  	int size =3D 0;
>  	int metadata_size =3D 0;
>  	int err;
> +	uint32_t location;
> =20
>  	sender =3D dbus_message_get_sender(msg);
> =20
> @@ -1650,12 +1659,12 @@ static DBusMessage *register_endpoint(DBusConnect=
ion *conn, DBusMessage *msg,
> =20
>  	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &cid,
>  			&vid, &qos, &capabilities, &size, &metadata,
> -			&metadata_size) < 0)
> +			&metadata_size, &location) < 0)
>  		return btd_error_invalid_args(msg);
> =20
>  	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
>  					codec, cid, vid, &qos, capabilities,
> -					size, metadata, metadata_size,
> +					size, metadata, metadata_size, location,
>  					&err) =3D=3D NULL) {
>  		if (err =3D=3D -EPROTONOSUPPORT)
>  			return btd_error_not_supported(msg);
> @@ -2688,6 +2697,7 @@ static void app_register_endpoint(void *data, void =
*user_data)
>  	int size =3D 0;
>  	uint8_t *metadata =3D NULL;
>  	int metadata_size =3D 0;
> +	uint32_t location;
>  	DBusMessageIter iter, array;
>  	struct media_endpoint *endpoint;
> =20
> @@ -2748,6 +2758,13 @@ static void app_register_endpoint(void *data, void=
 *user_data)
>  						&metadata_size);
>  	}
> =20
> +	if (g_dbus_proxy_get_property(proxy, "Location", &iter))	{

Same here.

> +		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_UINT32)
> +			goto fail;
> +
> +		dbus_message_iter_get_basic(&iter, &location);
> +	}
> +
>  	/* Parse QoS preferences */
>  	memset(&qos, 0, sizeof(qos));
>  	if (g_dbus_proxy_get_property(proxy, "Framing", &iter)) {
> @@ -2804,7 +2821,7 @@ static void app_register_endpoint(void *data, void =
*user_data)
>  						vendor.cid, vendor.vid, &qos,
>  						capabilities, size,
>  						metadata, metadata_size,
> -						&app->err);
> +						location, &app->err);
>  	if (!endpoint) {
>  		error("Unable to register endpoint %s:%s: %s", app->sender,
>  						path, strerror(-app->err));

