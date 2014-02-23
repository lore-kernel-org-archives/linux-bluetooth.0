Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/13] Bluetooth: Add timer for regenerating local RPA
Date: Sun, 23 Feb 2014 19:42:20 +0200
Message-Id: <1393177349-361-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a timer for updating the local RPA periodically. The
default timeout is set to 15 minutes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  5 +++++
 net/bluetooth/hci_core.c         |  4 ++++
 net/bluetooth/mgmt.c             | 23 +++++++++++++++++++++++
 4 files changed, 33 insertions(+)

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
index 68bbcabdd9fd..6415514e4f17 100644
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
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 964aa8deb009..92d35811b61e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2102,6 +2102,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 
 	if (!ret) {
 		hci_dev_hold(hdev);
+		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
@@ -2199,6 +2200,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->rpa_expired);
 
 	hci_dev_lock(hdev);
 	hci_inquiry_cache_flush(hdev);
@@ -3300,6 +3302,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_conn_min_interval = 0x0028;
 	hdev->le_conn_max_interval = 0x0038;
 
+	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 301b18a1c6a0..09316dd2cce1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -881,12 +881,35 @@ static void service_cache_off(struct work_struct *work)
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

