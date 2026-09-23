Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5A3F23DF
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150413; cv=none; b=EXx90/T0r230AqyymHFAVUHqsxxRJEw6gsFb3qtaX8vt5GS5yo4ccFessQO/yO9atbzN2D62+RF53CKc0IhQ3WmjTOfFc6bTsDOgwppT2pZn/+9LFq94R0QZhWn5yPR2kNwehRY0RL2+8PCR0aspvXeaGvxkwQFzI6ZxmJH0A+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150413; c=relaxed/simple;
	bh=Qi5eonA9rhUv2xHIjNZgcdLZbesnw8wlB99B5EgsK8k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFhDoSxUNAS0RmFpu2g05zpR1sIFLyWJENbkLf1ztpXkIiMJLNZzfIzfQ1A5jIOiFA3XBxlEbBUjOYWpRvZy184bnnYYH/E0GRUEnESiRZu/QzCkPIunYFoQ9xES6+lb93wIFss74kwrBcaxPGhrnS3T5aiEK7QEQNCeSIOnYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FnUK1mzI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FnUK1mzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790150408;
	bh=Qi5eonA9rhUv2xHIjNZgcdLZbesnw8wlB99B5EgsK8k=;
	h=From:To:Subject:Date:From;
	b=FnUK1mzIAXRjWW9o44RrFZcbOBg7cfiIXeUTdeNRLwJzo+yMcZ5Ag3uhn0BwSYi6L
	 15X1dcicTL8Mu9XUQRf5VzjkvSLoD2aozVjU709zkvDpH7aDD48+tBf59flRlMeRQX
	 YlryY3TFDJn53c8YEe+zmJ2+8rMFVTtSYPnxgDjWNUjWtBxteAXfR7DzkvPLViH+Y9
	 n5Vvr5rgQOkIYnKtRKwWUUjBykK+C0ReJxbrG3FCuBcGbcbjB2PHJ1ljH/gH+SQdd8
	 XveMfrYM/WmgbTYofocTiesCgUtcw1OgLe+oIIbv95v2RfVLa9g3TxFvPdxgiXb7od
	 +P7U+iZg/jfuw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CE3EA17E0104
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 10:00:08 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/avrcp: Poll GetPlayStatus when position changed event unsupported
Date: Wed, 23 Sep 2026 10:00:03 +0200
Message-ID: <20260923080003.317019-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some remote targets do not support the AVRCP_EVENT_PLAYBACK_POS_CHANGED
notification, meaning bluetoothd never learns about track position
updates for such devices.

When this event is not present in the capabilities reported by the
remote, fall back to polling AVRCP_GET_PLAY_STATUS once a second so
the media player position stays in sync. Polling is only kept running
while playback is actively progressing (playing/forward-seek/
reverse-seek) and is stopped otherwise, and is torn down on session
destruction.

Assisted-by: Copilot CLI:claude-sonnet-5
---
 profiles/audio/avrcp.c | 64 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index df5f97eaf..105538cdc 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -247,7 +247,9 @@ struct avrcp {
 	unsigned int control_id;
 	unsigned int browsing_id;
 	unsigned int browsing_timer;
+	unsigned int position_timer;
 	uint16_t supported_events;
+	bool pos_changed_supported;
 	uint8_t transaction;
 	struct pending_pdu *pending_pdu;
 };
@@ -341,6 +343,7 @@ static const uint32_t company_ids[] = {
 
 static void avrcp_register_notification(struct avrcp *session, uint8_t event);
 static GList *player_list_settings(struct avrcp_player *player);
+static void avrcp_get_play_status(struct avrcp *session);
 
 static void avrcp_browsing_record(sdp_record_t *record, sdp_data_t *version)
 {
@@ -2224,6 +2227,56 @@ static const char *status_to_string(uint8_t status)
 	}
 }
 
+static bool avrcp_poll_play_status(gpointer user_data)
+{
+	struct avrcp *session = user_data;
+
+	avrcp_get_play_status(session);
+
+	return TRUE;
+}
+
+static void avrcp_stop_pos_polling(struct avrcp *session)
+{
+	if (session->position_timer == 0)
+		return;
+
+	timeout_remove(session->position_timer);
+	session->position_timer = 0;
+}
+
+static void avrcp_start_pos_polling(struct avrcp *session)
+{
+	if (session->position_timer > 0)
+		return;
+
+	session->position_timer = timeout_add_seconds(1,
+						avrcp_poll_play_status,
+						session, NULL);
+}
+
+/*
+ * Poll GetPlayStatus once a second to resync position while playing when
+ * the remote does not support AVRCP_EVENT_PLAYBACK_POS_CHANGED. Polling is
+ * paused whenever playback is not actively progressing.
+ */
+static void avrcp_update_pos_polling(struct avrcp *session, uint8_t status)
+{
+	if (session->pos_changed_supported)
+		return;
+
+	switch (status) {
+	case AVRCP_PLAY_STATUS_PLAYING:
+	case AVRCP_PLAY_STATUS_FWD_SEEK:
+	case AVRCP_PLAY_STATUS_REV_SEEK:
+		avrcp_start_pos_polling(session);
+		break;
+	default:
+		avrcp_stop_pos_polling(session);
+		break;
+	}
+}
+
 static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
 					uint8_t subunit, uint8_t transaction,
 					uint8_t *operands, size_t operand_count,
@@ -2252,6 +2305,8 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
 	media_player_set_position(mp, position);
 	media_player_set_status(mp, status_to_string(status));
 
+	avrcp_update_pos_polling(session, status);
+
 	return FALSE;
 }
 
@@ -4128,6 +4183,9 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 		}
 	}
 
+	session->pos_changed_supported =
+			!!(events & (1 << AVRCP_EVENT_PLAYBACK_POS_CHANGED));
+
 	if (!session->controller || !session->controller->player)
 		return FALSE;
 
@@ -4140,7 +4198,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 			!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
 
-	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
+	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)) ||
+			!session->pos_changed_supported)
 		avrcp_get_play_status(session);
 
 	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
@@ -4470,6 +4529,9 @@ static void session_destroy(struct avrcp *session, int err)
 	if (session->browsing_timer > 0)
 		timeout_remove(session->browsing_timer);
 
+	if (session->position_timer > 0)
+		timeout_remove(session->position_timer);
+
 	if (session->controller != NULL)
 		controller_destroy(session);
 
-- 
2.43.0

