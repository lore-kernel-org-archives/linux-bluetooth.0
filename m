Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D2BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6898061157
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhKEVP2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhKEVP1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:15:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4887C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:12:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so4250436pje.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+jlaIrPeh8post1bqeTS+Sa76sib7DaRQHzBSBB9XM=;
        b=HCrP1yOzt0KK2Wt16Hxy4Vva5DfPh/EBBBk4JlRQrN0FRUGlAxrcQS/FkaW9kot1K+
         eR30jU1pElItAq6jZySJ2KvwTeBhACE8Y46tcO5QR5dtdFwZhZr6s4vJsHjz4QRJklfi
         2aZOABMMQooCe1gzBgG2SiZriqCFkBrFa4ar1cB4HF1zk//xZWG52UQbIrHqOM1nFSRd
         Cl64Gf7u+xhylOsdHK3wFslWf6y8ff3sZLm5sBwtIEJuajKeiUUKvw45PQ69LA+hDFMC
         o4B1LBmP6zEpufBV5p00x2vhoqgzrYEsrYITuo9VW151qHFkqcH6CIh/Q997+PAK7jSu
         eqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+jlaIrPeh8post1bqeTS+Sa76sib7DaRQHzBSBB9XM=;
        b=ge5Ffdw40Lg/bc7+vPHhJZJ1lAAX1z2P9/XWh2tq3usDWT50O261dib9XFUx0ntMd/
         xSyFOySQ5KTsxfKIlqunaVZRsRwEdXxfvT7S0tzwMA3tW8eaWclEd8ATGAosdDTeaIbL
         ffLXu4iEIAoAphaDtwiKKHzDnWpf3foC2tY3NlXVxcr3KIAgThNd/IsDkqKq46gbRDx2
         o5RPc4ZoZRTwcTzDIAbjP2Gq32CStJemuAQoSdp5hwkVzOIHKFvB/KxJiU+PUK5hCXpy
         o6U+e3f0VIokpqjt7eRMeT75HSY4bq6rwh70YzmyLSBPYWHyQDxecRumZCJXwNosVDPY
         er0A==
X-Gm-Message-State: AOAM531H+HebnOEKGmByH8toY7jCAsRnOMKiQziiReh17bfRmXAI5H2h
        Ms6rddP749vHIBbA1ld7AEV724Ex+r4=
X-Google-Smtp-Source: ABdhPJzkekbKreNckOYI0gx2k3Hq32VLNCLcyEUOYvX04Pr+9tty+aFyA47vaOMcbOFeCVsBOP76sg==
X-Received: by 2002:a17:90b:3b8e:: with SMTP id pc14mr32056500pjb.129.1636146766825;
        Fri, 05 Nov 2021 14:12:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id om8sm2250553pjb.12.2021.11.05.14.12.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:12:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] btdev: Add support for LE Set Privacy mode
Date:   Fri,  5 Nov 2021 14:12:40 -0700
Message-Id: <20211105211245.424024-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for LE Set Privacy mode which is required when using
Device Privacy mode:

< HCI Command: LE Set Priva.. (0x08|0x004e) plen 8
        Peer Identity address type: Public (0x00)
        Peer Identity address: BC:9A:78:56:34:12 (OUI BC-9A-78)
        Privacy Mode: Use Device Privacy (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Privacy Mode (0x08|0x004e) ncmd 1
---
 emulator/btdev.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7b311f347..72ce21517 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -72,6 +72,7 @@ struct btdev_al {
 struct btdev_rl {
 	uint8_t type;
 	bdaddr_t addr;
+	uint8_t mode;
 	uint8_t peer_irk[16];
 	uint8_t local_irk[16];
 };
@@ -5336,6 +5337,48 @@ static int cmd_read_tx_power(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static int cmd_set_privacy_mode(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_priv_mode *cmd = data;
+	const struct btdev_rl *rl;
+	uint8_t status;
+
+	/* This command shall not be used when address resolution is enabled in
+	 * the Controller and:
+	 * • Advertising (other than periodic advertising) is enabled,
+	 * • Scanning is enabled, or
+	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
+	 * or HCI_LE_Periodic_Advertising_Create_Sync command is pending.
+	 */
+	if (dev->le_rl_enable || dev->le_adv_enable || dev->le_scan_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+	/* If the device is not on the resolving list, the Controller shall
+	 * return the error code Unknown Connection Identifier (0x02).
+	 */
+	rl = rl_find(dev, cmd->peer_id_addr_type, cmd->peer_id_addr);
+	if (!rl) {
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+	if (cmd->priv_mode > 0x01) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	((struct btdev_rl *)rl)->mode = cmd->priv_mode;
+	status = BT_HCI_ERR_SUCCESS;
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PRIV_MODE, &status, sizeof(status));
+
+	return 0;
+}
+
 #define CMD_LE_50 \
 	CMD(BT_HCI_CMD_LE_SET_DEFAULT_PHY, cmd_set_default_phy,	NULL), \
 	CMD(BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR, cmd_set_adv_rand_addr, NULL), \
@@ -5372,7 +5415,8 @@ static int cmd_read_tx_power(struct btdev *dev, const void *data, uint8_t len)
 	CMD(BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST, cmd_per_adv_clear, NULL), \
 	CMD(BT_HCI_CMD_LE_READ_PERIODIC_ADV_LIST_SIZE, \
 					cmd_read_per_adv_list_size, NULL), \
-	CMD(BT_HCI_CMD_LE_READ_TX_POWER, cmd_read_tx_power, NULL)
+	CMD(BT_HCI_CMD_LE_READ_TX_POWER, cmd_read_tx_power, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PRIV_MODE, cmd_set_privacy_mode, NULL)
 
 static const struct btdev_cmd cmd_le_5_0[] = {
 	CMD_COMMON_ALL,
@@ -5408,6 +5452,7 @@ static void set_le_50_commands(struct btdev *btdev)
 	btdev->commands[38] |= 0x20;	/* LE Clear Periodic Adv List */
 	btdev->commands[38] |= 0x40;	/* LE Read Periodic Adv List Size */
 	btdev->commands[38] |= 0x80;	/* LE Read Transmit Power */
+	btdev->commands[39] |= 0x04;	/* LE Set Privacy Mode */
 	btdev->cmds = cmd_le_5_0;
 }
 
-- 
2.31.1

