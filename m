Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17857309F1D
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397177; cv=none; b=TLdg3MY3Xbgkdx8ANSYaxkroPSgIob/TFNwnn60o8zE6urMnISOyu9ybRQktlDvE/qCqF5nU/Ql5DYQz9mcfOZxdK1P0ulH6UW5Pe3ZI6DiSz9it8xU0QZxUU/9ycO63w5ARGBgPbyJU2MQC5YUeIGNs2uYfw21txpl2Ed4DGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397177; c=relaxed/simple;
	bh=7EYF861JYGpI7W7kyE7CiDq/AUQz9LUX6yLlZFurIXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocR8ekzCKfqlC8jxQWI/SLl3tX70Llo6oXcJPi1qsV2d9h/B1OlLvCjnr3XeopR6FXEu6sfO6GMADD9PGmGZi86I/iIT4ONKJxLyAPOtDAqKFPhGl7/4VjJJd0aTXJDbfWypgMj+VNoQl2xbH0qR4wUpxyJ/4al1ubIxF0+5cII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ITUPgF7q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ITUPgF7q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773397169;
	bh=7EYF861JYGpI7W7kyE7CiDq/AUQz9LUX6yLlZFurIXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITUPgF7qmZlfd5pHFWSq6UHASmFOh9RoqO8WnxIh3O+yHRU/svj/KdhTFLCbZgSXm
	 JyM2TjFaxQLN+HmciowfSLp3qGocBJ5WgW/KwpD6H+xWkO36Gco4nva1JwsSOictNP
	 7IkgI3qa1WczX+pR4e5IFEVE6Hdi0XKPdKxwCMXbgUn4i6boZ2xJ2CF7OVcQOOtNkk
	 k8+2KSQrC6dB9NmMixD5oA6Bz3rNQGoKX2+IKHY5hxq1qs7/yctPng4GcqdFf0oCX6
	 YqmRQjYCKyrX4JydvnFvmi4SP0hUcohWCC8tSRJs1Pyl1Zplgul3m1vE1TE+XlZ5WL
	 hB5v9sbX3IQCw==
Received: from fedora.localdomain (unknown [49.37.146.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 032BC17E026C;
	Fri, 13 Mar 2026 11:19:28 +0100 (CET)
From: raghava447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghava447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ 1/1] client: add advertise broadcast-name helper
Date: Fri, 13 Mar 2026 15:48:05 +0530
Message-ID: <20260313101805.46784-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313101805.46784-1-raghavendra.rao@collabora.com>
References: <20260313101805.46784-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bluetoothctl advertise helper for staging BLE Audio Broadcast
Name as AD type 0x30 using a plain string.

The helper reuses the existing raw advertising Data field and
registration flow.

The documentation is updated with relevant details.
---
 client/advertising.c           | 52 ++++++++++++++++++++++++++++++++++
 client/advertising.h           |  1 +
 client/main.c                  |  7 +++++
 doc/bluetoothctl-advertise.rst | 18 ++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index f9df1b855..924eb69d8 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -27,6 +27,7 @@
 
 #define AD_PATH "/org/bluez/advertising"
 #define AD_IFACE "org.bluez.LEAdvertisement1"
+#define AD_TYPE_BROADCAST_NAME 0x30
 
 struct ad_data {
 	uint8_t data[245];
@@ -1043,6 +1044,57 @@ void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+void ad_advertise_broadcast_name(DBusConnection *conn, int argc, char *argv[])
+{
+	GString *name;
+	size_t i;
+	size_t len;
+
+	if (argc < 2) {
+		if (ad.data[AD_TYPE_AD].valid &&
+				ad.data[AD_TYPE_AD].type == AD_TYPE_BROADCAST_NAME)
+			bt_shell_printf("Broadcast Name: %.*s\n",
+					ad.data[AD_TYPE_AD].data.len,
+					(char *) ad.data[AD_TYPE_AD].data.data);
+		else
+			bt_shell_printf("Broadcast Name not set\n");
+
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	name = g_string_new(NULL);
+	for (i = 1; i < (size_t) argc; i++) {
+		g_string_append(name, argv[i]);
+		if (i + 1 < (size_t) argc)
+			g_string_append_c(name, ' ');
+	}
+
+	if (!name->len) {
+		bt_shell_printf("Broadcast name cannot be empty\n");
+		g_string_free(name, TRUE);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	len = name->len;
+	if (len > sizeof(ad.data[AD_TYPE_AD].data.data)) {
+		bt_shell_printf("Broadcast name is too long\n");
+		g_string_free(name, TRUE);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ad_clear_data(AD_TYPE_AD);
+	ad.data[AD_TYPE_AD].valid = true;
+	ad.data[AD_TYPE_AD].type = AD_TYPE_BROADCAST_NAME;
+	memcpy(ad.data[AD_TYPE_AD].data.data, name->str, len);
+	ad.data[AD_TYPE_AD].data.len = len;
+	g_string_free(name, TRUE);
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							prop_names.data[AD_TYPE_AD]);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 void ad_disable_data(DBusConnection *conn, int type)
 {
 	if (!ad.data[type].type && !ad.data[type].data.len)
diff --git a/client/advertising.h b/client/advertising.h
index 9d124c7af..d855493ed 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -34,6 +34,7 @@ void ad_advertise_local_appearance(DBusConnection *conn, long int *value);
 void ad_advertise_duration(DBusConnection *conn, long int *value);
 void ad_advertise_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[]);
+void ad_advertise_broadcast_name(DBusConnection *conn, int argc, char *argv[]);
 void ad_disable_data(DBusConnection *conn, int type);
 void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
diff --git a/client/main.c b/client/main.c
index cb016a579..9b4e8190d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2917,6 +2917,11 @@ static void cmd_advertise_data(int argc, char *argv[])
 	ad_advertise_data(dbus_conn, AD_TYPE_AD, argc, argv);
 }
 
+static void cmd_advertise_broadcast_name(int argc, char *argv[])
+{
+	ad_advertise_broadcast_name(dbus_conn, argc, argv);
+}
+
 static void cmd_advertise_sr_uuids(int argc, char *argv[])
 {
 	ad_advertise_uuids(dbus_conn, AD_TYPE_SRD, argc, argv);
@@ -3600,6 +3605,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise manufacturer data" },
 	{ "data", "[type] [data=xx xx ...]", cmd_advertise_data,
 			"Set/Get advertise data" },
+	{ "broadcast-name", "<string>", cmd_advertise_broadcast_name,
+			"Set BLE Audio Broadcast Name (AD type 0x30)" },
 	{ "sr-uuids", "[uuid1 uuid2 ...]", cmd_advertise_sr_uuids,
 			"Set/Get scan response uuids" },
 	{ "sr-solicit", "[uuid1 uuid2 ...]", cmd_advertise_sr_solicit,
diff --git a/doc/bluetoothctl-advertise.rst b/doc/bluetoothctl-advertise.rst
index 0780cd9d8..a2963e4b7 100644
--- a/doc/bluetoothctl-advertise.rst
+++ b/doc/bluetoothctl-advertise.rst
@@ -171,6 +171,24 @@ To get the currently set data use the command data without any arguments.
 :Example Set service data for Battery Service (UUID 0x180F, level 100):
 	| **> data 0x16 0F 18 64**
 
+broadcast-name
+--------------
+
+Set BLE Audio Broadcast Name.
+
+This is a semantic helper for raw advertising data type ``0x30``. It writes
+only the payload bytes for that AD type into the same staged advertising data
+slot used by ``data 0x30 ...``. If either command is used later, the later
+call replaces the previous value.
+
+:Usage: **> broadcast-name <string>**
+:[string]: Broadcast Name string to be staged as AD type ``0x30`` payload
+:Example Show current broadcast name:
+	| **> broadcast-name**
+	| Broadcast Name: Collabora BlueZ Auracast
+:Example Set broadcast name to "Collabora BlueZ Auracast":
+	| **> broadcast-name "Collabora BlueZ Auracast"**
+
 sr-uuids
 --------
 
-- 
2.52.0

