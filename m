Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/7] android/handsfree-client: Add devices queue
Date: Sun,  9 Nov 2014 01:24:15 +0100
Message-Id: <1415492659-3296-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415492659-3296-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415492659-3296-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds devices queue eventhough we are going to support only
one HF device at once
---
 android/handsfree-client.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index b63aa13..aa3912b 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -35,6 +35,7 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "src/sdp-client.h"
+#include "src/shared/queue.h"
 #include "ipc.h"
 #include "ipc-common.h"
 #include "src/log.h"
@@ -69,6 +70,7 @@ static struct ipc *hal_ipc = NULL;
 
 static uint32_t hfp_hf_features = 0;
 static uint32_t hfp_hf_record_id = 0;
+static struct queue *devices = NULL;
 
 static void handle_connect(const void *buf, uint16_t len)
 {
@@ -334,16 +336,28 @@ bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	DBG("");
 
+	devices = queue_new();
+	if (!devices) {
+		error("hf-client: Could not create devices list");
+		goto failed;
+	}
+
 	bacpy(&adapter_addr, addr);
 
 	if (!enable_hf_client())
-		return false;
+		goto failed;
 
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
+
+failed:
+	queue_destroy(devices, free);
+	devices = NULL;
+
+	return false;
 }
 
 void bt_hf_client_unregister(void)
@@ -352,6 +366,9 @@ void bt_hf_client_unregister(void)
 
 	cleanup_hfp_hf();
 
+	queue_destroy(devices, free);
+	devices = NULL;
+
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
 	hal_ipc = NULL;
 }
-- 
1.8.4

