Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] adapter: Remove storage path #defines
Date: Wed, 14 Nov 2012 12:28:53 +0100
Message-Id: <1352892533-15154-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1352892533-15154-1-git-send-email-frederic.danis@linux.intel.com>
References: <1352892533-15154-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SETTINGS_PATH and CACHE_PATH will be static for the
entire 5.x series
---
 src/adapter.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bdea378..3f09295 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -84,9 +84,6 @@
 #define REMOVE_TEMP_TIMEOUT (3 * 60)
 #define PENDING_FOUND_MAX 5
 
-#define SETTINGS_PATH STORAGEDIR "/%s/settings"
-#define CACHE_PATH STORAGEDIR "/%s/cache/%s"
-
 static GSList *adapter_drivers = NULL;
 
 enum session_req_type {
@@ -244,7 +241,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
 					adapter->discov_timeout);
 
 	ba2str(&adapter->bdaddr, address);
-	snprintf(filename, PATH_MAX, SETTINGS_PATH, address);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
 	filename[PATH_MAX] = '\0';
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
@@ -267,7 +264,7 @@ static void store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
 
 	ba2str(local, s_addr);
 	ba2str(peer, d_addr);
-	snprintf(filename, PATH_MAX, CACHE_PATH, s_addr, d_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", s_addr, d_addr);
 	filename[PATH_MAX] = '\0';
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
@@ -2703,7 +2700,7 @@ static void load_config(struct btd_adapter *adapter)
 
 	key_file = g_key_file_new();
 
-	snprintf(filename, PATH_MAX, SETTINGS_PATH, address);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
 	filename[PATH_MAX] = '\0';
 
 	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
-- 
1.7.9.5

