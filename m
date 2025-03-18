Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DED20C46A
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304475; cv=none; b=UgWjh7nYw5FnPGeclBm/7816gjex5IMl8BC/sEkBhfcj+G/nxcpQihSqgvSRE5bzSy1tG+IREycnKe7SM6vJT39zkQVKx2KnWWfCz9u817/HIj/esWNiVBbYiJrgbJ6lM8v3y6yeTNGaPPtiaBO4hRXIqwLgxTUpyH5N24mMndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304475; c=relaxed/simple;
	bh=e1oQu/BGmxtWbtjYUuMeCgOImPH1bMeOCYFncQfHOs8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OaKXVsOG+uUd+Gf1rE0zcqV4Yi+biNCUzpnP4wCWgFmIGWOa/3Wv77ivd934J4oNryC+z4SeuFrN5x997UVEqB9dT+7eXQP5hBUy80nB9bFZAeyIj+SRmR2wO9U6iFZGPLE7VVu8wBLZF5AkvBVKCreOQcUQjKIJoS2hpyczBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I3XQMuX5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I3XQMuX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742304467;
	bh=e1oQu/BGmxtWbtjYUuMeCgOImPH1bMeOCYFncQfHOs8=;
	h=From:To:Subject:Date:From;
	b=I3XQMuX53vkKR3lDRqKssYmIHhN2hWUaKfVEhQ4bdKV97OW14Dai5/bSliG4cRGKc
	 E+PmFhTcjDmoHeE4q8ZcTIYKqKNAdMnO6806/jMYoZ8jLMjDHzxRlUR2PelbzEJ4ZG
	 Wt/tz3rsMZz3ZpR1dZ8/yY+cob9tAuKu5yHQ2mwgC2e+tx4OKyMycad5ehPHW8k9Jg
	 5OPmEF5eqiO0MXUxDyjQFy7iMnNS21UOypr/amROi3xUfNa1iUPtHZj7p5RQ4y22/M
	 Kkj6KVpvoWntKKdQ+DkX4Jm+c5KzGsIihx6wCc5EvcEneDlOZe/comjJH8kfrYaSE8
	 5epCVx1KWiVpw==
Received: from fdanis-XPS-13-9370.. (2a02-8428-aF44-1001-9fEE-4cCC-db1B-a287.rev.sfr.net [IPv6:2a02:8428:af44:1001:9fee:4ccc:db1b:a287])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F15717E0385
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 14:27:47 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obex: Publish SDP record for Phonebook Access Client
Date: Tue, 18 Mar 2025 14:27:41 +0100
Message-ID: <20250318132741.92320-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is required for passing below PTS test cases:

1. PBAP/PCE/SGSIT/ATTR/BV-01-C
   Attribute GSIT - Bluetooth Profile Descriptor List, PBAP 1.2
2. PBAP/PCE/SGSIT/OFFS/BV-02-C
   Attribute ID Offset String GSIT - Service Name
3. PBAP/PCE/SGSIT/SERR/BV-01-C
   Service record GSIT - PBAP PCE

Currently the Phonebook Access Client SDP record is not registered,
hence  above test cases are failing.
This commit adds code to register the profile (0x112e).
---
 obexd/client/pbap.c | 157 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 48a2de650..2f234fadf 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -121,6 +121,7 @@ static const char *filter_list[] = {
 
 #define PBAP_INTERFACE "org.bluez.obex.PhonebookAccess1"
 #define ERROR_INTERFACE "org.bluez.obex.Error"
+#define PBAP_CLIENT_UUID "0000112e-0000-1000-8000-00805f9b34fb"
 #define PBAP_UUID "0000112f-0000-1000-8000-00805f9b34fb"
 
 struct pbap_data {
@@ -139,6 +140,10 @@ struct pending_request {
 };
 
 static DBusConnection *conn = NULL;
+static DBusConnection *system_conn;
+
+static unsigned int listener_id;
+static char *client_path;
 
 static struct pending_request *pending_request_new(struct pbap_data *pbap,
 							DBusMessage *message)
@@ -1294,6 +1299,151 @@ static void pbap_remove(struct obc_session *session)
 	g_dbus_unregister_interface(conn, path, PBAP_INTERFACE);
 }
 
+static DBusMessage *pbap_release(DBusConnection *conn,
+	DBusMessage *msg, void *data)
+{
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *pbap_new_connection(DBusConnection *conn,
+	DBusMessage *msg, void *data)
+{
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *pbap_request_disconnection(DBusConnection *conn,
+	DBusMessage *msg, void *data)
+{
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *pbap_cancel(DBusConnection *conn,
+	DBusMessage *msg, void *data)
+{
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable profile_methods[] = {
+	{ GDBUS_METHOD("Release",
+			NULL, NULL,
+			pbap_release) },
+	{ GDBUS_METHOD("NewConnection",
+			GDBUS_ARGS({ "device", "o" }, { "fd", "h" },
+			{ "options", "a{sv}" }), NULL,
+			pbap_new_connection) },
+	{ GDBUS_METHOD("RequestDisconnection",
+			GDBUS_ARGS({ "device", "o" }), NULL,
+			pbap_request_disconnection) },
+	{ GDBUS_METHOD("Cancel",
+			NULL, NULL,
+			pbap_cancel) },
+	{ }
+};
+
+static void unregister_profile(void)
+{
+	g_dbus_unregister_interface(system_conn, client_path,
+						"org.bluez.Profile1");
+	g_free(client_path);
+	client_path = NULL;
+}
+
+static void register_profile_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		DBG("Profile %s registered", client_path);
+		goto done;
+	}
+
+	unregister_profile();
+
+	error("bluetooth: RequestProfile error: %s, %s", derr.name,
+								derr.message);
+	dbus_error_free(&derr);
+done:
+	dbus_message_unref(reply);
+}
+
+static int register_profile(void)
+{
+	DBusMessage *msg;
+	DBusMessageIter iter, opt;
+	DBusPendingCall *call;
+	char *uuid = PBAP_CLIENT_UUID;
+	dbus_bool_t auto_connect = FALSE;
+	int ret = 0;
+
+	client_path = g_strconcat("/org/bluez/obex/", uuid, NULL);
+	g_strdelimit(client_path, "-", '_');
+
+	if (!g_dbus_register_interface(system_conn, client_path,
+					"org.bluez.Profile1", profile_methods,
+					NULL, NULL,
+					NULL, NULL)) {
+		error("D-Bus failed to register %s", client_path);
+		g_free(client_path);
+		client_path = NULL;
+		return -1;
+	}
+
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
+						"org.bluez.ProfileManager1",
+						"RegisterProfile");
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+							&client_path);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+							&uuid);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&opt);
+	g_dbus_dict_append_entry(&opt, "AutoConnect", DBUS_TYPE_BOOLEAN,
+								&auto_connect);
+	dbus_message_iter_close_container(&iter, &opt);
+
+	if (!g_dbus_send_message_with_reply(system_conn, msg, &call, -1)) {
+		ret = -1;
+		unregister_profile();
+		goto failed;
+	}
+
+	dbus_pending_call_set_notify(call, register_profile_reply, NULL,
+									NULL);
+	dbus_pending_call_unref(call);
+
+failed:
+	dbus_message_unref(msg);
+	return ret;
+}
+
+static void name_acquired(DBusConnection *conn, void *user_data)
+{
+	DBG("org.bluez appeared");
+
+	if (register_profile() < 0) {
+		error("bluetooth: Failed to register profile %s",
+			client_path);
+		g_free(client_path);
+		client_path = NULL;
+	}
+}
+
+static void name_released(DBusConnection *conn, void *user_data)
+{
+	DBG("org.bluez disappeared");
+
+	unregister_profile();
+}
+
 static struct obc_driver pbap = {
 	.service = "PBAP",
 	.uuid = PBAP_UUID,
@@ -1314,6 +1464,10 @@ int pbap_init(void)
 	if (!conn)
 		return -EIO;
 
+	system_conn = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (system_conn == NULL)
+		return -EIO;
+
 	err = obc_driver_register(&pbap);
 	if (err < 0) {
 		dbus_connection_unref(conn);
@@ -1321,6 +1475,9 @@ int pbap_init(void)
 		return err;
 	}
 
+	listener_id = g_dbus_add_service_watch(system_conn, "org.bluez",
+				name_acquired, name_released, NULL, NULL);
+
 	return 0;
 }
 
-- 
2.43.0

