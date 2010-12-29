Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Keep found LE device list to use when creating a device
Date: Wed, 29 Dec 2010 18:25:22 -0300
Message-Id: <1293657922-17173-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Found devices list should be used to identify device types when
CreateDevice or CreatePairedDevice are called. During the device
creation the selected device will be classified as LE device if
it belongs to the device found list and if the Flags AD type
matches the GAP requirements. BR/EDR devices don't need to be
tracked since the default remote device type is Basic Rate.
---
 src/adapter.c |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index eef8a06..b96a89e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -638,16 +638,31 @@ static uint8_t get_needed_mode(struct btd_adapter *adapter, uint8_t mode)
 	return mode;
 }
 
+static GSList *remove_bredr(GSList *all)
+{
+	GSList *l, *le;
+
+	for (l = all, le = NULL; l; l = l->next) {
+		struct remote_dev_info *dev = l->data;
+		if (dev->le == FALSE) {
+			dev_info_free(dev);
+			continue;
+		}
+
+		le = g_slist_append(le, dev);
+	}
+
+	g_slist_free(all);
+
+	return le;
+}
+
 static void stop_discovery(struct btd_adapter *adapter, gboolean suspend)
 {
 	pending_remote_name_cancel(adapter);
 
-	if (suspend == FALSE) {
-		g_slist_foreach(adapter->found_devices,
-				(GFunc) dev_info_free, NULL);
-		g_slist_free(adapter->found_devices);
-		adapter->found_devices = NULL;
-	}
+	if (suspend == FALSE)
+		adapter->found_devices = remove_bredr(adapter->found_devices);
 
 	if (adapter->oor_devices) {
 		g_slist_free(adapter->oor_devices);
@@ -1141,6 +1156,13 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	if (adapter->disc_sessions)
 		goto done;
 
+	g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free, NULL);
+	g_slist_free(adapter->found_devices);
+	adapter->found_devices = NULL;
+
+	g_slist_free(adapter->oor_devices);
+	adapter->oor_devices = NULL;
+
 	err = start_discovery(adapter);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
@@ -2475,6 +2497,11 @@ static void adapter_free(gpointer user_data)
 
 	sdp_list_free(adapter->services, NULL);
 
+	g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free, NULL);
+	g_slist_free(adapter->found_devices);
+
+	g_slist_free(adapter->oor_devices);
+
 	g_free(adapter->path);
 	g_free(adapter);
 }
-- 
1.7.3.4

