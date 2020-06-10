Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0ACC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9A6206F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6L5cQEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgFJUF1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFJUF1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:05:27 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5914AC03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:05:27 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id u15so904780vkk.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yqETY+RHpYYZsFOwaipeBbdkgyHX5zy6ufvwsI+Jbk=;
        b=A6L5cQEUg2iwPOFE6akkofrmuZKHIEi9BQp5BZm3nn4YFPCe0auYVpOw2ewH5xw0ri
         kSpcnfuRbNTpkydFW3IOSYIb35FGweAqSorVhuVaFzuZWthikEZjXpVUu0gfcduGoitS
         Llay0pRFNnnzn9KLrJi6PnZCkn9g/1+rb6dhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yqETY+RHpYYZsFOwaipeBbdkgyHX5zy6ufvwsI+Jbk=;
        b=hSWz1V8mIPeEpdC62EANU2yCv0rqK3LL4n40mdax2bxUOzYNhqrVfHHk0xD/fxmECi
         t9CwlZcaNMG9PG/++ZQeEBT1bET2jnLUNruBlLdTYH50WWkbqixhMlH6izVrK1I6XPYK
         zjCkRKa+vcmhPCc7lRg3jb0RqMqL3bqYSg5b7J73lMyEgW6UdYmEfjs71u2Tfru4ySXc
         Pk5dEOza0k8FRunYEbt4Tjl3rRdptaqL/c/N13OSX9Ue/l4Lpb4qR4+kVyeUGJ+Z6AgF
         EusWnduJgoaHX9ivNJ15mqhq05zZQOnKn0y8NT6p7zPERXJXnKQbV/ExXP+p31oH/JxQ
         onvA==
X-Gm-Message-State: AOAM532osKRkooecH0X/TyBP392K7Pb20wqZA+JLKiuXjILm4SUNxX5e
        IAkvC/RcTANlce+RsVpa4IV+AXjzJrE=
X-Google-Smtp-Source: ABdhPJzVUwoBjPT6acpbjdGj5ZYYhYcjtET7FDyZRbYmTtuKMncRT2nVcs7mBhfT0AmmbqXzT7x+8A==
X-Received: by 2002:a1f:a448:: with SMTP id n69mr3822071vke.44.1591819526013;
        Wed, 10 Jun 2020 13:05:26 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id q185sm107253vkq.10.2020.06.10.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:05:25 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v2 3/3] bluetooth: implement read/set default system parameters mgmt
Date:   Wed, 10 Jun 2020 20:04:55 +0000
Message-Id: <20200610200452.107406-4-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200610200452.107406-1-alainm@chromium.org>
References: <20200610200452.107406-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements the read default system parameters and the set
default system parameters mgmt commands.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2: None

 net/bluetooth/Makefile      |   2 +-
 net/bluetooth/mgmt.c        |   6 +
 net/bluetooth/mgmt_config.c | 253 ++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt_config.h |  11 ++
 4 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 net/bluetooth/mgmt_config.c
 create mode 100644 net/bluetooth/mgmt_config.h

diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 41dd541a44a5..1c645fba8c49 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -14,7 +14,7 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
-	ecdh_helper.o hci_request.o mgmt_util.o
+	ecdh_helper.o hci_request.o mgmt_util.o mgmt_config.o
 
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9e8a3cccc6ca..69cd4f756a0d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -36,6 +36,7 @@
 #include "hci_request.h"
 #include "smp.h"
 #include "mgmt_util.h"
+#include "mgmt_config.h"
 
 #define MGMT_VERSION	1
 #define MGMT_REVISION	17
@@ -111,6 +112,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_SECURITY_INFO,
 	MGMT_OP_READ_EXP_FEATURES_INFO,
 	MGMT_OP_SET_EXP_FEATURE,
+	MGMT_OP_READ_DEF_SYSTEM_CONFIG,
+	MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 };
 
 static const u16 mgmt_events[] = {
@@ -162,6 +165,7 @@ static const u16 mgmt_untrusted_commands[] = {
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_READ_SECURITY_INFO,
 	MGMT_OP_READ_EXP_FEATURES_INFO,
+	MGMT_OP_READ_DEF_SYSTEM_CONFIG,
 };
 
 static const u16 mgmt_untrusted_events[] = {
@@ -7297,6 +7301,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_exp_feature,         MGMT_SET_EXP_FEATURE_SIZE,
 						HCI_MGMT_VAR_LEN |
 						HCI_MGMT_HDEV_OPTIONAL },
+	{ read_def_system_config, 0, HCI_MGMT_UNTRUSTED },
+	{ set_def_system_config, 0, HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
new file mode 100644
index 000000000000..f967ffc3fbb1
--- /dev/null
+++ b/net/bluetooth/mgmt_config.c
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2020 Google Corporation
+ */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/mgmt.h>
+
+#include "mgmt_util.h"
+#include "mgmt_config.h"
+
+#define HDEV_PARAM_U16(_param_code_, _param_name_) \
+{ \
+	{ _param_code_, sizeof(__u16) }, \
+	{ cpu_to_le16(hdev->_param_name_) } \
+}
+
+int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 data_len)
+{
+	struct {
+		struct mgmt_tlv entry;
+		union {
+			/* This is a simplification for now since all values
+			 * are 16 bits.  In the future, this code may need
+			 * refactoring to account for variable length values
+			 * and properly calculate the required buffer size.
+			 */
+			u16 value;
+		};
+	} __packed params[] = {
+		/* Please see mgmt-api.txt for documentation of these values */
+		HDEV_PARAM_U16(0x0000, def_page_scan_type),
+		HDEV_PARAM_U16(0x0001, def_page_scan_int),
+		HDEV_PARAM_U16(0x0002, def_page_scan_window),
+		HDEV_PARAM_U16(0x0003, def_inq_scan_type),
+		HDEV_PARAM_U16(0x0004, def_inq_scan_int),
+		HDEV_PARAM_U16(0x0005, def_inq_scan_window),
+		HDEV_PARAM_U16(0x0006, def_br_lsto),
+		HDEV_PARAM_U16(0x0007, def_page_timeout),
+		HDEV_PARAM_U16(0x0008, sniff_min_interval),
+		HDEV_PARAM_U16(0x0009, sniff_max_interval),
+		HDEV_PARAM_U16(0x000a, le_adv_min_interval),
+		HDEV_PARAM_U16(0x000b, le_adv_max_interval),
+		HDEV_PARAM_U16(0x000c, def_multi_adv_rotation_duration),
+		HDEV_PARAM_U16(0x000d, le_scan_interval),
+		HDEV_PARAM_U16(0x000e, le_scan_window),
+		HDEV_PARAM_U16(0x000f, le_scan_int_suspend),
+		HDEV_PARAM_U16(0x0010, le_scan_window_suspend),
+		HDEV_PARAM_U16(0x0011, le_scan_int_discovery),
+		HDEV_PARAM_U16(0x0012, le_scan_window_discovery),
+		HDEV_PARAM_U16(0x0013, le_scan_int_adv_monitor),
+		HDEV_PARAM_U16(0x0014, le_scan_window_adv_monitor),
+		HDEV_PARAM_U16(0x0015, le_scan_int_connect),
+		HDEV_PARAM_U16(0x0016, le_scan_window_connect),
+		HDEV_PARAM_U16(0x0017, le_conn_min_interval),
+		HDEV_PARAM_U16(0x0018, le_conn_max_interval),
+		HDEV_PARAM_U16(0x0019, le_conn_latency),
+		HDEV_PARAM_U16(0x001a, le_supv_timeout),
+	};
+	struct mgmt_rp_read_def_system_config *rp = (void *)params;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	return mgmt_cmd_complete(sk, hdev->id,
+				 MGMT_OP_READ_DEF_SYSTEM_CONFIG,
+				 0, rp, sizeof(params));
+}
+
+#define TO_TLV(x)		((struct mgmt_tlv *)(x))
+#define TLV_GET_LE16(tlv)	le16_to_cpu(*((u16 *)(TO_TLV(tlv)->value)))
+
+int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
+			  u16 data_len)
+{
+	u16 buffer_left = data_len;
+	u8 *buffer = data;
+
+	if (buffer_left < sizeof(struct mgmt_tlv)) {
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	/* First pass to validate the tlv */
+	while (buffer_left >= sizeof(struct mgmt_tlv)) {
+		const u8 len = TO_TLV(buffer)->length;
+		const u16 exp_len = sizeof(struct mgmt_tlv) +
+				    len;
+		const u16 type = le16_to_cpu(TO_TLV(buffer)->type);
+
+		if (buffer_left < exp_len) {
+			bt_dev_warn(hdev, "invalid len left %d, exp >= %d",
+				    buffer_left, exp_len);
+
+			return mgmt_cmd_status(sk, hdev->id,
+					MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+					MGMT_STATUS_INVALID_PARAMS);
+		}
+
+		/* Please see mgmt-api.txt for documentation of these values */
+		switch (type) {
+		case 0x0000:
+		case 0x0001:
+		case 0x0002:
+		case 0x0003:
+		case 0x0004:
+		case 0x0005:
+		case 0x0006:
+		case 0x0007:
+		case 0x0008:
+		case 0x0009:
+		case 0x000a:
+		case 0x000b:
+		case 0x000c:
+		case 0x000d:
+		case 0x000e:
+		case 0x000f:
+		case 0x0010:
+		case 0x0011:
+		case 0x0012:
+		case 0x0013:
+		case 0x0014:
+		case 0x0015:
+		case 0x0016:
+		case 0x0017:
+		case 0x0018:
+		case 0x0019:
+		case 0x001a:
+			if (len != sizeof(u16)) {
+				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
+					    len, sizeof(u16), type);
+
+				return mgmt_cmd_status(sk, hdev->id,
+					MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+					MGMT_STATUS_INVALID_PARAMS);
+			}
+			break;
+		default:
+			bt_dev_warn(hdev, "unsupported parameter %u", type);
+			break;
+		}
+
+		buffer_left -= exp_len;
+		buffer += exp_len;
+	}
+
+	buffer_left = data_len;
+	buffer = data;
+	while (buffer_left >= sizeof(struct mgmt_tlv)) {
+		const u8 len = TO_TLV(buffer)->length;
+		const u16 exp_len = sizeof(struct mgmt_tlv) +
+				    len;
+		const u16 type = le16_to_cpu(TO_TLV(buffer)->type);
+
+		switch (type) {
+		case 0x0000:
+			hdev->def_page_scan_type = TLV_GET_LE16(buffer);
+			break;
+		case 0x0001:
+			hdev->def_page_scan_int = TLV_GET_LE16(buffer);
+			break;
+		case 0x0002:
+			hdev->def_page_scan_window = TLV_GET_LE16(buffer);
+			break;
+		case 0x0003:
+			hdev->def_inq_scan_type = TLV_GET_LE16(buffer);
+			break;
+		case 0x0004:
+			hdev->def_inq_scan_int = TLV_GET_LE16(buffer);
+			break;
+		case 0x0005:
+			hdev->def_inq_scan_window = TLV_GET_LE16(buffer);
+			break;
+		case 0x0006:
+			hdev->def_br_lsto = TLV_GET_LE16(buffer);
+			break;
+		case 0x0007:
+			hdev->def_page_timeout = TLV_GET_LE16(buffer);
+			break;
+		case 0x0008:
+			hdev->sniff_min_interval = TLV_GET_LE16(buffer);
+			break;
+		case 0x0009:
+			hdev->sniff_max_interval = TLV_GET_LE16(buffer);
+			break;
+		case 0x000a:
+			hdev->le_adv_min_interval = TLV_GET_LE16(buffer);
+			break;
+		case 0x000b:
+			hdev->le_adv_max_interval = TLV_GET_LE16(buffer);
+			break;
+		case 0x000c:
+			hdev->def_multi_adv_rotation_duration =
+							   TLV_GET_LE16(buffer);
+			break;
+		case 0x000d:
+			hdev->le_scan_interval = TLV_GET_LE16(buffer);
+			break;
+		case 0x000e:
+			hdev->le_scan_window = TLV_GET_LE16(buffer);
+			break;
+		case 0x000f:
+			hdev->le_scan_int_suspend = TLV_GET_LE16(buffer);
+			break;
+		case 0x0010:
+			hdev->le_scan_window_suspend = TLV_GET_LE16(buffer);
+			break;
+		case 0x0011:
+			hdev->le_scan_int_discovery = TLV_GET_LE16(buffer);
+			break;
+		case 0x00012:
+			hdev->le_scan_window_discovery = TLV_GET_LE16(buffer);
+			break;
+		case 0x00013:
+			hdev->le_scan_int_adv_monitor = TLV_GET_LE16(buffer);
+			break;
+		case 0x00014:
+			hdev->le_scan_window_adv_monitor = TLV_GET_LE16(buffer);
+			break;
+		case 0x00015:
+			hdev->le_scan_int_connect = TLV_GET_LE16(buffer);
+			break;
+		case 0x00016:
+			hdev->le_scan_window_connect = TLV_GET_LE16(buffer);
+			break;
+		case 0x00017:
+			hdev->le_conn_min_interval = TLV_GET_LE16(buffer);
+			break;
+		case 0x00018:
+			hdev->le_conn_max_interval = TLV_GET_LE16(buffer);
+			break;
+		case 0x00019:
+			hdev->le_conn_latency = TLV_GET_LE16(buffer);
+			break;
+		case 0x0001a:
+			hdev->le_supv_timeout = TLV_GET_LE16(buffer);
+			break;
+		default:
+			bt_dev_warn(hdev, "unsupported parameter %u", type);
+			break;
+		}
+
+		buffer_left -= exp_len;
+		buffer += exp_len;
+	}
+
+	return mgmt_cmd_status(sk, hdev->id,
+			       MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+			       MGMT_STATUS_SUCCESS);
+}
diff --git a/net/bluetooth/mgmt_config.h b/net/bluetooth/mgmt_config.h
new file mode 100644
index 000000000000..0005db246afc
--- /dev/null
+++ b/net/bluetooth/mgmt_config.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2020 Google Corporation
+ */
+
+int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 data_len);
+
+int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
+			  u16 data_len);
-- 
2.27.0.290.gba653c62da-goog

