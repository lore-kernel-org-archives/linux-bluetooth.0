Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 2/4] emulator/bthost: Add hci disconnect
Date: Fri, 22 Aug 2014 14:40:47 +0200
Message-Id: <1408711249-6683-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

---
 emulator/bthost.c | 11 +++++++++++
 emulator/bthost.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index b30999b..1394fca 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2069,6 +2069,17 @@ void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 	}
 }
 
+void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
+								uint8_t reason)
+{
+	struct bt_hci_cmd_disconnect disc;
+
+	disc.handle = cpu_to_le16(handle);
+	disc.reason = reason;
+
+	send_command(bthost, BT_HCI_CMD_DISCONNECT, &disc, sizeof(disc));
+}
+
 void bthost_write_scan_enable(struct bthost *bthost, uint8_t scan)
 {
 	send_command(bthost, BT_HCI_CMD_WRITE_SCAN_ENABLE, &scan, 1);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 4a7e2bd..d7d3d8a 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -52,6 +52,9 @@ void bthost_set_connect_cb(struct bthost *bthost, bthost_new_conn_cb cb,
 void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 							uint8_t addr_type);
 
+void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
+								uint8_t reason);
+
 typedef void (*bthost_cid_hook_func_t)(const void *data, uint16_t len,
 							void *user_data);
 
-- 
1.9.1

