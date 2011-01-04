Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/11] Bluetooth: Fix leaking blacklist when unregistering a hci device
Date: Tue,  4 Jan 2011 12:08:50 +0200
Message-Id: <1294135732-26765-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The blacklist should be freed before the hci device gets unregistered.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c03e6c9..f01dcea 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1085,6 +1085,10 @@ int hci_unregister_dev(struct hci_dev *hdev)
 
 	destroy_workqueue(hdev->workqueue);
 
+	hci_dev_lock_bh(hdev);
+	hci_blacklist_clear(hdev);
+	hci_dev_unlock_bh(hdev);
+
 	__hci_dev_put(hdev);
 
 	return 0;
-- 
1.7.2.3

