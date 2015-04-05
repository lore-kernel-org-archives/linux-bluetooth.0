Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Update version number driver
Date: Sat,  4 Apr 2015 22:36:04 -0700
Message-Id: <1428212164-19437-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This version number is more cosmetic and for debugging purposes, but
since there has been a few changes lately, increase it now.

Two left-over and not used version constants that were never exposed
anywhere are removed since they have no actual value.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_bcsp.c  | 2 --
 drivers/bluetooth/hci_h4.c    | 2 --
 drivers/bluetooth/hci_ldisc.c | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index a467aa28009a..dc8e3d4356a0 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -47,8 +47,6 @@
 
 #include "hci_uart.h"
 
-#define VERSION "0.3"
-
 static bool txcrc = 1;
 static bool hciextn = 1;
 
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 81ad249fc44f..07f5f7a21961 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -46,8 +46,6 @@
 
 #include "hci_uart.h"
 
-#define VERSION "1.2"
-
 struct h4_struct {
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 19d0960489b6..b265abcb9eb6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -46,7 +46,7 @@
 
 #include "hci_uart.h"
 
-#define VERSION "2.2"
+#define VERSION "2.3"
 
 static const struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
 
-- 
2.1.0

