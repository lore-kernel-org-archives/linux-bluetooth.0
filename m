Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/13] Bluetooth: Add debugfs entry for RPA regeneration timeout
Date: Sun, 23 Feb 2014 19:42:26 +0200
Message-Id: <1393177349-361-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a rpa_timeout debugfs entry which can be used to set the
RPA regeneration timeout to something else than the default 15 minutes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7bc67b4e47a7..629919be071c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -492,6 +492,37 @@ static int idle_timeout_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
 			idle_timeout_set, "%llu\n");
 
+static int rpa_timeout_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	/* Require the RPA timeout to be at least 30 seconds and at most
+	 * 24 hours.
+	 */
+	if (val < 30 || val > (60 * 60 * 24))
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->rpa_timeout = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int rpa_timeout_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->rpa_timeout;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(rpa_timeout_fops, rpa_timeout_get,
+			rpa_timeout_set, "%llu\n");
+
 static int sniff_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -1612,6 +1643,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &random_address_fops);
 		debugfs_create_file("static_address", 0444, hdev->debugfs,
 				    hdev, &static_address_fops);
+		debugfs_create_file("rpa_timeout", 0644, hdev->debugfs,
+				    hdev, &rpa_timeout_fops);
 
 		/* For controllers with a public address, provide a debug
 		 * option to force the usage of the configured static
-- 
1.8.5.3

