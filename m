Return-Path: <cyrus@holtmann.org>
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org, linux-kernel@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 2/8 v2]Bluetooth: Fix warning: variable 'tty' set but not used
Date: Mon, 14 Jun 2010 18:26:40 -0700
Message-Id: <1276565200-5583-1-git-send-email-justinmattock@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Resend of this patch to fix whitespace issues
The patch below fixes a warning message
when using gcc 4.6.0

  CC [M]  drivers/bluetooth/hci_ldisc.o
drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_send_frame':
drivers/bluetooth/hci_ldisc.c:213:21: warning: variable 'tty' set but not used


 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
 Reviewed-By: Gustavo F. Padovan <gustavo@padovan.org>

---
 drivers/bluetooth/hci_ldisc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 76a1abb..e8beffe 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -210,7 +210,6 @@ static int hci_uart_close(struct hci_dev *hdev)
 static int hci_uart_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev* hdev = (struct hci_dev *) skb->dev;
-	struct tty_struct *tty;
 	struct hci_uart *hu;
 
 	if (!hdev) {
@@ -222,7 +221,6 @@ static int hci_uart_send_frame(struct sk_buff *skb)
 		return -EBUSY;
 
 	hu = (struct hci_uart *) hdev->driver_data;
-	tty = hu->tty;
 
 	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
-- 
1.7.1.rc1.21.gf3bd6

