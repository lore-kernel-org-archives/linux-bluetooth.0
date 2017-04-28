Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V1 1/3] Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()
Date: Fri, 28 Apr 2017 13:57:24 +0100
Message-ID: <1493384246-15381-2-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1493384246-15381-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1493384246-15381-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Before attempting to send a HCI message, check that the Data Link
protocol is still bound to the HCI UART driver. This makes the code
consistent with the usage of the other proto function pointers.

Therefore, add a check for HCI_UART_PROTO_READY into hci_uart_send_frame()
and return -EUNATCH if the Data Link protocol is not bound.

This also allows hci_send_frame() to report the error of an unbound
Data Link protocol layer. Therefore, it assists with diagnostics into
why HCI messages are being sent when the Data Link protocol is not
bound and avoids potential crashes.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c53513c..c515aa9 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -256,6 +256,9 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s: type %d len %d", hdev->name, hci_skb_pkt_type(skb),
 	       skb->len);
 
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		return -EUNATCH;
+
 	hu->proto->enqueue(hu, skb);
 
 	hci_uart_tx_wakeup(hu);
-- 
2.7.4
