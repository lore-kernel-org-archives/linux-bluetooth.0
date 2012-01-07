Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: hci-uart-bcsp: Use GFP_ATOMIC in open()
Date: Sat,  7 Jan 2012 15:19:39 +0100
Message-Id: <1325945981-11330-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The uart_proto open() callback is not called in atomic context so we can safely
sleep here. The caller hci_uart_set_proto() in hci_ldisc.c is an ioctl-handler
and therefore can sleep.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/hci_bcsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 9c5b2dc..8bf0c3e 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -692,7 +692,7 @@ static int bcsp_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
-	bcsp = kzalloc(sizeof(*bcsp), GFP_ATOMIC);
+	bcsp = kzalloc(sizeof(*bcsp), GFP_KERNEL);
 	if (!bcsp)
 		return -ENOMEM;
 
-- 
1.7.8.1
