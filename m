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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B90C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 21:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B99610CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 21:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbhEQVxm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 17:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbhEQVxm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 17:53:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB41C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 14:52:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n3so3928907plf.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMdfX1zgoPrATEGR6a4lpiBF5FvWJEeX8CbAPXVUFvk=;
        b=iW1EW0QxUG+8ABD4yEvWpG/kMMOyLcXxlh6GfDDbECjEZx4hSxhPNEmFbJ6uSMSTbI
         Dq4ZjZFV9MJDbVXNFg3Sfp3iAuOtGNfcj16a2gx4OSVnrn42gFLOLEWVFTOvoDP2dIdM
         /q+iJD6Fh3LRHBX182o5ThLchMFrPI8erxUD+mLKHegQvEV0412fbZAnkso6Jb0nUllE
         O2swqAogsGFlCplHFQSb/KRx4KBJ2KWw5lHMjiPdxI6nPGoJuA0xbL9hxpbVeWJDSPdf
         +nwIEQ2e+ImmqysWbgUZeF++lnp6aZGf6b7xp9mlZe58NH9YUXzQdA22nbzQ1SvxLjzr
         i+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMdfX1zgoPrATEGR6a4lpiBF5FvWJEeX8CbAPXVUFvk=;
        b=gAcQWF6WkNpmMsV71dDn8cx6noOv2AVk5U0OCOdQFHmN+SArkoyagEnc0ttLiABBkP
         S2E0XRHZVc458YUd0FsEGku1qVMntd9AzBJyIMh96SOi0Dk5rLylOAs4/1AkaxgTuafD
         NgMDyE5lkdkTKVytpqwfXON/aV0guLEWdXIj6/gb4K3k7I+aRtDYhJU4zjoDmX5sclU7
         UYbXfjd0z6vebG88puD+cx464aAX0pysmQIfXFPSWI2oUEoJsoUguZyXstjeuiL1Y/v/
         HZDHEhDm+tz7iaF96v0WF+xTWYwakg3yxkEbVTqao+aKUXSRFtCx0H4VZK/JC1yoFqlP
         D+aA==
X-Gm-Message-State: AOAM53115mzo5nApmXSgH+VS3tffuRlGC6HABOPk7FF0vWtez8HIF6I1
        gl3OkS1usytAYpU7Gen+Kd6nzlZioL4=
X-Google-Smtp-Source: ABdhPJwFnGZjVUhPCwZ+rSloJBP7vCF/B+5Jwyl8GI4dyztGlY/mYDoSWuTmJuMaPwVpg2o115OPbQ==
X-Received: by 2002:a17:90b:3b8a:: with SMTP id pc10mr1555080pjb.203.1621288344563;
        Mon, 17 May 2021 14:52:24 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o4sm10837664pfk.15.2021.05.17.14.52.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 14:52:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Add resolving list support
Date:   Mon, 17 May 2021 14:52:23 -0700
Message-Id: <20210517215223.612671-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for commands related to resolving list.
---
 emulator/btdev.c | 211 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 2fd452970..692fabd71 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -34,6 +34,7 @@
 #include "btdev.h"
 
 #define WL_SIZE			16
+#define RL_SIZE			16
 
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
@@ -157,6 +158,9 @@ struct btdev {
 	uint8_t  le_iso_path[2];
 
 	uint8_t  le_wl[WL_SIZE][7];
+	uint8_t  le_rl[RL_SIZE][39];
+	uint8_t  le_rl_enable;
+	uint16_t le_rl_timeout;
 
 	uint8_t le_local_sk256[32];
 
@@ -3440,6 +3444,191 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_add_to_resolv_list *cmd = data;
+	uint8_t status;
+	bool exists = false;
+	int i, pos = -1;
+
+	/* Valid range for address type is 0x00 to 0x01 */
+	if (cmd->addr_type > 0x01)
+		return -EINVAL;
+
+	for (i = 0; i < RL_SIZE; i++) {
+		if (dev->le_rl[i][0] == cmd->addr_type &&
+				!memcmp(&dev->le_rl[i][1], cmd->addr, 6)) {
+			exists = true;
+			break;
+		} else if (pos < 0 && dev->le_rl[i][0] == 0xff)
+			pos = i;
+	}
+
+	if (exists)
+		return -EALREADY;
+
+	if (pos < 0) {
+		cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
+					BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST);
+		return 0;
+	}
+
+	dev->le_rl[pos][0] = cmd->addr_type;
+	memcpy(&dev->le_rl[pos][1], cmd->addr, 6);
+	memcpy(&dev->le_rl[pos][7], cmd->peer_irk, 16);
+	memcpy(&dev->le_rl[pos][23], cmd->local_irk, 16);
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
+						&status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_remove_from_resolv_list *cmd = data;
+	uint8_t status;
+	int i, pos = -1;
+
+	/* Valid range for address type is 0x00 to 0x01 */
+	if (cmd->addr_type > 0x01)
+		return -EINVAL;
+
+	for (i = 0; i < RL_SIZE; i++) {
+		if (dev->le_rl[i][0] == cmd->addr_type &&
+				!memcmp(&dev->le_rl[i][1], cmd->addr, 6)) {
+			pos = i;
+			break;
+		}
+	}
+
+	if (pos < 0)
+		return -EINVAL;
+
+	dev->le_rl[pos][0] = 0xff;
+	memset(&dev->le_rl[pos][1], 0, 38);
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
+						&status, sizeof(status));
+
+	return 0;
+}
+
+static void rl_clear(struct btdev *dev)
+{
+	int i;
+
+	for (i = 0; i < RL_SIZE; i++) {
+		dev->le_rl[i][0] = 0xff;
+		memset(&dev->le_rl[i][1], 0, 38);
+	}
+}
+
+static int cmd_clear_rl(struct btdev *dev, const void *data, uint8_t len)
+{
+	uint8_t status;
+
+	rl_clear(dev);
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_RESOLV_LIST,
+						&status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_le_read_resolv_list_size rsp;
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.size = RL_SIZE;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
+							&rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_peer_rl_addr(struct btdev *dev, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_read_peer_resolv_addr *cmd = data;
+	struct bt_hci_rsp_le_read_peer_resolv_addr rsp;
+
+	/* Valid range for address type is 0x00 to 0x01 */
+	if (cmd->addr_type > 0x01)
+		return -EINVAL;
+
+	rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	memset(rsp.addr, 0, 6);
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_PEER_RESOLV_ADDR,
+							&rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_local_rl_addr(struct btdev *dev, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_read_local_resolv_addr *cmd = data;
+	struct bt_hci_rsp_le_read_local_resolv_addr rsp;
+
+	/* Valid range for address type is 0x00 to 0x01 */
+	if (cmd->addr_type > 0x01)
+		return -EINVAL;
+
+	rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	memset(rsp.addr, 0, 6);
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR,
+							&rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_set_rl_enable(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_resolv_enable *cmd = data;
+	uint8_t status;
+
+	/* Valid range for address resolution enable is 0x00 to 0x01 */
+	if (cmd->enable > 0x01)
+		return -EINVAL;
+
+	dev->le_rl_enable = cmd->enable;
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+						&status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_set_rl_timeout(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_resolv_timeout *cmd = data;
+	uint16_t timeout;
+	uint8_t status;
+
+	timeout = le16_to_cpu(cmd->timeout);
+
+	/* Valid range for RPA timeout is 0x0001 to 0xa1b8 */
+	if (timeout < 0x0001 || timeout > 0xa1b8)
+		return -EINVAL;
+
+	dev->le_rl_timeout = timeout;
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT,
+						&status, sizeof(status));
+
+	return 0;
+}
+
 static int cmd_conn_update(struct btdev *dev, const void *data, uint8_t len)
 {
 	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CONN_UPDATE);
@@ -3828,7 +4017,16 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 	CMD(BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY, cmd_conn_param_neg_reply, \
 					cmd_conn_param_neg_reply_complete), \
 	CMD(BT_HCI_CMD_LE_READ_LOCAL_PK256, cmd_read_local_pk256, NULL), \
-	CMD(BT_HCI_CMD_LE_GENERATE_DHKEY, cmd_gen_dhkey, NULL)
+	CMD(BT_HCI_CMD_LE_GENERATE_DHKEY, cmd_gen_dhkey, NULL), \
+	CMD(BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST, cmd_add_rl,  NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST, cmd_remove_rl, NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_RESOLV_LIST, cmd_clear_rl, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE, cmd_read_rl_size, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_PEER_RESOLV_ADDR, cmd_read_peer_rl_addr, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR, cmd_read_local_rl_addr, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_SET_RESOLV_ENABLE, cmd_set_rl_enable, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT, cmd_set_rl_timeout, NULL)
 
 static int cmd_set_default_phy(struct btdev *dev, const void *data,
 							uint8_t len)
@@ -5022,6 +5220,14 @@ static void set_le_commands(struct btdev *btdev)
 	/* Extra LE commands for >= 4.2 adapters */
 	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
 	btdev->commands[34] |= 0x04;	/* LE Generate DHKey */
+	btdev->commands[34] |= 0x08;	/* LE Add Device To Resolving List */
+	btdev->commands[34] |= 0x10;	/* LE Remove Dev From Resolving List */
+	btdev->commands[34] |= 0x20;	/* LE Clear Resolving List */
+	btdev->commands[34] |= 0x40;	/* LE Read Resolving List Size */
+	btdev->commands[34] |= 0x80;	/* LE Read Peer Resolvable Address */
+	btdev->commands[35] |= 0x01;	/* LE Read Local Resolvable Address */
+	btdev->commands[35] |= 0x02;	/* LE Set Address Resolution Enable */
+	btdev->commands[35] |= 0x04;	/* LE Set RPA Timeout */
 
 	btdev->cmds = cmd_le;
 
@@ -5302,6 +5508,9 @@ static void set_le_states(struct btdev *btdev)
 	btdev->le_states[5] = 0x03;
 
 	wl_clear(btdev);
+	rl_clear(btdev);
+	btdev->le_rl_enable = 0x00;
+	btdev->le_rl_timeout = 0x0384;	/* 900 secs or 15 minutes */
 }
 
 static void set_amp_features(struct btdev *btdev)
-- 
2.30.2

