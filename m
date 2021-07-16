Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43043C636CB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FDE613EB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 19:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhGPTmg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:42:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:58159 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233008AbhGPTme (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Jul 2021 15:42:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="296425608"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="296425608"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 12:39:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="431316669"
Received: from landruma-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.217.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 12:39:37 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com,
        brian.gix@intel.com
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH BlueZ v2 1/3] emulator/btdev: Add support HCI_READ_CLOCK command
Date:   Fri, 16 Jul 2021 12:39:30 -0700
Message-Id: <20210716193932.2939264-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support HCI_READ_CLOCK command in btdev.
---
 emulator/btdev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 90b3d9f31..0a5645c5c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2296,6 +2296,22 @@ static int cmd_read_rssi(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static int cmd_read_clock(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_read_clock *cmd = data;
+	struct bt_hci_rsp_read_clock rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.handle = le16_to_cpu(cmd->handle);
+	rsp.clock = 0x11223344;
+	rsp.accuracy = 0x5566;
+	cmd_complete(dev, BT_HCI_CMD_READ_CLOCK, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
 static int cmd_enable_dut_mode(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -2389,6 +2405,7 @@ static int cmd_enable_dut_mode(struct btdev *dev, const void *data,
 					NULL), \
 	CMD(BT_HCI_CMD_READ_COUNTRY_CODE, cmd_read_country_code, NULL), \
 	CMD(BT_HCI_CMD_READ_RSSI, cmd_read_rssi, NULL), \
+	CMD(BT_HCI_CMD_READ_CLOCK, cmd_read_clock, NULL), \
 	CMD(BT_HCI_CMD_ENABLE_DUT_MODE, cmd_enable_dut_mode, NULL)
 
 static void set_common_commands_bredr20(struct btdev *btdev)
@@ -2448,6 +2465,7 @@ static void set_common_commands_bredr20(struct btdev *btdev)
 	btdev->commands[14] |= 0x40;	/* Read Local Extended Features */
 	btdev->commands[15] |= 0x01;	/* Read Country Code */
 	btdev->commands[15] |= 0x20;	/* Read RSSI */
+	btdev->commands[15] |= 0x80;	/* Read Clock */
 	btdev->commands[16] |= 0x04;	/* Enable Device Under Test Mode */
 }
 
-- 
2.31.1

