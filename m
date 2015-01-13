Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/pan: Make NAP variables struc dev_struct independent
Date: Tue, 13 Jan 2015 15:30:51 +0100
Message-Id: <1421159453-5535-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1421159453-5535-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1421159453-5535-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to keep NAP sdp id, io, mode in structure. Remove nap
structure and take variables out.
---
 android/pan.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 3ff8389..714e926 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -76,18 +76,11 @@ struct pan_device {
 static bdaddr_t adapter_addr;
 static GSList *devices = NULL;
 static uint8_t local_role = HAL_PAN_ROLE_NONE;
+static uint32_t nap_rec_id = 0;
+static GIOChannel *nap_io = NULL;
+static bool nap_bridge_mode = false;
 static struct ipc *hal_ipc = NULL;
 
-static struct {
-	uint32_t	record_id;
-	GIOChannel	*io;
-	bool		bridge;
-} nap_dev = {
-	.record_id = 0,
-	.io = NULL,
-	.bridge = false,
-};
-
 static int set_forward_delay(int sk)
 {
 	unsigned long args[4] = { BRCTL_SET_BRIDGE_FORWARD_DELAY, 0 , 0, 0 };
@@ -112,7 +105,7 @@ static int nap_create_bridge(void)
 
 	DBG("%s", BNEP_BRIDGE);
 
-	if (nap_dev.bridge)
+	if (nap_bridge_mode)
 		return 0;
 
 	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
@@ -133,7 +126,7 @@ static int nap_create_bridge(void)
 
 	close(sk);
 
-	nap_dev.bridge = err == 0;
+	nap_bridge_mode = err == 0;
 
 	return err;
 }
@@ -169,7 +162,7 @@ static int nap_remove_bridge(void)
 
 	DBG("%s", BNEP_BRIDGE);
 
-	if (!nap_dev.bridge)
+	if (!nap_bridge_mode)
 		return 0;
 
 	bridge_if_down();
@@ -187,7 +180,7 @@ static int nap_remove_bridge(void)
 	if (err < 0)
 		return err;
 
-	nap_dev.bridge = false;
+	nap_bridge_mode = false;
 
 	return 0;
 }
@@ -617,10 +610,10 @@ static void destroy_nap_device(void)
 
 	nap_remove_bridge();
 
-	if (nap_dev.io) {
-		g_io_channel_shutdown(nap_dev.io, FALSE, NULL);
-		g_io_channel_unref(nap_dev.io);
-		nap_dev.io = NULL;
+	if (nap_io) {
+		g_io_channel_shutdown(nap_io, FALSE, NULL);
+		g_io_channel_unref(nap_io);
+		nap_io = NULL;
 	}
 }
 
@@ -630,7 +623,7 @@ static int register_nap_server(void)
 
 	DBG("");
 
-	nap_dev.io = bt_io_listen(NULL, nap_confirm_cb, NULL, NULL, &gerr,
+	nap_io = bt_io_listen(NULL, nap_confirm_cb, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 					BT_IO_OPT_PSM, BNEP_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
@@ -638,7 +631,7 @@ static int register_nap_server(void)
 					BT_IO_OPT_IMTU, BNEP_MTU,
 					BT_IO_OPT_INVALID);
 
-	if (!nap_dev.io) {
+	if (!nap_io) {
 		destroy_nap_device();
 		error("%s", gerr->message);
 		g_error_free(gerr);
@@ -828,7 +821,7 @@ bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 		return false;
 	}
 
-	nap_dev.record_id = rec->handle;
+	nap_rec_id = rec->handle;
 
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_PAN, cmd_handlers,
@@ -850,7 +843,7 @@ void bt_pan_unregister(void)
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_PAN);
 	hal_ipc = NULL;
 
-	bt_adapter_remove_record(nap_dev.record_id);
-	nap_dev.record_id = 0;
+	bt_adapter_remove_record(nap_rec_id);
+	nap_rec_id = 0;
 	destroy_nap_device();
 }
-- 
1.9.3

