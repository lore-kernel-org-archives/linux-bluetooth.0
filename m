Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B429B76F
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164258; cv=pass; b=P3YAVOkz/M58l7gTRiFtHGVa6am9i2VgASjMzVo8KujTs1qPVhIi7W2jBRW5XXHu1bJCAVcfCKodcQnnOb3iwOx7TJJgTgTKVLm6qhOoQ9nV2088NSDJSXDspCKmn+gr8zOpsWA7a+aL+D58lf4Ib38VabAuloduSeMSEtzHoNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164258; c=relaxed/simple;
	bh=LQUs9JLCBf5DYOKUTjsgO4Lx60H65m5+JE2g0ygiou4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYSusm9zBl7TvTdCf39oKKK4Oyn3xSvw5UQXlQxiEmdc6EMom9e1sodCMMBJkETXegEy8aWstuLWDQ6+VsjffAUq4FIw/Y+eJqlSbprZ9kqZO+4k0aKNOLglOmHYRuIdlLs8P7BauTfe/eEnDOYo+iIFvkGpbjvLVmGF/IuDvWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gvvej0Qx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gvvej0Qx"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dXvF14NTWz103Y;
	Fri, 19 Dec 2025 19:10:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1766164246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ON+gjs24lHNYLyOvnDj+lLsmKInVjxDrul45OP7byzY=;
	b=gvvej0Qxa899zycbvosmrgD0Vqfnd8Tfwg2q4yeZqqWYQMT8oJlQyHEHgUe2WTttXyLF8A
	YQr2IDRszqG+jzOBAAVtYzlvyTwnRhhE+v2jCRSYYLWxt8nvnf+dDtqiA4mxs4LlU9FLVV
	/Dsa7S72pqqrbm10oq9irxBP/11pRI0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1766164246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ON+gjs24lHNYLyOvnDj+lLsmKInVjxDrul45OP7byzY=;
	b=n9JnDAvjxOAI458G4BY6Sei+Q1VvJUmdULAulU7xBmosj77LLrmg/qGb+/jyqzkDxuj0fx
	ceAtpAeWNIiI4WsqM2qZHuQevfPkyGAN/5yP+mAxu83ox478+LibHUsORXpiApQ0KRFmuw
	u9e0gEa70NrE6lkT2/xWqCVkj0s37xw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1766164246;
	b=LpwgIz0EsIR4oUWReFooi877mXoYY/brDeteHmCnDjybGs8x3G3jDs7jNsuX4rPjedHl29
	k88xf86BhoMhGXiAzKH0A6MhOYZ35gBohx8fZ06TXzWBOWs9TIC0DXWrFAnFZ6amjoxZ2p
	3MVGZSrfWim6LwgGk2qGyI2xLqeC2rI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/3] mcp: expose org.bluez.MediaPlayer information via GMCS
Date: Fri, 19 Dec 2025 19:10:38 +0200
Message-ID: <a1f45c0b442eab8f767adcdc2f82902ea0aeb0ee.1766164144.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1766164144.git.pav@iki.fi>
References: <cover.1766164144.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select one of the local org.bluez.MediaPlayer instances as the "active"
player, and expose its playback controls via GMCS.
---

Notes:
    v2:
    - no change

 profiles/audio/mcp.c | 506 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 441 insertions(+), 65 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index fc0587ce3..0c2e0de0b 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -56,6 +56,7 @@
 #include "src/error.h"
 
 #include "player.h"
+#include "media.h"
 
 #define MCS_UUID_STR	"00001848-0000-1000-8000-00805f9b34fb"
 #define GMCS_UUID_STR	"00001849-0000-1000-8000-00805f9b34fb"
@@ -203,30 +204,42 @@ static const struct {
 	  .shuffle = true },
 };
 
-static void remote_playing_order(void *data, uint8_t order)
+static bool get_playing_order(uint8_t order, const char **repeat,
+							const char **shuffle)
 {
-	struct remote_player *remote = data;
-	const char *repeat = "off";
 	unsigned int i;
-	bool shuffle;
 
-	remote->playing_order = order;
+	*repeat = "off";
+	*shuffle = "off";
 
 	for (i = 0; i < ARRAY_SIZE(playing_orders); ++i) {
-		shuffle = playing_orders[i].shuffle;
+		*shuffle = playing_orders[i].shuffle ? "alltracks" : "off";
 		if (order == playing_orders[i].basic) {
 			break;
 		} else if (order == playing_orders[i].repeat) {
-			repeat = playing_orders[i].single ? "singletrack" :
+			*repeat = playing_orders[i].single ? "singletrack" :
 				"alltracks";
 			break;
 		}
 	}
 	if (i == ARRAY_SIZE(playing_orders))
+		return false;
+
+	return true;
+}
+
+static void remote_playing_order(void *data, uint8_t order)
+{
+	struct remote_player *remote = data;
+	const char *repeat, *shuffle;
+
+	remote->playing_order = order;
+
+	if (!get_playing_order(order, &repeat, &shuffle))
 		return;
 
 	media_player_set_setting(remote->mp, "Repeat", repeat);
-	media_player_set_setting(remote->mp, "Shuffle", shuffle ? "on" : "off");
+	media_player_set_setting(remote->mp, "Shuffle", shuffle);
 }
 
 static void remote_media_state(void *data, uint8_t status)
@@ -297,7 +310,7 @@ static bool remote_mp_set_setting(struct media_player *mp, const char *key,
 	unsigned int i;
 
 	if (strcmp(key, "Repeat") == 0) {
-		bool repeat = (strcmp(value, "alltracks") == 0);
+		bool repeat = (strcasecmp(value, "alltracks") == 0);
 		uint8_t order = remote->playing_order;
 
 		/* Some sensible mapping, 1-to-1 not possible */
@@ -313,7 +326,7 @@ static bool remote_mp_set_setting(struct media_player *mp, const char *key,
 			}
 		}
 
-		if (strcmp(value, "singletrack") == 0)
+		if (strcasecmp(value, "singletrack") == 0)
 			order = BT_MCS_ORDER_SINGLE_REPEAT;
 
 		DBG("Set Repeat %s -> 0x%02x", value, order);
@@ -325,7 +338,7 @@ static bool remote_mp_set_setting(struct media_player *mp, const char *key,
 	}
 
 	if (strcmp(key, "Shuffle") == 0) {
-		bool shuffle = (strcmp(value, "off") != 0);
+		bool shuffle = (strcasecmp(value, "off") != 0);
 		uint8_t order = remote->playing_order;
 
 		/* Some sensible mapping, 1-to-1 not possible */
@@ -424,22 +437,33 @@ static const struct bt_mcp_callback mcp_cb = {
 
 
 /*
- * Local player
+ * Local player.
+ *
+ * TODO: maybe expose multiple MCS instances, as many as there are players. We'd
+ * have to keep unused instances around in inactive state, so that we don't
+ * consume ATT handles when players disappear/reappear.
+ *
+ * If an instance has no local player, for GMCS we forward key presses to
+ * uinput. Other MCS instances should do nothing when inactive.
  */
 
-struct gmcs;
+struct mcs_instance;
 
-struct local_player {
-	struct bt_mcs *mcs;
-	struct media_player *mp;
-	struct gmcs *gmcs;
+struct player_link {
+	struct local_player *lp;
+	unsigned int id;
+	struct mcs_instance *instance;
 };
 
-struct gmcs {
-	struct bt_uinput *uinput;
+struct mcs_instance {
 	struct btd_adapter *adapter;
 	struct bt_mcs *mcs;
-	struct queue *players;
+	struct queue *player_links;
+	bool at_start;
+
+	/* GMCS-specific */
+	struct bt_uinput *uinput;
+	unsigned int player_watch_id;
 };
 
 static const struct bt_uinput_key_map key_map[] = {
@@ -453,96 +477,418 @@ static const struct bt_uinput_key_map key_map[] = {
 
 static struct queue *servers;
 
-static bool gmcs_command(struct gmcs *gmcs, uint8_t cmd)
+static struct player_link *mcs_get_active(struct mcs_instance *mcs)
+{
+	return queue_peek_head(mcs->player_links);
+}
+
+static bool player_link_is_active(struct player_link *p)
+{
+	return mcs_get_active(p->instance) == p;
+}
+
+static void mcs_update_media_state(struct mcs_instance *mcs)
+{
+	struct player_link *p = mcs_get_active(mcs);
+	const char *status = NULL;
+	uint8_t state;
+
+	mcs->at_start = false;
+
+	if (p)
+		status = local_player_get_status(p->lp);
+
+	if (!status) {
+		state = BT_MCS_STATE_INACTIVE;
+	} else if (!strcasecmp(status, "playing")) {
+		state = BT_MCS_STATE_PLAYING;
+	} else if (!strcasecmp(status, "stopped")) {
+		mcs->at_start = true;
+		state = BT_MCS_STATE_PAUSED;
+	} else if (!strcasecmp(status, "paused")) {
+		state = BT_MCS_STATE_PAUSED;
+	} else if (!strcasecmp(status, "forward-seek") ||
+					!strcasecmp(status, "backward-seek")) {
+		state = BT_MCS_STATE_SEEKING;
+	} else {
+		state = BT_MCS_STATE_INACTIVE;
+	}
+
+	bt_mcs_set_media_state(mcs->mcs, state);
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_POSITION_CHRC_UUID);
+}
+
+static void mcs_player_changed(struct mcs_instance *mcs)
+{
+	struct player_link *p = mcs_get_active(mcs);
+	const char *name = p ? local_player_get_player_name(p->lp) : NULL;
+
+	DBG("active: %p %s", p, name ? name : "");
+
+	bt_mcs_changed(mcs->mcs, MCS_MEDIA_PLAYER_NAME_CHRC_UUID);
+	mcs_update_media_state(mcs);
+
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_TITLE_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_DURATION_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_POSITION_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_PLAYBACK_SPEED_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_SEEKING_SPEED_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_PLAYING_ORDER_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_CHANGED_CHRC_UUID);
+}
+
+static bool player_link_make_active(struct player_link *p)
+{
+	struct mcs_instance *mcs = p->instance;
+
+	if (player_link_is_active(p))
+		return false;
+
+	queue_remove(mcs->player_links, p);
+	queue_push_head(mcs->player_links, p);
+
+	mcs_player_changed(mcs);
+	return true;
+}
+
+static void lp_status_changed(void *user_data)
+{
+	struct player_link *p = user_data;
+	struct mcs_instance *mcs = p->instance;
+	const char *status = local_player_get_status(p->lp);
+
+	/* Make the last player to start playing active */
+	if (!strcasecmp(status, "playing")) {
+		if (player_link_make_active(p))
+			return;
+	}
+
+	if (!player_link_is_active(p))
+		return;
+
+	mcs_update_media_state(mcs);
+}
+
+static void lp_track_position(uint32_t old_ms, uint32_t new_ms, void *user_data)
+{
+	struct player_link *p = user_data;
+	struct mcs_instance *mcs = p->instance;
+
+	if (!player_link_is_active(p))
+		return;
+
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_POSITION_CHRC_UUID);
+}
+
+static void lp_track_changed(void *user_data)
+{
+	struct player_link *p = user_data;
+	struct mcs_instance *mcs = p->instance;
+
+	mcs->at_start = false;
+
+	if (!player_link_is_active(p))
+		return;
+
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_TITLE_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_POSITION_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_DURATION_CHRC_UUID);
+	bt_mcs_changed(mcs->mcs, MCS_TRACK_CHANGED_CHRC_UUID);
+}
+
+static void lp_settings_changed(const char *key, void *user_data)
+{
+	struct player_link *p = user_data;
+	struct mcs_instance *mcs = p->instance;
+
+	if (!player_link_is_active(p))
+		return;
+	if (strcasecmp(key, "Shuffle") && strcasecmp(key, "Repeat"))
+		return;
+
+	bt_mcs_changed(mcs->mcs, MCS_PLAYING_ORDER_CHRC_UUID);
+}
+
+static void lp_player_removed(void *user_data)
+{
+	struct player_link *p = user_data;
+	struct mcs_instance *mcs = p->instance;
+	bool active = player_link_is_active(p);
+
+	DBG("%p", p);
+
+	queue_remove(mcs->player_links, p);
+	free(p);
+
+	if (active)
+		mcs_player_changed(mcs);
+}
+
+const struct local_player_callback local_player_cb = {
+	.status_changed = lp_status_changed,
+	.track_position = lp_track_position,
+	.track_changed = lp_track_changed,
+	.settings_changed = lp_settings_changed,
+	.player_removed = lp_player_removed,
+};
+
+static bool mcs_command(struct mcs_instance *mcs, uint8_t cmd)
 {
 	unsigned int i;
 
 	/* Emulate media key press */
-	if (!gmcs->uinput)
+	if (!mcs->uinput)
 		return false;
 
 	for (i = 0; i < ARRAY_SIZE(key_map); ++i) {
 		if (key_map[i].code == cmd) {
-			DBG("GMCS press %s", key_map[i].name);
-			bt_uinput_send_key(gmcs->uinput, key_map[i].uinput, 1);
-			bt_uinput_send_key(gmcs->uinput, key_map[i].uinput, 0);
+			DBG("MCS press %s", key_map[i].name);
+			bt_uinput_send_key(mcs->uinput, key_map[i].uinput, 1);
+			bt_uinput_send_key(mcs->uinput, key_map[i].uinput, 0);
 			break;
 		}
 	}
 
-	/* We are always inactive, so command does not cause state changes and
+	/* We are inactive, so command does not cause state changes and
 	 * does not succeed, even though we do generate the key presses.
 	 * This should be OK vs. MCP v1.0.1 p. 26
 	 */
 	return false;
 }
 
-static bool gmcs_play(void *data)
+static bool mcs_play(void *data)
 {
-	return gmcs_command(data, BT_MCS_CMD_PLAY);
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (p && local_player_play(p->lp))
+		return true;
+	return mcs_command(mcs, BT_MCS_CMD_PLAY);
 }
 
-static bool gmcs_pause(void *data)
+static bool mcs_pause(void *data)
 {
-	return gmcs_command(data, BT_MCS_CMD_PAUSE);
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (p && local_player_pause(p->lp))
+		return true;
+	return mcs_command(mcs, BT_MCS_CMD_PAUSE);
 }
 
-static bool gmcs_stop(void *data)
+static bool mcs_stop(void *data)
 {
-	return gmcs_command(data, BT_MCS_CMD_STOP);
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (p && local_player_stop(p->lp)) {
+		mcs->at_start = true;
+		return true;
+	}
+	return mcs_command(mcs, BT_MCS_CMD_STOP);
 }
 
-static bool gmcs_next_track(void *data)
+static bool mcs_next_track(void *data)
 {
-	return gmcs_command(data, BT_MCS_CMD_NEXT_TRACK);
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (p && local_player_next(p->lp)) {
+		mcs->at_start = true;
+		return true;
+	}
+	return mcs_command(data, BT_MCS_CMD_NEXT_TRACK);
 }
 
-static bool gmcs_previous_track(void *data)
+static bool mcs_previous_track(void *data)
 {
-	return gmcs_command(data, BT_MCS_CMD_PREV_TRACK);
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (p && local_player_previous(p->lp)) {
+		mcs->at_start = true;
+		return true;
+	}
+	return mcs_command(data, BT_MCS_CMD_PREV_TRACK);
 }
 
-static void gmcs_media_player_name(void *data, struct iovec *buf, size_t size)
+static void mcs_media_player_name(void *data, struct iovec *buf, size_t size)
 {
-	struct gmcs *gmcs = data;
-	int len;
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+	const char *name = NULL;
 
-	len = snprintf((void *)buf->iov_base, size, "%s",
-					btd_adapter_get_name(gmcs->adapter));
-	if (len < 0)
-		len = 0;
-	else if ((size_t)len > size)
-		len = size;
-	util_iov_push(buf, len);
+	if (p)
+		name = local_player_get_player_name(p->lp);
+	if (!name)
+		name = btd_adapter_get_name(mcs->adapter);
+
+	snprintf((void *)buf->iov_base, size, "%s", name);
+	util_iov_push(buf, strlen(buf->iov_base));
 }
 
-static void gmcs_destroy(void *data)
+static void mcs_track_title(void *data, struct iovec *buf, size_t size)
 {
-	struct gmcs *gmcs = data;
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+	const char *name = NULL;
+
+	if (p)
+		name = local_player_get_metadata(p->lp, "Title");
+	if (!name)
+		name = "";
+
+	snprintf((void *)buf->iov_base, size, "%s", name);
+	util_iov_push(buf, strlen(buf->iov_base));
+}
+
+static int32_t mcs_track_duration(void *data)
+{
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+	const char *duration = NULL;
+	long duration_ms;
+
+	if (p)
+		duration = local_player_get_metadata(p->lp, "Duration");
+	if (!duration)
+		return BT_MCS_DURATION_UNAVAILABLE;
+
+	duration_ms = atol(duration);
+	return duration_ms / 10;
+}
+
+static int32_t mcs_track_position(void *data)
+{
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (!p)
+		return BT_MCS_POSITION_UNAVAILABLE;
+
+	if (mcs->at_start)
+		return 0;
+
+	return local_player_get_position(p->lp) / 10;
+}
+
+static uint8_t mcs_playing_order(void *data)
+{
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+	bool shuffle, repeat, single;
+	const char *shuffle_str, *repeat_str;
+
+	if (!p)
+		return BT_MCS_ORDER_IN_ORDER_ONCE;
+
+	shuffle_str = local_player_get_setting(p->lp, "Shuffle");
+	repeat_str = local_player_get_setting(p->lp, "Repeat");
+
+	shuffle = shuffle_str && strcasecmp(shuffle_str, "off");
+	repeat = repeat_str && strcasecmp(repeat_str, "off");
+	single = repeat_str && !strcasecmp(repeat_str, "singletrack");
+	if (single)
+		return BT_MCS_ORDER_SINGLE_REPEAT;
+
+	if (shuffle)
+		return repeat ? BT_MCS_ORDER_SHUFFLE_REPEAT :
+						BT_MCS_ORDER_SHUFFLE_ONCE;
+	return repeat ? BT_MCS_ORDER_IN_ORDER_REPEAT :
+						BT_MCS_ORDER_IN_ORDER_ONCE;
+}
+
+static uint16_t mcs_playing_order_supported(void *data)
+{
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (!p)
+		return BT_MCS_ORDER_SUPPORTED_IN_ORDER_ONCE;
+
+	return BT_MCS_ORDER_SUPPORTED_SINGLE_REPEAT |
+		BT_MCS_ORDER_SUPPORTED_IN_ORDER_ONCE |
+		BT_MCS_ORDER_SUPPORTED_IN_ORDER_REPEAT |
+		BT_MCS_ORDER_SUPPORTED_SHUFFLE_ONCE |
+		BT_MCS_ORDER_SUPPORTED_SHUFFLE_REPEAT;
+}
+
+static bool mcs_set_track_position(void *data, int32_t value)
+{
+	/* TODO: add support to setting position in org.bluez.MediaPlayer */
+	return false;
+}
+
+static bool mcs_set_playing_order(void *data, uint8_t value)
+{
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+	const char *repeat, *shuffle;
+	bool ok = true;
+
+	if (!p)
+		return false;
+	if (!get_playing_order(value, &repeat, &shuffle))
+		return false;
+
+	if (local_player_set_setting(p->lp, "Shuffle", shuffle) < 0)
+		ok = false;
+	if (local_player_set_setting(p->lp, "Repeat", repeat) < 0)
+		ok = false;
+
+	bt_mcs_changed(mcs->mcs, MCS_PLAYING_ORDER_CHRC_UUID);
+	return ok;
+}
+
+static void player_link_destroy(void *data)
+{
+	struct player_link *p = data;
+
+	DBG("%p", p);
+
+	local_player_unregister_callbacks(p->lp, p->id);
+	free(p);
+}
+
+static void mcs_destroy(void *data)
+{
+	struct mcs_instance *mcs = data;
 
 	DBG("destroy %p", data);
 
-	queue_remove(servers, gmcs);
+	queue_remove(servers, mcs);
 
-	bt_uinput_destroy(gmcs->uinput);
+	bt_uinput_destroy(mcs->uinput);
 
-	free(gmcs);
+	queue_destroy(mcs->player_links, player_link_destroy);
+
+	if (mcs->player_watch_id)
+		local_player_unregister_watch(mcs->player_watch_id);
+
+	free(mcs);
 }
 
-static void gmcs_debug(void *data, const char *str)
+static void mcs_debug(void *data, const char *str)
 {
 	DBG_IDX(0xffff, "%s", str);
 }
 
 static const struct bt_mcs_callback gmcs_cb = {
-	.media_player_name = gmcs_media_player_name,
-	.play = gmcs_play,
-	.pause = gmcs_pause,
-	.stop = gmcs_stop,
-	.next_track = gmcs_next_track,
-	.previous_track = gmcs_previous_track,
-	.debug = gmcs_debug,
-	.destroy = gmcs_destroy,
+	.media_player_name = mcs_media_player_name,
+	.track_title = mcs_track_title,
+	.track_duration = mcs_track_duration,
+	.track_position = mcs_track_position,
+	.playing_order = mcs_playing_order,
+	.playing_order_supported = mcs_playing_order_supported,
+	.set_track_position = mcs_set_track_position,
+	.set_playing_order = mcs_set_playing_order,
+	.play = mcs_play,
+	.pause = mcs_pause,
+	.stop = mcs_stop,
+	.next_track = mcs_next_track,
+	.previous_track = mcs_previous_track,
+	.debug = mcs_debug,
+	.destroy = mcs_destroy,
 };
 
 static void uinput_debug(const char *str, void *data)
@@ -550,13 +896,39 @@ static void uinput_debug(const char *str, void *data)
 	DBG_IDX(0xffff, "%s", str);
 }
 
-static struct gmcs *gmcs_new(struct btd_adapter *adapter)
+static void gmcs_player_added(struct local_player *lp, void *user_data)
 {
-	struct gmcs *gmcs;
+	struct mcs_instance *gmcs = user_data;
+	struct btd_adapter *adapter = local_player_get_adapter(lp);
+	struct player_link *p;
+
+	if (adapter != gmcs->adapter)
+		return;
+
+	p = new0(struct player_link, 1);
+	p->lp = lp;
+	p->id = local_player_register_callbacks(lp, &local_player_cb, p);
+	p->instance = gmcs;
+	if (!p->id) {
+		free(p);
+		return;
+	}
+
+	DBG("%p", p);
+
+	queue_push_tail(gmcs->player_links, p);
+
+	if (queue_length(gmcs->player_links) == 1)
+		mcs_player_changed(gmcs);
+}
+
+static struct mcs_instance *gmcs_new(struct btd_adapter *adapter)
+{
+	struct mcs_instance *gmcs;
 	const char *name = btd_adapter_get_name(adapter);
 	int err;
 
-	gmcs = new0(struct gmcs, 1);
+	gmcs = new0(struct mcs_instance, 1);
 	gmcs->adapter = adapter;
 
 	gmcs->uinput = bt_uinput_new(name, " (MCS)",
@@ -571,6 +943,10 @@ static struct gmcs *gmcs_new(struct btd_adapter *adapter)
 		gmcs->uinput = NULL;
 	}
 
+	gmcs->player_links = queue_new();
+	gmcs->player_watch_id = local_player_register_watch(gmcs_player_added,
+									gmcs);
+
 	DBG("new %p", gmcs);
 	return gmcs;
 }
@@ -654,7 +1030,7 @@ static int gmcs_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct gatt_db *db = btd_gatt_database_get_db(database);
-	struct gmcs *gmcs;
+	struct mcs_instance *gmcs;
 
 	DBG("Add GMCS server %s", adapter_get_path(adapter));
 
@@ -664,7 +1040,7 @@ static int gmcs_probe(struct btd_profile *p, struct btd_adapter *adapter)
 
 	gmcs->mcs = bt_mcs_register(db, true, &gmcs_cb, gmcs);
 	if (!gmcs->mcs) {
-		gmcs_destroy(gmcs);
+		mcs_destroy(gmcs);
 		return -EINVAL;
 	}
 
-- 
2.51.1

