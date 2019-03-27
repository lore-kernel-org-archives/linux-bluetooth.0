Return-Path: <SRS0=dIIZ=R6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB21C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 04:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A34C20811
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfC0EfN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:35:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:13368 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0EfN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Mar 2019 00:35:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 21:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="128985000"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 21:35:06 -0700
From:   SpoorthiX K <spoorthix.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-bluetooth-owner@vger.kernel.org
Subject: [PATCH] Add Support for LE Ping feature
Date:   Wed, 27 Mar 2019 10:13:13 +0530
Message-Id: <1553661793-10304-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>

Changes made to add HCI Write Authenticated Payload timeout
command for LE Ping feature.
As per the Core Specification 5.0 Volume 2 Part E Section 7.3.94,
the following code changes implements
HCI Write Authenticated Payload timeout command for LE Ping feature.

Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci.h      | 10 +++++++++
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_debugfs.c      | 31 ++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 44 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 89 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fbba43e..769a007 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1142,6 +1142,16 @@ struct hci_cp_write_sc_support {
 	__u8	support;
 } __packed;
 
+#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
+struct hci_cp_write_auth_payload_to {
+	__le16	handle;
+	__u16	timeout;
+} __packed;
+struct hci_rp_write_auth_payload_to {
+	__u8	status;
+	__le16	handle;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
 struct hci_rp_read_local_oob_ext_data {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 094e61e..ce0c7a2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -421,6 +421,7 @@ struct hci_dev {
 	__u32			rpa_timeout;
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
+	__u16			auth_payload_timeout;
 
 #if IS_ENABLED(CONFIG_BT_LEDS)
 	struct led_trigger	*power_led;
@@ -500,6 +501,7 @@ struct hci_conn {
 	__u8		remote_id;
 
 	unsigned int	sent;
+	bool		auth_payload_timeout_set;
 
 	struct sk_buff_head data_q;
 	struct list_head chan_list;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd4978c..cf036b8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -516,6 +516,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	conn->rssi = HCI_RSSI_INVALID;
 	conn->tx_power = HCI_TX_POWER_INVALID;
 	conn->max_tx_power = HCI_TX_POWER_INVALID;
+	conn->auth_payload_timeout_set = false;
 
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6b2540..29f524d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3193,6 +3193,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_max_tx_time = 0x0148;
 	hdev->le_max_rx_len = 0x001b;
 	hdev->le_max_rx_time = 0x0148;
+	hdev->auth_payload_timeout = 0x0bb8;
 	hdev->le_max_key_size = SMP_MAX_ENC_KEY_SIZE;
 	hdev->le_min_key_size = SMP_MIN_ENC_KEY_SIZE;
 	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 51f5b1e..f7ab4d6 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -941,6 +941,35 @@ static int adv_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
 			adv_max_interval_set, "%llu\n");
 
+static int auth_payload_timeout_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0001 || val > 0xffff)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->auth_payload_timeout = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int auth_payload_timeout_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->auth_payload_timeout;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(auth_payload_timeout_fops,
+			auth_payload_timeout_get,
+			auth_payload_timeout_set, "%llu\n");
+
 DEFINE_QUIRK_ATTRIBUTE(quirk_strict_duplicate_filter,
 		       HCI_QUIRK_STRICT_DUPLICATE_FILTER);
 DEFINE_QUIRK_ATTRIBUTE(quirk_simultaneous_discovery,
@@ -992,6 +1021,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 			    &adv_min_interval_fops);
 	debugfs_create_file("adv_max_interval", 0644, hdev->debugfs, hdev,
 			    &adv_max_interval_fops);
+	debugfs_create_file("auth_payload_timeout", 0644, hdev->debugfs, hdev,
+			    &auth_payload_timeout_fops);
 	debugfs_create_u16("discov_interleaved_timeout", 0644, hdev->debugfs,
 			   &hdev->discov_interleaved_timeout);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd68..94a8e58 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -564,6 +564,25 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static void hci_cc_write_auth_payload_timeout(struct hci_dev *hdev,
+					      struct sk_buff *skb)
+{
+	struct hci_rp_write_auth_payload_to *rp = (void *)skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hci_dev_lock(hdev);
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+
+	if (conn)
+		conn->auth_payload_timeout_set = true;
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_read_local_commands(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
@@ -2974,6 +2993,27 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		goto unlock;
 	}
+	/* Set the default Authenticated Payload Timeout after
+	 * an LE Link is established. As per Core Spec v5.0, Vol 2, Part B
+	 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT should be
+	 * sent when the link is active and Encryption is enabled, the conn
+	 * type can be either LE or ACL and controller must support LMP Ping.
+	 * Ensure for AES-CCM encryption as well.
+	 */
+	if ((conn->type == LE_LINK || conn->type == ACL_LINK) &
+		lmp_ping_capable(hdev) &&
+		test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
+		test_bit(HCI_CONN_AES_CCM, &conn->flags)) {
+		struct hci_cp_write_auth_payload_to cp;
+
+		cp.handle = cpu_to_le16(conn->handle);
+		cp.timeout = cpu_to_le16(hdev->auth_payload_timeout);
+		hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
+			     sizeof(cp), &cp);
+	} else {
+		conn->state = BT_CONNECTED;
+		hci_connect_cfm(conn, ev->status);
+	}
 
 notify:
 	if (conn->state == BT_CONFIG) {
@@ -3170,6 +3210,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_write_sc_support(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_AUTH_PAYLOAD_TO:
+		hci_cc_write_auth_payload_timeout(hdev, skb);
+		break;
+
 	case HCI_OP_READ_LOCAL_VERSION:
 		hci_cc_read_local_version(hdev, skb);
 		break;
-- 
1.9.1

