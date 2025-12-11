Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD23313E3A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484173; cv=pass; b=naBMbU+92XXq+LDhU7762Po86yn68v9UHih61CsOwCoyadv8VruvHDel5BLyvzo96qBwkxNyODHXQz7gAjs3qvMiyWsGGjF4wQmTx7SAzcGk/9134+gUjz+jZLWNnNFTD5ujOVxKr2TAid3aYFJxIpCZ3E2oCa2EFO2ABEiS0js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484173; c=relaxed/simple;
	bh=/n4e5I/XTM/KQBFyxfeq/dPMMxdRjNb7Ug5uIraNfaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyZ9AG7sd65yhVX82x1Ogwi1B7rB1NQHrZXpjf1G/10/APCCI/WI00bIzpzBVUJPfn5lbbXxAqXtd6gc3IVeSKLyVL+okQy+rqM5D8vpoCmxjpHXVjO1vMTByZyV6qkQJRCZRPNdQjmNTVPSQeOL0Up2ifIk+GrREY38iai1zFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=B6Y2ajYa; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="B6Y2ajYa"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dS3kd4HLbzydB;
	Thu, 11 Dec 2025 22:16:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765484170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5RM3ZvKXQukVeuTHbtmCYBqZakoM2UVRNtL2etGEmw=;
	b=B6Y2ajYa3Hhk2NLnxkHhsR7QmykqTFN3N1OOJggf+/SGB/j2RJrpevnc87Q6YFrVBEtE1F
	/i/MHpIqwyw2XJ0SRjYn3twWAgX0H801/B0GGVJKd1Zs01wnfjG2ZbjlW9UPOK/XPyrrEf
	rt+sSlAANXIi1Wyff7nKhQjmBFDspr4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765484170;
	b=RdJCPwGbPDNYFpgZD1EIa1OA/3hVg0fZ9SxxwN2WU6ot/9/R8bnVa204BgQpdnBGpKTS6M
	qc7iy2KPqy+tIf8Pep4cY8k3w1zxAql2V11CCTUwhzUo6IUYm+WmjWcl6YdJl2vM5Hf1O3
	i6JlLAuZeTi/cx5WjQyaDDbE/WcUvzE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765484170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5RM3ZvKXQukVeuTHbtmCYBqZakoM2UVRNtL2etGEmw=;
	b=hbIR+s+ScNwwfmLZTUvwOCfxp3W8e4FUXpAsN2UZkj7P6LphgbdmragxFH3htfTTJ313UN
	iZiDrBDyvGfzibO05pE4Da4bddAplgkgXYw5ioxhbHMLZYlHQ0elkgO7/+mCYRglCzJ0PB
	KKuceYW8vnu6fLGOJxdmXSz+/FHey6U=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 6/7] mcp: add local GMCS service that emits uinput media keys
Date: Thu, 11 Dec 2025 22:15:58 +0200
Message-ID: <8bb2bae1c7ef8788f287ae225fa0ae1088373169.1765484150.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765484150.git.pav@iki.fi>
References: <cover.1765484150.git.pav@iki.fi>
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

 profiles/audio/mcp.c | 173 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index e64cbd01d..cf746e325 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -23,6 +23,8 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <math.h>
+#include <unistd.h>
+#include <linux/uinput.h>
 
 #include <glib.h>
 
@@ -42,6 +44,7 @@
 #include "src/shared/gatt-server.h"
 #include "src/shared/mcp.h"
 #include "src/shared/mcs.h"
+#include "src/shared/uinput-util.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -433,6 +436,151 @@ static const struct bt_mcp_callback mcp_cb = {
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
+	struct bt_uinput *uinput;
+	struct btd_adapter *adapter;
+	struct bt_mcs *mcs;
+	struct queue *players;
+};
+
+static const struct bt_uinput_key_map key_map[] = {
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
+	if (!gmcs->uinput)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(key_map); ++i) {
+		if (key_map[i].code == cmd) {
+			DBG("GMCS press %s", key_map[i].name);
+			bt_uinput_send_key(gmcs->uinput, key_map[i].uinput, 1);
+			bt_uinput_send_key(gmcs->uinput, key_map[i].uinput, 0);
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
+	DBG("destroy %p", data);
+
+	queue_remove(servers, gmcs);
+
+	bt_uinput_destroy(gmcs->uinput);
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
+static void uinput_debug(const char *str, void *data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static struct gmcs *gmcs_new(struct btd_adapter *adapter)
+{
+	struct gmcs *gmcs;
+	const char *name = btd_adapter_get_name(adapter);
+
+	gmcs = new0(struct gmcs, 1);
+	gmcs->adapter = adapter;
+	gmcs->uinput = bt_uinput_new(name, " (MCS)",
+				btd_adapter_get_address(adapter), NULL, key_map,
+				uinput_debug, gmcs);
+	if (!gmcs->uinput)
+		error("MCS: failed to init uinput for %s: %m", name);
+
+	DBG("new %p", gmcs);
+
+	return gmcs;
+}
+
 /*
  * Profile
  */
@@ -510,11 +658,36 @@ static void mcp_remove(struct btd_service *service)
 
 static int gmcs_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct gatt_db *db = btd_gatt_database_get_db(database);
+	struct gmcs *gmcs;
+
+	DBG("Add GMCS server %s", adapter_get_path(adapter));
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
+	DBG("Remove GMCS server %s", adapter_get_path(adapter));
+	bt_mcs_unregister_all(db);
 }
 
 static struct btd_profile mcp_gmcs_profile = {
-- 
2.51.1

