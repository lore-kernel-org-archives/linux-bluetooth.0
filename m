Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 09/19] android/socket: Implement socket connect HAL method
Date: Wed, 20 Nov 2013 12:24:27 +0200
Message-Id: <1384943077-5366-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

First step is to query remote device for RFCOMM channel.
---
 android/socket.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 90561dc..1815367 100644
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
@@ -58,6 +61,8 @@ struct rfcomm_sock {
 
 	guint rfcomm_watch;
 	guint stack_watch;
+
+	bdaddr_t dst;
 };
 
 static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
@@ -419,11 +424,37 @@ static int handle_listen(void *buf)
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
+	struct rfcomm_sock *rfsock;
+	bdaddr_t dst;
+	uuid_t uuid;
+	int hal_fd = -1;
 
-	return -1;
+	DBG("");
+
+	android2bdaddr(cmd->bdaddr, &dst);
+	rfsock = create_rfsock(-1, &hal_fd);
+	bacpy(&rfsock->dst, &dst);
+
+	memset(&uuid, 0, sizeof(uuid));
+	uuid.type = SDP_UUID128;
+	memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
+
+	if (bt_search_service(&adapter_addr, &dst, &uuid, sdp_search_cb, rfsock,
+								NULL) < 0) {
+		error("Failed to search SDP records");
+		cleanup_rfsock(rfsock);
+		return -1;
+	}
+
+	return hal_fd;
 }
 
 void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-- 
1.7.10.4

