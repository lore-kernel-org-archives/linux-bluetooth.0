Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] android/tester: remove not needed include of hal_msg.h
Date: Mon,  8 Dec 2014 11:35:06 +0100
Message-Id: <1418034908-1742-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1418034908-1742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418034908-1742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We shouldn't include header for one define. All test cases use internal
defines for commands as adopted.
---
 android/tester-gatt.c | 17 ++++++++---------
 android/tester-main.c |  7 +++++--
 android/tester-main.h |  1 +
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index e750cb3..de2a7a7 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -19,7 +19,6 @@
 
 #include "emulator/bthost.h"
 #include "tester-main.h"
-#include "hal-msg.h"
 #include "src/shared/util.h"
 
 #define ATT_HANDLE_SIZE	2
@@ -48,6 +47,8 @@
 
 #define TRANS1_ID	1
 
+#define BT_TRANSPORT_UNKNOWN		0x00
+
 #define GATT_SERVER_TRANSPORT_LE		0x01
 #define GATT_SERVER_TRANSPORT_BREDR		0x02
 #define GATT_SERVER_TRANSPORT_LE_BREDR		(0x01 | 0x02)
@@ -1172,10 +1173,9 @@ static void gatt_client_connect_action(void)
 	struct step *step = g_new0(struct step, 1);
 
 	step->action_status = data->if_gatt->client->connect(
-							conn_data->app_id,
-							&emu_remote_bdaddr_val,
-							0,
-							BT_TRANSPORT_UNKNOWN);
+						conn_data->app_id,
+						&emu_remote_bdaddr_val, 0,
+						BT_TRANSPORT_UNKNOWN);
 
 	schedule_action_verification(step);
 }
@@ -1405,10 +1405,9 @@ static void gatt_server_connect_action(void)
 	struct step *step = g_new0(struct step, 1);
 
 	step->action_status = data->if_gatt->server->connect(
-							conn_data->app_id,
-							&emu_remote_bdaddr_val,
-							0,
-							BT_TRANSPORT_UNKNOWN);
+						conn_data->app_id,
+						&emu_remote_bdaddr_val, 0,
+						BT_TRANSPORT_UNKNOWN);
 
 	schedule_action_verification(step);
 }
diff --git a/android/tester-main.c b/android/tester-main.c
index 429838d..6339b3a 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -19,7 +19,6 @@
 #include "src/shared/util.h"
 #include "emulator/bthost.h"
 #include "tester-main.h"
-#include "hal-msg.h"
 
 #include "monitor/bt.h"
 
@@ -30,6 +29,8 @@ static gint scheduled_cbacks_num;
 #define EMULATOR_SIGNAL_TIMEOUT 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
+#define BT_TRANSPORT_UNKNOWN	0x00
+
 static struct {
 	uint16_t cb_num;
 	const char *str;
@@ -2916,7 +2917,9 @@ void bt_create_bond_action(void)
 
 	step->action_status =
 			data->if_bluetooth->create_bond(action_data->addr,
-							BT_TRANSPORT_UNKNOWN);
+						action_data->transport_type ?
+						action_data->transport_type :
+						BT_TRANSPORT_UNKNOWN);
 
 	schedule_action_verification(step);
 }
diff --git a/android/tester-main.h b/android/tester-main.h
index 4407514..474afbb 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -606,6 +606,7 @@ struct bt_action_data {
 
 	/*Connection params*/
 	const uint8_t bearer_type;
+	const uint8_t transport_type;
 };
 
 /* bthost's l2cap server setup parameters */
-- 
1.9.3

