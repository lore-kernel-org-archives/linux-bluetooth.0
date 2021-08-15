Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26250C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 00:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC1760E76
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 00:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhHOAMM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 20:12:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:41698 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhHOAMM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 20:12:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10076"; a="215738509"
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="215738509"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2021 17:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="592006598"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2021 17:11:41 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH] mgmt: Set offload codec mgmt feature
Date:   Sun, 15 Aug 2021 05:45:50 +0530
Message-Id: <20210815001550.24643-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 tools/btmgmt.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 7d908238156d..c5f55ae1290c 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2554,6 +2554,48 @@ static void cmd_privacy(int argc, char **argv)
 	}
 }
 
+static void exp_offload_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		error("Set offload codec feature failed with status 0x%02x (%s)",
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
+		cmd_exp_offload_codecs,	"Toggle codec support support"	},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
 	{ "set-sysconfig",	"<-v|-h> [options...]",
-- 
2.17.1

