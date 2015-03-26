Return-Path: <cyrus@holtmann.org>
From: Hsin-Yu Chao <hychao@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: armansito@chromium.org, Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH] src/profile: Set service to connecting in ext_connect
Date: Thu, 26 Mar 2015 14:53:23 +0800
Message-Id: <1427352803-9264-1-git-send-email-hychao@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the profile connection initiated by remote device,
ext_connect() function is triggered without advance the state
of device's service to BTD_SERVICE_STATE_DISCONNECTING.
This is causing a problems when the later 'NewConnection'
dbus method call is made to registered application. If
the remote device gets disconnected during the period of
time waiting for the reply of 'NewConnection' method, the
btd_service_disconnect() call will fail at the service state
check and never handle the profile disconnection due to that
state was incorrectly left as BTD_SERVICE_STATE_DISCONNECTED.
Fix the problem by adding additional call in ext_connect()
to assure the service state has changed. Also modify the logic
of service state check in btd_service_connecting_complete()
to prevent the problem when the 'NewConnect' reply changes
service state to BTD_SERVICE_STATE_CONNECTED while the device
has already disconnected before it arrives.

Change-Id: If02af58f65480c35c697739c5a545c59d1088fdb
---
 src/profile.c |  5 ++++-
 src/service.c | 11 +++++++++--
 src/service.h |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index ca1dfec..31740b0 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1036,8 +1036,11 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
 									conn);
 	}
 
-	if (send_new_connection(ext, conn))
+	if (send_new_connection(ext, conn)) {
+		if (conn->service)
+			btd_service_connecting_start(conn->service);
 		return;
+	}
 
 drop:
 	if (conn->service)
diff --git a/src/service.c b/src/service.c
index 4d1f1cb..15a5b0d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -334,10 +334,17 @@ bool btd_service_remove_state_cb(unsigned int id)
 	return false;
 }
 
+void btd_service_connecting_start(struct btd_service *service)
+{
+	if (service->state != BTD_SERVICE_STATE_DISCONNECTED)
+		return;
+
+	change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
+}
+
 void btd_service_connecting_complete(struct btd_service *service, int err)
 {
-	if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
-				service->state != BTD_SERVICE_STATE_CONNECTING)
+	if (service->state != BTD_SERVICE_STATE_CONNECTING)
 		return;
 
 	if (err == 0)
diff --git a/src/service.h b/src/service.h
index c1f97f6..0967249 100644
--- a/src/service.h
+++ b/src/service.h
@@ -65,6 +65,7 @@ unsigned int btd_service_add_state_cb(btd_service_state_cb cb,
 bool btd_service_remove_state_cb(unsigned int id);
 
 /* Functions used by profile implementation */
+void btd_service_connecting_start(struct btd_service *service);
 void btd_service_connecting_complete(struct btd_service *service, int err);
 void btd_service_disconnecting_complete(struct btd_service *service, int err);
 void btd_service_set_user_data(struct btd_service *service, void *user_data);
-- 
2.1.2

