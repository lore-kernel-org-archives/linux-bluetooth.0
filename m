Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Introduce a new HCI_RFKILLED flag
Date: Wed, 11 Sep 2013 14:33:58 +0300
Message-Id: <1378899239-5138-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1378899239-5138-1-git-send-email-johan.hedberg@gmail.com>
References: <1378899239-5138-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This makes it more convenient to check for rfkill (no need to check for
dev->rfkill before calling rfkill_blocked()) and also avoids potential
races if the RFKILL state needs to be checked from within the rfkill
callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

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
index 4dbb6cb..70efa16 100644
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
-- 
1.8.4.rc3

