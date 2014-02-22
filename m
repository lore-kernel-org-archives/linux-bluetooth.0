Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/15] Bluetooth: Add mechanism for updating the local RPA
Date: Sat, 22 Feb 2014 19:06:40 +0200
Message-Id: <1393088805-28658-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to have a way of updating the local RPA periodically. This patch
adds a HCI_RPA_EXPIRED flag to track when the RPA needs to be
regenerated as well as a delayed work structure and callback to do the
updating periodically. By default the period for updating the RPA is set
to 15 minutes.

When the RPA gets regenerated we need to disable and re-enable
advertising if necessary. If there are any LE connections we do not
update the RPA.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  7 +++++++
 net/bluetooth/hci_core.c         | 25 +++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 23 +++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5ff885ff29df..1bb45a47a78a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -127,6 +127,7 @@ enum {
 	HCI_SC_ENABLED,
 	HCI_SC_ONLY,
 	HCI_PRIVACY,
+	HCI_RPA_EXPIRED,
 	HCI_RPA_RESOLVING,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 68bbcabdd9fd..94383dca6597 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -130,6 +130,9 @@ struct oob_data {
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
+/* Default LE RPA expiry time, 15 minutes */
+#define HCI_DEFAULT_RPA_TIMEOUT		(15 * 60)
+
 struct amp_assoc {
 	__u16	len;
 	__u16	offset;
@@ -304,6 +307,8 @@ struct hci_dev {
 	__u8			scan_rsp_data_len;
 
 	__u8			irk[16];
+	__u32			rpa_timeout;
+	struct delayed_work	rpa_expired;
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
@@ -1252,6 +1257,8 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 
+void hci_update_rpa(struct hci_request *req);
+
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 753a73ba6764..eeeeda7e6b70 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2202,6 +2202,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 
+	cancel_delayed_work_sync(&hdev->rpa_expired);
+	set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+
 	hci_dev_lock(hdev);
 	hci_inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
@@ -3276,6 +3279,26 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+void hci_update_rpa(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	bdaddr_t rpa;
+
+	if (smp_generate_rpa(hdev->tfm_aes, hdev->irk, &rpa) < 0) {
+		BT_ERR("%s failed to generate new RPA", hdev->name);
+		return;
+	}
+
+	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &rpa);
+
+	if (hdev->rpa_timeout) {
+		int to;
+
+		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
+		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
+	}
+}
+
 /* Alloc HCI device */
 struct hci_dev *hci_alloc_dev(void)
 {
@@ -3302,6 +3325,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_conn_min_interval = 0x0028;
 	hdev->le_conn_max_interval = 0x0038;
 
+	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 21d059968c32..248f116e3d08 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -882,12 +882,35 @@ static void service_cache_off(struct work_struct *work)
 	hci_req_run(&req, NULL);
 }
 
+static void rpa_expired(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    rpa_expired.work);
+	struct hci_request req;
+
+	BT_DBG("");
+
+	set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+
+	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags) ||
+	    hci_conn_num(hdev, LE_LINK) > 0)
+		return;
+
+	hci_req_init(&req, hdev);
+
+	disable_advertising(&req);
+	enable_advertising(&req);
+
+	hci_req_run(&req, NULL);
+}
+
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
 	if (test_and_set_bit(HCI_MGMT, &hdev->dev_flags))
 		return;
 
 	INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
+	INIT_DELAYED_WORK(&hdev->rpa_expired, rpa_expired);
 
 	/* Non-mgmt controlled devices get this bit set
 	 * implicitly so that pairing works for them, however
-- 
1.8.5.3

