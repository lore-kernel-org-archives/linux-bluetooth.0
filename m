Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: hci_uart: Add support for vendor detection flag
Date: Sat,  4 Apr 2015 16:13:01 -0700
Message-Id: <1428189183-12932-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a new HCI_UART_VND_DETECT flag to allow automatic vendor
detection. This allows to enable known vendor commands (for example
for setting the public device address) when using a standard H:4
UART protocol or when running in virtual machines.

When this new flag is configured and no vendor specific setup
routine is provided, then the local version information are read
and the provided manufacturer information can be evaluated to
configure extra vendor callbacks.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 29 ++++++++++++++++++++++++++++-
 drivers/bluetooth/hci_uart.h  |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 1363dc616ace..b1e8083044ce 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -264,10 +264,36 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 static int hci_uart_setup(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct hci_rp_read_local_version *ver;
+	struct sk_buff *skb;
 
 	if (hu->proto->setup)
 		return hu->proto->setup(hu);
 
+	if (!test_bit(HCI_UART_VND_DETECT, &hu->hdev_flags))
+		return 0;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reading local version information failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return 0;
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s: Event length mismatch for version information",
+		       hdev->name);
+		goto done;
+	}
+
+	ver = (struct hci_rp_read_local_version *)skb->data;
+
+	switch (le16_to_cpu(ver->manufacturer)) {
+	}
+
+done:
+	kfree_skb(skb);
 	return 0;
 }
 
@@ -497,7 +523,8 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 				    BIT(HCI_UART_RESET_ON_INIT) |
 				    BIT(HCI_UART_CREATE_AMP) |
 				    BIT(HCI_UART_INIT_PENDING) |
-				    BIT(HCI_UART_EXT_CONFIG);
+				    BIT(HCI_UART_EXT_CONFIG) |
+				    BIT(HCI_UART_VND_DETECT);
 
 	if (flags & ~valid_flags)
 		return -EINVAL;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 074ed29092b4..22a5f7c74266 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -49,6 +49,7 @@
 #define HCI_UART_CREATE_AMP	2
 #define HCI_UART_INIT_PENDING	3
 #define HCI_UART_EXT_CONFIG	4
+#define HCI_UART_VND_DETECT	5
 
 struct hci_uart;
 
-- 
2.1.0

