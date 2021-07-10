Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65280C07E99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 00:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F84611ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 00:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhGJAku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 20:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhGJAkt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 20:40:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4022C0613DD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jul 2021 17:38:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j9so4604966pfc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jul 2021 17:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XN5MUhZT1XhXTFqsPEQj8kO+1UMDEkMXUWwcUFVE5pE=;
        b=OmU4gmxILDbNrZzhVQihYD3ZGGjGgoNCpx+37rFAGuxlNIIFslhr5rUD6R65uXSi3+
         t3rkF2ZsPgixdQSLhBGJxpHueQpYQn8zqxJf9WA89jAR/jXYZC8XbRaqCJTaETj64gLU
         tEtYMxW8IRTQrsETWtPGHplvZ68fI9OMDFG5CdXa0A1vEtN7kou3uD2nVVd1Og/uK/aK
         pAAV5OborAiCKqa9s5bh621oihpViVLuT6w7zNlQa94Ln446W5Rbobz983UXy8FdlON0
         2WbGiGKE3AUQgdE0jfCq+A9xS77eeOLXyJO4IK1UcQbZpZTdnXcV+lgZV6Ek1xe2YHef
         YUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XN5MUhZT1XhXTFqsPEQj8kO+1UMDEkMXUWwcUFVE5pE=;
        b=XQI/Tk0Vmwy90TelT7cQs+hZ+Pk5ARo5cThp+VkbL9YXltoFJo5cr8nyBjZnYQsd6s
         Fodg2AAPh+7jq1SsTUKvRd9me/sm5xRIQdUeeDfL2iUZtENTxDI6SQQ+wvtRIhKOL/Xv
         rZlLVs8uYYwH00OSdS6As8bNvwoZ1FCI2jLh6CB8LCyMeXuSAx2HJnpePpfDZkozIJVv
         VC4z4v2M2gf5ic0cvfUkV5w4Gs5IkUQldcURjGvlu7EyD9BUDvhQODry1IcaS/M22s9q
         Ru7MCS7c9LWuY5UPD5Ksp4W/RrLceyU8k+uMoy8X4vLIdFr6LDIcNnrLCRWeYCj84NLg
         OmnA==
X-Gm-Message-State: AOAM530onPSc50HuGOTnyfLbZRBb9UCocqbyar8k7rqPKJSl0rA6phSY
        oDIaDoXtw0hzXi69qRLiqo45EQfn7dY=
X-Google-Smtp-Source: ABdhPJzRl76NZkTX3kLDzYQP/G1Kc1HrDzsE90F3gTfnXX7xETXjXSOzRlljNWMEbciwrKjHilxa/Q==
X-Received: by 2002:a62:30c5:0:b029:31e:fa6d:1738 with SMTP id w188-20020a6230c50000b029031efa6d1738mr30715643pfw.55.1625877484095;
        Fri, 09 Jul 2021 17:38:04 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id u13sm7278219pfi.54.2021.07.09.17.38.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 17:38:03 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/2] emulator/btdev: Add support HCI_READ_CLOCK command
Date:   Fri,  9 Jul 2021 17:38:00 -0700
Message-Id: <20210710003801.941787-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
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
index a7fda2c89..a863a0799 100644
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
2.26.3

