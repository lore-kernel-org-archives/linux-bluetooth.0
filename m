Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix using system-global workqueue when not necessary
Date: Mon, 14 Jan 2013 22:33:52 +0200
Message-Id: <1358195633-29303-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's a per-HCI device workqueue (hdev->workqueue) that should be used
for general per-HCI device work (except hdev->req_workqueue that's for
hci_request() related work). This patch fixes places using the
system-global work queue and makes them use the hdev->workqueue instead.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    4 ++--
 net/bluetooth/mgmt.c     |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 545553b..e061b35 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1622,8 +1622,8 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 	if (err < 0)
 		return err;
 
-	schedule_delayed_work(&hdev->le_scan_disable,
-			      msecs_to_jiffies(timeout));
+	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
+			   msecs_to_jiffies(timeout));
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 54114ff..fc171f2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1361,7 +1361,8 @@ static bool enable_service_cache(struct hci_dev *hdev)
 		return false;
 
 	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
-		schedule_delayed_work(&hdev->service_cache, CACHE_TIMEOUT);
+		queue_delayed_work(hdev->workqueue, &hdev->service_cache,
+				   CACHE_TIMEOUT);
 		return true;
 	}
 
-- 
1.7.10.4

