Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: hci-uart-h4: Use GFP_ATOMIC in open()
Date: Sat,  7 Jan 2012 15:19:38 +0100
Message-Id: <1325945981-11330-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The uart_proto open() callback is not called in atomic context so we can safely
sleep here. The caller hci_uart_set_proto() in hci_ldisc.c is an ioctl-handler
and therefore can sleep.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/hci_h4.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 2fcd8b3..7483294 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -69,7 +69,7 @@ static int h4_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
-	h4 = kzalloc(sizeof(*h4), GFP_ATOMIC);
+	h4 = kzalloc(sizeof(*h4), GFP_KERNEL);
 	if (!h4)
 		return -ENOMEM;
 
-- 
1.7.8.1
