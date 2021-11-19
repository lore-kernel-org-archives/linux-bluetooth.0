Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D55C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A9E61B04
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhKSJkF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:40:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:62588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhKSJkF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 04:40:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297804837"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="297804837"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="594179346"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2021 01:37:02 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 3/9] mgmt: Set MSFT offload codec feature
Date:   Fri, 19 Nov 2021 15:12:29 +0530
Message-Id: <20211119094235.2432-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119094235.2432-1-kiran.k@intel.com>
References: <20211119094235.2432-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support to toggle msft offload codec feature.
---
 tools/btmgmt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 42ef9acefaea..3d76269b178a 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2597,6 +2597,46 @@ static void cmd_exp_offload_codecs(int argc, char **argv)
 	}
 }
 
+static void exp_msft_offload_rsp(uint8_t status, uint16_t len,
+				 const void *param, void *user_data)
+{
+	if (status != 0)
+		error("Set MSFT offload codec failed with status 0x%02x (%s)",
+		      status, mgmt_errstr(status));
+	else
+		print("MSFT Offload codec feature successfully set");
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_exp_msft_offload_codecs(int argc, char **argv)
+{
+	/* 0cc2131f-96f0-4cd1-b313-b97e7cbc8335 */
+	static const uint8_t uuid[16] = {
+				0x35, 0x83, 0xbc, 0x7c, 0x7e, 0xb9, 0x13, 0xb3,
+				0xd1, 0x4c, 0xf0, 0x96, 0x1f, 0x13, 0xc2, 0x0c,
+	};
+	struct mgmt_cp_set_exp_feature cp;
+	uint8_t val;
+	uint16_t index;
+
+	if (parse_setting(argc, argv, &val) == false)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, uuid, 16);
+	cp.action = val;
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, index, sizeof(cp), &cp,
+		      exp_msft_offload_rsp, NULL, NULL) == 0) {
+		error("Unable to send msft offload codecs feature cmd");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
 static void class_rsp(uint16_t op, uint16_t id, uint8_t status, uint16_t len,
 							const void *param)
 {
@@ -5640,6 +5680,8 @@ static const struct bt_shell_menu main_menu = {
 		"Set bluetooth quality report feature"			},
 	{ "exp-offload",		"<on/off>",
 		cmd_exp_offload_codecs,	"Toggle codec support"		},
+	{ "exp-msft-offload",		"<on/off>",
+		cmd_exp_msft_offload_codecs, "Toggle msft codec support"},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
 	{ "set-sysconfig",	"<-v|-h> [options...]",
-- 
2.17.1

