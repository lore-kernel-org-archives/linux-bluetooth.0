Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: John Keeping <john@metanate.com>
Subject: [PATCH] tools/hciattach: Add support for BCM line discipline
Date: Tue, 24 Nov 2015 11:56:11 +0000
Message-Id: <1448366171-14264-1-git-send-email-john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is similar to the "bcm43xx" option but using the kernel driver has
the advantage that the wakeup and shutdown pins on the device can be
used.
---
 tools/hciattach.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index 59a76a7..7f8f463 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1163,6 +1163,10 @@ struct uart_t uart[] = {
 	{ "amp",	0x0000, 0x0000, HCI_UART_H4, 115200, 115200,
 			AMP_DEV, DISABLE_PM, NULL, NULL, NULL },
 
+	/* Broadcom BCM with kernel support */
+	{ "bcm",        0x0000, 0x0000, HCI_UART_BCM,  115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, NULL, NULL },
+
 	{ NULL, 0 }
 };
 
-- 
2.6.3.462.gbe2c914

