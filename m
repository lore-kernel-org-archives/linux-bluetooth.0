Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/4] Bluetooth: Interleaved discovery support
Date: Thu, 16 Feb 2012 18:50:41 -0300
Message-Id: <1329429041-30715-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds interleaved discovery support to MGMT Start
Discovery command.

In case interleaved discovery is not supported (not a dual mode
device), we perform BR/EDR or LE-only discovery according to the
device capabilities.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_event.c        |   13 +++++++---
 net/bluetooth/mgmt.c             |   47 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ee4dba5..26666f0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -720,6 +720,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
 #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
 #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
+#define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
 
 /* ----- Extended LMP capabilities ----- */
 #define lmp_host_le_capable(dev)   ((dev)->host_features[0] & LMP_HOST_LE)
@@ -1009,6 +1010,7 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
+int mgmt_interleaved_discovery(struct hci_dev *hdev);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d68e4cc..5bfe8c0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1083,11 +1083,16 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-		hci_dev_lock(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		hci_dev_unlock(hdev);
-
 		schedule_delayed_work(&hdev->adv_work, ADV_CLEAR_TIMEOUT);
+
+		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED) {
+			mgmt_interleaved_discovery(hdev);
+		} else {
+			hci_dev_lock(hdev);
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+			hci_dev_unlock(hdev);
+		}
+
 		break;
 
 	default:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7165d66..3d24dad 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,8 +106,11 @@ static const u16 mgmt_events[] = {
 #define LE_SCAN_WIN			0x12
 #define LE_SCAN_INT			0x12
 #define LE_SCAN_TIMEOUT_LE_ONLY		10240	/* TGAP(gen_disc_scan_min) */
+#define LE_SCAN_TIMEOUT_BREDR_LE	5120	/* TGAP(100)/2 */
 
 #define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
+#define INQUIRY_LEN_BREDR_LE		0x04	/* TGAP(100)/2 */
+
 
 #define SERVICE_CACHE_TIMEOUT (5 * 1000)
 
@@ -2033,6 +2036,45 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 	return err;
 }
 
+static int discovery(struct hci_dev *hdev)
+{
+	int err;
+
+	if (lmp_host_le_capable(hdev)) {
+		if (lmp_bredr_capable(hdev)) {
+			err = hci_le_scan(hdev, LE_SCAN_TYPE,
+						LE_SCAN_INT, LE_SCAN_WIN,
+						LE_SCAN_TIMEOUT_BREDR_LE);
+		} else {
+			hdev->discovery.type = DISCOV_TYPE_LE;
+			err = hci_le_scan(hdev, LE_SCAN_TYPE,
+						LE_SCAN_INT, LE_SCAN_WIN,
+						LE_SCAN_TIMEOUT_LE_ONLY);
+		}
+	} else {
+		hdev->discovery.type = DISCOV_TYPE_BREDR;
+		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+	}
+
+	return err;
+}
+
+int mgmt_interleaved_discovery(struct hci_dev *hdev)
+{
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
+	if (err < 0) {
+		hci_dev_lock(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		hci_dev_unlock(hdev);
+	}
+
+	return err;
+}
+
 static int start_discovery(struct sock *sk, u16 index,
 						void *data, u16 len)
 {
@@ -2076,7 +2118,6 @@ static int start_discovery(struct sock *sk, u16 index,
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
-	case DISCOV_TYPE_INTERLEAVED:
 		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
 		break;
 
@@ -2085,6 +2126,10 @@ static int start_discovery(struct sock *sk, u16 index,
 					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
 		break;
 
+	case DISCOV_TYPE_INTERLEAVED:
+		err = discovery(hdev);
+		break;
+
 	default:
 		err = -EINVAL;
 	}
-- 
1.7.9.1

