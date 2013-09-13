Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: Introduce a new HCI_RFKILLED flag
Date: Fri, 13 Sep 2013 08:58:17 +0300
Message-Id: <1379051898-2630-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379051898-2630-1-git-send-email-johan.hedberg@gmail.com>
References: <1379051898-2630-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This makes it more convenient to check for rfkill (no need to check for
dev->rfkill before calling rfkill_blocked()) and also avoids potential
races if the RFKILL state needs to be checked from within the rfkill
callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
v3: no changes
v2: Explicitly intialize HCI_RFKILLED flag after calling rfkill_register

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 30c88b5..ba008d5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -104,6 +104,7 @@ enum {
 enum {
 	HCI_SETUP,
 	HCI_AUTO_OFF,
+	HCI_RFKILLED,
 	HCI_MGMT,
 	HCI_PAIRABLE,
 	HCI_SERVICE_CACHE,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4dbb6cb..d0d6cf8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1148,7 +1148,7 @@ int hci_dev_open(__u16 dev)
 		goto done;
 	}
 
-	if (hdev->rfkill && rfkill_blocked(hdev->rfkill)) {
+	if (test_bit(HCI_RFKILLED, &hdev->dev_flags)) {
 		ret = -ERFKILL;
 		goto done;
 	}
@@ -1597,10 +1597,12 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
 		return -EBUSY;
 
-	if (!blocked)
-		return 0;
-
-	hci_dev_do_close(hdev);
+	if (blocked) {
+		set_bit(HCI_RFKILLED, &hdev->dev_flags);
+		hci_dev_do_close(hdev);
+	} else {
+		clear_bit(HCI_RFKILLED, &hdev->dev_flags);
+	}
 
 	return 0;
 }
@@ -2244,6 +2246,9 @@ int hci_register_dev(struct hci_dev *hdev)
 		}
 	}
 
+	if (hdev->rfkill && rfkill_blocked(hdev->rfkill))
+		set_bit(HCI_RFKILLED, &hdev->dev_flags);
+
 	set_bit(HCI_SETUP, &hdev->dev_flags);
 
 	if (hdev->dev_type != HCI_AMP)
-- 
1.8.4.rc3

