Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add reading of all local feature pages
Date: Wed, 17 Apr 2013 15:00:52 +0300
Message-Id: <1366200052-13196-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1366200052-13196-1-git-send-email-johan.hedberg@gmail.com>
References: <1366200052-13196-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With the introduction of CSA4 there is now also a features page number 2
available. This patch increments the maximum supported page number to 2
and adds code for reading all available pages (as long as we have
support for them - indicated by HCI_MAX_PAGES).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_core.c         |   10 ++++++++++
 net/bluetooth/hci_event.c        |    2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 07fb173..12c0d73 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -134,7 +134,7 @@ struct amp_assoc {
 	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
 };
 
-#define HCI_MAX_PAGES	2
+#define HCI_MAX_PAGES	3
 
 #define NUM_REASSEMBLY 4
 struct hci_dev {
@@ -153,6 +153,7 @@ struct hci_dev {
 	__u8		dev_class[3];
 	__u8		major_class;
 	__u8		minor_class;
+	__u8		max_page;
 	__u8		features[HCI_MAX_PAGES][8];
 	__u8		le_features[8];
 	__u8		le_white_list_size;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9570358..e246d37 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -589,6 +589,7 @@ static void hci_set_le_support(struct hci_request *req)
 static void hci_init3_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
+	u8 p;
 
 	if (hdev->commands[5] & 0x10)
 		hci_setup_link_policy(req);
@@ -597,6 +598,15 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 		hci_set_le_support(req);
 		hci_update_ad(req);
 	}
+
+	/* Read features beyond page 1 if available */
+	for (p = 2; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
+		struct hci_cp_read_local_ext_features cp;
+
+		cp.page = p;
+		hci_req_add(req, HCI_OP_READ_LOCAL_EXT_FEATURES,
+			    sizeof(cp), &cp);
+	}
 }
 
 static int __hci_init(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 39c61c9..95c7655 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -544,6 +544,8 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
+	hdev->max_page = rp->max_page;
+
 	if (rp->page < HCI_MAX_PAGES)
 		memcpy(hdev->features[rp->page], rp->features, 8);
 }
-- 
1.7.10.4

