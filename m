Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Fix workqueue synchronization in hci_dev_open
Date: Tue,  1 Oct 2013 22:44:50 +0300
Message-Id: <1380656690-22246-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380656690-22246-1-git-send-email-johan.hedberg@gmail.com>
References: <1380656690-22246-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When hci_sock.c calls hci_dev_open it needs to ensure that there isn't
pending work in progress, such as that which is scheduled for the
initial setup procedure or the one for automatically powering off after
the setup procedure. This adds the necessary calls to ensure that any
previously scheduled work is completed before attempting to call
hci_dev_do_open.

This patch fixes a race with old user space versions where we might
receive a HCIDEVUP ioctl before the setup procedure has been completed.
When that happens the setup procedures callback may fail early and leave
the device in an inconsistent state, causing e.g. the setup callback to
be (incorrectly) called more than once.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fc63e78..a573aa2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1227,6 +1227,16 @@ int hci_dev_open(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
+	/* We need to ensure that no other power on/off work is pending
+	 * before proceeding to call hci_dev_do_open. This is
+	 * particularly important if the setup procedure has not yet
+	 * completed.
+	 */
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		cancel_delayed_work(&hdev->power_off);
+
+	flush_workqueue(hdev->req_workqueue);
+
 	err = hci_dev_do_open(hdev);
 
 	hci_dev_put(hdev);
-- 
1.8.3.1

