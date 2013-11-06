Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/hal: Rename hal_op_sock_listen to hal_cmd_sock_listen
Date: Wed,  6 Nov 2013 16:03:33 +0200
Message-Id: <1383746614-15077-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383746614-15077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383746614-15077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This makes structures consistent with the rest of the code.
---
 android/hal-msg.h  |    4 ++--
 android/hal-sock.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index f0cc800..a5e5c76 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -215,7 +215,7 @@ struct hal_cmd_le_test_mode {
 /* Bluetooth Socket HAL api */
 
 #define HAL_OP_SOCK_LISTEN		0x01
-struct hal_op_sock_listen {
+struct hal_cmd_sock_listen {
 	uint8_t  type;
 	uint8_t  name[256];
 	uint8_t  uuid[16];
@@ -224,7 +224,7 @@ struct hal_op_sock_listen {
 } __attribute__((packed));
 
 #define HAL_OP_SOCK_CONNECT		0x02
-struct hal_op_sock_connect {
+struct hal_cmd_sock_connect {
 	uint8_t  bdaddr[6];
 	uint8_t  type;
 	uint8_t  uuid[16];
diff --git a/android/hal-sock.c b/android/hal-sock.c
index cd85f1f..32c7939 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -29,7 +29,7 @@ static bt_status_t sock_listen_rfcomm(const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
-	struct hal_op_sock_listen cmd;
+	struct hal_cmd_sock_listen cmd;
 
 	DBG("");
 
@@ -73,7 +73,7 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
-	struct hal_op_sock_connect cmd;
+	struct hal_cmd_sock_connect cmd;
 
 	if ((!uuid && chan <= 0) || !bdaddr || !sock) {
 		error("invalid params: bd_addr %p, uuid %p, chan %d, sock %p",
-- 
1.7.10.4

