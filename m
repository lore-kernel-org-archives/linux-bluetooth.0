Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 2/5] adapter: Replace device authorizing flag
Date: Thu, 27 Sep 2012 10:07:49 +0200
Message-Id: <1348733272-2117-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1348733272-2117-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348733272-2117-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Refactor code to drop the device authorizing flag by replacing it with a
private authorization pointer in btd_adapter. After all, no more than
one authorization can be ongoing, so the code is easier to follow if
this is made explicit.
---
 src/adapter.c | 56 +++++++++++++++++++++++++++++++++++++-------------------
 src/device.c  | 11 -----------
 src/device.h  |  2 --
 3 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b1ea3ea..0664d23 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -127,7 +127,8 @@ struct btd_adapter {
 	GSList *found_devices;
 	GSList *oor_devices;		/* out of range device list */
 	struct agent *agent;		/* For the new API */
-	guint auth_idle_id;		/* Ongoing authorization */
+	guint auth_idle_id;		/* Ongoing authorization (trusted) */
+	struct service_auth *auth;	/* Ongoing authorization */
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
 	GSList *mode_sessions;		/* Request Mode sessions */
@@ -967,8 +968,11 @@ void adapter_remove_device(struct btd_adapter *adapter,
 
 	agent = device_get_agent(device);
 
-	if (agent && device_is_authorizing(device))
+	if (agent && adapter->auth && adapter->auth->device == device) {
+		g_free(adapter->auth);
+		adapter->auth = NULL;
 		agent_cancel(agent);
+	}
 
 	device_remove(device, remove_storage);
 }
@@ -2420,6 +2424,9 @@ static void adapter_free(gpointer user_data)
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
 
+	if (adapter->auth)
+		g_free(adapter->auth);
+
 	if (adapter->off_timer)
 		off_timer_remove(adapter);
 
@@ -3154,22 +3161,28 @@ void btd_unregister_adapter_driver(struct btd_adapter_driver *driver)
 static void agent_auth_cb(struct agent *agent, DBusError *derr,
 							void *user_data)
 {
-	struct service_auth *auth = user_data;
+	struct btd_adapter *adapter = user_data;
+	struct service_auth *auth = adapter->auth;
 
-	device_set_authorizing(auth->device, FALSE);
+	adapter->auth = NULL;
 
 	auth->cb(derr, auth->user_data);
+
+	g_free(auth);
 }
 
 static gboolean auth_idle_cb(gpointer user_data)
 {
-	struct service_auth *auth = user_data;
-	struct btd_adapter *adapter = auth->adapter;
+	struct btd_adapter *adapter = user_data;
+	struct service_auth *auth = adapter->auth;
 
+	adapter->auth = NULL;
 	adapter->auth_idle_id = 0;
 
 	auth->cb(NULL, auth->user_data);
 
+	g_free(auth);
+
 	return FALSE;
 }
 
@@ -3193,7 +3206,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	if (!g_slist_find(adapter->connections, device))
 		error("Authorization request for non-connected device!?");
 
-	if (adapter->auth_idle_id)
+	if (adapter->auth != NULL)
 		return -EBUSY;
 
 	auth = g_try_new0(struct service_auth, 1);
@@ -3206,10 +3219,8 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	auth->adapter = adapter;
 
 	if (device_is_trusted(device) == TRUE) {
-		adapter->auth_idle_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
-							auth_idle_cb, auth,
-							g_free);
-		return 0;
+		adapter->auth_idle_id = g_idle_add(auth_idle_cb, adapter);
+		goto done;
 	}
 
 	agent = device_get_agent(device);
@@ -3221,14 +3232,16 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 
 	dev_path = device_get_path(device);
 
-	err = agent_authorize(agent, dev_path, uuid, agent_auth_cb, auth,
-								g_free);
-	if (err < 0)
+	err = agent_authorize(agent, dev_path, uuid, agent_auth_cb, adapter,
+									NULL);
+	if (err < 0) {
 		g_free(auth);
-	else
-		device_set_authorizing(device, TRUE);
+		return err;
+	}
 
-	return err;
+done:
+	adapter->auth = auth;
+	return 0;
 }
 
 int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
@@ -3281,6 +3294,9 @@ int btd_cancel_authorization(const bdaddr_t *src, const bdaddr_t *dst)
 		return 0;
 	}
 
+	if (!adapter->auth || adapter->auth->device != device)
+		return -EPERM;
+
 	/*
 	 * FIXME: Cancel fails if authorization is requested to adapter's
 	 * agent and in the meanwhile CreatePairedDevice is called.
@@ -3292,8 +3308,10 @@ int btd_cancel_authorization(const bdaddr_t *src, const bdaddr_t *dst)
 
 	err = agent_cancel(agent);
 
-	if (err == 0)
-		device_set_authorizing(device, FALSE);
+	if (err == 0) {
+		g_free(adapter->auth);
+		adapter->auth = NULL;
+	}
 
 	return err;
 }
diff --git a/src/device.c b/src/device.c
index cb25606..adce9ed 100644
--- a/src/device.c
+++ b/src/device.c
@@ -163,7 +163,6 @@ struct btd_device {
 	gboolean	bonded;
 	gboolean	auto_connect;
 
-	gboolean	authorizing;
 	gint		ref;
 
 	GIOChannel      *att_io;
@@ -3027,16 +3026,6 @@ gboolean device_is_authenticating(struct btd_device *device)
 	return (device->authr != NULL);
 }
 
-gboolean device_is_authorizing(struct btd_device *device)
-{
-	return device->authorizing;
-}
-
-void device_set_authorizing(struct btd_device *device, gboolean auth)
-{
-	device->authorizing = auth;
-}
-
 void device_register_services(struct btd_device *device,
 						GSList *prim_list, int psm)
 {
diff --git a/src/device.h b/src/device.h
index 02c1782..edd3033 100644
--- a/src/device.h
+++ b/src/device.h
@@ -99,8 +99,6 @@ int device_notify_pincode(struct btd_device *device, gboolean secure,
 						const char *pincode, void *cb);
 void device_cancel_authentication(struct btd_device *device, gboolean aborted);
 gboolean device_is_authenticating(struct btd_device *device);
-gboolean device_is_authorizing(struct btd_device *device);
-void device_set_authorizing(struct btd_device *device, gboolean auth);
 void device_add_connection(struct btd_device *device);
 void device_remove_connection(struct btd_device *device);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
-- 
1.7.11.4

