Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F700C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 19:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbhLATxm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbhLATxW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 14:53:22 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4EC061759
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 11:49:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 133so6573000pgc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 11:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bo2BIEDwpDABIhYkv3IyMfc3XqHAILp2eanXerwhGoI=;
        b=hLtq7b0Qsu8dh0QBsecwhFYflnRfxJlyvMZD5OPPpFx2OKoV65d9l9WUwJSiI1NgKR
         NFi4eZ9IIPAOiFeCtdGgJwTZl11n21+cQuzQWI4XRbZ+vmriJUAPB/Nz409yjlOLzBYh
         jhE8RJ9jO/3kvWi2cw+ztnjCNvaUicZ1OUi5qgI/Ft2EZfZFLrSmuptcXYRifO8S11fQ
         crc9TLgiGSEndCbEsoBPTBF+/YLPDw1346kDWc21YFHAo9VcNwKatZlDFNY9H4YOvnY2
         x8ZDoNXxnn96ZuhmLjlfsN6Qs/kc4k7C/CtdHlxFBuqvw+y0RHh3r3KCsgz6FAQoGoPg
         sxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo2BIEDwpDABIhYkv3IyMfc3XqHAILp2eanXerwhGoI=;
        b=BEENdsXV0H3WB+WWUpH67YAfpEBof8tAOiKZ1x6tjraoI79t5dtIqVYBKyKKy0rNKK
         TZvb6HFG50Ck+xvYd68mS1qIz28oh2Etll9EZs/BESM6QiizcIwCEyrqUu/Vqo1vkULA
         27r1GlkFI0+p4d8186ptVMx4QPtxLY4siD6efEG1d7PulrDsmmvVxw5xTgk24njQtP59
         RwfPlaU/PhYzEH2/O+nONuPBIOzeB2O4ibY1i/BX9NhHmnbOTuBLeEP6WBivrzVPSGO3
         0dOsxVodjDz/v7aINBquJ/YVb43q/koJ/1U2eidH+KRfyDvYCoHTQwD8tbW/XaJR8ksy
         IXPw==
X-Gm-Message-State: AOAM533/ts2W8bLZd542jmyTw8LIdlmgk1I4J+pWqd0QEZlCuiKjqcwZ
        3u/sDaaINv+7b6dvjTzL+zFXEhZbhZY=
X-Google-Smtp-Source: ABdhPJysy9dUAY1h2OiTgUEykI/WwKvDuPi3Z9JpAo6vp1VyaptVo7RacJoAszQ3UIE/UbYDEpXCnQ==
X-Received: by 2002:a63:2b88:: with SMTP id r130mr6267479pgr.80.1638388194684;
        Wed, 01 Dec 2021 11:49:54 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ip6sm122208pjb.42.2021.12.01.11.49.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:49:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: hci_core: Rework hci_conn_params flags
Date:   Wed,  1 Dec 2021 11:49:50 -0800
Message-Id: <20211201194952.1537811-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201194952.1537811-1-luiz.dentz@gmail.com>
References: <20211201194952.1537811-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reworks hci_conn_params flags to use bitmap_* helpers and add
support for setting the supported flags in hdev->conn_flags so it can
easily be accessed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 24 ++++++++++++------------
 net/bluetooth/hci_core.c         |  8 +++++++-
 net/bluetooth/hci_request.c      |  4 ++--
 net/bluetooth/hci_sync.c         |  7 +++----
 net/bluetooth/mgmt.c             | 30 ++++++++++++++++++++----------
 5 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7bae8376fd6f..d1b67755a373 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -152,22 +152,21 @@ struct bdaddr_list_with_irk {
 	u8 local_irk[16];
 };
 
-struct bdaddr_list_with_flags {
-	struct list_head list;
-	bdaddr_t bdaddr;
-	u8 bdaddr_type;
-	u32 current_flags;
-};
-
 enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP,
-	HCI_CONN_FLAG_MAX
-};
 
-#define hci_conn_test_flag(nr, flags) ((flags) & (1U << nr))
+	__HCI_CONN_NUM_FLAGS,
+};
 
 /* Make sure number of flags doesn't exceed sizeof(current_flags) */
-static_assert(HCI_CONN_FLAG_MAX < 32);
+static_assert(__HCI_CONN_NUM_FLAGS < 32);
+
+struct bdaddr_list_with_flags {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+	DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
+};
 
 struct bt_uuid {
 	struct list_head list;
@@ -560,6 +559,7 @@ struct hci_dev {
 	struct rfkill		*rfkill;
 
 	DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
+	DECLARE_BITMAP(conn_flags, __HCI_CONN_NUM_FLAGS);
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_EXT_AD_LENGTH];
@@ -755,7 +755,7 @@ struct hci_conn_params {
 
 	struct hci_conn *conn;
 	bool explicit_connect;
-	u32 current_flags;
+	DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
 };
 
 extern struct list_head hci_dev_list;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdc0dcf8ee36..7c4af0b34b62 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2153,7 +2153,7 @@ int hci_bdaddr_list_add_with_flags(struct list_head *list, bdaddr_t *bdaddr,
 
 	bacpy(&entry->bdaddr, bdaddr);
 	entry->bdaddr_type = type;
-	entry->current_flags = flags;
+	bitmap_from_u64(entry->flags, flags);
 
 	list_add(&entry->list, list);
 
@@ -2629,6 +2629,12 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
 
+	/* Mark Remote Wakeup connection flag as supported if driver has wakeup
+	 * callback.
+	 */
+	if (hdev->wakeup)
+		set_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, hdev->conn_flags);
+
 	hci_sock_dev_event(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8b3205e4b23e..fee88214606e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -492,8 +492,8 @@ static int add_to_accept_list(struct hci_request *req,
 	}
 
 	/* During suspend, only wakeable devices can be in accept list */
-	if (hdev->suspended && !hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
-						   params->current_flags))
+	if (hdev->suspended &&
+	    !test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, params->flags))
 		return 0;
 
 	*num_entries += 1;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ad86caf41f91..5f44ff0b8910 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1606,8 +1606,8 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 	}
 
 	/* During suspend, only wakeable devices can be in acceptlist */
-	if (hdev->suspended && !hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
-						   params->current_flags))
+	if (hdev->suspended &&
+	    !test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, params->flags))
 		return 0;
 
 	/* Attempt to program the device in the resolving list first to avoid
@@ -4749,8 +4749,7 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	hci_clear_event_filter_sync(hdev);
 
 	list_for_each_entry(b, &hdev->accept_list, list) {
-		if (!hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
-					b->current_flags))
+		if (!test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, b->flags))
 			continue;
 
 		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ff6d7c9333be..7d3c69c3cf62 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4349,8 +4349,6 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			       MGMT_STATUS_NOT_SUPPORTED);
 }
 
-#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
-
 static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 data_len)
 {
@@ -4358,7 +4356,7 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_rp_get_device_flags rp;
 	struct bdaddr_list_with_flags *br_params;
 	struct hci_conn_params *params;
-	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
+	u32 supported_flags;
 	u32 current_flags = 0;
 	u8 status = MGMT_STATUS_INVALID_PARAMS;
 
@@ -4367,6 +4365,9 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
+			__HCI_CONN_NUM_FLAGS);
+
 	memset(&rp, 0, sizeof(rp));
 
 	if (cp->addr.type == BDADDR_BREDR) {
@@ -4376,7 +4377,8 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (!br_params)
 			goto done;
 
-		current_flags = br_params->current_flags;
+		bitmap_to_arr32(&current_flags, br_params->flags,
+				__HCI_CONN_NUM_FLAGS);
 	} else {
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
@@ -4384,7 +4386,8 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (!params)
 			goto done;
 
-		current_flags = params->current_flags;
+		bitmap_to_arr32(&current_flags, params->flags,
+				__HCI_CONN_NUM_FLAGS);
 	}
 
 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
@@ -4422,13 +4425,16 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct bdaddr_list_with_flags *br_params;
 	struct hci_conn_params *params;
 	u8 status = MGMT_STATUS_INVALID_PARAMS;
-	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
+	u32 supported_flags;
 	u32 current_flags = __le32_to_cpu(cp->current_flags);
 
 	bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
 		   &cp->addr.bdaddr, cp->addr.type,
 		   __le32_to_cpu(current_flags));
 
+	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
+			__HCI_CONN_NUM_FLAGS);
+
 	if ((supported_flags | current_flags) != supported_flags) {
 		bt_dev_warn(hdev, "Bad flag given (0x%x) vs supported (0x%0x)",
 			    current_flags, supported_flags);
@@ -4443,7 +4449,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 							      cp->addr.type);
 
 		if (br_params) {
-			br_params->current_flags = current_flags;
+			bitmap_from_u64(br_params->flags, current_flags);
 			status = MGMT_STATUS_SUCCESS;
 		} else {
 			bt_dev_warn(hdev, "No such BR/EDR device %pMR (0x%x)",
@@ -4453,7 +4459,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
 		if (params) {
-			params->current_flags = current_flags;
+			bitmap_from_u64(params->flags, current_flags);
 			status = MGMT_STATUS_SUCCESS;
 		} else {
 			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
@@ -6979,6 +6985,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	struct hci_conn_params *params;
 	int err;
 	u32 current_flags = 0;
+	u32 supported_flags;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
@@ -7050,7 +7057,8 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						addr_type);
 		if (params)
-			current_flags = params->current_flags;
+			bitmap_to_arr32(&current_flags, params->flags,
+					__HCI_CONN_NUM_FLAGS);
 	}
 
 	err = hci_cmd_sync_queue(hdev, add_device_sync, NULL, NULL);
@@ -7059,8 +7067,10 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 
 added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
+	bitmap_to_arr32(&supported_flags, hdev->conn_flags,
+			__HCI_CONN_NUM_FLAGS);
 	device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
-			     SUPPORTED_DEVICE_FLAGS(), current_flags);
+			     supported_flags, current_flags);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 				MGMT_STATUS_SUCCESS, &cp->addr,
-- 
2.33.1

