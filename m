Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D5EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC0F61222
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhDEOte (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 10:49:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:40222 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235948AbhDEOte (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 10:49:34 -0400
IronPort-SDR: cII/k8LvclC8lbwkHM+t/tCesWtw28IkYVUIAIRrg7GaOE/81qBYLkaYruFSPhAzGO42gb7fPt
 P6wefZnyfUsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="189642577"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="189642577"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 07:49:28 -0700
IronPort-SDR: ND7SK95XtCym53ElE5FLQ1axlkfEw0PLqlGyC8QiZETctgRKl6ecDMh8LqPehOzNnr6oieH+YV
 +6GEP23XaEhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="414316882"
Received: from nsathish-latitude-7480.iind.intel.com ([10.224.186.105])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2021 07:49:26 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [Bluez PATCH] btmgmt: Add support to enable LL privacy
Date:   Mon,  5 Apr 2021 20:28:02 +0530
Message-Id: <20210405145802.27317-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If the Bluetooth controller supports LL privacy this command will be
used to test the same.
"sudo btmgmt power off"
"sudo btmgmt llprivacy on"
"sudo btmgmt power on"

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 tools/btmgmt.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 93d244ff8ec8..4a53c3768fe9 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2261,6 +2261,42 @@ static void cmd_bredr(int argc, char **argv)
 	cmd_setting(MGMT_OP_SET_BREDR, argc, argv);
 }
 
+static void ll_rpa_resoln_rsp(uint8_t status, uint16_t len, const void *param,
+			      void *user_data)
+{
+	if (status != 0)
+		error("Could not set LL RPA resolution with status 0x%02x (%s)",
+		      status, mgmt_errstr(status));
+	else
+		print("LL RPA Resolution successfully set");
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_set_ll_rpa_resoln(int argc, char **argv)
+{
+	/* 15c0a148-c273-11ea-b3de-0242ac130004 */
+	static const uint8_t rpa_resolution_uuid[16] = {
+				0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
+				0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
+	};
+	struct mgmt_cp_set_exp_feature cp;
+	uint16_t index;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, rpa_resolution_uuid, 16);
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (parse_setting(argc, argv, &cp.action) == false)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, index,
+		  sizeof(cp), &cp, ll_rpa_resoln_rsp, NULL, NULL);
+}
+
 static void cmd_privacy(int argc, char **argv)
 {
 	struct mgmt_cp_set_privacy cp;
@@ -5243,6 +5279,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_bredr,		"Toggle BR/EDR support",	},
 	{ "privacy",		"<on/off>",
 		cmd_privacy,		"Toggle privacy support"	},
+	{ "llprivacy",		"<on/off>",
+		cmd_set_ll_rpa_resoln,	"Toggle LL privacy support"	},
 	{ "class",		"<major> <minor>",
 		cmd_class,		"Set device major/minor class"	},
 	{ "disconnect", 	"[-t type] <remote address>",
-- 
2.17.1

