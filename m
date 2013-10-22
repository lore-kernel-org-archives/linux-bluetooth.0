Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 1/3] android: Add definition of buffer sizes to haltest
Date: Tue, 22 Oct 2013 13:02:25 +0200
Message-ID: <1382439747-13864-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382439747-13864-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382439747-13864-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds definition of sizes needed for text representation
of bluetooth address and uuid, this remove usage of magic numbers.
---
 android/client/if-bt.c    |    8 ++++----
 android/client/textconv.c |    2 +-
 android/client/textconv.h |    2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 30b41cd..f65e5f0 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -31,14 +31,14 @@ const bt_interface_t *if_bluetooth;
 
 static char *bdaddr2str(const bt_bdaddr_t *bd_addr)
 {
-	static char buf[18];
+	static char buf[MAX_ADDR_STR_LEN];
 
 	return bt_bdaddr_t2str(bd_addr, buf);
 }
 
 static char *btuuid2str(const bt_uuid_t *uuid)
 {
-	static char buf[39];
+	static char buf[MAX_UUID_STR_LEN];
 
 	return bt_uuid_t2str(uuid, buf);
 }
@@ -239,7 +239,7 @@ void add_remote_device(const bt_bdaddr_t *addr)
 
 const char *enum_devices(void *v, int i)
 {
-	static char buf[19];
+	static char buf[MAX_ADDR_STR_LEN];
 
 	if (i >= remote_devices_cnt)
 		return NULL;
@@ -310,7 +310,7 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
  * Buffer for remote addres that came from one of bind request.
  * It's stored for command completion.
  */
-static char last_remote_addr[18];
+static char last_remote_addr[MAX_ADDR_STR_LEN];
 static bt_ssp_variant_t last_ssp_variant = (bt_ssp_variant_t)-1;
 
 static void pin_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
diff --git a/android/client/textconv.c b/android/client/textconv.c
index 3493b1c..de7e23c 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -137,7 +137,7 @@ char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
 {
 	const char *p = (const char *) bd_addr;
 
-	snprintf(buf, 18, "%02x:%02x:%02x:%02x:%02x:%02x",
+	snprintf(buf, MAX_ADDR_STR_LEN, "%02x:%02x:%02x:%02x:%02x:%02x",
 					p[0], p[1], p[2], p[3], p[4], p[5]);
 
 	return buf;
diff --git a/android/client/textconv.h b/android/client/textconv.h
index 88da641..056e706 100644
--- a/android/client/textconv.h
+++ b/android/client/textconv.h
@@ -99,9 +99,11 @@ static struct int2str __##type##2str[] = {
 #define DELEMENT(s) {s, #s}
 /* End of mapping section */
 
+#define MAX_ADDR_STR_LEN 18
 char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf);
 void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr);
 
+#define MAX_UUID_STR_LEN 37
 char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf);
 void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
 
-- 
1.7.9.5

