Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 8/9] android: Use thread-safe helpers
Date: Tue, 29 Oct 2013 14:57:38 +0200
Message-Id: <1383051459-29495-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make use of thread-safe helpers.
---
 android/client/textconv.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index 1dc6ad0..effd1b3 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -19,6 +19,8 @@
 #include <stdio.h>
 #include <hardware/bluetooth.h>
 
+#include "../pthread-local.h"
+
 #include "textconv.h"
 
 /*
@@ -227,11 +229,12 @@ const char *enum_one_string(void *v, int i)
 	return (i == 0) && (m[0] != 0) ? m : NULL;
 }
 
+GLOBAL_INIT_THREAD_LOCAL_BUFFER(bdaddr);
 char *bdaddr2str(const bt_bdaddr_t *bd_addr)
 {
-	static char buf[MAX_ADDR_STR_LEN];
+	LOCAL_INIT_THREAD_LOCAL_BUFFER(char*, bdaddr, MAX_ADDR_STR_LEN);
 
-	return bt_bdaddr_t2str(bd_addr, buf);
+	return bt_bdaddr_t2str(bd_addr, bdaddr_tls_buffer);
 }
 
 static char *btuuid2str(const bt_uuid_t *uuid)
@@ -241,12 +244,14 @@ static char *btuuid2str(const bt_uuid_t *uuid)
 	return bt_uuid_t2str(uuid, buf);
 }
 
+GLOBAL_INIT_THREAD_LOCAL_BUFFER(property);
 char *btproperty2str(const bt_property_t *property)
 {
-	static char buf[4096];
 	char *p;
+	LOCAL_INIT_THREAD_LOCAL_BUFFER(char*, property, 4096);
 
-	p = buf + sprintf(buf, "type=%s len=%d val=",
+	p = property_tls_buffer + sprintf(property_tls_buffer,
+					"type=%s len=%d val=",
 					bt_property_type_t2str(property->type),
 					property->len);
 
@@ -334,5 +339,5 @@ char *btproperty2str(const bt_property_t *property)
 		sprintf(p, "%p", property->val);
 	}
 
-	return buf;
+	return property_tls_buffer;
 }
-- 
1.7.10.4

