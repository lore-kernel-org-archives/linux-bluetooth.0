Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D6C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4F5218FC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfDXIIo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:08:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:45025 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfDXIIo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 04:08:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 01:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="164355633"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2019 01:08:43 -0700
From:   SpoorthiX K <spoorthix.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] [v5]Add support for LE ping feature
Date:   Wed, 24 Apr 2019 13:47:09 +0530
Message-Id: <1556093829-11793-1-git-send-email-spoorthix.k@intel.com>
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
 include/net/bluetooth/hci.h      | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_debugfs.c      | 29 +++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 42 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e..366d2c7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1130,6 +1130,16 @@ struct hci_cp_write_sc_support {
 	__u8	support;
 } __packed;
 
+#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
+struct hci_cp_write_auth_payload_to {
+	__le16  handle;
+	__le16  timeout;
+} __packed;
+struct hci_rp_write_auth_payload_to {
+	__u8    status;
+	__le16  handle;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
 struct hci_rp_read_local_oob_ext_data {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5ea633..57ec424 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -421,6 +421,7 @@ struct hci_dev {
 	__u32			rpa_timeout;
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
+	__u16			auth_payload_timeout;
 
 #if IS_ENABLED(CONFIG_BT_LEDS)
 	struct led_trigger	*power_led;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7352fe8..402bbf9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3147,6 +3147,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_max_tx_time = 0x0148;
 	hdev->le_max_rx_len = 0x001b;
 	hdev->le_max_rx_time = 0x0148;
+	hdev->auth_payload_timeout = 0x0bb8;
 	hdev->le_max_key_size = SMP_MAX_ENC_KEY_SIZE;
 	hdev->le_min_key_size = SMP_MIN_ENC_KEY_SIZE;
 	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 51f5b1e..930f01f 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -941,6 +941,33 @@ static int adv_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
 			adv_max_interval_set, "%llu\n");
 
+static int auth_payload_timeout_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0001 || val > 0xffff)
+		return -EINVAL;
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
@@ -995,6 +1022,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 	debugfs_create_u16("discov_interleaved_timeout", 0644, hdev->debugfs,
 			   &hdev->discov_interleaved_timeout);
 
+	debugfs_create_file("auth_payload_timeout", 0644, hdev->debugfs, hdev,
+			    &auth_payload_timeout_fops);
 	debugfs_create_file("quirk_strict_duplicate_filter", 0644,
 			    hdev->debugfs, hdev,
 			    &quirk_strict_duplicate_filter_fops);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2826c..ecc5ea1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -579,6 +579,25 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 }
 
+static void hci_cc_write_auth_payload_timeout(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	struct hci_rp_write_auth_payload_to *rp = (void *)skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+	if (rp->status)
+		return;
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (conn)
+		set_bit(HCI_CONN_AUTH_PAYLOAD_TIMEOUT, &conn->flags);
+
+	hci_dev_unlock(hdev);
+}
+
+
 static void hci_cc_read_local_features(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
@@ -2975,6 +2994,25 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 	}
 
+	/* Set the default Authenticated Payload Timeout after
+	 * an LE Link is established. As per Core Spec v5.0, Vol 2, Part B
+	 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT should be
+	 * sent when the link is active and Encryption is enabled, the conn
+	 * type can be either LE or ACL and controller must support LMP Ping.
+	 * Ensure for AES-CCM encryption as well.
+	 */
+	if ((conn->type == LE_LINK || conn->type == ACL_LINK) &&
+	    lmp_ping_capable(hdev) && (hdev->le_features[0] & HCI_LE_PING)
+	     test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
+	      test_bit(HCI_CONN_AES_CCM, &conn->flags)) {
+		struct hci_cp_write_auth_payload_to cp;
+
+		cp.handle = cpu_to_le16(conn->handle);
+		cp.timeout = cpu_to_le16(hdev->auth_payload_timeout);
+		hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
+			     sizeof(cp), &cp);
+	}
+
 notify:
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status)
@@ -3178,6 +3216,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_local_commands(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_AUTH_PAYLOAD_TO:
+		hci_cc_write_auth_payload_timeout(hdev, skb);
+		break;
+
 	case HCI_OP_READ_LOCAL_FEATURES:
 		hci_cc_read_local_features(hdev, skb);
 		break;
-- 
1.9.1

