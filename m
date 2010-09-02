Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Make sure discovery don't interfere with bonding
Date: Thu,  2 Sep 2010 17:04:13 +0300
Message-Id: <1283436253-9850-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

In situation where the user application keep a discovery session while
bonding with a device it may cause a delay, or even timeout, due to the
number of the inquiry responses that the controller has to process.

Since the discovery can be shared between many applications it may not be
possible to simple require to each application to stop their discovery
before trying to pair with a device, so to fix this bluetoothd now
suspends the discovery while bonding, resuming when completed.
---
 src/adapter.c |   62 +++++++++++++++++++++++++++++++++++++++++++++-----------
 src/adapter.h |    3 ++
 src/device.c  |    4 +++
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 173dfbe..25b0671 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -107,7 +107,7 @@ struct btd_adapter {
 	uint8_t global_mode;		/* last valid global mode */
 	struct session_req *pending_mode;
 	int state;			/* standard inq, periodic inq, name
-					 * resloving */
+					 * resolving, suspended discovery */
 	GSList *found_devices;
 	GSList *oor_devices;		/* out of range device list */
 	struct agent *agent;		/* For the new API */
@@ -685,6 +685,27 @@ static uint8_t get_needed_mode(struct btd_adapter *adapter, uint8_t mode)
 	return mode;
 }
 
+static void adapter_stop_inquiry(struct btd_adapter *adapter)
+{
+	pending_remote_name_cancel(adapter);
+
+	/* Clear out of range device list */
+	if (adapter->oor_devices) {
+		g_slist_free(adapter->oor_devices);
+		adapter->oor_devices = NULL;
+	}
+
+	/* Reset if suspended, otherwise remove timer (software scheduler)
+	   or request inquiry to stop */
+	if (adapter->state & SUSPENDED_INQUIRY)
+		adapter->state &= ~SUSPENDED_INQUIRY;
+	else if (adapter->scheduler_id) {
+		g_source_remove(adapter->scheduler_id);
+		adapter->scheduler_id = 0;
+	} else
+		adapter_ops->stop_discovery(adapter->dev_id);
+}
+
 static void session_remove(struct session_req *req)
 {
 	struct btd_adapter *adapter = req->adapter;
@@ -719,19 +740,9 @@ static void session_remove(struct session_req *req)
 
 		DBG("Stopping discovery");
 
-		pending_remote_name_cancel(adapter);
-
 		clear_found_devices_list(adapter);
 
-		g_slist_free(adapter->oor_devices);
-		adapter->oor_devices = NULL;
-
-		if (adapter->scheduler_id) {
-			g_source_remove(adapter->scheduler_id);
-			adapter->scheduler_id = 0;
-		}
-
-		adapter_ops->stop_discovery(adapter->dev_id);
+		adapter_stop_inquiry(adapter);
 	}
 }
 
@@ -1219,6 +1230,10 @@ static int adapter_start_inquiry(struct btd_adapter *adapter)
 {
 	gboolean periodic = TRUE;
 
+	/* Do not start if suspended */
+	if (adapter->state & SUSPENDED_INQUIRY)
+		return 0;
+
 	if (main_opts.discov_interval)
 		periodic = FALSE;
 
@@ -3165,6 +3180,29 @@ gboolean adapter_has_discov_sessions(struct btd_adapter *adapter)
 	return TRUE;
 }
 
+void adapter_suspend_discovery(struct btd_adapter *adapter)
+{
+	if (adapter->disc_sessions == NULL ||
+			adapter->state & SUSPENDED_INQUIRY)
+		return;
+
+	DBG("Suspending discovery");
+
+	adapter_stop_inquiry(adapter);
+	adapter->state |= SUSPENDED_INQUIRY;
+}
+
+void adapter_resume_discovery(struct btd_adapter *adapter)
+{
+	if (adapter->disc_sessions == NULL)
+		return;
+
+	DBG("Resuming discovery");
+
+	adapter->state &= ~SUSPENDED_INQUIRY;
+	adapter_start_inquiry(adapter);
+}
+
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 {
 	GSList *adapters;
diff --git a/src/adapter.h b/src/adapter.h
index 5352731..fb52b34 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -33,6 +33,7 @@
 #define DISCOVER_TYPE_NONE	0x00
 #define STD_INQUIRY		0x01
 #define PERIODIC_INQUIRY	0x02
+#define SUSPENDED_INQUIRY	0x04
 
 /* Actions executed after inquiry complete */
 #define RESOLVE_NAME		0x10
@@ -133,6 +134,8 @@ void adapter_add_connection(struct btd_adapter *adapter,
 void adapter_remove_connection(struct btd_adapter *adapter,
 				struct btd_device *device, uint16_t handle);
 gboolean adapter_has_discov_sessions(struct btd_adapter *adapter);
+void adapter_suspend_discovery(struct btd_adapter *adapter);
+void adapter_resume_discovery(struct btd_adapter *adapter);
 
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
diff --git a/src/device.c b/src/device.c
index 1129e85..9055eca 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1813,6 +1813,8 @@ static void bonding_request_free(struct bonding_req *bonding)
 
 	device->bonding = NULL;
 
+	adapter_resume_discovery(device->adapter);
+
 	if (!device->agent)
 		return;
 
@@ -1879,6 +1881,8 @@ proceed:
 	bonding->conn = dbus_connection_ref(conn);
 	bonding->msg = dbus_message_ref(msg);
 
+	adapter_suspend_discovery(device->adapter);
+
 	return bonding;
 }
 
-- 
1.7.0.4

