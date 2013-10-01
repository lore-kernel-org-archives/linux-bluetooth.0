Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix workqueue synchronization in hci_dev_open
Date: Tue,  1 Oct 2013 14:10:28 +0300
Message-Id: <1380625828-19538-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380625828-19538-1-git-send-email-johan.hedberg@gmail.com>
References: <1380625828-19538-1-git-send-email-johan.hedberg@gmail.com>
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
---
 net/bluetooth/hci_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fc63e78..a216dcf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1227,6 +1227,11 @@ int hci_dev_open(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		cancel_delayed_work(&hdev->power_off);
+
+	flush_workqueue(hdev->req_workqueue);
+
 	err = hci_dev_do_open(hdev);
 
 	hci_dev_put(hdev);
-- 
1.8.3.1

