Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 6/6] emulator: Implement LE advertising report
Date: Wed,  3 Jul 2013 16:54:56 -0400
Message-Id: <1372884896-11419-7-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a virtual device starts a LE advertising, emulator searches for
other virtual devices that are in scan mode, in order to send adv data
to these devices.
Inverse goes when LE scan is enabled. Emulator searches virtual devices
that are in advertising mode and copy adv data to them.
---
 emulator/btdev.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c98a20d..79d2f0e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -811,6 +811,60 @@ static void remote_version_complete(struct btdev *btdev, uint16_t handle)
 							&rvc, sizeof(rvc));
 }
 
+static void le_send_adv_report(struct btdev *btdev, const struct btdev *remote)
+{
+	struct __packed {
+		uint8_t subevent;
+		union {
+			struct bt_hci_evt_le_adv_report lar;
+			uint8_t raw[10 + 31 + 1];
+		};
+	} meta_event;
+
+	meta_event.subevent = BT_HCI_EVT_LE_ADV_REPORT;
+
+	memset(&meta_event.lar, 0, sizeof(meta_event.lar));
+	meta_event.lar.num_reports = 1;
+	memcpy(meta_event.lar.addr, remote->bdaddr, 6);
+	meta_event.lar.data_len = remote->le_adv_data_len;
+	memcpy(meta_event.lar.data, remote->le_adv_data,
+						meta_event.lar.data_len);
+	/* Not available */
+	meta_event.raw[10 + meta_event.lar.data_len] = 127;
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &meta_event,
+					1 + 10 + meta_event.lar.data_len + 1);
+}
+
+static void le_set_adv_enable_complete(struct btdev *btdev)
+{
+	int i;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!btdev_list[i]->le_scan_enable)
+			continue;
+
+		le_send_adv_report(btdev_list[i], btdev);
+	}
+}
+
+static void le_set_scan_enable_complete(struct btdev *btdev)
+{
+	int i;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!btdev_list[i]->le_adv_enable)
+			continue;
+
+		le_send_adv_report(btdev, btdev_list[i]);
+	}
+}
+
 static void default_cmd(struct btdev *btdev, uint16_t opcode,
 						const void *data, uint8_t len)
 {
@@ -1480,6 +1534,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			status = BT_HCI_ERR_SUCCESS;
 		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
+		if (status == BT_HCI_ERR_SUCCESS && btdev->le_adv_enable)
+			le_set_adv_enable_complete(btdev);
 		break;
 
 	case BT_HCI_CMD_LE_SET_SCAN_PARAMETERS:
@@ -1504,6 +1560,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			status = BT_HCI_ERR_SUCCESS;
 		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
+		if (status == BT_HCI_ERR_SUCCESS && btdev->le_scan_enable)
+			le_set_scan_enable_complete(btdev);
 		break;
 
 	case BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE:
-- 
1.8.3.2

