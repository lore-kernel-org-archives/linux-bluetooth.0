Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC4CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1AC611EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhJTVvH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhJTVvF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 17:51:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7BFC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ls18so3417925pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A8abYeu+8xlEL8YmaLECkMCSJS4S4M8dTmXlYFq5hNk=;
        b=E23zW5Qh9vdiDCbd4jqw1h5vYkmr0Oz4Ve0GdqnGuAgEav70AVMVuE1nKcnc98LV+0
         oR0fsesKF1/AfAxRy/sFKrDkDOAYJvC0TrwEh4xjT/lhziKcIn3nQuGR78iEwWDWQNiU
         BL5+TrRO41BQQ79Vol7B+jmKmra567hgF3nutm9MrvgR255JnxKCFvsO4IDVNU9Y0x+Y
         fmjAdfKum0kb5C9Ay/eD6ysjhDzjQmVgrvQK+CqYdCQ5LIiK3fpHnF67jQD6YVqfF4QZ
         sx+6jXkch5t+hcRGY+ziHWLI1ddT7+JrqqVBGzsK9bx/VE9B4Y4r03nKdAQ3kK9qSPNn
         t6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8abYeu+8xlEL8YmaLECkMCSJS4S4M8dTmXlYFq5hNk=;
        b=ECGsi0xcrNKxsNdYQ4/aPWGRKcBlvZQNb6AonGhOIBkgTlMhM5TPXVtuJ/Eby/5FoG
         TLfTDvL4+iPYNTVL3oJC/axnGi2kWEJIVZ1BEW34cN4sT1NgJO0sNjAKAdds00wTFUPA
         QKJG4lt6eYnnThY9L5MR7zGloqmiP86Goy5FgzBG4uUXHdkTvDTjMZcTzxiCoyK/gKDk
         IULSr53i8+6PPCWq6o4TIuRdA4vj023wwFFxOiKiFkNU1T69X4GzINc5nykZcR2Z5Voq
         y5qhn08qy8lDMsh/2IIcZzUGCSm+3JKQfyQGur2m8GELIDBc9q2k6t2x7ZD2h30GaQLt
         fpjQ==
X-Gm-Message-State: AOAM530K9B70UrYLyRvKLqeMrPWiC5BhOqj6+M1O16FvPKcbn11hJt8B
        NHIT15ZlZDV5rJPE1PXN1QFDMHyhADM=
X-Google-Smtp-Source: ABdhPJylCcbfgoVGRIA7Pgc18BS8uMMOXNeAQ78x5l0yB6ZzAQfwMMuYOtckAFyFK7yxpKRYakSBCw==
X-Received: by 2002:a17:902:b68b:b0:13a:1239:b8d9 with SMTP id c11-20020a170902b68b00b0013a1239b8d9mr1550947pls.25.1634766529945;
        Wed, 20 Oct 2021 14:48:49 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b13sm7257664pjl.15.2021.10.20.14.48.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:48:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] emulator: Add initial support for MSFT vendor commands
Date:   Wed, 20 Oct 2021 14:48:43 -0700
Message-Id: <20211020214843.431327-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020214843.431327-1-luiz.dentz@gmail.com>
References: <20211020214843.431327-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial support for MSFT vendor commands and enable them
when in btvirt:

< HCI Command: Microsoft Ex.. (0x3f|0x001e) plen 1
      Read Supported Features (0x00)
> HCI Event: Command Complete (0x0e) plen 14
      Microsoft Extension (0x3f|0x001e) ncmd 1
      Read Supported Features (0x00)
        Status: Success (0x00)
        Features: 0x3f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          RSSI Monitoring feature for BR/EDR
          RSSI Monitoring feature for LE connections
          RSSI Monitoring of LE advertisements
          Advertising Monitoring of LE advertisements
          Verifying the validity of P-192 and P-256 keys
          Continuous Advertising Monitoring
        Event prefix length: 0
        Event prefix:
< HCI Command: Microsoft Ex.. (0x3f|0x001e) plen 2
      LE Set Advertisement Filter Enable (0x05)
        Enable: All filter conditions (0x01)
> HCI Event: Command Complete (0x0e) plen 5
      Microsoft Extension (0x3f|0x001e) ncmd 1
      LE Set Advertisement Filter Enable (0x05)
        Status: Success (0x00)
---
 emulator/btdev.c | 245 ++++++++++++++++++++++++++++++++++++++++++-----
 emulator/main.c  |   2 +
 2 files changed, 223 insertions(+), 24 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 18aefed11..096ba2da4 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,6 +33,7 @@
 #include "src/shared/ecc.h"
 #include "src/shared/queue.h"
 #include "monitor/bt.h"
+#include "monitor/msft.h"
 #include "btdev.h"
 
 #define AL_SIZE			16
@@ -139,6 +140,7 @@ struct btdev {
 	uint8_t  le_states[8];
 	const struct btdev_cmd *cmds;
 	uint16_t msft_opcode;
+	const struct btdev_cmd *msft_cmds;
 	bool aosp_capable;
 
 	uint16_t default_link_policy;
@@ -6440,41 +6442,76 @@ static void num_completed_packets(struct btdev *btdev, uint16_t handle)
 	}
 }
 
+static const struct btdev_cmd *run_cmd(struct btdev *btdev,
+					const struct btdev_cmd *cmd,
+					const void *data, uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_UNKNOWN_COMMAND;
+	int err;
+
+	err = cmd->func(btdev, data, len);
+	switch (err) {
+	case 0:
+		return cmd;
+	case -ENOTSUP:
+		status = BT_HCI_ERR_UNKNOWN_COMMAND;
+		break;
+	case -EINVAL:
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		break;
+	case -EPERM:
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		break;
+	default:
+		status = BT_HCI_ERR_UNSPECIFIED_ERROR;
+		break;
+	}
+
+	cmd_status(btdev, status, cmd->opcode);
+
+	return NULL;
+}
+
+static const struct btdev_cmd *msft_cmd(struct btdev *btdev, const void *data,
+								uint8_t len)
+{
+	const struct btdev_cmd *cmd;
+
+	for (cmd = btdev->msft_cmds; cmd->func; cmd++) {
+		if (cmd->opcode != ((uint8_t *)data)[0])
+			continue;
+
+		return run_cmd(btdev, cmd, data, len);
+	}
+
+	util_debug(btdev->debug_callback, btdev->debug_data,
+			"Unsupported MSFT subcommand 0x%2.2x\n",
+			((uint8_t *)data)[0]);
+
+	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, btdev->msft_opcode);
+
+	return NULL;
+}
+
 static const struct btdev_cmd *default_cmd(struct btdev *btdev, uint16_t opcode,
 						const void *data, uint8_t len)
 {
 	const struct btdev_cmd *cmd;
-	uint8_t status = BT_HCI_ERR_UNKNOWN_COMMAND;
-	int err;
+
+	if (btdev->msft_opcode == opcode)
+		return msft_cmd(btdev, data, len);
 
 	for (cmd = btdev->cmds; cmd->func; cmd++) {
 		if (cmd->opcode != opcode)
 			continue;
 
-		err = cmd->func(btdev, data, len);
-		switch (err) {
-		case 0:
-			return cmd;
-		case -ENOTSUP:
-			status = BT_HCI_ERR_UNKNOWN_COMMAND;
-			goto failed;
-		case -EINVAL:
-			status = BT_HCI_ERR_INVALID_PARAMETERS;
-			goto failed;
-		case -EPERM:
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-			goto failed;
-		default:
-			status = BT_HCI_ERR_UNSPECIFIED_ERROR;
-			goto failed;
-		}
+		return run_cmd(btdev, cmd, data, len);
 	}
 
 	util_debug(btdev->debug_callback, btdev->debug_data,
 			"Unsupported command 0x%4.4x\n", opcode);
 
-failed:
-	cmd_status(btdev, status, opcode);
+	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
 
 	return NULL;
 }
@@ -6719,14 +6756,174 @@ bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
 	return false;
 }
 
+static int cmd_msft_read_features(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct msft_rsp_read_supported_features rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.subcmd = MSFT_SUBCMD_READ_SUPPORTED_FEATURES;
+	rsp.features[0] = MSFT_MONITOR_BREDR_RSSI | MSFT_MONITOR_LE_RSSI |
+				MSFT_MONITOR_LE_LEGACY_RSSI |
+				MSFT_MONITOR_LE_ADV |
+				MSFT_MONITOR_SSP_VALIDATION |
+				MSFT_MONITOR_LE_ADV_CONTINUOS;
+
+	cmd_complete(dev, dev->msft_opcode, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_msft_monitor_rssi(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct msft_cmd_monitor_rssi *cmd = data;
+	struct msft_rsp_monitor_rssi rsp;
+	struct btdev_conn *conn;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.subcmd = MSFT_SUBCMD_MONITOR_RSSI;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn)
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+
+	cmd_complete(dev, dev->msft_opcode, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_msft_cancel_monitor_rssi(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct msft_cmd_cancel_monitor_rssi *cmd = data;
+	struct msft_rsp_cancel_monitor_rssi rsp;
+	struct btdev_conn *conn;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.subcmd = MSFT_SUBCMD_CANCEL_MONITOR_RSSI;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn)
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+
+	cmd_complete(dev, dev->msft_opcode, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_msft_le_monitor_adv(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct msft_cmd_le_monitor_adv *cmd = data;
+	struct msft_rsp_le_monitor_adv rsp;
+	static uint8_t handle;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.subcmd = MSFT_SUBCMD_LE_MONITOR_ADV;
+
+	switch (cmd->type) {
+	case MSFT_LE_MONITOR_ADV_PATTERN:
+	case MSFT_LE_MONITOR_ADV_UUID:
+	case MSFT_LE_MONITOR_ADV_IRK:
+	case MSFT_LE_MONITOR_ADV_ADDR:
+		rsp.handle = handle++;
+		break;
+	default:
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		break;
+	}
+
+	cmd_complete(dev, dev->msft_opcode, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_msft_le_cancel_monitor_adv(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct msft_rsp_le_cancel_monitor_adv rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.subcmd = MSFT_SUBCMD_LE_CANCEL_MONITOR_ADV;
+
+	cmd_complete(dev, dev->msft_opcode, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_msft_le_monitor_adv_enable(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct msft_rsp_le_cancel_monitor_adv rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.subcmd = MSFT_SUBCMD_LE_MONITOR_ADV_ENABLE;
+
+	cmd_complete(dev, dev->msft_opcode, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_msft_read_abs_rssi(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct msft_rsp_read_abs_rssi rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.subcmd = MSFT_SUBCMD_READ_ABS_RSSI;
+
+	cmd_complete(dev, dev->msft_opcode, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+#define CMD_MSFT \
+	CMD(MSFT_SUBCMD_READ_SUPPORTED_FEATURES, cmd_msft_read_features, \
+						NULL), \
+	CMD(MSFT_SUBCMD_MONITOR_RSSI, cmd_msft_monitor_rssi, NULL), \
+	CMD(MSFT_SUBCMD_CANCEL_MONITOR_RSSI, cmd_msft_cancel_monitor_rssi, \
+						NULL), \
+	CMD(MSFT_SUBCMD_LE_MONITOR_ADV, cmd_msft_le_monitor_adv, NULL),	\
+	CMD(MSFT_SUBCMD_LE_CANCEL_MONITOR_ADV, cmd_msft_le_cancel_monitor_adv, \
+						NULL), \
+	CMD(MSFT_SUBCMD_LE_MONITOR_ADV_ENABLE, cmd_msft_le_monitor_adv_enable, \
+						NULL), \
+	CMD(MSFT_SUBCMD_READ_ABS_RSSI, cmd_msft_read_abs_rssi, NULL)
+
+static const struct btdev_cmd cmd_msft[] = {
+	CMD_MSFT,
+	{}
+};
+
 int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode)
 {
 	if (!btdev)
 		return -EINVAL;
 
-	btdev->msft_opcode = opcode;
-
-	return 0;
+	switch (btdev->type) {
+	case BTDEV_TYPE_BREDRLE:
+	case BTDEV_TYPE_BREDRLE50:
+	case BTDEV_TYPE_BREDRLE52:
+		btdev->msft_opcode = opcode;
+		btdev->msft_cmds = cmd_msft;
+		return 0;
+	case BTDEV_TYPE_BREDR:
+	case BTDEV_TYPE_LE:
+	case BTDEV_TYPE_AMP:
+	case BTDEV_TYPE_BREDR20:
+	default:
+		return -ENOTSUP;
+	}
 }
 
 int btdev_set_aosp_capable(struct btdev *btdev, bool enable)
diff --git a/emulator/main.c b/emulator/main.c
index f64d46a5e..3c215efbc 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -192,6 +192,8 @@ int main(int argc, char *argv[])
 
 		if (debug_enabled)
 			vhci_set_debug(vhci, vhci_debug, UINT_TO_PTR(i), NULL);
+
+		vhci_set_msft_opcode(vhci, 0xfc1e);
 	}
 
 	if (serial_enabled) {
-- 
2.31.1

