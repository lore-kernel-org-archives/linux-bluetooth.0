Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E151A9F88
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448787; cv=none; b=MlNFs4pabr5Zv3tpyHe8KD+3rd3szGJQ56GQ6PisbfurXZUKWa++31zIEtRauWsCFpuiMVw7zq8sB3rr3x7DXSH+afaB70ZxqQbgnXDNSmsnHDYU/7GYEv00qFhdAbyPd5hPEUY2p1uXcz5/iK/jfZwDuWZFRDEdgNHlGXyxZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448787; c=relaxed/simple;
	bh=//NBYbP9tVA4fOuyrp26DgJWTzdXzrzS7bwRVSFvuO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJYRF9wK3W9Ye+0LxETfxWFr+/gExvtfr2Ezhbd+crPjYFIg75Bvpb2pDoS0X3fksPob7MghbqMgbew1Bo2z49YlsRMq3Xc2rsRtpxdK29ovesn9YEHSh+Z3EExmczTFCTUKPYL2NFu7himWelYWnwe3etUa3AjRkUHPdQQJH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=laAnBtP2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="laAnBtP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777448784;
	bh=//NBYbP9tVA4fOuyrp26DgJWTzdXzrzS7bwRVSFvuO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laAnBtP2apTIJO2F/qilm0kIBhlCKf+pTWZPo+EfUR5AfFsoOYv4pzCr91Z5q22eT
	 dN01/p/1Wzs74SvoODQF3QxLdkwrAhEs5sDxotz4npo0dKDMtNBqH9bZ8K4QpoOI7r
	 W9y+07jb3jyW3AE4kVgEtZ4eM217jtnJtkardUV1rXTQcJ8MDsVZJzivItsBgUvGeH
	 zv5nYnJnd2gDiwWRC3K44y6jon/ezRJBx/atck+6MxFLnWiKn7HY9WoqLIxKhcikDj
	 tNpDtvSr096+eB5Mwkbul4Z/fZEOqNOCJT5SOz4zHTRPMpSba0fRpkmkA1b2dnqNCp
	 yKoE+UiBxNk+w==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 12EB017E1355;
	Wed, 29 Apr 2026 09:46:22 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v5 1/2] client: add public-broadcast advertising command
Date: Wed, 29 Apr 2026 13:16:04 +0530
Message-ID: <20260429074605.11774-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429074605.11774-1-raghavendra.rao@collabora.com>
References: <20260429061045.9115-2-raghavendra.rao@collabora.com>
 <20260429074605.11774-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

---
 client/advertising.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  2 ++
 client/main.c        | 19 ++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index f9df1b855..2fc2ac9c6 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -20,6 +20,9 @@
 #include <string.h>
 #include <errno.h>
 
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+
 #include "gdbus/gdbus.h"
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
@@ -27,6 +30,9 @@
 
 #define AD_PATH "/org/bluez/advertising"
 #define AD_IFACE "org.bluez.LEAdvertisement1"
+#define AD_PUBLIC_BROADCAST_UUID "0x1856"
+#define AD_PUBLIC_BROADCAST_SQ BIT(1)
+#define AD_PUBLIC_BROADCAST_HQ BIT(2)
 
 struct ad_data {
 	uint8_t data[245];
@@ -1005,6 +1011,74 @@ static void ad_clear_data(int type)
 	memset(&ad.data[type], 0, sizeof(ad.data[type]));
 }
 
+static bool ad_is_public_broadcast_uuid(const char *uuid)
+{
+	return uuid && !bt_uuid_strcmp(uuid, AD_PUBLIC_BROADCAST_UUID);
+}
+
+static const char *ad_public_broadcast_state(void)
+{
+	if (!ad_is_public_broadcast_uuid(ad.service[AD_TYPE_AD].uuid))
+		return NULL;
+
+	if (ad.service[AD_TYPE_AD].data.len != 2)
+		return NULL;
+
+	if (ad.service[AD_TYPE_AD].data.data[0] == AD_PUBLIC_BROADCAST_SQ &&
+			ad.service[AD_TYPE_AD].data.data[1] == 0x00)
+		return "sq";
+
+	if (ad.service[AD_TYPE_AD].data.data[0] == AD_PUBLIC_BROADCAST_HQ &&
+			ad.service[AD_TYPE_AD].data.data[1] == 0x00)
+		return "hq";
+
+	return NULL;
+}
+
+void ad_advertise_public_broadcast(DBusConnection *conn, int argc, char *argv[])
+{
+	struct ad_data data = {
+		.data = { 0x00, 0x00 },
+		.len = 2,
+	};
+	const char *state;
+
+	if (argc < 2) {
+		state = ad_public_broadcast_state();
+		if (state)
+			bt_shell_printf("Public Broadcast: %s\n", state);
+		else
+			bt_shell_printf("Public Broadcast not set\n");
+
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (!strlen(argv[1])) {
+		bt_shell_printf("Public broadcast value cannot be empty\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!strcasecmp(argv[1], "sq"))
+		data.data[0] = AD_PUBLIC_BROADCAST_SQ;
+	else if (!strcasecmp(argv[1], "hq"))
+		data.data[0] = AD_PUBLIC_BROADCAST_HQ;
+	else {
+		bt_shell_printf("Invalid argument: accepted values are "
+				"sq or hq\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ad_clear_service(AD_TYPE_AD);
+
+	ad.service[AD_TYPE_AD].uuid = g_strdup(AD_PUBLIC_BROADCAST_UUID);
+	ad.service[AD_TYPE_AD].data = data;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+					prop_names.service[AD_TYPE_AD]);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[])
 {
 	char *endptr = NULL;
diff --git a/client/advertising.h b/client/advertising.h
index 9d124c7af..8c3fd041b 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -34,6 +34,8 @@ void ad_advertise_local_appearance(DBusConnection *conn, long int *value);
 void ad_advertise_duration(DBusConnection *conn, long int *value);
 void ad_advertise_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[]);
+void ad_advertise_public_broadcast(DBusConnection *conn, int argc,
+							char *argv[]);
 void ad_disable_data(DBusConnection *conn, int type);
 void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
diff --git a/client/main.c b/client/main.c
index 57fa13888..6fb399277 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2920,6 +2920,17 @@ static char *scan_generator(const char *text, int state)
 	return argument_generator(text, state, scan_arguments);
 }
 
+static const char *public_broadcast_arguments[] = {
+	"sq",
+	"hq",
+	NULL
+};
+
+static char *public_broadcast_generator(const char *text, int state)
+{
+	return argument_generator(text, state, public_broadcast_arguments);
+}
+
 static void cmd_advertise(int argc, char *argv[])
 {
 	dbus_bool_t enable;
@@ -2970,6 +2981,11 @@ static void cmd_advertise_data(int argc, char *argv[])
 	ad_advertise_data(dbus_conn, AD_TYPE_AD, argc, argv);
 }
 
+static void cmd_advertise_public_broadcast(int argc, char *argv[])
+{
+	ad_advertise_public_broadcast(dbus_conn, argc, argv);
+}
+
 static void cmd_advertise_sr_uuids(int argc, char *argv[])
 {
 	ad_advertise_uuids(dbus_conn, AD_TYPE_SRD, argc, argv);
@@ -3653,6 +3669,9 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise manufacturer data" },
 	{ "data", "[type] [data=xx xx ...]", cmd_advertise_data,
 			"Set/Get advertise data" },
+	{ "public-broadcast", "[sq/hq]", cmd_advertise_public_broadcast,
+			"Set/Get BLE Audio Public Broadcast Announcement",
+			public_broadcast_generator },
 	{ "sr-uuids", "[uuid1 uuid2 ...]", cmd_advertise_sr_uuids,
 			"Set/Get scan response uuids" },
 	{ "sr-solicit", "[uuid1 uuid2 ...]", cmd_advertise_sr_solicit,
-- 
2.43.0

