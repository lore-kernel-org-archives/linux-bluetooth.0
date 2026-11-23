Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453184;
	b=KNtgp2z4vSw2hhNCAvfhzEAeSW9RLmW26QaQnPVKp+myKK4y36YK4MhfqKoRpWTZ8i49
	 vLmExiB4tYkuyVVBtY48f05VoliKp4qstuL1QjQFhIlFdS0wQWUKlyRv3TazWsRgao2cK
	 nnhO5IbVk7ofPXuRke0nOih3yfP+/prQVxCCbkZ/dGGCMtomMaTukcRrcdofeVkM7+lKK
	 x00j46uZtJtt+qQ0Vy5cbouenks4//t8DGHAT2BOnlW+AW/KcsuumMWGswRNnnW5evZc/
	 BFbKFgpBbb4EbHk82eAQ+C2gfhP+6I5Ca51+Oz1UO4JyWCMOGPA0gyJmKaEcer0BpSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hvJk4GF+DMqUotxCEafF2E/zDJC9tUs/EV5INVJ9aCc=;
	b=e0I72n92gh8TWJvbZQ6ypKNfwGYo5dYfWuJ4I2c5qQ6acJLtZyPrhkkEMftZ4uk8Z2Pi
	 BJeizf3QaLtM3EvQXYwLTxT844yt5vosyhBSrsKGbYlrHfODceyAHRdMlFgcwiOUhon8u
	 imJCTxRyi3KZtsAGbHXweKDGzGeWsm3/NUX6gFYBfZamRlWgt7Fvp0FgdWbnnxVdj3Z3f
	 /mFQSR4K2noVWmYP4x9uaOhFUYkZgCzHIm/sFqRUra1DPUFoEmTywGsyKKxRvoN8PJd0+
	 0dCH1DdZpN/emF0D91grFwMqoSRs/bc/7ZAUEGk4cCb31mDPuYAoiSatZ148AozkUdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0nikYLv+;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD9606A69E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDD9606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0nikYLv+
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso34537605e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453182; x=1796057982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvJk4GF+DMqUotxCEafF2E/zDJC9tUs/EV5INVJ9aCc=;
        b=0nikYLv+O1mfMxvYpZjywyDXidJjVk01T7+rIvNh+oI7Pa/NTwqsVeHkbgBq6/5I2J
         TMRxZ7PHUlJkUtFgRxsFnAi2jPRamqun/9OyPWe87eYzyCVaNm7yrGb0QyJG2JELezkf
         Py7PAL8X7+399al21cybc94FhzC+qzIgu7qRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453182; x=1796057982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvJk4GF+DMqUotxCEafF2E/zDJC9tUs/EV5INVJ9aCc=;
        b=K7lH2BKI61MR6pv1JkqeMNKu8Ybr34qfplYg4FWFQ/safSIIzbBQzVAf9ntQz6GjWe
         P77dXmHBVx9MzLombpgvAPjmLVN58kroqxIH6ol+/999a9pu1ESeD6x5sy4izixEjQ44
         9E+8ljescNknBpYv3nbmD1bZ/VvUkZON6xyGH9ALVhsz/q8+kjMu89+WrqOci+dVhCJy
         3SJ3Y3yu3oYQP8BMscoZHYyvjh5VHDMUEIeAJ+x5GUdOxw6F0tmNpz5rE4RFS9KcKtvE
         llTieUy7p6cs3g/DGIKBwKQmUIFF+s+MW+XAc52JNrNqdXsuJ1EyC6ChW7HFzTRq7NzE
         z5ZA==
X-Gm-Message-State: APuU4Z8mjCe5mpmEMp+LJSsJycCJ76RoEl6RgTlzkHBX8ljW9HE5M6WW
	dcs0br8Hr1eXuIxAP+kBj85Mgh5A7Kuv2npOozhzU8QKwmcTSoja3dTesv4Y0WrDCy6nAL7pals
	VL32I
X-Gm-Gg: AZFdTZfClnFIBpmcxk/0Sx+ssMSrac/ICDQ3SUazVk6Ka3LyWIM8y0mq2kbiHql3EtA
	Epc7KcCSuIlHgJRGcbRUYgrUwSZ+SdASk2xK6UPgCk2FrvlmGVrC5UCZRnYZzp46Yxkbg+uiDFU
	vYflxg37GhiY5Nj+SmB9r9Wv51XybW7/25PdWJctlNmhcv9fUync7Yhs5YwmVjj7m5q5e0GGmYK
	qyd4jjrkiIHuVc7zv7BU/PtEh0/4p4NvyEIC3LjVHQuOurOL6MDk1XKZYHt9/fZlEVWKXtGcIMS
	mNh9FFrV1jQbO780oqIRyoFTPM+YjtihQStKl55/XwSJg9fMgRd55hLp7wDdZRN+U+D5efpragv
	ISFeG/n2WmdVvNzdHGjqZm0751pBXGhHxuwiCDX3RD3oiSYid5iO8fIKZpImlTAhbjncaVOBcnn
	3XXRwO6Pj9ujhF3BBjAejfw+idRUznMwBEuq3rc3TUXtX2Vdz6DFG0RFvVCdTcwOsGjuRwnozIB
	Lnt6neSW/5JVAzjvwLF+3/xPn3c9WvylVwBHMFagBLonecQ95cSFmN2kJ70UgrRDvX9qwInK3hS
	c/mDA7WNTFZ/DCFyxk7h4ytVHGFN5zYRBwZryjpmvlyZfE3WqrGujH+IVFnaJAlDuUlwrw==
X-Received: by 2002:a05:600c:3491:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4bb8880014dmr258350885e9.10.1795453182478;
        Mon, 23 Nov 2026 08:59:42 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:42 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 8/8] player: Fix NumberOfItems of Now Playing when its content changes
Date: Mon, 23 Nov 2026 17:59:32 +0100
Message-ID: <20261123165932.470612-9-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
References: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NOW_PLAYING_CONTENT_CHANGED clears the Now Playing items but keeps the
number of items, which is requested again only when the scope changes,
and ListItems does not list past it. So a controller that stays in Now
Playing lists a grown list cut at its old length.

To reproduce, list the 2 items of Now Playing, let the target add 3
items, and list Now Playing again:

  btmon: EventID: 0x09 (EVENT_NOW_PLAYING_CONTENT_CHANGED)
  avrcp_now_playing_changed() NowPlaying changed
  bluetoothd: profiles/audio/player.c:get_items() 2
  btmon: AVRCP: GetFolderItems: len 0x0022
  btmon: Scope: 0x03 (Now Playing)
  btmon: StartItem: 0x00000000 (0)
  btmon: EndItem: 0x00000001 (1)
  avrcp_list_items_rsp() start 0 end 1 items 2 total 2

Only the 2 items listed before are listed again.

Reset the number of items, so that ListItems leaves the end of the list
to the target until it is known again, and request it again when Now
Playing is the current folder.

That request can still be in flight when the client changes folder or
player, and its reply would then set the number of items of the folder
current by then, of whichever player is the current one. Give each
reply the player and folder it was requested for, and drop it when that
folder is no longer the player's current one.

Fixes: 671f370a8e34 ("audio/player: Clear playlist on Now Playing Changed AVRCP event")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c   | 86 ++++++++++++++++++++++++++++++++--------
 profiles/audio/player.c  | 25 +++++++++++-
 profiles/audio/player.h  |  1 +
 unit/test-media-player.c |  8 +++-
 4 files changed, 101 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 128d7fe39..9486cb99e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -252,6 +252,13 @@ struct avrcp {
 	bool pos_changed_supported;
 	uint8_t transaction;
 	struct pending_pdu *pending_pdu;
+	GSList *total_items_reqs;
+};
+
+struct total_items_req {
+	struct avrcp *session;
+	struct avrcp_player *player;
+	char *name;
 };
 
 struct passthrough_handler {
@@ -3554,50 +3561,71 @@ static int ct_add_to_nowplaying(struct media_player *mp, const char *name,
 	return 0;
 }
 
+static void total_items_req_free(void *data)
+{
+	struct total_items_req *req = data;
+
+	g_free(req->name);
+	g_free(req);
+}
+
 static gboolean avrcp_get_total_numberofitems_rsp(struct avctp *conn,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
 	struct iovec iov = { operands, operand_count };
-	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->controller->player;
-	struct media_player *mp = player->user_data;
+	struct total_items_req *req = user_data;
+	struct avrcp *session = req->session;
+	struct avrcp_player *player = req->player;
 	uint32_t num_of_items = 0;
 	uint16_t uid_counter;
 	uint8_t status;
 
+	session->total_items_reqs = g_slist_remove(session->total_items_reqs,
+									req);
+
+	/* The player may be gone */
+	if (!g_slist_find(session->controller->players, player))
+		goto free;
+
 	if (operands == NULL)
-		return FALSE;
+		goto free;
 
 	if (!avrcp_pull_browsing_header(&iov) ||
 			!util_iov_pull_u8(&iov, &status))
-		return FALSE;
+		goto free;
 
 	if (status == AVRCP_STATUS_OUT_OF_BOUNDS)
 		goto done;
 
 	if (status != AVRCP_STATUS_SUCCESS)
-		return FALSE;
+		goto free;
 
 	if (!util_iov_pull_be16(&iov, &uid_counter) ||
 			!util_iov_pull_be32(&iov, &num_of_items))
-		return FALSE;
+		goto free;
 
 	player->uid_counter = uid_counter;
 
 	if (!num_of_items)
-		return FALSE;
+		goto free;
 
 done:
-	media_player_total_items_complete(mp, num_of_items);
+	media_player_total_items_complete(player->user_data, req->name,
+							num_of_items);
+free:
+	total_items_req_free(req);
 	return FALSE;
 }
 
-static void avrcp_get_total_numberofitems(struct avrcp *session)
+static int avrcp_get_total_numberofitems(struct avrcp *session,
+							const char *name)
 {
 	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 1];
 	struct avrcp_player *player = session->controller->player;
 	struct avrcp_browsing_header *pdu = (void *) buf;
+	struct total_items_req *req;
+	int err;
 
 	memset(buf, 0, sizeof(buf));
 
@@ -3606,8 +3634,26 @@ static void avrcp_get_total_numberofitems(struct avrcp *session)
 
 	pdu->params[0] = player->scope;
 
-	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
-				avrcp_get_total_numberofitems_rsp, session);
+	/*
+	 * The reply is matched to the folder it was asked for, since the
+	 * player or its folder may change while the request is in flight.
+	 */
+	req = g_new0(struct total_items_req, 1);
+	req->session = session;
+	req->player = player;
+	req->name = g_strdup(name);
+
+	err = avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+				avrcp_get_total_numberofitems_rsp, req);
+	if (err < 0) {
+		total_items_req_free(req);
+		return err;
+	}
+
+	session->total_items_reqs = g_slist_prepend(session->total_items_reqs,
+									req);
+
+	return 0;
 }
 
 static int ct_get_total_numberofitems(struct media_player *mp, const char *name,
@@ -3631,9 +3677,7 @@ static int ct_get_total_numberofitems(struct media_player *mp, const char *name,
 	else
 		player->scope = 0x01;
 
-	avrcp_get_total_numberofitems(session);
-
-	return 0;
+	return avrcp_get_total_numberofitems(session, name);
 }
 
 static const struct media_player_callback ct_cbs = {
@@ -4556,6 +4600,8 @@ static void session_destroy(struct avrcp *session, int err)
 	if (session->position_timer > 0)
 		timeout_remove(session->position_timer);
 
+	g_slist_free_full(session->total_items_reqs, total_items_req_free);
+
 	if (session->controller != NULL)
 		controller_destroy(session);
 
@@ -4618,7 +4664,15 @@ static void state_changed(struct btd_device *device, avctp_state_t old_state,
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-		if (session == NULL || session->control_id > 0)
+		if (session == NULL)
+			break;
+
+		/* The requests of a lost browsing channel get no reply */
+		g_slist_free_full(session->total_items_reqs,
+						total_items_req_free);
+		session->total_items_reqs = NULL;
+
+		if (session->control_id > 0)
 			break;
 
 		session_init_control(session);
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 5f29be749..166279f91 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -758,11 +758,13 @@ done:
 }
 
 void media_player_total_items_complete(struct media_player *mp,
-							uint32_t num_of_items)
+						const char *name,
+						uint32_t num_of_items)
 {
 	struct media_folder *folder = mp->scope;
 
-	if (folder == NULL)
+	/* The scope may have changed while the request was in flight */
+	if (folder == NULL || g_strcmp0(folder->item->name, name) != 0)
 		return;
 
 	if (folder->number_of_items != num_of_items) {
@@ -2073,9 +2075,28 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 
 void media_player_clear_playlist(struct media_player *mp)
 {
+	struct player_callback *cb = mp->cb;
+
 	if (mp->playlist) {
 		g_slist_free_full(mp->playlist->items, media_item_destroy);
 		mp->playlist->items = NULL;
+
+		/*
+		 * The number of items may have changed: leave the end of the
+		 * list to the target until it is known again.
+		 */
+		mp->playlist->number_of_items = 0;
+	}
+
+	if (mp->playlist && mp->scope == mp->playlist) {
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						mp->path,
+						MEDIA_FOLDER_INTERFACE,
+						"NumberOfItems");
+
+		if (cb->cbs->total_items)
+			cb->cbs->total_items(mp, mp->scope->item->name,
+							cb->user_data);
 	}
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index dcd7df286..5d2e0a962 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -108,6 +108,7 @@ void media_player_change_folder_complete(struct media_player *player,
 						int ret);
 void media_player_search_complete(struct media_player *mp, int ret);
 void media_player_total_items_complete(struct media_player *mp,
+						const char *name,
 						uint32_t num_of_items);
 
 void media_player_set_callbacks(struct media_player *mp,
diff --git a/unit/test-media-player.c b/unit/test-media-player.c
index ef2d5dff3..7dfee7681 100644
--- a/unit/test-media-player.c
+++ b/unit/test-media-player.c
@@ -53,6 +53,7 @@ struct context {
 	bool destroy_on_play;
 	bool check_total_items;
 	unsigned int total_items_calls;
+	char *total_items_name;
 };
 
 static struct context *context;
@@ -145,7 +146,8 @@ static gboolean complete_total_items(gpointer user_data)
 	if (context == NULL)
 		return FALSE;
 
-	media_player_total_items_complete(context->mp, TOTAL_ITEMS);
+	media_player_total_items_complete(context->mp,
+					context->total_items_name, TOTAL_ITEMS);
 
 	call_get_number_of_items(&context->pending2, number_of_items_reply);
 
@@ -165,6 +167,9 @@ static int test_total_items(struct media_player *mp, const char *name,
 
 	ctx->total_items_calls++;
 
+	g_free(ctx->total_items_name);
+	ctx->total_items_name = g_strdup(name);
+
 	if (ctx->check_total_items)
 		g_idle_add(complete_total_items, NULL);
 
@@ -240,6 +245,7 @@ static void destroy_context(void)
 	dbus_connection_unref(context->dbus_conn);
 
 	g_free(context->play_item_name);
+	g_free(context->total_items_name);
 	g_free(context);
 	context = NULL;
 }
-- 
2.43.0

