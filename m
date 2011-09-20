Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 03/19] Unregister Health Thermometer Interface
Date: Tue, 20 Sep 2011 19:47:15 +0200
Message-Id: <1316540841-14713-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1316540841-14713-3-git-send-email-sancane@gmail.com>
References: <1316540841-14713-1-git-send-email-sancane@gmail.com>
 <1316540841-14713-2-git-send-email-sancane@gmail.com>
 <1316540841-14713-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index a89d8a9..cdfe455 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -51,6 +51,17 @@ static void destroy_thermometer(gpointer user_data)
         g_free(t);
 }
 
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct thermometer *t = a;
+	const struct btd_device *dev = b;
+
+	if (dev == t->dev)
+		return 0;
+
+	return -1;
+}
+
 static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -143,5 +154,15 @@ int thermometer_register(DBusConnection *connection, struct btd_device *device,
 
 void thermometer_unregister(struct btd_device *device)
 {
-	/* TODO: Unregister Health Thermometer Interface */
+	struct thermometer *t;
+	GSList *l;
+
+	l = g_slist_find_custom(thermometers, device, cmp_device);
+	if (!l)
+		return;
+
+	t = l->data;
+	thermometers = g_slist_remove(thermometers, t);
+	g_dbus_unregister_interface(t->conn, device_get_path(t->dev),
+							THERMOMETER_INTERFACE);
 }
-- 
1.7.6.1

