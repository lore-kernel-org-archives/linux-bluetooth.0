Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/socket: Connect directly to RFCOMM chan is uuid is zero
Date: Wed, 18 Dec 2013 16:18:55 +0200
Message-Id: <1387376336-17092-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387376336-17092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387376336-17092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check uuid and connect to specified channel number directly.
---
 android/socket.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 656222e..7bc5b0b 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -925,10 +925,17 @@ fail:
 	cleanup_rfsock(rfsock);
 }
 
+static bool is_empty(const uint8_t *uuid)
+{
+	static uint8_t zero_uuid[16];
+
+	return memcmp(uuid, zero_uuid, sizeof(zero_uuid)) == 0;
+}
+
 static void handle_connect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_sock_connect *cmd = buf;
-	struct rfcomm_sock *rfsock;
+	struct rfcomm_sock *rfsock = NULL;
 	uuid_t uuid;
 	int hal_fd = -1;
 
@@ -940,17 +947,21 @@ static void handle_connect(const void *buf, uint16_t len)
 
 	android2bdaddr(cmd->bdaddr, &rfsock->dst);
 
-	memset(&uuid, 0, sizeof(uuid));
-	uuid.type = SDP_UUID128;
-	memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
+	if (is_empty(cmd->uuid)) {
+		if (!do_connect(rfsock, cmd->channel))
+			goto failed;
+	} else {
+		memset(&uuid, 0, sizeof(uuid));
+		uuid.type = SDP_UUID128;
+		memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
 
-	rfsock->profile = get_profile_by_uuid(cmd->uuid);
+		rfsock->profile = get_profile_by_uuid(cmd->uuid);
 
-	if (bt_search_service(&adapter_addr, &rfsock->dst, &uuid,
+		if (bt_search_service(&adapter_addr, &rfsock->dst, &uuid,
 					sdp_search_cb, rfsock, NULL) < 0) {
-		error("Failed to search SDP records");
-		cleanup_rfsock(rfsock);
-		goto failed;
+			error("Failed to search SDP records");
+			goto failed;
+		}
 	}
 
 	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT, 0, NULL,
@@ -962,6 +973,9 @@ failed:
 	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT,
 							HAL_STATUS_FAILED);
 
+	if (rfsock)
+		cleanup_rfsock(rfsock);
+
 	if (hal_fd >= 0)
 		close(hal_fd);
 }
-- 
1.8.3.2

