Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7F7082F
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318921; cv=pass; b=uZa4Brp3Cae4zpX4W5s+GKHx+Yzf6HbNK0LxmFuOss5U6IAGLVT2M8xCjfGP/E4k1hvNiTzNBok9HIKtEFYSahMAluTlEJ1S2ejeeKyn4O8quy8S+8vgsyKAxkasUqXsGR3X6QniM/Rdki35Wj3dnsUbSCWtYQPVtITAZJGiga4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318921; c=relaxed/simple;
	bh=LUD3lsU0uxVo5zVa83HI+1ozLV6yMBvyU2A8+2zNP78=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9RDJiXdV0WBj7BsajoKKvcMUvoRI2tuF6yvI7A6l2FjEYxcfUXKvGP1TRGGkfWnxjyHTMK0SzB+EAEpWZt8kdz1GKsrsz177n7U5IBV9vlb0hA4hyZYdOV/RyrPDQkGy5FcNeMLkIRaEAf2B9SpcJcfUDrLOFeRXCXa0sv2q4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=RnItuCJb; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="RnItuCJb"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4drD4n2kDZz49Py8
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 17:41:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1768318905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kL1SOJ3tNVwpXaIJjZtSfaAFL503e/Vi1gEImOIqMlg=;
	b=RnItuCJbUhywy53vnEAJkuXfsgtysAGzMOhGEWZLtxyk07aJFUfJj1LrJjl63/sRUy1Sh5
	r29IaArZdmH8Tbh74BzJcM3/yRjd0uDYsIBemFMbTyzIDM4H4Q0cNQBD7hCOnN42AeTsHK
	v/g3/DdBVKuG0L2AfPNe0tWEVAog0AiPdU1Vn1WyZAD4b4BFZU2r2/e7MlZJtat3zDWYUD
	GrHFy6AP+x5lmMkOpERB0EBkHYDrSp4rcpBXSJ0Bp/sm6py65R2kUDntzO829mtzjh16Zv
	lLT7dh7usPG/CIaZWYzEgrht8rwRxrcOITb3w4yExYDuUTqL3QwA9kvm/PSO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1768318905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kL1SOJ3tNVwpXaIJjZtSfaAFL503e/Vi1gEImOIqMlg=;
	b=SiMXxhGRVHaqsvLwKYwBvnTeo7ZrKa4aNOcfZt84N9fD2bpDjOVejPOM6eJ4hED8bdj4jL
	A4GSg70eS3t/2K0iblYDQUkBmHiZ4Yg8heTNLCqPcHHTOX7qwWizuZYCLfGd1rmok/f20V
	9XzGtcTnEPG8YHavrpTTrKJvuySXG+YZFUnLk1pZIupmBU7wUeqwIkGcta8LIOV9BfPRtz
	GcwT0ugL2zQGxAmcb7JXOQoCl4qbG9A0Q4PRr4xVDjQ8nMsAAYD8jHQ7xeDHV4usKiSYCM
	tIPqrCTKCNuETVBNtSYGqqJc6KW3Yub9r7/LHLSBZau6fIjuaCcEs+YaVhZBlQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1768318905;
	b=ZcK7frCI5T9nSYIProvBS1cUnQeaer12tdJ46mFa1dV0bazIQMHI2eWHmPAT98mrwEWSSJ
	DXseTJx3UzMWbwpNK+t6bWn7oGi/oB1fIcYpNCBlQx883qZfesTko7KWrpgTaAlLfYT/PY
	YxSBKTtPfC5OONHsX3XtDUZOKY7e15szJSQu/H7huRjaeIf2W2HnK9B46hJENCXi07dmIg
	IRnxIRy40Qt5oaOODI5J686N4x4PUZwV51OKgHTvLtGpQR30mSJPfWV2NyJA/r2e7uJvvY
	y4qDt2jGqTLgNpEsk/jUhokLx/gyXh3Z3a3hWhvn0zomWcuFIiWJMWPTPm/27w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <79d6af641a5ab8a84d7318b45683c25cc297658c.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/2] shared/mcp: emit MCS error if value changes
 during long read
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 13 Jan 2026 17:41:44 +0200
In-Reply-To: <977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
References: 
	<977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2025-12-16 kello 21:46 +0200, Pauli Virtanen kirjoitti:
> MCS spec requires emitting Value Changed During Read Long if value
> changes between remote reading with zero offset and nonzero offset.
>=20
> This is session-specific state, so add support for that.
>=20
> As server, track value changes and emit that error properly.
>=20
> As client, we don't need to reread if this error occurs, as there should
> be a notification or track changed that queues a new read.

Friendly ping on this series, while it's still in Patchwork.

> ---
>  src/shared/mcp.c | 109 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 97 insertions(+), 12 deletions(-)
>=20
> diff --git a/src/shared/mcp.c b/src/shared/mcp.c
> index 910089f18..9f8952af1 100644
> --- a/src/shared/mcp.c
> +++ b/src/shared/mcp.c
> @@ -30,6 +30,8 @@
>  #include "src/shared/mcp.h"
>  #include "src/shared/mcs.h"
> =20
> +#define BT_MCS_ERROR_VALUE_CHANGED_DURING_READ_LONG	0x80
> +
>  #define DBG_MCP(mcp, fmt, ...) \
>  	mcp_debug(mcp, "%s:%s() mcp %p | " fmt, __FILE__, __func__, mcp, \
>  								##__VA_ARGS__)
> @@ -76,22 +78,19 @@ struct bt_mcs_db {
>  	struct gatt_db_attribute *ccid;
>  };
> =20
> -struct bt_mcs_client {
> +struct bt_mcs_session {
> +	struct bt_mcs *mcs;
>  	struct bt_att *att;
> +	unsigned int disconn_id;
> =20
> -	/* Per-client state.
> -	 *
> -	 * Concurrency is not specified in MCS v1.0.1, everything currently
> -	 * implemented seems OK to be in global state.
> -	 *
> -	 * TODO: Search Results ID likely should go here
> -	 */
> +	/* Per-client state */
> +	struct queue *changed;
>  };
> =20
>  struct bt_mcs {
>  	struct gatt_db *db;
>  	struct bt_mcs_db ldb;
> -	struct queue *clients;
> +	struct queue *sessions;
> =20
>  	uint8_t media_state;
> =20
> @@ -557,11 +556,86 @@ static bool set_playing_order(struct bt_mcs *mcs, v=
oid *data)
>  	return false;
>  }
> =20
> +static bool match_session_att(const void *data, const void *match_data)
> +{
> +	const struct bt_mcs_session *session =3D data;
> +
> +	return session->att =3D=3D match_data;
> +}
> +
> +static void session_destroy(void *data)
> +{
> +	struct bt_mcs_session *session =3D data;
> +
> +	bt_att_unregister_disconnect(session->att, session->disconn_id);
> +	queue_destroy(session->changed, NULL);
> +	free(session);
> +}
> +
> +static void session_disconnect(int err, void *user_data)
> +{
> +	struct bt_mcs_session *session =3D user_data;
> +	struct bt_mcs *mcs =3D session->mcs;
> +
> +	queue_remove(mcs->sessions, session);
> +	session_destroy(session);
> +}
> +
> +static struct bt_mcs_session *get_session(struct bt_mcs *mcs,
> +							struct bt_att *att)
> +{
> +	struct bt_mcs_session *session;
> +
> +	session =3D queue_find(mcs->sessions, match_session_att, att);
> +	if (session)
> +		return session;
> +
> +	session =3D new0(struct bt_mcs_session, 1);
> +	session->disconn_id =3D bt_att_register_disconnect(att,
> +					session_disconnect, session, NULL);
> +	if (!session->disconn_id) {
> +		free(session);
> +		return NULL;
> +	}
> +
> +	session->mcs =3D mcs;
> +	session->att =3D att;
> +	session->changed =3D queue_new();
> +
> +	queue_push_tail(mcs->sessions, session);
> +	return session;
> +}
> +
> +static void session_changed(void *data, void *user_data)
> +{
> +	struct bt_mcs_session *session =3D data;
> +	struct gatt_db_attribute *attrib =3D user_data;
> +
> +	if (!queue_find(session->changed, NULL, attrib))
> +		queue_push_tail(session->changed, attrib);
> +}
> +
>  static void read_result(struct bt_mcs *mcs, struct gatt_db_attribute *at=
trib,
> -			unsigned int id, uint16_t offset, mcs_get_func_t get)
> +			unsigned int id, uint16_t offset, struct bt_att *att,
> +			mcs_get_func_t get)
>  {
>  	uint8_t buf[BT_ATT_MAX_VALUE_LEN];
>  	struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D 0 };
> +	struct bt_mcs_session *session =3D get_session(mcs, att);
> +
> +	if (!session) {
> +		gatt_db_attribute_read_result(attrib, id,
> +						BT_ATT_ERROR_UNLIKELY, NULL, 0);
> +		return;
> +	}
> +
> +	if (!offset) {
> +		queue_remove(session->changed, attrib);
> +	} else if (queue_find(session->changed, NULL, attrib)) {
> +		gatt_db_attribute_read_result(attrib, id,
> +			BT_MCS_ERROR_VALUE_CHANGED_DURING_READ_LONG, NULL, 0);
> +		return;
> +	}
> =20
>  	get(mcs, &iov, sizeof(buf));
> =20
> @@ -582,7 +656,7 @@ static void read_result(struct bt_mcs *mcs, struct ga=
tt_db_attribute *attrib,
>  				void *user_data) \
>  	{ \
>  		DBG_MCS(user_data, ""); \
> -		read_result(user_data, attrib, id, offset, get_ ##name); \
> +		read_result(user_data, attrib, id, offset, att, get_ ##name); \
>  	}
> =20
>  READ_FUNC(media_player_name)
> @@ -683,7 +757,9 @@ void bt_mcs_changed(struct bt_mcs *mcs, uint16_t chrc=
_uuid)
>  		if (bt_uuid_cmp(&uuid_attr, &uuid))
>  			continue;
> =20
> -		DBG_MCS(mcs, "Notify %u", chrc_uuid);
> +		queue_foreach(mcs->sessions, session_changed, attrs[i].attr);
> +
> +		DBG_MCS(mcs, "Notify 0x%04x", chrc_uuid);
> =20
>  		attrs[i].get(mcs, &iov, sizeof(buf));
> =20
> @@ -925,6 +1001,7 @@ struct bt_mcs *bt_mcs_register(struct gatt_db *db, b=
ool is_gmcs,
>  	mcs->user_data =3D user_data;
> =20
>  	mcs->media_state =3D BT_MCS_STATE_INACTIVE;
> +	mcs->sessions =3D queue_new();
> =20
>  	if (!mcs_init_db(mcs, is_gmcs)) {
>  		free(mcs);
> @@ -959,6 +1036,8 @@ void bt_mcs_unregister(struct bt_mcs *mcs)
>  		servers =3D NULL;
>  	}
> =20
> +	queue_destroy(mcs->sessions, session_destroy);
> +
>  	free(mcs);
>  }
> =20
> @@ -1367,6 +1446,12 @@ static void update_media_player_name(bool success,=
 uint8_t att_ecode,
>  {
>  	struct bt_mcp_service *service =3D user_data;
> =20
> +	if (!success) {
> +		DBG_SVC(service, "Unable to read Media Player Name: "
> +						"error 0x%02x", att_ecode);
> +		return;
> +	}
> +
>  	DBG_SVC(service, "Media Player Name");
> =20
>  	LISTENER_CB(service, media_player_name, value, length);

--=20
Pauli Virtanen
