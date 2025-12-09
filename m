Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456A328B55
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315570; cv=pass; b=j9HInwq+V6GqGMRRAmBa9UaljR5IqkFip3ghogrFL4HuVv8qFtUqzXUfGpKR+OVAndD9tiN9Z6K4MQ1EB2DB6VKokZxVuLcnzxLaQmRPrqZIqjmjssN4FGo429mpI+KiL/fzNepuCRzya3J3q8YISuN0mBsVXQH8+X/MsQYLp20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315570; c=relaxed/simple;
	bh=vrNRYLOPT2G2gqmgpvtLJJSP6qUnrKoEp3erNaGnjMM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MBA8H4Ds224AABkb5Ra+dI4Y5fzz11ZBc/Fa4cIw+DryVlQOeaMLC07V83okPnUBc9fw9LaSw97Rg+8Dk4PiGT7FKWF3S8BMANmaxH/uHRd/FsRFJBYvyeEXGzOYmLXJP7XSU/sQoOg9b6C5w03/wSfJnSjq1vNdZ+q7+YZWzhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iHhS9WhY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iHhS9WhY"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dQsNC1ch4z49PyZ
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Dec 2025 23:26:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1765315563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tVSZiDq5W4FYmua9ESZzpCfue9V6XESJJIq4RhjBh/4=;
	b=iHhS9WhYmgMS6sOH5zUOifjn1/4eQ6/QpVJGRXyQc0wVRRd7ckxvPNp7EGU4PYkPoUY6cb
	I85UCdc9Ym7di4EoLwNroVI91UdXtLKAotYf2bXT/SwTsaAB2QOLHUg9ww40s3ipOzOl7b
	G/63ccuVaZrCPSTqLtkm2iNnBimP/B30ulqjRzZZjQX/lqGPLEc4Ay40L2vdXNCUKcSsGm
	c+8nUuiFOyXQ3d95ZIkcjYIfQFnyZTTUJ+r1plL3m4R4rZHhfKYe2LCQCCs7w53pSX+rf1
	bsaVnDewLw0iYmrs5nO+ghOqPRtyzaP7EQT7Ho5f4zmWaqk1ds1mNJAlnOq1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1765315563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tVSZiDq5W4FYmua9ESZzpCfue9V6XESJJIq4RhjBh/4=;
	b=eAiblgtXNthVdSf4/TSvCmGvOwSgrFuWus1q0GxGNaAkkSonwoEI25Di9qshTPLxlXM6gS
	E3dgECjRIGohWd8s5rlpLv2Crl64oJbjQhvH+9WzV8TEqNu1+1VeY7mZoxnCFcHn+cAlLy
	eP9XnCFob3OQ9Keam6amPOA/E6NN+AGJ0vqkk2SAN+W9YvEqP8Xx2XngEAFFQJxEzkcSZD
	9Bd/6ydWGwxWN59szj2vnsiC9nOCepZ5C3EiPf7GezYITpfhJdoU8lWqzsqN4uvL7ghi6C
	5LOqwGHlGIfpsFz8hc+pdSA2ljWK27O6/+JrVcfgXSlzuID1ixr0LiCNUzO6xw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1765315563;
	b=ryNCTBKz2exl1aU7OnRQ6xxBCrYUWDx/mg2skzmVMWfjeDaxVkJ7TChcYOMehE1GF+36MO
	la98DPbCjbztyibIKIhHNQqJLGQXrqjTYQuCYvvVkdVz8igTAQ0o2ynoVTFnoUNFlHcvSH
	mnv5clJr0muRYYUYpUsfplHCzym+E16uldq75AQhqbEc5ue3vPJkK8QlvG4WBo2MKOP1U6
	RoqbN/fGBV0zLqr+esZTB680nO2S7ZWBEtikl4moAEc4/isZHrqzNsbh6FJI4onnXmqOyG
	iMEH+BTyJJCqwSFNwSVXEi8iIzS7DWA6xN0LYtnoJYcMF0W8R5SCIiqFlv1JYA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <093c138552df698eed399692731c876580c3cd60.camel@iki.fi>
Subject: Re: [PATCH BlueZ 3/6] mcp: adapt to new MCP API to support multiple
 remote MCS services
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 09 Dec 2025 23:26:01 +0200
In-Reply-To: <d339d8d98eb5276702d8f4d27b85e0d26cecfb07.1765314903.git.pav@iki.fi>
References: <cover.1765314903.git.pav@iki.fi>
	 <d339d8d98eb5276702d8f4d27b85e0d26cecfb07.1765314903.git.pav@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2025-12-09 kello 23:15 +0200, Pauli Virtanen kirjoitti:
> Rewrite to use the new shared/mcp API, adding support for multiple MCS
> services on the remote side.
> ---
>  profiles/audio/mcp.c | 648 +++++++++++++++++++++++++++----------------
>  1 file changed, 408 insertions(+), 240 deletions(-)
>=20
> diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
> index 8d4eed643..6fd0cab11 100644
> --- a/profiles/audio/mcp.c
> +++ b/profiles/audio/mcp.c
> @@ -22,6 +22,7 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <errno.h>
> +#include <math.h>
> =20
>  #include <glib.h>
> =20
> @@ -51,50 +52,55 @@
>  #include "src/service.h"
>  #include "src/log.h"
>  #include "src/error.h"
> +
>  #include "player.h"
> +#include "uinput-util.h"

This header should have been added in the later commit

-> v2

> =20
> -#define GMCS_UUID_STR "00001849-0000-1000-8000-00805f9b34fb"
> +#define MCS_UUID_STR	"00001848-0000-1000-8000-00805f9b34fb"
> +#define GMCS_UUID_STR	"00001849-0000-1000-8000-00805f9b34fb"
> =20
> -struct mcp_data {
> -	struct btd_device *device;
> -	struct btd_service *service;
> +
> +/*
> + * Remote player
> + */
> +
> +struct remote_player {
>  	struct bt_mcp *mcp;
> -	unsigned int state_id;
> -
> +	uint8_t ccid;
>  	struct media_player *mp;
> +	uint8_t playing_order;
>  };
> =20
> -static void mcp_debug(const char *str, void *user_data)
> -{
> -	DBG_IDX(0xffff, "%s", str);
> -}
> -
>  static char *name2utf8(const uint8_t *name, uint16_t len)
>  {
> -	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
> +	char *utf8_name;
> =20
> -	len =3D MIN(len, sizeof(utf8_name) - 1);
> +	utf8_name =3D malloc(len + 1);
> +	if (!utf8_name)
> +		return NULL;
> =20
> -	memset(utf8_name, 0, sizeof(utf8_name));
> -	strncpy(utf8_name, (char *) name, len);
> +	if (len)
> +		memcpy(utf8_name, name, len);
> +
> +	utf8_name[len] =3D 0;
>  	strtoutf8(utf8_name, len);
> =20
>  	/* Remove leading and trailing whitespace characters */
>  	g_strstrip(utf8_name);
> =20
> -	return g_strdup(utf8_name);
> +	return utf8_name;
>  }
> =20
>  static const char *mcp_status_val_to_string(uint8_t status)
>  {
>  	switch (status) {
> -	case BT_MCS_STATUS_PLAYING:
> +	case BT_MCS_STATE_PLAYING:
>  		return "playing";
> -	case BT_MCS_STATUS_PAUSED:
> +	case BT_MCS_STATE_PAUSED:
>  		return "paused";
> -	case BT_MCS_STATUS_INACTIVE:
> +	case BT_MCS_STATE_INACTIVE:
>  		return "stopped";
> -	case BT_MCS_STATUS_SEEKING:
> +	case BT_MCS_STATE_SEEKING:
>  		/* TODO: find a way for fwd/rvs seeking, probably by storing
>  		 * control point operation sent before
>  		 */
> @@ -104,307 +110,469 @@ static const char *mcp_status_val_to_string(uint8=
_t status)
>  	}
>  }
> =20
> -static struct mcp_data *mcp_data_new(struct btd_device *device)
> -{
> -	struct mcp_data *data;
> -
> -	data =3D new0(struct mcp_data, 1);
> -	data->device =3D device;
> -
> -	return data;
> -}
> -
> -static void cb_player_name(struct bt_mcp *mcp,  const uint8_t *value,
> -					uint16_t length)
> +static void remote_media_player_name(void *data, const uint8_t *value,
> +								uint16_t length)
>  {
> +	struct remote_player *remote =3D data;
>  	char *name;
> -	struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> =20
>  	name =3D name2utf8(value, length);
> +	if (!name)
> +		return;
> +
>  	DBG("Media Player Name %s", (const char *)name);
> =20
> -	media_player_set_name(mp, name);
> +	media_player_set_name(remote->mp, name);
> =20
> -	g_free(name);
> +	free(name);
>  }
> =20
> -static void cb_track_changed(struct bt_mcp *mcp)
> +static void remote_track_changed(void *data)
>  {
> +	struct remote_player *remote =3D data;
> +
>  	DBG("Track Changed");
> -	/* Since track changed has happened
> -	 * track title notification is expected
> -	 */
> +
> +	media_player_metadata_changed(remote->mp);
>  }
> =20
> -static void cb_track_title(struct bt_mcp *mcp, const uint8_t *value,
> -					uint16_t length)
> +static void remote_track_title(void *data, const uint8_t *value,
> +								uint16_t length)
>  {
> +	struct remote_player *remote =3D data;
>  	char *name;
>  	uint16_t len;
> -	struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> =20
>  	name =3D name2utf8(value, length);
> +	if (!name)
> +		return;
> +
>  	len =3D strlen(name);
> =20
>  	DBG("Track Title %s", (const char *)name);
> =20
> -	media_player_set_metadata(mp, NULL, "Title", name, len);
> -	media_player_metadata_changed(mp);
> +	media_player_set_metadata(remote->mp, NULL, "Title", name, len);
> +	media_player_metadata_changed(remote->mp);
> =20
>  	g_free(name);
>  }
> =20
> -static void cb_track_duration(struct bt_mcp *mcp, int32_t duration)
> +static void remote_track_duration(void *data, int32_t duration_centisec)
>  {
> -	struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> -	unsigned char buf[10];
> +	struct remote_player *remote =3D data;
> =20
> -	/* MCP defines duration is int32 but api takes it as uint32 */
> -	snprintf((char *)buf, 10, "%d", duration);
> -	media_player_set_metadata(mp, NULL, "Duration", buf, sizeof(buf));
> -	media_player_metadata_changed(mp);
> -}
> -
> -static void cb_track_position(struct bt_mcp *mcp, int32_t duration)
> -{
> -	struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> -
> -	/* MCP defines duration is int32 but api takes it as uint32 */
> -	media_player_set_position(mp, duration);
> -}
> -
> -static void cb_media_state(struct bt_mcp *mcp, uint8_t status)
> -{
> -	struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> -
> -	media_player_set_status(mp, mcp_status_val_to_string(status));
> -}
> -
> -static const struct bt_mcp_event_callback cbs =3D {
> -	.player_name			=3D cb_player_name,
> -	.track_changed			=3D cb_track_changed,
> -	.track_title			=3D cb_track_title,
> -	.track_duration			=3D cb_track_duration,
> -	.track_position			=3D cb_track_position,
> -	.media_state			=3D cb_media_state,
> -};
> -
> -static int ct_play(struct media_player *mp, void *user_data)
> -{
> -	struct bt_mcp *mcp =3D user_data;
> -
> -	return bt_mcp_play(mcp);
> -}
> -
> -static int ct_pause(struct media_player *mp, void *user_data)
> -{
> -	struct bt_mcp *mcp =3D user_data;
> -
> -	return bt_mcp_pause(mcp);
> -}
> -
> -static int ct_stop(struct media_player *mp, void *user_data)
> -{
> -	struct bt_mcp *mcp =3D user_data;
> -
> -	return bt_mcp_stop(mcp);
> -}
> -
> -static int ct_next(struct media_player *mp, void *user_data)
> -{
> -	struct bt_mcp *mcp =3D user_data;
> -
> -	return bt_mcp_next_track(mcp);
> -}
> -
> -static int ct_previous(struct media_player *mp, void *user_data)
> -{
> -	struct bt_mcp *mcp =3D user_data;
> -
> -	return bt_mcp_previous_track(mcp);
> -}
> -
> -static const struct media_player_callback ct_cbs =3D {
> -	.play		=3D ct_play,
> -	.pause		=3D ct_pause,
> -	.stop		=3D ct_stop,
> -	.next		=3D ct_next,
> -	.previous	=3D ct_previous,
> -};
> -
> -static int mcp_probe(struct btd_service *service)
> -{
> -	struct btd_device *device =3D btd_service_get_device(service);
> -	struct btd_adapter *adapter =3D device_get_adapter(device);
> -	struct btd_gatt_database *database =3D btd_adapter_get_database(adapter=
);
> -	struct mcp_data *data =3D btd_service_get_user_data(service);
> -	char addr[18];
> -
> -	ba2str(device_get_address(device), addr);
> -	DBG("%s", addr);
> -
> -	/* Ignore, if we were probed for this device already */
> -	if (data) {
> -		error("Profile probed twice for the same device!");
> -		return -EINVAL;
> -	}
> -
> -	data =3D mcp_data_new(device);
> -	data->service =3D service;
> -
> -	data->mcp =3D bt_mcp_new(btd_gatt_database_get_db(database),
> -					btd_device_get_gatt_db(device));
> -
> -	bt_mcp_set_debug(data->mcp, mcp_debug, NULL, NULL);
> -	btd_service_set_user_data(service, data);
> -
> -	return 0;
> -}
> -
> -static void mcp_data_free(struct mcp_data *data)
> -{
> -	DBG("");
> -
> -	if (data->service) {
> -		btd_service_set_user_data(data->service, NULL);
> -		bt_mcp_set_user_data(data->mcp, NULL);
> -	}
> -
> -	if (data->mp) {
> -		media_player_destroy(data->mp);
> -		data->mp =3D NULL;
> -	}
> -
> -	bt_mcp_unref(data->mcp);
> -	free(data);
> -}
> -
> -static void mcp_data_remove(struct mcp_data *data)
> -{
> -	DBG("data %p", data);
> -
> -	mcp_data_free(data);
> -}
> -
> -static void mcp_remove(struct btd_service *service)
> -{
> -	struct btd_device *device =3D btd_service_get_device(service);
> -	struct mcp_data *data;
> -	char addr[18];
> -
> -	ba2str(device_get_address(device), addr);
> -	DBG("%s", addr);
> -
> -	data =3D btd_service_get_user_data(service);
> -	if (!data) {
> -		error("MCP service not handled by profile");
> +	if (duration_centisec =3D=3D BT_MCS_POSITION_UNAVAILABLE) {
> +		media_player_set_duration(remote->mp, 0);
>  		return;
>  	}
> =20
> -	mcp_data_remove(data);
> +	if (duration_centisec < 0)
> +		duration_centisec =3D 0;
> +
> +	media_player_set_duration(remote->mp, duration_centisec * 10);
> +}
> +
> +static void remote_track_position(void *data, int32_t position_centisec)
> +{
> +	struct remote_player *remote =3D data;
> +
> +	if (position_centisec =3D=3D BT_MCS_POSITION_UNAVAILABLE) {
> +		media_player_set_position(remote->mp, 0);
> +		return;
> +	}
> +
> +	if (position_centisec < 0)
> +		position_centisec =3D 0;
> +
> +	media_player_set_position(remote->mp, position_centisec * 10);
> +}
> +
> +static void remote_playback_speed(void *data, int8_t value)
> +{
> +	/* TODO */
> +}
> +
> +static void remote_seeking_speed(void *data, int8_t speed)
> +{
> +	/* TODO */
> +}
> +
> +static const struct {
> +	uint16_t basic;
> +	uint16_t repeat;
> +	bool shuffle;
> +	bool single;
> +} playing_orders[] =3D {
> +	{ BT_MCS_ORDER_SINGLE_ONCE, BT_MCS_ORDER_SINGLE_REPEAT,
> +	  .single =3D true },
> +	{ BT_MCS_ORDER_IN_ORDER_ONCE, BT_MCS_ORDER_IN_ORDER_REPEAT },
> +	{ BT_MCS_ORDER_OLDEST_ONCE, BT_MCS_ORDER_OLDEST_REPEAT },
> +	{ BT_MCS_ORDER_NEWEST_ONCE, BT_MCS_ORDER_NEWEST_REPEAT },
> +	{ BT_MCS_ORDER_SHUFFLE_ONCE, BT_MCS_ORDER_SHUFFLE_REPEAT,
> +	  .shuffle =3D true },
> +};
> +
> +static void remote_playing_order(void *data, uint8_t order)
> +{
> +	struct remote_player *remote =3D data;
> +	const char *repeat =3D "off";
> +	unsigned int i;
> +	bool shuffle;
> +
> +	remote->playing_order =3D order;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(playing_orders); ++i) {
> +		shuffle =3D playing_orders[i].shuffle;
> +		if (order =3D=3D playing_orders[i].basic) {
> +			break;
> +		} else if (order =3D=3D playing_orders[i].repeat) {
> +			repeat =3D playing_orders[i].single ? "singletrack" :
> +				"alltracks";
> +			break;
> +		}
> +	}
> +	if (i =3D=3D ARRAY_SIZE(playing_orders))
> +		return;
> +
> +	media_player_set_setting(remote->mp, "Repeat", repeat);
> +	media_player_set_setting(remote->mp, "Shuffle", shuffle ? "on" : "off")=
;
> +}
> +
> +static void remote_media_state(void *data, uint8_t status)
> +{
> +	struct remote_player *remote =3D data;
> +
> +	media_player_set_status(remote->mp, mcp_status_val_to_string(status));
> +}
> +
> +static void remote_destroy(void *data)
> +{
> +	struct remote_player *remote =3D data;
> +
> +	media_player_destroy(remote->mp);
> +	free(data);
> +}
> +
> +static const struct bt_mcp_listener_callback remote_cb =3D {
> +	.media_player_name =3D remote_media_player_name,
> +	.track_changed =3D remote_track_changed,
> +	.track_title =3D remote_track_title,
> +	.track_duration =3D remote_track_duration,
> +	.track_position =3D remote_track_position,
> +	.playback_speed =3D remote_playback_speed,
> +	.seeking_speed =3D remote_seeking_speed,
> +	.playing_order =3D remote_playing_order,
> +	.media_state =3D remote_media_state,
> +	.destroy =3D remote_destroy,
> +};
> +
> +static int remote_mp_play(struct media_player *mp, void *user_data)
> +{
> +	struct remote_player *remote =3D user_data;
> +
> +	return bt_mcp_play(remote->mcp, remote->ccid);
> +}
> +
> +static int remote_mp_pause(struct media_player *mp, void *user_data)
> +{
> +	struct remote_player *remote =3D user_data;
> +
> +	return bt_mcp_pause(remote->mcp, remote->ccid);
> +}
> +
> +static int remote_mp_stop(struct media_player *mp, void *user_data)
> +{
> +	struct remote_player *remote =3D user_data;
> +
> +	return bt_mcp_stop(remote->mcp, remote->ccid);
> +}
> +
> +static int remote_mp_next(struct media_player *mp, void *user_data)
> +{
> +	struct remote_player *remote =3D user_data;
> +
> +	return bt_mcp_next_track(remote->mcp, remote->ccid);
> +}
> +
> +static int remote_mp_previous(struct media_player *mp, void *user_data)
> +{
> +	struct remote_player *remote =3D user_data;
> +
> +	return bt_mcp_previous_track(remote->mcp, remote->ccid);
> +}
> +
> +static bool remote_mp_set_setting(struct media_player *mp, const char *k=
ey,
> +					const char *value, void *user_data)
> +{
> +	struct remote_player *remote =3D user_data;
> +	unsigned int i;
> +
> +	if (strcmp(key, "Repeat") =3D=3D 0) {
> +		bool repeat =3D (strcmp(value, "alltracks") =3D=3D 0);
> +		uint8_t order =3D remote->playing_order;
> +
> +		/* Some sensible mapping, 1-to-1 not possible */
> +		for (i =3D 0; i < ARRAY_SIZE(playing_orders); ++i) {
> +			if (order =3D=3D playing_orders[i].basic) {
> +				if (repeat)
> +					order =3D playing_orders[i].repeat;
> +				break;
> +			} else if (order =3D=3D playing_orders[i].repeat) {
> +				if (!repeat)
> +					order =3D playing_orders[i].basic;
> +				break;
> +			}
> +		}
> +
> +		if (strcmp(value, "singletrack") =3D=3D 0)
> +			order =3D BT_MCS_ORDER_SINGLE_REPEAT;
> +
> +		DBG("Set Repeat %s -> 0x%02x", value, order);
> +
> +		if (order =3D=3D remote->playing_order)
> +			return true;
> +		return bt_mcp_set_playing_order(remote->mcp, remote->ccid,
> +									order);
> +	}
> +
> +	if (strcmp(key, "Shuffle") =3D=3D 0) {
> +		bool shuffle =3D (strcmp(value, "off") !=3D 0);
> +		uint8_t order =3D remote->playing_order;
> +
> +		/* Some sensible mapping, 1-to-1 not possible */
> +		switch (order) {
> +		case BT_MCS_ORDER_SHUFFLE_ONCE:
> +			if (!shuffle)
> +				order =3D BT_MCS_ORDER_IN_ORDER_ONCE;
> +			break;
> +		case BT_MCS_ORDER_SHUFFLE_REPEAT:
> +			if (!shuffle)
> +				order =3D BT_MCS_ORDER_IN_ORDER_REPEAT;
> +			break;
> +		case BT_MCS_ORDER_SINGLE_ONCE:
> +		case BT_MCS_ORDER_IN_ORDER_ONCE:
> +		case BT_MCS_ORDER_OLDEST_ONCE:
> +		case BT_MCS_ORDER_NEWEST_ONCE:
> +			if (shuffle)
> +				order =3D BT_MCS_ORDER_SHUFFLE_ONCE;
> +			break;
> +		case BT_MCS_ORDER_SINGLE_REPEAT:
> +		case BT_MCS_ORDER_IN_ORDER_REPEAT:
> +		case BT_MCS_ORDER_OLDEST_REPEAT:
> +		case BT_MCS_ORDER_NEWEST_REPEAT:
> +			if (shuffle)
> +				order =3D BT_MCS_ORDER_SHUFFLE_REPEAT;
> +			break;
> +		}
> +
> +		DBG("Set Shuffle %s -> 0x%02x", value, order);
> +
> +		if (order =3D=3D remote->playing_order)
> +			return true;
> +		return bt_mcp_set_playing_order(remote->mcp, remote->ccid,
> +									order);
> +	}
> +
> +	return false;
> +}
> +
> +static const struct media_player_callback remote_mp_cb =3D {
> +	.play		=3D remote_mp_play,
> +	.pause		=3D remote_mp_pause,
> +	.stop		=3D remote_mp_stop,
> +	.next		=3D remote_mp_next,
> +	.previous	=3D remote_mp_previous,
> +	.set_setting	=3D remote_mp_set_setting,
> +};
> +
> +static void mcp_ccid(void *data, uint8_t ccid, bool gmcs)
> +{
> +	struct btd_service *service =3D data;
> +	struct btd_device *device =3D btd_service_get_device(service);
> +	struct bt_mcp *mcp =3D btd_service_get_user_data(service);
> +	struct remote_player *remote;
> +	struct media_player *mp;
> +
> +	mp =3D media_player_controller_create(device_get_path(device),
> +					gmcs ? "mcp_gmcs" : "mcp_mcs", ccid);
> +	if (!mp) {
> +		DBG("Unable to create Media Player");
> +		return;
> +	}
> +
> +	remote =3D new0(struct remote_player, 1);
> +	remote->mcp =3D mcp;
> +	remote->ccid =3D ccid;
> +	remote->mp =3D mp;
> +
> +	media_player_set_callbacks(remote->mp, &remote_mp_cb, remote);
> +
> +	if (!bt_mcp_add_listener(mcp, ccid, &remote_cb, remote)) {
> +		DBG("Unable to register Media Player with MCP");
> +		media_player_destroy(mp);
> +		free(remote);
> +		return;
> +	}
> +}
> +
> +static void mcp_debug(void *data, const char *str)
> +{
> +	DBG_IDX(0xffff, "%s", str);
> +}
> +
> +static void mcp_ready(void *data)
> +{
> +	struct btd_service *service =3D data;
> +
> +	btd_service_connecting_complete(service, 0);
> +}
> +
> +static const struct bt_mcp_callback mcp_cb =3D {
> +	.ccid =3D mcp_ccid,
> +	.debug =3D mcp_debug,
> +	.ready =3D mcp_ready,
> +};
> +
> +
> +/*
> + * Profile
> + */
> +
> +static struct btd_profile mcp_gmcs_profile;
> +
> +static int add_service(struct btd_service *service)
> +{
> +	struct btd_device *device =3D btd_service_get_device(service);
> +	struct bt_gatt_client *client =3D btd_device_get_gatt_client(device);
> +	struct bt_mcp *mcp =3D btd_service_get_user_data(service);
> +	bool gmcs;
> +
> +	if (mcp)
> +		return -EALREADY;
> +
> +	gmcs =3D btd_service_get_profile(service) =3D=3D &mcp_gmcs_profile;
> +
> +	mcp =3D bt_mcp_attach(client, gmcs, &mcp_cb, service);
> +	if (!mcp) {
> +		DBG("Unable to attach MCP");
> +		return -EINVAL;
> +	}
> +
> +	btd_service_set_user_data(service, mcp);
> +	return 0;
> +}
> +
> +static void remove_service(struct btd_service *service)
> +{
> +	struct bt_mcp *mcp =3D btd_service_get_user_data(service);
> +
> +	btd_service_set_user_data(service, NULL);
> +	bt_mcp_detach(mcp);
>  }
> =20
>  static int mcp_accept(struct btd_service *service)
>  {
>  	struct btd_device *device =3D btd_service_get_device(service);
> -	struct bt_gatt_client *client =3D btd_device_get_gatt_client(device);
> -	struct mcp_data *data =3D btd_service_get_user_data(service);
>  	char addr[18];
> =20
>  	ba2str(device_get_address(device), addr);
>  	DBG("%s", addr);
> =20
> -	bt_mcp_attach(data->mcp, client);
> -
> -	data->mp =3D media_player_controller_create(device_get_path(device),
> -							"mcp", 0);
> -	if (data->mp =3D=3D NULL) {
> -		DBG("Unable to create Media Player");
> -		return -EINVAL;
> -	}
> -
> -	media_player_set_callbacks(data->mp, &ct_cbs, data->mcp);
> -
> -	bt_mcp_set_user_data(data->mcp, data->mp);
> -	bt_mcp_set_event_callbacks(data->mcp, &cbs, data->mp);
> -	btd_service_connecting_complete(service, 0);
> -
> -	return 0;
> +	return add_service(service);
>  }
> =20
>  static int mcp_connect(struct btd_service *service)
>  {
> -	struct btd_device *device =3D btd_service_get_device(service);
> -	char addr[18];
> -
> -	ba2str(device_get_address(device), addr);
> -	DBG("%s", addr);
> -
>  	return 0;
>  }
> =20
>  static int mcp_disconnect(struct btd_service *service)
>  {
>  	struct btd_device *device =3D btd_service_get_device(service);
> -	struct mcp_data *data =3D btd_service_get_user_data(service);
>  	char addr[18];
> =20
>  	ba2str(device_get_address(device), addr);
>  	DBG("%s", addr);
> =20
> -	if (data->mp) {
> -		media_player_destroy(data->mp);
> -		data->mp =3D NULL;
> -	}
> -
> -	bt_mcp_detach(data->mcp);
> -
> +	remove_service(service);
>  	btd_service_disconnecting_complete(service, 0);
> -
>  	return 0;
>  }
> =20
> -static int media_control_server_probe(struct btd_profile *p,
> -						struct btd_adapter *adapter)
> +static int mcp_probe(struct btd_service *service)
>  {
> -	struct btd_gatt_database *database =3D btd_adapter_get_database(adapter=
);
> -
> -	bt_mcp_register(btd_gatt_database_get_db(database));
> -
>  	return 0;
>  }
> =20
> -static void media_control_server_remove(struct btd_profile *p,
> -						struct btd_adapter *adapter)
> +static void mcp_remove(struct btd_service *service)
>  {
> -
> +	remove_service(service);
>  }
> =20
> -static struct btd_profile mcp_profile =3D {
> -	.name			=3D "mcp",
> +static int gmcs_probe(struct btd_profile *p, struct btd_adapter *adapter=
)
> +{
> +	return 0;
> +}
> +
> +static void gmcs_remove(struct btd_profile *p, struct btd_adapter *adapt=
er)
> +{
> +}
> +
> +static struct btd_profile mcp_gmcs_profile =3D {
> +	.name			=3D "mcp-gmcs",
>  	.priority		=3D BTD_PROFILE_PRIORITY_MEDIUM,
> -	.bearer		=3D BTD_PROFILE_BEARER_LE,
> -	.remote_uuid	=3D GMCS_UUID_STR,
> -	.device_probe	=3D mcp_probe,
> -	.device_remove	=3D mcp_remove,
> +	.bearer			=3D BTD_PROFILE_BEARER_LE,
> +	.remote_uuid		=3D GMCS_UUID_STR,
> +	.device_probe		=3D mcp_probe,
> +	.device_remove		=3D mcp_remove,
>  	.accept			=3D mcp_accept,
>  	.connect		=3D mcp_connect,
>  	.disconnect		=3D mcp_disconnect,
> =20
> -	.adapter_probe	=3D media_control_server_probe,
> -	.adapter_remove =3D media_control_server_remove,
> +	.adapter_probe		=3D gmcs_probe,
> +	.adapter_remove		=3D gmcs_remove,
> =20
> -	.experimental	=3D true,
> +	.experimental =3D true,
> +};
> +
> +static struct btd_profile mcp_mcs_profile =3D {
> +	.name			=3D "mcp-mcs",
> +	.priority		=3D BTD_PROFILE_PRIORITY_MEDIUM,
> +	.bearer			=3D BTD_PROFILE_BEARER_LE,
> +	.remote_uuid		=3D MCS_UUID_STR,
> +	.device_probe		=3D mcp_probe,
> +	.device_remove		=3D mcp_remove,
> +	.accept			=3D mcp_accept,
> +	.connect		=3D mcp_connect,
> +	.disconnect		=3D mcp_disconnect,
> +
> +	.adapter_probe		=3D NULL,
> +	.adapter_remove		=3D NULL,
> +
> +	.experimental =3D true,
>  };
> =20
>  static int mcp_init(void)
>  {
> -	return btd_profile_register(&mcp_profile);
> +	int err;
> +
> +	err =3D btd_profile_register(&mcp_gmcs_profile);
> +	if (err)
> +		return err;
> +
> +	err =3D btd_profile_register(&mcp_mcs_profile);
> +	if (err) {
> +		btd_profile_unregister(&mcp_gmcs_profile);
> +		return err;
> +	}
> +
> +	return err;
>  }
> =20
>  static void mcp_exit(void)
>  {
> -	btd_profile_unregister(&mcp_profile);
> +	btd_profile_unregister(&mcp_gmcs_profile);
> +	btd_profile_unregister(&mcp_mcs_profile);
>  }
> =20
>  BLUETOOTH_PLUGIN_DEFINE(mcp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
