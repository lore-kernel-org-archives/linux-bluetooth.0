Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/advertising: Fix not waiting Add Advertising response
Date: Tue, 12 May 2015 23:21:08 +0300
Message-Id: <1431462068-4242-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When registering a new instance it must wait MGMT_OP_ADD_ADVERTISING
before replying to the client since the command can still fail.
---
 src/advertising.c | 60 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 0eb489a..d6ab084 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -395,24 +395,48 @@ static bool parse_advertising_include_tx_power(GDBusProxy *proxy,
 	return true;
 }
 
+static void add_adverting_complete(struct advertisement *ad, uint8_t status)
+{
+	DBusMessage *reply;
+
+	if (status) {
+		error("Failed to add advertisement: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		reply = btd_error_failed(ad->reg,
+					"Failed to register advertisement");
+		queue_remove(ad->manager->ads, ad);
+		g_idle_add(advertisement_free_idle_cb, ad);
+
+	} else
+		reply = dbus_message_new_method_return(ad->reg);
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(ad->reg);
+	ad->reg = NULL;
+}
+
 static void add_advertising_callback(uint8_t status, uint16_t length,
 					  const void *param, void *user_data)
 {
 	struct advertisement *ad = user_data;
 	const struct mgmt_rp_add_advertising *rp = param;
 
-	if (status || !param) {
-		error("Failed to add advertisement: %s (0x%02x)",
-						mgmt_errstr(status), status);
-		return;
-	}
+	if (status)
+		goto done;
 
-	if (length < sizeof(*rp)) {
-		error("Wrong size of add advertising response");
-		return;
+	if (!param || length < sizeof(*rp)) {
+		status = MGMT_STATUS_FAILED;
+		goto done;
 	}
 
 	ad->instance = rp->instance;
+
+	g_dbus_client_set_disconnect_watch(ad->client, client_disconnect_cb,
+									ad);
+	DBG("Advertisement registered: %s", ad->path);
+
+done:
+	add_adverting_complete(ad, status);
 }
 
 static size_t calc_max_adv_len(struct advertisement *ad, uint32_t flags)
@@ -541,24 +565,14 @@ static void advertisement_proxy_added(GDBusProxy *proxy, void *data)
 	DBusMessage *reply;
 
 	reply = parse_advertisement(ad);
+	if (!reply)
+		return;
 
-	if (reply) {
-		/* Failed to publish for some reason, remove. */
-		queue_remove(ad->manager->ads, ad);
-
-		g_idle_add(advertisement_free_idle_cb, ad);
-
-		goto done;
-	}
-
-	g_dbus_client_set_disconnect_watch(ad->client, client_disconnect_cb,
-									ad);
-
-	reply = dbus_message_new_method_return(ad->reg);
+	/* Failed to publish for some reason, remove. */
+	queue_remove(ad->manager->ads, ad);
 
-	DBG("Advertisement registered: %s", ad->path);
+	g_idle_add(advertisement_free_idle_cb, ad);
 
-done:
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 
 	dbus_message_unref(ad->reg);
-- 
2.1.0

