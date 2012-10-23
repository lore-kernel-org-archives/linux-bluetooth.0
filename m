Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Remove unnecessary include export.h
Date: Tue, 23 Oct 2012 19:02:17 +0530
Message-id: <1350999140-7481-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For files only using THIS_MODULE and/or EXPORT_SYMBOL, map
them onto including export.h -- or if the file isn't even
using those, then just delete the include.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/bnep/netdev.c |    1 -
 net/bluetooth/hci_event.c   |    1 -
 2 files changed, 2 deletions(-)

diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
index 98f86f9..e58c8b3 100644
--- a/net/bluetooth/bnep/netdev.c
+++ b/net/bluetooth/bnep/netdev.c
@@ -25,7 +25,6 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-#include <linux/export.h>
 #include <linux/etherdevice.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 82e478a..110006a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -24,7 +24,6 @@
 
 /* Bluetooth HCI event handling. */
 
-#include <linux/export.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
-- 
1.7.9.5

