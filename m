Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 10/11] android/ipc-tester: Add cases for Core message data size
Date: Mon, 20 Jan 2014 10:36:09 +0100
Message-Id: <1390210570-28260-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add testing for improper data sizes for Core service opcodes.
---
 android/ipc-tester.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index cebe751..3d1561d 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -573,6 +573,27 @@ static void ipc_send_tc(const void *data)
 				_servicelist);				\
 	} while (0)
 
+struct vardata {
+	struct hal_hdr hdr;
+	uint8_t buf[BLUEZ_HAL_MTU];
+} __attribute__((packed));
+
+#define test_datasize_valid(_name, _service, _opcode, _hlen, _addatasize, \
+							_servicelist...) \
+	do {								\
+		static struct vardata vdata = {				\
+			.hdr.service_id = _service,			\
+			.hdr.opcode = _opcode,				\
+			.hdr.len = (_hlen) + (_addatasize),		\
+			.buf = {},					\
+		};							\
+		test_generic("Data size "_name,				\
+				ipc_send_tc, setup, teardown,		\
+				&vdata,					\
+				sizeof(vdata.hdr) + (_hlen) + (_addatasize),\
+				_servicelist);				\
+	} while (0)
+
 struct regmod_msg register_bt_msg = {
 	.header = {
 		.service_id = HAL_SERVICE_ID_CORE,
@@ -686,5 +707,19 @@ int main(int argc, char *argv[])
 
 	test_opcode_valid("A2DP", HAL_SERVICE_ID_A2DP, 0x03, 0,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
+
+	/* check for valid data size */
+	test_datasize_valid("CORE Register+", HAL_SERVICE_ID_CORE,
+			HAL_OP_REGISTER_MODULE,
+			sizeof(struct hal_cmd_register_module), 1);
+	test_datasize_valid("CORE Register-", HAL_SERVICE_ID_CORE,
+			HAL_OP_REGISTER_MODULE,
+			sizeof(struct hal_cmd_register_module), -1);
+	test_datasize_valid("CORE Unregister+", HAL_SERVICE_ID_CORE,
+			HAL_OP_UNREGISTER_MODULE,
+			sizeof(struct hal_cmd_register_module), 1);
+	test_datasize_valid("CORE Unregister-", HAL_SERVICE_ID_CORE,
+			HAL_OP_UNREGISTER_MODULE,
+			sizeof(struct hal_cmd_register_module), -1);
 	return tester_run();
 }
-- 
1.8.5.2

