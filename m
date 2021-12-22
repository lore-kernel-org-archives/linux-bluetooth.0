Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9881C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhLVUWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345410AbhLVUWH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 15:22:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B288AC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 196so3328752pfw.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y9FEDJYzS+cGZ95d3rcBmAMGdImhD9c6MymXhPf/dJ0=;
        b=O5rM+FTYHjZGvuH+2w2bhuaNPqEWLngcT5NuP9fy7n822DMIg2qw4D/8OEGAHyy73a
         oW44ECgomIT0x/ekwxJVih+yUdKMMDnT9zMkkLm0v5fbj3qeXRLlrajVIBm34OAgMVch
         lswC9PZwnerWyYJGWHFYY7IgloOUpJ8pYAyqbv5kroQT63P6GanNyhYAjjNYsXqRArFq
         s3aar/SItmnGFqO59sW4C44v0Sl+nirllBAQAN7IWAIxtPoTWt4s3f3MMnJEh3r2feRB
         ANTE39q5TRvjf/oR7kq0RBTFQtsShzm6MCdlb7UT557LtCBOooDEpk/fN9o1mAztId6r
         E05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9FEDJYzS+cGZ95d3rcBmAMGdImhD9c6MymXhPf/dJ0=;
        b=tipe/iFhImbaOJfE5nNznJalmimmEI0w0MWfokGQ/k6TiONwINO7Ohkb8uEXFAaYov
         BU9XmDcgaEF+zCUS4QTyzaIhk+LyGGXJCkT6/rNqHM7qs3jlNDq2Mb3eIKQmymARQ3vW
         wUCsmbjOD6UrnKkdApiz4dS77e/1m5I2+Y0g1mP5CDC7neIrU3ZhBajKBjIwDbhXYWQC
         7HRlTAtUdrQumFMLJk0sB+8sWtY0G2Ao7A6XMm+tPpGsd0BVTTrvAifhVSIBRae1rYyc
         MvY4LxwYSfNiFU3/ypPA4BPCnBa5m9yAWHPBOVrrLdBGJU9iESOzE4vp0u9A20RjcZXd
         W9jA==
X-Gm-Message-State: AOAM530ZsepIu2zrrGDOqxqk6O3+YJ6j/rDSFIymIc/h58V/eiD558+U
        8f/5hM5hWcQHP6m3Y8eaCfMSXCKrXXs=
X-Google-Smtp-Source: ABdhPJzpNqmT9icGc+fRstEYwV04llXQHKlUfzUQoziHX4yju1RAIlfs52RtZTvrbqapjmFEDa8ZGw==
X-Received: by 2002:a62:8042:0:b0:4a8:15eb:db10 with SMTP id j63-20020a628042000000b004a815ebdb10mr4826688pfd.28.1640204526740;
        Wed, 22 Dec 2021 12:22:06 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x25sm1285266pfu.113.2021.12.22.12.22.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:22:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 5/6] Bluetooth: MGMT: Fix LE simultaneous roles UUID if not supported
Date:   Wed, 22 Dec 2021 12:22:00 -0800
Message-Id: <20211222202201.977779-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222202201.977779-1-luiz.dentz@gmail.com>
References: <20211222202201.977779-1-luiz.dentz@gmail.com>
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
index 61d8a076a3f3..0feb68f12545 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5197,12 +5197,12 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
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
@@ -5214,8 +5214,8 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
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

