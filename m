Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 06/11] Disable automatic connections after 60 seconds
Date: Mon, 26 Sep 2011 14:48:23 -0300
Message-Id: <1317059308-20038-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   24 ++++++++++++++++++++++++
 src/device.c  |    8 ++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 605a9f2..8ff4e3d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -78,6 +78,7 @@
 #define check_address(address) bachk(address)
 
 #define OFF_TIMER 3
+#define AUTO_TIMER	60
 
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
@@ -134,6 +135,7 @@ struct btd_adapter {
 	GSList *mode_sessions;		/* Request Mode sessions */
 	GSList *disc_sessions;		/* Discovery sessions */
 	guint scheduler_id;		/* Scheduler handle */
+	guint auto_timeout_id;		/* Automatic connections timeout */
 	sdp_list_t *services;		/* Services associated to adapter */
 
 	gboolean pairable;		/* pairable state */
@@ -3417,6 +3419,22 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 	return 0;
 }
 
+static gboolean disable_auto(gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	GSList *l;
+
+	for (l = adapter->devices; l; l = l->next) {
+		struct btd_device *device = l->data;
+
+		device_set_auto_connect(device, FALSE);
+	}
+
+	adapter->auto_timeout_id = 0;
+
+	return FALSE;
+}
+
 static void set_auto_connect(gpointer data, gpointer user_data)
 {
 	struct btd_device *device = data;
@@ -3431,7 +3449,13 @@ void btd_adapter_enable_auto_connect(struct btd_adapter *adapter)
 
 	DBG("Enabling automatic connections");
 
+	if (adapter->auto_timeout_id)
+		return;
+
 	g_slist_foreach(adapter->devices, set_auto_connect, NULL);
+
+	adapter->auto_timeout_id = g_timeout_add_seconds(AUTO_TIMER,
+						disable_auto, adapter);
 }
 
 void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index 35121b5..f56d57f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1950,6 +1950,14 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 
 	device->auto_connect = enable;
 
+	/* Disabling auto connect */
+	if (enable == FALSE) {
+		if (device->auto_id)
+			g_source_remove(device->auto_id);
+		return;
+	}
+
+	/* Enabling auto connect */
 	if (device->auto_id != 0)
 		return;
 
-- 
1.7.6.1

