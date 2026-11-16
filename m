Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821601;
	b=K+waQCfDPSBaffKM03WWBJrXYwlha45VLaSno1jlLU++pWucpZqHh6/ebFDmcbhR9F40
	 4gfnHlxSTnjLLW9PAqkztjYs2F3zmgKasPIuty1Dk8yKGeQjUt8RhunV0yIKz323UDzOY
	 excicrCLMzznEAZto2t5Oor4IASDHtnkRZztkuatlfCTMxrrRFld3D6UlL2QbBIz9stI7
	 IF2jyOAo4GkWGhsEsifRQhgsHCmByhuNJ3fHmRNsCCBJsvklw0H3M9+hEbb1zzaDbIQz/
	 XgL8zyEspm0BBGtYV3pOohF/iM0+sbqZCVRmV6mXsnDCE6mdDW8OoYgkxRO0KLkc6qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821601;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zZD1ecSQpfHzr0M/Z2wi+FG+/jH6oQvvrQSRGb/w98U=;
	b=IJXhtm7mCWpkRwT0IBJHWvAy4lqU9XTVjjP9pcdYFxuojsiRc9m6xkPwnZBOGq0Hzd32
	 UYnSjFf2KzhqvhCJ5+jokiRAPQdISaIdHypI6Kox+8YfuvxUl2ToRNIChiosfABj+mxem
	 uLXTbGlTwh+C7XbEA3IdogkquG1cRFKeha99xbOgQ6LQVNMlPUzZneUfOc9swjPU2cjuB
	 zsjEmpro9bvjytk455VkEVtQJqlveUEZmz5hcAjxCvjyfv+0Z0tMCUynudwD/qW3jWwDL
	 GiRYWgD061SVomz7bK6xcmQcQ7pkvkH12PQnEm8u/ZTbDx/LAcweirGJUXVSNMPTfvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lD3bbq0x;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CE606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 838CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lD3bbq0x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794821598;
	bh=69igiJHwoSRqVkHyDrlHC7STzHibppvduashZN+z6l4=;
	h=From:To:Subject:Date:From;
	b=lD3bbq0xVqTp7LUfGXaMol9XrjsuTQX429758m+F98qTJysiZKDx0uKyfuas4DtMU
	 wr/lsx0ZumrC8928UhQsG+4VL9f+3uin5TsFW77O1903yq3tzxBXkYCvYHY0eWypT7
	 e2mZNqpIeJ+GubKPXRWS541k/7Ix1mL2q3Dk6Lp+698X/NCi0rRpFQnv3wtYUQkbAr
	 vWw/brA7ZzQYh8pamyL7GzmHXRGBufee35fped1DwpsDQxUGuAJ2m1haBSpEirKVMe
	 axzzVoRH9IjdaU3kqWGbZxJmqVruK3sIM6QS5Mb+sQ/DBh8Z0YjHprbFUBwZ4H3rxD
	 Dl/MZTNT3au7Q==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 722F217E07B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 10:33:18 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 RESEND] avrcp: Poll GetPlayStatus when position changed event unsupported
Date: Mon, 16 Nov 2026 10:33:08 +0100
Message-ID: <20261116093308.79430-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
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
v2->v3: Change commit title to fit max length

 profiles/audio/avrcp.c | 67 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c09a32766..2f214e982 100644
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

