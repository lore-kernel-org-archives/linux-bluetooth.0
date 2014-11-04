Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/6] android/hal-bluetooth: Add parameter to create_bond
Date: Tue,  4 Nov 2014 14:24:45 +0200
Message-Id: <1415103890-24375-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add parameter to create_bond following new bluetooth.h HAL, transport is
defined in bluedroid include/bt_types.h. Bluetooth daemon shall check
transport parameter and make needed decisions, by default parameter is
unknown and this is the way bluedroid manage it itself.
---
 android/bluetooth.c     |  2 ++
 android/hal-bluetooth.c | 19 ++++++++++++++++++-
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  5 +++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 03eb1a1..fdfa0d3 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -4323,6 +4323,8 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 	cp.addr.type = select_device_bearer(dev);
 	bacpy(&cp.addr.bdaddr, &dev->bdaddr);
 
+	/* TODO: Handle transport parameter */
+
 	if (device_is_paired(dev, cp.addr.type)) {
 		status = HAL_STATUS_FAILED;
 		goto fail;
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 97440e2..e9e413b 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -736,7 +736,7 @@ static int cancel_discovery(void)
 						NULL, NULL, NULL, NULL);
 }
 
-static int create_bond(const bt_bdaddr_t *bd_addr)
+static int create_bond_real(const bt_bdaddr_t *bd_addr, int transport)
 {
 	struct hal_cmd_create_bond cmd;
 
@@ -745,12 +745,29 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	if (transport < BT_TRANSPORT_UNKNOWN || transport > BT_TRANSPORT_LE)
+		return BT_STATUS_PARM_INVALID;
+
+	cmd.transport = transport;
+
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static int create_bond(const bt_bdaddr_t *bd_addr, int transport)
+{
+	return create_bond_real(bd_addr, transport);
+}
+#else
+static int create_bond(const bt_bdaddr_t *bd_addr)
+{
+	return create_bond_real(bd_addr, BT_TRANSPORT_UNKNOWN);
+}
+#endif
+
 static int cancel_bond(const bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_cancel_bond cmd;
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

