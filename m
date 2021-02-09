Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B41C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B2B64ECC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhBINiq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:38:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34042 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhBINiE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 08:38:04 -0500
Received: from [123.112.66.2] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1l9TCh-00050T-Ni; Tue, 09 Feb 2021 13:37:20 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@intel.com, luiz.dentz@gmail.com
Subject: [PATCH 2/3] Bluetooth: make experimental features expand easier
Date:   Tue,  9 Feb 2021 21:36:27 +0800
Message-Id: <20210209133629.12784-3-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209133629.12784-1-hui.wang@canonical.com>
References: <20210209133629.12784-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

So far there are 3 experimental features in total, if users want to
add new features, they need to write code in the function
read_exp_features_info() and set_exp_feature(), this will make these
2 functions larger and larger.

After using the struct exp_feature, users just need to implement
feature specific read and set function and insert an exp_feature entry
into the exp_feature_list[].

This patch converts the current 3 exp features to the exp_feature
entries, no function change for them.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 net/bluetooth/mgmt.c | 379 ++++++++++++++++++++++++-------------------
 1 file changed, 214 insertions(+), 165 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fa0f7a4a1d2f..4ac85e24906b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3774,12 +3774,94 @@ static int read_controller_cap(struct sock *sk, struct hci_dev *hdev,
 				 rp, sizeof(*rp) + cap_len);
 }
 
+struct exp_feature {
+	const u8 *uuid;
+	void (*read_info)(struct hci_dev *hdev, const u8 *uuid, u16 *idx,
+			  struct mgmt_rp_read_exp_features_info *rp);
+	int (*set_info)(struct sock *sk, struct hci_dev *hdev, const u8 *uuid,
+			u16 data_len, struct mgmt_cp_set_exp_feature *cp);
+};
+
+#define EXP_FEATURE_ENTRY(_uuid, _read_info_func, _set_info_func)	\
+	{ .uuid = (_uuid), .read_info = (_read_info_func), \
+	  .set_info = (_set_info_func) }
+
 #ifdef CONFIG_BT_FEATURE_DEBUG
 /* d4992530-b9ec-469f-ab01-6c481c47da1c */
 static const u8 debug_uuid[16] = {
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
 	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
 };
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
+static void exp_read_debug_info(struct hci_dev *hdev, const u8 *uuid, u16 *idx,
+				struct mgmt_rp_read_exp_features_info *rp)
+{
+	u32 flags;
+
+	if (hdev)
+		return;
+
+	flags = bt_dbg_get() ? BIT(0) : 0;
+	memcpy(rp->features[*idx].uuid, uuid, 16);
+	rp->features[(*idx)++].flags = cpu_to_le32(flags);
+}
+
+static int exp_set_debug(struct sock *sk, struct hci_dev *hdev, const u8 *uuid,
+			 u16 data_len, struct mgmt_cp_set_exp_feature *cp)
+{
+	struct mgmt_rp_set_exp_feature rp;
+	bool val, changed;
+	int err;
+
+	/* Command requires to use the non-controller index */
+	if (hdev)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_INDEX);
+
+	/* Parameters are limited to a single octet */
+	if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	/* Only boolean on/off is supported */
+	if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	val = !!cp->param[0];
+	changed = val ? !bt_dbg_get() : bt_dbg_get();
+	bt_dbg_set(val);
+
+	memcpy(rp.uuid, uuid, 16);
+	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
+
+	if (changed)
+		exp_debug_feature_changed(val, sk);
+
+	return err;
+}
 #endif
 
 /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
@@ -3794,41 +3876,43 @@ static const u8 rpa_resolution_uuid[16] = {
 	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
 };
 
-static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
-				  void *data, u16 data_len)
+static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
+					  struct sock *skip)
 {
-	char buf[62];	/* Enough space for 3 features */
-	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
-	u16 idx = 0;
-	u32 flags;
+	struct mgmt_ev_exp_feature_changed ev;
 
-	bt_dev_dbg(hdev, "sock %p", sk);
+	memset(&ev, 0, sizeof(ev));
+	memcpy(ev.uuid, rpa_resolution_uuid, 16);
+	ev.flags = cpu_to_le32((enabled ? BIT(0) : 0) | BIT(1));
 
-	memset(&buf, 0, sizeof(buf));
+	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
+				  &ev, sizeof(ev),
+				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
+}
 
-#ifdef CONFIG_BT_FEATURE_DEBUG
-	if (!hdev) {
-		flags = bt_dbg_get() ? BIT(0) : 0;
+static void exp_read_le_status(struct hci_dev *hdev, const u8 *uuid, u16 *idx,
+			       struct mgmt_rp_read_exp_features_info *rp)
+{
+	u32 flags;
 
-		memcpy(rp->features[idx].uuid, debug_uuid, 16);
-		rp->features[idx].flags = cpu_to_le32(flags);
-		idx++;
-	}
-#endif
+	if (!hdev)
+		return;
+	if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
+	    (hdev->le_states[4] & 0x08) &&	/* Central */
+	    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
+	    (hdev->le_states[3] & 0x10))	/* Simultaneous */
+		flags = BIT(0);
+	else
+		flags = 0;
 
-	if (hdev) {
-		if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
-		    (hdev->le_states[4] & 0x08) &&	/* Central */
-		    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
-		    (hdev->le_states[3] & 0x10))	/* Simultaneous */
-			flags = BIT(0);
-		else
-			flags = 0;
+	memcpy(rp->features[*idx].uuid, uuid, 16);
+	rp->features[(*idx)++].flags = cpu_to_le32(flags);
+}
 
-		memcpy(rp->features[idx].uuid, simult_central_periph_uuid, 16);
-		rp->features[idx].flags = cpu_to_le32(flags);
-		idx++;
-	}
+static void exp_read_rpa_resolution(struct hci_dev *hdev, const u8 *uuid, u16 *idx,
+				    struct mgmt_rp_read_exp_features_info *rp)
+{
+	u32 flags;
 
 	if (hdev && use_ll_privacy(hdev)) {
 		if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
@@ -3836,62 +3920,128 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		else
 			flags = BIT(1);
 
-		memcpy(rp->features[idx].uuid, rpa_resolution_uuid, 16);
-		rp->features[idx].flags = cpu_to_le32(flags);
-		idx++;
+		memcpy(rp->features[*idx].uuid, uuid, 16);
+		rp->features[(*idx)++].flags = cpu_to_le32(flags);
 	}
+}
 
-	rp->feature_count = cpu_to_le16(idx);
+static int exp_set_rpa_resolution(struct sock *sk, struct hci_dev *hdev,
+				  const u8 *uuid, u16 data_len,
+				  struct mgmt_cp_set_exp_feature *cp)
+{
+	struct mgmt_rp_set_exp_feature rp;
+	bool val, changed;
+	int err;
+	u32 flags;
 
-	/* After reading the experimental features information, enable
-	 * the events to update client on any future change.
-	 */
-	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	/* Command requires to use the controller index */
+	if (!hdev)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_INDEX);
 
-	return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
-				 MGMT_OP_READ_EXP_FEATURES_INFO,
-				 0, rp, sizeof(*rp) + (20 * idx));
-}
+	/* Changes can only be made when controller is powered down */
+	if (hdev_is_powered(hdev))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_NOT_POWERED);
 
-static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
-					  struct sock *skip)
-{
-	struct mgmt_ev_exp_feature_changed ev;
+	/* Parameters are limited to a single octet */
+	if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
 
-	memset(&ev, 0, sizeof(ev));
-	memcpy(ev.uuid, rpa_resolution_uuid, 16);
-	ev.flags = cpu_to_le32((enabled ? BIT(0) : 0) | BIT(1));
+	/* Only boolean on/off is supported */
+	if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
 
-	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
-				  &ev, sizeof(ev),
-				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
+	val = !!cp->param[0];
+
+	if (val) {
+		changed = !hci_dev_test_flag(hdev,
+					     HCI_ENABLE_LL_PRIVACY);
+		hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
+
+		/* Enable LL privacy + supported settings changed */
+		flags = BIT(0) | BIT(1);
+	} else {
+		changed = hci_dev_test_flag(hdev,
+					    HCI_ENABLE_LL_PRIVACY);
+		hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+
+		/* Disable LL privacy + supported settings changed */
+		flags = BIT(1);
+	}
+
+	memcpy(rp.uuid, uuid, 16);
+	rp.flags = cpu_to_le32(flags);
+
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+	err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
 
+	if (changed)
+		exp_ll_privacy_feature_changed(val, hdev, sk);
+
+	return err;
 }
 
+static const struct exp_feature exp_feature_list[] = {
 #ifdef CONFIG_BT_FEATURE_DEBUG
-static int exp_debug_feature_changed(bool enabled, struct sock *skip)
+	EXP_FEATURE_ENTRY(debug_uuid, exp_read_debug_info,
+			  exp_set_debug),
+#endif
+	EXP_FEATURE_ENTRY(simult_central_periph_uuid, exp_read_le_status,
+			  NULL),
+	EXP_FEATURE_ENTRY(rpa_resolution_uuid, exp_read_rpa_resolution,
+			  exp_set_rpa_resolution),
+	{}
+};
+
+static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
+				  void *data, u16 data_len)
 {
-	struct mgmt_ev_exp_feature_changed ev;
+	char buf[62] = {0}; /* Enough space for 3 features */
+	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
+	u16 idx = 0;
+	int i;
 
-	memset(&ev, 0, sizeof(ev));
-	memcpy(ev.uuid, debug_uuid, 16);
-	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
+	bt_dev_dbg(hdev, "sock %p", sk);
 
-	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
-				  &ev, sizeof(ev),
-				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
+	for (i = 0; exp_feature_list[i].uuid; i++)
+		if (exp_feature_list[i].read_info)
+			exp_feature_list[i].read_info(hdev,
+						      exp_feature_list[i].uuid,
+						      &idx, rp);
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
 }
-#endif
 
 static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 data_len)
 {
 	struct mgmt_cp_set_exp_feature *cp = data;
-	struct mgmt_rp_set_exp_feature rp;
+	int i;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
 	if (!memcmp(cp->uuid, ZERO_KEY, 16)) {
+		struct mgmt_rp_set_exp_feature rp;
+
 		memset(rp.uuid, 0, 16);
 		rp.flags = cpu_to_le32(0);
 
@@ -3923,111 +4073,10 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 					 &rp, sizeof(rp));
 	}
 
-#ifdef CONFIG_BT_FEATURE_DEBUG
-	if (!memcmp(cp->uuid, debug_uuid, 16)) {
-		bool val, changed;
-		int err;
-
-		/* Command requires to use the non-controller index */
-		if (hdev)
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_SET_EXP_FEATURE,
-					       MGMT_STATUS_INVALID_INDEX);
-
-		/* Parameters are limited to a single octet */
-		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
-			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
-					       MGMT_OP_SET_EXP_FEATURE,
-					       MGMT_STATUS_INVALID_PARAMS);
-
-		/* Only boolean on/off is supported */
-		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
-			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
-					       MGMT_OP_SET_EXP_FEATURE,
-					       MGMT_STATUS_INVALID_PARAMS);
-
-		val = !!cp->param[0];
-		changed = val ? !bt_dbg_get() : bt_dbg_get();
-		bt_dbg_set(val);
-
-		memcpy(rp.uuid, debug_uuid, 16);
-		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
-
-		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
-
-		err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
-					MGMT_OP_SET_EXP_FEATURE, 0,
-					&rp, sizeof(rp));
-
-		if (changed)
-			exp_debug_feature_changed(val, sk);
-
-		return err;
-	}
-#endif
-
-	if (!memcmp(cp->uuid, rpa_resolution_uuid, 16)) {
-		bool val, changed;
-		int err;
-		u32 flags;
-
-		/* Command requires to use the controller index */
-		if (!hdev)
-			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
-					       MGMT_OP_SET_EXP_FEATURE,
-					       MGMT_STATUS_INVALID_INDEX);
-
-		/* Changes can only be made when controller is powered down */
-		if (hdev_is_powered(hdev))
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_SET_EXP_FEATURE,
-					       MGMT_STATUS_NOT_POWERED);
-
-		/* Parameters are limited to a single octet */
-		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_SET_EXP_FEATURE,
-					       MGMT_STATUS_INVALID_PARAMS);
-
-		/* Only boolean on/off is supported */
-		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_SET_EXP_FEATURE,
-					       MGMT_STATUS_INVALID_PARAMS);
-
-		val = !!cp->param[0];
-
-		if (val) {
-			changed = !hci_dev_test_flag(hdev,
-						     HCI_ENABLE_LL_PRIVACY);
-			hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
-			hci_dev_clear_flag(hdev, HCI_ADVERTISING);
-
-			/* Enable LL privacy + supported settings changed */
-			flags = BIT(0) | BIT(1);
-		} else {
-			changed = hci_dev_test_flag(hdev,
-						    HCI_ENABLE_LL_PRIVACY);
-			hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
-
-			/* Disable LL privacy + supported settings changed */
-			flags = BIT(1);
-		}
-
-		memcpy(rp.uuid, rpa_resolution_uuid, 16);
-		rp.flags = cpu_to_le32(flags);
-
-		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
-
-		err = mgmt_cmd_complete(sk, hdev->id,
-					MGMT_OP_SET_EXP_FEATURE, 0,
-					&rp, sizeof(rp));
-
-		if (changed)
-			exp_ll_privacy_feature_changed(val, hdev, sk);
-
-		return err;
-	}
+	for (i = 0; exp_feature_list[i].uuid; i++)
+		if (!memcmp(cp->uuid, exp_feature_list[i].uuid, 16))
+			return exp_feature_list[i].set_info(sk, hdev, exp_feature_list[i].uuid,
+							    data_len, cp);
 
 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 			       MGMT_OP_SET_EXP_FEATURE,
-- 
2.25.1

