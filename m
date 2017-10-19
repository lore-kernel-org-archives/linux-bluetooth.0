Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] Bluetooth: hci_ath: Add ath_vendor_cmd helper
Date: Thu, 19 Oct 2017 14:29:10 +0200
Message-Id: <1508416150-26259-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce ath_vendor_cmd function which can be used to
configure 'tags' and patch the firmware.

ATH vendor command has the following format:
| OPCODE (u8) | INDEX (LE16) | DLEN (U8) | DATA (U8 * DLEN) |

BD address configuration tag is at index 0x0001.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/bluetooth/hci_ath.c | 49 +++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 0ccf6bf..5f17ec3 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -50,6 +50,17 @@ struct ath_struct {
 	struct work_struct ctxtsw;
 };
 
+#define OP_WRITE_TAG	0x01
+
+#define INDEX_BDADDR	0x01
+
+struct ath_vendor_cmd {
+	__u8 opcode;
+	__le16 index;
+	__u8 len;
+	__u8 data[251];
+} __packed;
+
 static int ath_wakeup_ar3k(struct tty_struct *tty)
 {
 	int status = tty->driver->ops->tiocmget(tty);
@@ -144,30 +155,34 @@ static int ath_flush(struct hci_uart *hu)
 	return 0;
 }
 
-static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+static int ath_vendor_cmd(struct hci_dev *hdev, uint8_t opcode, uint16_t index,
+			  const void *data, size_t dlen)
 {
 	struct sk_buff *skb;
-	u8 buf[10];
-	int err;
-
-	buf[0] = 0x01;
-	buf[1] = 0x01;
-	buf[2] = 0x00;
-	buf[3] = sizeof(bdaddr_t);
-	memcpy(buf + 4, bdaddr, sizeof(bdaddr_t));
-
-	skb = __hci_cmd_sync(hdev, 0xfc0b, sizeof(buf), buf, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		BT_ERR("%s: Change address command failed (%d)",
-		       hdev->name, err);
-		return err;
-	}
+	struct ath_vendor_cmd cmd;
+
+	if (dlen > sizeof(cmd.data))
+		return -EINVAL;
+
+	cmd.opcode = opcode;
+	cmd.index = cpu_to_le16(index);
+	cmd.len = dlen;
+	memcpy(cmd.data, data, dlen);
+
+	skb = __hci_cmd_sync(hdev, 0xfc0b, dlen + 4, &cmd, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 	kfree_skb(skb);
 
 	return 0;
 }
 
+static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	return ath_vendor_cmd(hdev, OP_WRITE_TAG, INDEX_BDADDR, bdaddr,
+			      sizeof(*bdaddr));
+}
+
 static int ath_setup(struct hci_uart *hu)
 {
 	BT_DBG("hu %p", hu);
-- 
2.7.4
