Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C4DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 03:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8460F38
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 03:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhHQDFk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 23:05:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:19782 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234014AbhHQDFj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 23:05:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="212865680"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="212865680"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 20:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="530847985"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2021 20:05:05 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] mgmt: Set offload codec mgmt feature
Date:   Tue, 17 Aug 2021 08:39:30 +0530
Message-Id: <20210817030930.9211-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add mgmt support to toggle offload codec feature
---
changes in v2:
 - fix warnings reported by checkpatch
 - add uuid to /src/shared/util.c:uuid128_table
 - remove sign-off from commit message

 src/shared/util.c |  1 +
 tools/btmgmt.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 854b48d38f09..2447564566ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1027,6 +1027,7 @@ static const struct {
 		"BlueZ Experimental LL privacy" },
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
+	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
 	{ }
 };
 
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 7d908238156d..a840c428cc74 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2554,6 +2554,48 @@ static void cmd_privacy(int argc, char **argv)
 	}
 }
 
+static void exp_offload_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		error("Set offload codec failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+	else
+		print("Offload codec feature successfully set");
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_exp_offload_codecs(int argc, char **argv)
+{
+	/* a6695ace-ee7f-4fb9-881a-5fac66c629af */
+	static const uint8_t uuid[16] = {
+				0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
+				0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6,
+	};
+
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
+	if (mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, index,
+			sizeof(cp), &cp, exp_offload_rsp, NULL, NULL) == 0) {
+		error("Unable to send offload codecs feature cmd");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void class_rsp(uint16_t op, uint16_t id, uint8_t status, uint16_t len,
 							const void *param)
 {
@@ -5595,6 +5637,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_exp_privacy,	"Set LL privacy feature"	},
 	{ "exp-quality",	"<on/off>", cmd_exp_quality,
 		"Set bluetooth quality report feature"			},
+	{ "exp-offload",		"<on/off>",
+		cmd_exp_offload_codecs,	"Toggle codec support"		},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
 	{ "set-sysconfig",	"<-v|-h> [options...]",
-- 
2.17.1

