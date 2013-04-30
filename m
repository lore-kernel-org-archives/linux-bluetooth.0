Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 11/13] Bluetooth: Remove inquiry helpers
Date: Tue, 30 Apr 2013 02:45:02 -0300
Message-Id: <1367300704-703-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes hci_do_inquiry and hci_cancel_inquiry helpers. We
now use the HCI request framework in device discovery functionality
and these helpers are no longer needed.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 --
 net/bluetooth/hci_core.c         | 30 ------------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7cc8857..632d7d08a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1211,8 +1211,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
-int hci_do_inquiry(struct hci_dev *hdev, u8 length);
-int hci_cancel_inquiry(struct hci_dev *hdev);
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dcfe639..ff032e3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3492,36 +3492,6 @@ static void hci_cmd_work(struct work_struct *work)
 	}
 }
 
-int hci_do_inquiry(struct hci_dev *hdev, u8 length)
-{
-	/* General inquiry access code (GIAC) */
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	struct hci_cp_inquiry cp;
-
-	BT_DBG("%s", hdev->name);
-
-	if (test_bit(HCI_INQUIRY, &hdev->flags))
-		return -EINPROGRESS;
-
-	hci_inquiry_cache_flush(hdev);
-
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, sizeof(cp.lap));
-	cp.length  = length;
-
-	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
-}
-
-int hci_cancel_inquiry(struct hci_dev *hdev)
-{
-	BT_DBG("%s", hdev->name);
-
-	if (!test_bit(HCI_INQUIRY, &hdev->flags))
-		return -EALREADY;
-
-	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-}
-
 u8 bdaddr_to_le(u8 bdaddr_type)
 {
 	switch (bdaddr_type) {
-- 
1.8.2.1

