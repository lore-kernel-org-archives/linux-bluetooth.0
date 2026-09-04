Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E5511187
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540836; cv=none; b=K/fJzQ+LzW0J7/GkXMpsFUsxHps44J/hRWdsTtnqdanrV3TFbmnFGjzcPGLbdmHoH+TwPK2mgZCfaseEKMUyLIZ72ZBEpwyAcjgOJ39EWBs8NoVWrpP82kuG0vT/iyDlWlFKYUKSr62fiKErGXnEVqjEV0BPIFuU5qSKr2GPyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540836; c=relaxed/simple;
	bh=0lgahP1GnoRDDVZPljamVUfymQdxMmryrUj0Ock1nX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ere7fTAR9N21vP9G4o7kWulrzzD2FX/0sn2UQ0yZTtgfhPiWqQHH0wDxkqEN3lvxtSoRwzw2CXMk7D0uiLT9SomOtdCis1BNcMbgYdNrz0z6ajfVKOds5m9+h1XDdQhuLVaYfpBMvP9aoDFnYzreHkSMauaVb1JFn5Oyi6QVtTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NJDrCkRu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NJDrCkRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788540833;
	bh=0lgahP1GnoRDDVZPljamVUfymQdxMmryrUj0Ock1nX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJDrCkRuT3oL3Xs0GhFMjYjlpthdWa0m9Q4R1g136+iqe9lWcsdgmPWbqi7hb61Qs
	 hTslw+OMVMHa5vKdq8Z29xHOKHF6qJ1Mq6lLRCZGec2ckP1CMY3fKKkmYkAi4/1/rS
	 MUXHyInDJBco/2qjcYxDWXM83r7j6ThXjjLIv0Rf7UYYaER+dt7R/RVyXJfL9c+yt0
	 DQ23eY/UjJpWceHVPLABh/wABsRDcQR511IXGmupaUNM5xQroWMtFX++qVgZJDlFIH
	 7RgBGwxQxGLgE8pCo3v65ITWOtLccJmkDQGIkV4IY0WuVVB6aBbFnzESH5SZFv4Ryf
	 Sxl091+1EWTbg==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 886AE17E092E;
	Fri, 04 Sep 2026 18:53:52 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH 2/4] profiles/audio: Support MCS fast seeking
Date: Fri,  4 Sep 2026 22:23:30 +0530
Message-ID: <20260904165332.42046-3-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904165332.42046-1-raghavendra.rao@collabora.com>
References: <1654183666f442926c1301e1733567216b307981.camel@hadess.net>
 <20260904165332.42046-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

Map Fast Rewind and Fast Forward to relative MPRIS Seek calls.

Report direction through Seeking Speed until Seeked restores player
state.

This is required by PTS tests GMCS/SR/MCP/BV-05-C to BV-08-C.
---
 profiles/audio/mcp.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 2d239ac4b..314bce243 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -60,6 +60,7 @@
 
 #define MCS_UUID_STR	"00001848-0000-1000-8000-00805f9b34fb"
 #define GMCS_UUID_STR	"00001849-0000-1000-8000-00805f9b34fb"
+#define MCS_SEEK_OFFSET_USEC	(10 * G_USEC_PER_SEC)
 
 
 /*
@@ -440,6 +441,7 @@ struct mcs_instance {
 	struct bt_mcs *mcs;
 	struct queue *player_links;
 	bool at_start;
+	int8_t seeking_speed;
 
 	/* GMCS-specific */
 	struct bt_uinput *uinput;
@@ -494,6 +496,11 @@ static void mcs_update_media_state(struct mcs_instance *mcs)
 		state = BT_MCS_STATE_INACTIVE;
 	}
 
+	if (state != BT_MCS_STATE_SEEKING && mcs->seeking_speed) {
+		mcs->seeking_speed = 0;
+		bt_mcs_changed(mcs->mcs, MCS_SEEKING_SPEED_CHRC_UUID);
+	}
+
 	bt_mcs_set_media_state(mcs->mcs, state);
 	bt_mcs_changed(mcs->mcs, MCS_TRACK_POSITION_CHRC_UUID);
 }
@@ -557,6 +564,11 @@ static void lp_track_position(uint32_t old_ms, uint32_t new_ms, void *user_data)
 	if (!player_link_is_active(p))
 		return;
 
+	if (mcs->seeking_speed) {
+		mcs_update_media_state(mcs);
+		return;
+	}
+
 	bt_mcs_changed(mcs->mcs, MCS_TRACK_POSITION_CHRC_UUID);
 }
 
@@ -656,6 +668,33 @@ static bool mcs_pause(void *data)
 	return mcs_command(mcs, BT_MCS_CMD_PAUSE);
 }
 
+/* MPRIS Seek uses signed offsets: negative rewinds, positive advances. */
+static bool mcs_fast_rewind(void *data)
+{
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (!p || !local_player_seek(p->lp, -MCS_SEEK_OFFSET_USEC))
+		return false;
+
+	mcs->seeking_speed = -1;
+	bt_mcs_changed(mcs->mcs, MCS_SEEKING_SPEED_CHRC_UUID);
+	return true;
+}
+
+static bool mcs_fast_forward(void *data)
+{
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (!p || !local_player_seek(p->lp, MCS_SEEK_OFFSET_USEC))
+		return false;
+
+	mcs->seeking_speed = 1;
+	bt_mcs_changed(mcs->mcs, MCS_SEEKING_SPEED_CHRC_UUID);
+	return true;
+}
+
 static bool mcs_stop(void *data)
 {
 	struct mcs_instance *mcs = data;
@@ -752,6 +791,13 @@ static int32_t mcs_track_position(void *data)
 	return local_player_get_position(p->lp) / 10;
 }
 
+static int8_t mcs_seeking_speed(void *data)
+{
+	struct mcs_instance *mcs = data;
+
+	return mcs->seeking_speed;
+}
+
 static uint8_t mcs_playing_order(void *data)
 {
 	struct mcs_instance *mcs = data;
@@ -876,12 +922,15 @@ static const struct bt_mcs_callback gmcs_cb = {
 	.track_title = mcs_track_title,
 	.track_duration = mcs_track_duration,
 	.track_position = mcs_track_position,
+	.seeking_speed = mcs_seeking_speed,
 	.playing_order = mcs_playing_order,
 	.playing_order_supported = mcs_playing_order_supported,
 	.set_track_position = mcs_set_track_position,
 	.set_playing_order = mcs_set_playing_order,
 	.play = mcs_play,
 	.pause = mcs_pause,
+	.fast_rewind = mcs_fast_rewind,
+	.fast_forward = mcs_fast_forward,
 	.stop = mcs_stop,
 	.next_track = mcs_next_track,
 	.previous_track = mcs_previous_track,
-- 
2.43.0

