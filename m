Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B964C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiBXAbK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBXAbI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:08 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F56E2AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso4233200pjk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hl0evxxrqp/Qfdb5sN8zGAfs6IrTTpCQEbp1CLx/B74=;
        b=beu4BcSo2bK/loLJ3zPIxQIcs9S16Wdz0JUo3KsFKtWL6NxvF12Il3VOuENnvnNIvK
         xkCSp3nawBrBS1zvz0j6lg3hupmhnO1N2Wwn7Sbch4x2WwJP3FvFBXFGd02PWbyF4xPu
         YXKhYin4Sow1WgNV2rjpAZngIzVw0P+2+AkifO6rAD8LnfCD0HdiI3GzrxifaWYLMxJQ
         2FoGk+sELJUK/mrc8+9G2foECAWEtwfg7OvSLq5BfZEQ4lzsnpENRmA+PgKGV6SzMpNT
         dYhBsT7Jv0RTpzcmF1rrSQ9bjkR70zSCGoX9LoBpcuzmFYzu/jjbhncustoZwDumcijw
         i8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hl0evxxrqp/Qfdb5sN8zGAfs6IrTTpCQEbp1CLx/B74=;
        b=KT8RXAIfqZvd32J56SI4MYLTt51z8IZxGC3QT7dRIuRjbaQA7vlxVxwbR2PSXP1noz
         i1Q2eR8ZzYV0UugKK+1yEf0M4rK49IfWAWWYQ7EkJmIVLCzVLEIDK1JEYqDL3xqrpABR
         nY8NKIsk32NOZBLotQKyJgNHA55A4VjZ8dxR3CEyeHYUrJsgCaXWcIvkUDbt/qlSWpo2
         lsdQMUoHVmoMOCI8oPn86w9GM6DjxvX9zahj7Z9BtgP5620Iwwbmn/fhRygxNaFAVmCM
         0mOW7jmL4WbZFwPz6nWseK/YkeEauGn6gbTHco4ObYTcZ0joSomUlXme+820oyt3oW6l
         3Kvw==
X-Gm-Message-State: AOAM5308Xf0ZOMg9A2Je0+lmaoRzxk5Na7Ttr4fILNz3oIVxH6GRA/df
        pX4WJQhcMGgWzQ11mpcDGHv+H5UKXtQ=
X-Google-Smtp-Source: ABdhPJwDGyxLY6M4yzRHwDD8irOyMZ0mUI4ANFbN7OkgQwbvcB+2UnDy6BUMKdTzTGjVtkQTubmKxA==
X-Received: by 2002:a17:90a:10d0:b0:1bc:a943:b6e5 with SMTP id b16-20020a17090a10d000b001bca943b6e5mr3856855pje.86.1645662638801;
        Wed, 23 Feb 2022 16:30:38 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/11] btdev: Implements BT_HCI_CMD_LE_BIG_TERM_SYNC
Date:   Wed, 23 Feb 2022 16:30:27 -0800
Message-Id: <20220224003029.706163-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sends BT_HCI_EVT_DISCONNECT_COMPLETE when handling
BT_HCI_CMD_LE_BIG_TERM_SYNC.
---
 emulator/btdev.c | 39 +++++++++++++++++++++++++++++++++++++--
 monitor/bt.h     |  5 +++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 567377caa..6834ec1c2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6055,8 +6055,43 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 
 static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_big_term_sync *cmd = data;
+	struct bt_hci_rsp_le_big_term_sync rsp;
+	const struct queue_entry *entry;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	/* If the Host issues this command with a BIG_Handle that does not
+	 * exist, the Controller shall return the error code Unknown
+	 * Advertising Identifier (0x42).
+	 */
+	if (dev->big_handle != cmd->handle) {
+		rsp.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	rsp.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	rsp.handle = cmd->handle;
+
+	/* Cleanup existing connections */
+	for (entry = queue_get_entries(dev->conns); entry;
+					entry = entry->next) {
+		struct btdev_conn *conn = entry->data;
+
+		if (!conn->data)
+			continue;
+
+		rsp.status = BT_HCI_ERR_SUCCESS;
+		disconnect_complete(dev, conn->handle, BT_HCI_ERR_SUCCESS,
+								0x16);
+
+		conn_remove(conn);
+	}
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_BIG_TERM_SYNC, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
 static int cmd_req_peer_sca(struct btdev *dev, const void *data, uint8_t len)
diff --git a/monitor/bt.h b/monitor/bt.h
index 3bee11868..6ce6384a4 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2817,6 +2817,11 @@ struct bt_hci_cmd_le_big_term_sync {
 	uint8_t  handle;
 } __attribute__ ((packed));
 
+struct bt_hci_rsp_le_big_term_sync {
+	uint8_t  status;
+	uint8_t  handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_CMD_LE_REQ_PEER_SCA		0x206d
 #define BT_HCI_BIT_LE_REQ_PEER_SCA		BT_HCI_CMD_BIT(43, 2)
 struct bt_hci_cmd_le_req_peer_sca {
-- 
2.35.1

