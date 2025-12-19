Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08733C1B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164259; cv=pass; b=RBUqWkE0wCCkoAGFXWBS0E2sfrmljXEZIWc0C+RXDCL2HCtia5sVQ8GhpBLkjyLef/uc77rwVOO0vByCR3f6pB2UBlc7q0C/+RbRZTC7sSfhVvNFsan56buR6VSKJBBihJCv9lbuTxmyffKWgJa/ZGHOYntKWj1/sDClH/U/Ssg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164259; c=relaxed/simple;
	bh=BYfqIrG9jwYkVRxpbtNgo0t/+ScKQIHrof4bCIt4ASo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9rSfa5ccz5Q1oznH5hrg+uwgikTcMzJdOtxy+tf+i6d7Hy5/OTocZTyk3J5eGzkWeLr0n/HlIa+cZVi+I9hBkbruaiwOYSzu6gBRmoWRhIQUU1MGRdT7g0ZECj7HD7OAI9t/sP72V9UZpb5KBHRzLyzSxHlqtxW/TY7BtzLlHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=SoWiVn0l; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="SoWiVn0l"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dXvF02Bywz101X;
	Fri, 19 Dec 2025 19:10:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1766164245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2Jb1XUBHTDbMrm2Ho0wvXI9a/Bt/wgQjzc6siQ7RRc=;
	b=SoWiVn0lC/Wzlf/bYnw9qy2DJPVH3INkQqSZiOIph1C7liR62XqiW1OoKcBNTctxnrcgLN
	T0bDZM9irrQWyKulDFMZYXAa/OPnnVnfSKOVcL//apXobzshcqgP/8yiQvPEQ8YX0zbMkW
	FbnYWUROEdugH0fwPhpXy+2DQARdxTM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1766164245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2Jb1XUBHTDbMrm2Ho0wvXI9a/Bt/wgQjzc6siQ7RRc=;
	b=mJKwl8kk7VxZFcBdFFY292BKKEV/qWwWcVd5k6USBjwAiX4gYP7jgaOAyh9HbiGD4xqIZX
	adjdM6h1Ux9f8x3NTl2yYbySxQbvpQXB2JiHLmYck53f9D85CdiH25FOGtK0SnefT+CWpt
	u9NCV9CwkMWoRvnBoEMQJPggX/7rwSQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1766164245;
	b=qBzgo/EFYBqqS814OWBiqrJpkDdWtBNR3nqEoN7DS0F/KMfBDtWtuXaKjqisQgfcF4+FPr
	+DlxL8tDoL9XR70nDcpdKIKm5pyWV9lVdAdX/Yukh9Dw5jXPRknAVW64Vx+rp9Jhlb8frk
	e4bIccRzfvkoXmVYLQU9IedOSPe6GhI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/3] media: decouple local org.bluez.MediaPlayer from AVRCP
Date: Fri, 19 Dec 2025 19:10:37 +0200
Message-ID: <25bf9f1544b7f55dd9f21b8297241a09bf4719f2.1766164144.git.pav@iki.fi>
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

The local media player API should be used also for MCP in addition to
AVRCP, but it's currently calling directly into AVRCP.

Invert the API to be DBus player --> hooks, and attach AVRCP to it
allowing multiple backends.

Rename media_player to local_player, to fix the naming conflict with
player.h, which is the API for remote player --> DBus, ie. the inverse
direction.

Don't modify the AVRCP side of the code to these new wrappers, instead
keep the old AVRCP API and use an extra indirection in avrcp-player.c,
which may make it easier to add new features for MCS.
---

Notes:
    v2:
    - no change

 Makefile.plugins              |   3 +-
 profiles/audio/avrcp-player.c | 291 ++++++++++++++++++++
 profiles/audio/avrcp.c        |   4 +
 profiles/audio/avrcp.h        |   3 +
 profiles/audio/media.c        | 501 +++++++++++++++++++---------------
 profiles/audio/media.h        |  45 +++
 6 files changed, 626 insertions(+), 221 deletions(-)
 create mode 100644 profiles/audio/avrcp-player.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 3a95b5fb5..654936176 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -44,7 +44,8 @@ if AVRCP
 builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
-			profiles/audio/avrcp.h profiles/audio/avrcp.c
+			profiles/audio/avrcp.h profiles/audio/avrcp.c \
+			profiles/audio/avrcp-player.c
 endif
 
 if NETWORK
diff --git a/profiles/audio/avrcp-player.c b/profiles/audio/avrcp-player.c
new file mode 100644
index 000000000..d335e7ef6
--- /dev/null
+++ b/profiles/audio/avrcp-player.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2025 Pauli Virtanen
+ *
+ */
+
+#include <stdint.h>
+
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/log.h"
+
+#include "avrcp.h"
+#include "media.h"
+
+struct player_link {
+	struct local_player *lp;
+	struct avrcp_player *avrcp;
+	unsigned int id;
+};
+
+static unsigned int watch_id;
+static struct queue *players;
+
+static GList *lp_list_settings(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_list_settings(p->lp);
+}
+
+static const char *lp_get_setting(const char *key, void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_get_setting(p->lp, key);
+}
+
+static int lp_set_setting(const char *key, const char *value, void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_set_setting(p->lp, key, value);
+}
+
+static uint64_t lp_get_uid(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	if (!local_player_have_track(p->lp))
+		return UINT64_MAX;
+
+	return 0;
+}
+
+static const char *lp_get_metadata(const char *key, void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_get_metadata(p->lp, key);
+}
+
+static GList *lp_list_metadata(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_list_metadata(p->lp);
+}
+
+static const char *lp_get_status(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_get_status(p->lp);
+}
+
+static uint32_t lp_get_position(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_get_position(p->lp);
+}
+
+static uint32_t lp_get_duration(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_get_duration(p->lp);
+}
+
+static const char *lp_get_name(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_get_player_name(p->lp);
+}
+
+static bool lp_play(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_play(p->lp);
+}
+
+static bool lp_stop(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_stop(p->lp);
+}
+
+static bool lp_pause(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_pause(p->lp);
+}
+
+static bool lp_next(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_next(p->lp);
+}
+
+static bool lp_previous(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	return local_player_previous(p->lp);
+}
+
+static struct avrcp_player_cb avrcp_cb = {
+	.list_settings = lp_list_settings,
+	.get_setting = lp_get_setting,
+	.set_setting = lp_set_setting,
+	.list_metadata = lp_list_metadata,
+	.get_uid = lp_get_uid,
+	.get_metadata = lp_get_metadata,
+	.get_position = lp_get_position,
+	.get_duration = lp_get_duration,
+	.get_status = lp_get_status,
+	.get_name = lp_get_name,
+	.play = lp_play,
+	.stop = lp_stop,
+	.pause = lp_pause,
+	.next = lp_next,
+	.previous = lp_previous,
+};
+
+static void status_changed(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	avrcp_player_event(p->avrcp, AVRCP_EVENT_STATUS_CHANGED,
+						local_player_get_status(p->lp));
+}
+
+static void track_position(uint32_t old, uint32_t position, void *user_data)
+{
+	struct player_link *p = user_data;
+	uint32_t duration = local_player_get_duration(p->lp);
+	const char *status;
+
+	if (position > old)
+		status = "forward-seek";
+	else
+		status = "reverse-seek";
+
+	if (!position) {
+		avrcp_player_event(p->avrcp,
+					AVRCP_EVENT_TRACK_REACHED_START, NULL);
+		return;
+	}
+
+	/*
+	 * If position is the maximum value allowed or greater than track's
+	 * duration, we send a track-reached-end event.
+	 */
+	if (position == UINT32_MAX || position >= duration) {
+		avrcp_player_event(p->avrcp, AVRCP_EVENT_TRACK_REACHED_END,
+									NULL);
+		return;
+	}
+
+	/* Send a status change to force resync the position */
+	avrcp_player_event(p->avrcp, AVRCP_EVENT_STATUS_CHANGED, status);
+}
+
+static void track_changed(void *user_data)
+{
+	struct player_link *p = user_data;
+	uint64_t uid = lp_get_uid(p->lp);
+
+	avrcp_player_event(p->avrcp, AVRCP_EVENT_TRACK_CHANGED, &uid);
+	avrcp_player_event(p->avrcp, AVRCP_EVENT_TRACK_REACHED_START, NULL);
+}
+
+static void settings_changed(const char *key, void *user_data)
+{
+	struct player_link *p = user_data;
+
+	avrcp_player_event(p->avrcp, AVRCP_EVENT_SETTINGS_CHANGED, key);
+}
+
+static void player_removed(void *user_data)
+{
+	struct player_link *p = user_data;
+
+	DBG("%p", p);
+
+	avrcp_unregister_player(p->avrcp);
+}
+
+static const struct local_player_callback player_cb =  {
+	.status_changed = status_changed,
+	.track_position = track_position,
+	.track_changed = track_changed,
+	.settings_changed = settings_changed,
+	.player_removed = player_removed,
+};
+
+static void player_destroy(gpointer data)
+{
+	struct player_link *p = data;
+
+	DBG("%p", p);
+
+	queue_remove(players, p);
+
+	local_player_unregister_callbacks(p->lp, p->id);
+	free(p);
+}
+
+static void player_added(struct local_player *lp, void *user_data)
+{
+	struct btd_adapter *adapter = local_player_get_adapter(lp);
+	struct player_link *p;
+
+	p = new0(struct player_link, 1);
+	p->lp = lp;
+	p->id = local_player_register_callbacks(lp, &player_cb, p);
+	if (!p->id) {
+		free(p);
+		return;
+	}
+
+	p->avrcp = avrcp_register_player(adapter, &avrcp_cb, p, player_destroy);
+	if (!p->avrcp) {
+		local_player_unregister_callbacks(lp, p->id);
+		free(p);
+		return;
+	}
+
+	DBG("%p", p);
+
+	queue_push_tail(players, p);
+}
+
+void avrcp_player_init(void)
+{
+	DBG("");
+
+	if (watch_id)
+		return;
+
+	watch_id = local_player_register_watch(player_added, NULL);
+	players = queue_new();
+}
+
+void avrcp_player_exit(void)
+{
+	DBG("");
+
+	queue_destroy(players, player_removed);
+	players = NULL;
+
+	if (!watch_id)
+		return;
+
+	local_player_unregister_watch(watch_id);
+	watch_id = 0;
+}
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e6f7e1bfd..14889e4b4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4972,11 +4972,15 @@ static int avrcp_init(void)
 
 	populate_default_features();
 
+	avrcp_player_init();
+
 	return 0;
 }
 
 static void avrcp_exit(void)
 {
+	avrcp_player_exit();
+
 	btd_profile_unregister(&avrcp_controller_profile);
 	btd_profile_unregister(&avrcp_target_profile);
 }
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 1f46df17d..b5381b4df 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -105,3 +105,6 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
 size_t avrcp_browsing_general_reject(uint8_t *operands);
 
 struct avrcp_player *avrcp_get_target_player_by_device(struct btd_device *dev);
+
+void avrcp_player_init(void);
+void avrcp_player_exit(void);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 9deeed1f4..ad9eb7beb 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -65,10 +65,6 @@
 #include "transport.h"
 #ifdef HAVE_A2DP
 #include "a2dp.h"
-
-#ifdef HAVE_AVRCP
-#include "avrcp.h"
-#endif
 #endif
 
 #define MEDIA_INTERFACE "org.bluez.Media1"
@@ -85,9 +81,7 @@ struct media_app {
 	char			*path;		/* Application object path */
 	struct queue		*proxies;	/* Application proxies */
 	struct queue		*endpoints;	/* Application endpoints */
-#ifdef HAVE_AVRCP
 	struct queue		*players;	/* Application players */
-#endif
 	int			err;
 };
 
@@ -95,9 +89,7 @@ struct media_adapter {
 	struct btd_adapter	*btd_adapter;
 	struct queue		*apps;		/* Application list */
 	GSList			*endpoints;	/* Endpoints list */
-#ifdef HAVE_AVRCP
 	GSList			*players;	/* Players list */
-#endif
 	int			so_timestamping;
 };
 
@@ -144,9 +136,8 @@ struct media_endpoint {
 	struct endpoint_features	features;
 };
 
-struct media_player {
+struct local_player {
 	struct media_adapter	*adapter;
-	struct avrcp_player	*player;
 	char			*sender;	/* Player DBus bus id */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
@@ -164,9 +155,24 @@ struct media_player {
 	bool			previous;
 	bool			control;
 	char			*name;
+	struct queue		*cbs;
+};
+
+struct local_player_watch {
+	unsigned int		id;
+	local_player_added_t	cb;
+	void			*user_data;
+};
+
+struct local_player_cbs {
+	struct local_player			*mp;
+	unsigned int				id;
+	const struct local_player_callback	*cb;
+	void					*user_data;
 };
 
 static GSList *adapters = NULL;
+static struct queue *local_player_watches;
 
 static void endpoint_request_free(struct endpoint_request *request)
 {
@@ -1928,8 +1934,7 @@ static DBusMessage *unregister_endpoint(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-#ifdef HAVE_AVRCP
-static struct media_player *media_adapter_find_player(
+static struct local_player *media_adapter_find_player(
 						struct media_adapter *adapter,
 						const char *sender,
 						const char *path)
@@ -1937,7 +1942,7 @@ static struct media_player *media_adapter_find_player(
 	GSList *l;
 
 	for (l = adapter->players; l; l = l->next) {
-		struct media_player *mp = l->data;
+		struct local_player *mp = l->data;
 
 		if (sender && g_strcmp0(mp->sender, sender) != 0)
 			continue;
@@ -1951,7 +1956,7 @@ static struct media_player *media_adapter_find_player(
 	return NULL;
 }
 
-static void release_player(struct media_player *mp)
+static void release_player(struct local_player *mp)
 {
 	DBusMessage *msg;
 
@@ -1968,16 +1973,73 @@ static void release_player(struct media_player *mp)
 	g_dbus_send_message(btd_get_dbus_connection(), msg);
 }
 
-static void media_player_free(gpointer data)
+#define LOCAL_PLAYER_EMIT_CB(mp_, method_, ...) \
+	do { \
+		const struct queue_entry *entry, *next; \
+		for (entry = queue_get_entries(mp_->cbs); entry; \
+							entry = next) { \
+			struct local_player_cbs *cbs = entry->data; \
+			next = entry->next; \
+			if (cbs->cb->method_) \
+				cbs->cb->method_(__VA_ARGS__); \
+		} \
+	} while (0)
+
+static void local_player_emit_status_changed(struct local_player *mp)
+{
+	LOCAL_PLAYER_EMIT_CB(mp, status_changed, cbs->user_data);
+}
+
+static void local_player_emit_track_position(struct local_player *mp,
+					uint32_t old, uint32_t new)
+{
+	LOCAL_PLAYER_EMIT_CB(mp, track_position, old, new, cbs->user_data);
+}
+
+static void local_player_emit_track_changed(struct local_player *mp)
+{
+	LOCAL_PLAYER_EMIT_CB(mp, track_changed, cbs->user_data);
+}
+
+static void local_player_emit_settings_changed(struct local_player *mp,
+								const char *key)
+{
+	LOCAL_PLAYER_EMIT_CB(mp, settings_changed, key, cbs->user_data);
+}
+
+static void local_player_emit_player_removed(struct local_player *mp)
+{
+	LOCAL_PLAYER_EMIT_CB(mp, player_removed, cbs->user_data);
+}
+
+#undef LOCAL_PLAYER_EMIT_CB
+
+static void local_player_emit_player_added(struct local_player *mp)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(local_player_watches); entry;
+							entry = entry->next) {
+		struct local_player_watch *w = entry->data;
+
+		w->cb(mp, w->user_data);
+	}
+}
+
+static void local_player_destroy(struct local_player *mp)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
-	struct media_player *mp = data;
 	struct media_adapter *adapter = mp->adapter;
 
-	if (mp->player) {
-		adapter->players = g_slist_remove(adapter->players, mp);
-		release_player(mp);
-	}
+	DBG("sender=%s path=%s", mp->sender, mp->path);
+
+	local_player_emit_player_removed(mp);
+
+	queue_destroy(mp->cbs, free);
+	mp->cbs = NULL;
+
+	adapter->players = g_slist_remove(adapter->players, mp);
+	release_player(mp);
 
 	g_dbus_remove_watch(conn, mp->watch);
 	g_dbus_remove_watch(conn, mp->properties_watch);
@@ -1997,36 +2059,17 @@ static void media_player_free(gpointer data)
 	g_free(mp);
 }
 
-static void media_player_destroy(struct media_player *mp)
+static void local_player_remove(void *data)
 {
-	struct media_adapter *adapter = mp->adapter;
-
-	DBG("sender=%s path=%s", mp->sender, mp->path);
-
-	if (mp->player) {
-		struct avrcp_player *player = mp->player;
-		mp->player = NULL;
-		adapter->players = g_slist_remove(adapter->players, mp);
-		avrcp_unregister_player(player);
-		return;
-	}
-
-	media_player_free(mp);
-}
-
-static void media_player_remove(void *data)
-{
-	struct media_player *mp = data;
+	struct local_player *mp = data;
 
 	info("Player unregistered: sender=%s path=%s", mp->sender, mp->path);
 
-	media_player_destroy(mp);
+	local_player_destroy(mp);
 }
 
-static GList *media_player_list_settings(void *user_data)
+GList *local_player_list_settings(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	DBG("");
 
 	if (mp->settings == NULL)
@@ -2035,25 +2078,26 @@ static GList *media_player_list_settings(void *user_data)
 	return g_hash_table_get_keys(mp->settings);
 }
 
-static const char *media_player_get_setting(const char *key, void *user_data)
+const char *local_player_get_setting(struct local_player *mp, const char *key)
 {
-	struct media_player *mp = user_data;
-
 	DBG("%s", key);
 
 	return g_hash_table_lookup(mp->settings, key);
 }
 
-static const char *media_player_get_player_name(void *user_data)
+const char *local_player_get_player_name(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	if (!mp->name)
 		return "Player";
 
 	return mp->name;
 }
 
+bool local_player_have_track(struct local_player *mp)
+{
+	return mp->track;
+}
+
 static void set_shuffle_setting(DBusMessageIter *iter, const char *value)
 {
 	const char *key = "Shuffle";
@@ -2098,10 +2142,9 @@ static void set_repeat_setting(DBusMessageIter *iter, const char *value)
 	dbus_message_iter_close_container(iter, &var);
 }
 
-static int media_player_set_setting(const char *key, const char *value,
-				    void *user_data)
+int local_player_set_setting(struct local_player *mp, const char *key,
+							const char *value)
 {
-	struct media_player *mp = user_data;
 	const char *iface = MEDIA_PLAYER_INTERFACE;
 	DBusMessage *msg;
 	DBusMessageIter iter;
@@ -2136,10 +2179,8 @@ static int media_player_set_setting(const char *key, const char *value,
 	return 0;
 }
 
-static GList *media_player_list_metadata(void *user_data)
+GList *local_player_list_metadata(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	DBG("");
 
 	if (mp->track == NULL)
@@ -2148,22 +2189,8 @@ static GList *media_player_list_metadata(void *user_data)
 	return g_hash_table_get_keys(mp->track);
 }
 
-static uint64_t media_player_get_uid(void *user_data)
+const char *local_player_get_metadata(struct local_player *mp, const char *key)
 {
-	struct media_player *mp = user_data;
-
-	DBG("%p", mp->track);
-
-	if (mp->track == NULL)
-		return UINT64_MAX;
-
-	return 0;
-}
-
-static const char *media_player_get_metadata(const char *key, void *user_data)
-{
-	struct media_player *mp = user_data;
-
 	DBG("%s", key);
 
 	if (mp->track == NULL)
@@ -2172,16 +2199,13 @@ static const char *media_player_get_metadata(const char *key, void *user_data)
 	return g_hash_table_lookup(mp->track, key);
 }
 
-static const char *media_player_get_status(void *user_data)
+const char *local_player_get_status(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	return mp->status;
 }
 
-static uint32_t media_player_get_position(void *user_data)
+uint32_t local_player_get_position(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
 	double timedelta;
 	uint32_t sec, msec;
 
@@ -2196,14 +2220,12 @@ static uint32_t media_player_get_position(void *user_data)
 	return mp->position + sec * 1000 + msec;
 }
 
-static uint32_t media_player_get_duration(void *user_data)
+uint32_t local_player_get_duration(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	return mp->duration;
 }
 
-static bool media_player_send(struct media_player *mp, const char *name)
+static bool local_player_send(struct local_player *mp, const char *name)
 {
 	DBusMessage *msg;
 
@@ -2219,93 +2241,70 @@ static bool media_player_send(struct media_player *mp, const char *name)
 	return true;
 }
 
-static bool media_player_play(void *user_data)
+bool local_player_play(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	DBG("");
 
 	if (!mp->play || !mp->control)
 		return false;
 
-	return media_player_send(mp, "Play");
+	return local_player_send(mp, "Play");
 }
 
-static bool media_player_stop(void *user_data)
+bool local_player_stop(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	DBG("");
 
 	if (!mp->control)
 		return false;
 
-	return media_player_send(mp, "Stop");
+	return local_player_send(mp, "Stop");
 }
 
-static bool media_player_pause(void *user_data)
+bool local_player_pause(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	DBG("");
 
 	if (!mp->pause || !mp->control)
 		return false;
 
-	return media_player_send(mp, "Pause");
+	return local_player_send(mp, "Pause");
 }
 
-static bool media_player_next(void *user_data)
+bool local_player_next(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	DBG("");
 
 	if (!mp->next || !mp->control)
 		return false;
 
-	return media_player_send(mp, "Next");
+	return local_player_send(mp, "Next");
 }
 
-static bool media_player_previous(void *user_data)
+bool local_player_previous(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
-
 	DBG("");
 
 	if (!mp->previous || !mp->control)
 		return false;
 
-	return media_player_send(mp, "Previous");
+	return local_player_send(mp, "Previous");
 }
 
-static struct avrcp_player_cb player_cb = {
-	.list_settings = media_player_list_settings,
-	.get_setting = media_player_get_setting,
-	.set_setting = media_player_set_setting,
-	.list_metadata = media_player_list_metadata,
-	.get_uid = media_player_get_uid,
-	.get_metadata = media_player_get_metadata,
-	.get_position = media_player_get_position,
-	.get_duration = media_player_get_duration,
-	.get_status = media_player_get_status,
-	.get_name = media_player_get_player_name,
-	.play = media_player_play,
-	.stop = media_player_stop,
-	.pause = media_player_pause,
-	.next = media_player_next,
-	.previous = media_player_previous,
-};
-
-static void media_player_exit(DBusConnection *connection, void *user_data)
+struct btd_adapter *local_player_get_adapter(struct local_player *mp)
 {
-	struct media_player *mp = user_data;
+	return mp->adapter->btd_adapter;
+}
+
+static void local_player_exit(DBusConnection *connection, void *user_data)
+{
+	struct local_player *mp = user_data;
 
 	mp->watch = 0;
-	media_player_remove(mp);
+	local_player_remove(mp);
 }
 
-static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
+static gboolean set_status(struct local_player *mp, DBusMessageIter *iter)
 {
 	const char *value;
 
@@ -2318,21 +2317,21 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 	if (g_strcmp0(mp->status, value) == 0)
 		return TRUE;
 
-	mp->position = media_player_get_position(mp);
+	mp->position = local_player_get_position(mp);
 	g_timer_start(mp->timer);
 
 	g_free(mp->status);
 	mp->status = g_strdup(value);
 
-	avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, mp->status);
+	local_player_emit_status_changed(mp);
 
 	return TRUE;
 }
 
-static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
+static gboolean set_position(struct local_player *mp, DBusMessageIter *iter)
 {
 	uint64_t value;
-	const char *status;
+	uint32_t old_position;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT64)
 		return FALSE;
@@ -2341,46 +2340,24 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 
 	value /= 1000;
 
-	if (value > media_player_get_position(mp))
-		status = "forward-seek";
-	else
-		status = "reverse-seek";
-
+	old_position = local_player_get_position(mp);
 	mp->position = value;
 	g_timer_start(mp->timer);
 
 	DBG("Position=%u", mp->position);
 
-	if (!mp->position) {
-		avrcp_player_event(mp->player,
-					AVRCP_EVENT_TRACK_REACHED_START, NULL);
-		return TRUE;
-	}
-
-	/*
-	 * If position is the maximum value allowed or greater than track's
-	 * duration, we send a track-reached-end event.
-	 */
-	if (mp->position == UINT32_MAX || mp->position >= mp->duration) {
-		avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_END,
-									NULL);
-		return TRUE;
-	}
-
-	/* Send a status change to force resync the position */
-	avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, status);
-
+	local_player_emit_track_position(mp, old_position, mp->position);
 	return TRUE;
 }
 
-static void set_metadata(struct media_player *mp, const char *key,
+static void set_metadata(struct local_player *mp, const char *key,
 							const char *value)
 {
 	DBG("%s=%s", key, value);
 	g_hash_table_replace(mp->track, g_strdup(key), g_strdup(value));
 }
 
-static gboolean parse_string_metadata(struct media_player *mp, const char *key,
+static gboolean parse_string_metadata(struct local_player *mp, const char *key,
 							DBusMessageIter *iter)
 {
 	const char *value;
@@ -2395,7 +2372,7 @@ static gboolean parse_string_metadata(struct media_player *mp, const char *key,
 	return TRUE;
 }
 
-static gboolean parse_array_metadata(struct media_player *mp, const char *key,
+static gboolean parse_array_metadata(struct local_player *mp, const char *key,
 							DBusMessageIter *iter)
 {
 	DBusMessageIter array;
@@ -2419,7 +2396,7 @@ static gboolean parse_array_metadata(struct media_player *mp, const char *key,
 	return TRUE;
 }
 
-static gboolean parse_int64_metadata(struct media_player *mp, const char *key,
+static gboolean parse_int64_metadata(struct local_player *mp, const char *key,
 							DBusMessageIter *iter)
 {
 	uint64_t value;
@@ -2446,7 +2423,7 @@ static gboolean parse_int64_metadata(struct media_player *mp, const char *key,
 	return TRUE;
 }
 
-static gboolean parse_int32_metadata(struct media_player *mp, const char *key,
+static gboolean parse_int32_metadata(struct local_player *mp, const char *key,
 							DBusMessageIter *iter)
 {
 	uint32_t value;
@@ -2468,14 +2445,13 @@ static gboolean parse_int32_metadata(struct media_player *mp, const char *key,
 	return TRUE;
 }
 
-static gboolean parse_player_metadata(struct media_player *mp,
+static gboolean parse_player_metadata(struct local_player *mp,
 							DBusMessageIter *iter)
 {
 	DBusMessageIter dict;
 	DBusMessageIter var;
 	int ctype;
 	gboolean title = FALSE;
-	uint64_t uid;
 
 	ctype = dbus_message_iter_get_arg_type(iter);
 	if (ctype != DBUS_TYPE_ARRAY)
@@ -2540,15 +2516,13 @@ static gboolean parse_player_metadata(struct media_player *mp,
 
 	mp->position = 0;
 	g_timer_start(mp->timer);
-	uid = media_player_get_uid(mp);
 
-	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, &uid);
-	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_START, NULL);
+	local_player_emit_track_changed(mp);
 
 	return TRUE;
 }
 
-static gboolean set_property(struct media_player *mp, const char *key,
+static gboolean set_property(struct local_player *mp, const char *key,
 							const char *value)
 {
 	const char *curval;
@@ -2561,12 +2535,12 @@ static gboolean set_property(struct media_player *mp, const char *key,
 
 	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
 
-	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, key);
+	local_player_emit_settings_changed(mp, key);
 
 	return TRUE;
 }
 
-static gboolean set_shuffle(struct media_player *mp, DBusMessageIter *iter)
+static gboolean set_shuffle(struct local_player *mp, DBusMessageIter *iter)
 {
 	dbus_bool_t value;
 	const char *strvalue;
@@ -2593,7 +2567,7 @@ static const char *loop_status_to_repeat(const char *value)
 	return NULL;
 }
 
-static gboolean set_repeat(struct media_player *mp, DBusMessageIter *iter)
+static gboolean set_repeat(struct local_player *mp, DBusMessageIter *iter)
 {
 	const char *value;
 
@@ -2609,7 +2583,7 @@ static gboolean set_repeat(struct media_player *mp, DBusMessageIter *iter)
 	return set_property(mp, "Repeat", value);
 }
 
-static gboolean set_flag(struct media_player *mp, DBusMessageIter *iter,
+static gboolean set_flag(struct local_player *mp, DBusMessageIter *iter,
 								bool *var)
 {
 	dbus_bool_t value;
@@ -2624,7 +2598,7 @@ static gboolean set_flag(struct media_player *mp, DBusMessageIter *iter,
 	return TRUE;
 }
 
-static gboolean set_name(struct media_player *mp, DBusMessageIter *iter)
+static gboolean set_name(struct local_player *mp, DBusMessageIter *iter)
 {
 	const char *value;
 
@@ -2643,7 +2617,7 @@ static gboolean set_name(struct media_player *mp, DBusMessageIter *iter)
 	return TRUE;
 }
 
-static gboolean set_player_property(struct media_player *mp, const char *key,
+static gboolean set_player_property(struct local_player *mp, const char *key,
 							DBusMessageIter *entry)
 {
 	DBusMessageIter var;
@@ -2691,7 +2665,7 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 	return TRUE;
 }
 
-static gboolean parse_player_properties(struct media_player *mp,
+static gboolean parse_player_properties(struct local_player *mp,
 							DBusMessageIter *iter)
 {
 	DBusMessageIter dict;
@@ -2730,7 +2704,7 @@ static gboolean parse_player_properties(struct media_player *mp,
 static gboolean properties_changed(DBusConnection *connection, DBusMessage *msg,
 							void *user_data)
 {
-	struct media_player *mp = user_data;
+	struct local_player *mp = user_data;
 	DBusMessageIter iter;
 
 	DBG("sender=%s path=%s", mp->sender, mp->path);
@@ -2747,7 +2721,7 @@ static gboolean properties_changed(DBusConnection *connection, DBusMessage *msg,
 static gboolean position_changed(DBusConnection *connection, DBusMessage *msg,
 							void *user_data)
 {
-	struct media_player *mp = user_data;
+	struct local_player *mp = user_data;
 	DBusMessageIter iter;
 
 	DBG("sender=%s path=%s", mp->sender, mp->path);
@@ -2759,22 +2733,23 @@ static gboolean position_changed(DBusConnection *connection, DBusMessage *msg,
 	return TRUE;
 }
 
-static struct media_player *media_player_create(struct media_adapter *adapter,
+static struct local_player *local_player_create(struct media_adapter *adapter,
 						const char *sender,
 						const char *path,
 						int *err)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
-	struct media_player *mp;
+	struct local_player *mp;
 
-	mp = g_new0(struct media_player, 1);
+	mp = g_new0(struct local_player, 1);
 	mp->adapter = adapter;
 	mp->sender = g_strdup(sender);
 	mp->path = g_strdup(path);
 	mp->timer = g_timer_new();
+	mp->cbs = queue_new();
 
 	mp->watch = g_dbus_add_disconnect_watch(conn, sender,
-						media_player_exit, mp,
+						local_player_exit, mp,
 						NULL);
 	mp->properties_watch = g_dbus_add_properties_watch(conn, sender,
 						path, MEDIA_PLAYER_INTERFACE,
@@ -2784,14 +2759,6 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 						path, MEDIA_PLAYER_INTERFACE,
 						"Seeked", position_changed,
 						mp, NULL);
-	mp->player = avrcp_register_player(adapter->btd_adapter, &player_cb,
-							mp, media_player_free);
-	if (!mp->player) {
-		if (err)
-			*err = -EPROTONOSUPPORT;
-		media_player_destroy(mp);
-		return NULL;
-	}
 
 	mp->settings = g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
 								g_free);
@@ -2805,14 +2772,127 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 
 	return mp;
 }
-#endif /* HAVE_AVRCP */
+
+static bool match_local_player(const void *data, const void *match)
+{
+	const struct local_player_cbs *cbs = data;
+
+	return cbs->id == PTR_TO_UINT(match);
+}
+
+unsigned int local_player_register_callbacks(struct local_player *mp,
+			const struct local_player_callback *cb, void *user_data)
+{
+	struct local_player_cbs *cbs;
+	unsigned int id = 1;
+
+	if (!cb)
+		return 0;
+
+	while (id && queue_find(mp->cbs, match_local_player, UINT_TO_PTR(id)))
+		id++;
+	if (!id)
+		return 0;
+
+	cbs = new0(struct local_player_cbs, 1);
+	cbs->mp = mp;
+	cbs->id = id;
+	cbs->cb = cb;
+	cbs->user_data = user_data;
+
+	queue_push_tail(mp->cbs, cbs);
+
+	return id;
+}
+
+void local_player_unregister_callbacks(struct local_player *mp, unsigned int id)
+{
+	struct local_player_cb *cbs;
+
+	cbs = queue_remove_if(mp->cbs, match_local_player, UINT_TO_PTR(id));
+	free(cbs);
+}
+
+static bool match_local_player_watch(const void *data, const void *match)
+{
+	const struct local_player_watch *w = data;
+
+	return w->id == PTR_TO_UINT(match);
+}
+
+static void local_player_watch_added(void *data, void *user_data)
+{
+	struct local_player *mp = data;
+	struct local_player_watch *w = user_data;
+
+	w->cb(mp, w->user_data);
+}
+
+unsigned int local_player_register_watch(local_player_added_t cb,
+							void *user_data)
+{
+	struct local_player_watch *w;
+	unsigned int id = 1;
+	GSList *l;
+
+	if (!cb)
+		return 0;
+
+	while (id && queue_find(local_player_watches, match_local_player_watch,
+							UINT_TO_PTR(id)))
+		id++;
+	if (!id)
+		return 0;
+
+	w = new0(struct local_player_watch, 1);
+	w->id = id;
+	w->cb = cb;
+	w->user_data = user_data;
+
+	if (!local_player_watches)
+		local_player_watches = queue_new();
+	queue_push_tail(local_player_watches, w);
+
+	/* Emit existing */
+	for (l = adapters; l; l = l->next) {
+		struct media_adapter *adapter = l->data;
+		const struct queue_entry *entry;
+		GSList *pl;
+
+		for (pl = adapter->players; pl; pl = pl->next)
+			local_player_watch_added(pl->data, w);
+
+		for (entry = queue_get_entries(adapter->apps); entry;
+							entry = entry->next) {
+			struct media_app *app = entry->data;
+
+			queue_foreach(app->players, local_player_watch_added,
+									w);
+		}
+	}
+
+	return id;
+}
+
+void local_player_unregister_watch(unsigned int id)
+{
+	struct local_player_watch *w;
+
+	w = queue_remove_if(local_player_watches, match_local_player_watch,
+							UINT_TO_PTR(id));
+	free(w);
+
+	if (queue_isempty(local_player_watches)) {
+		queue_destroy(local_player_watches, NULL);
+		local_player_watches = NULL;
+	}
+}
 
 static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
-#ifdef HAVE_AVRCP
 	struct media_adapter *adapter = data;
-	struct media_player *mp;
+	struct local_player *mp;
 	DBusMessageIter args;
 	const char *sender, *path;
 	int err;
@@ -2827,7 +2907,7 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 	if (media_adapter_find_player(adapter, sender, path) != NULL)
 		return btd_error_already_exists(msg);
 
-	mp = media_player_create(adapter, sender, path, &err);
+	mp = local_player_create(adapter, sender, path, &err);
 	if (mp == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
@@ -2836,22 +2916,20 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (parse_player_properties(mp, &args) == FALSE) {
-		media_player_destroy(mp);
+		local_player_destroy(mp);
 		return btd_error_invalid_args(msg);
 	}
 
+	local_player_emit_player_added(mp);
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-#else
-	return btd_error_not_supported(msg);
-#endif
 }
 
 static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
-#ifdef HAVE_AVRCP
 	struct media_adapter *adapter = data;
-	struct media_player *player;
+	struct local_player *player;
 	const char *sender, *path;
 
 	if (!dbus_message_get_args(msg, NULL,
@@ -2865,12 +2943,9 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	if (player == NULL)
 		return btd_error_does_not_exist(msg);
 
-	media_player_remove(player);
+	local_player_remove(player);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-#else
-	return btd_error_not_supported(msg);
-#endif
 }
 
 static void app_free(void *data)
@@ -2879,9 +2954,7 @@ static void app_free(void *data)
 
 	queue_destroy(app->proxies, NULL);
 	queue_destroy(app->endpoints, media_endpoint_remove);
-#ifdef HAVE_AVRCP
-	queue_destroy(app->players, media_player_remove);
-#endif
+	queue_destroy(app->players, local_player_remove);
 
 	if (app->client) {
 		g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
@@ -3092,12 +3165,11 @@ fail:
 
 static void app_register_player(void *data, void *user_data)
 {
-#ifdef HAVE_AVRCP
 	struct media_app *app = user_data;
 	GDBusProxy *proxy = data;
 	const char *iface = g_dbus_proxy_get_interface(proxy);
 	const char *path = g_dbus_proxy_get_path(proxy);
-	struct media_player *player;
+	struct local_player *player;
 	DBusMessageIter iter;
 
 	if (app->err)
@@ -3106,7 +3178,7 @@ static void app_register_player(void *data, void *user_data)
 	if (strcmp(iface, MEDIA_PLAYER_INTERFACE))
 		return;
 
-	player = media_player_create(app->adapter, app->sender, path,
+	player = local_player_create(app->adapter, app->sender, path,
 							&app->err);
 	if (!player)
 		return;
@@ -3166,6 +3238,8 @@ static void app_register_player(void *data, void *user_data)
 			goto fail;
 	}
 
+	local_player_emit_player_added(player);
+
 	queue_push_tail(app->players, player);
 
 	return;
@@ -3173,8 +3247,7 @@ fail:
 	app->err = -EINVAL;
 	error("Unable to register player %s:%s: %s", app->sender, path,
 							strerror(-app->err));
-	media_player_destroy(player);
-#endif /* HAVE_AVRCP */
+	local_player_destroy(player);
 }
 
 static void remove_app(void *data)
@@ -3223,11 +3296,7 @@ static void client_ready_cb(GDBusClient *client, void *user_data)
 		goto reply;
 	}
 
-#ifdef HAVE_AVRCP
 	if ((queue_isempty(app->endpoints) && queue_isempty(app->players))) {
-#else
-	if (queue_isempty(app->endpoints)) {
-#endif
 		error("No valid external Media objects found");
 		fail = true;
 		reply = btd_error_failed(app->reg,
@@ -3276,15 +3345,13 @@ static bool match_endpoint_by_path(const void *a, const void *b)
 	return !strcmp(endpoint->path, path);
 }
 
-#ifdef HAVE_AVRCP
 static bool match_player_by_path(const void *a, const void *b)
 {
-	const struct media_player *player = a;
+	const struct local_player *player = a;
 	const char *path = b;
 
 	return !strcmp(player->path, path);
 }
-#endif
 
 static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 {
@@ -3308,9 +3375,8 @@ static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 		DBG("Proxy removed - removing endpoint: %s", endpoint->path);
 
 		media_endpoint_remove(endpoint);
-#ifdef HAVE_AVRCP
 	} else if (!strcmp(iface, MEDIA_PLAYER_INTERFACE)) {
-		struct media_player *player;
+		struct local_player *player;
 
 		player = queue_remove_if(app->players, match_player_by_path,
 						(void *) path);
@@ -3322,8 +3388,7 @@ static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 
 		DBG("Proxy removed - removing player: %s", player->path);
 
-		media_player_remove(player);
-#endif
+		local_player_remove(player);
 	}
 }
 
@@ -3352,9 +3417,7 @@ static struct media_app *create_app(DBusConnection *conn, DBusMessage *msg,
 
 	app->proxies = queue_new();
 	app->endpoints = queue_new();
-#ifdef HAVE_AVRCP
 	app->players = queue_new();
-#endif
 	app->reg = dbus_message_ref(msg);
 
 	g_dbus_client_set_disconnect_watch(app->client, client_disconnect_cb,
@@ -3588,15 +3651,13 @@ static void path_free(void *data)
 		release_endpoint(endpoint);
 	}
 
-#ifdef HAVE_AVRCP
 	for (l = adapter->players; l;) {
-		struct media_player *mp = l->data;
+		struct local_player *mp = l->data;
 
 		l = g_slist_next(l);
 
-		media_player_destroy(mp);
+		local_player_destroy(mp);
 	}
-#endif
 
 	adapters = g_slist_remove(adapters, adapter);
 
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 380951f28..28174a017 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -10,6 +10,7 @@
  */
 
 struct media_endpoint;
+struct local_player;
 
 typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
 					void *ret, int size, void *user_data);
@@ -26,3 +27,47 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
 bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
 
 const struct media_endpoint *media_endpoint_get_asha(void);
+
+/*
+ * Local media player
+ */
+struct local_player_callback {
+	void (*status_changed)(void *user_data);
+	void (*track_position)(uint32_t old_ms, uint32_t new_ms,
+							void *user_data);
+	void (*track_changed)(void *user_data);
+	void (*settings_changed)(const char *key, void *user_data);
+
+	/* Player removed (no further callbacks) */
+	void (*player_removed)(void *user_data);
+};
+
+unsigned int local_player_register_callbacks(struct local_player *lp,
+		const struct local_player_callback *cb, void *user_data);
+void local_player_unregister_callbacks(struct local_player *lp,
+							unsigned int id);
+
+struct btd_adapter *local_player_get_adapter(struct local_player *lp);
+
+GList *local_player_list_settings(struct local_player *lp);
+const char *local_player_get_setting(struct local_player *lp, const char *key);
+int local_player_set_setting(struct local_player *lp, const char *key,
+							const char *value);
+const char *local_player_get_metadata(struct local_player *lp, const char *key);
+GList *local_player_list_metadata(struct local_player *lp);
+const char *local_player_get_status(struct local_player *lp);
+uint32_t local_player_get_position(struct local_player *lp);
+uint32_t local_player_get_duration(struct local_player *lp);
+const char *local_player_get_player_name(struct local_player *lp);
+bool local_player_have_track(struct local_player *lp);
+bool local_player_play(struct local_player *lp);
+bool local_player_stop(struct local_player *lp);
+bool local_player_pause(struct local_player *lp);
+bool local_player_next(struct local_player *lp);
+bool local_player_previous(struct local_player *lp);
+
+typedef void (*local_player_added_t)(struct local_player *lp, void *user_data);
+
+unsigned int local_player_register_watch(local_player_added_t cb,
+							void *user_data);
+void local_player_unregister_watch(unsigned int id);
-- 
2.51.1

