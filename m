Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843F2D6E4A
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572372; cv=pass; b=WBCrSgkLhtwGURJtkr2SOEYSAxXA6fMua41CaYU5iraA5AWSr07LhcfML5GwpJnrJFJAYXqHvcnjJksZgwUmgX/MDGSPafosrs15X+GOWYHFxzvvVe6YtTtE16uzo9+2yObfY2vGkNjZwc9PQEzCgPk02dW/g49D3YMilqH7gmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572372; c=relaxed/simple;
	bh=pwV+id0flGnJM0UFgptXp3riKKk8WhgmopsguVzw7pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlqhdI77PamiIarc4rzh4cbRgQDKszZpVXWQXvyGoHJRNpdqSUibApodLjxaOvNAa3mg16f9V6E6H9Ty0yZl8FPWa71L4P2kj5VGpohrGhZO+NYpQZ51CSRaWKpyI8JnVmS+T2qrMvDaYDtWcLpSRWHHyopa/n/gzjJEeYBsUFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=g7T73l8Z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="g7T73l8Z"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dShLk3WLCz1065;
	Fri, 12 Dec 2025 22:46:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765572366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANsIsryjUbOiqCZpWc/OhGYvKdKtAph3xopKOoEUnnw=;
	b=g7T73l8ZHZhP+pWQn8UpCMcxVf0W7LhYjEigU7te3o1Hft36qPdCl5nKiZs9UiJe8z8WBA
	U70Z1bcL4rDbHQtalhTWFiln323nNn6KLG7aWsv+CVLVYROlmQHcdF6MblMT/eB6l0zcwb
	eYboAJ3WnMJAsNRwm/ifOih1F1MSm+A=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765572366;
	b=e664ilMffXCqz96M9U16NYPkDWWbntbDMwuapklwHTnRDZnQ5yKxNP287yXR3XESaC2DAy
	nHqO+l/vfxtwvbYDeiMwEWKv6hCxTj1bb4CXEE2VJJD8+nUpVnLZZsJ+X+aUXyEtSdZVCM
	MYG648S/teW+muy++653AlnJX5rUbRI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765572366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANsIsryjUbOiqCZpWc/OhGYvKdKtAph3xopKOoEUnnw=;
	b=sXHwhza5Q/SCmpwJtIgmNtl6Yj0ar1+elEeV8H+efRq/8EIGasTr8FO2nAAIJL2DDohw2V
	q51gAsou9pmg72XJgIkRuCHiVIOl6rFAPtSem/BdQIH93+aUC+A6LDIxDTBnVE7NwR83zK
	PRC5CgMgpLxeoWi60Vm2Jfvh6UUfLOs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 6/9] mcp: add local GMCS service that emits uinput media keys
Date: Fri, 12 Dec 2025 22:45:51 +0200
Message-ID: <c1d595aa93f5f328ca73d0f2f328ffa803fa1abf.1765572338.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765572338.git.pav@iki.fi>
References: <cover.1765572338.git.pav@iki.fi>
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

 profiles/audio/mcp.c | 180 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 48e65d497..fc0587ce3 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -22,6 +22,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <unistd.h>
+#include <linux/uinput.h>
 
 #include <glib.h>
 
@@ -41,6 +43,7 @@
 #include "src/shared/gatt-server.h"
 #include "src/shared/mcp.h"
 #include "src/shared/mcs.h"
+#include "src/shared/uinput.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -420,6 +423,158 @@ static const struct bt_mcp_callback mcp_cb = {
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
+	int err;
+
+	gmcs = new0(struct gmcs, 1);
+	gmcs->adapter = adapter;
+
+	gmcs->uinput = bt_uinput_new(name, " (MCS)",
+			btd_adapter_get_address(adapter), NULL);
+	bt_uinput_set_debug(gmcs->uinput, uinput_debug, gmcs);
+
+	err = bt_uinput_create(gmcs->uinput, key_map);
+	if (err < 0) {
+		error("MCS: failed to init uinput for %s: %s", name,
+								strerror(-err));
+		bt_uinput_destroy(gmcs->uinput);
+		gmcs->uinput = NULL;
+	}
+
+	DBG("new %p", gmcs);
+	return gmcs;
+}
+
 /*
  * Profile
  */
@@ -497,11 +652,36 @@ static void mcp_remove(struct btd_service *service)
 
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

