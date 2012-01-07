Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: hci-uart-ath: Use GFP_ATOMIC in open()
Date: Sat,  7 Jan 2012 15:19:40 +0100
Message-Id: <1325945981-11330-4-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The uart_proto open() callback is not called in atomic context so we can safely
sleep here. The caller hci_uart_set_proto() in hci_ldisc.c is an ioctl-handler
and therefore can sleep.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/hci_ath.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 4093935..12172a6 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -112,7 +112,7 @@ static int ath_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
-	ath = kzalloc(sizeof(*ath), GFP_ATOMIC);
+	ath = kzalloc(sizeof(*ath), GFP_KERNEL);
 	if (!ath)
 		return -ENOMEM;
 
-- 
1.7.8.1
