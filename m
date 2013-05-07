Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v1 1/3] device: Add function to find a given service
Date: Tue,  7 May 2013 09:44:02 +0200
Message-Id: <1367912644-17401-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Search within the list of services for a given remote UUID.
---
 src/device.c | 16 ++++++++++++++++
 src/device.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/src/device.c b/src/device.c
index ff4c553..14c3e81 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4376,6 +4376,22 @@ static void service_state_changed(struct btd_service *service,
 		device_profile_disconnected(device, profile, err);
 }
 
+struct btd_service *btd_device_get_service(struct btd_device *dev,
+						const char *remote_uuid)
+{
+	GSList *l;
+
+	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
+		struct btd_service *service = l->data;
+		struct btd_profile *p = btd_service_get_profile(service);
+
+		if (g_str_equal(p->remote_uuid, remote_uuid))
+			return service;
+	}
+
+	return NULL;
+}
+
 void btd_device_init(void)
 {
 	dbus_conn = btd_get_dbus_connection();
diff --git a/src/device.h b/src/device.h
index 7cd11af..70e1502 100644
--- a/src/device.h
+++ b/src/device.h
@@ -121,5 +121,8 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 bool device_remove_svc_complete_callback(struct btd_device *dev,
 							unsigned int id);
 
+struct btd_service *btd_device_get_service(struct btd_device *dev,
+						const char *remote_uuid);
+
 void btd_device_init(void);
 void btd_device_cleanup(void);
-- 
1.8.1.4

