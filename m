Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] core: Wait for services to be resolved before doing authorization
Date: Thu, 20 Mar 2014 15:50:49 +0200
Message-Id: <1395323451-31229-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes btd_request_authorization to wait until services are resolved
before proceeding with authorization, if the services could not be
resolved it still proceeds with authorization since some profile may not
have a record to be resolved.
---
 src/adapter.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 56bee35..bc95136 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -138,6 +138,7 @@ struct watch_client {
 
 struct service_auth {
 	guint id;
+	unsigned int svc_id;
 	service_auth_cb cb;
 	void *user_data;
 	const char *uuid;
@@ -1056,6 +1057,10 @@ static void service_auth_cancel(struct service_auth *auth)
 {
 	DBusError derr;
 
+	if (auth->svc_id > 0)
+		device_remove_svc_complete_callback(auth->device,
+								auth->svc_id);
+
 	dbus_error_init(&derr);
 	dbus_set_error_const(&derr, ERROR_INTERFACE ".Canceled", NULL);
 
@@ -4607,6 +4612,10 @@ static gboolean process_auth_queue(gpointer user_data)
 		struct btd_device *device = auth->device;
 		const char *dev_path;
 
+		/* Wait services to be resolved before asking authorization */
+		if (auth->svc_id > 0)
+			return TRUE;
+
 		if (device_is_trusted(device) == TRUE) {
 			auth->cb(NULL, auth->user_data);
 			goto next;
@@ -4643,6 +4652,22 @@ next:
 	return FALSE;
 }
 
+static void svc_complete(struct btd_device *dev, int err, void *user_data)
+{
+	struct service_auth *auth = user_data;
+	struct btd_adapter *adapter = auth->adapter;
+
+	auth->svc_id = 0;
+
+	if (adapter->auths->length != 1)
+		return;
+
+	if (adapter->auth_idle_id != 0)
+		return;
+
+	adapter->auth_idle_id = g_idle_add(process_auth_queue, adapter);
+}
+
 static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 					const char *uuid, service_auth_cb cb,
 					void *user_data)
@@ -4669,17 +4694,10 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	auth->device = device;
 	auth->adapter = adapter;
 	auth->id = ++id;
+	auth->svc_id = device_wait_for_svc_complete(device, svc_complete, auth);
 
 	g_queue_push_tail(adapter->auths, auth);
 
-	if (adapter->auths->length != 1)
-		return auth->id;
-
-	if (adapter->auth_idle_id != 0)
-		return auth->id;
-
-	adapter->auth_idle_id = g_idle_add(process_auth_queue, adapter);
-
 	return auth->id;
 }
 
@@ -4738,6 +4756,10 @@ int btd_cancel_authorization(guint id)
 	if (auth == NULL)
 		return -EPERM;
 
+	if (auth->svc_id > 0)
+		device_remove_svc_complete_callback(auth->device,
+								auth->svc_id);
+
 	g_queue_remove(auth->adapter->auths, auth);
 
 	if (auth->agent)
-- 
1.8.5.3

