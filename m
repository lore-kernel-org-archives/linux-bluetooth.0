Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] androi/haltest: Make debug functions return const string
Date: Fri,  8 Nov 2013 16:08:49 +0200
Message-Id: <1383919730-13597-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/textconv.c |    6 +++---
 android/client/textconv.h |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index 60ac08a..dcbe53e 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -137,7 +137,7 @@ int int2str_findstr(const char *str, const struct int2str m[])
  *
  * returns buf
  */
-char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
+const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
 {
 	const uint8_t *p = bd_addr->address;
 
@@ -196,14 +196,14 @@ const char *enum_one_string(void *v, int i)
 	return (i == 0) && (m[0] != 0) ? m : NULL;
 }
 
-char *bdaddr2str(const bt_bdaddr_t *bd_addr)
+const char *bdaddr2str(const bt_bdaddr_t *bd_addr)
 {
 	static char buf[MAX_ADDR_STR_LEN];
 
 	return bt_bdaddr_t2str(bd_addr, buf);
 }
 
-char *btproperty2str(const bt_property_t *property)
+const char *btproperty2str(const bt_property_t *property)
 {
 	static char buf[4096];
 	char *p;
diff --git a/android/client/textconv.h b/android/client/textconv.h
index 837eb4e..0a72805 100644
--- a/android/client/textconv.h
+++ b/android/client/textconv.h
@@ -100,13 +100,13 @@ static struct int2str __##type##2str[] = {
 /* End of mapping section */
 
 #define MAX_ADDR_STR_LEN 18
-char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf);
+const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf);
 void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr);
 
 void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
 
-char *btproperty2str(const bt_property_t *property);
-char *bdaddr2str(const bt_bdaddr_t *bd_addr);
+const char *btproperty2str(const bt_property_t *property);
+const char *bdaddr2str(const bt_bdaddr_t *bd_addr);
 
 DECINTMAP(bt_status_t);
 DECINTMAP(bt_state_t);
-- 
1.7.10.4

