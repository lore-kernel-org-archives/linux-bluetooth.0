Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Use proper invalid value for tx_power
Date: Tue,  6 Nov 2012 23:06:38 +0100
Message-Id: <1352239600-5840-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The core specification defines 127 as the "not available" value (well,
"reserved" for BR/EDR and "not available" for LE - but essentially the
same). Therefore, instead of testing for 0 (which is in fact a valid
value) we should be using this invalid value to test if the tx_power is
available.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    3 +++
 net/bluetooth/hci_core.c    |    2 ++
 net/bluetooth/hci_event.c   |    2 ++
 net/bluetooth/mgmt.c        |    2 +-
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6c414f4..344fea0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -319,6 +319,9 @@ enum {
 #define HCI_FLOW_CTL_MODE_PACKET_BASED	0x00
 #define HCI_FLOW_CTL_MODE_BLOCK_BASED	0x01
 
+/* The core spec defines 127 as the "not available" value */
+#define HCI_TX_POWER_INVALID	127
+
 /* Extended Inquiry Response field types */
 #define EIR_FLAGS		0x01 /* flags */
 #define EIR_UUID16_SOME		0x02 /* 16-bit UUID, more available */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c68c409..0af08f3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1606,6 +1606,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
 	hdev->io_capability = 0x03; /* No Input No Output */
+	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
+	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
 
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c08ac7c..09c6571 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -202,6 +202,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 			     BIT(HCI_PERIODIC_INQ));
 
 	hdev->discovery.state = DISCOVERY_STOPPED;
+	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
+	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 26a0984..ad1054f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -485,7 +485,7 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		ptr += (name_len + 2);
 	}
 
-	if (hdev->inq_tx_power) {
+	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID) {
 		ptr[0] = 2;
 		ptr[1] = EIR_TX_POWER;
 		ptr[2] = (u8) hdev->inq_tx_power;
-- 
1.7.10.4

