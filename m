Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/debug: Export print uuid function
Date: Tue,  5 Nov 2013 16:06:17 +0200
Message-Id: <1383660378-23198-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The function will be reused in socket HAL.
---
 android/client/textconv.c |    2 +-
 android/client/textconv.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index 9a2f7e6..e6f327f 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -237,7 +237,7 @@ char *bdaddr2str(const bt_bdaddr_t *bd_addr)
 	return bt_bdaddr_t2str(bd_addr, bdaddr_tls_buffer);
 }
 
-static char *btuuid2str(const bt_uuid_t *uuid)
+char *btuuid2str(const bt_uuid_t *uuid)
 {
 	static char buf[MAX_UUID_STR_LEN];
 
diff --git a/android/client/textconv.h b/android/client/textconv.h
index 1c848ef..7520b04 100644
--- a/android/client/textconv.h
+++ b/android/client/textconv.h
@@ -109,6 +109,7 @@ void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
 
 char *btproperty2str(const bt_property_t *property);
 char *bdaddr2str(const bt_bdaddr_t *bd_addr);
+char *btuuid2str(const bt_uuid_t *uuid);
 
 DECINTMAP(bt_status_t);
 DECINTMAP(bt_state_t);
-- 
1.7.10.4

