Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF6C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 17:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C9060D07
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 17:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhEQRk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhEQRk0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 13:40:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FCC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 10:39:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so17496pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LnM73gtFwZhQsjDldWI9OEK0vZ+mPcvxC3OOJFqFQ8E=;
        b=Del1+MdjZGgbAquBuqgsu8UXIx5tLaEtn6AfCji/hel6Fo1/lwlctCCCuXoopQvtPM
         BsUsVP6zTxOk05i5ycaax0LN2gRK4kwoXRdejor4d6kAiYuj6GZnovBsao6SbTDDUgIK
         aQwmoT7bPJ//hqG7u2SogekK/XGsW8OIdK3i6tqjfD+kLb5fXBquhiYKErl5/fyDxXYB
         1RHujfzTgUC6edAWvu/1KezopS51NhZL0eEUhHGNmVMJjW9vxOEqYAr+TyhoAh4qLRPx
         lONABQQsPvZu4SFtOv4my4QJ8a7FB12oq5yj0Nz1o2/qJ7EHTzRrvqhdBTUjZuwOLzDe
         v5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LnM73gtFwZhQsjDldWI9OEK0vZ+mPcvxC3OOJFqFQ8E=;
        b=bLBvtqtCo/v0d2XoLg5iLWvrfTmjIG0j2+Jaix40nv6wuPNoFfKbxmct8GWDBRbYdF
         VgReOgyfYSBH0W8UdLixqNjexYQvso9yYW3oSfPoQMhWziwuCq+IHonW6+XDuYHKt5lI
         df9VhkFKdzwJ1v5wTtyOBucPdsFb79vqrguZTmqo1C1WTrWTw+MJD/Pk04bV2TC69VgO
         5OZEC+YgNSGH4c73s5TGB57r5mP/AkFeJsOvr6pTaHvfDf26s7JPYZ2NoZXFBOlvRkn/
         Otp1MkhTR7NYau5d9AsEoWiB41tuOELb77k1X5WF7RR7RGjQ4NEsjjmA8rSeRG462knt
         XrRA==
X-Gm-Message-State: AOAM531zcyh39aOmxznJucwGk4Xox7sVIqBkJ5AX2zoGnkiIDLKsdTw2
        oDhtUXrKZXgXCM70DCG88J3Xy87rK0c=
X-Google-Smtp-Source: ABdhPJxas59bBGQa85JXzJupQv4sKg2CHBR/yMPn/9xDfkbsI9d5MAP+jW5GEY5ois1c+THn+pfYKg==
X-Received: by 2002:a17:90b:1e4e:: with SMTP id pi14mr269815pjb.120.1621273147992;
        Mon, 17 May 2021 10:39:07 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p8sm5301457pfw.165.2021.05.17.10.39.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:39:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Add support for Add/Remove White List
Date:   Mon, 17 May 2021 10:39:06 -0700
Message-Id: <20210517173906.575688-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Add to/Remove from White List.
---
 emulator/btdev.c | 104 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 50407d9a2..2fd452970 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,6 +33,8 @@
 #include "monitor/bt.h"
 #include "btdev.h"
 
+#define WL_SIZE			16
+
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
 
@@ -154,6 +156,8 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
 
+	uint8_t  le_wl[WL_SIZE][7];
+
 	uint8_t le_local_sk256[32];
 
 	uint16_t sync_train_interval;
@@ -383,6 +387,16 @@ static int cmd_set_event_mask(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static void wl_clear(struct btdev *dev)
+{
+	int i;
+
+	for (i = 0; i < WL_SIZE; i++) {
+		dev->le_wl[i][0] = 0xff;
+		memset(&dev->le_wl[i][1], 0, 6);
+	}
+}
+
 static void btdev_reset(struct btdev *btdev)
 {
 	/* FIXME: include here clearing of all states that should be
@@ -391,6 +405,8 @@ static void btdev_reset(struct btdev *btdev)
 
 	btdev->le_scan_enable		= 0x00;
 	btdev->le_adv_enable		= 0x00;
+
+	wl_clear(btdev);
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -3333,17 +3349,19 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_white_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = 0;
+	rsp.size = WL_SIZE;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
 	return 0;
 }
 
-static int cmd_clear_wl(struct btdev *dev, const void *data, uint8_t len)
+static int cmd_wl_clear(struct btdev *dev, const void *data, uint8_t len)
 {
 	uint8_t status;
 
+	wl_clear(dev);
+
 	status = BT_HCI_ERR_SUCCESS;
 	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_WHITE_LIST, &status,
 						sizeof(status));
@@ -3351,6 +3369,77 @@ static int cmd_clear_wl(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_add_to_white_list *cmd = data;
+	uint8_t status;
+	bool exists = false;
+	int i, pos = -1;
+
+	/* Valid range for address type is 0x00 to 0x01 */
+	if (cmd->addr_type > 0x01)
+		return -EINVAL;
+
+	for (i = 0; i < WL_SIZE; i++) {
+		if (dev->le_wl[i][0] == cmd->addr_type &&
+				!memcmp(&dev->le_wl[i][1],
+							cmd->addr, 6)) {
+			exists = true;
+			break;
+		} else if (pos < 0 && dev->le_wl[i][0] == 0xff)
+			pos = i;
+	}
+
+	if (exists)
+		return -EALREADY;
+
+	if (pos < 0) {
+		cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
+					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+		return 0;
+	}
+
+	dev->le_wl[pos][0] = cmd->addr_type;
+	memcpy(&dev->le_wl[pos][1], cmd->addr, 6);
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+						&status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_remove_from_white_list *cmd = data;
+	uint8_t status;
+	int i, pos = -1;
+
+	/* Valid range for address type is 0x00 to 0x01 */
+	if (cmd->addr_type > 0x01)
+		return -EINVAL;
+
+	for (i = 0; i < WL_SIZE; i++) {
+		if (dev->le_wl[i][0] == cmd->addr_type &&
+			    !memcmp(&dev->le_wl[i][1], cmd->addr, 6)) {
+			pos = i;
+			break;
+		}
+	}
+
+	if (pos < 0)
+		return -EINVAL;
+
+	dev->le_wl[pos][0] = 0xff;
+	memset(&dev->le_wl[pos][1], 0, 6);
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+						&status, sizeof(status));
+
+	return 0;
+}
+
 static int cmd_conn_update(struct btdev *dev, const void *data, uint8_t len)
 {
 	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CONN_UPDATE);
@@ -3717,7 +3806,9 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 	CMD(BT_HCI_CMD_LE_CREATE_CONN, cmd_le_create_conn, \
 					cmd_le_create_conn_complete), \
 	CMD(BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, cmd_read_wl_size, NULL), \
-	CMD(BT_HCI_CMD_LE_CLEAR_WHITE_LIST, cmd_clear_wl, NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_WHITE_LIST, cmd_wl_clear, NULL), \
+	CMD(BT_HCI_CMD_LE_ADD_TO_WHITE_LIST, cmd_add_wl, NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST, cmd_remove_wl, NULL), \
 	CMD(BT_HCI_CMD_LE_CONN_UPDATE, cmd_conn_update, \
 					cmd_conn_update_complete), \
 	CMD(BT_HCI_CMD_LE_READ_REMOTE_FEATURES, cmd_le_read_remote_features, \
@@ -4910,6 +5001,8 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[26] |= 0x10;	/* LE Create Connection */
 	btdev->commands[26] |= 0x40;	/* LE Read White List Size */
 	btdev->commands[26] |= 0x80;	/* LE Clear White List */
+	btdev->commands[27] |= 0x01;	/* LE Add Device to White List */
+	btdev->commands[27] |= 0x02;	/* LE Remove Device from White List */
 	btdev->commands[27] |= 0x04;	/* LE Connection Update */
 	btdev->commands[27] |= 0x20;	/* LE Read Remote Used Features */
 	btdev->commands[27] |= 0x40;	/* LE Encrypt */
@@ -5207,6 +5300,8 @@ static void set_le_states(struct btdev *btdev)
 	btdev->le_states[3] = 0xff;
 	btdev->le_states[4] = 0xff;
 	btdev->le_states[5] = 0x03;
+
+	wl_clear(btdev);
 }
 
 static void set_amp_features(struct btdev *btdev)
@@ -5421,9 +5516,10 @@ static const struct btdev_cmd *default_cmd(struct btdev *btdev, uint16_t opcode,
 		}
 	}
 
-failed:
 	util_debug(btdev->debug_callback, btdev->debug_data,
 			"Unsupported command 0x%4.4x\n", opcode);
+
+failed:
 	cmd_status(btdev, status, opcode);
 
 	return NULL;
-- 
2.30.2

