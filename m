Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix toggling background scan when changing connectable state
Date: Tue,  8 Jul 2014 16:35:34 +0300
Message-Id: <1404826534-5546-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the connectable state change doesn't require any special HCI commands
the set_connectable_update_settings() function is used instead of the
set_connectable_complete() function. We must therefore make sure to call
hci_update_background_scan() there as well. This code path is used also
when we're powered off, but that's fine since hci_update_background_scan()
has the necessary checks for it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 376b164c5250..216aa93514b6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1794,8 +1794,10 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 	if (err < 0)
 		return err;
 
-	if (changed)
+	if (changed) {
+		hci_update_background_scan(hdev);
 		return new_settings(hdev, sk);
+	}
 
 	return 0;
 }
-- 
1.9.3

