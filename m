Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2586DC433E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB102083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgG3JOc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:14:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39750 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbgG3JOb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 05:14:31 -0400
Received: from localhost.localdomain (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1E670CECF9
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2020 11:24:29 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Enable controller RPA resolution using Experimental feature
Date:   Thu, 30 Jul 2020 11:14:21 +0200
Message-Id: <20200730091421.48847-8-marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <nsathish41@gmail.com>

This patch adds support to enable the use of RPA Address resolution
using expermental feature mgmt command.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |   1 +
 net/bluetooth/hci_event.c   |   1 +
 net/bluetooth/hci_request.c |   7 +-
 net/bluetooth/mgmt.c        | 142 +++++++++++++++++++++++++++++++++++-
 4 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index dd82cce77a7a..c8e67042a3b1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -318,6 +318,7 @@ enum {
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 	HCI_LL_RPA_RESOLUTION,
+	HCI_ENABLE_LL_PRIVACY,
 	HCI_CMD_PENDING,
 	HCI_FORCE_NO_MITM,
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 628831b15c0a..33d8458fdd4a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5230,6 +5230,7 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->supervision_timeout));
 
 	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
 		hci_req_disable_address_resolution(hdev);
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 70e077cc7dfa..435400a43a78 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -678,8 +678,10 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 
 	/* Disable address resolution */
 	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
 		__u8 enable = 0x00;
+
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
 }
@@ -870,8 +872,11 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		return;
 	}
 
-	if (use_ll_privacy(hdev) && addr_resolv) {
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
+	    addr_resolv) {
 		u8 enable = 0x01;
+
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 47bcfe2fb14c..4ec0fee80344 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -795,10 +795,15 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 
 	if (lmp_le_capable(hdev)) {
 		settings |= MGMT_SETTING_LE;
-		settings |= MGMT_SETTING_ADVERTISING;
 		settings |= MGMT_SETTING_SECURE_CONN;
 		settings |= MGMT_SETTING_PRIVACY;
 		settings |= MGMT_SETTING_STATIC_ADDRESS;
+
+		/* When the experimental feature for LL Privacy support is
+		 * enabled, then advertising is no longer supported.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+			settings |= MGMT_SETTING_ADVERTISING;
 	}
 
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
@@ -3759,10 +3764,16 @@ static const u8 simult_central_periph_uuid[16] = {
 	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
 };
 
+/* 15c0a148-c273-11ea-b3de-0242ac130004 */
+static const u8 rpa_resolution_uuid[16] = {
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
+	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[44];
+	char buf[62];	/* Enough space for 3 features */
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 	u32 flags;
@@ -3795,6 +3806,17 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+	if (hdev && use_ll_privacy(hdev)) {
+		if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+			flags = BIT(0) | BIT(1);
+		else
+			flags = BIT(1);
+
+		memcpy(rp->features[idx].uuid, rpa_resolution_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -3807,6 +3829,21 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				 0, rp, sizeof(*rp) + (20 * idx));
 }
 
+static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
+					  struct sock *skip)
+{
+	struct mgmt_ev_exp_feature_changed ev;
+
+	memset(&ev, 0, sizeof(ev));
+	memcpy(ev.uuid, rpa_resolution_uuid, 16);
+	ev.flags = cpu_to_le32((enabled ? BIT(0) : 0) | BIT(1));
+
+	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
+				  &ev, sizeof(ev),
+				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
+
+}
+
 #ifdef CONFIG_BT_FEATURE_DEBUG
 static int exp_debug_feature_changed(bool enabled, struct sock *skip)
 {
@@ -3845,6 +3882,16 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 		}
 #endif
 
+		if (hdev && use_ll_privacy(hdev) && !hdev_is_powered(hdev)) {
+			bool changed = hci_dev_test_flag(hdev,
+							 HCI_ENABLE_LL_PRIVACY);
+
+			hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+
+			if (changed)
+				exp_ll_privacy_feature_changed(false, hdev, sk);
+		}
+
 		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
 
 		return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
@@ -3895,6 +3942,69 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
+	if (!memcmp(cp->uuid, rpa_resolution_uuid, 16)) {
+		bool val, changed;
+		int err;
+		u32 flags;
+
+		/* Command requires to use the controller index */
+		if (!hdev)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_INDEX);
+
+		/* Changes can only be made when controller is powered down */
+		if (hdev_is_powered(hdev))
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_NOT_POWERED);
+
+		/* Parameters are limited to a single octet */
+		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		/* Only boolean on/off is supported */
+		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		val = !!cp->param[0];
+
+		if (val) {
+			changed = !hci_dev_test_flag(hdev,
+						     HCI_ENABLE_LL_PRIVACY);
+			hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+			hci_dev_clear_flag(hdev, HCI_ADVERTISING);
+
+			/* Enable LL privacy + supported settings changed */
+			flags = BIT(0) | BIT(1);
+		} else {
+			changed = hci_dev_test_flag(hdev,
+						    HCI_ENABLE_LL_PRIVACY);
+			hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+
+			/* Disable LL privacy + supported settings changed */
+			flags = BIT(1);
+		}
+
+		memcpy(rp.uuid, rpa_resolution_uuid, 16);
+		rp.flags = cpu_to_le32(flags);
+
+		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_SET_EXP_FEATURE, 0,
+					&rp, sizeof(rp));
+
+		if (changed)
+			exp_ll_privacy_feature_changed(val, hdev, sk);
+
+		return err;
+	}
+
 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 			       MGMT_OP_SET_EXP_FEATURE,
 			       MGMT_STATUS_NOT_SUPPORTED);
@@ -5040,6 +5150,13 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
 				       status);
 
+	/* Enabling the experimental LL Privay support disables support for
+	 * advertising.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
@@ -7112,6 +7229,13 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_ADV_FEATURES,
 				       MGMT_STATUS_REJECTED);
 
+	/* Enabling the experimental LL Privay support disables support for
+	 * advertising.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	hci_dev_lock(hdev);
 
 	rp_len = sizeof(*rp) + hdev->adv_instance_cnt;
@@ -7315,6 +7439,13 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       status);
 
+	/* Enabling the experimental LL Privay support disables support for
+	 * advertising.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	if (cp->instance < 1 || cp->instance > HCI_MAX_ADV_INSTANCES)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
@@ -7479,6 +7610,13 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
+	/* Enabling the experimental LL Privay support disables support for
+	 * advertising.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	hci_dev_lock(hdev);
 
 	if (cp->instance && !hci_find_adv_instance(hdev, cp->instance)) {
-- 
2.26.2

