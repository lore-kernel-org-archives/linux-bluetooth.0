Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 07/35] emulator: Implement LE advertising report
Date: Wed, 12 Jun 2013 08:56:53 -0400
Message-Id: <1371041841-21793-8-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

This is a helper to report an advertising from a virtual device to other
device in scan mode.
---
 emulator/btdev.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 2725c76..171ca68 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -876,6 +876,30 @@ static void remote_version_complete(struct btdev *btdev, uint16_t handle)
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
 static void le_set_adv_enable_complete(struct btdev *btdev)
 {
 	int i;
@@ -886,6 +910,8 @@ static void le_set_adv_enable_complete(struct btdev *btdev)
 
 		if (!btdev_list[i]->le_scan_enable)
 			continue;
+
+		le_send_adv_report(btdev_list[i], btdev);
 	}
 }
 
@@ -899,6 +925,8 @@ static void le_set_scan_enable_complete(struct btdev *btdev)
 
 		if (!btdev_list[i]->le_adv_enable)
 			continue;
+
+		le_send_adv_report(btdev, btdev_list[i]);
 	}
 }
 
-- 
1.7.9.5

