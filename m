Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9B3AC0D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156735; cv=none; b=G8WP6JHC1drF6NMCrP9v4VBsRPBUQ2GCYDzNWKl2n2idwEE3PQTHJrhpoFWAlGl+RDKdoAUsRXfqYz3KPmp+fHRklkJfylid7It+n5RYTWICj3VUFsBDB78MWjFsBzAM6GMXs9mrdRq7/2s1cnpwbaSLPrLXxGOsrCzJ6b9fdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156735; c=relaxed/simple;
	bh=7f8tWQSrT5yzNKJ9uAIkvXe1QmurNS8Y7LTCv54zqbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAlS5+eSIAK/KITHGM2Pvy9GDKuAz27baXh75Cu8UQzlmDLVa9qK88cM8wpP8hEDKtdzQBgD/6J7g3v/qqa/wa7QPOFzuWIJm3II1m2elR1+VKCsoqEaTJizwqm49j1yxza8CC5cHu8VFao6vGUWY5D+9wK5fCkTlGkc0Z87IwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cg0fZgsu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cg0fZgsu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788156723;
	bh=7f8tWQSrT5yzNKJ9uAIkvXe1QmurNS8Y7LTCv54zqbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cg0fZgsuntYlekMNe/kl6uWFUto15M3ajIRACv0AKTZcwe+oMC9PtJHwHMqxBg0s3
	 mHO33MCJKDw82M8HQpupnFofokaz9KsRSPmAnYwmMg7GDCQRJy+k4Gx7tYtrNj2vBn
	 5WsQ0YKU6qg9b3QahDCbJzIbFLwFr5NSdLZlvifR6gaN53vPsWVCViW+Olxv0KhMCE
	 u4wszcIyy3pqIXho17QeFAokBYxzMVTNfgOy7TBA2hfd5AqJiHfl0FCLPKNJ1c153i
	 Hpl8S+nmZfqOTykQPc7esedUqFsDg8K2/OPC6wwEY7ocD0HC4B0e85wmz+Yx+t6d83
	 +qB2mkctVH7IA==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5527817E0803;
	Mon, 31 Aug 2026 08:12:02 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 1/3] profiles/audio: Support MCS fast seeking
Date: Mon, 31 Aug 2026 11:41:42 +0530
Message-ID: <20260831061144.7767-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831061144.7767-1-raghavendra.rao@collabora.com>
References: <20260831061144.7767-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

---
 profiles/audio/mcp.c   | 43 ++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/media.c | 27 ++++++++++++++++++++++++++
 profiles/audio/media.h |  1 +
 3 files changed, 71 insertions(+)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 8adf814e8..4df388a22 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -60,6 +60,7 @@
 
 #define MCS_UUID_STR	"00001848-0000-1000-8000-00805f9b34fb"
 #define GMCS_UUID_STR	"00001849-0000-1000-8000-00805f9b34fb"
+#define MCS_SEEK_OFFSET	(10 * 1000 * 1000)
 
 
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
@@ -656,6 +663,32 @@ static bool mcs_pause(void *data)
 	return mcs_command(mcs, BT_MCS_CMD_PAUSE);
 }
 
+static bool mcs_fast_rewind(void *data)
+{
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+
+	if (!p || !local_player_seek(p->lp, -MCS_SEEK_OFFSET))
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
+	if (!p || !local_player_seek(p->lp, MCS_SEEK_OFFSET))
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
@@ -752,6 +785,13 @@ static int32_t mcs_track_position(void *data)
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
@@ -858,12 +898,15 @@ static const struct bt_mcs_callback gmcs_cb = {
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
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 95f9580b0..aeb6226da 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -157,6 +157,7 @@ struct local_player {
 	GTimer			*timer;
 	bool			play;
 	bool			pause;
+	bool			seek;
 	bool			next;
 	bool			previous;
 	bool			control;
@@ -2296,6 +2297,29 @@ bool local_player_pause(struct local_player *mp)
 	return local_player_send(mp, "Pause");
 }
 
+bool local_player_seek(struct local_player *mp, int64_t offset)
+{
+	DBusMessage *msg;
+
+	DBG("");
+
+	if (!mp->seek || !mp->control)
+		return false;
+
+	msg = dbus_message_new_method_call(mp->sender, mp->path,
+					MEDIA_PLAYER_INTERFACE, "Seek");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return false;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_INT64, &offset,
+					DBUS_TYPE_INVALID);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+
+	return true;
+}
+
 bool local_player_next(struct local_player *mp)
 {
 	DBG("");
@@ -2673,6 +2697,9 @@ static gboolean set_player_property(struct local_player *mp, const char *key,
 	if (strcasecmp(key, "CanPause") == 0)
 		return set_flag(mp, &var, &mp->pause);
 
+	if (strcasecmp(key, "CanSeek") == 0)
+		return set_flag(mp, &var, &mp->seek);
+
 	if (strcasecmp(key, "CanGoNext") == 0)
 		return set_flag(mp, &var, &mp->next);
 
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 1c43075ba..a89466657 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -73,6 +73,7 @@ bool local_player_have_track(struct local_player *lp);
 bool local_player_play(struct local_player *lp);
 bool local_player_stop(struct local_player *lp);
 bool local_player_pause(struct local_player *lp);
+bool local_player_seek(struct local_player *lp, int64_t offset);
 bool local_player_next(struct local_player *lp);
 bool local_player_previous(struct local_player *lp);
 
