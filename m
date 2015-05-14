Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] emulator/bthost: Add support for setting custom ADV data
Date: Thu, 14 May 2015 12:50:28 +0200
Message-Id: <1431600630-8568-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to set any ADV data and not just flags.
---
 android/tester-main.c | 13 +++++++++++--
 emulator/bthost.c     | 35 +++++++++++++++++------------------
 emulator/bthost.h     |  5 +++--
 tools/l2cap-tester.c  |  2 +-
 tools/mgmt-tester.c   |  2 +-
 tools/smp-tester.c    |  2 +-
 6 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 2506548..19400fc 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2719,8 +2719,17 @@ void emu_setup_powered_remote_action(void)
 	bthost_set_cmd_complete_cb(bthost, emu_connectable_complete, data);
 
 	if ((data->hciemu_type == HCIEMU_TYPE_LE) ||
-				(data->hciemu_type == HCIEMU_TYPE_BREDRLE))
-		bthost_set_adv_enable(bthost, 0x01, 0x02);
+				(data->hciemu_type == HCIEMU_TYPE_BREDRLE)) {
+		uint8_t adv[4];
+
+		adv[0] = 0x02;	/* Field length */
+		adv[1] = 0x01;	/* Flags */
+		adv[2] = 0x02;	/* Flags value */
+		adv[3] = 0x00;	/* Field terminator */
+
+		bthost_set_adv_data(bthost, adv, sizeof(adv));
+		bthost_set_adv_enable(bthost, 0x01);
+	}
 
 	if (data->hciemu_type != HCIEMU_TYPE_LE)
 		bthost_write_scan_enable(bthost, 0x03);
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 2b48ad8..29bbe5d 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2279,30 +2279,29 @@ void bthost_write_scan_enable(struct bthost *bthost, uint8_t scan)
 	send_command(bthost, BT_HCI_CMD_WRITE_SCAN_ENABLE, &scan, 1);
 }
 
-void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable, uint8_t flags)
+void bthost_set_adv_data(struct bthost *bthost, const uint8_t *data,
+								uint8_t len)
 {
-	struct bt_hci_cmd_le_set_adv_parameters cp;
-
-	memset(&cp, 0, sizeof(cp));
-	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
-							&cp, sizeof(cp));
+	struct bt_hci_cmd_le_set_adv_data adv_cp;
 
-	if (flags) {
-		struct bt_hci_cmd_le_set_adv_data adv_cp;
+	memset(adv_cp.data, 0, 31);
 
-		memset(adv_cp.data, 0, 31);
-
-		adv_cp.data[0] = 0x02;	/* Field length */
-		adv_cp.data[1] = 0x01;	/* Flags */
-		adv_cp.data[2] = flags;
+	if (len) {
+		adv_cp.len = len;
+		memcpy(adv_cp.data, data, len);
+	}
 
-		adv_cp.data[3] = 0x00;	/* Field terminator */
+	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_DATA, &adv_cp,
+							sizeof(adv_cp));
+}
 
-		adv_cp.len = 1 + adv_cp.data[0];
+void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
+{
+	struct bt_hci_cmd_le_set_adv_parameters cp;
 
-		send_command(bthost, BT_HCI_CMD_LE_SET_ADV_DATA, &adv_cp,
-								sizeof(adv_cp));
-	}
+	memset(&cp, 0, sizeof(cp));
+	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
+							&cp, sizeof(cp));
 
 	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_ENABLE, &enable, 1);
 }
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 6beb1f4..7110db8 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -79,8 +79,9 @@ bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t req,
 
 void bthost_write_scan_enable(struct bthost *bthost, uint8_t scan);
 
-void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable,
-								uint8_t flags);
+void bthost_set_adv_data(struct bthost *bthost, const uint8_t *data,
+								uint8_t len);
+void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode);
 
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 7f03591..2b89045 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -546,7 +546,7 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, user_data);
 	if (data->hciemu_type == HCIEMU_TYPE_LE)
-		bthost_set_adv_enable(bthost, 0x01, 0x00);
+		bthost_set_adv_enable(bthost, 0x01);
 	else
 		bthost_write_scan_enable(bthost, 0x03);
 }
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index fab8d35..fd5ef7d 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4547,7 +4547,7 @@ static void setup_bthost(void)
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, data);
 	if (data->hciemu_type == HCIEMU_TYPE_LE)
-		bthost_set_adv_enable(bthost, 0x01, 0x00);
+		bthost_set_adv_enable(bthost, 0x01);
 	else
 		bthost_write_scan_enable(bthost, 0x03);
 }
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index c44dc2d..d24c9b2 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -493,7 +493,7 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
-	bthost_set_adv_enable(bthost, 0x01, 0x00);
+	bthost_set_adv_enable(bthost, 0x01);
 }
 
 static void make_pk(struct test_data *data)
-- 
1.9.3

