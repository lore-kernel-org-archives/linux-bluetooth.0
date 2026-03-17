Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154F329C74
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773727207; cv=none; b=a5WH8IMiaXspZrfTdSJzzayMR2tdPERLt1nhj6eV7OzDYJAVqtghIM2Mq76QqBfKXsmTcYzZVcRKA6wts0EIOtIFBpmeQWIBIQr0IlVWAcAyzcwGp/ikxE2lB6jMLM/uaeBAWRInyIkioc1dKOp1PFH/JfTqK+xXLnp+u8eUh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773727207; c=relaxed/simple;
	bh=nNOPJWYxfRu92+i8HmhC2HDhlXs3fFDklMOYXz6lh44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pId1TvKxJU6yRL2EWd9LfgEanToBePAZpC+s5KNd/Bx5GG+dRLJSv7JLnp0waGtid4vF4Ij2BkH0gJ38FyW67+DD0yMVGVkTLl6QT41UaxYx8JFuVOfMkxpuuySm4QuKMT6kqj0ZuniNn5NdU3W6QMduHH1bgSYegqbluPFMNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cXGmJuma; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cXGmJuma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773727204;
	bh=nNOPJWYxfRu92+i8HmhC2HDhlXs3fFDklMOYXz6lh44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXGmJumasxEJLkSN4mVrh1x0Fk1EvnIu/yVBDeymRGBnVm3yZ8pNZp0QOOgAtXEuR
	 Cf4aDtqtp46RWW5IpXZDwxGN00dAfCR/g6Gltqv57nDG86Xt0pvMZG/x1Vv2akWdhL
	 QsWC+hLreNYj/gDCbZnJGOKWssPkDkhj2yuJIcEqs5ziOk9E/86C/7D0BmSPLZ+YGg
	 ybTalrfuSnXYCZlKl9ox6OfVncn8gGSoKP2cIK2OdKSHPiz/r7jkn+OQCu2UjuSE4l
	 hOJQxfvo/eg85c2gKRu+jCjbXL6cEJ9lj/+FDCYqkdGVpyRRLT4pM34dqZFXqx+GH7
	 PE5X1oGpVukGg==
Received: from fedora.localdomain (unknown [152.57.158.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C82BC17E127F;
	Tue, 17 Mar 2026 07:00:02 +0100 (CET)
From: raghava447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghava447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ 1/1] client: Add public-broadcast profile advertise command
Date: Tue, 17 Mar 2026 11:28:55 +0530
Message-ID: <20260317055855.4096-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317055855.4096-1-raghavendra.rao@collabora.com>
References: <20260317055855.4096-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an advertise submenu command for BLE Audio public broadcast profile
advertising in bluetoothctl.

The new "public-broadcast" command reuses the existing staged AD
ServiceData field for UUID 0x1856.
It supports:
- public-broadcast sq
- public-broadcast hq
- public-broadcast

The sq and hq values map to the existing raw service-data payloads:
- sq -> 0x02 0x00
- hq -> 0x04 0x00

When called without arguments, the command reports the currently staged
public-broadcast state if the staged AD service UUID is 0x1856.
Else it reports that public broadcast is not set.
---
 client/advertising.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  2 ++
 client/main.c        | 19 ++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 924eb69d8..27639d786 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -20,6 +20,8 @@
 #include <string.h>
 #include <errno.h>
 
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
 #include "gdbus/gdbus.h"
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
@@ -28,6 +30,7 @@
 #define AD_PATH "/org/bluez/advertising"
 #define AD_IFACE "org.bluez.LEAdvertisement1"
 #define AD_TYPE_BROADCAST_NAME 0x30
+#define AD_PUBLIC_BROADCAST_UUID "0x1856"
 
 struct ad_data {
 	uint8_t data[245];
@@ -1006,6 +1009,73 @@ static void ad_clear_data(int type)
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
+	if (ad.service[AD_TYPE_AD].data.data[0] == 0x02 &&
+			ad.service[AD_TYPE_AD].data.data[1] == 0x00)
+		return "sq";
+
+	if (ad.service[AD_TYPE_AD].data.data[0] == 0x04 &&
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
+		data.data[0] = 0x02;
+	else if (!strcasecmp(argv[1], "hq"))
+		data.data[0] = 0x04;
+	else {
+		bt_shell_printf("Invalid argument: accepted values are sq or hq\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ad_clear_service(AD_TYPE_AD);
+
+	ad.service[AD_TYPE_AD].uuid = g_strdup(AD_PUBLIC_BROADCAST_UUID);
+	ad.service[AD_TYPE_AD].data = data;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+						prop_names.service[AD_TYPE_AD]);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[])
 {
 	char *endptr = NULL;
diff --git a/client/advertising.h b/client/advertising.h
index d855493ed..c08672680 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -35,6 +35,8 @@ void ad_advertise_duration(DBusConnection *conn, long int *value);
 void ad_advertise_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[]);
 void ad_advertise_broadcast_name(DBusConnection *conn, int argc, char *argv[]);
+void ad_advertise_public_broadcast(DBusConnection *conn, int argc,
+							char *argv[]);
 void ad_disable_data(DBusConnection *conn, int type);
 void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
diff --git a/client/main.c b/client/main.c
index 9b4e8190d..93f572977 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2892,6 +2892,17 @@ static char *ad_generator(const char *text, int state)
 	return argument_generator(text, state, ad_arguments);
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
 static void cmd_advertise_uuids(int argc, char *argv[])
 {
 	ad_advertise_uuids(dbus_conn, AD_TYPE_AD, argc, argv);
@@ -2922,6 +2933,11 @@ static void cmd_advertise_broadcast_name(int argc, char *argv[])
 	ad_advertise_broadcast_name(dbus_conn, argc, argv);
 }
 
+static void cmd_advertise_public_broadcast(int argc, char *argv[])
+{
+	ad_advertise_public_broadcast(dbus_conn, argc, argv);
+}
+
 static void cmd_advertise_sr_uuids(int argc, char *argv[])
 {
 	ad_advertise_uuids(dbus_conn, AD_TYPE_SRD, argc, argv);
@@ -3607,6 +3623,9 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise data" },
 	{ "broadcast-name", "<string>", cmd_advertise_broadcast_name,
 			"Set BLE Audio Broadcast Name (AD type 0x30)" },
+	{ "public-broadcast", "[sq/hq]", cmd_advertise_public_broadcast,
+			"Set/Get BLE Audio Public Broadcast Announcement",
+			public_broadcast_generator },
 	{ "sr-uuids", "[uuid1 uuid2 ...]", cmd_advertise_sr_uuids,
 			"Set/Get scan response uuids" },
 	{ "sr-solicit", "[uuid1 uuid2 ...]", cmd_advertise_sr_solicit,
-- 
2.53.0

