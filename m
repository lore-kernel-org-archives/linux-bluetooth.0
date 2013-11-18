Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 10/16] android/socket: Implement socket connect HAL method
Date: Mon, 18 Nov 2013 10:26:13 +0200
Message-Id: <1384763179-2218-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

First step is to query remote device for RFCOMM channel.
---
 android/socket.c |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index a800a77..c22e4ed 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -33,6 +33,9 @@
 #include "lib/bluetooth.h"
 #include "btio/btio.h"
 #include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "src/sdp-client.h"
+
 #include "log.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
@@ -52,6 +55,7 @@ struct rfcomm_slot {
 	int fd;		/* descriptor for communication with Java framework */
 	int real_sock;	/* real RFCOMM socket */
 	int channel;	/* RFCOMM channel */
+	bdaddr_t dst;
 };
 
 static struct rfcomm_slot *create_rfslot(int sock, int *hal_fd)
@@ -373,11 +377,37 @@ static int handle_listen(void *buf)
 	return hal_fd;
 }
 
+static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
+{
+	DBG("");
+}
+
 static int handle_connect(void *buf)
 {
-	DBG("Not implemented");
+	struct hal_cmd_sock_connect *cmd = buf;
+	struct rfcomm_slot *rfslot;
+	bdaddr_t dst;
+	uuid_t uuid;
+	int hal_fd = -1;
 
-	return -1;
+	DBG("");
+
+	android2bdaddr(cmd->bdaddr, &dst);
+	rfslot = create_rfslot(-1, &hal_fd);
+	bacpy(&rfslot->dst, &dst);
+
+	memset(&uuid, 0, sizeof(uuid));
+	uuid.type = SDP_UUID128;
+	memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
+
+	if (bt_search_service(&adapter_addr, &dst, &uuid, sdp_search_cb, rfslot,
+								NULL) < 0) {
+		error("Failed to search SDP records");
+		cleanup_rfslot(rfslot);
+		return -1;
+	}
+
+	return hal_fd;
 }
 
 void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-- 
1.7.10.4

