Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix race condition with user channel and setup stage
Date: Sat,  6 Jun 2015 06:06:49 +0200
Message-Id: <1433563609-75812-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During the initial setup stage of a controller, the low-level transport
is actually active. This means that HCI_UP is true. To avoid toggling
the transport off and back on again for normal operation the kernel
holds a grace period with HCI_AUTO_OFF that will turn the low-level
transport off in case no user is present.

The idea of the grace period is important to avoid having to initialize
all of the controller twice. So legacy ioctl and the new management
interface knows how to clear this grace period and then start normal
operation.

For the user channel operation this grace period has not been taken into
account which results in the problem that HCI_UP and HCI_AUTO_OFF are
set and the kernel will return EBUSY. However from a system point of
view the controller is ready to be grabbed by either the ioctl, the
management interface or the user channel.

This patch brings the user channel to the same level as the other two
entries for operating a controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
---
 net/bluetooth/hci_sock.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 5b14dcafcd08..e08c18c328bc 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -741,10 +741,11 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
-		if (test_bit(HCI_UP, &hdev->flags) ||
-		    test_bit(HCI_INIT, &hdev->flags) ||
+		if (test_bit(HCI_INIT, &hdev->flags) ||
 		    hci_dev_test_flag(hdev, HCI_SETUP) ||
-		    hci_dev_test_flag(hdev, HCI_CONFIG)) {
+		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+		    (!hci_dev_test_flag(hdev, HCI_AUTO_OFF) &&
+		     test_bit(HCI_UP, &hdev->flags))) {
 			err = -EBUSY;
 			hci_dev_put(hdev);
 			goto done;
@@ -760,10 +761,21 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
-			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
-			mgmt_index_added(hdev);
-			hci_dev_put(hdev);
-			goto done;
+			if (err == -EALREADY) {
+				/* In case the transport is already up and
+				 * running, clear the error here.
+				 *
+				 * This can happen when opening an user
+				 * channel and HCI_AUTO_OFF grace period
+				 * is still active.
+				 */
+				err = 0;
+			} else {
+				hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
+				mgmt_index_added(hdev);
+				hci_dev_put(hdev);
+				goto done;
+			}
 		}
 
 		atomic_inc(&hdev->promisc);
-- 
2.4.2

