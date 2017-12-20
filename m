Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 1/8] Bluetooth: Define PHY flags in hdev and set 1M as default
Date: Wed, 20 Dec 2017 11:44:30 +0530
Message-Id: <1513750477-8438-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1M is mandatory to be supported by LE controllers and the same
would be set in power on. This patch defines hdev flags for
LE PHYs and set 1M to default.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h | 7 +++++++
 net/bluetooth/hci_core.c    | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1668211..ca5669a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -261,6 +261,13 @@ enum {
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 
+	HCI_LE_PHY_1M_TX,
+	HCI_LE_PHY_1M_RX,
+	HCI_LE_PHY_2M_TX,
+	HCI_LE_PHY_2M_RX,
+	HCI_LE_PHY_CODED_TX,
+	HCI_LE_PHY_CODED_RX,
+
 	__HCI_NUM_FLAGS,
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 40d260f..f42f5b3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -322,6 +322,10 @@ static void le_setup(struct hci_request *req)
 	/* LE-only controllers have LE implicitly enabled */
 	if (!lmp_bredr_capable(hdev))
 		hci_dev_set_flag(hdev, HCI_LE_ENABLED);
+
+	/* Set PHY to 1M for TX and RX */
+	hci_dev_set_flag(hdev, HCI_LE_PHY_1M_TX);
+	hci_dev_set_flag(hdev, HCI_LE_PHY_1M_RX);
 }
 
 static void hci_setup_event_mask(struct hci_request *req)
-- 
2.7.4

