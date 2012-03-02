Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove HCI_PI_MGMT_INIT flag for sockets
Date: Fri,  2 Mar 2012 14:33:09 -0800
Message-Id: <1330727590-27120-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This flag is of no use right now and is in fact harmful in that it
prevents the HCI_MGMT flag to be set for any controllers that may need
it after the first one that bluetoothd takes into use (the flag is
cleared for the first controller so any subsequent ones through the same
bluetoothd mgmt socket never get the HCI_MGMT flag set).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    4 ----
 net/bluetooth/hci_sock.c         |    1 -
 net/bluetooth/mgmt.c             |   18 ++++++++----------
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index facd7ed..25cb0a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1034,16 +1034,12 @@ int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
 
-/* HCI socket flags */
-#define HCI_PI_MGMT_INIT	0
-
 struct hci_pinfo {
 	struct bt_sock    bt;
 	struct hci_dev    *hdev;
 	struct hci_filter filter;
 	__u32             cmsg_mask;
 	unsigned short   channel;
-	unsigned long     flags;
 };
 
 /* HCI security filter */
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 8a814bc..63afd23 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -659,7 +659,6 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 			goto done;
 		}
 
-		set_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags);
 		break;
 
 	case HCI_CHANNEL_MONITOR:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fa9a589..4b1efed 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -615,19 +615,17 @@ static void service_cache_off(struct work_struct *work)
 
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
-	if (!test_and_clear_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags))
+	if (test_and_set_bit(HCI_MGMT, &hdev->dev_flags))
 		return;
 
-	if (!test_and_set_bit(HCI_MGMT, &hdev->dev_flags)) {
-		INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
+	INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 
-		/* Non-mgmt controlled devices get this bit set
-		 * implicitly so that pairing works for them, however
-		 * for mgmt we require user-space to explicitly enable
-		 * it
-		 */
-		clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
-	}
+	/* Non-mgmt controlled devices get this bit set
+	 * implicitly so that pairing works for them, however
+	 * for mgmt we require user-space to explicitly enable
+	 * it
+	 */
+	clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
 }
 
 static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
-- 
1.7.9.1

