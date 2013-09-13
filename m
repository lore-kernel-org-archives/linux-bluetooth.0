Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add synchronization train parameters reading support
Date: Fri, 13 Sep 2013 11:40:01 +0300
Message-Id: <1379061602-8290-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com>
References: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds support for reading the synchronization train parameters
for controllers that support the feature. Since the feature is
detectable through the local features page 2, which is retreived only in
stage 3 of the HCI init sequence, there is no other option than to add a
fourth stage to the init sequence.

For now the patch doesn't yet add storing of the parameters, but it is
nevertheless convenient to have around to see what kind of parameters
various controllers use by default (analyzable e.g. with the btmon user
space tool).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_core.c    | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ba008d5..63cce97 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -839,6 +839,8 @@ struct hci_cp_write_le_host_supported {
 	__u8	simul;
 } __packed;
 
+#define HCI_OP_READ_SYNC_TRAIN_PARAMS	0x0c77
+
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
 struct hci_rp_read_local_version {
 	__u8     status;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 12b017d..8f73b1f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -645,6 +645,15 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	}
 }
 
+static void hci_init4_req(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	/* Check for Synchronization Train support */
+	if (hdev->features[2][0] & 0x04)
+		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
+}
+
 static int __hci_init(struct hci_dev *hdev)
 {
 	int err;
@@ -664,7 +673,11 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	return __hci_req_sync(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT);
+	err = __hci_req_sync(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT);
+	if (err < 0)
+		return err;
+
+	return __hci_req_sync(hdev, hci_init4_req, 0, HCI_INIT_TIMEOUT);
 }
 
 static void hci_scan_req(struct hci_request *req, unsigned long opt)
-- 
1.8.4.rc3

