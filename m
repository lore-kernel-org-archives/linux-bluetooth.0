Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 10/10] android/pan: Add PAN NAP sdp record fo server role
Date: Wed, 11 Dec 2013 12:13:45 +0200
Message-Id: <1386756825-934-11-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding PAN profile NAP SDP record on profile register call and
remove on unregister call.
---
 android/pan.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/pan.c b/android/pan.c
index 29b0a54..a6a8e27 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -44,9 +44,12 @@
 #include "utils.h"
 #include "bluetooth.h"
 
+#define SVC_HINT_CAPTURING 0x08
+
 static bdaddr_t adapter_addr;
 GSList *devices = NULL;
 uint8_t local_role = HAL_PAN_ROLE_NONE;
+static uint32_t record_id = 0;
 
 struct pan_device {
 	char		iface[16];
@@ -343,6 +346,7 @@ static const struct ipc_handler cmd_handlers[] = {
 
 bool bt_pan_register(const bdaddr_t *addr)
 {
+	sdp_record_t *rec = NULL;
 	int err;
 
 	DBG("");
@@ -355,6 +359,21 @@ bool bt_pan_register(const bdaddr_t *addr)
 		return false;
 	}
 
+	rec = pan_record("bnepnap", BNEP_SVC_NAP, TRUE);
+	if (!rec) {
+		bnep_cleanup();
+		return false;
+	}
+
+	if (bt_adapter_add_record(rec, SVC_HINT_CAPTURING) < 0) {
+		error("Failed to register on PAN record");
+		sdp_record_free(rec);
+		bnep_cleanup();
+		return false;
+	}
+
+	record_id = rec->handle;
+
 	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
@@ -373,6 +392,8 @@ void bt_pan_unregister(void)
 {
 	DBG("");
 
+	bt_adapter_remove_record(record_id);
+
 	g_slist_foreach(devices, free_pan_devices, NULL);
 	devices = NULL;
 	bnep_cleanup();
-- 
1.8.3.2

