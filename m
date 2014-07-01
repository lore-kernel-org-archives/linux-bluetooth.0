Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] android: Fix local variables not being marked as static
Date: Tue,  1 Jul 2014 15:50:42 +0300
Message-Id: <1404219043-4216-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
References: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/ipc-tester.c | 8 ++++----
 android/pan.c        | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index f23e4b6..99cc31f 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -601,7 +601,7 @@ struct vardata {
 				_servicelist);				\
 	} while (0)
 
-struct regmod_msg register_bt_msg = {
+static struct regmod_msg register_bt_msg = {
 	.header = {
 		.service_id = HAL_SERVICE_ID_CORE,
 		.opcode = HAL_OP_REGISTER_MODULE,
@@ -612,7 +612,7 @@ struct regmod_msg register_bt_msg = {
 		},
 };
 
-struct regmod_msg register_bt_malformed_size_msg = {
+static struct regmod_msg register_bt_malformed_size_msg = {
 	.header = {
 		.service_id = HAL_SERVICE_ID_CORE,
 		.opcode = HAL_OP_REGISTER_MODULE,
@@ -645,13 +645,13 @@ static struct malformed_data3_struct malformed_data3_msg = {
 	. redundant_data = 666,
 };
 
-struct ipc_hdr enable_unknown_service_hdr = {
+static struct ipc_hdr enable_unknown_service_hdr = {
 	.service_id = HAL_SERVICE_ID_MAX + 1,
 	.opcode = HAL_OP_REGISTER_MODULE,
 	.len = 0,
 };
 
-struct ipc_hdr enable_bt_service_hdr = {
+static struct ipc_hdr enable_bt_service_hdr = {
 	.service_id = HAL_SERVICE_ID_BLUETOOTH,
 	.opcode = HAL_OP_ENABLE,
 	.len = 0,
diff --git a/android/pan.c b/android/pan.c
index 9eab932..c11ee29 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -63,8 +63,8 @@
 #define BNEP_NAP_INTERFACE "bt-pan%d"
 
 static bdaddr_t adapter_addr;
-GSList *devices = NULL;
-uint8_t local_role = HAL_PAN_ROLE_NONE;
+static GSList *devices = NULL;
+static uint8_t local_role = HAL_PAN_ROLE_NONE;
 static struct ipc *hal_ipc = NULL;
 
 struct pan_device {
-- 
1.9.3

