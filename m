Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 03/16] Bluetooth: mgmt: multi adv for read_adv_features()
Date: Mon, 25 May 2015 00:39:01 +0200
Message-Id: <1432507154-22925-4-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The read_adv_features() method had a single instance identifier hard
coded. Refer to the advertising instance list instead to return a
dynamically generated list of instance identifiers.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9dc4905..9f5ac26 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6770,8 +6770,9 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_rp_read_adv_features *rp;
 	size_t rp_len;
-	int err;
+	int err, i;
 	bool instance;
+	struct adv_info *adv_instance;
 	u32 supported_flags;
 
 	BT_DBG("%s", hdev->name);
@@ -6784,12 +6785,9 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 
 	rp_len = sizeof(*rp);
 
-	/* Currently only one instance is supported, so just add 1 to the
-	 * response length.
-	 */
 	instance = hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE);
 	if (instance)
-		rp_len++;
+		rp_len += hdev->adv_instance_cnt;
 
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
@@ -6804,12 +6802,16 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
 	rp->max_instances = HCI_MAX_ADV_INSTANCES;
 
-	/* Currently only one instance is supported, so simply return the
-	 * current instance number.
-	 */
 	if (instance) {
-		rp->num_instances = 1;
-		rp->instance[0] = 1;
+		i = 0;
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+			if (i >= hdev->adv_instance_cnt)
+				break;
+
+			rp->instance[i] = adv_instance->instance;
+			i++;
+		}
+		rp->num_instances = hdev->adv_instance_cnt;
 	} else {
 		rp->num_instances = 0;
 	}
-- 
1.9.1

