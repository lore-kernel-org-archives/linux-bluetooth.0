Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v2 05/11] Bluetooth: Clear advertising cache before scanning
Date: Fri, 20 May 2011 21:10:39 -0300
Message-Id: <1305936645-15007-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
References: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE advertising cache should be cleared before performing a LE
scanning. This will force the cache to contain only fresh advertising
entries.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ccf4d4d..85e12d8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -842,9 +842,27 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
+	void *sent;
+	__u8 param_scan_enable;
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	if (status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
+	if (!sent)
+		return;
+
+	param_scan_enable = *((__u8 *) sent);
+
+	hci_dev_lock(hdev);
+
+	if (param_scan_enable == 0x01)
+		hci_adv_entries_clear(hdev);
+
+	hci_dev_unlock(hdev);
 }
 
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
-- 
1.7.4.1

