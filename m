Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B123EA95
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381464; cv=pass; b=BscB+qbaN4OBpfadPL8s66dib0VlIrL1pwfu+Oyt8g2+OqJLThHv51fFFVnwRcD0DgL4KwKwhDzK5F2bOTF0+r2DCeMYT+uKzBo/bjZvglXLaep6x7Y7MOVgEWTbAIMFL9i/LU5fnvj21doGasBufKi2jaCu3gjFYIZeU+JhHJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381464; c=relaxed/simple;
	bh=FpaFBI/WfxUfiS/FXJf6n/chY3dyzTndzTEXrO22yLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiReyXwbTVpIRkQq4/4Jk8JE2dAX+0UnsNqgwpLqU9NAysfxYWoi5yhzw0ljcj8+bI2pLV02S/w3FeK2TyOmLXTBG+OFbQMtNO0ib62gKXpF8o8mYf1nOWMn56jiKV1216utq/Ehiq+k4nRVY5amHNq+5AnV/kX3QIhxPVjL0yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ks/bF8Hx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ks/bF8Hx"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRKlQ5vJXz105k;
	Wed, 10 Dec 2025 17:44:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765381459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UBhGUITJQXukRm/Vg/GM1W71HJAuZHSyEvm0mye37w=;
	b=Ks/bF8Hx06Z1TIxGTgZnVI+RUpTC1FifDBHVVDZ5P3dFchIQ1+rIvCgsl5CUQsCuykKiKi
	yYlpMBLCx8r9V+e/4CBlNU1OMGKN97kHmjW4AhAeeBLYrR88qLit7HIJhCakRjGsrQ7zhn
	FLjQVqB1jtVwBeOqFtJWHyjWiHZvt3w=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765381459;
	b=WJrd2USfqDRjkGIi8FaJU8ighJ8wZiYXFcQSOlS3Ft4tBHGiUS/DjRW71/uR97sVzMxRqK
	KaOHF3XuqU5QHf/lZz14pvQSm1Q79foHuHXwy6AqlxeT0Rv9dXFPbRFfgTNK27KiPLcuqQ
	dKD9TY9mdXNoPcvbQ8DubQ0a1RStcKw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765381459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UBhGUITJQXukRm/Vg/GM1W71HJAuZHSyEvm0mye37w=;
	b=xh8KM/u5zu7K+fdoPFkytEWO4TGq5/44bRvuXPvqvuJ4cJ/GebLjCqT1te/0YAtoqW0hrW
	wDneTPHsxK9OCcMngZ45B0xGozr5U8of7KRUuBYfBHbGzNkqyDd0VyaBE+kVGVILetg5lC
	5SOxxIXREfqQfhomm7VJrrRi9aA42y4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 3/7] mcp: adapt to new MCP API to support multiple remote MCS services
Date: Wed, 10 Dec 2025 17:44:08 +0200
Message-ID: <d1193c2026933eb7d131a43a1f92d10f87b7f23f.1765381438.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765381438.git.pav@iki.fi>
References: <cover.1765381438.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite to use the new shared/mcp API, adding support for multiple MCS
services on the remote side.
---
 profiles/audio/mcp.c | 647 +++++++++++++++++++++++++++----------------
 1 file changed, 407 insertions(+), 240 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 8d4eed643..e64cbd01d 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -22,6 +22,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <math.h>
 
 #include <glib.h>
 
@@ -51,50 +52,54 @@
 #include "src/service.h"
 #include "src/log.h"
 #include "src/error.h"
+
 #include "player.h"
 
-#define GMCS_UUID_STR "00001849-0000-1000-8000-00805f9b34fb"
+#define MCS_UUID_STR	"00001848-0000-1000-8000-00805f9b34fb"
+#define GMCS_UUID_STR	"00001849-0000-1000-8000-00805f9b34fb"
 
-struct mcp_data {
-	struct btd_device *device;
-	struct btd_service *service;
+
+/*
+ * Remote player
+ */
+
+struct remote_player {
 	struct bt_mcp *mcp;
-	unsigned int state_id;
-
+	uint8_t ccid;
 	struct media_player *mp;
+	uint8_t playing_order;
 };
 
-static void mcp_debug(const char *str, void *user_data)
-{
-	DBG_IDX(0xffff, "%s", str);
-}
-
 static char *name2utf8(const uint8_t *name, uint16_t len)
 {
-	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
+	char *utf8_name;
 
-	len = MIN(len, sizeof(utf8_name) - 1);
+	utf8_name = malloc(len + 1);
+	if (!utf8_name)
+		return NULL;
 
-	memset(utf8_name, 0, sizeof(utf8_name));
-	strncpy(utf8_name, (char *) name, len);
+	if (len)
+		memcpy(utf8_name, name, len);
+
+	utf8_name[len] = 0;
 	strtoutf8(utf8_name, len);
 
 	/* Remove leading and trailing whitespace characters */
 	g_strstrip(utf8_name);
 
-	return g_strdup(utf8_name);
+	return utf8_name;
 }
 
 static const char *mcp_status_val_to_string(uint8_t status)
 {
 	switch (status) {
-	case BT_MCS_STATUS_PLAYING:
+	case BT_MCS_STATE_PLAYING:
 		return "playing";
-	case BT_MCS_STATUS_PAUSED:
+	case BT_MCS_STATE_PAUSED:
 		return "paused";
-	case BT_MCS_STATUS_INACTIVE:
+	case BT_MCS_STATE_INACTIVE:
 		return "stopped";
-	case BT_MCS_STATUS_SEEKING:
+	case BT_MCS_STATE_SEEKING:
 		/* TODO: find a way for fwd/rvs seeking, probably by storing
 		 * control point operation sent before
 		 */
@@ -104,307 +109,469 @@ static const char *mcp_status_val_to_string(uint8_t status)
 	}
 }
 
-static struct mcp_data *mcp_data_new(struct btd_device *device)
-{
-	struct mcp_data *data;
-
-	data = new0(struct mcp_data, 1);
-	data->device = device;
-
-	return data;
-}
-
-static void cb_player_name(struct bt_mcp *mcp,  const uint8_t *value,
-					uint16_t length)
+static void remote_media_player_name(void *data, const uint8_t *value,
+								uint16_t length)
 {
+	struct remote_player *remote = data;
 	char *name;
-	struct media_player *mp = bt_mcp_get_user_data(mcp);
 
 	name = name2utf8(value, length);
+	if (!name)
+		return;
+
 	DBG("Media Player Name %s", (const char *)name);
 
-	media_player_set_name(mp, name);
+	media_player_set_name(remote->mp, name);
 
-	g_free(name);
+	free(name);
 }
 
-static void cb_track_changed(struct bt_mcp *mcp)
+static void remote_track_changed(void *data)
 {
+	struct remote_player *remote = data;
+
 	DBG("Track Changed");
-	/* Since track changed has happened
-	 * track title notification is expected
-	 */
+
+	media_player_metadata_changed(remote->mp);
 }
 
-static void cb_track_title(struct bt_mcp *mcp, const uint8_t *value,
-					uint16_t length)
+static void remote_track_title(void *data, const uint8_t *value,
+								uint16_t length)
 {
+	struct remote_player *remote = data;
 	char *name;
 	uint16_t len;
-	struct media_player *mp = bt_mcp_get_user_data(mcp);
 
 	name = name2utf8(value, length);
+	if (!name)
+		return;
+
 	len = strlen(name);
 
 	DBG("Track Title %s", (const char *)name);
 
-	media_player_set_metadata(mp, NULL, "Title", name, len);
-	media_player_metadata_changed(mp);
+	media_player_set_metadata(remote->mp, NULL, "Title", name, len);
+	media_player_metadata_changed(remote->mp);
 
 	g_free(name);
 }
 
-static void cb_track_duration(struct bt_mcp *mcp, int32_t duration)
+static void remote_track_duration(void *data, int32_t duration_centisec)
 {
-	struct media_player *mp = bt_mcp_get_user_data(mcp);
-	unsigned char buf[10];
+	struct remote_player *remote = data;
 
-	/* MCP defines duration is int32 but api takes it as uint32 */
-	snprintf((char *)buf, 10, "%d", duration);
-	media_player_set_metadata(mp, NULL, "Duration", buf, sizeof(buf));
-	media_player_metadata_changed(mp);
-}
-
-static void cb_track_position(struct bt_mcp *mcp, int32_t duration)
-{
-	struct media_player *mp = bt_mcp_get_user_data(mcp);
-
-	/* MCP defines duration is int32 but api takes it as uint32 */
-	media_player_set_position(mp, duration);
-}
-
-static void cb_media_state(struct bt_mcp *mcp, uint8_t status)
-{
-	struct media_player *mp = bt_mcp_get_user_data(mcp);
-
-	media_player_set_status(mp, mcp_status_val_to_string(status));
-}
-
-static const struct bt_mcp_event_callback cbs = {
-	.player_name			= cb_player_name,
-	.track_changed			= cb_track_changed,
-	.track_title			= cb_track_title,
-	.track_duration			= cb_track_duration,
-	.track_position			= cb_track_position,
-	.media_state			= cb_media_state,
-};
-
-static int ct_play(struct media_player *mp, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	return bt_mcp_play(mcp);
-}
-
-static int ct_pause(struct media_player *mp, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	return bt_mcp_pause(mcp);
-}
-
-static int ct_stop(struct media_player *mp, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	return bt_mcp_stop(mcp);
-}
-
-static int ct_next(struct media_player *mp, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	return bt_mcp_next_track(mcp);
-}
-
-static int ct_previous(struct media_player *mp, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	return bt_mcp_previous_track(mcp);
-}
-
-static const struct media_player_callback ct_cbs = {
-	.play		= ct_play,
-	.pause		= ct_pause,
-	.stop		= ct_stop,
-	.next		= ct_next,
-	.previous	= ct_previous,
-};
-
-static int mcp_probe(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	struct btd_adapter *adapter = device_get_adapter(device);
-	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
-	struct mcp_data *data = btd_service_get_user_data(service);
-	char addr[18];
-
-	ba2str(device_get_address(device), addr);
-	DBG("%s", addr);
-
-	/* Ignore, if we were probed for this device already */
-	if (data) {
-		error("Profile probed twice for the same device!");
-		return -EINVAL;
-	}
-
-	data = mcp_data_new(device);
-	data->service = service;
-
-	data->mcp = bt_mcp_new(btd_gatt_database_get_db(database),
-					btd_device_get_gatt_db(device));
-
-	bt_mcp_set_debug(data->mcp, mcp_debug, NULL, NULL);
-	btd_service_set_user_data(service, data);
-
-	return 0;
-}
-
-static void mcp_data_free(struct mcp_data *data)
-{
-	DBG("");
-
-	if (data->service) {
-		btd_service_set_user_data(data->service, NULL);
-		bt_mcp_set_user_data(data->mcp, NULL);
-	}
-
-	if (data->mp) {
-		media_player_destroy(data->mp);
-		data->mp = NULL;
-	}
-
-	bt_mcp_unref(data->mcp);
-	free(data);
-}
-
-static void mcp_data_remove(struct mcp_data *data)
-{
-	DBG("data %p", data);
-
-	mcp_data_free(data);
-}
-
-static void mcp_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	struct mcp_data *data;
-	char addr[18];
-
-	ba2str(device_get_address(device), addr);
-	DBG("%s", addr);
-
-	data = btd_service_get_user_data(service);
-	if (!data) {
-		error("MCP service not handled by profile");
+	if (duration_centisec == BT_MCS_POSITION_UNAVAILABLE) {
+		media_player_set_duration(remote->mp, 0);
 		return;
 	}
 
-	mcp_data_remove(data);
+	if (duration_centisec < 0)
+		duration_centisec = 0;
+
+	media_player_set_duration(remote->mp, duration_centisec * 10);
+}
+
+static void remote_track_position(void *data, int32_t position_centisec)
+{
+	struct remote_player *remote = data;
+
+	if (position_centisec == BT_MCS_POSITION_UNAVAILABLE) {
+		media_player_set_position(remote->mp, 0);
+		return;
+	}
+
+	if (position_centisec < 0)
+		position_centisec = 0;
+
+	media_player_set_position(remote->mp, position_centisec * 10);
+}
+
+static void remote_playback_speed(void *data, int8_t value)
+{
+	/* TODO */
+}
+
+static void remote_seeking_speed(void *data, int8_t speed)
+{
+	/* TODO */
+}
+
+static const struct {
+	uint16_t basic;
+	uint16_t repeat;
+	bool shuffle;
+	bool single;
+} playing_orders[] = {
+	{ BT_MCS_ORDER_SINGLE_ONCE, BT_MCS_ORDER_SINGLE_REPEAT,
+	  .single = true },
+	{ BT_MCS_ORDER_IN_ORDER_ONCE, BT_MCS_ORDER_IN_ORDER_REPEAT },
+	{ BT_MCS_ORDER_OLDEST_ONCE, BT_MCS_ORDER_OLDEST_REPEAT },
+	{ BT_MCS_ORDER_NEWEST_ONCE, BT_MCS_ORDER_NEWEST_REPEAT },
+	{ BT_MCS_ORDER_SHUFFLE_ONCE, BT_MCS_ORDER_SHUFFLE_REPEAT,
+	  .shuffle = true },
+};
+
+static void remote_playing_order(void *data, uint8_t order)
+{
+	struct remote_player *remote = data;
+	const char *repeat = "off";
+	unsigned int i;
+	bool shuffle;
+
+	remote->playing_order = order;
+
+	for (i = 0; i < ARRAY_SIZE(playing_orders); ++i) {
+		shuffle = playing_orders[i].shuffle;
+		if (order == playing_orders[i].basic) {
+			break;
+		} else if (order == playing_orders[i].repeat) {
+			repeat = playing_orders[i].single ? "singletrack" :
+				"alltracks";
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(playing_orders))
+		return;
+
+	media_player_set_setting(remote->mp, "Repeat", repeat);
+	media_player_set_setting(remote->mp, "Shuffle", shuffle ? "on" : "off");
+}
+
+static void remote_media_state(void *data, uint8_t status)
+{
+	struct remote_player *remote = data;
+
+	media_player_set_status(remote->mp, mcp_status_val_to_string(status));
+}
+
+static void remote_destroy(void *data)
+{
+	struct remote_player *remote = data;
+
+	media_player_destroy(remote->mp);
+	free(data);
+}
+
+static const struct bt_mcp_listener_callback remote_cb = {
+	.media_player_name = remote_media_player_name,
+	.track_changed = remote_track_changed,
+	.track_title = remote_track_title,
+	.track_duration = remote_track_duration,
+	.track_position = remote_track_position,
+	.playback_speed = remote_playback_speed,
+	.seeking_speed = remote_seeking_speed,
+	.playing_order = remote_playing_order,
+	.media_state = remote_media_state,
+	.destroy = remote_destroy,
+};
+
+static int remote_mp_play(struct media_player *mp, void *user_data)
+{
+	struct remote_player *remote = user_data;
+
+	return bt_mcp_play(remote->mcp, remote->ccid);
+}
+
+static int remote_mp_pause(struct media_player *mp, void *user_data)
+{
+	struct remote_player *remote = user_data;
+
+	return bt_mcp_pause(remote->mcp, remote->ccid);
+}
+
+static int remote_mp_stop(struct media_player *mp, void *user_data)
+{
+	struct remote_player *remote = user_data;
+
+	return bt_mcp_stop(remote->mcp, remote->ccid);
+}
+
+static int remote_mp_next(struct media_player *mp, void *user_data)
+{
+	struct remote_player *remote = user_data;
+
+	return bt_mcp_next_track(remote->mcp, remote->ccid);
+}
+
+static int remote_mp_previous(struct media_player *mp, void *user_data)
+{
+	struct remote_player *remote = user_data;
+
+	return bt_mcp_previous_track(remote->mcp, remote->ccid);
+}
+
+static bool remote_mp_set_setting(struct media_player *mp, const char *key,
+					const char *value, void *user_data)
+{
+	struct remote_player *remote = user_data;
+	unsigned int i;
+
+	if (strcmp(key, "Repeat") == 0) {
+		bool repeat = (strcmp(value, "alltracks") == 0);
+		uint8_t order = remote->playing_order;
+
+		/* Some sensible mapping, 1-to-1 not possible */
+		for (i = 0; i < ARRAY_SIZE(playing_orders); ++i) {
+			if (order == playing_orders[i].basic) {
+				if (repeat)
+					order = playing_orders[i].repeat;
+				break;
+			} else if (order == playing_orders[i].repeat) {
+				if (!repeat)
+					order = playing_orders[i].basic;
+				break;
+			}
+		}
+
+		if (strcmp(value, "singletrack") == 0)
+			order = BT_MCS_ORDER_SINGLE_REPEAT;
+
+		DBG("Set Repeat %s -> 0x%02x", value, order);
+
+		if (order == remote->playing_order)
+			return true;
+		return bt_mcp_set_playing_order(remote->mcp, remote->ccid,
+									order);
+	}
+
+	if (strcmp(key, "Shuffle") == 0) {
+		bool shuffle = (strcmp(value, "off") != 0);
+		uint8_t order = remote->playing_order;
+
+		/* Some sensible mapping, 1-to-1 not possible */
+		switch (order) {
+		case BT_MCS_ORDER_SHUFFLE_ONCE:
+			if (!shuffle)
+				order = BT_MCS_ORDER_IN_ORDER_ONCE;
+			break;
+		case BT_MCS_ORDER_SHUFFLE_REPEAT:
+			if (!shuffle)
+				order = BT_MCS_ORDER_IN_ORDER_REPEAT;
+			break;
+		case BT_MCS_ORDER_SINGLE_ONCE:
+		case BT_MCS_ORDER_IN_ORDER_ONCE:
+		case BT_MCS_ORDER_OLDEST_ONCE:
+		case BT_MCS_ORDER_NEWEST_ONCE:
+			if (shuffle)
+				order = BT_MCS_ORDER_SHUFFLE_ONCE;
+			break;
+		case BT_MCS_ORDER_SINGLE_REPEAT:
+		case BT_MCS_ORDER_IN_ORDER_REPEAT:
+		case BT_MCS_ORDER_OLDEST_REPEAT:
+		case BT_MCS_ORDER_NEWEST_REPEAT:
+			if (shuffle)
+				order = BT_MCS_ORDER_SHUFFLE_REPEAT;
+			break;
+		}
+
+		DBG("Set Shuffle %s -> 0x%02x", value, order);
+
+		if (order == remote->playing_order)
+			return true;
+		return bt_mcp_set_playing_order(remote->mcp, remote->ccid,
+									order);
+	}
+
+	return false;
+}
+
+static const struct media_player_callback remote_mp_cb = {
+	.play		= remote_mp_play,
+	.pause		= remote_mp_pause,
+	.stop		= remote_mp_stop,
+	.next		= remote_mp_next,
+	.previous	= remote_mp_previous,
+	.set_setting	= remote_mp_set_setting,
+};
+
+static void mcp_ccid(void *data, uint8_t ccid, bool gmcs)
+{
+	struct btd_service *service = data;
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_mcp *mcp = btd_service_get_user_data(service);
+	struct remote_player *remote;
+	struct media_player *mp;
+
+	mp = media_player_controller_create(device_get_path(device),
+					gmcs ? "mcp_gmcs" : "mcp_mcs", ccid);
+	if (!mp) {
+		DBG("Unable to create Media Player");
+		return;
+	}
+
+	remote = new0(struct remote_player, 1);
+	remote->mcp = mcp;
+	remote->ccid = ccid;
+	remote->mp = mp;
+
+	media_player_set_callbacks(remote->mp, &remote_mp_cb, remote);
+
+	if (!bt_mcp_add_listener(mcp, ccid, &remote_cb, remote)) {
+		DBG("Unable to register Media Player with MCP");
+		media_player_destroy(mp);
+		free(remote);
+		return;
+	}
+}
+
+static void mcp_debug(void *data, const char *str)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static void mcp_ready(void *data)
+{
+	struct btd_service *service = data;
+
+	btd_service_connecting_complete(service, 0);
+}
+
+static const struct bt_mcp_callback mcp_cb = {
+	.ccid = mcp_ccid,
+	.debug = mcp_debug,
+	.ready = mcp_ready,
+};
+
+
+/*
+ * Profile
+ */
+
+static struct btd_profile mcp_gmcs_profile;
+
+static int add_service(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct bt_mcp *mcp = btd_service_get_user_data(service);
+	bool gmcs;
+
+	if (mcp)
+		return -EALREADY;
+
+	gmcs = btd_service_get_profile(service) == &mcp_gmcs_profile;
+
+	mcp = bt_mcp_attach(client, gmcs, &mcp_cb, service);
+	if (!mcp) {
+		DBG("Unable to attach MCP");
+		return -EINVAL;
+	}
+
+	btd_service_set_user_data(service, mcp);
+	return 0;
+}
+
+static void remove_service(struct btd_service *service)
+{
+	struct bt_mcp *mcp = btd_service_get_user_data(service);
+
+	btd_service_set_user_data(service, NULL);
+	bt_mcp_detach(mcp);
 }
 
 static int mcp_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
-	struct mcp_data *data = btd_service_get_user_data(service);
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
 
-	bt_mcp_attach(data->mcp, client);
-
-	data->mp = media_player_controller_create(device_get_path(device),
-							"mcp", 0);
-	if (data->mp == NULL) {
-		DBG("Unable to create Media Player");
-		return -EINVAL;
-	}
-
-	media_player_set_callbacks(data->mp, &ct_cbs, data->mcp);
-
-	bt_mcp_set_user_data(data->mcp, data->mp);
-	bt_mcp_set_event_callbacks(data->mcp, &cbs, data->mp);
-	btd_service_connecting_complete(service, 0);
-
-	return 0;
+	return add_service(service);
 }
 
 static int mcp_connect(struct btd_service *service)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	char addr[18];
-
-	ba2str(device_get_address(device), addr);
-	DBG("%s", addr);
-
 	return 0;
 }
 
 static int mcp_disconnect(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct mcp_data *data = btd_service_get_user_data(service);
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
 
-	if (data->mp) {
-		media_player_destroy(data->mp);
-		data->mp = NULL;
-	}
-
-	bt_mcp_detach(data->mcp);
-
+	remove_service(service);
 	btd_service_disconnecting_complete(service, 0);
-
 	return 0;
 }
 
-static int media_control_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static int mcp_probe(struct btd_service *service)
 {
-	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
-
-	bt_mcp_register(btd_gatt_database_get_db(database));
-
 	return 0;
 }
 
-static void media_control_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
+static void mcp_remove(struct btd_service *service)
 {
-
+	remove_service(service);
 }
 
-static struct btd_profile mcp_profile = {
-	.name			= "mcp",
+static int gmcs_probe(struct btd_profile *p, struct btd_adapter *adapter)
+{
+	return 0;
+}
+
+static void gmcs_remove(struct btd_profile *p, struct btd_adapter *adapter)
+{
+}
+
+static struct btd_profile mcp_gmcs_profile = {
+	.name			= "mcp-gmcs",
 	.priority		= BTD_PROFILE_PRIORITY_MEDIUM,
-	.bearer		= BTD_PROFILE_BEARER_LE,
-	.remote_uuid	= GMCS_UUID_STR,
-	.device_probe	= mcp_probe,
-	.device_remove	= mcp_remove,
+	.bearer			= BTD_PROFILE_BEARER_LE,
+	.remote_uuid		= GMCS_UUID_STR,
+	.device_probe		= mcp_probe,
+	.device_remove		= mcp_remove,
 	.accept			= mcp_accept,
 	.connect		= mcp_connect,
 	.disconnect		= mcp_disconnect,
 
-	.adapter_probe	= media_control_server_probe,
-	.adapter_remove = media_control_server_remove,
+	.adapter_probe		= gmcs_probe,
+	.adapter_remove		= gmcs_remove,
 
-	.experimental	= true,
+	.experimental = true,
+};
+
+static struct btd_profile mcp_mcs_profile = {
+	.name			= "mcp-mcs",
+	.priority		= BTD_PROFILE_PRIORITY_MEDIUM,
+	.bearer			= BTD_PROFILE_BEARER_LE,
+	.remote_uuid		= MCS_UUID_STR,
+	.device_probe		= mcp_probe,
+	.device_remove		= mcp_remove,
+	.accept			= mcp_accept,
+	.connect		= mcp_connect,
+	.disconnect		= mcp_disconnect,
+
+	.adapter_probe		= NULL,
+	.adapter_remove		= NULL,
+
+	.experimental = true,
 };
 
 static int mcp_init(void)
 {
-	return btd_profile_register(&mcp_profile);
+	int err;
+
+	err = btd_profile_register(&mcp_gmcs_profile);
+	if (err)
+		return err;
+
+	err = btd_profile_register(&mcp_mcs_profile);
+	if (err) {
+		btd_profile_unregister(&mcp_gmcs_profile);
+		return err;
+	}
+
+	return err;
 }
 
 static void mcp_exit(void)
 {
-	btd_profile_unregister(&mcp_profile);
+	btd_profile_unregister(&mcp_gmcs_profile);
+	btd_profile_unregister(&mcp_mcs_profile);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(mcp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.51.1

