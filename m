Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/15] Bluetooth: Convert hdev->ssp_mode to a flag
Date: Wed, 18 Jan 2012 20:51:53 +0200
Message-Id: <1326912717-6347-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The ssp_mode is essentially just a boolean so it's more appropriate to
have it simply as a flag in hdev->dev_flags.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    3 +--
 net/bluetooth/hci_event.c        |   10 ++++++++--
 net/bluetooth/mgmt.c             |    4 ++--
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index dd2cc6c..cb9097a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -94,6 +94,7 @@ enum {
 	HCI_DEBUG_KEYS,
 
 	HCI_LE_SCAN,
+	HCI_SSP_ENABLED,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f2ccdae..4440e49 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -144,7 +144,6 @@ struct hci_dev {
 	__u8		features[8];
 	__u8		host_features[8];
 	__u8		commands[64];
-	__u8		ssp_mode;
 	__u8		hci_ver;
 	__u16		hci_rev;
 	__u8		lmp_ver;
@@ -414,7 +413,7 @@ enum {
 static inline bool hci_conn_ssp_support(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	return (hdev->ssp_mode > 0 &&
+	return (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 				test_bit(HCI_CONN_SSP_SUPPORT, &conn->flags));
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aee417c..21ab6e7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -429,7 +429,10 @@ static void hci_cc_read_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	hdev->ssp_mode = rp->mode;
+	if (rp->mode)
+		set_bit(HCI_SSP_ENABLED, &hdev->flags);
+	else
+		clear_bit(HCI_SSP_ENABLED, &hdev->flags);
 }
 
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -446,7 +449,10 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
-	hdev->ssp_mode = *((__u8 *) sent);
+	if (*(u8 *) sent)
+		set_bit(HCI_SSP_ENABLED, &hdev->flags);
+	else
+		clear_bit(HCI_SSP_ENABLED, &hdev->flags);
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bec64c9..c851579 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -297,7 +297,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_AUTH, &hdev->flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
-	if (hdev->ssp_mode > 0)
+	if (test_bit(HCI_SSP_ENABLED, &hdev->flags))
 		settings |= MGMT_SETTING_SSP;
 
 	return settings;
@@ -416,7 +416,7 @@ static int update_eir(struct hci_dev *hdev)
 	if (!(hdev->features[6] & LMP_EXT_INQ))
 		return 0;
 
-	if (hdev->ssp_mode == 0)
+	if (!test_bit(HCI_SSP_ENABLED, &hdev->flags))
 		return 0;
 
 	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
-- 
1.7.8.3

