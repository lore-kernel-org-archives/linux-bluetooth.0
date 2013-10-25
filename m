Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Fix incorrect casts of addresses
Date: Fri, 25 Oct 2013 10:51:10 +0200
Message-ID: <1382691070-24358-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes printing of addresses.
If char is set to be signed (as it should) some addresses were
printed with leading FFFFFF.
---
This issue did not showed up before due to unsigned char for Android build
on Qualcomm platform.

 android/client/textconv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index 1188477..bcdf4d9 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -137,7 +137,7 @@ int int2str_findstr(const char *str, const struct int2str m[])
  */
 char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
 {
-	const char *p = (const char *) bd_addr;
+	const uint8_t *p = bd_addr->address;
 
 	snprintf(buf, MAX_ADDR_STR_LEN, "%02x:%02x:%02x:%02x:%02x:%02x",
 					p[0], p[1], p[2], p[3], p[4], p[5]);
@@ -148,7 +148,7 @@ char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
 /* converts string to bt_bdaddr_t */
 void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr)
 {
-	char *p = (char *) bd_addr;
+	uint8_t *p = bd_addr->address;
 
 	sscanf(str, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
 			       &p[0], &p[1], &p[2], &p[3], &p[4], &p[5]);
-- 
1.7.9.5

