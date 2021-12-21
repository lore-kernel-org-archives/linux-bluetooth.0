Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577AFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 22:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbhLUWeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 17:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbhLUWeD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 17:34:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2323C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:34:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3915427pja.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i4c+OkZqK8xy0FDxlDGdXHUXP3WrkkWpTGWZicu9RTU=;
        b=lJAsJ7NsCbVD3LQOXYSWUdejrVKGzFBGOwD019A/MIzsNM+XJnC6ryP8ZeWsmEDov3
         Qy8nQTU7sKaHPFGE7d4dKfzkUci36oAkWYH/32HGKtvhVornBIMEovZIKhxoKDtwmrLe
         h4sgQ7tqECpqvsEJlfHZ+ro/VqZ9JoAVr7Er3sgyad93YlcCtxasslk5KQRvqhZ4PYVd
         SzOAY2J5d4KT5jWKc0NhbawvfTDv797Pc140uIFt03LbvlQp2uGpq0rgzcKC0RO2TyLR
         hxBp2+P8dQCPUZKW7m8MNg29z58wAEjkwPcYQnvQRmnGUP5BFmLF8IMzyMf2cgPUmSNh
         0fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4c+OkZqK8xy0FDxlDGdXHUXP3WrkkWpTGWZicu9RTU=;
        b=q853CK2LC9haSIkNhjvzaPCjwXNcAOykh5eADm9Hf/0XVIIVVzIkXwmaSib8UBUusZ
         Y1VgbW32FWoPt44lAGlbo5dPzFNE+m80XLp0Dqses6Iz03zOq02amg1wiToLP06kb60F
         xB8bFa3ER2fNV4uqJ8VpOuXbV7dCWe//cq+5RCw25hDxmF6bxu/qj0/wjH8rm/HNqox1
         OzzigfBYHDmrOxtmUZwSDUCzZoh/VUm/LLEWN8Zb1vNSP3FkObmobri1v0KEBfG5iWtY
         skQvKflc6pyfrMB39ngrsyzPbSvNtgN8iyorgrzmwQHQ7h7tSQezidRYakyBLv6P5HmG
         m7gQ==
X-Gm-Message-State: AOAM531IWBMC33f3EFSDoOx3AEzYdb1NXYVp3zh/dE90DuZ+v+3iyyro
        shX9UvdNtmFPD2YZ+lAIgywY/ERu8U4=
X-Google-Smtp-Source: ABdhPJz59/e8XekAteMKQXwp9FE8N2+O7bnEl/93QEAZXiUYEDl46wQNwL25Jt/PIcdwiMEhsFJqKQ==
X-Received: by 2002:a17:902:6a8a:b0:143:905f:aec7 with SMTP id n10-20020a1709026a8a00b00143905faec7mr162000plk.8.1640126042030;
        Tue, 21 Dec 2021 14:34:02 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id np1sm3872209pjb.22.2021.12.21.14.34.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 14:34:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/4] Bluetooth: MGMT: Fix LE simultaneous roles UUID if not supported
Date:   Tue, 21 Dec 2021 14:33:57 -0800
Message-Id: <20211221223357.742863-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211221223357.742863-1-luiz.dentz@gmail.com>
References: <20211221223357.742863-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If controller/driver don't support LE simultaneous roles its UUID shall
be omitted when responding to MGMT_OP_READ_EXP_FEATURES_INFO.

This also rework the support introducing HCI_LE_SIMULTANEOUS_ROLES flag
so it can be detected when userspace wants to use or not.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |   1 +
 net/bluetooth/hci_sync.c    |  10 ++--
 net/bluetooth/mgmt.c        | 114 +++++++++++++++++++++++-------------
 3 files changed, 78 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7f5f00ff53da..e2b06bb79e2e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -341,6 +341,7 @@ enum {
 	HCI_FORCE_NO_MITM,
 	HCI_QUALITY_REPORT,
 	HCI_OFFLOAD_CODECS_ENABLED,
+	HCI_LE_SIMULTANEOUS_ROLES,
 
 	__HCI_NUM_FLAGS,
 };
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6abcf966d001..7565238f2b58 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5172,12 +5172,12 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
 	/* If requested to connect as peripheral use directed advertising */
 	if (conn->role == HCI_ROLE_SLAVE) {
-		/* If we're active scanning and the controller doesn't support
-		 * simultaneous roles simply reject the attempt.
+		/* If we're active scanning and simultaneous roles is not
+		 * enabled simply reject the attempt.
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
-		    !hci_dev_le_state_simultaneous(hdev)) {
+		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
 			hci_conn_del(conn);
 			return -EBUSY;
 		}
@@ -5189,8 +5189,8 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 		goto done;
 	}
 
-	/* Disable advertising if simultaneous roles is not supported. */
-	if (!hci_dev_le_state_simultaneous(hdev))
+	/* Disable advertising if simultaneous roles is not in use. */
+	if (!hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
 		hci_pause_advertising_sync(hdev);
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3326d9459dd3..6f192efd9da0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3882,7 +3882,7 @@ static const u8 offload_codecs_uuid[16] = {
 };
 
 /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
-static const u8 simult_central_periph_uuid[16] = {
+static const u8 le_simultaneous_roles_uuid[16] = {
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
 	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
 };
@@ -3915,13 +3915,13 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
-	if (hdev) {
-		if (hci_dev_le_state_simultaneous(hdev))
+	if (hdev && hci_dev_le_state_simultaneous(hdev)) {
+		if (hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
 			flags = BIT(0);
 		else
 			flags = 0;
 
-		memcpy(rp->features[idx].uuid, simult_central_periph_uuid, 16);
+		memcpy(rp->features[idx].uuid, le_simultaneous_roles_uuid, 16);
 		rp->features[idx].flags = cpu_to_le32(flags);
 		idx++;
 	}
@@ -3992,29 +3992,13 @@ static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
 
 }
 
-#ifdef CONFIG_BT_FEATURE_DEBUG
-static int exp_debug_feature_changed(bool enabled, struct sock *skip)
-{
-	struct mgmt_ev_exp_feature_changed ev;
-
-	memset(&ev, 0, sizeof(ev));
-	memcpy(ev.uuid, debug_uuid, 16);
-	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
-
-	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
-				  &ev, sizeof(ev),
-				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
-}
-#endif
-
-static int exp_quality_report_feature_changed(bool enabled,
-					      struct hci_dev *hdev,
-					      struct sock *skip)
+static int exp_feature_changed(struct hci_dev *hdev, const u8 *uuid,
+			       bool enabled, struct sock *skip)
 {
 	struct mgmt_ev_exp_feature_changed ev;
 
 	memset(&ev, 0, sizeof(ev));
-	memcpy(ev.uuid, quality_report_uuid, 16);
+	memcpy(ev.uuid, uuid, 16);
 	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
 
 	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
@@ -4044,7 +4028,7 @@ static int set_zero_key_func(struct sock *sk, struct hci_dev *hdev,
 		bt_dbg_set(false);
 
 		if (changed)
-			exp_debug_feature_changed(false, sk);
+			exp_feature_changed(NULL, ZERO_KEY, false, sk);
 	}
 #endif
 
@@ -4054,7 +4038,8 @@ static int set_zero_key_func(struct sock *sk, struct hci_dev *hdev,
 		changed = hci_dev_test_and_clear_flag(hdev,
 						      HCI_ENABLE_LL_PRIVACY);
 		if (changed)
-			exp_ll_privacy_feature_changed(false, hdev, sk);
+			exp_feature_changed(hdev, rpa_resolution_uuid, false,
+					    sk);
 	}
 
 	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
@@ -4105,7 +4090,7 @@ static int set_debug_func(struct sock *sk, struct hci_dev *hdev,
 				&rp, sizeof(rp));
 
 	if (changed)
-		exp_debug_feature_changed(val, sk);
+		exp_feature_changed(hdev, debug_uuid, val, sk);
 
 	return err;
 }
@@ -4243,27 +4228,13 @@ static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 				&rp, sizeof(rp));
 
 	if (changed)
-		exp_quality_report_feature_changed(val, hdev, sk);
+		exp_feature_changed(hdev, quality_report_uuid, val, sk);
 
 unlock_quality_report:
 	hci_req_sync_unlock(hdev);
 	return err;
 }
 
-static int exp_offload_codec_feature_changed(bool enabled, struct hci_dev *hdev,
-					     struct sock *skip)
-{
-	struct mgmt_ev_exp_feature_changed ev;
-
-	memset(&ev, 0, sizeof(ev));
-	memcpy(ev.uuid, offload_codecs_uuid, 16);
-	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
-
-	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
-				  &ev, sizeof(ev),
-				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
-}
-
 static int set_offload_codec_func(struct sock *sk, struct hci_dev *hdev,
 				  struct mgmt_cp_set_exp_feature *cp,
 				  u16 data_len)
@@ -4317,7 +4288,65 @@ static int set_offload_codec_func(struct sock *sk, struct hci_dev *hdev,
 				&rp, sizeof(rp));
 
 	if (changed)
-		exp_offload_codec_feature_changed(val, hdev, sk);
+		exp_feature_changed(hdev, offload_codecs_uuid, val, sk);
+
+	return err;
+}
+
+static int set_le_simultaneous_roles_func(struct sock *sk, struct hci_dev *hdev,
+					  struct mgmt_cp_set_exp_feature *cp,
+					  u16 data_len)
+{
+	bool val, changed;
+	int err;
+	struct mgmt_rp_set_exp_feature rp;
+
+	/* Command requires to use a valid controller index */
+	if (!hdev)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_INDEX);
+
+	/* Parameters are limited to a single octet */
+	if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	/* Only boolean on/off is supported */
+	if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	val = !!cp->param[0];
+	changed = (val != hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES));
+
+	if (!hci_dev_le_state_simultaneous(hdev)) {
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_NOT_SUPPORTED);
+	}
+
+	if (changed) {
+		if (val)
+			hci_dev_set_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES);
+		else
+			hci_dev_clear_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES);
+	}
+
+	bt_dev_info(hdev, "LE simultanous roles enable %d changed %d",
+		    val, changed);
+
+	memcpy(rp.uuid, le_simultaneous_roles_uuid, 16);
+	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
+
+	if (changed)
+		exp_feature_changed(hdev, le_simultaneous_roles_uuid, val, sk);
 
 	return err;
 }
@@ -4334,6 +4363,7 @@ static const struct mgmt_exp_feature {
 	EXP_FEAT(rpa_resolution_uuid, set_rpa_resolution_func),
 	EXP_FEAT(quality_report_uuid, set_quality_report_func),
 	EXP_FEAT(offload_codecs_uuid, set_offload_codec_func),
+	EXP_FEAT(le_simultaneous_roles_uuid, set_le_simultaneous_roles_func),
 
 	/* end with a null feature */
 	EXP_FEAT(NULL, NULL)
-- 
2.33.1

