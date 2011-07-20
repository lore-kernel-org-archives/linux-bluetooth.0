Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] Bluetooth: Increase command tx timeout
Date: Wed, 20 Jul 2011 21:12:11 +0200
Message-Id: <1311189131-8592-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some CSR chips require more time for HCI reset command to complete.
Too short timeout caused next command being sent before reset
complete event resulting in
[23101.792031] hci_cmd_timer: hci0 command tx timeout
[23102.792046] hci_cmd_timer: hci0 command tx timeout
after pluging in dongle and non functional bt.

Signed-off-by: Szymon Janc <szymon@janc.net.pl>
---
 include/net/bluetooth/hci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index be30aab..12a527c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -121,7 +121,7 @@ enum {
 #define HCI_PAIRING_TIMEOUT	(60000)	/* 60 seconds */
 #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
 #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
-#define HCI_CMD_TIMEOUT		(1000)	/* 1 seconds */
+#define HCI_CMD_TIMEOUT		(3000)	/* 3 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
-- 
1.7.5.4


