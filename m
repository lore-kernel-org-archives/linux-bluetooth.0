Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCHv3] Bluetooth: hci_uart: Add Intel baudrate configuration support
Date: Fri, 14 Aug 2015 19:02:26 +0200
Message-Id: <1439571746-3678-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Implement the set_baudrate callback for hci_intel.
 - Controller requires a read Intel version command before updating
   its baudrate.
 - Inject the change speed command complete since controller does not
   respond at the same speed.
 - Wait 100ms to let the controller change its baudrate.

Manage speed change in the setup function, we need to restore the oper
speed once chip has booted on patched firmware.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: simplify baudrate change, update commit message,
     set missing set_baudrate callback.
 v3: Remove unused 'err' variable in intel_set_baudrate

 drivers/bluetooth/hci_intel.c | 134 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 21dfa89..275283c 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -38,6 +38,7 @@
 #define STATE_FIRMWARE_LOADED	2
 #define STATE_FIRMWARE_FAILED	3
 #define STATE_BOOTING		4
+#define STATE_SPEED_CHANGING	5
 
 struct intel_data {
 	struct sk_buff *rx_skb;
@@ -45,6 +46,38 @@ struct intel_data {
 	unsigned long flags;
 };
 
+static u8 intel_convert_speed(unsigned int speed)
+{
+	switch (speed) {
+	case 9600:
+		return 0x00;
+	case 19200:
+		return 0x01;
+	case 38400:
+		return 0x02;
+	case 57600:
+		return 0x03;
+	case 115200:
+		return 0x04;
+	case 230400:
+		return 0x05;
+	case 460800:
+		return 0x06;
+	case 921600:
+		return 0x07;
+	case 1843200:
+		return 0x08;
+	case 3250000:
+		return 0x09;
+	case 2000000:
+		return 0x0a;
+	case 3000000:
+		return 0x0b;
+	default:
+		return 0xff;
+	}
+}
+
 static int intel_open(struct hci_uart *hu)
 {
 	struct intel_data *intel;
@@ -111,6 +144,53 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 	return hci_recv_frame(hdev, skb);
 }
 
+static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
+{
+	struct intel_data *intel = hu->priv;
+	struct hci_dev *hdev = hu->hdev;
+	u8 intel_speed;
+	struct sk_buff *skb;
+
+	BT_INFO("%s: Change controller speed to %d", hdev->name, speed);
+
+	/* Device will not accept speed change if Intel version has not been
+	 * previously requested.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reading Intel version information failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+
+	intel_speed = intel_convert_speed(speed);
+	if (intel_speed == 0xff) {
+		BT_ERR("%s: Unsupported speed", hdev->name);
+		return -EINVAL;
+	}
+
+	set_bit(STATE_SPEED_CHANGING, &intel->flags);
+
+	skb = __hci_cmd_sync(hdev, 0xfc06, 1, &intel_speed, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Changing Intel speed failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		clear_bit(STATE_SPEED_CHANGING, &intel->flags);
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+
+	/* wait 100ms to change baudrate on controller side */
+	msleep(100);
+
+	clear_bit(STATE_SPEED_CHANGING, &intel->flags);
+
+	return 0;
+}
+
 static int intel_setup(struct hci_uart *hu)
 {
 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
@@ -126,6 +206,8 @@ static int intel_setup(struct hci_uart *hu)
 	u32 frag_len;
 	ktime_t calltime, delta, rettime;
 	unsigned long long duration;
+	unsigned int init_speed, oper_speed;
+	int speed_change = 0;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -134,6 +216,19 @@ static int intel_setup(struct hci_uart *hu)
 
 	calltime = ktime_get();
 
+	if (hu->init_speed)
+		init_speed = hu->init_speed;
+	else
+		init_speed = hu->proto->init_speed;
+
+	if (hu->oper_speed)
+		oper_speed = hu->oper_speed;
+	else
+		oper_speed = hu->proto->oper_speed;
+
+	if (oper_speed && init_speed && oper_speed != init_speed)
+		speed_change = 1;
+
 	set_bit(STATE_BOOTLOADER, &intel->flags);
 
 	/* Read the Intel version information to determine if the device
@@ -420,6 +515,14 @@ done:
 
 	set_bit(STATE_BOOTING, &intel->flags);
 
+	/* We need to restore the default speed before Intel reset */
+	if (speed_change) {
+		err = intel_set_baudrate(hu, init_speed);
+		if (err)
+			return err;
+		hci_uart_set_baudrate(hu, init_speed);
+	}
+
 	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb))
@@ -456,6 +559,19 @@ done:
 
 	BT_INFO("%s: Device booted in %llu usecs", hdev->name, duration);
 
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+
+	if (speed_change) {
+		err = intel_set_baudrate(hu, oper_speed);
+		if (err)
+			return err;
+		hci_uart_set_baudrate(hu, oper_speed);
+	}
+
 	clear_bit(STATE_BOOTLOADER, &intel->flags);
 
 	return 0;
@@ -515,6 +631,10 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
+	/* Ignore unexpected non-sync data during speed change */
+	if (test_bit(STATE_SPEED_CHANGING, &intel->flags))
+		return count;
+
 	intel->rx_skb = h4_recv_buf(hu->hdev, intel->rx_skb, data, count,
 				    intel_recv_pkts,
 				    ARRAY_SIZE(intel_recv_pkts));
@@ -548,7 +668,9 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
 	if (!skb)
 		return skb;
 
-	if (test_bit(STATE_BOOTLOADER, &intel->flags) &&
+	/* Inject cmd complete pkt for async commands */
+	if ((test_bit(STATE_BOOTLOADER, &intel->flags) ||
+	    test_bit(STATE_SPEED_CHANGING, &intel->flags)) &&
 	    (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT)) {
 		struct hci_command_hdr *cmd = (void *)skb->data;
 		__u16 opcode = le16_to_cpu(cmd->opcode);
@@ -560,6 +682,14 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
 		 */
 		if (opcode == 0xfc01)
 			inject_cmd_complete(hu->hdev, opcode);
+
+		/* When the 0xfc06 command is issued to change the
+		 * speed, device will send the command complete event
+		 * only at the targeted speed. Host needs to change its
+		 * own baudrate before being able to receive the response.
+		 */
+		if (opcode == 0xfc06)
+			inject_cmd_complete(hu->hdev, opcode);
 	}
 
 	/* Prepend skb with frame type */
@@ -572,10 +702,12 @@ static const struct hci_uart_proto intel_proto = {
 	.id		= HCI_UART_INTEL,
 	.name		= "Intel",
 	.init_speed	= 115200,
+	.oper_speed	= 3000000,
 	.open		= intel_open,
 	.close		= intel_close,
 	.flush		= intel_flush,
 	.setup		= intel_setup,
+	.set_baudrate	= intel_set_baudrate,
 	.recv		= intel_recv,
 	.enqueue	= intel_enqueue,
 	.dequeue	= intel_dequeue,
-- 
1.9.1
