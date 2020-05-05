Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE7C47247
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2457B206FA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgEEXUs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 19:20:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37030 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgEEXUr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 19:20:47 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1AB78CED02
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 01:30:26 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/7] Bluetooth: Add support for experimental features configuration
Date:   Wed,  6 May 2020 01:20:38 +0200
Message-Id: <86afaa0c52ad28ff533c7c74769868c9063a3911.1588720791.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588720791.git.marcel@holtmann.org>
References: <cover.1588720791.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To enable platform specific experimental features, introduce this new set of
management commands and events.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h  |  1 +
 include/net/bluetooth/mgmt.h | 27 ++++++++++++++
 net/bluetooth/mgmt.c         | 71 ++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e5bc1dfe809a..16ab6ce87883 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -258,6 +258,7 @@ enum {
 	HCI_MGMT_DEV_CLASS_EVENTS,
 	HCI_MGMT_LOCAL_NAME_EVENTS,
 	HCI_MGMT_OOB_DATA_EVENTS,
+	HCI_MGMT_EXP_FEATURE_EVENTS,
 };
 
 /*
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9d4d87c6028e..16e0d87bd8fa 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -681,6 +681,27 @@ struct mgmt_rp_read_security_info {
 	__u8     sec[];
 } __packed;
 
+#define MGMT_OP_READ_EXP_FEATURES_INFO	0x0049
+#define MGMT_READ_EXP_FEATURES_INFO_SIZE 0
+struct mgmt_rp_read_exp_features_info {
+	__le16 feature_count;
+	struct {
+		__u8   uuid[16];
+		__le32 flags;
+	} features[];
+} __packed;
+
+#define MGMT_OP_SET_EXP_FEATURE		0x004a
+struct mgmt_cp_set_exp_feature {
+	__u8   uuid[16];
+	__u8   param[];
+} __packed;
+#define MGMT_SET_EXP_FEATURE_SIZE	16
+struct mgmt_rp_set_exp_feature {
+	__u8   uuid[16];
+	__le32 flags;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -906,3 +927,9 @@ struct mgmt_ev_ext_info_changed {
 struct mgmt_ev_phy_configuration_changed {
 	__le32	selected_phys;
 } __packed;
+
+#define MGMT_EV_EXP_FEATURE_CHANGED	0x0027
+struct mgmt_ev_exp_feature_changed {
+	__u8	uuid[16];
+	__le32	flags;
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 78cf72b64014..df85ad5c827a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -109,6 +109,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_BLOCKED_KEYS,
 	MGMT_OP_SET_WIDEBAND_SPEECH,
 	MGMT_OP_READ_SECURITY_INFO,
+	MGMT_OP_READ_EXP_FEATURES_INFO,
+	MGMT_OP_SET_EXP_FEATURE,
 };
 
 static const u16 mgmt_events[] = {
@@ -148,6 +150,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_ADVERTISING_REMOVED,
 	MGMT_EV_EXT_INFO_CHANGED,
 	MGMT_EV_PHY_CONFIGURATION_CHANGED,
+	MGMT_EV_EXP_FEATURE_CHANGED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -158,6 +161,7 @@ static const u16 mgmt_untrusted_commands[] = {
 	MGMT_OP_READ_EXT_INDEX_LIST,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_READ_SECURITY_INFO,
+	MGMT_OP_READ_EXP_FEATURES_INFO,
 };
 
 static const u16 mgmt_untrusted_events[] = {
@@ -172,6 +176,7 @@ static const u16 mgmt_untrusted_events[] = {
 	MGMT_EV_EXT_INDEX_ADDED,
 	MGMT_EV_EXT_INDEX_REMOVED,
 	MGMT_EV_EXT_INFO_CHANGED,
+	MGMT_EV_EXP_FEATURE_CHANGED,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -3710,6 +3715,66 @@ static int read_security_info(struct sock *sk, struct hci_dev *hdev,
 				 rp, sizeof(*rp) + sec_len);
 }
 
+static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
+				  void *data, u16 data_len)
+{
+	char buf[42];
+	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
+	u16 idx = 0;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	memset(&buf, 0, sizeof(buf));
+
+	rp->feature_count = cpu_to_le16(idx);
+
+	/* After reading the experimental features information, enable
+	 * the events to update client on any future change.
+	 */
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+	return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
+				 MGMT_OP_READ_EXP_FEATURES_INFO,
+				 0, rp, sizeof(*rp) + (20 * idx));
+}
+
+static int exp_debug_feature_changed(bool enabled, struct sock *skip)
+{
+	struct mgmt_ev_exp_feature_changed ev;
+
+	memset(&ev, 0, sizeof(ev));
+	memcpy(ev.uuid, debug_uuid, 16);
+	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
+
+	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
+				  &ev, sizeof(ev),
+				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
+}
+
+static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
+			   void *data, u16 data_len)
+{
+	struct mgmt_cp_set_exp_feature *cp = data;
+	struct mgmt_rp_set_exp_feature rp;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	if (!memcmp(cp->uuid, ZERO_KEY, 16)) {
+		memset(rp.uuid, 0, 16);
+		rp.flags = cpu_to_le32(0);
+
+		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+		return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
+					 MGMT_OP_SET_EXP_FEATURE, 0,
+					 &rp, sizeof(rp));
+	}
+
+	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
+			       MGMT_OP_SET_EXP_FEATURE,
+			       MGMT_STATUS_NOT_SUPPORTED);
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -7152,6 +7217,12 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_wideband_speech,	   MGMT_SETTING_SIZE },
 	{ read_security_info,      MGMT_READ_SECURITY_INFO_SIZE,
 						HCI_MGMT_UNTRUSTED },
+	{ read_exp_features_info,  MGMT_READ_EXP_FEATURES_INFO_SIZE,
+						HCI_MGMT_UNTRUSTED |
+						HCI_MGMT_HDEV_OPTIONAL },
+	{ set_exp_feature,         MGMT_SET_EXP_FEATURE_SIZE,
+						HCI_MGMT_VAR_LEN |
+						HCI_MGMT_HDEV_OPTIONAL },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.26.2

