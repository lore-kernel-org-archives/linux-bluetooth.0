Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] Bluetooth: mgmt: Fix pairable setting upon initialization
Date: Tue, 21 Feb 2012 18:00:04 +0200
Message-Id: <1329840005-4977-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When mgmt is not in use the HCI_PAIRABLE flag will get implicitly set so
that pairing still works with old user space versions. However, as soon
as mgmt comes into play we should clear this flag so that it can be
properly set through the set_pairable command by user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index abad38c..ac6dcff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -601,9 +601,17 @@ static void service_cache_off(struct work_struct *work)
 
 static void mgmt_init_hdev(struct hci_dev *hdev)
 {
-	if (!test_and_set_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!test_and_set_bit(HCI_MGMT, &hdev->dev_flags)) {
 		INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 
+		/* Non-mgmt controlled devices get this bit set
+		 * implicitly so that pairing works for them, however
+		 * for mgmt we require user-space to explicitly enable
+		 * it
+		 */
+		clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
+	}
+
 	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		schedule_delayed_work(&hdev->service_cache,
 				msecs_to_jiffies(SERVICE_CACHE_TIMEOUT));
-- 
1.7.9

