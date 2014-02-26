Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 07/17] emulator: Use timeout for sending inquiry results
Date: Wed, 26 Feb 2014 02:57:18 +0100
Message-ID: <1393379848-4031-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch btdev uses timeout to schedule inquiry results
It also allows btdev to receive hci commands during inquiry.
Previously btdev was blocked since all the inquiry result were sent in
single loop
---
 Makefile.tools      | 19 ++++++++----
 android/Makefile.am |  2 ++
 emulator/btdev.c    | 87 +++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 15d810f..0a41ec3 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -48,6 +48,7 @@ emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 				monitor/mainloop.h monitor/mainloop.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/crypto.h src/shared/crypto.c \
+				src/sharead/timeout.h src/shared/timeout-mainloop.c \
 				emulator/server.h emulator/server.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
@@ -82,7 +83,8 @@ tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
-				src/shared/tester.h src/shared/tester.c
+				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c
 tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
@@ -94,7 +96,8 @@ tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
-				src/shared/tester.h src/shared/tester.c
+				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c
 tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
@@ -106,7 +109,8 @@ tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
-				src/shared/tester.h src/shared/tester.c
+				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c
 tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
@@ -118,7 +122,8 @@ tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
-				src/shared/tester.h src/shared/tester.c
+				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c
 tools_smp_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
@@ -128,7 +133,8 @@ tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
 				src/shared/util.h src/shared/util.c \
 				src/shared/queue.h src/shared/queue.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
-				src/shared/tester.h src/shared/tester.c
+				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c
 tools_gap_tester_LDADD =  lib/libbluetooth-internal.la \
 				gdbus/libgdbus-internal.la \
 				@GLIB_LIBS@ @DBUS_LIBS@
@@ -142,7 +148,8 @@ tools_sco_tester_SOURCES = tools/sco-tester.c monitor/bt.h \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
-				src/shared/tester.h src/shared/tester.c
+				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c
 tools_sco_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h \
diff --git a/android/Makefile.am b/android/Makefile.am
index b93b840..036a08b 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -117,6 +117,7 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
 				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c \
 				monitor/rfcomm.h \
 				android/hardware/hardware.c \
 				android/android-tester.c
@@ -139,6 +140,7 @@ android_ipc_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
 				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c \
 				android/hal-utils.h android/hal-utils.c \
 				android/ipc-tester.c
 
diff --git a/emulator/btdev.c b/emulator/btdev.c
index c6bf96c..18f7410 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,6 +33,7 @@
 #include <alloca.h>
 
 #include "src/shared/util.h"
+#include "src/shared/timeout.h"
 #include "monitor/bt.h"
 #include "btdev.h"
 
@@ -68,6 +69,8 @@ struct btdev {
 	btdev_send_func send_handler;
 	void *send_data;
 
+	int inquiry_id;
+
 	struct hook *hook_list[MAX_HOOK_ENTRIES];
 
         uint16_t manufacturer;
@@ -122,8 +125,16 @@ struct btdev {
 	uint8_t  sync_train_service_data;
 };
 
+struct inquiry_data {
+	struct btdev *btdev;
+	int sent_count;
+};
+
+#define DEFAULT_INQUIRY_INTERVAL 2 /* 2 miliseconds */
+
 #define MAX_BTDEV_ENTRIES 16
 
+
 static const uint8_t LINK_KEY_NONE[16] = { 0 };
 static const uint8_t LINK_KEY_DUMMY[16] = {	0, 1, 2, 3, 4, 5, 6, 7,
 						8, 9, 0, 1, 2, 3, 4, 5 };
@@ -527,9 +538,13 @@ void btdev_destroy(struct btdev *btdev)
 	if (!btdev)
 		return;
 
+	if (btdev->inquiry_id)
+		timeout_remove(btdev->inquiry_id);
+
 	del_btdev(btdev);
 
 	free(btdev);
+	btdev = NULL;
 }
 
 const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
@@ -683,12 +698,22 @@ static void num_completed_packets(struct btdev *btdev)
 	}
 }
 
-static void inquiry_complete(struct btdev *btdev, uint8_t status)
+static bool inquiry_callback(void *user_data)
 {
-	struct bt_hci_evt_inquiry_complete ic;
+	struct inquiry_data *data = user_data;
+	struct btdev *btdev = data->btdev;
+	static int j;
+	int sent = data->sent_count;
 	int i;
 
-	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+	if (!btdev)
+		return false;
+
+	for (i = j; i < MAX_BTDEV_ENTRIES; i++, j++) {
+		/*Lets sent 10 inquiry results at once */
+		if (sent + 10 == data->sent_count)
+			break;
+
 		if (!btdev_list[i] || btdev_list[i] == btdev)
 			continue;
 
@@ -710,6 +735,7 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
 
 			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT, &ir,
 								sizeof(ir));
+			data->sent_count++;
 			continue;
 		}
 
@@ -726,6 +752,7 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
 
 			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT_WITH_RSSI,
 							&ir, sizeof(ir));
+			data->sent_count++;
 		} else {
 			struct bt_hci_evt_inquiry_result ir;
 
@@ -739,11 +766,59 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
 
 			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT, &ir,
 								sizeof(ir));
+			data->sent_count++;
 		}
-        }
+	}
+
+	if (i == MAX_BTDEV_ENTRIES) {
+		struct bt_hci_evt_inquiry_complete ic;
+
+		ic.status = BT_HCI_ERR_SUCCESS;
+		send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+
+		/* reset */
+		btdev->inquiry_id = 0;
+		j = 0;
 
-	ic.status = status;
+		return false;
+	}
+
+	return true;
+}
+
+static void inquiry_destroy(void *user_data)
+{
+	struct inquiry_data *data = user_data;
+
+	if (data->btdev)
+		data->btdev->inquiry_id = 0;
+
+	free(data);
+}
+
+static void inquiry_cmd(struct btdev *btdev, const void *cmd)
+{
+	struct inquiry_data *data;
+	struct bt_hci_evt_inquiry_complete ic;
+
+	if (btdev->inquiry_id)
+		return;
+
+	data = malloc(sizeof(*data));
+	if (!data)
+		goto error;
+
+	memset(data, 0, sizeof(*data));
+	data->btdev = btdev;
+
+	btdev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
+				inquiry_callback, data, inquiry_destroy);
+	/* Return if success */
+	if (btdev->inquiry_id)
+		return;
 
+error:
+	ic.status = BT_HCI_ERR_HARDWARE_FAILURE;
 	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
 }
 
@@ -2480,7 +2555,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_INQUIRY:
 		if (btdev->type == BTDEV_TYPE_LE)
 			return;
-		inquiry_complete(btdev, BT_HCI_ERR_SUCCESS);
+		inquiry_cmd(btdev, data);
 		break;
 
 	case BT_HCI_CMD_CREATE_CONN:
-- 
1.8.4

