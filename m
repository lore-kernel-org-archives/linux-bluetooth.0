Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: Fix possible NULL dereference
Date: Thu, 28 Mar 2013 01:54:59 +0900
Message-id: <1364403300-11220-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1364403300-11220-1-git-send-email-chanyeol.park@samsung.com>
References: <1364401575-9868-1-git-send-email-chanyeol.park@samsung.com>
 <1364403300-11220-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds NULL check for hci uart ldisc because some of hci uart driver
allow hci_uart_tty_receive function could be called though hci uar driver is
not registered properly.

Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 drivers/bluetooth/hci_ldisc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index ed0fade..d710d8b 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -388,7 +388,10 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *f
 
 	spin_lock(&hu->rx_lock);
 	hu->proto->recv(hu, (void *) data, count);
-	hu->hdev->stat.byte_rx += count;
+
+	if (hu->hdev)
+		hu->hdev->stat.byte_rx += count;
+
 	spin_unlock(&hu->rx_lock);
 
 	tty_unthrottle(tty);
-- 
1.7.10.4

