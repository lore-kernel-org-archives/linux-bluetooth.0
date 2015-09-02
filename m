Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v3 4/4] Bluetooth: hci_intel: Show error in case of invalid LPM packet size
Date: Wed,  2 Sep 2015 12:04:14 +0200
Message-Id: <1441188254-15507-4-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1441188254-15507-1-git-send-email-loic.poulain@intel.com>
References: <1441188254-15507-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Don't hide this packet size error.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: no patch 4/4
 v3: Add this patch

 drivers/bluetooth/hci_intel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 9fd1143..b4dc3c5 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1010,8 +1010,11 @@ static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
 
 	switch (lpm->opcode) {
 	case LPM_OP_TX_NOTIFY:
-		if (lpm->dlen)
-			intel_recv_lpm_notify(hdev, lpm->data[0]);
+		if (lpm->dlen < 1) {
+			bt_dev_err(hu->hdev, "Invalid LPM notification packet");
+			break;
+		}
+		intel_recv_lpm_notify(hdev, lpm->data[0]);
 		break;
 	case LPM_OP_SUSPEND_ACK:
 		set_bit(STATE_SUSPENDED, &intel->flags);
-- 
1.9.1
