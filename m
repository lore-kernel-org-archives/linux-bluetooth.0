Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jan 2022 22:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiADW4j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiADW4h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jan 2022 17:56:37 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B78C061761
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jan 2022 14:56:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g2so33900525pgo.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jan 2022 14:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEBOeQfiZGwcpCPzvtFGq4lfkNKoOI96YebbQ3auNwA=;
        b=AwzWA+IE/Lq278lohq9NQ4NugPuhkBk+zP/E0ww3NrWfUTammrd1yM9mKhzHiFzunV
         JdEw7i04ET4Bw+yNUd9BArdUXm1orzmp68GKtc60sQFD61UErv1/GhWgThL05cUIFjaX
         j/uAifhVQde9TUyYPQteeIQTACzH2xWNEKDY1SL3vKmVMqQk6wJqD6W5ocn4/g0GG6vz
         aEVIyfCuv4MQp/nMeaPrp5czY09dW5wpCFnc8HcpZTsWYmDXgXlEl6hkof9qZ88ZtiRS
         l/e2SuYmoK62WCEyWdo6PLScc1+bdENXs4MMUrF/Atmg97z2GvVuficX3BvuyaGrOLRf
         hyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEBOeQfiZGwcpCPzvtFGq4lfkNKoOI96YebbQ3auNwA=;
        b=0Dtea1OeC3Q7te3Jvgw8hF4dixgUFRiqVFXm91gaeZdxQabjuOfck/tLmueIaYq1ZD
         ZV5bc0J/L1UnaU8AQwJUyDV6j8kguSYd/7RRKP0kRtbf8FLE/fFE0JOduc3dsKLo7Jxr
         7qmuuU0vRKVNkIMxrnA6ghv1wYdJNtj+WxnKBgcVWLakpwnbO+vQsDI65l06k3cGz7fR
         1htvA3VjNAZW5j5JR7X/+HzjPhCw9qBguKRUkd5Er0Et2ZwhP6QGZ1jgrqPOK4uwku5U
         CTgrIzlyS5sB5LP9fmAe+BqlcgacSAn658fFh1xT+i6AqHS2lMIbQMjC6YygFo3rVVsz
         Xzmg==
X-Gm-Message-State: AOAM5322/VxW9MgcjjVJaZ8/ILNTVoTKqiUcDspEW3MK0+JEIOMAcpLX
        4+SszkYsXBhx9qarQvCS7sjH8wX136E=
X-Google-Smtp-Source: ABdhPJxv9YRfI3nY96+XyQmb0oZ5IjgIk0Y7Zy9aHs9vL63unGQ3jck59dT3vMY9GKvw9P6yMujkUA==
X-Received: by 2002:a63:cf04:: with SMTP id j4mr45480621pgg.278.1641336996371;
        Tue, 04 Jan 2022 14:56:36 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l12sm28472484pfc.181.2022.01.04.14.56.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:56:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] emulator: Add support for vendor commands
Date:   Tue,  4 Jan 2022 14:56:35 -0800
Message-Id: <20220104225635.2997485-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for vendor commands reserving a single opcode (0xfc10)
so it can be extended using subcommands, similar to how MSFT works.

The first subcommand (0x00) enables the emulator to generate arbitrary
events using the commands parameters:

> tools/hcitool cmd 3f 10 00 22 24 d0 d0 d0 d0 d0 d0 ff ff
< HCI Command: Vendor (0x3f|0x0010) plen 11
        00 22 24 d0 d0 d0 d0 d0 d0 ff ff
	."$........
Bluetooth: hci0: Malformed HCI Event: 0x22
> HCI Event: Inquiry Result with R.. (0x22) plen 9
        Num responses: 36
        Page scan repetition mode: Reserved (0xff)
        Page period mode: Reserved (0xff)
        Class: 0xffffd0
          Major class: Uncategorized, specific device code not specified
          Minor class: 0x34
          Limited Discoverable Mode
          invalid service class
        Clock offset: 0x6368
        RSSI: 105 dBm (0x69)
> HCI Event: Command Complete (0x0e) plen 4
      Vendor (0x3f|0x0010) ncmd 1
        Status: Success (0x00)
---
 emulator/btdev.c | 68 ++++++++++++++++++++++++++++++++++++++++++------
 emulator/btdev.h |  1 +
 emulator/main.c  |  1 +
 emulator/vhci.c  |  5 ++++
 emulator/vhci.h  |  1 +
 5 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 41410dd05..002ebf3e7 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -34,6 +34,7 @@
 #include "src/shared/queue.h"
 #include "monitor/bt.h"
 #include "monitor/msft.h"
+#include "monitor/emulator.h"
 #include "btdev.h"
 
 #define AL_SIZE			16
@@ -142,6 +143,8 @@ struct btdev {
 	const struct btdev_cmd *cmds;
 	uint16_t msft_opcode;
 	const struct btdev_cmd *msft_cmds;
+	uint16_t emu_opcode;
+	const struct btdev_cmd *emu_cmds;
 	bool aosp_capable;
 
 	uint16_t default_link_policy;
@@ -6586,12 +6589,11 @@ static const struct btdev_cmd *run_cmd(struct btdev *btdev,
 	return NULL;
 }
 
-static const struct btdev_cmd *msft_cmd(struct btdev *btdev, const void *data,
-								uint8_t len)
+static const struct btdev_cmd *vnd_cmd(struct btdev *btdev, uint8_t op,
+					const struct btdev_cmd *cmd,
+					const void *data, uint8_t len)
 {
-	const struct btdev_cmd *cmd;
-
-	for (cmd = btdev->msft_cmds; cmd->func; cmd++) {
+	for (; cmd && cmd->func; cmd++) {
 		if (cmd->opcode != ((uint8_t *)data)[0])
 			continue;
 
@@ -6599,10 +6601,10 @@ static const struct btdev_cmd *msft_cmd(struct btdev *btdev, const void *data,
 	}
 
 	util_debug(btdev->debug_callback, btdev->debug_data,
-			"Unsupported MSFT subcommand 0x%2.2x\n",
+			"Unsupported Vendor subcommand 0x%2.2x\n",
 			((uint8_t *)data)[0]);
 
-	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, btdev->msft_opcode);
+	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, op);
 
 	return NULL;
 }
@@ -6612,8 +6614,11 @@ static const struct btdev_cmd *default_cmd(struct btdev *btdev, uint16_t opcode,
 {
 	const struct btdev_cmd *cmd;
 
+	if (btdev->emu_opcode == opcode)
+		return vnd_cmd(btdev, opcode, btdev->emu_cmds, data, len);
+
 	if (btdev->msft_opcode == opcode)
-		return msft_cmd(btdev, data, len);
+		return vnd_cmd(btdev, opcode, btdev->msft_cmds, data, len);
 
 	for (cmd = btdev->cmds; cmd->func; cmd++) {
 		if (cmd->opcode != opcode)
@@ -7049,3 +7054,50 @@ int btdev_set_aosp_capable(struct btdev *btdev, bool enable)
 
 	return 0;
 }
+
+static int cmd_emu_test_event(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct emu_cmd_test_event *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	if (len < sizeof(*cmd)) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	send_event(dev, cmd->evt, cmd->data, len - sizeof(*cmd));
+
+done:
+	cmd_complete(dev, dev->emu_opcode, &status, sizeof(status));
+
+	return 0;
+}
+
+#define CMD_EMU \
+	CMD(EMU_SUBCMD_TEST_EVENT, cmd_emu_test_event, NULL)
+
+static const struct btdev_cmd cmd_emu[] = {
+	CMD_EMU,
+	{}
+};
+
+int btdev_set_emu_opcode(struct btdev *btdev, uint16_t opcode)
+{
+	if (!btdev)
+		return -EINVAL;
+
+	switch (btdev->type) {
+	case BTDEV_TYPE_BREDRLE:
+	case BTDEV_TYPE_BREDRLE50:
+	case BTDEV_TYPE_BREDRLE52:
+		btdev->emu_opcode = opcode;
+		btdev->emu_cmds = cmd_emu;
+		return 0;
+	case BTDEV_TYPE_BREDR:
+	case BTDEV_TYPE_LE:
+	case BTDEV_TYPE_AMP:
+	case BTDEV_TYPE_BREDR20:
+	default:
+		return -ENOTSUP;
+	}
+}
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 9493938c6..228bf205c 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -102,3 +102,4 @@ bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
 
 int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode);
 int btdev_set_aosp_capable(struct btdev *btdev, bool enable);
+int btdev_set_emu_opcode(struct btdev *btdev, uint16_t opcode);
diff --git a/emulator/main.c b/emulator/main.c
index 3c215efbc..bd9831449 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -193,6 +193,7 @@ int main(int argc, char *argv[])
 		if (debug_enabled)
 			vhci_set_debug(vhci, vhci_debug, UINT_TO_PTR(i), NULL);
 
+		vhci_set_emu_opcode(vhci, 0xfc10);
 		vhci_set_msft_opcode(vhci, 0xfc1e);
 	}
 
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 014df87d2..4295e30ef 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -252,3 +252,8 @@ int vhci_set_aosp_capable(struct vhci *vhci, bool enable)
 
 	return vhci_debugfs_write(vhci, "aosp_capable", &val, sizeof(val));
 }
+
+int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode)
+{
+	return btdev_set_emu_opcode(vhci->btdev, opcode);
+}
diff --git a/emulator/vhci.h b/emulator/vhci.h
index a601d3934..c42e8bde1 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -27,3 +27,4 @@ int vhci_set_force_suspend(struct vhci *vhci, bool enable);
 int vhci_set_force_wakeup(struct vhci *vhci, bool enable);
 int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
+int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
-- 
2.33.1

