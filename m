Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/5] android/handsfree-client: Add SCO to handsfree client
Date: Fri, 28 Nov 2014 10:37:21 +0100
Message-Id: <1417167445-29099-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 283519f..9e67c7f 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -47,6 +47,7 @@
 #include "bluetooth.h"
 #include "hal-msg.h"
 #include "handsfree-client.h"
+#include "sco.h"
 
 #define HFP_HF_CHANNEL 7
 
@@ -139,6 +140,8 @@ static uint32_t hfp_hf_record_id = 0;
 static struct queue *devices = NULL;
 static GIOChannel *hfp_hf_server = NULL;
 
+static struct bt_sco *sco = NULL;
+
 static struct device *find_default_device(void)
 {
 	return queue_peek_head(devices);
@@ -1999,6 +2002,11 @@ static void cleanup_hfp_hf(void)
 		bt_adapter_remove_record(hfp_hf_record_id);
 		hfp_hf_record_id = 0;
 	}
+
+	if (sco) {
+		bt_sco_unref(sco);
+		sco = NULL;
+	}
 }
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
@@ -2016,6 +2024,12 @@ bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
 	if (!enable_hf_client())
 		goto failed;
 
+	sco = bt_sco_new(addr);
+	if (!sco) {
+		error("hf-client: Cannot create SCO. HFP AG is in use ?");
+		goto failed;
+	}
+
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
@@ -2023,6 +2037,7 @@ bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
 	return true;
 
 failed:
+	cleanup_hfp_hf();
 	queue_destroy(devices, free);
 	devices = NULL;
 
-- 
1.8.4

