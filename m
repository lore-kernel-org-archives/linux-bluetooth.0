Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v3 06/18] Bluetooth: Define PHY flags in hdev and set 1M as default
Date: Fri,  6 Jul 2018 17:05:32 +0530
Message-Id: <1530876944-17453-7-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
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
index 73e48be..1b5d79b 100644
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
index e19f7f3..be87d2a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -313,6 +313,10 @@ static void le_setup(struct hci_request *req)
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
