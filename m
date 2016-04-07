Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Ignore unknown advertising packet types
Date: Thu,  7 Apr 2016 21:01:27 +0300
Message-Id: <1460052087-29894-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In case of buggy controllers send advertising packet types that we
don't know of we should simply ignore them instead of trying to react
to them in some (potentially wrong) way.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c162af5d16bf..d4b3dd5413be 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4727,6 +4727,19 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	u32 flags;
 	u8 *ptr, real_len;
 
+	switch (type) {
+	case LE_ADV_IND:
+	case LE_ADV_DIRECT_IND:
+	case LE_ADV_SCAN_IND:
+	case LE_ADV_NONCONN_IND:
+	case LE_ADV_SCAN_RSP:
+		break;
+	default:
+		BT_ERR_RATELIMITED("Unknown advetising packet type: 0x%02x",
+				   type);
+		return;
+	}
+
 	/* Find the end of the data in case the report contains padded zero
 	 * bytes at the end causing an invalid length value.
 	 *
-- 
2.5.5

