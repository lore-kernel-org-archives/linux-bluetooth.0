Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 02/47] android/hal-bluetooth: Add parameter to create_bond
Date: Tue,  4 Nov 2014 10:18:25 +0200
Message-Id: <1415089150-18798-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add parameter to create_bond following new bluetooth.h HAL, transport is
defined in bluedroid include/bt_types.h. Bluetooth daemon shall check
transport parameter and make needed decisions, by default parameter is
unknown and this is the way bluedroid manage it itself.
---
 android/hal-bluetooth.c | 13 +++++++++++++
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  5 +++++
 3 files changed, 19 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 97440e2..5b6e99d 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -736,7 +736,11 @@ static int cancel_discovery(void)
 						NULL, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 static int create_bond(const bt_bdaddr_t *bd_addr)
+#else
+static int create_bond(const bt_bdaddr_t *bd_addr, int transport)
+#endif
 {
 	struct hal_cmd_create_bond cmd;
 
@@ -745,6 +749,15 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	if (transport < BT_TRANSPORT_UNKNOWN || transport > BT_TRANSPORT_LE)
+		return BT_STATUS_PARM_INVALID;
+
+	cmd.transport = transport;
+#else
+	cmd.transport = BT_TRANSPORT_UNKNOWN;
+#endif
+
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 6c647b7..3a3ae92 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -275,6 +275,7 @@ Commands and responses:
 	Opcode 0x0d - Create Bond command/response
 
 		Command parameters: Remote address (6 octets)
+		                    Transport (1 octet)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 12efcef..bcb73b2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -190,9 +190,14 @@ struct hal_cmd_get_remote_services {
 
 #define HAL_OP_CANCEL_DISCOVERY		0x0c
 
+#define BT_TRANSPORT_UNKNOWN		0x00
+#define BT_TRANSPORT_BR_EDR		0x01
+#define BT_TRANSPORT_LE			0x02
+
 #define HAL_OP_CREATE_BOND		0x0d
 struct hal_cmd_create_bond {
 	uint8_t bdaddr[6];
+	uint8_t transport;
 } __attribute__((packed));
 
 #define HAL_OP_REMOVE_BOND		0x0e
-- 
1.9.1

