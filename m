Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13003081D5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314947; cv=pass; b=rWLnuFIgxDyOPRWXXu6q7E4DxJKHjavMwNS0+bCBKR4ykJCx506zVfJmirAR8r6yjr0iFWQ4M5H2NdWt7NUpj7VSIO9F+QRWu9TXVj3ablK59WRYZrIgeKpH8KeWXMEQyjrwwJAZkyrHcf8iQs21Gn//I68IxGcVFqyohekq44Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314947; c=relaxed/simple;
	bh=zIiY684lJzdJdQer2rNt/WhRYrNpDLi0zR0ZVf8aMoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrL6/rGrcMeEaQ7ZjqlESAKP0eu65hTgXjDWLY8u1NJiujW+NrWNtK6bVF/Mg7qMKgutIiKWd+A61VE65B8wsGQVc9udhlrzg4nskuWFPCm4Sh7ByOhLcVRbmyG+HQzvcuZqjpkimcnkStc/NtmY6aBgN8GIYmJ6yNew2pecslY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Zpx0yoZO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Zpx0yoZO"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dQs893xbDzyVW;
	Tue,  9 Dec 2025 23:15:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765314938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5PjxoV+C+M/YfqqvgyWWxOwjN2msSAabWTIpCnAgZI=;
	b=Zpx0yoZOozeZxkACug4L3fz3aWn1A9OzQasWIF8OmXGBkrKYBSmjd5QdGrBe5Hjs/ycGL7
	v5AURHd+LO0RzMuxYXQ+Nw+er45NEAse1Zx7mXPcnYCv3DTQUO9L4VIWxmrs8165WM/qkv
	Vvk1nv54IAzqNshmfG5Egf7NwReD/44=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765314938;
	b=ZBoH4pl7gMibPKkWaZ6V7/Fu67QO6xbEUaSzr0HqcsySfQgCcHgKtKiZn9BGXEUwLksjIj
	ZN3LWrn0bcjAehgNsfSsjGE1xT5D7LvlXWqeSC6yBuYKg/Y1HWsmvsEBbea31r00s/BMqn
	qYeFsoiAEFXq69aI/lLe801TKqPDkyU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765314938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5PjxoV+C+M/YfqqvgyWWxOwjN2msSAabWTIpCnAgZI=;
	b=YNSVs2LXADf9Dl2PLNKhLE0P9e6i84sH22Zy8BcjlJd6lJoHG6zmwHWNEm0PlTp+bqXVPb
	9BIOMrFbmfGWMvBHW3d5MML7dCexQIgTiiCKr7EXv27uz4lLxFAS3y6mz/sxrAHM3AsZED
	KaQF8QyXjq3+uTJbUV53Q0KfuZNZgF8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/6] shared/mcp: support multiple MCP, and add non-stub MCS server
Date: Tue,  9 Dec 2025 23:15:18 +0200
Message-ID: <9a051c44736af25754990fd742f1c8446881c958.1765314903.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765314903.git.pav@iki.fi>
References: <cover.1765314903.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Media Control Client, add support for multiple GMCS / MCS services
on the server. Revise the API accordingly.

For Media Control Server, make it a complete implementation (OTS still
missing), and add an API the profile can use.

This is mostly a complete rewrite.
---
 lib/bluetooth/uuid.h |   27 +-
 src/shared/mcp.c     | 3223 ++++++++++++++++++++++++------------------
 src/shared/mcp.h     |  186 ++-
 src/shared/mcs.h     |   51 +-
 4 files changed, 2093 insertions(+), 1394 deletions(-)

diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
index 805366c3d..74bd83742 100644
--- a/lib/bluetooth/uuid.h
+++ b/lib/bluetooth/uuid.h
@@ -198,20 +198,21 @@ extern "C" {
 #define	AICS_AUDIO_INPUT_CP_CHRC_UUID		0X2B7B
 #define	AICS_INPUT_DESCR_CHAR_UUID		0X2B7C
 
+#define MCS_UUID                                0x1848
 #define GMCS_UUID                               0x1849
-#define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
-#define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
-#define MEDIA_TRACK_TITLE_CHRC_UUID             0x2b97
-#define MEDIA_TRACK_DURATION_CHRC_UUID          0x2b98
-#define MEDIA_TRACK_POSTION_CHRC_UUID           0x2b99
-#define MEDIA_PLAYBACK_SPEED_CHRC_UUID          0x2b9a
-#define MEDIA_SEEKING_SPEED_CHRC_UUID           0x2b9b
-#define MEDIA_PLAYING_ORDER_CHRC_UUID           0x2ba1
-#define MEDIA_PLAY_ORDER_SUPPRTD_CHRC_UUID      0x2ba2
-#define MEDIA_STATE_CHRC_UUID                   0x2ba3
-#define MEDIA_CP_CHRC_UUID                      0x2ba4
-#define MEDIA_CP_OP_SUPPORTED_CHRC_UUID         0x2ba5
-#define MEDIA_CONTENT_CONTROL_ID_CHRC_UUID      0x2bba
+#define MCS_MEDIA_PLAYER_NAME_CHRC_UUID         0x2b93
+#define MCS_TRACK_CHANGED_CHRC_UUID             0x2b96
+#define MCS_TRACK_TITLE_CHRC_UUID               0x2b97
+#define MCS_TRACK_DURATION_CHRC_UUID            0x2b98
+#define MCS_TRACK_POSITION_CHRC_UUID            0x2b99
+#define MCS_PLAYBACK_SPEED_CHRC_UUID            0x2b9a
+#define MCS_SEEKING_SPEED_CHRC_UUID             0x2b9b
+#define MCS_PLAYING_ORDER_CHRC_UUID             0x2ba1
+#define MCS_PLAYING_ORDER_SUPPORTED_CHRC_UUID   0x2ba2
+#define MCS_MEDIA_STATE_CHRC_UUID               0x2ba3
+#define MCS_MEDIA_CP_CHRC_UUID                  0x2ba4
+#define MCS_MEDIA_CP_OP_SUPPORTED_CHRC_UUID     0x2ba5
+#define MCS_CCID_CHRC_UUID                      0x2bba
 
 /* Telephony and Media Audio Service */
 #define TMAS_UUID_STR		"00001855-0000-1000-8000-00805f9b34fb"
diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index 3b03aff40..208c0f78f 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -3,7 +3,8 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2022	Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025	Pauli Virtanen. All rights reserved.
  *
  */
 
@@ -29,1463 +30,2011 @@
 #include "src/shared/mcp.h"
 #include "src/shared/mcs.h"
 
-#define DBG(_mcp, fmt, arg...) \
-	mcp_debug(_mcp, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+#define DBG_MCP(mcp, fmt, ...) \
+	mcp_debug(mcp, "%s:%s() mcp %p | " fmt, __FILE__, __func__, mcp, \
+								##__VA_ARGS__)
+#define DBG_SVC(service, fmt, ...) \
+	mcp_debug(service->mcp, "%s:%s() svc %p | " fmt, __FILE__, __func__, \
+							service, ##__VA_ARGS__)
+#define DBG_MCS(mcs, fmt, ...) \
+	mcs_debug(mcs, "%s:%s() mcs %p | " fmt, __FILE__, __func__, mcs, \
+								##__VA_ARGS__)
 
-struct bt_mcp_db {
-	struct gatt_db *db;
-	struct bt_mcs *mcs;
-};
+#define MAX_ATTR	32
+#define MAX_PENDING	256
 
-struct bt_mcp_pending {
-	unsigned int id;
-	struct bt_mcp *mcp;
-	bt_gatt_client_read_callback_t func;
-	void *user_data;
-};
+struct bt_mcs_db {
+	bool gmcs;
+	int ccid_value;
+	uint32_t media_cp_op_supported_value;
+	uint16_t playing_order_supported_value;
 
-struct event_callback {
-	const struct bt_mcp_event_callback *cbs;
-	void *user_data;
-};
-
-struct bt_mcp_session_info {
-	uint8_t content_control_id;
-	uint32_t cp_op_supported;
-};
-
-struct bt_mcp {
-	int ref_count;
-	struct bt_gatt_client *client;
-	struct bt_mcp_db *ldb;
-	struct bt_mcp_db *rdb;
-	unsigned int mp_name_id;
-	unsigned int track_changed_id;
-	unsigned int track_title_id;
-	unsigned int track_duration_id;
-	unsigned int track_position_id;
-	unsigned int media_state_id;
-	unsigned int media_cp_id;
-	unsigned int media_cp_op_supported_id;
-
-	struct bt_mcp_session_info session;
-	struct event_callback *cb;
-
-	struct queue *pending;
-
-	bt_mcp_debug_func_t debug_func;
-	bt_mcp_destroy_func_t debug_destroy;
-	void *debug_data;
-	void *user_data;
-};
-
-struct bt_mcs {
-	struct bt_mcp_db *mdb;
 	struct gatt_db_attribute *service;
-	struct gatt_db_attribute *mp_name;
+	struct gatt_db_attribute *media_player_name;
+	struct gatt_db_attribute *media_player_name_ccc;
 	struct gatt_db_attribute *track_changed;
 	struct gatt_db_attribute *track_changed_ccc;
 	struct gatt_db_attribute *track_title;
+	struct gatt_db_attribute *track_title_ccc;
 	struct gatt_db_attribute *track_duration;
+	struct gatt_db_attribute *track_duration_ccc;
 	struct gatt_db_attribute *track_position;
+	struct gatt_db_attribute *track_position_ccc;
 	struct gatt_db_attribute *playback_speed;
+	struct gatt_db_attribute *playback_speed_ccc;
 	struct gatt_db_attribute *seeking_speed;
-	struct gatt_db_attribute *play_order;
-	struct gatt_db_attribute *play_order_supported;
+	struct gatt_db_attribute *seeking_speed_ccc;
+	struct gatt_db_attribute *playing_order;
+	struct gatt_db_attribute *playing_order_ccc;
+	struct gatt_db_attribute *playing_order_supported;
 	struct gatt_db_attribute *media_state;
 	struct gatt_db_attribute *media_state_ccc;
 	struct gatt_db_attribute *media_cp;
 	struct gatt_db_attribute *media_cp_ccc;
-	struct gatt_db_attribute *media_cp_op_supportd;
-	struct gatt_db_attribute *content_control_id;
-	struct gatt_db_attribute *content_control_id_ccc;
+	struct gatt_db_attribute *media_cp_op_supported;
+	struct gatt_db_attribute *media_cp_op_supported_ccc;
+	struct gatt_db_attribute *ccid;
 };
 
-static struct queue *mcp_db;
+struct bt_mcs_client {
+	struct bt_att *att;
+
+	/* Per-client state.
+	 *
+	 * Concurrency is not specified in MCS v1.0.1, everything currently
+	 * implemented seems OK to be in global state.
+	 *
+	 * TODO: Search Results ID likely should go here
+	 */
+};
+
+struct bt_mcs {
+	struct gatt_db *db;
+	struct bt_mcs_db ldb;
+	struct queue *clients;
+
+	uint8_t media_state;
+
+	const struct bt_mcs_callback *cb;
+	void *user_data;
+};
+
+struct bt_mcp_listener {
+	const struct bt_mcp_listener_callback *cb;
+	void *user_data;
+};
+
+struct bt_mcp_service {
+	struct bt_mcp *mcp;
+	struct bt_mcs_db rdb;
+
+	bool ready;
+
+	unsigned int notify_id[MAX_ATTR];
+	unsigned int notify_id_count;
+
+	unsigned int pending_id;
+
+	struct queue *pending;
+	struct queue *listeners;
+};
+
+struct bt_mcp_pending {
+	struct bt_mcp_service *service;
+	unsigned int id;
+	uint8_t op;
+	struct {
+		unsigned int client_id;
+		struct gatt_db_attribute *attrib;
+		uint8_t result;
+	} write;
+};
+
+struct bt_mcp {
+	bool gmcs;
+	struct bt_gatt_client *client;
+	unsigned int idle_id;
+	unsigned int db_id;
+	bool ready;
+
+	struct queue *services;
+
+	const struct bt_mcp_callback *cb;
+	void *user_data;
+};
+
+#define MCS_COMMAND(name_, op_, arg_, end_state_) \
+	{ \
+		.name = name_, \
+		.op = BT_MCS_CMD_ ## op_, \
+		.support = BT_MCS_CMD_ ## op_ ## _SUPPORTED, \
+		.int32_arg = arg_, \
+		.end_state = end_state_, \
+	}
+
+#define ANY_STATE	-1
+
+static const struct mcs_command {
+	const char *name;
+	uint8_t op;
+	uint32_t support;
+	bool int32_arg;
+	int end_state;
+} mcs_command[] = {
+	MCS_COMMAND("Play", PLAY, false, BT_MCS_STATE_PLAYING),
+	MCS_COMMAND("Pause", PAUSE, false, BT_MCS_STATE_PAUSED),
+	MCS_COMMAND("Fast Rewind", FAST_REWIND, false, BT_MCS_STATE_SEEKING),
+	MCS_COMMAND("Fast Forward", FAST_FORWARD, false, BT_MCS_STATE_SEEKING),
+	MCS_COMMAND("Stop", STOP, false, BT_MCS_STATE_PAUSED),
+	MCS_COMMAND("Move Relative", MOVE_RELATIVE, true, ANY_STATE),
+	MCS_COMMAND("Prev Segment", PREV_SEGMENT, false, ANY_STATE),
+	MCS_COMMAND("Next Segment", NEXT_SEGMENT, false, ANY_STATE),
+	MCS_COMMAND("First Segment", FIRST_SEGMENT, false, ANY_STATE),
+	MCS_COMMAND("Last Segment", LAST_SEGMENT, false, ANY_STATE),
+	MCS_COMMAND("Goto Segment", GOTO_SEGMENT, true, ANY_STATE),
+	MCS_COMMAND("Prev Track", PREV_TRACK, false, ANY_STATE),
+	MCS_COMMAND("Next Track", NEXT_TRACK, false, ANY_STATE),
+	MCS_COMMAND("First Track", FIRST_TRACK, false, ANY_STATE),
+	MCS_COMMAND("Last Track", LAST_TRACK, false, ANY_STATE),
+	MCS_COMMAND("Goto Track", GOTO_TRACK, true, ANY_STATE),
+	MCS_COMMAND("Prev Group", PREV_GROUP, false, ANY_STATE),
+	MCS_COMMAND("Next Group", NEXT_GROUP, false, ANY_STATE),
+	MCS_COMMAND("First Group", FIRST_GROUP, false, ANY_STATE),
+	MCS_COMMAND("Last Group", LAST_GROUP, false, ANY_STATE),
+	MCS_COMMAND("Goto Group", GOTO_GROUP, true, ANY_STATE),
+};
+
+#define MCS_PLAYING_ORDER(name) \
+	{ BT_MCS_ORDER_ ## name, BT_MCS_ORDER_SUPPORTED_ ## name }
+
+static const struct {
+	uint8_t order;
+	uint16_t support;
+} mcs_playing_orders[] = {
+	MCS_PLAYING_ORDER(SINGLE_ONCE),
+	MCS_PLAYING_ORDER(SINGLE_REPEAT),
+	MCS_PLAYING_ORDER(IN_ORDER_ONCE),
+	MCS_PLAYING_ORDER(IN_ORDER_REPEAT),
+	MCS_PLAYING_ORDER(OLDEST_ONCE),
+	MCS_PLAYING_ORDER(OLDEST_REPEAT),
+	MCS_PLAYING_ORDER(NEWEST_ONCE),
+	MCS_PLAYING_ORDER(NEWEST_REPEAT),
+	MCS_PLAYING_ORDER(SHUFFLE_ONCE),
+	MCS_PLAYING_ORDER(SHUFFLE_REPEAT)
+};
+
+typedef bool (*mcs_command_func_t)(void *data);
+typedef bool (*mcs_command_func_int32_t)(void *data, int32_t offset);
+typedef void (*mcs_get_func_t)(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size);
+typedef bool (*mcs_set_func_t)(struct bt_mcs *mcs, void *data);
+
+static struct queue *servers;
+static uint8_t servers_ccid;
+
+
+/*
+ * MCS Server
+ */
+
+static void mcs_debug_func(const char *str, void *user_data)
+{
+	struct bt_mcs *mcs = user_data;
+
+	mcs->cb->debug(mcs->user_data, str);
+}
+
+static void mcs_debug(struct bt_mcs *mcs, const char *format, ...)
+{
+	va_list ap;
+
+	if (!mcs || !format || !mcs->cb->debug)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(mcs_debug_func, mcs, format, ap);
+	va_end(ap);
+}
+
+static const struct mcs_command *mcs_get_command(uint8_t op)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(mcs_command); ++i)
+		if (mcs_command[i].op == op)
+			return &mcs_command[i];
+
+	return NULL;
+}
+
+static mcs_command_func_t mcs_get_handler(struct bt_mcs *mcs, uint8_t op)
+
+{
+	switch (op) {
+	case BT_MCS_CMD_PLAY: return mcs->cb->play;
+	case BT_MCS_CMD_PAUSE: return mcs->cb->pause;
+	case BT_MCS_CMD_FAST_REWIND: return mcs->cb->fast_rewind;
+	case BT_MCS_CMD_FAST_FORWARD: return mcs->cb->fast_forward;
+	case BT_MCS_CMD_STOP: return mcs->cb->stop;
+	case BT_MCS_CMD_PREV_SEGMENT: return mcs->cb->previous_segment;
+	case BT_MCS_CMD_NEXT_SEGMENT: return mcs->cb->next_segment;
+	case BT_MCS_CMD_FIRST_SEGMENT: return mcs->cb->first_segment;
+	case BT_MCS_CMD_LAST_SEGMENT: return mcs->cb->last_segment;
+	case BT_MCS_CMD_PREV_TRACK: return mcs->cb->previous_track;
+	case BT_MCS_CMD_NEXT_TRACK: return mcs->cb->next_track;
+	case BT_MCS_CMD_FIRST_TRACK: return mcs->cb->first_track;
+	case BT_MCS_CMD_LAST_TRACK: return mcs->cb->last_track;
+	case BT_MCS_CMD_PREV_GROUP: return mcs->cb->previous_group;
+	case BT_MCS_CMD_NEXT_GROUP: return mcs->cb->next_group;
+	case BT_MCS_CMD_FIRST_GROUP: return mcs->cb->first_group;
+	case BT_MCS_CMD_LAST_GROUP: return mcs->cb->last_group;
+	}
+	return NULL;
+}
+
+static mcs_command_func_int32_t mcs_get_handler_int32(struct bt_mcs *mcs,
+								uint8_t op)
+
+{
+	switch (op) {
+	case BT_MCS_CMD_MOVE_RELATIVE: return mcs->cb->move_relative;
+	case BT_MCS_CMD_GOTO_SEGMENT: return mcs->cb->goto_segment;
+	case BT_MCS_CMD_GOTO_TRACK: return mcs->cb->goto_track;
+	case BT_MCS_CMD_GOTO_GROUP: return mcs->cb->goto_group;
+	}
+	return NULL;
+}
+
+static uint32_t mcs_get_supported(struct bt_mcs *mcs)
+{
+	unsigned int i;
+	uint32_t value = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mcs_command); ++i)
+		value |= mcs_command[i].support;
+
+	if (mcs->cb->media_cp_op_supported)
+		value = mcs->cb->media_cp_op_supported(mcs->user_data);
+
+	for (i = 0; i < ARRAY_SIZE(mcs_command); ++i) {
+		void *handler = mcs_get_handler(mcs, mcs_command[i].op);
+
+		if (!handler)
+			handler = mcs_get_handler_int32(mcs, mcs_command[i].op);
+		if (!handler)
+			value &= ~mcs_command[i].support;
+	}
+
+	mcs->ldb.media_cp_op_supported_value = value;
+	return value;
+}
+
+static void write_media_cp(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *data, size_t len,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_mcs *mcs = user_data;
+	struct iovec iov = { .iov_base = (void *)data, .iov_len = len };
+	const struct mcs_command *cmd;
+	struct bt_mcs_cp_rsp rsp = {
+		.op = 0,
+		.result = BT_MCS_RESULT_COMMAND_CANNOT_COMPLETE
+	};
+	int ret = 0;
+	int32_t arg = 0;
+	uint8_t op;
+	bool ok = false;
+
+	if (offset) {
+		ret = BT_ATT_ERROR_INVALID_OFFSET;
+		goto respond;
+	}
+
+	if (!util_iov_pull_u8(&iov, &op)) {
+		ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto respond;
+	}
+
+	rsp.op = op;
+
+	cmd = mcs_get_command(op);
+	if (!cmd || !(cmd->support & mcs_get_supported(mcs))) {
+		rsp.result = BT_MCS_RESULT_OP_NOT_SUPPORTED;
+		goto respond;
+	}
+
+	DBG_MCS(mcs, "Command %s", cmd->name);
+
+	/* We may attempt to perform the operation also if inactive (MCS v1.0.1
+	 * p. 26), leave decision to upper layer. Upper layer shall emit
+	 * appropriate Media State change event if command successful.
+	 */
+
+	ok = cmd->int32_arg ?
+		mcs_get_handler_int32(mcs, op)(mcs->user_data, arg) :
+		mcs_get_handler(mcs, op)(mcs->user_data);
+	if (ok)
+		rsp.result = BT_MCS_RESULT_SUCCESS;
+	else if (mcs->media_state == BT_MCS_STATE_INACTIVE)
+		rsp.result = BT_MCS_RESULT_MEDIA_PLAYER_INACTIVE;
+	else
+		rsp.result = BT_MCS_RESULT_COMMAND_CANNOT_COMPLETE;
+
+respond:
+	DBG_MCS(mcs, "%s ret %u result %u", cmd->name, ret, rsp.result);
+
+	gatt_db_attribute_write_result(attrib, id, ret);
+	if (!rsp.op)
+		return;
+
+	/* Make state transition immediately if command was successful and has
+	 * specified end state. Upper layer shall emit spontaneous transitions
+	 * to correct as needed.
+	 */
+	if (ok) {
+		bt_mcs_set_media_state(mcs, cmd->end_state);
+
+		switch (op) {
+		case BT_MCS_CMD_STOP:
+		case BT_MCS_CMD_PREV_TRACK:
+		case BT_MCS_CMD_NEXT_TRACK:
+		case BT_MCS_CMD_FIRST_TRACK:
+		case BT_MCS_CMD_LAST_TRACK:
+		case BT_MCS_CMD_GOTO_TRACK:
+		case BT_MCS_CMD_PREV_GROUP:
+		case BT_MCS_CMD_NEXT_GROUP:
+		case BT_MCS_CMD_FIRST_GROUP:
+		case BT_MCS_CMD_LAST_GROUP:
+		case BT_MCS_CMD_GOTO_GROUP:
+			if (mcs->cb->set_track_position)
+				mcs->cb->set_track_position(mcs->user_data, 0);
+			bt_mcs_changed(mcs, MCS_TRACK_POSITION_CHRC_UUID);
+			break;
+		}
+	}
+
+	gatt_db_attribute_notify(attrib, (uint8_t *)&rsp, sizeof(rsp), att);
+}
+
+void bt_mcs_set_media_state(struct bt_mcs *mcs, uint8_t state)
+{
+	switch (state) {
+	case BT_MCS_STATE_INACTIVE:
+	case BT_MCS_STATE_PLAYING:
+	case BT_MCS_STATE_PAUSED:
+	case BT_MCS_STATE_SEEKING:
+		break;
+	default:
+		return;
+	}
+
+	if (state == mcs->media_state)
+		return;
+
+	mcs->media_state = state;
+	bt_mcs_changed(mcs, MCS_MEDIA_STATE_CHRC_UUID);
+}
+
+uint8_t bt_mcs_get_media_state(struct bt_mcs *mcs)
+{
+	return mcs->media_state;
+}
+
+static void get_media_player_name(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	if (mcs->cb->media_player_name)
+		mcs->cb->media_player_name(mcs->user_data, buf, size);
+}
+
+static void get_track_changed(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+}
+
+static void get_track_title(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	if (mcs->cb->track_title)
+		mcs->cb->track_title(mcs->user_data, buf, size);
+}
+
+static void get_track_duration(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	int32_t value = BT_MCS_DURATION_UNAVAILABLE;
+
+	if (mcs->cb->track_duration)
+		value = mcs->cb->track_duration(mcs->user_data);
+
+	util_iov_push_le32(buf, (uint32_t)value);
+}
+
+static void get_track_position(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	int32_t value = BT_MCS_POSITION_UNAVAILABLE;
+
+	if (mcs->cb->track_position)
+		value = mcs->cb->track_position(mcs->user_data);
+
+	util_iov_push_le32(buf, (uint32_t)value);
+}
+
+static void get_playback_speed(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	int8_t value = 0x00;
+
+	if (mcs->cb->playback_speed)
+		value = mcs->cb->playback_speed(mcs->user_data);
+
+	util_iov_push_u8(buf, (uint8_t)value);
+}
+
+static void get_seeking_speed(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	int8_t value = 0x00;
+
+	if (mcs->cb->seeking_speed)
+		value = mcs->cb->seeking_speed(mcs->user_data);
+
+	util_iov_push_u8(buf, (uint8_t)value);
+}
+
+static void get_playing_order(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	uint8_t value = BT_MCS_ORDER_IN_ORDER_REPEAT;
+
+	if (mcs->cb->playing_order)
+		value = mcs->cb->playing_order(mcs->user_data);
+
+	util_iov_push_u8(buf, value);
+}
+
+static void get_playing_order_supported(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	uint16_t value = BT_MCS_ORDER_SUPPORTED_IN_ORDER_REPEAT;
+
+	if (mcs->cb->playing_order_supported)
+		value = mcs->cb->playing_order_supported(mcs->user_data);
+
+	util_iov_push_le16(buf, value);
+}
+
+static void get_media_state(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	util_iov_push_u8(buf, mcs->media_state);
+}
+
+static void get_media_cp_op_supported(struct bt_mcs *mcs, struct iovec *buf,
+								size_t size)
+{
+	uint32_t value = mcs_get_supported(mcs);
+
+	if (mcs->cb->media_cp_op_supported)
+		value = mcs->cb->media_cp_op_supported(mcs->user_data);
+
+	mcs->ldb.media_cp_op_supported_value = value;
+
+	util_iov_push_le32(buf, mcs_get_supported(mcs));
+}
+
+static void get_ccid(struct bt_mcs *mcs, struct iovec *buf, size_t size)
+{
+	util_iov_push_u8(buf, mcs->ldb.ccid_value);
+}
+
+static bool set_track_position(struct bt_mcs *mcs, void *data)
+{
+	int32_t value = (int32_t)get_le32(data);
+
+	DBG_MCS(mcs, "Set Track Position %d", value);
+
+	if (mcs->cb->set_track_position)
+		return mcs->cb->set_track_position(mcs->user_data, value);
+	return false;
+}
+
+static bool set_playback_speed(struct bt_mcs *mcs, void *data)
+{
+	int8_t value = (int8_t)get_u8(data);
+
+	DBG_MCS(mcs, "Set Playback Speed %d", value);
+
+	if (mcs->cb->set_playback_speed)
+		return mcs->cb->set_playback_speed(mcs->user_data, value);
+	return false;
+}
+
+static bool set_playing_order(struct bt_mcs *mcs, void *data)
+{
+	uint8_t value = get_u8(data);
+
+	DBG_MCS(mcs, "Set Playing Order %u", value);
+
+	if (mcs->cb->set_playing_order)
+		return mcs->cb->set_playing_order(mcs->user_data, value);
+	return false;
+}
+
+static void read_result(struct bt_mcs *mcs, struct gatt_db_attribute *attrib,
+			unsigned int id, uint16_t offset, mcs_get_func_t get)
+{
+	uint8_t buf[BT_ATT_MAX_VALUE_LEN];
+	struct iovec iov = { .iov_base = buf, .iov_len = 0 };
+
+	get(mcs, &iov, sizeof(buf));
+
+	if (offset > iov.iov_len) {
+		gatt_db_attribute_read_result(attrib, id,
+					BT_ATT_ERROR_INVALID_OFFSET, NULL, 0);
+		return;
+	}
+
+	gatt_db_attribute_read_result(attrib, id, 0, buf + offset,
+							iov.iov_len - offset);
+}
+
+#define READ_FUNC(name) \
+	static void read_ ## name(struct gatt_db_attribute *attrib, \
+				unsigned int id, uint16_t offset, \
+				uint8_t opcode, struct bt_att *att, \
+				void *user_data) \
+	{ \
+		DBG_MCS(user_data, ""); \
+		read_result(user_data, attrib, id, offset, get_ ##name); \
+	}
+
+READ_FUNC(media_player_name)
+READ_FUNC(track_title)
+READ_FUNC(track_duration)
+READ_FUNC(track_position)
+READ_FUNC(playback_speed)
+READ_FUNC(seeking_speed)
+READ_FUNC(playing_order)
+READ_FUNC(playing_order_supported)
+READ_FUNC(media_state)
+READ_FUNC(media_cp_op_supported)
+READ_FUNC(ccid)
+
+static void write_result(struct bt_mcs *mcs,
+				struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *data, size_t len,
+				mcs_get_func_t get, mcs_set_func_t set)
+{
+	uint8_t buf[4];
+	struct iovec iov = { .iov_base = buf, .iov_len = 0 };
+	bt_uuid_t uuid;
+	uint8_t ret;
+
+	get(mcs, &iov, sizeof(buf));
+
+	if (len > iov.iov_len) {
+		gatt_db_attribute_write_result(attrib, id,
+				BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
+		return;
+	}
+
+	if (offset + len > iov.iov_len) {
+		gatt_db_attribute_write_result(attrib, id,
+				BT_ATT_ERROR_INVALID_OFFSET);
+		return;
+	}
+
+	memcpy(iov.iov_base + offset, data, len);
+
+	if (set(mcs, iov.iov_base))
+		ret = 0;
+	else
+		ret = BT_ATT_ERROR_VALUE_NOT_ALLOWED;
+
+	gatt_db_attribute_write_result(attrib, id, ret);
+
+	if (!gatt_db_attribute_get_char_data(attrib, NULL, NULL, NULL, NULL,
+									&uuid))
+		return;
+	if (!ret)
+		bt_mcs_changed(mcs, uuid.value.u16);
+}
+
+#define WRITE_FUNC(name) \
+	static void write_ ## name(struct gatt_db_attribute *attrib, \
+				unsigned int id, uint16_t offset, \
+				const uint8_t *data, size_t len, \
+				uint8_t opcode, struct bt_att *att, \
+				void *user_data) \
+	{ write_result(user_data, attrib, id, offset, data, len, \
+						get_ ## name, set_ ## name); }
+
+WRITE_FUNC(track_position)
+WRITE_FUNC(playback_speed)
+WRITE_FUNC(playing_order)
+
+void bt_mcs_changed(struct bt_mcs *mcs, uint16_t chrc_uuid)
+{
+	struct {
+		struct gatt_db_attribute *attr;
+		mcs_get_func_t get;
+	} attrs[] = {
+		{ mcs->ldb.media_player_name, get_media_player_name },
+		{ mcs->ldb.track_changed, get_track_changed },
+		{ mcs->ldb.track_title, get_track_title },
+		{ mcs->ldb.track_duration, get_track_duration },
+		{ mcs->ldb.track_position, get_track_position },
+		{ mcs->ldb.playback_speed, get_playback_speed },
+		{ mcs->ldb.seeking_speed, get_seeking_speed },
+		{ mcs->ldb.playing_order, get_playing_order },
+		{ mcs->ldb.media_state, get_media_state },
+		{ mcs->ldb.media_cp_op_supported, get_media_cp_op_supported },
+	};
+	uint8_t buf[BT_ATT_MAX_VALUE_LEN];
+	struct iovec iov = { .iov_base = buf, .iov_len = 0 };
+	unsigned int i;
+	bt_uuid_t uuid, uuid_attr;
+	uint8_t props;
+
+	bt_uuid16_create(&uuid, chrc_uuid);
+
+	for (i = 0; i < ARRAY_SIZE(attrs); ++i) {
+		if (!gatt_db_attribute_get_char_data(attrs[i].attr, NULL,
+						NULL, &props, NULL, &uuid_attr))
+			continue;
+		if (bt_uuid_cmp(&uuid_attr, &uuid))
+			continue;
+
+		DBG_MCS(mcs, "Notify %u", chrc_uuid);
+
+		attrs[i].get(mcs, &iov, sizeof(buf));
+
+		/* No client-specific state: notify everyone */
+		gatt_db_attribute_notify(attrs[i].attr, iov.iov_base,
+							iov.iov_len, NULL);
+		break;
+	}
+}
+
+static bool mcs_init_db(struct bt_mcs *mcs, bool is_gmcs)
+{
+	struct gatt_db *db = mcs->db;
+	struct bt_mcs_db *ldb = &mcs->ldb;
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, is_gmcs ? GMCS_UUID : MCS_UUID);
+	ldb->service = gatt_db_add_service(db, &uuid, true, 38);
+
+	/* Add also optional CCC */
+
+	bt_uuid16_create(&uuid, MCS_MEDIA_PLAYER_NAME_CHRC_UUID);
+	ldb->media_player_name = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
+		read_media_player_name, NULL, mcs);
+
+	ldb->media_player_name_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_TRACK_CHANGED_CHRC_UUID);
+	ldb->track_changed = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_NONE, BT_GATT_CHRC_PROP_NOTIFY,
+		NULL, NULL, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->track_changed, 0);
+
+	ldb->track_changed_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_TRACK_TITLE_CHRC_UUID);
+	ldb->track_title = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
+		read_track_title, NULL, mcs);
+
+	ldb->track_title_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_TRACK_DURATION_CHRC_UUID);
+	ldb->track_duration = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
+		read_track_duration, NULL, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->track_duration,
+							sizeof(int32_t));
+
+	ldb->track_duration_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_TRACK_POSITION_CHRC_UUID);
+	ldb->track_position = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY |
+		BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
+		read_track_position, write_track_position, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->track_position,
+							sizeof(int32_t));
+
+	ldb->track_position_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_PLAYBACK_SPEED_CHRC_UUID);
+	ldb->playback_speed = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY |
+		BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
+		read_playback_speed, write_playback_speed, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->playback_speed, sizeof(int8_t));
+
+	ldb->playback_speed_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_SEEKING_SPEED_CHRC_UUID);
+	ldb->seeking_speed = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
+		read_seeking_speed, NULL, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->seeking_speed, sizeof(int8_t));
+
+	ldb->seeking_speed_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_PLAYING_ORDER_CHRC_UUID);
+	ldb->playing_order = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY |
+		BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
+		read_playing_order, write_playing_order, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->playing_order, sizeof(uint8_t));
+
+	ldb->playing_order_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_PLAYING_ORDER_SUPPORTED_CHRC_UUID);
+	ldb->playing_order_supported = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
+		read_playing_order_supported, NULL, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->playing_order_supported,
+							sizeof(uint16_t));
+
+	bt_uuid16_create(&uuid, MCS_MEDIA_STATE_CHRC_UUID);
+	ldb->media_state = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
+		read_media_state, NULL, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->media_state, sizeof(uint8_t));
+
+	ldb->media_state_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_MEDIA_CP_CHRC_UUID);
+	ldb->media_cp = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_WRITE,
+		BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_NOTIFY |
+					BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
+		NULL, write_media_cp, mcs);
+
+	ldb->media_cp_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_MEDIA_CP_OP_SUPPORTED_CHRC_UUID);
+	ldb->media_cp_op_supported = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ,
+		BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
+		read_media_cp_op_supported, NULL, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->media_cp_op_supported,
+							sizeof(uint32_t));
+
+	ldb->media_cp_op_supported_ccc = gatt_db_service_add_ccc(
+		ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, MCS_CCID_CHRC_UUID);
+	ldb->ccid = gatt_db_service_add_characteristic(
+		ldb->service, &uuid,
+		BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
+		read_ccid, NULL, mcs);
+	gatt_db_attribute_set_fixed_length(ldb->ccid, sizeof(uint8_t));
+
+	return true;
+}
+
+uint8_t bt_mcs_get_ccid(struct bt_mcs *mcs)
+{
+	return mcs->ldb.ccid_value;
+}
+
+struct match_mcs_data {
+	struct gatt_db *db;
+	bool gmcs;
+	bool any;
+	int ccid;
+};
+
+static bool match_mcs(const void *data, const void *user_data)
+{
+	const struct bt_mcs *mcs = data;
+	const struct match_mcs_data *match = user_data;
+
+	if (match->db != mcs->db)
+		return false;
+	if (match->gmcs)
+		return mcs->ldb.gmcs;
+	if (match->any)
+		return true;
+	return match->ccid == mcs->ldb.ccid_value;
+}
+
+static int mcs_alloc_ccid(struct gatt_db *db)
+{
+	unsigned int ccid;
+
+	if (!db)
+		return 0;
+
+	for (ccid = servers_ccid; ccid < servers_ccid + 0x100u; ccid++) {
+		struct match_mcs_data match = { .db = db, .ccid = ccid & 0xff };
+
+		if (!queue_find(servers, match_mcs, &match)) {
+			servers_ccid = ccid + 1;
+			return match.ccid;
+		}
+	}
+
+	return -ENOENT;
+}
+
+void bt_mcs_test_util_reset_ccid(void)
+{
+	servers_ccid = 0;
+}
+
+struct bt_mcs *bt_mcs_register(struct gatt_db *db, bool is_gmcs,
+			const struct bt_mcs_callback *cb, void *user_data)
+{
+	struct bt_mcs *mcs;
+	int ccid;
+
+	if (!db || !cb)
+		return NULL;
+
+	if (is_gmcs) {
+		struct match_mcs_data match = { .db = db, .gmcs = true };
+
+		/* Only one GMCS possible */
+		if (queue_find(servers, match_mcs, &match))
+			return NULL;
+	}
+
+	ccid = mcs_alloc_ccid(db);
+	if (ccid < 0)
+		return NULL;
+
+	mcs = new0(struct bt_mcs, 1);
+	mcs->db = db;
+	mcs->ldb.ccid_value = ccid;
+	mcs->cb = cb;
+	mcs->user_data = user_data;
+
+	mcs->media_state = BT_MCS_STATE_INACTIVE;
+
+	if (!mcs_init_db(mcs, is_gmcs)) {
+		free(mcs);
+		return NULL;
+	}
+
+	gatt_db_ref(mcs->db);
+
+	if (!servers)
+		servers = queue_new();
+	queue_push_tail(servers, mcs);
+
+	gatt_db_service_set_active(mcs->ldb.service, true);
+	return mcs;
+}
+
+void bt_mcs_unregister(struct bt_mcs *mcs)
+{
+	if (!mcs)
+		return;
+
+	if (mcs->cb->destroy)
+		mcs->cb->destroy(mcs->user_data);
+
+	queue_remove(servers, mcs);
+
+	gatt_db_remove_service(mcs->db, mcs->ldb.service);
+	gatt_db_unref(mcs->db);
+
+	if (queue_isempty(servers)) {
+		queue_destroy(servers, NULL);
+		servers = NULL;
+	}
+
+	free(mcs);
+}
+
+void bt_mcs_unregister_all(struct gatt_db *db)
+{
+	struct bt_mcs *mcs;
+
+	do {
+		struct match_mcs_data match = { .db = db, .any = true };
+
+		mcs = queue_find(servers, match_mcs, &match);
+		bt_mcs_unregister(mcs);
+	} while (mcs);
+}
+
+/*
+ * MCP Client
+ */
+
+static void mcp_service_reread(struct bt_mcp_service *service,
+					struct gatt_db_attribute *attrib);
+
+static void mcp_debug_func(const char *str, void *user_data)
+{
+	struct bt_mcp *mcp = user_data;
+
+	mcp->cb->debug(mcp->user_data, str);
+}
 
 static void mcp_debug(struct bt_mcp *mcp, const char *format, ...)
 {
 	va_list ap;
 
-	if (!mcp || !format || !mcp->debug_func)
+	if (!mcp || !format || !mcp->cb->debug)
 		return;
 
 	va_start(ap, format);
-	util_debug_va(mcp->debug_func, mcp->debug_data, format, ap);
+	util_debug_va(mcp_debug_func, mcp, format, ap);
 	va_end(ap);
 }
 
-static bool mcp_db_match(const void *data, const void *match_data)
+static bool match_ccid(const void *data, const void *user_data)
 {
-	const struct bt_mcp_db *mdb = data;
-	const struct gatt_db *db = match_data;
+	const struct bt_mcp_service *service = data;
 
-	return (mdb->db == db);
+	return service->rdb.ccid_value == (int)PTR_TO_UINT(user_data);
 }
 
-static void mcp_db_free(void *data)
-{
-	struct bt_mcp_db *bdb = data;
-
-	if (!bdb)
-		return;
-
-	gatt_db_unref(bdb->db);
-
-	free(bdb->mcs);
-	free(bdb);
-}
-
-static void mcp_free(void *data)
-{
-	struct bt_mcp *mcp = data;
-
-	DBG(mcp, "");
-
-	bt_mcp_detach(mcp);
-
-	mcp_db_free(mcp->rdb);
-
-	queue_destroy(mcp->pending, NULL);
-
-	free(mcp);
-}
-
-struct bt_mcp *bt_mcp_ref(struct bt_mcp *mcp)
+static struct bt_mcp_service *mcp_service(struct bt_mcp *mcp, uint8_t ccid)
 {
 	if (!mcp)
 		return NULL;
 
-	__sync_fetch_and_add(&mcp->ref_count, 1);
-
-	return mcp;
+	return queue_find(mcp->services, match_ccid, UINT_TO_PTR(ccid));
 }
 
-void bt_mcp_unref(struct bt_mcp *mcp)
+static bool match_pending(const void *data, const void *user_data)
 {
-	if (!mcp)
-		return;
+	const struct bt_mcp_pending *pending = data;
 
-	if (__sync_sub_and_fetch(&mcp->ref_count, 1))
-		return;
-
-	mcp_free(mcp);
+	return pending->id == PTR_TO_UINT(user_data);
 }
 
-bool bt_mcp_set_user_data(struct bt_mcp *mcp, void *user_data)
-{
-	if (!mcp)
-		return false;
-
-	mcp->user_data = user_data;
-
-	return true;
-}
-
-void *bt_mcp_get_user_data(struct bt_mcp *mcp)
-{
-	if (!mcp)
-		return NULL;
-
-	return mcp->user_data;
-}
-
-bool bt_mcp_set_debug(struct bt_mcp *mcp, bt_mcp_debug_func_t func,
-			void *user_data, bt_mcp_destroy_func_t destroy)
-{
-	if (!mcp)
-		return false;
-
-	if (mcp->debug_destroy)
-		mcp->debug_destroy(mcp->debug_data);
-
-	mcp->debug_func = func;
-	mcp->debug_destroy = destroy;
-	mcp->debug_data = user_data;
-
-	return true;
-}
-
-static void mcs_mp_name_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	char mp_name[] = "";
-	struct iovec iov;
-
-	iov.iov_base = mp_name;
-	iov.iov_len = sizeof(mp_name);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_track_title_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	char track_title[] = "";
-	struct iovec iov;
-
-	iov.iov_base = track_title;
-	iov.iov_len = 0;
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_track_duration_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	int32_t track_duration = 0xFFFFFFFF;
-	struct iovec iov;
-
-	iov.iov_base = &track_duration;
-	iov.iov_len = sizeof(track_duration);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_track_position_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	int32_t track_position = 0xFFFFFFFF;
-	struct iovec iov;
-
-	iov.iov_base = &track_position;
-	iov.iov_len = sizeof(track_position);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_track_position_write(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				const uint8_t *value, size_t len,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	gatt_db_attribute_write_result(attrib, id,
-			BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
-}
-
-static void mcs_playback_speed_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	int8_t playback_speed = 0x00;
-	struct iovec iov;
-
-	iov.iov_base = &playback_speed;
-	iov.iov_len = sizeof(playback_speed);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_playback_speed_write(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				const uint8_t *value, size_t len,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	gatt_db_attribute_write_result(attrib, id,
-				BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
-}
-
-static void mcs_seeking_speed_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	int8_t seeking_speed = 0x00;
-	struct iovec iov;
-
-	iov.iov_base = &seeking_speed;
-	iov.iov_len = sizeof(seeking_speed);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_playing_order_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	uint8_t playing_order = 0x01;
-	struct iovec iov;
-
-	iov.iov_base = &playing_order;
-	iov.iov_len = sizeof(playing_order);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_playing_order_write(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				const uint8_t *value, size_t len,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	gatt_db_attribute_write_result(attrib, id,
-				BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
-}
-
-static void mcs_playing_order_supported_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	uint16_t playing_order_supported = 0x01;
-	struct iovec iov;
-
-	iov.iov_base = &playing_order_supported;
-	iov.iov_len = sizeof(playing_order_supported);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_media_state_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	uint8_t media_state = 0x00;
-	struct iovec iov;
-
-	iov.iov_base = &media_state;
-	iov.iov_len = sizeof(media_state);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_media_cp_write(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				const uint8_t *value, size_t len,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	gatt_db_attribute_write_result(attrib, id,
-				BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
-}
-
-static void mcs_media_cp_op_supported_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	uint32_t cp_op_supported = 0x00000000;
-	struct iovec iov;
-
-	iov.iov_base = &cp_op_supported;
-	iov.iov_len = sizeof(cp_op_supported);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static void mcs_media_content_control_id_read(struct gatt_db_attribute *attrib,
-				unsigned int id, uint16_t offset,
-				uint8_t opcode, struct bt_att *att,
-				void *user_data)
-{
-	uint8_t content_control_id = 0x00;
-	struct iovec iov;
-
-	iov.iov_base = &content_control_id;
-	iov.iov_len = sizeof(content_control_id);
-
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
-}
-
-static struct bt_mcs *mcs_new(struct gatt_db *db)
-{
-	struct bt_mcs *mcs;
-	bt_uuid_t uuid;
-
-	if (!db)
-		return NULL;
-
-	mcs = new0(struct bt_mcs, 1);
-
-	/* Populate DB with MCS attributes */
-	bt_uuid16_create(&uuid, GMCS_UUID);
-	mcs->service = gatt_db_add_service(db, &uuid, true, 31);
-
-	bt_uuid16_create(&uuid, MEDIA_PLAYER_NAME_CHRC_UUID);
-	mcs->mp_name = gatt_db_service_add_characteristic(mcs->service, &uuid,
-					BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ,
-					mcs_mp_name_read, NULL,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_TRACK_CHNGD_CHRC_UUID);
-	mcs->track_changed = gatt_db_service_add_characteristic(mcs->service,
-					&uuid,
-					BT_ATT_PERM_NONE,
-					BT_GATT_CHRC_PROP_NOTIFY,
-					NULL, NULL,
-					mcs);
-
-	mcs->track_changed_ccc = gatt_db_service_add_ccc(mcs->service,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
-
-	bt_uuid16_create(&uuid, MEDIA_TRACK_TITLE_CHRC_UUID);
-	mcs->track_title = gatt_db_service_add_characteristic(mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ,
-					mcs_track_title_read, NULL,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_TRACK_DURATION_CHRC_UUID);
-	mcs->track_duration = gatt_db_service_add_characteristic(mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ,
-					mcs_track_duration_read, NULL,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_TRACK_POSTION_CHRC_UUID);
-	mcs->track_position = gatt_db_service_add_characteristic(mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
-					BT_GATT_CHRC_PROP_READ |
-					BT_GATT_CHRC_PROP_WRITE |
-					BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
-					mcs_track_position_read,
-					mcs_track_position_write,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_PLAYBACK_SPEED_CHRC_UUID);
-	mcs->playback_speed = gatt_db_service_add_characteristic(mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
-					BT_GATT_CHRC_PROP_READ |
-					BT_GATT_CHRC_PROP_WRITE |
-					BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
-					mcs_playback_speed_read,
-					mcs_playback_speed_write,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_SEEKING_SPEED_CHRC_UUID);
-	mcs->seeking_speed = gatt_db_service_add_characteristic(mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ,
-					mcs_seeking_speed_read, NULL,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_PLAYING_ORDER_CHRC_UUID);
-	mcs->play_order = gatt_db_service_add_characteristic(mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
-					BT_GATT_CHRC_PROP_READ |
-					BT_GATT_CHRC_PROP_WRITE |
-					BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
-					mcs_playing_order_read,
-					mcs_playing_order_write,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_PLAY_ORDER_SUPPRTD_CHRC_UUID);
-	mcs->play_order_supported = gatt_db_service_add_characteristic(
-					mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ,
-					mcs_playing_order_supported_read, NULL,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_STATE_CHRC_UUID);
-	mcs->media_state = gatt_db_service_add_characteristic(mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ |
-					BT_GATT_CHRC_PROP_NOTIFY,
-					mcs_media_state_read, NULL,
-					mcs);
-
-	mcs->media_state_ccc = gatt_db_service_add_ccc(mcs->service,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
-
-	bt_uuid16_create(&uuid, MEDIA_CP_CHRC_UUID);
-	mcs->media_cp = gatt_db_service_add_characteristic(mcs->service, &uuid,
-					BT_ATT_PERM_WRITE,
-					BT_GATT_CHRC_PROP_WRITE |
-					BT_GATT_CHRC_PROP_NOTIFY |
-					BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
-					NULL, mcs_media_cp_write,
-					mcs);
-
-	mcs->media_cp_ccc = gatt_db_service_add_ccc(mcs->service,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
-
-	bt_uuid16_create(&uuid, MEDIA_CP_OP_SUPPORTED_CHRC_UUID);
-	mcs->media_cp_op_supportd = gatt_db_service_add_characteristic(
-					mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ,
-					mcs_media_cp_op_supported_read, NULL,
-					mcs);
-
-	bt_uuid16_create(&uuid, MEDIA_CONTENT_CONTROL_ID_CHRC_UUID);
-	mcs->content_control_id = gatt_db_service_add_characteristic(
-					mcs->service,
-					&uuid,
-					BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ |
-					BT_GATT_CHRC_PROP_NOTIFY,
-					mcs_media_content_control_id_read,
-					NULL,
-					mcs);
-
-	mcs->content_control_id_ccc = gatt_db_service_add_ccc(mcs->service,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
-
-	gatt_db_service_set_active(mcs->service, false);
-
-	return mcs;
-}
-
-static struct bt_mcs *mcp_get_mcs(struct bt_mcp *mcp)
-{
-	if (!mcp)
-		return NULL;
-
-	if (mcp->rdb->mcs)
-		return mcp->rdb->mcs;
-
-	mcp->rdb->mcs = new0(struct bt_mcs, 1);
-	mcp->rdb->mcs->mdb = mcp->rdb;
-
-	return mcp->rdb->mcs;
-}
-
-static unsigned int mcp_send(struct bt_mcp *mcp, uint8_t operation)
-{
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-	int ret;
-	uint16_t handle;
-
-	DBG(mcp, "mcs %p", mcs);
-
-	if (!mcp->client)
-		return -1;
-
-	if (!gatt_db_attribute_get_char_data(mcs->media_cp, NULL, &handle,
-					NULL, NULL, NULL))
-		return -1;
-
-	ret = bt_gatt_client_write_without_response(mcp->client, handle, false,
-					&operation, sizeof(uint8_t));
-	if (!ret)
-		return -1;
-
-	return 0;
-}
-
-unsigned int bt_mcp_play(struct bt_mcp *mcp)
-{
-	if (!mcp)
-		return 0;
-
-	if (!(mcp->session.cp_op_supported & BT_MCS_CMD_PLAY_SUPPORTED))
-		return -ENOTSUP;
-
-	DBG(mcp, "mcp %p", mcp);
-
-	return mcp_send(mcp, BT_MCS_CMD_PLAY);
-}
-
-unsigned int bt_mcp_pause(struct bt_mcp *mcp)
-{
-	if (!mcp)
-		return 0;
-
-	if (!(mcp->session.cp_op_supported & BT_MCS_CMD_PAUSE_SUPPORTED))
-		return -ENOTSUP;
-
-	DBG(mcp, "mcp %p", mcp);
-
-	return mcp_send(mcp, BT_MCS_CMD_PAUSE);
-}
-
-unsigned int bt_mcp_stop(struct bt_mcp *mcp)
-{
-	if (!mcp)
-		return 0;
-
-	if (!(mcp->session.cp_op_supported & BT_MCS_CMD_STOP_SUPPORTED))
-		return -ENOTSUP;
-
-	DBG(mcp, "mcp %p", mcp);
-
-	return mcp_send(mcp, BT_MCS_CMD_STOP);
-}
-
-unsigned int bt_mcp_next_track(struct bt_mcp *mcp)
-{
-	if (!mcp)
-		return 0;
-
-	if (!(mcp->session.cp_op_supported & BT_MCS_CMD_NEXT_TRACK_SUPPORTED))
-		return -ENOTSUP;
-
-	DBG(mcp, "mcp %p", mcp);
-
-	return mcp_send(mcp, BT_MCS_CMD_NEXT_TRACK);
-}
-
-unsigned int bt_mcp_previous_track(struct bt_mcp *mcp)
-{
-	if (!mcp)
-		return 0;
-
-	if (!(mcp->session.cp_op_supported & BT_MCS_CMD_PREV_TRACK_SUPPORTED))
-		return -ENOTSUP;
-
-	DBG(mcp, "mcp %p", mcp);
-
-	return mcp_send(mcp, BT_MCS_CMD_PREV_TRACK);
-}
-
-static void mcp_mp_set_player_name(struct bt_mcp *mcp, const uint8_t *value,
-					uint16_t length)
-{
-	struct event_callback *cb;
-
-	if (!mcp)
-		return;
-
-	cb = mcp->cb;
-
-	if (cb && cb->cbs && cb->cbs->player_name)
-		cb->cbs->player_name(mcp, value, length);
-}
-
-static void mcp_mp_set_track_title(struct bt_mcp *mcp, const uint8_t *value,
-					uint16_t length)
-{
-	struct event_callback *cb;
-
-	if (!mcp)
-		return;
-
-	cb = mcp->cb;
-
-	if (cb && cb->cbs && cb->cbs->track_title)
-		cb->cbs->track_title(mcp, value, length);
-}
-
-static void mcp_mp_set_title_duration(struct bt_mcp *mcp, int32_t duration)
-{
-	struct event_callback *cb;
-
-	if (!mcp)
-		return;
-
-	cb = mcp->cb;
-
-	DBG(mcp, "Track Duration 0x%08x", duration);
-
-	if (cb && cb->cbs && cb->cbs->track_duration)
-		cb->cbs->track_duration(mcp, duration);
-}
-
-static void mcp_mp_set_title_position(struct bt_mcp *mcp, int32_t position)
-{
-	struct event_callback *cb;
-
-	if (!mcp)
-		return;
-
-	cb = mcp->cb;
-
-	DBG(mcp, "Track Position 0x%08x", position);
-
-	if (cb && cb->cbs && cb->cbs->track_position)
-		cb->cbs->track_position(mcp, position);
-}
-
-static void mcp_mp_set_media_state(struct bt_mcp *mcp, uint8_t state)
-{
-	struct event_callback *cb;
-
-	if (!mcp)
-		return;
-
-	cb = mcp->cb;
-
-	DBG(mcp, "Media State 0x%02x", state);
-
-	if (cb && cb->cbs && cb->cbs->media_state)
-		cb->cbs->media_state(mcp, state);
-}
-
-static void read_media_player_name(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (!success) {
-		DBG(mcp, "Unable to read media player name: error 0x%02x",
-				att_ecode);
-		return;
-	}
-
-	if (!length)
-		return;
-
-	mcp_mp_set_player_name(mcp, value, length);
-}
-
-static void read_track_title(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (!success) {
-		DBG(mcp, "Unable to read track title: error 0x%02x",
-					att_ecode);
-		return;
-	}
-
-	if (!length)
-		return;
-
-	mcp_mp_set_track_title(mcp, value, length);
-}
-
-static void read_track_duration(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-	int32_t duration;
-
-	if (!success) {
-		DBG(mcp, "Unable to read track duration: error 0x%02x",
-					att_ecode);
-		return;
-	}
-
-	if (length != sizeof(duration))
-		DBG(mcp, "Wrong length received Length : %u", length);
-
-	memcpy(&duration, value, length);
-	mcp_mp_set_title_duration(mcp, duration);
-}
-
-static void read_track_position(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-	int32_t position;
-
-	if (!success) {
-		DBG(mcp, "Unable to read track position: error 0x%02x",
-					att_ecode);
-		return;
-	}
-
-	if (length != sizeof(position))
-		DBG(mcp, "Wrong length received Length : %u", length);
-
-	memcpy(&position, value, length);
-	mcp_mp_set_title_position(mcp, position);
-}
-
-static void read_media_state(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (!success) {
-		DBG(mcp, "Unable to read media state: error 0x%02x",
-					att_ecode);
-		return;
-	}
-
-	if (length != sizeof(uint8_t))
-		DBG(mcp, "Wrong length received Length : %u", length);
-
-	mcp_mp_set_media_state(mcp, *value);
-}
-
-static void read_media_cp_op_supported(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (!success) {
-		DBG(mcp, "Unable to read media CP OP supported: error 0x%02x",
-					att_ecode);
-		return;
-	}
-
-	if (length != sizeof(uint32_t))
-		DBG(mcp, "Wrong length received Length : %u", length);
-
-	memcpy(&mcp->session.cp_op_supported, value, sizeof(uint32_t));
-	DBG(mcp, "Media Control Point Opcodes Supported 0x%08x",
-			mcp->session.cp_op_supported);
-}
-
-static void read_content_control_id(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (!success) {
-		DBG(mcp, "Unable to read content control id: error 0x%02x",
-					att_ecode);
-		return;
-	}
-
-	if (length != sizeof(uint8_t))
-		DBG(mcp, "Wrong length received Length : %u", length);
-
-	DBG(mcp, "Content Control ID 0x%02x", *value);
-}
-
-static void mcp_pending_destroy(void *data)
-{
-	struct bt_mcp_pending *pending = data;
-	struct bt_mcp *mcp = pending->mcp;
-
-	queue_remove_if(mcp->pending, NULL, pending);
-}
-
-static void mcp_pending_complete(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_mcp_pending *pending = user_data;
-
-	if (pending->func)
-		pending->func(success, att_ecode, value, length,
-						pending->user_data);
-}
-
-static void mcp_read_value(struct bt_mcp *mcp, uint16_t value_handle,
-				bt_gatt_client_read_callback_t func,
-				void *user_data)
+static struct bt_mcp_pending *mcp_pending_new(struct bt_mcp_service *service)
 {
 	struct bt_mcp_pending *pending;
 
-	pending = new0(struct bt_mcp_pending, 1);
-	pending->mcp = mcp;
-	pending->func = func;
-	pending->user_data = user_data;
+	if (queue_length(service->pending) > MAX_PENDING)
+		return NULL;
 
-	pending->id = bt_gatt_client_read_value(mcp->client, value_handle,
-						mcp_pending_complete, pending,
-						mcp_pending_destroy);
-	if (!pending->id) {
-		DBG(mcp, "Unable to send Read request");
+	while (!service->pending_id || queue_find(service->pending,
+			match_pending, UINT_TO_PTR(service->pending_id)))
+		service->pending_id++;
+
+	pending = new0(struct bt_mcp_pending, 1);
+	pending->service = service;
+	pending->id = service->pending_id++;
+	return pending;
+}
+
+static unsigned int mcp_send(struct bt_mcp_service *service, uint8_t *buf,
+								uint16_t length)
+{
+	struct bt_mcp *mcp = service->mcp;
+	uint16_t handle;
+	struct bt_mcp_pending *pending;
+	int ret;
+	uint8_t op = buf[0];
+
+	if (!gatt_db_attribute_get_char_data(service->rdb.media_cp, NULL,
+						&handle, NULL, NULL, NULL))
+		return 0;
+
+	pending = mcp_pending_new(service);
+	if (!pending)
+		return 0;
+
+	ret = bt_gatt_client_write_without_response(mcp->client,
+						handle, false, buf, length);
+	if (!ret) {
 		free(pending);
+		return 0;
+	}
+
+	pending->op = op;
+	queue_push_tail(service->pending, pending);
+
+	DBG_SVC(service, "%u", pending->id);
+	return pending->id;
+}
+
+static void mcp_pending_write_cb(bool success, uint8_t att_ecode,
+								void *user_data)
+{
+	struct bt_mcp_pending *pending = user_data;
+	uint8_t props;
+
+	if (!success) {
+		pending->write.result = BT_MCS_RESULT_COMMAND_CANNOT_COMPLETE;
 		return;
 	}
 
-	queue_push_tail(mcp->pending, pending);
+	pending->write.result = BT_MCS_RESULT_SUCCESS;
+
+	if (!gatt_db_attribute_get_char_data(pending->write.attrib, NULL,
+						NULL, &props, NULL, NULL))
+		return;
+	if (props & BT_GATT_CHRC_PROP_NOTIFY)
+		return;
+
+	/* If the attribute doesn't have notify, reread to get the new value */
+	mcp_service_reread(pending->service, pending->write.attrib);
 }
 
-static void mcp_mp_name_register(uint16_t att_ecode, void *user_data)
+static void mcp_pending_write_done(void *user_data)
 {
+	struct bt_mcp_pending *pending = user_data;
+	struct bt_mcp_service *service = pending->service;
+	struct bt_mcp *mcp = service->mcp;
+
+	DBG_SVC(service, "write %u", pending->id);
+
+	queue_remove(service->pending, pending);
+
+	if (mcp->cb->complete)
+		mcp->cb->complete(mcp->user_data, pending->id,
+							pending->write.result);
+	free(pending);
+}
+
+static unsigned int mcp_write_chrc(struct bt_mcp_service *service,
+		struct gatt_db_attribute *attrib, void *data, uint16_t length)
+{
+	struct bt_mcp *mcp;
+	struct bt_mcp_pending *pending;
+	uint16_t handle;
+
+	if (!service)
+		return 0;
+
+	mcp = service->mcp;
+
+	if (!gatt_db_attribute_get_char_data(attrib, NULL, &handle, NULL, NULL,
+									NULL))
+		return 0;
+
+	pending = mcp_pending_new(service);
+	if (!pending)
+		return 0;
+
+	pending->write.attrib = attrib;
+	pending->write.client_id = bt_gatt_client_write_value(mcp->client,
+				handle, data, length, mcp_pending_write_cb,
+				pending, mcp_pending_write_done);
+	if (!pending->write.client_id) {
+		free(pending);
+		return 0;
+	}
+
+	queue_push_tail(service->pending, pending);
+	return pending->id;
+}
+
+static bool match_pending_write(const void *data, const void *user_data)
+{
+	const struct bt_mcp_pending *pending = data;
+
+	return !pending->op;
+}
+
+static void mcp_cancel_pending_writes(struct bt_mcp_service *service)
+{
+	struct bt_mcp_pending *pending;
+	struct bt_gatt_client *client = service->mcp->client;
+
+	do {
+		pending = queue_remove_if(service->pending, match_pending_write,
+									NULL);
+		if (pending) {
+			if (!bt_gatt_client_cancel(client,
+						pending->write.client_id))
+				free(pending);
+		}
+	} while (pending);
+}
+
+static unsigned int mcp_command(struct bt_mcp *mcp, uint8_t ccid, uint8_t op,
+								int32_t arg)
+{
+	const struct mcs_command *cmd = mcs_get_command(op);
+	struct bt_mcp_service *service = mcp_service(mcp, ccid);
+	uint8_t buf[5];
+	struct iovec iov = { .iov_base = buf, .iov_len = 0 };
+
+	if (!service || !cmd)
+		return 0;
+
+	if (!(service->rdb.media_cp_op_supported_value & cmd->support))
+		return 0;
+
+	DBG_SVC(service, "%s %d", cmd->name, arg);
+
+	util_iov_push_u8(&iov, op);
+	if (cmd->int32_arg)
+		util_iov_push_le32(&iov, arg);
+
+	return mcp_send(service, iov.iov_base, iov.iov_len);
+}
+
+unsigned int bt_mcp_play(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_PLAY, 0);
+}
+
+unsigned int bt_mcp_pause(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_PAUSE, 0);
+}
+
+unsigned int bt_mcp_fast_rewind(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_FAST_REWIND, 0);
+}
+
+unsigned int bt_mcp_fast_forward(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_FAST_FORWARD, 0);
+}
+
+unsigned int bt_mcp_stop(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_STOP, 0);
+}
+
+unsigned int bt_mcp_move_relative(struct bt_mcp *mcp, uint8_t ccid,
+								int32_t offset)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_MOVE_RELATIVE, offset);
+}
+
+unsigned int bt_mcp_previous_segment(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_PREV_SEGMENT, 0);
+}
+
+unsigned int bt_mcp_next_segment(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_NEXT_SEGMENT, 0);
+}
+
+unsigned int bt_mcp_first_segment(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_FIRST_SEGMENT, 0);
+}
+
+unsigned int bt_mcp_last_segment(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_LAST_SEGMENT, 0);
+}
+
+unsigned int bt_mcp_goto_segment(struct bt_mcp *mcp, uint8_t ccid, int32_t n)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_GOTO_SEGMENT, n);
+}
+
+unsigned int bt_mcp_previous_track(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_PREV_TRACK, 0);
+}
+
+unsigned int bt_mcp_next_track(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_NEXT_TRACK, 0);
+}
+
+unsigned int bt_mcp_first_track(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_FIRST_TRACK, 0);
+}
+
+unsigned int bt_mcp_last_track(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_LAST_TRACK, 0);
+}
+
+unsigned int bt_mcp_goto_track(struct bt_mcp *mcp, uint8_t ccid, int32_t n)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_GOTO_TRACK, n);
+}
+
+unsigned int bt_mcp_previous_group(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_PREV_GROUP, 0);
+}
+
+unsigned int bt_mcp_next_group(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_NEXT_GROUP, 0);
+}
+
+unsigned int bt_mcp_first_group(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_FIRST_GROUP, 0);
+}
+
+unsigned int bt_mcp_last_group(struct bt_mcp *mcp, uint8_t ccid)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_LAST_GROUP, 0);
+}
+
+unsigned int bt_mcp_goto_group(struct bt_mcp *mcp, uint8_t ccid, int32_t n)
+{
+	return mcp_command(mcp, ccid, BT_MCS_CMD_GOTO_GROUP, n);
+}
+
+unsigned int bt_mcp_set_track_position(struct bt_mcp *mcp, uint8_t ccid,
+							int32_t position)
+{
+	struct bt_mcp_service *service = mcp_service(mcp, ccid);
+
+	position = cpu_to_le32(position);
+	return mcp_write_chrc(service, service->rdb.track_position,
+						&position, sizeof(position));
+}
+
+unsigned int bt_mcp_set_playback_speed(struct bt_mcp *mcp, uint8_t ccid,
+								int8_t value)
+{
+	struct bt_mcp_service *service = mcp_service(mcp, ccid);
+
+	return mcp_write_chrc(service, service->rdb.playback_speed,
+							&value, sizeof(value));
+}
+
+unsigned int bt_mcp_set_playing_order(struct bt_mcp *mcp, uint8_t ccid,
+								uint8_t value)
+{
+	struct bt_mcp_service *service = mcp_service(mcp, ccid);
+	uint16_t support = 0;
+	unsigned int i;
+
+	if (!service)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(mcs_playing_orders); ++i) {
+		if (mcs_playing_orders[i].order == value) {
+			support = mcs_playing_orders[i].support;
+			break;
+		}
+	}
+	if (!(service->rdb.playing_order_supported_value & support))
+		return 0;
+
+	return mcp_write_chrc(service, service->rdb.playing_order,
+							&value, sizeof(value));
+}
+
+uint16_t bt_mcp_get_supported_playing_order(struct bt_mcp *mcp, uint8_t ccid)
+{
+	struct bt_mcp_service *service = mcp_service(mcp, ccid);
+
+	if (!service)
+		return 0;
+	return service->rdb.playing_order_supported_value;
+}
+
+uint32_t bt_mcp_get_supported_commands(struct bt_mcp *mcp, uint8_t ccid)
+{
+	struct bt_mcp_service *service = mcp_service(mcp, ccid);
+
+	if (!service)
+		return 0;
+	return service->rdb.media_cp_op_supported_value;
+}
+
+#define LISTENER_CB(service, method, ...) \
+	do { \
+		const struct queue_entry *entry = \
+				queue_get_entries((service)->listeners); \
+		for (; entry; entry = entry->next) { \
+			struct bt_mcp_listener *listener = entry->data; \
+			if (listener->cb->method) \
+				listener->cb->method(listener->user_data, \
+							## __VA_ARGS__); \
+		} \
+	} while (0)
+
+static void update_media_player_name(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+
+	DBG_SVC(service, "Media Player Name");
+
+	LISTENER_CB(service, media_player_name, value, length);
+}
+
+static void update_track_changed(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+
+	if (!success) {
+		DBG_SVC(service, "Unable to read Track Changed: "
+						"error 0x%02x", att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Track Changed");
+
+	LISTENER_CB(service, track_changed);
+}
+
+static void update_track_title(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+
+	if (!success) {
+		DBG_SVC(service, "Unable to read Track Title: error 0x%02x",
+								att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Track Title");
+
+	LISTENER_CB(service, track_title, value, length);
+}
+
+static void update_track_duration(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint32_t v;
+
+	if (!success || !util_iov_pull_le32(&iov, &v)) {
+		DBG_SVC(service, "Unable to read Track Duration: "
+						"error 0x%02x", att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Track Duration: %d", (int32_t)v);
+
+	LISTENER_CB(service, track_duration, (int32_t)v);
+}
+
+static void update_track_position(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint32_t v;
+
+	if (!success || !util_iov_pull_le32(&iov, &v)) {
+		DBG_SVC(service, "Unable to read Track Position: "
+						"error 0x%02x", att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Track Position: %d", (int32_t)v);
+
+	LISTENER_CB(service, track_position, (int32_t)v);
+}
+
+static void update_playback_speed(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint8_t v;
+
+	if (!success || !util_iov_pull_u8(&iov, &v)) {
+		DBG_SVC(service, "Unable to read Playback Speed: "
+						"error 0x%02x", att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Playback Speed: %d", (int8_t)v);
+
+	LISTENER_CB(service, playback_speed, (int8_t)v);
+}
+
+static void update_seeking_speed(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint8_t v;
+
+	if (!success || !util_iov_pull_u8(&iov, &v)) {
+		DBG_SVC(service, "Unable to read Seeking Speed: "
+						"error 0x%02x", att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Seeking Speed: %d", (int8_t)v);
+
+	LISTENER_CB(service, seeking_speed, (int8_t)v);
+}
+
+static void update_playing_order(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint8_t v;
+
+	if (!success || !util_iov_pull_u8(&iov, &v)) {
+		DBG_SVC(service, "Unable to read Playing Order: "
+						"error 0x%02x", att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Playing Order: %u", v);
+
+	LISTENER_CB(service, playing_order, v);
+}
+
+static void update_playing_order_supported(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint16_t v;
+
+	if (!success || !util_iov_pull_le16(&iov, &v)) {
+		DBG_SVC(service, "Unable to read "
+			"Playing Order Supported: error 0x%02x", att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Playing Order Supported: %u", v);
+
+	service->rdb.playing_order_supported_value = v;
+}
+
+static void update_media_state(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint8_t v;
+
+	if (!success || !util_iov_pull_u8(&iov, &v)) {
+		DBG_SVC(service, "Unable to read Media State: error 0x%02x",
+								att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Media State: %u", v);
+
+	LISTENER_CB(service, media_state, v);
+}
+
+static bool match_pending_op(const void *data, const void *user_data)
+{
+	const struct bt_mcp_pending *pending = data;
+
+	return pending->op && pending->op == PTR_TO_UINT(user_data);
+}
+
+static void update_media_cp(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct bt_mcp *mcp = service->mcp;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	struct bt_mcp_pending *pending;
+	uint8_t op, result;
+
+	if (!success || !util_iov_pull_u8(&iov, &op) ||
+					!util_iov_pull_u8(&iov, &result)) {
+		DBG_SVC(service, "Unable to read Media CP: error 0x%02x",
+								att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Media CP %u result %u", op, result);
+
+	pending = queue_remove_if(service->pending, match_pending_op,
+							UINT_TO_PTR(op));
+	if (!pending)
+		return;
+
+	if (mcp->cb->complete)
+		mcp->cb->complete(mcp->user_data, pending->id, result);
+
+	free(pending);
+}
+
+static void update_media_cp_op_supported(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint32_t v;
+
+	if (!success || !util_iov_pull_le32(&iov, &v)) {
+		DBG_SVC(service, "Unable to read "
+			"Media CP Op Supported: error 0x%02x", att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "Media CP Op Supported: %d", v);
+
+	service->rdb.media_cp_op_supported_value = v;
+}
+
+static void update_add_service(void *data, void *user_data)
+{
+	struct bt_mcp_service *service = data;
 	struct bt_mcp *mcp = user_data;
 
-	if (att_ecode)
-		DBG(mcp, "Media Player Name notification failed: 0x%04x",
-					att_ecode);
+	if (service->rdb.ccid_value < 0)
+		return;
+
+	if (service->ready)
+		return;
+
+	service->ready = true;
+	if (mcp->cb->ccid)
+		mcp->cb->ccid(mcp->user_data, service->rdb.ccid_value,
+							service->rdb.gmcs);
 }
 
-static void mcp_mp_name_notify(uint16_t value_handle, const uint8_t *value,
+static void update_ccid(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_mcp_service *service = user_data;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint8_t v;
+
+	if (!success || !util_iov_pull_u8(&iov, &v)) {
+		DBG_SVC(service, "Unable to read Media State: error 0x%02x",
+								att_ecode);
+		return;
+	}
+
+	DBG_SVC(service, "CCID: %u", v);
+
+	service->rdb.ccid_value = v;
+
+	update_add_service(service, service->mcp);
+}
+
+static void mcp_service_reread(struct bt_mcp_service *service,
+					struct gatt_db_attribute *attrib)
+{
+	const struct {
+		struct gatt_db_attribute *attr;
+		bt_gatt_client_read_callback_t cb;
+	} attrs[] = {
+		{ service->rdb.track_title, update_track_title },
+		{ service->rdb.track_duration, update_track_duration },
+		{ service->rdb.track_position, update_track_position },
+		{ service->rdb.playback_speed, update_playback_speed },
+		{ service->rdb.seeking_speed, update_seeking_speed },
+		{ service->rdb.playing_order, update_playing_order },
+		{ service->rdb.playing_order_supported,
+		  update_playing_order_supported },
+		{ service->rdb.media_state, update_media_state },
+		{ service->rdb.media_cp_op_supported,
+		  update_media_cp_op_supported },
+	};
+	struct bt_gatt_client *client = service->mcp->client;
+	uint16_t value_handle;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(attrs); ++i) {
+		if (!attrs[i].attr)
+			continue;
+		if (attrib && attrs[i].attr != attrib)
+			continue;
+
+		if (!gatt_db_attribute_get_char_data(attrs[i].attr, NULL,
+					&value_handle, NULL, NULL, NULL))
+			return;
+
+		DBG_SVC(service, "re-read handle 0x%04x", value_handle);
+
+		bt_gatt_client_read_value(client, value_handle,
+						attrs[i].cb, service, NULL);
+	}
+}
+
+static void notify_media_player_name(struct bt_mcp_service *service)
+{
+	/* On player name change, re-read all attributes */
+	mcp_service_reread(service, NULL);
+}
+
+static void mcp_idle(void *data)
+{
+	struct bt_mcp *mcp = data;
+
+	DBG_MCP(mcp, "");
+
+	mcp->idle_id = 0;
+
+	if (!mcp->ready) {
+		mcp->ready = true;
+		if (mcp->cb->ready)
+			mcp->cb->ready(mcp->user_data);
+	}
+}
+
+struct chrc_notify_data {
+	const char *name;
+	struct bt_mcp_service *service;
+	bt_gatt_client_read_callback_t cb;
+	void (*notify_cb)(struct bt_mcp_service *service);
+};
+
+static void chrc_register(uint16_t att_ecode, void *user_data)
+{
+	struct chrc_notify_data *data = user_data;
+
+	if (att_ecode)
+		DBG_SVC(data->service, "%s notification failed: 0x%04x",
+							data->name, att_ecode);
+}
+
+static void chrc_notify(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
-	struct bt_mcp *mcp = user_data;
+	struct chrc_notify_data *data = user_data;
+	struct bt_mcp_service *service = data->service;
+	struct bt_gatt_client *client = service->mcp->client;
+	uint16_t mtu = bt_gatt_client_get_mtu(client);
 
-	if (!length)
+	DBG_SVC(service, "Notify %s", data->name);
+
+	if (length == mtu - 3) {
+		/* Probably truncated value */
+		DBG_SVC(service, "Read %s", data->name);
+
+		bt_gatt_client_read_value(client, value_handle,
+						data->cb, service, NULL);
 		return;
+	}
 
-	mcp_mp_set_player_name(mcp, value, length);
-}
+	data->cb(true, 0xff, value, length, data->service);
 
-static void mcp_track_changed_register(uint16_t att_ecode, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (att_ecode)
-		DBG(mcp, "Media Track Changed notification failed: 0x%04x",
-					att_ecode);
-}
-
-static void mcp_track_changed_notify(uint16_t value_handle,
-			const uint8_t *value, uint16_t length, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-	struct event_callback *cb = mcp->cb;
-
-	DBG(mcp, "Track Changed");
-
-	if (cb && cb->cbs && cb->cbs->track_changed)
-		cb->cbs->track_changed(mcp);
-}
-
-static void mcp_track_title_register(uint16_t att_ecode, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (att_ecode)
-		DBG(mcp, "Media Track Title notification failed: 0x%04x",
-					att_ecode);
-}
-
-static void mcp_track_title_notify(uint16_t value_handle,
-			const uint8_t *value, uint16_t length, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	mcp_mp_set_track_title(mcp, value, length);
-}
-
-static void mcp_track_duration_register(uint16_t att_ecode, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (att_ecode)
-		DBG(mcp, "Media Track Duration notification failed: 0x%04x",
-					att_ecode);
-}
-
-static void mcp_track_duration_notify(uint16_t value_handle,
-			const uint8_t *value, uint16_t length, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-	int32_t duration;
-
-	memcpy(&duration, value, sizeof(int32_t));
-	mcp_mp_set_title_duration(mcp, duration);
-}
-
-static void mcp_track_position_register(uint16_t att_ecode, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (att_ecode)
-		DBG(mcp, "Media Track Position notification failed: 0x%04x",
-					att_ecode);
-}
-
-static void mcp_track_position_notify(uint16_t value_handle,
-		const uint8_t *value, uint16_t length, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-	int32_t position;
-
-	memcpy(&position, value, sizeof(int32_t));
-	mcp_mp_set_title_position(mcp, position);
-}
-
-static void mcp_media_state_register(uint16_t att_ecode, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (att_ecode)
-		DBG(mcp, "Media Media State notification failed: 0x%04x",
-					att_ecode);
-}
-
-static void mcp_media_state_notify(uint16_t value_handle,
-			const uint8_t *value, uint16_t length, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	mcp_mp_set_media_state(mcp, *value);
-}
-
-static void mcp_media_cp_register(uint16_t att_ecode, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (att_ecode)
-		DBG(mcp, "Media Media CP notification failed: 0x%04x",
-					att_ecode);
-}
-
-static void mcp_media_cp_notify(uint16_t value_handle, const uint8_t *value,
-					uint16_t length, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	DBG(mcp, "Media CP Notification");
-}
-
-static void mcp_media_cp_op_supported_register(uint16_t att_ecode,
-					void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	if (att_ecode)
-		DBG(mcp, "Media Media CP OP Supported notify failed: 0x%04x",
-					att_ecode);
-}
-
-static void mcp_media_cp_op_supported_notify(uint16_t value_handle,
-			const uint8_t *value, uint16_t length, void *user_data)
-{
-	struct bt_mcp *mcp = user_data;
-
-	memcpy(&mcp->session.cp_op_supported, value, sizeof(uint32_t));
-	DBG(mcp, "Media CP Opcodes Supported Notification 0x%08x",
-			mcp->session.cp_op_supported);
-}
-
-static void bt_mcp_mp_name_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->mp_name, NULL, &value_handle,
-						NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Media Player handle 0x%04x", value_handle);
-
-	mcp_read_value(mcp, value_handle, read_media_player_name, mcp);
-
-	mcp->mp_name_id = bt_gatt_client_register_notify(mcp->client,
-				value_handle, mcp_mp_name_register,
-				mcp_mp_name_notify, mcp, NULL);
-}
-
-static void bt_mcp_track_changed_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->track_changed, NULL,
-				&value_handle, NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Track Changed handle 0x%04x", value_handle);
-
-	mcp->track_changed_id = bt_gatt_client_register_notify(mcp->client,
-				value_handle, mcp_track_changed_register,
-				mcp_track_changed_notify, mcp, NULL);
-}
-
-static void bt_mcp_track_title_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->track_title, NULL,
-				&value_handle, NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Track Title handle 0x%04x", value_handle);
-
-	mcp_read_value(mcp, value_handle, read_track_title, mcp);
-
-	mcp->track_title_id = bt_gatt_client_register_notify(mcp->client,
-				value_handle, mcp_track_title_register,
-				mcp_track_title_notify, mcp, NULL);
-}
-
-static void bt_mcp_track_duration_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->track_duration, NULL,
-				&value_handle, NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Track Duration handle 0x%04x", value_handle);
-
-	mcp_read_value(mcp, value_handle, read_track_duration, mcp);
-
-	mcp->track_duration_id = bt_gatt_client_register_notify(mcp->client,
-				value_handle, mcp_track_duration_register,
-				mcp_track_duration_notify, mcp, NULL);
-}
-
-static void bt_mcp_track_position_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->track_position, NULL,
-				&value_handle, NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Track Position handle 0x%04x", value_handle);
-
-	mcp_read_value(mcp, value_handle, read_track_position, mcp);
-
-	mcp->track_position_id = bt_gatt_client_register_notify(mcp->client,
-				value_handle, mcp_track_position_register,
-				mcp_track_position_notify, mcp, NULL);
-}
-
-static void bt_mcp_media_state_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->media_state, NULL,
-				&value_handle, NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Media State handle 0x%04x", value_handle);
-
-	mcp_read_value(mcp, value_handle, read_media_state, mcp);
-
-	mcp->media_state_id = bt_gatt_client_register_notify(mcp->client,
-					value_handle, mcp_media_state_register,
-					mcp_media_state_notify, mcp, NULL);
-}
-
-static void bt_mcp_media_cp_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->media_cp, NULL,
-				&value_handle, NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Media Control Point handle 0x%04x", value_handle);
-
-	mcp->media_cp_id = bt_gatt_client_register_notify(mcp->client,
-					value_handle, mcp_media_cp_register,
-					mcp_media_cp_notify, mcp, NULL);
-}
-
-static void bt_mcp_media_cp_op_supported_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->media_cp_op_supportd, NULL,
-				&value_handle, NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Media Control Point Opcodes Supported handle 0x%04x",
-			value_handle);
-
-	mcp_read_value(mcp, value_handle, read_media_cp_op_supported, mcp);
-
-	mcp->media_cp_op_supported_id = bt_gatt_client_register_notify(
-		mcp->client, value_handle, mcp_media_cp_op_supported_register,
-		mcp_media_cp_op_supported_notify, mcp, NULL);
-}
-
-static void bt_mcp_content_control_id_supported_attach(struct bt_mcp *mcp)
-{
-	uint16_t value_handle;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
-
-	if (!gatt_db_attribute_get_char_data(mcs->content_control_id, NULL,
-				&value_handle, NULL, NULL, NULL))
-		return;
-
-	DBG(mcp, "Media Content Control id Supported handle 0x%04x",
-				value_handle);
-	mcp_read_value(mcp, value_handle, read_content_control_id, mcp);
+	if (data->notify_cb)
+		data->notify_cb(service);
 }
 
 static void foreach_mcs_char(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct bt_mcp *mcp = user_data;
+	struct bt_mcp_service *service = user_data;
+	struct bt_mcp *mcp = service->mcp;
+	const struct {
+		uint16_t uuid;
+		const char *name;
+		struct gatt_db_attribute **dst;
+		bt_gatt_client_read_callback_t cb;
+		void (*notify_cb)(struct bt_mcp_service *service);
+		bool no_read;
+		bool no_notify;
+	} attrs[] = {
+		{ MCS_CCID_CHRC_UUID, "CCID", &service->rdb.ccid,
+		  update_ccid, .no_notify = true },
+		{ MCS_MEDIA_PLAYER_NAME_CHRC_UUID, "Media Player Name",
+		  &service->rdb.media_player_name, update_media_player_name,
+		  .notify_cb = notify_media_player_name },
+		{ MCS_TRACK_CHANGED_CHRC_UUID, "Track Changed",
+		  &service->rdb.track_changed, update_track_changed,
+		  .no_read = true },
+		{ MCS_TRACK_TITLE_CHRC_UUID, "Track Title",
+		  &service->rdb.track_title, update_track_title },
+		{ MCS_TRACK_DURATION_CHRC_UUID, "Track Duration",
+		  &service->rdb.track_duration, update_track_duration },
+		{ MCS_TRACK_POSITION_CHRC_UUID, "Track Position",
+		  &service->rdb.track_position, update_track_position },
+		{ MCS_PLAYBACK_SPEED_CHRC_UUID, "Playback Speed",
+		  &service->rdb.playback_speed, update_playback_speed },
+		{ MCS_SEEKING_SPEED_CHRC_UUID, "Seeking Speed",
+		  &service->rdb.seeking_speed, update_seeking_speed },
+		{ MCS_PLAYING_ORDER_CHRC_UUID, "Playing Order",
+		  &service->rdb.playing_order, update_playing_order },
+		{ MCS_PLAYING_ORDER_SUPPORTED_CHRC_UUID,
+		  "Playing Order Supported",
+		  &service->rdb.playing_order_supported,
+		  update_playing_order_supported, .no_notify = true },
+		{ MCS_MEDIA_STATE_CHRC_UUID, "Media State",
+		  &service->rdb.media_state, update_media_state },
+		{ MCS_MEDIA_CP_CHRC_UUID, "Media Control Point",
+		  &service->rdb.media_cp, update_media_cp },
+		{ MCS_MEDIA_CP_OP_SUPPORTED_CHRC_UUID, "Media CP Op Supported",
+		  &service->rdb.media_cp_op_supported,
+		  update_media_cp_op_supported },
+	};
+	struct bt_gatt_client *client = service->mcp->client;
+	bt_uuid_t uuid, uuid_attr;
 	uint16_t value_handle;
-	bt_uuid_t uuid, uuid_mp_name, uuid_track_changed, uuid_track_title,
-		uuid_track_duration, uuid_track_position, uuid_media_state,
-		uuid_media_cp, uuid_media_cp_op_supported,
-		uuid_content_control_id;
-	struct bt_mcs *mcs;
+	uint8_t props;
+	unsigned int i;
 
 	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
-						NULL, NULL, &uuid))
+						&props, NULL, &uuid_attr))
 		return;
 
-	bt_uuid16_create(&uuid_mp_name, MEDIA_PLAYER_NAME_CHRC_UUID);
-	bt_uuid16_create(&uuid_track_changed, MEDIA_TRACK_CHNGD_CHRC_UUID);
-	bt_uuid16_create(&uuid_track_title, MEDIA_TRACK_TITLE_CHRC_UUID);
-	bt_uuid16_create(&uuid_track_duration, MEDIA_TRACK_DURATION_CHRC_UUID);
-	bt_uuid16_create(&uuid_track_position, MEDIA_TRACK_POSTION_CHRC_UUID);
-	bt_uuid16_create(&uuid_media_state, MEDIA_STATE_CHRC_UUID);
-	bt_uuid16_create(&uuid_media_cp, MEDIA_CP_CHRC_UUID);
-	bt_uuid16_create(&uuid_media_cp_op_supported,
-					MEDIA_CP_OP_SUPPORTED_CHRC_UUID);
-	bt_uuid16_create(&uuid_content_control_id,
-					MEDIA_CONTENT_CONTROL_ID_CHRC_UUID);
+	for (i = 0; i < ARRAY_SIZE(attrs); ++i) {
+		unsigned int id;
+		struct chrc_notify_data *data;
 
-	if (!bt_uuid_cmp(&uuid, &uuid_mp_name)) {
-		DBG(mcp, "Media Player Name found: handle 0x%04x",
-					value_handle);
+		if (*attrs[i].dst)
+			continue;
 
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->mp_name)
-			return;
+		bt_uuid16_create(&uuid, attrs[i].uuid);
+		if (bt_uuid_cmp(&uuid_attr, &uuid))
+			continue;
 
-		mcs->mp_name = attr;
-		bt_mcp_mp_name_attach(mcp);
+		DBG_SVC(service, "%s found: handle 0x%04x",
+						attrs[i].name, value_handle);
+		*attrs[i].dst = attr;
+
+		if ((props & BT_GATT_CHRC_PROP_READ) && !attrs[i].no_read)
+			bt_gatt_client_read_value(client, value_handle,
+						attrs[i].cb, service, NULL);
+
+		if (!(props & BT_GATT_CHRC_PROP_NOTIFY) || attrs[i].no_notify)
+			break;
+		if (service->notify_id_count >= ARRAY_SIZE(service->notify_id))
+			break;
+
+		data = new0(struct chrc_notify_data, 1);
+		data->name = attrs[i].name;
+		data->service = service;
+		data->cb = attrs[i].cb;
+
+		id = bt_gatt_client_register_notify(client, value_handle,
+						chrc_register, chrc_notify,
+						data, free);
+		if (id)
+			service->notify_id[service->notify_id_count++] = id;
+		else
+			free(data);
+
+		break;
 	}
 
-	if (!bt_uuid_cmp(&uuid, &uuid_track_changed)) {
-		DBG(mcp, "Track Changed found: handle 0x%04x", value_handle);
-
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->track_changed)
-			return;
-
-		mcs->track_changed = attr;
-		bt_mcp_track_changed_attach(mcp);
-	}
-
-	if (!bt_uuid_cmp(&uuid, &uuid_track_title)) {
-		DBG(mcp, "Track Title found: handle 0x%04x", value_handle);
-
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->track_title)
-			return;
-
-		mcs->track_title = attr;
-		bt_mcp_track_title_attach(mcp);
-	}
-
-	if (!bt_uuid_cmp(&uuid, &uuid_track_duration)) {
-		DBG(mcp, "Track Duration found: handle 0x%04x", value_handle);
-
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->track_duration)
-			return;
-
-		mcs->track_duration = attr;
-		bt_mcp_track_duration_attach(mcp);
-	}
-
-	if (!bt_uuid_cmp(&uuid, &uuid_track_position)) {
-		DBG(mcp, "Track Position found: handle 0x%04x", value_handle);
-
-
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->track_position)
-			return;
-
-		mcs->track_position = attr;
-		bt_mcp_track_position_attach(mcp);
-	}
-
-	if (!bt_uuid_cmp(&uuid, &uuid_media_state)) {
-		DBG(mcp, "Media State found: handle 0x%04x", value_handle);
-
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->media_state)
-			return;
-
-		mcs->media_state = attr;
-		bt_mcp_media_state_attach(mcp);
-	}
-
-	if (!bt_uuid_cmp(&uuid, &uuid_media_cp)) {
-		DBG(mcp, "Media Control Point found: handle 0x%04x",
-					value_handle);
-
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->media_cp)
-			return;
-
-		mcs->media_cp = attr;
-		bt_mcp_media_cp_attach(mcp);
-	}
-
-	if (!bt_uuid_cmp(&uuid, &uuid_media_cp_op_supported)) {
-		DBG(mcp, "Media CP Opcodes Supported found: handle 0x%04x",
-					value_handle);
-
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->media_cp_op_supportd)
-			return;
-
-		mcs->media_cp_op_supportd = attr;
-		bt_mcp_media_cp_op_supported_attach(mcp);
-	}
-
-	if (!bt_uuid_cmp(&uuid, &uuid_content_control_id)) {
-		DBG(mcp, "Content Control ID found: handle 0x%04x",
-					value_handle);
-
-		mcs = mcp_get_mcs(mcp);
-		if (!mcs || mcs->content_control_id)
-			return;
-
-		mcs->content_control_id = attr;
-		bt_mcp_content_control_id_supported_attach(mcp);
-	}
+	if (!mcp->idle_id && i < ARRAY_SIZE(attrs))
+		mcp->idle_id = bt_gatt_client_idle_register(mcp->client,
+							mcp_idle, mcp, NULL);
 }
 
-void bt_mcp_set_event_callbacks(struct bt_mcp *mcp,
-				const struct bt_mcp_event_callback *cbs,
-				void *user_data)
+static void foreach_mcs_ccid(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct event_callback *cb;
+	bt_uuid_t uuid, uuid_attr;
 
-	if (!mcp)
+	if (!gatt_db_attribute_get_char_data(attr, NULL, NULL, NULL, NULL,
+								&uuid_attr))
 		return;
 
-	if (mcp->cb)
-		free(mcp->cb);
+	bt_uuid16_create(&uuid, MCS_CCID_CHRC_UUID);
+	if (bt_uuid_cmp(&uuid_attr, &uuid))
+		return;
 
-	cb = new0(struct event_callback, 1);
-	cb->cbs = cbs;
-	cb->user_data = user_data;
-
-	mcp->cb = cb;
+	foreach_mcs_char(attr, user_data);
 }
 
-static void foreach_mcs_service(struct gatt_db_attribute *attr,
-						void *user_data)
+static void listener_destroy(void *data)
+{
+	struct bt_mcp_listener *listener = data;
+
+	if (listener->cb->destroy)
+		listener->cb->destroy(listener->user_data);
+
+	free(listener);
+}
+
+static void mcp_service_destroy(void *data)
+{
+	struct bt_mcp_service *service = data;
+	struct bt_gatt_client *client = service->mcp->client;
+	unsigned int i;
+
+	mcp_cancel_pending_writes(service);
+
+	queue_destroy(service->listeners, listener_destroy);
+
+	for (i = 0; i < service->notify_id_count; ++i)
+		bt_gatt_client_unregister_notify(client, service->notify_id[i]);
+
+	queue_destroy(service->pending, free);
+	free(service);
+}
+
+static void foreach_mcs_service(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct bt_mcp *mcp = user_data;
-	struct bt_mcs *mcs = mcp_get_mcs(mcp);
+	struct bt_mcp_service *service;
+	bt_uuid_t uuid, uuid_attr;
+	bool gmcs, mcs;
 
-	DBG(mcp, "");
+	DBG_MCP(mcp, "");
 
-	mcs->service = attr;
+	if (!gatt_db_attribute_get_service_uuid(attr, &uuid_attr))
+		return;
 
-	gatt_db_service_foreach_char(attr, foreach_mcs_char, mcp);
+	bt_uuid16_create(&uuid, GMCS_UUID);
+	gmcs = !bt_uuid_cmp(&uuid_attr, &uuid);
+
+	if (gmcs != mcp->gmcs)
+		return;
+
+	bt_uuid16_create(&uuid, MCS_UUID);
+	mcs = !bt_uuid_cmp(&uuid_attr, &uuid);
+
+	if (!gmcs && !mcs)
+		return;
+
+	service = new0(struct bt_mcp_service, 1);
+	service->mcp = mcp;
+	service->rdb.gmcs = gmcs;
+	service->rdb.service = attr;
+	service->rdb.ccid_value = -1;
+	service->pending = queue_new();
+	service->listeners = queue_new();
+
+	/* Find CCID first */
+	gatt_db_service_foreach_char(attr, foreach_mcs_ccid, service);
+
+	gatt_db_service_foreach_char(attr, foreach_mcs_char, service);
+
+	queue_push_tail(mcp->services, service);
 }
 
-static struct bt_mcp_db *mcp_db_new(struct gatt_db *db)
+static bool match_service_attr(const void *data, const void *user_data)
 {
-	struct bt_mcp_db *mdb;
+	const struct bt_mcp_service *service = data;
 
-	if (!db)
-		return NULL;
-
-	mdb = new0(struct bt_mcp_db, 1);
-	mdb->db = gatt_db_ref(db);
-
-	if (!mcp_db)
-		mcp_db = queue_new();
-
-	queue_push_tail(mcp_db, mdb);
-
-	mdb->mcs = mcs_new(db);
-	return mdb;
+	return service->rdb.service == user_data;
 }
 
-static struct bt_mcp_db *mcp_get_db(struct gatt_db *db)
+static void mcp_service_added(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct bt_mcp_db *mdb;
+	struct bt_mcp *mcp = user_data;
 
-	mdb = queue_find(mcp_db, mcp_db_match, db);
-	if (mdb)
-		return mdb;
-
-	return mcp_db_new(db);
+	foreach_mcs_service(attr, mcp);
 }
 
-struct bt_mcp *bt_mcp_new(struct gatt_db *ldb, struct gatt_db *rdb)
+static void mcp_service_removed(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_mcp *mcp = user_data;
+
+	queue_remove_all(mcp->services, match_service_attr, attr,
+							mcp_service_destroy);
+}
+
+struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool gmcs,
+			const struct bt_mcp_callback *cb, void *user_data)
 {
 	struct bt_mcp *mcp;
-	struct bt_mcp_db *mdb;
+	struct gatt_db *db;
+	bt_uuid_t uuid;
 
-	if (!ldb)
+	if (!cb)
 		return NULL;
 
-	mdb = mcp_get_db(ldb);
-	if (!mdb)
-		return NULL;
+	client = bt_gatt_client_clone(client);
+	if (!client)
+		return false;
 
 	mcp = new0(struct bt_mcp, 1);
-	mcp->ldb = mdb;
-	mcp->pending = queue_new();
+	mcp->gmcs = gmcs;
+	mcp->client = client;
+	mcp->services = queue_new();
+	mcp->cb = cb;
+	mcp->user_data = user_data;
 
-	if (!rdb)
-		goto done;
+	DBG_MCP(mcp, "");
 
-	mdb = new0(struct bt_mcp_db, 1);
-	mdb->db = gatt_db_ref(rdb);
+	db = bt_gatt_client_get_db(client);
 
-	mcp->rdb = mdb;
+	bt_uuid16_create(&uuid, GMCS_UUID);
+	gatt_db_foreach_service(db, &uuid, foreach_mcs_service, mcp);
 
-done:
-	bt_mcp_ref(mcp);
+	bt_uuid16_create(&uuid, MCS_UUID);
+	gatt_db_foreach_service(db, &uuid, foreach_mcs_service, mcp);
+
+	mcp->db_id = gatt_db_register(db, mcp_service_added,
+						mcp_service_removed, mcp, NULL);
+
+	if (!mcp->idle_id)
+		mcp_idle(mcp);
 
 	return mcp;
 }
 
-void bt_mcp_register(struct gatt_db *db)
-{
-	if (!db)
-		return;
-
-	mcp_db_new(db);
-}
-
-bool bt_mcp_attach(struct bt_mcp *mcp, struct bt_gatt_client *client)
-{
-	bt_uuid_t uuid;
-
-	if (!mcp)
-		return false;
-
-	DBG(mcp, "mcp %p", mcp);
-
-	mcp->client = bt_gatt_client_clone(client);
-	if (!mcp->client)
-		return false;
-
-	if (mcp->rdb->mcs) {
-		bt_mcp_mp_name_attach(mcp);
-		bt_mcp_track_changed_attach(mcp);
-		bt_mcp_track_title_attach(mcp);
-		bt_mcp_track_duration_attach(mcp);
-		bt_mcp_track_position_attach(mcp);
-		bt_mcp_media_state_attach(mcp);
-		bt_mcp_media_cp_attach(mcp);
-		bt_mcp_media_cp_op_supported_attach(mcp);
-		bt_mcp_content_control_id_supported_attach(mcp);
-
-		return true;
-	}
-
-	bt_uuid16_create(&uuid, GMCS_UUID);
-	gatt_db_foreach_service(mcp->rdb->db, &uuid, foreach_mcs_service, mcp);
-
-	return true;
-}
-
 void bt_mcp_detach(struct bt_mcp *mcp)
 {
+	struct gatt_db *db;
+
 	if (!mcp)
 		return;
 
-	DBG(mcp, "%p", mcp);
+	DBG_MCP(mcp, "");
+
+	queue_destroy(mcp->services, mcp_service_destroy);
+
+	if (mcp->cb->destroy)
+		mcp->cb->destroy(mcp->user_data);
+
+	if (mcp->idle_id)
+		bt_gatt_client_idle_unregister(mcp->client, mcp->idle_id);
+
+	db = bt_gatt_client_get_db(mcp->client);
+	if (mcp->db_id)
+		gatt_db_unregister(db, mcp->db_id);
 
 	bt_gatt_client_unref(mcp->client);
-	mcp->client = NULL;
+
+	free(mcp);
+}
+
+bool bt_mcp_add_listener(struct bt_mcp *mcp, uint8_t ccid,
+				const struct bt_mcp_listener_callback *cb,
+				void *user_data)
+{
+	struct bt_mcp_listener *listener;
+	struct bt_mcp_service *service;
+
+	if (!cb)
+		return false;
+
+	service = queue_find(mcp->services, match_ccid, UINT_TO_PTR(ccid));
+	if (!service)
+		return false;
+
+	listener = new0(struct bt_mcp_listener, 1);
+	listener->cb = cb;
+	listener->user_data = user_data;
+
+	queue_push_tail(service->listeners, listener);
+	return true;
 }
diff --git a/src/shared/mcp.h b/src/shared/mcp.h
index ee57ed4bf..b013e78b6 100644
--- a/src/shared/mcp.h
+++ b/src/shared/mcp.h
@@ -10,54 +10,160 @@
 #include <stdbool.h>
 #include <inttypes.h>
 
-#ifndef __packed
-#define __packed __attribute__((packed))
-#endif
-
 struct bt_mcp;
-struct bt_mcp_db;
-struct bt_mcp_session_info;
+struct bt_mcs;
 
-typedef void (*bt_mcp_debug_func_t)(const char *str, void *user_data);
-typedef void (*bt_mcp_destroy_func_t)(void *user_data);
+/*
+ * edia Control Client
+ */
 
-struct bt_mcp_event_callback {
-	void (*player_name)(struct bt_mcp *mcp,  const uint8_t *value,
-					uint16_t length);
-	void (*track_changed)(struct bt_mcp *mcp);
-	void (*track_title)(struct bt_mcp *mcp, const uint8_t *value,
-					uint16_t length);
-	void (*track_duration)(struct bt_mcp *mcp, int32_t duration);
-	void (*track_position)(struct bt_mcp *mcp, int32_t position);
-	void (*playback_speed)(struct bt_mcp *mcp, int8_t speed);
-	void (*seeking_speed)(struct bt_mcp *mcp, int8_t speed);
-	void (*play_order)(struct bt_mcp *mcp, uint8_t order);
-	void (*play_order_supported)(struct bt_mcp *mcp,
-					uint16_t order_supported);
-	void (*media_state)(struct bt_mcp *mcp, uint8_t state);
-	void (*content_control_id)(struct bt_mcp *mcp, uint8_t cc_id);
+struct bt_mcp_callback {
+	/* New player seen */
+	void (*ccid)(void *data, uint8_t ccid, bool gmcs);
+
+	/* Client command complete */
+	void (*complete)(void *data, unsigned int id, uint8_t status);
+
+	/* Attach complete */
+	void (*ready)(void *data);
+
+	/* Debug message */
+	void (*debug)(void *data, const char *str);
+
+	/* mcp destroyed (no further callbacks) */
+	void (*destroy)(void *data);
 };
 
-void bt_mcp_set_event_callbacks(struct bt_mcp *mcp,
-				const struct bt_mcp_event_callback *cbs,
+struct bt_mcp_listener_callback {
+	/* Value notification */
+	void (*media_player_name)(void *data, const uint8_t *value,
+							uint16_t length);
+	void (*track_changed)(void *data);
+	void (*track_title)(void *data, const uint8_t *value, uint16_t length);
+	void (*track_duration)(void *data, int32_t duration_centisecond);
+	void (*track_position)(void *data, int32_t position_centisecond);
+	void (*playback_speed)(void *data, int8_t log2_speed);
+	void (*seeking_speed)(void *data, int8_t log2_speed);
+	void (*playing_order)(void *data, uint8_t order);
+	void (*media_state)(void *data, uint8_t state);
+
+	/* TODO: OTS */
+
+	/* Listener destroyed (no further callbacks) */
+	void (*destroy)(void *data);
+};
+
+unsigned int bt_mcp_play(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_pause(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_fast_rewind(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_fast_forward(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_stop(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_move_relative(struct bt_mcp *mcp, uint8_t ccid,
+								int32_t offset);
+
+unsigned int bt_mcp_previous_segment(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_next_segment(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_first_segment(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_last_segment(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_goto_segment(struct bt_mcp *mcp, uint8_t ccid, int32_t n);
+
+unsigned int bt_mcp_previous_track(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_next_track(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_first_track(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_last_track(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_goto_track(struct bt_mcp *mcp, uint8_t ccid, int32_t n);
+
+unsigned int bt_mcp_previous_group(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_next_group(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_first_group(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_last_group(struct bt_mcp *mcp, uint8_t ccid);
+unsigned int bt_mcp_goto_group(struct bt_mcp *mcp, uint8_t ccid, int32_t n);
+
+unsigned int bt_mcp_set_track_position(struct bt_mcp *mcp, uint8_t ccid,
+							int32_t position);
+unsigned int bt_mcp_set_playback_speed(struct bt_mcp *mcp, uint8_t ccid,
+							int8_t speed);
+unsigned int bt_mcp_set_playing_order(struct bt_mcp *mcp, uint8_t ccid,
+							uint8_t order);
+
+uint16_t bt_mcp_get_supported_playing_order(struct bt_mcp *mcp, uint8_t ccid);
+uint32_t bt_mcp_get_supported_commands(struct bt_mcp *mcp, uint8_t ccid);
+
+bool bt_mcp_add_listener(struct bt_mcp *mcp, uint8_t ccid,
+				const struct bt_mcp_listener_callback *cb,
 				void *user_data);
 
-bool bt_mcp_set_debug(struct bt_mcp *mcp, bt_mcp_debug_func_t cb,
-			void *user_data, bt_mcp_destroy_func_t destroy);
-
-void bt_mcp_register(struct gatt_db *db);
-bool bt_mcp_attach(struct bt_mcp *mcp, struct bt_gatt_client *client);
+struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool gmcs,
+				const struct bt_mcp_callback *cb,
+				void *user_data);
 void bt_mcp_detach(struct bt_mcp *mcp);
 
-struct bt_mcp *bt_mcp_new(struct gatt_db *ldb, struct gatt_db *rdb);
-struct bt_mcp *bt_mcp_ref(struct bt_mcp *mcp);
-void bt_mcp_unref(struct bt_mcp *mcp);
+/*
+ * Media Control Server
+ */
 
-bool bt_mcp_set_user_data(struct bt_mcp *mcp, void *user_data);
-void *bt_mcp_get_user_data(struct bt_mcp *mcp);
+struct bt_mcs_callback {
+	/* Value requests */
+	void (*media_player_name)(void *data, struct iovec *buf, size_t size);
+	void (*track_title)(void *data, struct iovec *buf, size_t size);
+	int32_t (*track_duration)(void *data);
+	int32_t (*track_position)(void *data);
+	int8_t (*playback_speed)(void *data);
+	int8_t (*seeking_speed)(void *data);
+	uint8_t (*playing_order)(void *data);
+	uint16_t (*playing_order_supported)(void *data);
+	uint32_t (*media_cp_op_supported)(void *data);
 
-unsigned int bt_mcp_play(struct bt_mcp *mcp);
-unsigned int bt_mcp_pause(struct bt_mcp *mcp);
-unsigned int bt_mcp_stop(struct bt_mcp *mcp);
-unsigned int bt_mcp_next_track(struct bt_mcp *mcp);
-unsigned int bt_mcp_previous_track(struct bt_mcp *mcp);
+	/* TODO: OTS */
+
+	/* Set value notification */
+	bool (*set_track_position)(void *data, int32_t value);
+	bool (*set_playback_speed)(void *data, int8_t value);
+	bool (*set_playing_order)(void *data, uint8_t value);
+
+	/* Command notification */
+	bool (*play)(void *data);
+	bool (*pause)(void *data);
+	bool (*fast_rewind)(void *data);
+	bool (*fast_forward)(void *data);
+	bool (*stop)(void *data);
+	bool (*move_relative)(void *data, int32_t offset);
+
+	bool (*previous_segment)(void *data);
+	bool (*next_segment)(void *data);
+	bool (*first_segment)(void *data);
+	bool (*last_segment)(void *data);
+	bool (*goto_segment)(void *data, int32_t n);
+
+	bool (*previous_track)(void *data);
+	bool (*next_track)(void *data);
+	bool (*first_track)(void *data);
+	bool (*last_track)(void *data);
+	bool (*goto_track)(void *data, int32_t n);
+
+	bool (*previous_group)(void *data);
+	bool (*next_group)(void *data);
+	bool (*first_group)(void *data);
+	bool (*last_group)(void *data);
+	bool (*goto_group)(void *data, int32_t n);
+
+	/* Debug message */
+	void (*debug)(void *data, const char *str);
+
+	/* Player destroyed (no further callbacks) */
+	void (*destroy)(void *data);
+};
+
+void bt_mcs_set_media_state(struct bt_mcs *mcs, uint8_t state);
+uint8_t bt_mcs_get_media_state(struct bt_mcs *mcs);
+
+void bt_mcs_changed(struct bt_mcs *mcs, uint16_t chrc_uuid);
+uint8_t bt_mcs_get_ccid(struct bt_mcs *mcs);
+
+struct bt_mcs *bt_mcs_register(struct gatt_db *db, bool is_gmcs,
+			const struct bt_mcs_callback *cb, void *user_data);
+void bt_mcs_unregister(struct bt_mcs *mcs);
+void bt_mcs_unregister_all(struct gatt_db *db);
+
+/* For tests: */
+void bt_mcs_test_util_reset_ccid(void);
diff --git a/src/shared/mcs.h b/src/shared/mcs.h
index 09b3bffe8..f6666ab58 100644
--- a/src/shared/mcs.h
+++ b/src/shared/mcs.h
@@ -7,11 +7,54 @@
  *
  */
 
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+struct bt_mcs_cp_rsp {
+	uint8_t	op;
+	uint8_t	result;
+} __packed;
+
+/* MCP Track Position */
+#define BT_MCS_POSITION_UNAVAILABLE	((int32_t)0xffffffffu)
+#define BT_MCS_DURATION_UNAVAILABLE	((int32_t)0xffffffffu)
+
 /* MCP Media State */
-#define BT_MCS_STATUS_INACTIVE	0x00
-#define BT_MCS_STATUS_PLAYING	0x01
-#define BT_MCS_STATUS_PAUSED	0x02
-#define BT_MCS_STATUS_SEEKING	0x03
+#define BT_MCS_STATE_INACTIVE	0x00
+#define BT_MCS_STATE_PLAYING	0x01
+#define BT_MCS_STATE_PAUSED	0x02
+#define BT_MCS_STATE_SEEKING	0x03
+
+/* MCP Playing Order */
+#define BT_MCS_ORDER_SINGLE_ONCE	0x01
+#define BT_MCS_ORDER_SINGLE_REPEAT	0x02
+#define BT_MCS_ORDER_IN_ORDER_ONCE	0x03
+#define BT_MCS_ORDER_IN_ORDER_REPEAT	0x04
+#define BT_MCS_ORDER_OLDEST_ONCE	0x05
+#define BT_MCS_ORDER_OLDEST_REPEAT	0x06
+#define BT_MCS_ORDER_NEWEST_ONCE	0x07
+#define BT_MCS_ORDER_NEWEST_REPEAT	0x08
+#define BT_MCS_ORDER_SHUFFLE_ONCE	0x09
+#define BT_MCS_ORDER_SHUFFLE_REPEAT	0x0a
+
+/* MCP Playing Order Supported */
+#define BT_MCS_ORDER_SUPPORTED_SINGLE_ONCE	0x0001
+#define BT_MCS_ORDER_SUPPORTED_SINGLE_REPEAT	0x0002
+#define BT_MCS_ORDER_SUPPORTED_IN_ORDER_ONCE	0x0004
+#define BT_MCS_ORDER_SUPPORTED_IN_ORDER_REPEAT	0x0008
+#define BT_MCS_ORDER_SUPPORTED_OLDEST_ONCE	0x0010
+#define BT_MCS_ORDER_SUPPORTED_OLDEST_REPEAT	0x0020
+#define BT_MCS_ORDER_SUPPORTED_NEWEST_ONCE	0x0040
+#define BT_MCS_ORDER_SUPPORTED_NEWEST_REPEAT	0x0080
+#define BT_MCS_ORDER_SUPPORTED_SHUFFLE_ONCE	0x0100
+#define BT_MCS_ORDER_SUPPORTED_SHUFFLE_REPEAT	0x0200
+
+/* Control Point result codes */
+#define BT_MCS_RESULT_SUCCESS			0x01
+#define BT_MCS_RESULT_OP_NOT_SUPPORTED		0x02
+#define BT_MCS_RESULT_MEDIA_PLAYER_INACTIVE	0x03
+#define BT_MCS_RESULT_COMMAND_CANNOT_COMPLETE	0x04
 
 /* MCP Control Point Opcodes */
 #define BT_MCS_CMD_PLAY			    0x01
-- 
2.51.1

