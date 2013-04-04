Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 14/17] Bluetooth: Remove inquiry helpers
Date: Thu,  4 Apr 2013 20:21:12 -0300
Message-Id: <1365117675-2202-15-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
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
index 9760d91..6aa6a30 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1174,8 +1174,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
-int hci_do_inquiry(struct hci_dev *hdev, u8 length);
-int hci_cancel_inquiry(struct hci_dev *hdev);
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7f954e2..a38bf9e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3361,36 +3361,6 @@ static void hci_cmd_work(struct work_struct *work)
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
-	inquiry_cache_flush(hdev);
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
1.8.1.2

