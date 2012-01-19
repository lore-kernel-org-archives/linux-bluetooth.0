Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth Convert hdev->ssp_mode to a flag
Date: Thu, 19 Jan 2012 11:42:52 +0200
Message-Id: <1326966173-20105-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326966173-20105-1-git-send-email-johan.hedberg@gmail.com>
References: <1326966173-20105-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The ssp_mode is essentially just a boolean so it's more appropriate to
have it simply as a flag in hdev->dev_flags.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 -
 net/bluetooth/hci_conn.c         |    6 +++---
 net/bluetooth/hci_event.c        |   17 ++++++++++++-----
 net/bluetooth/mgmt.c             |    4 ++--
 5 files changed, 18 insertions(+), 11 deletions(-)

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
index 7a03311..94ba869 100644
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
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8288e30..6ec259e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -609,8 +609,8 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 	BT_DBG("conn %p", conn);
 
 	if (test_bit(HCI_CONN_SSP_ENABLED, &conn->flags) &&
-					conn->hdev->ssp_mode > 0 &&
-					!(conn->link_mode & HCI_LM_ENCRYPT))
+			test_bit(HCI_SSP_ENABLED, &conn->hdev->dev_flags) &&
+			!(conn->link_mode & HCI_LM_ENCRYPT))
 		return 0;
 
 	return 1;
@@ -674,7 +674,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 	   key. */
 	if (sec_level == BT_SECURITY_LOW &&
 			(!test_bit(HCI_CONN_SSP_ENABLED, &conn->flags) ||
-							!conn->hdev->ssp_mode))
+			!test_bit(HCI_SSP_ENABLED, &conn->hdev->dev_flags)))
 		return 1;
 
 	/* For other security levels we need the link key. */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cbb0fa2..3163d18 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -429,7 +429,10 @@ static void hci_cc_read_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	hdev->ssp_mode = rp->mode;
+	if (rp->mode)
+		set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+	else
+		clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 }
 
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -446,7 +449,10 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
-	hdev->ssp_mode = *((__u8 *) sent);
+	if (*((u8 *) sent))
+		set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+	else
+		clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
@@ -1264,7 +1270,7 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 
 	/* Only request authentication for SSP connections or non-SSP
 	 * devices with sec_level HIGH or if MITM protection is requested */
-	if (!(hdev->ssp_mode > 0 &&
+	if (!(test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 			test_bit(HCI_CONN_SSP_ENABLED, &conn->flags)) &&
 				conn->pending_sec_level != BT_SECURITY_HIGH &&
 				!(conn->auth_type & 0x01))
@@ -1840,7 +1846,7 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 
 	if (!ev->status) {
 		if (!(test_bit(HCI_CONN_SSP_ENABLED, &conn->flags) &&
-							hdev->ssp_mode > 0) &&
+				test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) &&
 				test_bit(HCI_CONN_REAUTH_PEND,	&conn->flags)) {
 			BT_INFO("re-auth of legacy device is not possible.");
 		} else {
@@ -1855,7 +1861,8 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	clear_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 
 	if (conn->state == BT_CONFIG) {
-		if (!ev->status && hdev->ssp_mode > 0 &&
+		if (!ev->status &&
+				test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 				test_bit(HCI_CONN_SSP_ENABLED, &conn->flags)) {
 			struct hci_cp_set_conn_encrypt cp;
 			cp.handle  = ev->handle;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ae9283d..8970799 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -297,7 +297,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_AUTH, &hdev->flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
-	if (hdev->ssp_mode > 0)
+	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_SSP;
 
 	return settings;
@@ -416,7 +416,7 @@ static int update_eir(struct hci_dev *hdev)
 	if (!(hdev->features[6] & LMP_EXT_INQ))
 		return 0;
 
-	if (hdev->ssp_mode == 0)
+	if (!test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
 		return 0;
 
 	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
-- 
1.7.8.3

