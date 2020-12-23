Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18894C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 00:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE16F22AAA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 00:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLWA1b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 19:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLWA1b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 19:27:31 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE9CC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 16:26:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e2so9472071pgi.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 16:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHkAFeFGdVP0bN+3byL2TsVLZTpr3v8Y3XvQKnnn9Fo=;
        b=J8QbsTBgbaUeX1aRMZyX9YcjS/yaRckew8+z6zRBRLYyNuOfOPJdNpIZvd/5ERSIBA
         +6q7lKA+jQzeh1KqvZPPYPJHuCeC4nIRA9SbW/nxe0B8msAZMXzC8O+WdtK0/IWK02w8
         HZAfgRjlpY3FbJzGzpr6iDct2n5HjiMahBcWtGZbsKl65aP0DTqXiesyYJOja4hmQ6gW
         D6rK1rzN0UtLhS/gC78ijx61UgrnpV+3uU5/HO7w/9i+PzAbDi/RrAsMyJGmpx418uvZ
         MDwBpixL40JfpLvs+EbDI7BFN/ybV4yY/4RLGs5ZSyRJJBZrNoV1bfV+5lUs5FPThjKf
         Hi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHkAFeFGdVP0bN+3byL2TsVLZTpr3v8Y3XvQKnnn9Fo=;
        b=bYgFXmFHon1NA8LN/C4eoYl2jyDJ8oymV/nQLsLoJHcdAzfjgmVrhUWjo70hliC8nK
         dR376DGpdOxs5xX8UHzCKn3MJUWWJCwhrG3/Ws8DAsI0qoDn/shbkWzwKpf88PjMW5Lk
         U4PU2BA2YeJ3d35Zbl23uV8bcSlwBvx7kfNPG1B+Rqxhj1kpnY8LPe48Lahwl3hY/bQc
         7anB3agQogh9XEDRmK9R8OSepW6HrE2gfaPY7JOFSvMH9zZ34B2APMl6931LDWIW+Dcb
         Uh4ZkYDx3od0F+oKsNiCPDJuWXyCmO7LRW/zyRX8k0uK7km0Kmdhnt5ciNzk+lYZjD7y
         bDYg==
X-Gm-Message-State: AOAM531sjIyGGX3wiBtEuT95s+kCa+mx6B8PQUrvlYrTw0v2cSmOvZQl
        ZCRObeIt9tDpZlgquqei0CGPjCnq6U4=
X-Google-Smtp-Source: ABdhPJx2XcN685bsoFyRy8MEUS7AkwORDBkxvr/EFt+lhFca3KOWgw4+UrheLnq+G1W4RM0/QVG5cw==
X-Received: by 2002:a65:458e:: with SMTP id o14mr16272005pgq.444.1608683210533;
        Tue, 22 Dec 2020 16:26:50 -0800 (PST)
Received: from localhost.localdomain (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id 8sm5505566pfz.93.2020.12.22.16.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 16:26:50 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     danielwinkler@google.com, tedd.an@intel.com
Subject: [PATCH 2/3] emulator/btdev: Add support LE_READ_TX_POWER command
Date:   Tue, 22 Dec 2020 16:26:32 -0800
Message-Id: <20201223002633.187612-2-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223002633.187612-1-tedd.an@intel.com>
References: <20201223002633.187612-1-tedd.an@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for LE_READ_TX_POWER command.
It uses a random values for min and max tx power since these values is
read from the controller.
---
 emulator/btdev.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ae382d9b9..17965f9b6 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4170,6 +4170,22 @@ static int cmd_read_per_adv_list_size(struct btdev *dev, const void *data,
 	return -ENOTSUP;
 }
 
+static int cmd_read_tx_power(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_le_read_tx_power rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	/* a random default value */
+	rsp.max_tx_power = 0x07;
+	rsp.min_tx_power = 0xDE;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_TX_POWER, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
 #define CMD_LE_50 \
 	CMD(BT_HCI_CMD_LE_SET_DEFAULT_PHY, cmd_set_default_phy,	NULL), \
 	CMD(BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR, cmd_set_adv_rand_addr, NULL), \
@@ -4205,7 +4221,8 @@ static int cmd_read_per_adv_list_size(struct btdev *dev, const void *data,
 					NULL), \
 	CMD(BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST, cmd_per_adv_clear, NULL), \
 	CMD(BT_HCI_CMD_LE_READ_PERIODIC_ADV_LIST_SIZE, \
-					cmd_read_per_adv_list_size, NULL)
+					cmd_read_per_adv_list_size, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_TX_POWER, cmd_read_tx_power, NULL)
 
 static const struct btdev_cmd cmd_le_5_0[] = {
 	CMD_COMMON_ALL,
@@ -4240,6 +4257,7 @@ static void set_le_50_commands(struct btdev *btdev)
 	btdev->commands[38] |= 0x10;	/* LE Remove Periodic Adv List */
 	btdev->commands[38] |= 0x20;	/* LE Clear Periodic Adv List */
 	btdev->commands[38] |= 0x40;	/* LE Read Periodic Adv List Size */
+	btdev->commands[38] |= 0x80;	/* LE Read Transmit Power */
 	btdev->cmds = cmd_le_5_0;
 }
 
-- 
2.25.1

