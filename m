Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: AMP contollers do not support the legacy ioctls
Date: Thu, 10 Oct 2013 10:02:08 -0700
Message-Id: <1381424528-9754-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The legacy ioctls for device specific commands including inquiry are
not support by AMP controllers. So just reject them right away instead
of trying to send the HCI command and wait for failure from the
actual hardware.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 10 ++++++++++
 net/bluetooth/hci_sock.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0c636ba..593b4ef 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1048,6 +1048,11 @@ int hci_inquiry(void __user *arg)
 		goto done;
 	}
 
+	if (hdev->dev_type != HCI_BREDR) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
 	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 		err = -EOPNOTSUPP;
 		goto done;
@@ -1533,6 +1538,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		goto done;
 	}
 
+	if (hdev->dev_type != HCI_BREDR) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
 	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 		err = -EOPNOTSUPP;
 		goto done;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 5798861..5b2d3f3 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -518,6 +518,9 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
 		return -EBUSY;
 
+	if (hdev->dev_type != HCI_BREDR)
+		return -EOPNOTSUPP;
+
 	switch (cmd) {
 	case HCISETRAW:
 		if (!capable(CAP_NET_ADMIN))
-- 
1.8.3.1

