Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64443E06D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345456; cv=none; b=rH9P0eWrJw6nsQQ/NMALsRzxXQyU2tN4pSK7OMmkk3hQNpLp8hgsgktEnin+vy3BlGLslgXrfV3h11xBAOda8vBUU8suNq5CvF7KgHB3IMY/hI7Va3PxFG0Y8a7zjqT5SmItwg20YOT3SGwV+AyzXushJWo7iObxxa7MyaZcELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345456; c=relaxed/simple;
	bh=lSbcAx3T6IlfmuxTjkq8Z3uPz8lEkeY64zhAmiPmSW8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VtejdR223gTLJfYgXWbJEfk5U9VfMCdaZQiTNmxuUkX+QHqFFnQg7LL+1pzTuepv/spxkXt2qaHqGpu8BqGTadLVogXmX4Q5/3NAmuZUCmycOEw8bsoHtGEhwE0Nv94rMMIM985jCLnpXixdRN7Ojb0kargYyastv9mhN0CK9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qv0ZOUeQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qv0ZOUeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790345453;
	bh=lSbcAx3T6IlfmuxTjkq8Z3uPz8lEkeY64zhAmiPmSW8=;
	h=From:To:Subject:Date:From;
	b=qv0ZOUeQd5RcT8cmLfqLAw3nuRLVcofgmaBYk4ZsE4doUK9yFEJ/u92hHgYFP4DWW
	 QA6Z02MYgLHjEWyCAxY+9YgmzZrxPgSjxIfEh/cOxQhVS/FxMk0t8jszFmOnFF1pA7
	 sji3l/kk/sqMomfxLbVgScNuYnZZLad5gF8fj3afWPe3LZBMdfTg5sR5a19QUYMwVu
	 K0HSnSqlQXNstHxVHb/n+ipOe612QAFlIV+wRKjeS1IKTFpcOg4kHpHJY46K9BDqC7
	 X2LesaDhrl9DTDKqavkH1MnT9JrNTOhnx4Fwig7vFZlpvzNFh2J2LpLbaaT04aH2Yw
	 tVXOIHHSeOxTg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0284C17E0082
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 16:10:52 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] audio/avrcp: Poll GetPlayStatus when position changed event unsupported
Date: Fri, 25 Sep 2026 16:10:47 +0200
Message-ID: <20260925141047.3397212-1-frederic.danis@collabora.com>
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
while playback is actively progressing (playing) and is stopped
otherwise, and is torn down on session destruction.

Assisted-by: Copilot CLI:claude-sonnet-5
---
v1->v2: Remove polling during seek

 profiles/audio/avrcp.c | 67 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index df5f97eaf..a30709eaa 100644
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
@@ -2224,6 +2227,59 @@ static const char *status_to_string(uint8_t status)
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
+		avrcp_start_pos_polling(session);
+		break;
+	case AVRCP_PLAY_STATUS_FWD_SEEK:
+	case AVRCP_PLAY_STATUS_REV_SEEK:
+		/* Position already resynced once via GetPlayStatus,
+		 * no need for continuous polling on seek.
+		 */
+	default:
+		avrcp_stop_pos_polling(session);
+		break;
+	}
+}
+
 static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
 					uint8_t subunit, uint8_t transaction,
 					uint8_t *operands, size_t operand_count,
@@ -2252,6 +2308,8 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
 	media_player_set_position(mp, position);
 	media_player_set_status(mp, status_to_string(status));
 
+	avrcp_update_pos_polling(session, status);
+
 	return FALSE;
 }
 
@@ -4128,6 +4186,9 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 		}
 	}
 
+	session->pos_changed_supported =
+			!!(events & (1 << AVRCP_EVENT_PLAYBACK_POS_CHANGED));
+
 	if (!session->controller || !session->controller->player)
 		return FALSE;
 
@@ -4140,7 +4201,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 			!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
 
-	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
+	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)) ||
+			!session->pos_changed_supported)
 		avrcp_get_play_status(session);
 
 	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
@@ -4470,6 +4532,9 @@ static void session_destroy(struct avrcp *session, int err)
 	if (session->browsing_timer > 0)
 		timeout_remove(session->browsing_timer);
 
+	if (session->position_timer > 0)
+		timeout_remove(session->position_timer);
+
 	if (session->controller != NULL)
 		controller_destroy(session);
 
-- 
2.43.0

