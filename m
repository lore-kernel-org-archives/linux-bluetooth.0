Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] Bluetooth: Flush inquiry cache when starting mgmt triggered inquiry
Date: Thu,  5 Jan 2012 17:16:19 +0200
Message-Id: <1325776582-10314-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For the remote name state tracking for the management interface to work
the cache needs to be flushed whenever inquiry is started. The
hci_do_inquiry function is only used by the management interface so by
having the flushing done from it ensures that old ioctl based
functionality isn't affected.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 67b0bd6..5c0a1e7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2611,6 +2611,8 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
 	if (test_bit(HCI_INQUIRY, &hdev->flags))
 		return -EINPROGRESS;
 
+	inquiry_cache_flush(hdev);
+
 	memset(&cp, 0, sizeof(cp));
 	memcpy(&cp.lap, lap, sizeof(cp.lap));
 	cp.length  = length;
-- 
1.7.7.3

