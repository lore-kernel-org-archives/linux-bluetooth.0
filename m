Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC97C4332D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1D464ECC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhBINiu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:38:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBINiM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 08:38:12 -0500
Received: from [123.112.66.2] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1l9TCq-00050T-IL; Tue, 09 Feb 2021 13:37:30 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@intel.com, luiz.dentz@gmail.com
Subject: [Bluez][PATCH] btmgmt: add a new command reset_hci via experimental feature
Date:   Tue,  9 Feb 2021 21:36:29 +0800
Message-Id: <20210209133629.12784-5-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209133629.12784-1-hui.wang@canonical.com>
References: <20210209133629.12784-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Users could reset the hci through this command, and the hci will
reset to bootloader mode if it supports, then the driver will load the
firmware in the driver's probe().
---
 tools/btmgmt.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index f4eb541fa..613a1118e 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1728,6 +1728,18 @@ static void exp_debug_rsp(uint8_t status, uint16_t len, const void *param,
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void exp_reset_hci_rsp(uint8_t status, uint16_t len, const void *param,
+			      void *user_data)
+{
+	if (status != 0)
+		error("Set reset hci feature failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+	else
+		print("Reset hci feature successfully set");
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_exp_debug(int argc, char **argv)
 {
 	/* d4992530-b9ec-469f-ab01-6c481c47da1c */
@@ -1752,6 +1764,25 @@ static void cmd_exp_debug(int argc, char **argv)
 	}
 }
 
+static void cmd_exp_reset_hci(int argc, char **argv)
+{
+	/* 3f06cef5-2b4f-4c22-b1f4-64bb4733e637 */
+	const uint8_t uuid[16] = {
+		0x37, 0xe6, 0x33, 0x47, 0xbb, 0x64, 0xf4, 0xb1,
+		0x22, 0x4c, 0x4f, 0x2b, 0xf5, 0xce, 0x06, 0x3f,
+	};
+	struct mgmt_cp_set_exp_feature cp;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, uuid, 16);
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, mgmt_index,
+			sizeof(cp), &cp, exp_reset_hci_rsp, NULL, NULL) == 0) {
+		error("Unable to send reset hci feature cmd");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void print_mgmt_tlv(void *data, void *user_data)
 {
 	const struct mgmt_tlv *entry = data;
@@ -5303,6 +5334,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_expinfo,		"Show experimental features"	},
 	{ "exp-debug",		"<on/off>",
 		cmd_exp_debug,		"Set debug feature"		},
+	{ "exp-reset-hci",	NULL,
+		cmd_exp_reset_hci,	"Reset hci"	},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
 	{ "set-sysconfig",	"<-v|-h> [options...]",
-- 
2.25.1

