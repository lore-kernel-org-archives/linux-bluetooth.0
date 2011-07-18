Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/7] Initial steps to manage thermometer objects
Date: Mon, 18 Jul 2011 15:10:41 +0200
Message-Id: <1310994642-16375-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1310994642-16375-5-git-send-email-sancane@gmail.com>
References: <1310994642-16375-1-git-send-email-sancane@gmail.com>
 <1310994642-16375-2-git-send-email-sancane@gmail.com>
 <1310994642-16375-3-git-send-email-sancane@gmail.com>
 <1310994642-16375-4-git-send-email-sancane@gmail.com>
 <1310994642-16375-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   63 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index a05d37d..b8c0b82 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -27,15 +27,78 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "log.h"
 #include "thermometer.h"
 
+struct thermometer {
+	DBusConnection		*conn;	/* The connection to the bus */
+	struct btd_device	*dev;	/* Device reference */
+	gint			ref;	/* Reference counter */
+};
+
+static GSList *thermometers = NULL;
+
+static struct thermometer *thermometer_ref(struct thermometer *t)
+{
+	t->ref++;
+
+	DBG("%p: ref=%d", t, t->ref);
+
+	return t;
+}
+
+static void thermometer_unref(struct thermometer *t)
+{
+	t->ref--;
+
+	DBG("%p: ref=%d", t, t->ref);
+
+	if (t->ref > 0)
+		return;
+
+	dbus_connection_unref(t->conn);
+	btd_device_unref(t->dev);
+	g_free(t);
+}
+
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
 int thermometer_register(DBusConnection *connection, struct btd_device *device)
 {
+	struct thermometer *t;
+
+	t = g_new0(struct thermometer, 1);
+	t->conn = dbus_connection_ref(connection);
+	t->dev = btd_device_ref(device);
+
 	/* TODO: Register Health Thermometer Interface */
+
+	thermometers = g_slist_prepend(thermometers, thermometer_ref(t));
+
 	return 0;
 }
 
 void thermometer_unregister(struct btd_device *device)
 {
+	struct thermometer *t;
+	GSList *l;
+
+	l = g_slist_find_custom(thermometers, device, cmp_device);
+	if (!l)
+		return;
+
 	/* TODO: Unregister Health Thermometer Interface */
+
+	t = l->data;
+	thermometers = g_slist_remove(thermometers, t);
+	thermometer_unref(t);
 }
\ No newline at end of file
-- 
1.7.6

