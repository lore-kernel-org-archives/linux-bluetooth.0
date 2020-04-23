Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0472AC55193
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F6720724
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7WRdzpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgDWVzK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgDWVzJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 17:55:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA061C09B042
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s18so886151pgl.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KKOb2C9dKqnGrY0+vf6D1MbWO6xCggSYV+3P1ig+TNI=;
        b=E7WRdzpQsh+6rdSGygAKQylX2O70bAAMaE2PvxJSq/EWKIYcKPH7kO0BhM6LNoSh6o
         m54APbiw2KQfdyTpq5x/sbntwUmQlXvihk8R86kNEs5SkIZYQL9NOtMpcWr0X39Lo77H
         4BL9Waoa4QKKmQYkAqWHcHr8bfD+OV9AWZJa0ncGkdAVnVxUyokoQsNUEpLP02qQ9XBO
         z6qf+CGyOS+i/wnjyhor5bgljiChZ5nNvoDx4qUGPGQpnK4PLbiV1l81NNrm4QIg1kyy
         T3ZL0SZ6aNhqydm5Gj8EaXAf2bmXJq/TPkj/PhlIXpPNZ3mzstB4EDSjiCoLBnSfao7Q
         RV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKOb2C9dKqnGrY0+vf6D1MbWO6xCggSYV+3P1ig+TNI=;
        b=nFvVuatasTGTaPOwzJ0+BzeU8B54FnpGJuSqBxQER3iZIaW38BdAUU4DziVri4cRha
         YmcJXcgSw8xWeYYI3A5RVvd4rPxfSMtpSMdGcxNBC4pu03EtHEoL2+qiG/DjMYMlGWIH
         HvvdQzokK1A3X15uZyZhu5UwdND5OnY0nUjzxXgtFJ9myYg7+FvTxm7jIdCT/geSPIjy
         mN8j3MbVmlRxn6/kMTk8797SlGWgDa4BQ50rOO1baTaTeWXZp/5XiAe0J9VzHclELHI9
         zsaYoHd4QP1kpwjSY6q59UnHl960WEav3lvNY7380Le+z4Ub56R3r6jYWW5QIsxQYRYw
         SxrQ==
X-Gm-Message-State: AGi0PuZpqY9ENk0+5Dtqx2eUpeDfWp/U44WxTT46FDEFrrDsHoRN/B0t
        1d1LX/E2BL6VQEkM1ijP1JvkU2mxhb8=
X-Google-Smtp-Source: APiQypKpuk7gTHjoFxJNLp97nBQKmQ9Oa/nnDGTpqXEWjNlaeeCYQ+uNLF0pZc3j1Wk72nkxQ8RH1g==
X-Received: by 2002:a63:2143:: with SMTP id s3mr5816663pgm.20.1587678908867;
        Thu, 23 Apr 2020 14:55:08 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k12sm2972294pgj.33.2020.04.23.14.55.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:55:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] emulator: Add support for LE Remove ISO Data Path
Date:   Thu, 23 Apr 2020 14:55:01 -0700
Message-Id: <20200423215501.427266-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423215501.427266-1-luiz.dentz@gmail.com>
References: <20200423215501.427266-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements support for LE Remove ISO Data Path command.
---
 emulator/btdev.c | 25 +++++++++++++++++++++++++
 monitor/bt.h     |  2 +-
 monitor/packet.c |  2 +-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1b3ad6442..46d71d77e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2508,6 +2508,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_le_scan_phy *lsp;
 	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
 	const struct bt_hci_cmd_le_reject_cis *lrcis;
+	const struct bt_hci_cmd_le_remove_iso_path *lerip;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -3907,6 +3908,30 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 		break;
 
+	case BT_HCI_CMD_LE_REMOVE_ISO_PATH:
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
+			goto unsupported;
+
+		lerip = data;
+		status = BT_HCI_ERR_SUCCESS;
+
+		if (!btdev->conn || le16_to_cpu(lerip->handle) != ISO_HANDLE)
+			status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+
+		switch (lerip->direction) {
+		case 0x00:
+			btdev->le_iso_path[0] = 0x00;
+			break;
+		case 0x01:
+			btdev->le_iso_path[1] = 0x00;
+			break;
+		default:
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+		}
+
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
 	case BT_HCI_CMD_LE_SET_HOST_FEATURE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
diff --git a/monitor/bt.h b/monitor/bt.h
index 39ca1e39a..32ea10ca4 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2780,7 +2780,7 @@ struct bt_hci_cmd_le_setup_iso_path {
 #define BT_HCI_BIT_LE_REMOVE_ISO_PATH		BT_HCI_CMD_BIT(43, 4)
 struct bt_hci_cmd_le_remove_iso_path {
 	uint16_t handle;
-	uint8_t  path_dir;
+	uint8_t  direction;
 } __attribute__ ((packed));
 
 #define BT_HCI_CMD_LE_ISO_TX_TEST		0x2070
diff --git a/monitor/packet.c b/monitor/packet.c
index 777a52205..5d8709c42 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8118,7 +8118,7 @@ static void le_remove_iso_path_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_remove_iso_path *cmd = data;
 
 	print_field("Connection Handle: %d", le16_to_cpu(cmd->handle));
-	print_iso_dir("Data Path Direction", cmd->path_dir);
+	print_iso_dir("Data Path Direction", cmd->direction);
 }
 
 static void le_req_peer_sca_cmd(const void *data, uint8_t size)
-- 
2.25.3

