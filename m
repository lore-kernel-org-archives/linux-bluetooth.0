Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v5 3/8] core: Add support for retrying a bonding
Date: Wed,  8 May 2013 17:37:57 -0700
Message-Id: <1368059882-9986-4-git-send-email-deymo@chromium.org>
In-Reply-To: <1368059882-9986-1-git-send-email-deymo@chromium.org>
References: <1368059882-9986-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

In order to retry a bonding we need a timer that will perform the
retry, we need to stash the status of the bonding request so we
can use it again. In the case of a retrying bonding attempt we
need to not tear down the temporary D-Bus device object on the
adapter.
---
 src/adapter.c |  2 +-
 src/device.c  | 12 ++++++++++++
 src/device.h  |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index bf10268..bcf54d5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4239,7 +4239,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 	if (device_is_authenticating(device))
 		device_cancel_authentication(device, TRUE);
 
-	if (device_is_temporary(device)) {
+	if (device_is_temporary(device) && !device_is_retrying(device)) {
 		const char *path = device_get_path(device);
 
 		DBG("Removing temporary device %s", path);
diff --git a/src/device.c b/src/device.c
index 005acb3..012e150 100644
--- a/src/device.c
+++ b/src/device.c
@@ -88,6 +88,8 @@ struct bonding_req {
 	struct btd_device *device;
 	struct agent *agent;
 	struct btd_adapter_pin_cb_iter *cb_iter;
+	uint8_t status;
+	guint retry_timer;
 };
 
 typedef enum {
@@ -1625,6 +1627,9 @@ static void bonding_request_free(struct bonding_req *bonding)
 		bonding->agent = NULL;
 	}
 
+	if (bonding->retry_timer)
+		g_source_remove(bonding->retry_timer);
+
 	if (bonding->device)
 		bonding->device->bonding = NULL;
 
@@ -3673,6 +3678,13 @@ static void device_auth_req_free(struct btd_device *device)
 	device->authr = NULL;
 }
 
+bool device_is_retrying(struct btd_device *device)
+{
+	struct bonding_req *bonding = device->bonding;
+
+	return bonding && bonding->retry_timer > 0;
+}
+
 void device_bonding_complete(struct btd_device *device, uint8_t status)
 {
 	struct bonding_req *bonding = device->bonding;
diff --git a/src/device.h b/src/device.h
index 0869e22..b7d5c45 100644
--- a/src/device.h
+++ b/src/device.h
@@ -74,6 +74,7 @@ void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
 gboolean device_is_connected(struct btd_device *device);
+bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t status);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
-- 
1.8.2.1
