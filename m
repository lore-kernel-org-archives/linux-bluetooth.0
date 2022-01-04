Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CFCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jan 2022 23:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiADXna (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiADXn2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jan 2022 18:43:28 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0924AC061761
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jan 2022 15:43:28 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q3so29236151pfs.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jan 2022 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4lAUsAf7ayfneI8w7zMXJtpkbE6S0rN4UQLiPx13iYo=;
        b=Jb2+SZe7ybffKWTmwzv6o3TJXV/h951FuMV2+uer4bBSqEBXmijKDiWkt/8n4FSrk+
         sc1ZVwqhkB800XCMM95LQ1eAdFNaiPRmV2Pcmfj/PULg43eSnq8feELMv5QJ69x485IA
         gycliEh4pahT8UMjVlzFhmvsqSjGyb49pkSkwQYcVz4T9sRSTUVKeFiFvuAtkoXOIMi+
         Lxhbd2RSDyts3OuMyBM78O1ZSUqYtHD5LaFg4LeBY6PtbWzPJc0fflS7QrrR+w6s9Oab
         x3wKSxepZfzspjzc70N+c/D9yQv12M1ZUbsfUOcXyjhbCqBmQGs1jJWQNREvP7aaCfFr
         Rsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4lAUsAf7ayfneI8w7zMXJtpkbE6S0rN4UQLiPx13iYo=;
        b=4o+AO0ov0CVYw36XD5j7faX/oeX1vXo3PYZJJLdWpF31YEKlfawW+LMyGwhP289qNF
         jVf84JM4O68lD5RA5RBrAVwD7S8jJXShXgo670NhbiLpJe9wEkDCWsCPYODND2eSYqh0
         C14SMh5GEasOO9q0wjAo1yNsKrHPoU5zDKU24ireJTIIj43i7MIVRozhGpMi31PnPmv6
         rpDJ/ZYMEXkZU4OMAj9FS9KOUA7T48BDVjocvlrYbV/H3ePzpM7tkzec+hZ0cJxRRHvx
         9ofjyClEqwBSjpJRaOrCThyTHJ61PrfL2xdy+lMmSAofLgotxhbXRATfEqrCwrlojXOg
         Mb3A==
X-Gm-Message-State: AOAM533AzLscM79kIDDVoZRIvtx54PyvG3KaG/VnDyoHGLvx51xMjX0p
        4l6ym+KnCiCO9mItfTl4XGyV1g5N3+w=
X-Google-Smtp-Source: ABdhPJww/x20KzbQU1LG700JgFZd/XLpBQktMT3rtNDjOjtZSwOaHO/JDmQire5WDt5A40c/6kJS8g==
X-Received: by 2002:a62:7ed4:0:b0:4bb:5951:aac7 with SMTP id z203-20020a627ed4000000b004bb5951aac7mr53025107pfc.31.1641339807254;
        Tue, 04 Jan 2022 15:43:27 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l18sm400388pjy.6.2022.01.04.15.43.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 15:43:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2] emulator: Add support for vendor commands
Date:   Tue,  4 Jan 2022 15:43:26 -0800
Message-Id: <20220104234326.3001935-1-luiz.dentz@gmail.com>
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
v2: Fix missing monitor/emulator.h

 emulator/btdev.c   | 68 ++++++++++++++++++++++++++++++++++++++++------
 emulator/btdev.h   |  1 +
 emulator/main.c    |  1 +
 emulator/vhci.c    |  5 ++++
 emulator/vhci.h    |  1 +
 monitor/emulator.h | 18 ++++++++++++
 6 files changed, 86 insertions(+), 8 deletions(-)
 create mode 100644 monitor/emulator.h

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
diff --git a/monitor/emulator.h b/monitor/emulator.h
new file mode 100644
index 000000000..dc9351e4e
--- /dev/null
+++ b/monitor/emulator.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2014  Intel Corporation
+ *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ */
+
+#define EMU_SUBCMD_TEST_EVENT 0x00
+
+struct emu_cmd_test_event {
+	uint8_t subcmd;
+	uint8_t evt;
+	uint8_t data[];
+} __attribute__((packed));
-- 
2.33.1

