Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5 v2] Bluetooth: Add initial support for LE-only controllers
Date: Fri, 19 Oct 2012 20:57:45 +0300
Message-Id: <1350669469-7719-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
References: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch splits off most the HCI init sequence commands from a fixed
set into a conditional one that is sent once the HCI_Read_Local_Features
and HCI_Read_Local_Version_Information commands complete. This is
necessary since many of the current fixed commands are not allowed for
LE-only controllers.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  |   47 ------------------------------------
 net/bluetooth/hci_event.c |   58 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0ec776a..dd05ed0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -178,48 +178,13 @@ static void hci_reset_req(struct hci_dev *hdev, unsigned long opt)
 
 static void bredr_init(struct hci_dev *hdev)
 {
-	struct hci_cp_delete_stored_link_key cp;
-	__le16 param;
-	__u8 flt_type;
-
 	hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_PACKET_BASED;
 
-	/* Mandatory initialization */
-
 	/* Read Local Supported Features */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
 
 	/* Read Local Version */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
-
-	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
-	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
-
-	/* Read BD Address */
-	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
-
-	/* Read Class of Device */
-	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
-
-	/* Read Local Name */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
-
-	/* Read Voice Setting */
-	hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
-
-	/* Optional initialization */
-
-	/* Clear Event Filters */
-	flt_type = HCI_FLT_CLEAR_ALL;
-	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
-
-	/* Connection accept timeout ~20 secs */
-	param = __constant_cpu_to_le16(0x7d00);
-	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
-
-	bacpy(&cp.bdaddr, BDADDR_ANY);
-	cp.delete_all = 1;
-	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
 }
 
 static void amp_init(struct hci_dev *hdev)
@@ -273,14 +238,6 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	}
 }
 
-static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)
-{
-	BT_DBG("%s", hdev->name);
-
-	/* Read LE buffer size */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
-}
-
 static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
 {
 	__u8 scan = opt;
@@ -687,10 +644,6 @@ int hci_dev_open(__u16 dev)
 
 		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
 
-		if (lmp_host_le_capable(hdev))
-			ret = __hci_request(hdev, hci_le_init_req, 0,
-					    HCI_INIT_TIMEOUT);
-
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0383635..f4f0b8b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -507,11 +507,13 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return;
 
-	events[4] |= 0x01; /* Flow Specification Complete */
-	events[4] |= 0x02; /* Inquiry Result with RSSI */
-	events[4] |= 0x04; /* Read Remote Extended Features Complete */
-	events[5] |= 0x08; /* Synchronous Connection Complete */
-	events[5] |= 0x10; /* Synchronous Connection Changed */
+	if (lmp_bredr_capable(hdev)) {
+		events[4] |= 0x01; /* Flow Specification Complete */
+		events[4] |= 0x02; /* Inquiry Result with RSSI */
+		events[4] |= 0x04; /* Read Remote Extended Features Complete */
+		events[5] |= 0x08; /* Synchronous Connection Complete */
+		events[5] |= 0x10; /* Synchronous Connection Changed */
+	}
 
 	if (hdev->features[3] & LMP_RSSI_INQ)
 		events[4] |= 0x02; /* Inquiry Result with RSSI */
@@ -550,11 +552,57 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	hci_send_cmd(hdev, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
 }
 
+static void bredr_init(struct hci_dev *hdev)
+{
+	struct hci_cp_delete_stored_link_key cp;
+	__le16 param;
+	__u8 flt_type;
+
+	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
+	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
+
+	/* Read Class of Device */
+	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
+
+	/* Read Local Name */
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
+
+	/* Read Voice Setting */
+	hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
+
+	/* Clear Event Filters */
+	flt_type = HCI_FLT_CLEAR_ALL;
+	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
+
+	/* Connection accept timeout ~20 secs */
+	param = __constant_cpu_to_le16(0x7d00);
+	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
+
+	bacpy(&cp.bdaddr, BDADDR_ANY);
+	cp.delete_all = 1;
+	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
+}
+
+static void le_init(struct hci_dev *hdev)
+{
+	/* Read LE Buffer Size */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
+}
+
 static void hci_setup(struct hci_dev *hdev)
 {
 	if (hdev->dev_type != HCI_BREDR)
 		return;
 
+	/* Read BD Address */
+	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
+
+	if (lmp_bredr_capable(hdev))
+		bredr_init(hdev);
+
+	if (lmp_le_capable(hdev))
+		le_init(hdev);
+
 	hci_setup_event_mask(hdev);
 
 	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
-- 
1.7.10.4

