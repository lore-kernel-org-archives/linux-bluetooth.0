Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add missing 6lowpan.h include
Date: Thu, 12 Dec 2013 09:53:20 +0200
Message-Id: <1386834801-1635-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The 6lowpan.c file was missing an #include statement for 6lowpan.h.
Without it we get the following type of warnings:

net/bluetooth/6lowpan.c:320:5: warning: symbol 'bt_6lowpan_recv' was not declared. Should it be static?
net/bluetooth/6lowpan.c:737:5: warning: symbol 'bt_6lowpan_add_conn' was not declared. Should it be static?
net/bluetooth/6lowpan.c:805:5: warning: symbol 'bt_6lowpan_del_conn' was not declared. Should it be static?
net/bluetooth/6lowpan.c:878:5: warning: symbol 'bt_6lowpan_init' was not declared. Should it be static?
net/bluetooth/6lowpan.c:883:6: warning: symbol 'bt_6lowpan_cleanup' was not declared. Should it be static?

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index ba840fe2c555..3cbb1d14c304 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -26,6 +26,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
+#include "6lowpan.h"
+
 #include "../ieee802154/6lowpan.h" /* for the compression support */
 
 #define IFACE_NAME_TEMPLATE "bt%d"
-- 
1.8.4.2

