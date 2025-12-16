Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349D2BDC0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914417; cv=pass; b=sF/kQ4qhGC/KilBA/wFHuOMqIK9EQhr7nMFPERc/ghOVL9PT9WUgswzNY2MSqioOhOzhK2nH1+HdEzbgyabnuWhP2iWpdNOQOemqXIdkDu+hBeNB788zpg8O4I4x2DLNd/n50N6jRq5RK9I3IZA+chnsp9Pvko6l+xB/HIeXZvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914417; c=relaxed/simple;
	bh=MxQkzaKy84wNfB7/HrXUzitw0sl/KVrMMMFCBcw+L30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5c8ILGwLuP5AhsL30128rlvbh5OYe5G5/Vvq9Czg9G7LAxyUtQyFpED3pVK1aTizEe13isb9kSIlFtlhZV5z3nnnRgccSwibIZwXvDRMcbKu51zS4ZtyxfYz2aijJNDhPJR+7Oj6T102qJUfHk05co2ZsmMLD3BQ4T6J+hxz7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=P2VBgG7f; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="P2VBgG7f"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dW6rP6ZcSzyQK;
	Tue, 16 Dec 2025 21:46:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765914406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1sm9bctrnlchmh9pGFOi9QFKEX2SSGu303MZgvwnTU=;
	b=P2VBgG7foK+JCPZJacMwsnOTFiWE09If+aj0nbmpUaL6XPbC+J7hqyvK82KSdDhrDbd2fP
	m/nxYUmP4PIbnlyz53LAAQt2S5wq/embGEfRIINTwFl144kKUkSgPi0DOzbFjKrSOJ9rHR
	XppYtu+c1I9kmMtjU8yWItie9Ugg/3Q=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765914406;
	b=AGUJCmqi4jL65qEJcFqR8OFCuuXeE549nHOdnuvYsqsI/1DsyIJCwG1IuWLBCybdh6k+sG
	KCY8vdWN+Tl76ZCyMMayLguOG9XrHqsHxwpdgju5icFLF/T641z+ulN9WJa01RcQ3E3T0t
	KVTR3UuQumeqSnjbwtvC0G4Cr2AIwZo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765914406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1sm9bctrnlchmh9pGFOi9QFKEX2SSGu303MZgvwnTU=;
	b=Je8cxUDnsyH8GPdgRggB8KqQ+EI3Tii7wv1bSOsTm3Z66ZeG+56BBrV2Srj5xTzdZu2OvP
	12gZJFm89eTxInb0MwMis2aYoh7OduN8lm9DQcoMOVQFxrsil11f1MuNAbY1h02hk/+d1w
	V0kDqRCbFYkAI46WZP7PD/E/ThVPQUI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared/mcp: emit MCS error if value changes during long read
Date: Tue, 16 Dec 2025 21:46:43 +0200
Message-ID: <977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MCS spec requires emitting Value Changed During Read Long if value
changes between remote reading with zero offset and nonzero offset.

This is session-specific state, so add support for that.

As server, track value changes and emit that error properly.

As client, we don't need to reread if this error occurs, as there should
be a notification or track changed that queues a new read.
---
 src/shared/mcp.c | 109 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 97 insertions(+), 12 deletions(-)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index 910089f18..9f8952af1 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -30,6 +30,8 @@
 #include "src/shared/mcp.h"
 #include "src/shared/mcs.h"
 
+#define BT_MCS_ERROR_VALUE_CHANGED_DURING_READ_LONG	0x80
+
 #define DBG_MCP(mcp, fmt, ...) \
 	mcp_debug(mcp, "%s:%s() mcp %p | " fmt, __FILE__, __func__, mcp, \
 								##__VA_ARGS__)
@@ -76,22 +78,19 @@ struct bt_mcs_db {
 	struct gatt_db_attribute *ccid;
 };
 
-struct bt_mcs_client {
+struct bt_mcs_session {
+	struct bt_mcs *mcs;
 	struct bt_att *att;
+	unsigned int disconn_id;
 
-	/* Per-client state.
-	 *
-	 * Concurrency is not specified in MCS v1.0.1, everything currently
-	 * implemented seems OK to be in global state.
-	 *
-	 * TODO: Search Results ID likely should go here
-	 */
+	/* Per-client state */
+	struct queue *changed;
 };
 
 struct bt_mcs {
 	struct gatt_db *db;
 	struct bt_mcs_db ldb;
-	struct queue *clients;
+	struct queue *sessions;
 
 	uint8_t media_state;
 
@@ -557,11 +556,86 @@ static bool set_playing_order(struct bt_mcs *mcs, void *data)
 	return false;
 }
 
+static bool match_session_att(const void *data, const void *match_data)
+{
+	const struct bt_mcs_session *session = data;
+
+	return session->att == match_data;
+}
+
+static void session_destroy(void *data)
+{
+	struct bt_mcs_session *session = data;
+
+	bt_att_unregister_disconnect(session->att, session->disconn_id);
+	queue_destroy(session->changed, NULL);
+	free(session);
+}
+
+static void session_disconnect(int err, void *user_data)
+{
+	struct bt_mcs_session *session = user_data;
+	struct bt_mcs *mcs = session->mcs;
+
+	queue_remove(mcs->sessions, session);
+	session_destroy(session);
+}
+
+static struct bt_mcs_session *get_session(struct bt_mcs *mcs,
+							struct bt_att *att)
+{
+	struct bt_mcs_session *session;
+
+	session = queue_find(mcs->sessions, match_session_att, att);
+	if (session)
+		return session;
+
+	session = new0(struct bt_mcs_session, 1);
+	session->disconn_id = bt_att_register_disconnect(att,
+					session_disconnect, session, NULL);
+	if (!session->disconn_id) {
+		free(session);
+		return NULL;
+	}
+
+	session->mcs = mcs;
+	session->att = att;
+	session->changed = queue_new();
+
+	queue_push_tail(mcs->sessions, session);
+	return session;
+}
+
+static void session_changed(void *data, void *user_data)
+{
+	struct bt_mcs_session *session = data;
+	struct gatt_db_attribute *attrib = user_data;
+
+	if (!queue_find(session->changed, NULL, attrib))
+		queue_push_tail(session->changed, attrib);
+}
+
 static void read_result(struct bt_mcs *mcs, struct gatt_db_attribute *attrib,
-			unsigned int id, uint16_t offset, mcs_get_func_t get)
+			unsigned int id, uint16_t offset, struct bt_att *att,
+			mcs_get_func_t get)
 {
 	uint8_t buf[BT_ATT_MAX_VALUE_LEN];
 	struct iovec iov = { .iov_base = buf, .iov_len = 0 };
+	struct bt_mcs_session *session = get_session(mcs, att);
+
+	if (!session) {
+		gatt_db_attribute_read_result(attrib, id,
+						BT_ATT_ERROR_UNLIKELY, NULL, 0);
+		return;
+	}
+
+	if (!offset) {
+		queue_remove(session->changed, attrib);
+	} else if (queue_find(session->changed, NULL, attrib)) {
+		gatt_db_attribute_read_result(attrib, id,
+			BT_MCS_ERROR_VALUE_CHANGED_DURING_READ_LONG, NULL, 0);
+		return;
+	}
 
 	get(mcs, &iov, sizeof(buf));
 
@@ -582,7 +656,7 @@ static void read_result(struct bt_mcs *mcs, struct gatt_db_attribute *attrib,
 				void *user_data) \
 	{ \
 		DBG_MCS(user_data, ""); \
-		read_result(user_data, attrib, id, offset, get_ ##name); \
+		read_result(user_data, attrib, id, offset, att, get_ ##name); \
 	}
 
 READ_FUNC(media_player_name)
@@ -683,7 +757,9 @@ void bt_mcs_changed(struct bt_mcs *mcs, uint16_t chrc_uuid)
 		if (bt_uuid_cmp(&uuid_attr, &uuid))
 			continue;
 
-		DBG_MCS(mcs, "Notify %u", chrc_uuid);
+		queue_foreach(mcs->sessions, session_changed, attrs[i].attr);
+
+		DBG_MCS(mcs, "Notify 0x%04x", chrc_uuid);
 
 		attrs[i].get(mcs, &iov, sizeof(buf));
 
@@ -925,6 +1001,7 @@ struct bt_mcs *bt_mcs_register(struct gatt_db *db, bool is_gmcs,
 	mcs->user_data = user_data;
 
 	mcs->media_state = BT_MCS_STATE_INACTIVE;
+	mcs->sessions = queue_new();
 
 	if (!mcs_init_db(mcs, is_gmcs)) {
 		free(mcs);
@@ -959,6 +1036,8 @@ void bt_mcs_unregister(struct bt_mcs *mcs)
 		servers = NULL;
 	}
 
+	queue_destroy(mcs->sessions, session_destroy);
+
 	free(mcs);
 }
 
@@ -1367,6 +1446,12 @@ static void update_media_player_name(bool success, uint8_t att_ecode,
 {
 	struct bt_mcp_service *service = user_data;
 
+	if (!success) {
+		DBG_SVC(service, "Unable to read Media Player Name: "
+						"error 0x%02x", att_ecode);
+		return;
+	}
+
 	DBG_SVC(service, "Media Player Name");
 
 	LISTENER_CB(service, media_player_name, value, length);
-- 
2.51.1

