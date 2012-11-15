Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] device: Remove storage path #defines
Date: Thu, 15 Nov 2012 18:31:34 +0100
Message-Id: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

INFO_PATH and CACHE_PATH will be static for the
entire 5.x series
---
 src/device.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 4ca375b..e3570cb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -76,9 +76,6 @@
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
 
-#define INFO_PATH STORAGEDIR "/%s/%s/info"
-#define CACHE_PATH STORAGEDIR "/%s/cache/%s"
-
 struct btd_disconnect_data {
 	guint id;
 	disconnect_watch watch;
@@ -231,7 +228,8 @@ static gboolean store_device_info_cb(gpointer user_data)
 
 	ba2str(adapter_get_address(device->adapter), adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
-	snprintf(filename, PATH_MAX, INFO_PATH, adapter_addr, device_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+			device_addr);
 	filename[PATH_MAX] = '\0';
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
@@ -1693,7 +1691,7 @@ static char *load_cached_name(struct btd_device *device, const char *local,
 	char *str = NULL;
 	int len;
 
-	snprintf(filename, PATH_MAX, CACHE_PATH, local, peer);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
 	filename[PATH_MAX] = '\0';
 
 	key_file = g_key_file_new();
@@ -1722,7 +1720,7 @@ static void load_info(struct btd_device *device, const gchar *local,
 	char *str;
 	gboolean store_needed = FALSE;
 
-	snprintf(filename, PATH_MAX, INFO_PATH, local, peer);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", local, peer);
 	filename[PATH_MAX] = '\0';
 
 	key_file = g_key_file_new();
-- 
1.7.9.5

