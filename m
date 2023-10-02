Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA3E784BF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 15:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbjJBPoi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbjJBPoZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 11:44:25 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC44C6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 08:44:07 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RzlcN2plJz49Q1k;
        Mon,  2 Oct 2023 18:44:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1696261444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=SGXJUyYI0NyLUyrtmLmy23y0C7Ff+w3Zhc26BcDru6A=;
        b=USH50jX6/g3DNRESjbnqh/vaQJ4atIb0e32H4vYNIMnrpWtthe/PgTwOz5nZ7hfq27YIiW
        09VbR6D0bjBb/mE7Ar5HG70i+b+3hKTej+7z/waA40LfAGuUoOXb/jrZcCQMun3N/qNDiZ
        bT5ZniNL7myU+WpwKkuOjtJ4BPChhMrt4z7kUTGs4L0uDM8YZnafemmOE1PYz3rerz0mL7
        MdHnVzAIGw8L8hjmOFEtQYsfazvSRZ7Ie1qAZG6L/JOniNYyyNWTIxUj5qWnIrE3kik54X
        p9S27GTGhXb94nlUJGzerWUklIq/poLyZITuKEdqbGRggUF+GA9PMSqPYeTtTg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1696261444; a=rsa-sha256;
        cv=none;
        b=IokttIaAp6o7IHsPYW/kU5HHf3xUVd0GYppfKP8SJ/F3xX9XPK5etnZ03hYzz+4MJ++EwD
        qmkLqMtSQo84RpUENfqgnN4k082ddIjRIA346HCyhyaO9RUUbTKZ8XhvyNlX81Ido/iglC
        d2wOxgFArRWp7jycdf8bpI6rbdXT7YNRp/wJRgat/Owh94ppOm2EP+0cW1MM8ddwURpJFk
        g9h/jjc3jgy5qguHkNYlrREgf65+i+ImI7TFZ7T9Fpl4xkHxLdl16SUZH6SPlCcRQoiH05
        rbxcfWgHrjW/p+HcB6Yq1Ck5nXOuIm6RIsqHdU9vSh4VdVWwcHEnBjqvoa74ZQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1696261444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=SGXJUyYI0NyLUyrtmLmy23y0C7Ff+w3Zhc26BcDru6A=;
        b=TIuu9EA1fXzmm4t/6vEkTsbDLUe3Z9BNMUaOGEL6mh936ECN+oB4tAutx1lfsvnTOErla0
        qoEEOYbERNo6D7vWvRHt39TttdisCcBVe+eeGu2GJngNUi4nRg0Mrr243t7y1l6FBu1CAZ
        I+eyy4Y4MA9kEjP+VMTxD4j4WbSlxB1oY13/Ihv1KpeKsWOr+RcCzCGGM//OZqeo7IPEs/
        BYkaT1ftOqAAcw8bwNjN1DR4d0iodly617Jl/M73sk0/Zq810YGmiMlLFrz93o5psfIMab
        NqqnJC6W9EGPHBVC92FYNSWFcVtTN9ECMKdJGrJpnJ4DYazulUkm/C1vLlRP2g==
Message-ID: <55f95bce515ae57d7691aedeb1d1706ae12a0535.camel@iki.fi>
Subject: Re: [PATCH v2 2/3] transport: Update transport release flow for
 bcast src
From:   Pauli Virtanen <pav@iki.fi>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 02 Oct 2023 18:44:02 +0300
In-Reply-To: <20231002153352.3163-3-iulia.tanasescu@nxp.com>
References: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
         <20231002153352.3163-3-iulia.tanasescu@nxp.com>
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

ma, 2023-10-02 kello 18:33 +0300, Iulia Tanasescu kirjoitti:
> From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
>=20
> Update transport release flow for broadcast source
>=20
> ---
>  profiles/audio/transport.c | 63 ++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
>=20
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 1e03b7b51..646061358 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -606,11 +606,38 @@ static DBusMessage *try_acquire(DBusConnection *con=
n, DBusMessage *msg,
>  	return NULL;
>  }
> =20
> +static void bap_stop_complete(struct bt_bap_stream *stream,
> +					uint8_t code, uint8_t reason,
> +					void *user_data)
> +{
> +	struct media_owner *owner =3D user_data;
> +	struct media_request *req =3D owner->pending;
> +	struct media_transport *transport =3D owner->transport;
> +
> +	/* Release always succeeds */
> +	if (req) {
> +		req->id =3D 0;
> +		media_request_reply(req, 0);
> +		media_owner_remove(owner);
> +	}
> +
> +	transport_set_state(transport, TRANSPORT_STATE_IDLE);
> +	media_transport_remove_owner(transport);
> +}
> +
> +static void bap_disable_complete(struct bt_bap_stream *stream,
> +					uint8_t code, uint8_t reason,
> +					void *user_data)
> +{
> +	bap_stop_complete(stream, code, reason, user_data);
> +}
> +
>  static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
>  					void *data)
>  {
>  	struct media_transport *transport =3D data;
>  	struct media_owner *owner =3D transport->owner;
> +	struct bap_transport *bap =3D transport->data;
>  	const char *sender;
>  	struct media_request *req;
>  	guint id;
> @@ -642,6 +669,11 @@ static DBusMessage *release(DBusConnection *conn, DB=
usMessage *msg,
>  	req =3D media_request_create(msg, id);
>  	media_owner_add(owner, req);
> =20
> +	if (bt_bap_stream_get_type(bap->stream) =3D=3D
> +			BT_BAP_STREAM_TYPE_BCAST) {
> +		bap_disable_complete(bap->stream, 0x00, 0x00, owner);
> +	}
> +
>  	return NULL;
>  }
> =20
> @@ -1370,32 +1402,6 @@ static guint resume_bap(struct media_transport *tr=
ansport,
>  	return id;
>  }
> =20
> -static void bap_stop_complete(struct bt_bap_stream *stream,
> -					uint8_t code, uint8_t reason,
> -					void *user_data)
> -{
> -	struct media_owner *owner =3D user_data;
> -	struct media_request *req =3D owner->pending;
> -	struct media_transport *transport =3D owner->transport;
> -
> -	/* Release always succeeds */
> -	if (req) {
> -		req->id =3D 0;
> -		media_request_reply(req, 0);
> -		media_owner_remove(owner);
> -	}
> -
> -	transport_set_state(transport, TRANSPORT_STATE_IDLE);
> -	media_transport_remove_owner(transport);
> -}
> -
> -static void bap_disable_complete(struct bt_bap_stream *stream,
> -					uint8_t code, uint8_t reason,
> -					void *user_data)
> -{
> -	bap_stop_complete(stream, code, reason, user_data);
> -}
> -
>  static guint suspend_bap(struct media_transport *transport,
>  				struct media_owner *owner)
>  {
> @@ -1499,9 +1505,12 @@ static void bap_state_changed(struct bt_bap_stream=
 *stream, uint8_t old_state,
>  			return;
>  		break;
>  	case BT_BAP_STREAM_STATE_STREAMING:
> -		if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SOURCE)

This change is maybe not intended, seems to run update_bcast_qos also
for ucast?

>  			bap_update_bcast_qos(transport);
>  		break;
> +	case BT_BAP_STREAM_STATE_RELEASING:
> +		if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SINK)
> +			return;
> +		break;
>  	}
> =20
>  	io =3D bt_bap_stream_get_io(stream);

