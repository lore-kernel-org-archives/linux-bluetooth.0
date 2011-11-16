Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/3] Bluetooth: Add AMP initialization
Date: Wed, 16 Nov 2011 17:30:22 +0200
Message-Id: <1321457422-31641-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define init sequence for AMP controller. Code based on Code Aurora
sequence.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c  |   58 ++++++++++++++++++++++++++++----------------
 net/bluetooth/hci_event.c |    2 +-
 2 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d1eef7c..290acb2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -219,40 +219,56 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 			hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
 	}
 
-	/* Read Local Supported Features */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
-
 	/* Read Local Version */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
 
 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
 	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
 
-	/* Read BD Address */
-	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
+	switch (hdev->dev_type) {
+	case HCI_BREDR:
+		/* BR-EDR specific initialization */
+		/* Read Local Supported Features */
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
+
+		/* Read BD Address */
+		hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
 
-	/* Read Class of Device */
-	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
+		/* Read Class of Device */
+		hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
 
-	/* Read Local Name */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
+		/* Read Local Name */
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
 
-	/* Read Voice Setting */
-	hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
+		/* Read Voice Setting */
+		hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
 
-	/* Optional initialization */
+		/* Optional initialization */
+		/* Clear Event Filters */
+		flt_type = HCI_FLT_CLEAR_ALL;
+		hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
 
-	/* Clear Event Filters */
-	flt_type = HCI_FLT_CLEAR_ALL;
-	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
+		/* Connection accept timeout ~20 secs */
+		param = cpu_to_le16(0x7d00);
+		hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
 
-	/* Connection accept timeout ~20 secs */
-	param = cpu_to_le16(0x7d00);
-	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
+		bacpy(&cp.bdaddr, BDADDR_ANY);
+		cp.delete_all = 1;
+		hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY,
+							sizeof(cp), &cp);
+		break;
+
+	case HCI_AMP:
+		/* AMP initialization */
+		/* Read AMP Info */
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+		break;
+
+	default:
+		BT_ERR("Unknown device type %d", hdev->dev_type);
+		break;
+	}
 
-	bacpy(&cp.bdaddr, BDADDR_ANY);
-	cp.delete_all = 1;
-	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
 }
 
 static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a89cf1f..ad31eb4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -603,7 +603,7 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 					hdev->manufacturer,
 					hdev->hci_ver, hdev->hci_rev);
 
-	if (test_bit(HCI_INIT, &hdev->flags))
+	if (hdev->dev_type == HCI_BREDR && test_bit(HCI_INIT, &hdev->flags))
 		hci_setup(hdev);
 }
 
-- 
1.7.4.1

