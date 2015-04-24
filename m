Return-Path: <cyrus@holtmann.org>
From: Hsin-Yu Chao <hychao@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: armansito@chromium.org, luiz.dentz@gmail.com,
	Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH v1] src/profile: Set service to connecting in ext_connect
Date: Fri, 24 Apr 2015 10:36:09 -0700
Message-Id: <1429896969-629-1-git-send-email-hychao@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the profile connection initiated by remote device,
ext_connect() function is triggered without advance the state
of device's service to BTD_SERVICE_STATE_CONNECTING.
This is causing a problems when the later 'NewConnection'
dbus method call is made to registered application. If
the remote device gets disconnected during the period of
time waiting for the reply of 'NewConnection' method, the
btd_service_disconnect() call will fail at the service state
check and never handle the profile disconnection due to that
state was incorrectly left as BTD_SERVICE_STATE_DISCONNECTED.
Fix the problem by use service_accept() call in ext_connect()
to assure the service state has changed. Also modify the logic
of service state check in btd_service_connecting_complete()
to prevent the problem when the 'NewConnect' reply changes
service state to BTD_SERVICE_STATE_CONNECTED while the device
has already disconnected before it arrives.

---
 src/profile.c |  6 ++++--
 src/service.c | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index ca1dfec..4e68afc 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1036,8 +1036,10 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
 									conn);
 	}
 
-	if (send_new_connection(ext, conn))
-		return;
+	if (conn->service && service_accept(conn->service) == 0) {
+		if (send_new_connection(ext, conn))
+			return;
+	}
 
 drop:
 	if (conn->service)
diff --git a/src/service.c b/src/service.c
index 4d1f1cb..cae2804 100644
--- a/src/service.c
+++ b/src/service.c
@@ -185,16 +185,20 @@ int service_accept(struct btd_service *service)
 	int err;
 
 	if (!service->profile->accept)
-		return 0;
+		goto done;
 
 	err = service->profile->accept(service);
 	if (!err)
-		return 0;
+		goto done;
 
 	ba2str(device_get_address(service->device), addr);
 	error("%s profile accept failed for %s", service->profile->name, addr);
 
 	return err;
+
+done:
+	change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
+	return 0;
 }
 
 int btd_service_connect(struct btd_service *service)
@@ -336,8 +340,7 @@ bool btd_service_remove_state_cb(unsigned int id)
 
 void btd_service_connecting_complete(struct btd_service *service, int err)
 {
-	if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
-				service->state != BTD_SERVICE_STATE_CONNECTING)
+	if (service->state != BTD_SERVICE_STATE_CONNECTING)
 		return;
 
 	if (err == 0)
-- 
2.1.2

