Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D633126B6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314947; cv=pass; b=WwHOosP7XL3B9zapoYXno8nzNsUT2X3UNNqvnmQyY6etEWOVPgufyK0k23+GSdlINb7yajG6cAByoYsJ1YobfSH+9BPREV1/27XOJdn8MPNe7rWahmzYwmUv7pfQRMpmrf45auWt1+XC6JreaWANoZNJFZu1POJUovBTn4Ib/+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314947; c=relaxed/simple;
	bh=PDFTXP64TmKxAQDctqhaMgsYcvimHEiLiZc9TW+763Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPunbFub7fOuyujKCbuy1Cqyr2mqybW7egmhHkIxHK+2mB2bQiqweUg7PTMS9u9qC00msboedMDf5q5JBv8u5A2cDf4V9wg7I6G4+vgcvwZPy2YYZ58xylY21vGj6zv+u0tw7JEGV71E/b/8agv/9HfqwhuYXb6Wx7prOHPwD1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Uf6rRrfp; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Uf6rRrfp"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dQs8H0g1LzyQH;
	Tue,  9 Dec 2025 23:15:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765314943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+X6KHrJTwYsESu3CgpIfuFi6pZeOFIdmh5JniDpWB0=;
	b=Uf6rRrfpwaFEIc7tlj9NEj3weHWT9zJrD4mWfNjGqCv6nhE123necxP8BmuFdplrBXfvOd
	OASIxV7F37rYPWT5+Zl72RjlOAQopQFGO0rHIFSUbhljuVPVwV0szBlffC2oeR2aDgvTVF
	NHki00A2XUtAqiuethlU20b0wbOAFwQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765314943;
	b=UUdXYE0ubvmBNEUUhU29W8M3AfY0hrcbrJgfs15gGLP8FOZHWiZmG6p+Nv84iInLQoO0yC
	+oPUYucDBIvGl2TtPkJ4N5hy35dQ8sn522Vo7B+jEcSyeI/zKxxtMW8TiFp2lGL+LqFcJ6
	4KWEv6dvaFg1GwDrPZxe4EY0Vab9DlA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765314943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+X6KHrJTwYsESu3CgpIfuFi6pZeOFIdmh5JniDpWB0=;
	b=AV8+FHhjQoqGCIw14hr0fhXjs/WB7Wn+HHCPURsx9ZJK7QnpZnkldZcdKTflpdKDqsBsLV
	Tj+Y+BBVeZsRDpZmKgSxEHdP9vm1He4+3xrbn67G1ticLwlSV37xSXJk9yNEGdl/JkRZh8
	2R92baTrRFLpzq6/OoMwA7KWo6SqbpE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/6] mcp: add local GMCS service that emits uinput media keys
Date: Tue,  9 Dec 2025 23:15:22 +0200
Message-ID: <821eab6f3ae0e169b0631fd248e3d9b8b7f9ce86.1765314903.git.pav@iki.fi>
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

 profiles/audio/mcp.c | 162 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 6fd0cab11..acc143d8c 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -23,6 +23,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <math.h>
+#include <linux/uinput.h>
 
 #include <glib.h>
 
@@ -434,6 +435,145 @@ static const struct bt_mcp_callback mcp_cb = {
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
@@ -511,11 +651,33 @@ static void mcp_remove(struct btd_service *service)
 
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

