Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: mgmt: Fix clear_uuids response
Date: Thu, 23 Feb 2012 23:32:54 +0200
Message-Id: <1330032774-16206-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
References: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the clear_uuids operation doesn't send an immediate HCI command
but just sets off a timer to wait for subsequent add_uuid calls it
doesn't make sense to wait until the timer fires off to send the
response. Instead send the response immediately.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7a906d6..07e31f7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1394,6 +1394,20 @@ failed:
 	return err;
 }
 
+static bool enable_service_cache(struct hci_dev *hdev)
+{
+	if (!hdev_is_powered(hdev))
+		return false;
+
+	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
+		schedule_delayed_work(&hdev->service_cache,
+				msecs_to_jiffies(SERVICE_CACHE_TIMEOUT));
+		return true;
+	}
+
+	return false;
+}
+
 static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_cp_remove_uuid *cp = data;
@@ -1425,10 +1439,11 @@ static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
 	if (memcmp(cp->uuid, bt_uuid_any, 16) == 0) {
 		err = hci_uuids_clear(hdev);
 
-		if (hdev_is_powered(hdev) &&
-				!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
-			schedule_delayed_work(&hdev->service_cache,
-					msecs_to_jiffies(SERVICE_CACHE_TIMEOUT));
+		if (enable_service_cache(hdev)) {
+			err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, 0,
+							hdev->dev_class, 3);
+			goto unlock;
+		}
 
 		goto update_class;
 	}
-- 
1.7.9

