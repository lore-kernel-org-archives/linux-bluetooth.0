Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v3 1/4] Bluetooth: hci_intel: Implement LPM suspend/resume
Date: Wed,  2 Sep 2015 12:04:11 +0200
Message-Id: <1441188254-15507-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add LPM PM suspend/resume/host_wake LPM functions.
A LPM transaction is composed with a LPM request and ack/response.
Host can send a LPM suspend/resume request to the controller which
should respond with a LPM ack.
If resume is requested by the controller (irq), host has to send a LPM
ack once resumed.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: Bracket coding style fixes.
     Reorder lpm functions to avoid forward declaration.
 v3: Add comment about lpm_transaction failure ignoring

 drivers/bluetooth/hci_intel.c | 158 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 5d53185..2e15ca5 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -46,12 +46,17 @@
 #define STATE_BOOTING		4
 #define STATE_LPM_ENABLED	5
 #define STATE_TX_ACTIVE		6
+#define STATE_SUSPENDED		7
+#define STATE_LPM_TRANSACTION	8
 
+#define HCI_LPM_WAKE_PKT 0xf0
 #define HCI_LPM_PKT 0xf1
 #define HCI_LPM_MAX_SIZE 10
 #define HCI_LPM_HDR_SIZE HCI_EVENT_HDR_SIZE
 
 #define LPM_OP_TX_NOTIFY 0x00
+#define LPM_OP_SUSPEND_ACK 0x02
+#define LPM_OP_RESUME_ACK 0x03
 
 struct hci_lpm_pkt {
 	__u8 opcode;
@@ -129,6 +134,143 @@ static int intel_wait_booting(struct hci_uart *hu)
 	return err;
 }
 
+static int intel_wait_lpm_transaction(struct hci_uart *hu)
+{
+	struct intel_data *intel = hu->priv;
+	int err;
+
+	err = wait_on_bit_timeout(&intel->flags, STATE_LPM_TRANSACTION,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(1000));
+
+	if (err == 1) {
+		bt_dev_err(hu->hdev, "LPM transaction interrupted");
+		return -EINTR;
+	}
+
+	if (err) {
+		bt_dev_err(hu->hdev, "LPM transaction timeout");
+		return -ETIMEDOUT;
+	}
+
+	return err;
+}
+
+static int intel_lpm_suspend(struct hci_uart *hu)
+{
+	static const u8 suspend[] = { 0x01, 0x01, 0x01 };
+	struct intel_data *intel = hu->priv;
+	struct sk_buff *skb;
+
+	if (!test_bit(STATE_LPM_ENABLED, &intel->flags) ||
+	    test_bit(STATE_SUSPENDED, &intel->flags))
+		return 0;
+
+	if (test_bit(STATE_TX_ACTIVE, &intel->flags))
+		return -EAGAIN;
+
+	bt_dev_dbg(hu->hdev, "Suspending");
+
+	skb = bt_skb_alloc(sizeof(suspend), GFP_KERNEL);
+	if (!skb) {
+		bt_dev_err(hu->hdev, "Failed to alloc memory for LPM packet");
+		return -ENOMEM;
+	}
+
+	memcpy(skb_put(skb, sizeof(suspend)), suspend, sizeof(suspend));
+	bt_cb(skb)->pkt_type = HCI_LPM_PKT;
+
+	set_bit(STATE_LPM_TRANSACTION, &intel->flags);
+
+	skb_queue_tail(&intel->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	intel_wait_lpm_transaction(hu);
+	/* Even in case of failure, continue and test the suspended flag */
+
+	clear_bit(STATE_LPM_TRANSACTION, &intel->flags);
+
+	if (!test_bit(STATE_SUSPENDED, &intel->flags)) {
+		bt_dev_err(hu->hdev, "Device suspend error");
+		return -EINVAL;
+	}
+
+	bt_dev_dbg(hu->hdev, "Suspended");
+
+	hci_uart_set_flow_control(hu, true);
+
+	return 0;
+}
+
+static int intel_lpm_resume(struct hci_uart *hu)
+{
+	struct intel_data *intel = hu->priv;
+	struct sk_buff *skb;
+
+	if (!test_bit(STATE_LPM_ENABLED, &intel->flags) ||
+	    !test_bit(STATE_SUSPENDED, &intel->flags))
+		return 0;
+
+	bt_dev_dbg(hu->hdev, "Resuming");
+
+	hci_uart_set_flow_control(hu, false);
+
+	skb = bt_skb_alloc(0, GFP_KERNEL);
+	if (!skb) {
+		bt_dev_err(hu->hdev, "Failed to alloc memory for LPM packet");
+		return -ENOMEM;
+	}
+
+	bt_cb(skb)->pkt_type = HCI_LPM_WAKE_PKT;
+
+	set_bit(STATE_LPM_TRANSACTION, &intel->flags);
+
+	skb_queue_tail(&intel->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	intel_wait_lpm_transaction(hu);
+	/* Even in case of failure, continue and test the suspended flag */
+
+	clear_bit(STATE_LPM_TRANSACTION, &intel->flags);
+
+	if (test_bit(STATE_SUSPENDED, &intel->flags)) {
+		bt_dev_err(hu->hdev, "Device resume error");
+		return -EINVAL;
+	}
+
+	bt_dev_dbg(hu->hdev, "Resumed");
+
+	return 0;
+}
+
+static int intel_lpm_host_wake(struct hci_uart *hu)
+{
+	static const u8 lpm_resume_ack[] = { LPM_OP_RESUME_ACK, 0x00 };
+	struct intel_data *intel = hu->priv;
+	struct sk_buff *skb;
+
+	hci_uart_set_flow_control(hu, false);
+
+	clear_bit(STATE_SUSPENDED, &intel->flags);
+
+	skb = bt_skb_alloc(sizeof(lpm_resume_ack), GFP_KERNEL);
+	if (!skb) {
+		bt_dev_err(hu->hdev, "Failed to alloc memory for LPM packet");
+		return -ENOMEM;
+	}
+
+	memcpy(skb_put(skb, sizeof(lpm_resume_ack)), lpm_resume_ack,
+	       sizeof(lpm_resume_ack));
+	bt_cb(skb)->pkt_type = HCI_LPM_PKT;
+
+	skb_queue_tail(&intel->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	bt_dev_dbg(hu->hdev, "Resumed by controller");
+
+	return 0;
+}
+
 static irqreturn_t intel_irq(int irq, void *dev_id)
 {
 	struct intel_device *idev = dev_id;
@@ -800,12 +942,28 @@ static void intel_recv_lpm_notify(struct hci_dev *hdev, int value)
 static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_lpm_pkt *lpm = (void *)skb->data;
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct intel_data *intel = hu->priv;
 
 	switch (lpm->opcode) {
 	case LPM_OP_TX_NOTIFY:
 		if (lpm->dlen)
 			intel_recv_lpm_notify(hdev, lpm->data[0]);
 		break;
+	case LPM_OP_SUSPEND_ACK:
+		set_bit(STATE_SUSPENDED, &intel->flags);
+		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
+			smp_mb__after_atomic();
+			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
+		}
+		break;
+	case LPM_OP_RESUME_ACK:
+		clear_bit(STATE_SUSPENDED, &intel->flags);
+		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
+			smp_mb__after_atomic();
+			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
+		}
+		break;
 	default:
 		bt_dev_err(hdev, "Unknown LPM opcode (%02x)", lpm->opcode);
 		break;
-- 
1.9.1
