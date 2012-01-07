Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 13/18] Bluetooth: uart-ldisc: Fix memory leak and remove destruct cb
Date: Sat,  7 Jan 2012 15:47:19 +0100
Message-Id: <1325947644-11736-14-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We currently leak the hci_uart object if HCI_UART_PROTO_SET is never set because
the hci-destruct callback will then never be called.
This fix removes the hci-destruct callback and frees the driver internal private
hci_uart object directly on tty-close. We call hci_unregister_dev() here so the
hci-core will never call our callbacks again (except destruct). Therefore, we
can safely free the driver internal data right away and set the destruct
callback to NULL.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/hci_ldisc.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 48ad2a7..5ea49df 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -231,15 +231,6 @@ static int hci_uart_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void hci_uart_destruct(struct hci_dev *hdev)
-{
-	if (!hdev)
-		return;
-
-	BT_DBG("%s", hdev->name);
-	kfree(hdev->driver_data);
-}
-
 /* ------ LDISC part ------ */
 /* hci_uart_tty_open
  * 
@@ -316,6 +307,8 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 				hci_free_dev(hdev);
 			}
 		}
+
+		kfree(hu);
 	}
 }
 
@@ -397,7 +390,6 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hdev->close = hci_uart_close;
 	hdev->flush = hci_uart_flush;
 	hdev->send  = hci_uart_send_frame;
-	hdev->destruct = hci_uart_destruct;
 	hdev->parent = hu->tty->dev;
 
 	hdev->owner = THIS_MODULE;
-- 
1.7.8.1
