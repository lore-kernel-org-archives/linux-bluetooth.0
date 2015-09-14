Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix missing HCI_RAW check when binding USER_CHANNEL socket
Date: Mon, 14 Sep 2015 10:14:24 +0300
Message-Id: <1442214864-30292-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

HCI devices in RAW mode will have the HCI_UP flag set. The existing
hci_sock_bind code, when invoked on a HCI_CHANNEL_USER socket, tests
for this flag and will return EBUSY, making it impossible to bind any
HCI device RAW mode. This patch adds an extra condition for the
HCI_RAW flag to make it possible for bind() to succeed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 150556345263..6588929b4d26 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -754,6 +754,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		    hci_dev_test_flag(hdev, HCI_SETUP) ||
 		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
 		    (!hci_dev_test_flag(hdev, HCI_AUTO_OFF) &&
+		     !test_bit(HCI_RAW, &hdev->flags) &&
 		     test_bit(HCI_UP, &hdev->flags))) {
 			err = -EBUSY;
 			hci_dev_put(hdev);
-- 
2.4.3

