Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/4] android/gatt: Add helper to set security level
Date: Thu, 19 Jun 2014 00:41:24 +0200
Message-Id: <1403131286-15028-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 004dead..7061924 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2735,12 +2735,29 @@ static int get_sec_level(struct gatt_device *dev)
 	return sec_level;
 }
 
-static bool set_security_by_auth(struct gatt_device *device, int auth_type)
+static bool set_security_level(struct gatt_device *dev, int sec_level)
 {
-	int req_sec_level, sec_level;
 	GError *gerr = NULL;
 	GIOChannel *io;
 
+	io = g_attrib_get_channel(dev->attrib);
+	if (!io)
+		return false;
+
+	bt_io_set(io, &gerr, BT_IO_OPT_SEC_LEVEL, sec_level, BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("gatt: Failed to set security level: %s", gerr->message);
+		g_error_free(gerr);
+		return false;
+	}
+
+	return true;
+}
+
+static bool set_security_by_auth(struct gatt_device *device, int auth_type)
+{
+	int req_sec_level, sec_level;
+
 	switch (auth_type) {
 	case HAL_GATT_AUTHENTICATION_MITM:
 		req_sec_level = BT_SECURITY_HIGH;
@@ -2763,19 +2780,7 @@ static bool set_security_by_auth(struct gatt_device *device, int auth_type)
 	if (req_sec_level <= sec_level)
 		return true;
 
-	io = g_attrib_get_channel(device->attrib);
-	if (!io)
-		return false;
-
-	bt_io_set(io, &gerr, BT_IO_OPT_SEC_LEVEL, req_sec_level,
-							BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("gatt: Failed to set security level: %s", gerr->message);
-		g_error_free(gerr);
-		return false;
-	}
-
-	return true;
+	return set_security_level(device, req_sec_level);
 }
 
 static void handle_client_read_characteristic(const void *buf, uint16_t len)
-- 
1.8.4

