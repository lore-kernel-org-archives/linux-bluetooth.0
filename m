Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/pan: Minor style fix
Date: Tue, 13 Jan 2015 15:30:50 +0100
Message-Id: <1421159453-5535-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Empty line added between function definitions. Tab indention added.
Statics definitions should be placed after structures.
---
 android/pan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 6131890..3ff8389 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -63,11 +63,6 @@
 #define BNEP_PANU_INTERFACE "bt-pan"
 #define BNEP_NAP_INTERFACE "bt-pan%d"
 
-static bdaddr_t adapter_addr;
-static GSList *devices = NULL;
-static uint8_t local_role = HAL_PAN_ROLE_NONE;
-static struct ipc *hal_ipc = NULL;
-
 struct pan_device {
 	char		iface[16];
 	bdaddr_t	dst;
@@ -78,6 +73,11 @@ struct pan_device {
 	guint		watch;
 };
 
+static bdaddr_t adapter_addr;
+static GSList *devices = NULL;
+static uint8_t local_role = HAL_PAN_ROLE_NONE;
+static struct ipc *hal_ipc = NULL;
+
 static struct {
 	uint32_t	record_id;
 	GIOChannel	*io;
@@ -463,6 +463,7 @@ static gboolean nap_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 
 	return FALSE;
 }
+
 static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 							gpointer user_data)
 {
@@ -488,7 +489,7 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 
 	/* Highest known control command id BNEP_FILTER_MULT_ADDR_RSP 0x06 */
 	if (req->type == BNEP_CONTROL &&
-			req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
+					req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
 		error("cmd not understood");
 		bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_CMD_NOT_UNDERSTOOD,
 								req->ctrl);
-- 
1.9.3

