Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A69030E82B
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381466; cv=pass; b=VnQaxkVp+DyIdc7KS3Xc2G2mGT166FjrP2JtunufkZc6CmHslNeuCxqZOfvx+zVYcp6zlv9lfEjRzC8njFkkFyR9ohNd+KWKziTLJ8FwPXH9XlU2/tazB0/tLOTNBevscoxUWsBN88zaDXxzdZ5braLEIygulWPbLlxiwAplALc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381466; c=relaxed/simple;
	bh=4JtXGlfSP9DJ6vmbIbuKGNyQRZDfI+zmshF/XoAVUz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjWAzwV3bSoiRhXzScRDN9x++G3mUv0bf+bbZ7RR6O886wXT89dz/On7YGWOoHIdEm5C0euRCdYI08Dt7d16QU+LMmBxOFGuPzTOpnaIMZ3dE0DUvW0uEkCGfFa0YHbuJpX2ghVrpeQiDYJyD0ft3ysqnsUtOlsSIh0AcIkFND0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rAje9xwe; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rAje9xwe"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRKlV0WXGz108R;
	Wed, 10 Dec 2025 17:44:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765381462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kya0Q6Qe2LcuX1uvuhmfu2D4MwPSUQMcs0Um4+KrFDc=;
	b=rAje9xweONITdO4mkOcqd3oB4h5u3gRyYwyi1xtoy+Z7EHCHciKZxpOUK3tbVrQnNtSfei
	K972mz9ggC7Im9CxQYC5UWiFTfo2xmHz/T0oHqKIbXT3fZZMsd9PYnsFSWc0vM87EHuMsn
	/ZF9rXUgY3Y8DOZ0ug9irETXQGKpLs0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765381462;
	b=FR9Vuq0Pwu0mWW9P1bJBFQZBCZy0O63C0Gadb4ZmDeIZmXZ9QDniMM4lGDIg/d5Y36JNhK
	B0loJmsAlZqCtGymnlIPLGQoDRWMdjm1H/tM1GKerQPvhyRx1aQR5KvFigkOwAMyIg4foy
	yR0ejIeWtkiu5Y2N/ulUzrRPJrHYuBg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765381462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kya0Q6Qe2LcuX1uvuhmfu2D4MwPSUQMcs0Um4+KrFDc=;
	b=rsNtU/anWAU5SGYsRNzhhZZ6sn9KxGKl4d84gBTvE3pCRmjh0EjcMgWF2UR2mvlwwU7eLr
	ys0/fSuka04S7koNBEOhobtksStNDgNj/KL78Jym/x9+ztVxBJS9nmzqlwF+G2O+zkm0Lh
	BYL+9U4ja0Fvc4jOMB+wydBTCQ+4fa0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 6/7] mcp: add local GMCS service that emits uinput media keys
Date: Wed, 10 Dec 2025 17:44:11 +0200
Message-ID: <bcc4f0c971347cceb1201c502c25ddd405bad24a.1765381438.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765381438.git.pav@iki.fi>
References: <cover.1765381438.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement simple GMCS service that is always inactive, and emits media
key presses via uinput for Play/Pause/Stop/Next/Prev MCS commands.

In practice, this seems to be enough to support media control keys on
headsets.  Some headsets (Creative Zen Hybrid Pro) also refuse to
connect if there is no GMCS service.
---

Notes:
    Tested production devices:
    
    - Creative Zen Hybrid Pro (doesn't even connect without GMCS)
    - Samsung Galaxy Buds Pro2

 profiles/audio/mcp.c | 163 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index e64cbd01d..acc143d8c 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -23,6 +23,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <math.h>
+#include <linux/uinput.h>
 
 #include <glib.h>
 
@@ -54,6 +55,7 @@
 #include "src/error.h"
 
 #include "player.h"
+#include "uinput-util.h"
 
 #define MCS_UUID_STR	"00001848-0000-1000-8000-00805f9b34fb"
 #define GMCS_UUID_STR	"00001849-0000-1000-8000-00805f9b34fb"
@@ -433,6 +435,145 @@ static const struct bt_mcp_callback mcp_cb = {
 };
 
 
+/*
+ * Local player
+ */
+
+struct gmcs;
+
+struct local_player {
+	struct bt_mcs *mcs;
+	struct media_player *mp;
+	struct gmcs *gmcs;
+};
+
+struct gmcs {
+	int uinput;
+	struct btd_adapter *adapter;
+	struct bt_mcs *mcs;
+	struct queue *players;
+};
+
+static const struct uinput_key_map key_map[] = {
+	{ "Play",	BT_MCS_CMD_PLAY,		KEY_PLAYCD },
+	{ "Stop",	BT_MCS_CMD_STOP,		KEY_STOPCD },
+	{ "Pause",	BT_MCS_CMD_PAUSE,		KEY_PAUSECD },
+	{ "Next Track",	BT_MCS_CMD_NEXT_TRACK,		KEY_NEXTSONG },
+	{ "Prev Track",	BT_MCS_CMD_PREV_TRACK,		KEY_PREVIOUSSONG },
+	{ NULL }
+};
+
+static struct queue *servers;
+
+static bool gmcs_command(struct gmcs *gmcs, uint8_t cmd)
+{
+	unsigned int i;
+
+	/* Emulate media key press */
+	if (gmcs->uinput < 0)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(key_map); ++i) {
+		if (key_map[i].code == cmd) {
+			DBG("GMCS press %s", key_map[i].name);
+			uinput_send_key(gmcs->uinput, key_map[i].uinput, 1);
+			uinput_send_key(gmcs->uinput, key_map[i].uinput, 0);
+			break;
+		}
+	}
+
+	/* We are always inactive, so command does not cause state changes and
+	 * does not succeed, even though we do generate the key presses.
+	 * This should be OK vs. MCP v1.0.1 p. 26
+	 */
+	return false;
+}
+
+static bool gmcs_play(void *data)
+{
+	return gmcs_command(data, BT_MCS_CMD_PLAY);
+}
+
+static bool gmcs_pause(void *data)
+{
+	return gmcs_command(data, BT_MCS_CMD_PAUSE);
+}
+
+static bool gmcs_stop(void *data)
+{
+	return gmcs_command(data, BT_MCS_CMD_STOP);
+}
+
+static bool gmcs_next_track(void *data)
+{
+	return gmcs_command(data, BT_MCS_CMD_NEXT_TRACK);
+}
+
+static bool gmcs_previous_track(void *data)
+{
+	return gmcs_command(data, BT_MCS_CMD_PREV_TRACK);
+}
+
+static void gmcs_media_player_name(void *data, struct iovec *buf, size_t size)
+{
+	struct gmcs *gmcs = data;
+	int len;
+
+	len = snprintf((void *)buf->iov_base, size, "%s",
+					btd_adapter_get_name(gmcs->adapter));
+	if (len < 0)
+		len = 0;
+	else if ((size_t)len > size)
+		len = size;
+	util_iov_push(buf, len);
+}
+
+static void gmcs_destroy(void *data)
+{
+	struct gmcs *gmcs = data;
+
+	DBG_IDX(0xffff, "destroy %p", data);
+
+	queue_remove(servers, gmcs);
+
+	if (gmcs->uinput >= 0)
+		close(gmcs->uinput);
+
+	free(gmcs);
+}
+
+static void gmcs_debug(void *data, const char *str)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static const struct bt_mcs_callback gmcs_cb = {
+	.media_player_name = gmcs_media_player_name,
+	.play = gmcs_play,
+	.pause = gmcs_pause,
+	.stop = gmcs_stop,
+	.next_track = gmcs_next_track,
+	.previous_track = gmcs_previous_track,
+	.debug = gmcs_debug,
+	.destroy = gmcs_destroy,
+};
+
+static struct gmcs *gmcs_new(struct btd_adapter *adapter)
+{
+	struct gmcs *gmcs;
+	const char *name = btd_adapter_get_name(adapter);
+
+	gmcs = new0(struct gmcs, 1);
+	gmcs->adapter = adapter;
+	gmcs->uinput = uinput_create(adapter, NULL, name, " (MCS)", key_map);
+	if (gmcs->uinput < 0)
+		error("MCS: failed to init uinput for %s", name);
+
+	DBG_IDX(0xffff, "new %p", gmcs);
+
+	return gmcs;
+}
+
 /*
  * Profile
  */
@@ -510,11 +651,33 @@ static void mcp_remove(struct btd_service *service)
 
 static int gmcs_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct gatt_db *db = btd_gatt_database_get_db(database);
+	struct gmcs *gmcs;
+
+	gmcs = gmcs_new(adapter);
+	if (!gmcs)
+		return -EINVAL;
+
+	gmcs->mcs = bt_mcs_register(db, true, &gmcs_cb, gmcs);
+	if (!gmcs->mcs) {
+		gmcs_destroy(gmcs);
+		return -EINVAL;
+	}
+
+	if (!servers)
+		servers = queue_new();
+	queue_push_tail(servers, gmcs);
+
 	return 0;
 }
 
 static void gmcs_remove(struct btd_profile *p, struct btd_adapter *adapter)
 {
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct gatt_db *db = btd_gatt_database_get_db(database);
+
+	bt_mcs_unregister_all(db);
 }
 
 static struct btd_profile mcp_gmcs_profile = {
-- 
2.51.1

