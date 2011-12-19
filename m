Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/5] Bluetooth: Split ctrl init to BREDR and AMP parts
Date: Mon, 19 Dec 2011 16:31:27 +0200
Message-Id: <1324305091-19393-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324305091-19393-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324305091-19393-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Current controller initialization is moved tp bredr_init and new
function added amp_init to handle later AMP init sequence. Current
AMP init sequence include Reset and Read Local Version.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  |   64 ++++++++++++++++++++++++++++++++------------
 net/bluetooth/hci_event.c |    3 ++
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6382db..bb089e3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -193,33 +193,18 @@ static void hci_reset_req(struct hci_dev *hdev, unsigned long opt)
 	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
 }
 
-static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
+static void bredr_init(struct hci_dev *hdev)
 {
 	struct hci_cp_delete_stored_link_key cp;
-	struct sk_buff *skb;
 	__le16 param;
 	__u8 flt_type;
 
-	BT_DBG("%s %ld", hdev->name, opt);
-
-	/* Driver initialization */
-
-	/* Special commands */
-	while ((skb = skb_dequeue(&hdev->driver_init))) {
-		bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
-		skb->dev = (void *) hdev;
-
-		skb_queue_tail(&hdev->cmd_q, skb);
-		queue_work(hdev->workqueue, &hdev->cmd_work);
-	}
-	skb_queue_purge(&hdev->driver_init);
-
 	/* Mandatory initialization */
 
 	/* Reset */
 	if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
-			set_bit(HCI_RESET, &hdev->flags);
-			hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
+		set_bit(HCI_RESET, &hdev->flags);
+		hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
 	}
 
 	/* Read Local Supported Features */
@@ -258,6 +243,49 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
 }
 
+static void amp_init(struct hci_dev *hdev)
+{
+	/* Reset */
+	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
+
+	/* Read Local Version */
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
+}
+
+static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
+{
+	struct sk_buff *skb;
+
+	BT_DBG("%s %ld", hdev->name, opt);
+
+	/* Driver initialization */
+
+	/* Special commands */
+	while ((skb = skb_dequeue(&hdev->driver_init))) {
+		bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+		skb->dev = (void *) hdev;
+
+		skb_queue_tail(&hdev->cmd_q, skb);
+		queue_work(hdev->workqueue, &hdev->cmd_work);
+	}
+	skb_queue_purge(&hdev->driver_init);
+
+	switch (hdev->dev_type) {
+	case HCI_BREDR:
+		bredr_init(hdev);
+		break;
+
+	case HCI_AMP:
+		amp_init(hdev);
+		break;
+
+	default:
+		BT_ERR("Unknown device type %d", hdev->dev_type);
+		break;
+	}
+
+}
+
 static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)
 {
 	BT_DBG("%s", hdev->name);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4275816..ceb7979 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -556,6 +556,9 @@ static void hci_set_le_support(struct hci_dev *hdev)
 
 static void hci_setup(struct hci_dev *hdev)
 {
+	if (hdev->dev_type != HCI_BREDR)
+		return;
+
 	hci_setup_event_mask(hdev);
 
 	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
-- 
1.7.4.1

