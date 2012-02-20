Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Always enable management interface
Date: Mon, 20 Feb 2012 21:24:37 +0100
Message-Id: <1329769477-11242-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The management interface API has reached stable version 1.0 and thus
it can now be always enabled. All future changes will be made backwards
compatible.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 8c429a1..dd56350 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -50,8 +50,6 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/hci_mon.h>
 
-static bool enable_mgmt;
-
 static atomic_t monitor_promisc = ATOMIC_INIT(0);
 
 /* ----- HCI socket interface ----- */
@@ -651,7 +649,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 		break;
 
 	case HCI_CHANNEL_CONTROL:
-		if (haddr.hci_dev != HCI_DEV_NONE || !enable_mgmt) {
+		if (haddr.hci_dev != HCI_DEV_NONE) {
 			err = -EINVAL;
 			goto done;
 		}
@@ -1129,6 +1127,3 @@ void hci_sock_cleanup(void)
 
 	proto_unregister(&hci_sk_proto);
 }
-
-module_param(enable_mgmt, bool, 0644);
-MODULE_PARM_DESC(enable_mgmt, "Enable Management interface");
-- 
1.7.7.6

