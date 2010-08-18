Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] sdp: Remove sdp_general_inquiry API
Date: Wed, 18 Aug 2010 18:13:30 +0800
Message-Id: <1282126410-6157-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So that sdp.c won't include hci.h and hci_lib.h. The inquiry operation
could be done by simply invoking hci_inquiry().
---
 lib/sdp.c       |   16 ----------------
 lib/sdp_lib.h   |    5 -----
 tools/sdptool.c |    6 ++++--
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 8a31b55..76695af 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -43,8 +43,6 @@
 #include <netinet/in.h>
 
 #include "bluetooth.h"
-#include "hci.h"
-#include "hci_lib.h"
 #include "l2cap.h"
 #include "sdp.h"
 #include "sdp_lib.h"
@@ -4523,20 +4521,6 @@ end:
 	return status;
 }
 
-/*
- * Find devices in the piconet.
- */
-int sdp_general_inquiry(inquiry_info *ii, int num_dev, int duration, uint8_t *found)
-{
-	int n = hci_inquiry(-1, 10, num_dev, NULL, &ii, 0);
-	if (n < 0) {
-		SDPERR("Inquiry failed:%s", strerror(errno));
-		return -1;
-	}
-	*found = n;
-	return 0;
-}
-
 int sdp_close(sdp_session_t *session)
 {
 	struct sdp_transaction *t;
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index e506ac1..5ad4b56 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -146,11 +146,6 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 
 uint16_t sdp_gen_tid(sdp_session_t *session);
 
-/*
- * find all devices in the piconet
- */
-int sdp_general_inquiry(inquiry_info *ii, int dev_num, int duration, uint8_t *found);
-
 /* flexible extraction of basic attributes - Jean II */
 int sdp_get_int_attr(const sdp_record_t *rec, uint16_t attr, int *value);
 int sdp_get_string_attr(const sdp_record_t *rec, uint16_t attr, char *value, int valuelen);
diff --git a/tools/sdptool.c b/tools/sdptool.c
index d06b159..3ce0fc3 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -3733,11 +3733,13 @@ static int cmd_del(int argc, char **argv)
 static void inquiry(handler_t handler, void *arg)
 {
 	inquiry_info ii[20];
-	uint8_t count = 0;
+	int count = 0;
 	int i;
 
 	printf("Inquiring ...\n");
-	if (sdp_general_inquiry(ii, 20, 8, &count) < 0) {
+
+	count = hci_inquiry(-1, 10, 20, NULL, (inquiry_info **) &ii, 0);
+	if (count < 0) {
 		printf("Inquiry failed\n");
 		return;
 	}
-- 
1.7.0.4

