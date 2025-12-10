Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABA2E9EC3
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383211; cv=pass; b=LA4iZ5NyD8V55traHWKjcqRJvBTauJkZzsghj19B0bOMiECcsWhiXcmlpmXibsnej5DJIOr26F9f+TMjonr3FhW+3+Xs8oucJQxzWd5jFndGd3cUguHqna+hzxJYhtTDHI0aQH5KzqGAFoSWqcyXgySFhGrV+NtAMzF51T6vOBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383211; c=relaxed/simple;
	bh=4JtXGlfSP9DJ6vmbIbuKGNyQRZDfI+zmshF/XoAVUz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTYI89zSthtoAV7r5UwP7CEalaMTUa7O+XSt8vVPfVUrLAyWWX1WCwdOaoFBEYG4xP9UVWpqNv3O2FNYhc0JrCpnP1P5EUwCDBfKqlzmzdJ8d49D0PvwTGhLx+jTfecdqUh0GkCIGrRY5pEX+sPLovlE/jcMgunvsZxN+CIBOf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=s7wgXkz4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="s7wgXkz4"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRLP14Nn1z105k;
	Wed, 10 Dec 2025 18:13:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765383206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kya0Q6Qe2LcuX1uvuhmfu2D4MwPSUQMcs0Um4+KrFDc=;
	b=s7wgXkz4qFR4jvYcjEaZiQQJHMilSOEtI4vOyMDjS3SXpykgNRcb6QfrT9QrYJmJsQnYud
	SV4EDxWIuktqkw5DndSQ0GsAmqPHsibrAnCXOmxhr79eSMF0wUI0DYKZIkyRjm8KYSQqmv
	+SyvBnBmOunfnS0mPX6uVqWOOP+f2Bo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765383206;
	b=xYsNuAN3H9FDExwFxqRT/q2RkpG/i3H3Irt9Mtai9HDsDe9UegKB3WYf2tz05gNmzcwGTA
	Biza3NyNaRdp1c/abIa17Mn4/gVxsyMTm1dF4GBO4ZcAkDvJUzaPlRE4hJiVVPVlOluWa6
	wgHbDXHuVnFw2S4zzN0AMxcetxua6yk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765383206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kya0Q6Qe2LcuX1uvuhmfu2D4MwPSUQMcs0Um4+KrFDc=;
	b=HbriZ6Vl89d+7JkPUnXGqnIj/F8UegFkduyA4kYzJH9Q5/jpophICQRzMV0iz9yZ+cSR2/
	dmWVMD7tm9I3cyDHs410pe+pT3MZRzRmMCIIkV08EGg1BQTtPDd4CrW4Ht7G6j/L989F+k
	RWUoedGRgyF5G7L658Hr+2swk0woqy4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 6/7] mcp: add local GMCS service that emits uinput media keys
Date: Wed, 10 Dec 2025 18:13:14 +0200
Message-ID: <3b8c22f8d714738bfcecfec2422a92d4c87c32fb.1765383173.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765383173.git.pav@iki.fi>
References: <cover.1765383173.git.pav@iki.fi>
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

