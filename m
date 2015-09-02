Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH] Bluetooth: close HCI device when user channel socket gets closed
Date: Wed,  2 Sep 2015 12:10:12 +0200
Message-Id: <1441188612-18946-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With 9380f9eacfbbee701daa416edd6625efcd3e29e1 the order of unsetting
the HCI_USER_CHANNEL flag of the HCI device was reverted to ensure
the device is first closed before making it available again.

Due to hci_dev_close checking for HCI_USER_CHANNEL being set on the
device it was never really closed and was kept opened. We're now
calling hci_dev_do_close directly to make sure the device is correctly
closed and we keep the correct order to unset the flag on our device
object.

Signed-off-by: Simon Fels <simon.fels@canonical.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 2 +-
 net/bluetooth/hci_sock.c         | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9e1a59e..256e673 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -987,6 +987,7 @@ int hci_resume_dev(struct hci_dev *hdev);
 int hci_reset_dev(struct hci_dev *hdev);
 int hci_dev_open(__u16 dev);
 int hci_dev_close(__u16 dev);
+int hci_dev_do_close(struct hci_dev *hdev);
 int hci_dev_reset(__u16 dev);
 int hci_dev_reset_stat(__u16 dev);
 int hci_dev_cmd(unsigned int cmd, void __user *arg);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5a36020..a7cdd99 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1549,7 +1549,7 @@ static void hci_pend_le_actions_clear(struct hci_dev *hdev)
 	BT_DBG("All LE pending actions cleared");
 }
 
-static int hci_dev_do_close(struct hci_dev *hdev)
+int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f2d30d1..050b6eb 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -503,7 +503,7 @@ static int hci_sock_release(struct socket *sock)
 
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
-			hci_dev_close(hdev->id);
+			hci_dev_do_close(hdev);
 			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
 			mgmt_index_added(hdev);
 		}
-- 
2.1.4

