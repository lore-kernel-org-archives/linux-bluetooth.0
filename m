Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A938EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8440061B1E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhKSJkB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:40:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:62588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhKSJkA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 04:40:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297804832"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="297804832"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="594179321"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2021 01:36:57 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/9] adapter: Enable MSFT a2dp offload codec when Experimental is set
Date:   Fri, 19 Nov 2021 15:12:27 +0530
Message-Id: <20211119094235.2432-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This enables codec offload experimental feature if its UUIDs has been
enabled by main.conf:Experimental or -E has been passed in the command
line.
---
 src/adapter.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/main.c    |  1 +
 src/main.conf |  1 +
 3 files changed, 45 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 309956bbb5be..1627cc127057 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -142,6 +142,13 @@ static const struct mgmt_exp_uuid codec_offload_uuid = {
 	.str = "a6695ace-ee7f-4fb9-881a-5fac66c629af"
 };
 
+/* 0cc2131f-96f0-4cd1-b313-b97e7cbc8335 */
+static const struct mgmt_exp_uuid msft_a2dp_offload_codecs_uuid = {
+	.val = { 0x35, 0x83, 0xbc, 0x7c, 0x7e, 0xb9, 0x13, 0xb3,
+		0xd1, 0x4c, 0xf0, 0x96, 0x1f, 0x13, 0xc2, 0x0c},
+	.str = "0cc2131f-96f0-4cd1-b313-b97e7cbc8335"
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static uint32_t kernel_features = 0;
@@ -9789,6 +9796,41 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 	btd_error(adapter->dev_id, "Failed to set Codec Offload");
 }
 
+static void msft_a2dp_offload_complete(uint8_t status, uint16_t len,
+				       const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
+
+	if (status != 0) {
+		error("Set MSFT a2dp offload codec failed with status 0x%02x (%s)",
+		       status, mgmt_errstr(status));
+		return;
+	}
+
+	DBG("MSFT a2dp offload codecs successfully set");
+
+	if (action)
+		queue_push_tail(adapter->exps,
+				(void *)msft_a2dp_offload_codecs_uuid.val);
+}
+
+static void msft_a2dp_offload_func(struct btd_adapter *adapter, uint8_t action)
+{
+	struct mgmt_cp_set_exp_feature cp;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, msft_a2dp_offload_codecs_uuid.val, 16);
+	cp.action = action;
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+		      adapter->dev_id, sizeof(cp), &cp,
+		      msft_a2dp_offload_complete, adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id, "Failed to set RPA Resolution");
+}
+
 static const struct exp_feat {
 	const struct mgmt_exp_uuid *uuid;
 	void (*func)(struct btd_adapter *adapter, uint8_t action);
@@ -9799,6 +9841,7 @@ static const struct exp_feat {
 	EXP_FEAT(&quality_report_uuid, quality_report_func),
 	EXP_FEAT(&rpa_resolution_uuid, rpa_resolution_func),
 	EXP_FEAT(&codec_offload_uuid, codec_offload_func),
+	EXP_FEAT(&msft_a2dp_offload_codecs_uuid, msft_a2dp_offload_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
diff --git a/src/main.c b/src/main.c
index dd954e1abfe9..9776ff89a1d9 100644
--- a/src/main.c
+++ b/src/main.c
@@ -571,6 +571,7 @@ static const char *valid_uuids[] = {
 	"15c0a148-c273-11ea-b3de-0242ac130004",
 	"330859bc-7506-492d-9370-9a6f0614037f",
 	"a6695ace-ee7f-4fb9-881a-5fac66c629af",
+	"0cc2131f-96f0-4cd1-b313-b97e7cbc8335",
 	"*"
 };
 
diff --git a/src/main.conf b/src/main.conf
index c82d7e6482c4..ab4a6128ad5c 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -116,6 +116,7 @@
 # 15c0a148-c273-11ea-b3de-0242ac130004 (BlueZ Experimental LL privacy)
 # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
+# 0cc2131f-96f0-4cd1-b313-b97e7cbc8335 (BlueZ Experimental MSFT a2dp offload Codecs)
 # Defaults to false.
 #Experimental = false
 
-- 
2.17.1

