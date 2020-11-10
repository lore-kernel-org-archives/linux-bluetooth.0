Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C69C55ABD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 21:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A2D2074B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 21:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdGr16a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgKJVmh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgKJVmK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 16:42:10 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13EAC0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 13:42:10 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a18so86534pfl.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 13:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFJJ6joqN2ymzvLiDTpQFHzV9vF3V5ywQgimwHRhVRg=;
        b=mdGr16a88I7mmm0prcNi45x0W3VKxRdFSt10FPV3HHb8YVvqyGWOLMiccvREJmkJnI
         AIqEOzs+j/Dto5xUMBsh8IJV2O58MrnHjsTP+IFuf7G4otxfgSkU3jb1fLL553livptF
         AtQ3KP0dj5CCDl+6Yydw00Hp0R6NJv0oulzajokov8FhEsQqrQFsfAyxzUP3vYNAj6s8
         TfV2WuwJ6C2A1zSd7EX4jZmQqscRiNz6XblsBequZGI3o/JcVuq9084F1dSopEedCrJR
         R7F7whFwv3dl7x3vjHePGUEw0NMIhikAbAUEOJC7CLnnnKCcsp3O6t1WUg0lk1L7Fqq5
         AN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFJJ6joqN2ymzvLiDTpQFHzV9vF3V5ywQgimwHRhVRg=;
        b=HBXxUwvz2eePBN81aQvZZNXrKNftOgqiEzkuD0WHIWmc5Stqb+pYt6EklwdFSTkyrX
         547yhkIQfPOcl6P41tUJIOVNaQmBsEA4r6pydH0KH+vOuorWtOB3gHwFOKeeZF7xRkUs
         84LqFG9WgppNSRm0MJuchZxuHBUmMn6BAcLDfmDPfx9Wb6g31VhYz4i0ItO9CuG4PFee
         g/1Pj34yOv/YwLNvKaWPsFzy+cQtCKlKDhOA9FICpTHd+FFn1GvW53HssgaXfEHtRjAY
         yiKOHeT+OYy1b34H18SAzK01wXYtXCXHKOezGnsHRRJBMeD+Z0SxAtB4NSJo8kIvAUBB
         0nzA==
X-Gm-Message-State: AOAM530LJTnZ5Q7wh21+4Nqb7oHK6i2+8jpDI9cz88kyoJXL8MOE+Qse
        nWXMBMFTgs1j8v1T/YpRanu7FainCbmFeA==
X-Google-Smtp-Source: ABdhPJwWy49Pjcm48wJuHZyScO6qq9c3uv7YRv+7gdC2Q7U2lnYfATxD8BbtqJehD6hhxyIdvigqhw==
X-Received: by 2002:a62:380f:0:b029:163:a2a0:698 with SMTP id f15-20020a62380f0000b0290163a2a00698mr20642293pfa.10.1605044527900;
        Tue, 10 Nov 2020 13:42:07 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ii20sm4369762pjb.57.2020.11.10.13.42.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:42:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] emulator: Rework command handling
Date:   Tue, 10 Nov 2020 13:42:05 -0800
Message-Id: <20201110214205.3092997-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This create command tables per version/supported command bits to make
it easier to keep them in sync.
---
 emulator/btdev.c | 6973 +++++++++++++++++++++++++---------------------
 1 file changed, 3815 insertions(+), 3158 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a36493346..61c43c298 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -20,6 +20,7 @@
 #include <alloca.h>
 #include <sys/uio.h>
 #include <stdint.h>
+#include <errno.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -36,6 +37,7 @@
 
 #define ACL_HANDLE 42
 #define ISO_HANDLE 44
+#define SCO_HANDLE 257
 
 struct hook {
 	btdev_hook_func handler;
@@ -89,6 +91,7 @@ struct btdev {
 	uint8_t  random_addr[6];
 	uint8_t  le_features[8];
 	uint8_t  le_states[8];
+	const struct btdev_cmd *cmds;
 
 	uint16_t default_link_policy;
 	uint8_t  event_mask[8];
@@ -271,25 +274,1804 @@ static void get_bdaddr(uint16_t id, uint8_t index, uint8_t *bdaddr)
 	bdaddr[5] = 0x00;
 }
 
+struct btdev_cmd {
+	uint16_t opcode;
+	int (*func)(struct btdev *dev, const void *data, uint8_t len);
+	int (*complete)(struct btdev *dev, const void *data, uint8_t len);
+};
+
+#define CMD(_opcode, _func, _complete) \
+	{ \
+		.opcode = _opcode, \
+		.func = _func, \
+		.complete = _complete, \
+	}
+
+static void send_packet(struct btdev *btdev, const struct iovec *iov,
+								int iovlen)
+{
+	int i;
+
+	if (!btdev->send_handler)
+		return;
+
+	for (i = 0; i < iovlen; i++) {
+		if (!i)
+			util_hexdump('<', iov[i].iov_base, iov[i].iov_len,
+				btdev->debug_callback, btdev->debug_data);
+		else
+			util_hexdump(' ', iov[i].iov_base, iov[i].iov_len,
+				btdev->debug_callback, btdev->debug_data);
+	}
+
+	btdev->send_handler(iov, iovlen, btdev->send_data);
+}
+
+static void send_cmd(struct btdev *btdev, uint8_t evt, uint16_t opcode,
+					const struct iovec *iov, int iovlen)
+{
+	struct bt_hci_evt_hdr hdr;
+	struct iovec iov2[2 + iovlen];
+	uint8_t pkt = BT_H4_EVT_PKT;
+	int i;
+
+	util_debug(btdev->debug_callback, btdev->debug_data,
+				"event 0x%02x opcode 0x%04x", evt, opcode);
+
+	iov2[0].iov_base = &pkt;
+	iov2[0].iov_len = sizeof(pkt);
+
+	hdr.evt = evt;
+	hdr.plen = 0;
+
+	iov2[1].iov_base = &hdr;
+	iov2[1].iov_len = sizeof(hdr);
+
+	for (i = 0; i < iovlen; i++) {
+		hdr.plen += iov[i].iov_len;
+		iov2[2 + i].iov_base = iov[i].iov_base;
+		iov2[2 + i].iov_len = iov[i].iov_len;
+	}
+
+	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, iov[i -1].iov_base,
+							iov[i -1].iov_len))
+		send_packet(btdev, iov2, 2 + iovlen);
+}
+
+static void cmd_complete(struct btdev *btdev, uint16_t opcode,
+						const void *data, uint8_t len)
+{
+	struct bt_hci_evt_cmd_complete cc;
+	struct iovec iov[2];
+
+	cc.ncmd = 0x01;
+	cc.opcode = cpu_to_le16(opcode);
+
+	iov[0].iov_base = &cc;
+	iov[0].iov_len = sizeof(cc);
+
+	iov[1].iov_base = (void *) data;
+	iov[1].iov_len = len;
+
+	send_cmd(btdev, BT_HCI_EVT_CMD_COMPLETE, opcode, iov, 2);
+}
+
+static int cmd_set_event_mask(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_set_event_mask *cmd = data;
+	uint8_t status;
+
+	memcpy(dev->event_mask, cmd->mask, 8);
+	status = BT_HCI_ERR_SUCCESS;
+
+	cmd_complete(dev, BT_HCI_CMD_SET_EVENT_MASK, &status, sizeof(status));
+
+	return 0;
+}
+
+static void btdev_reset(struct btdev *btdev)
+{
+	/* FIXME: include here clearing of all states that should be
+	 * cleared upon HCI_Reset
+	 */
+
+	btdev->le_scan_enable		= 0x00;
+	btdev->le_adv_enable		= 0x00;
+}
+
+static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
+{
+	uint8_t status;
+
+	btdev_reset(dev);
+	status = BT_HCI_ERR_SUCCESS;
+
+	cmd_complete(dev, BT_HCI_CMD_RESET, &status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_local_version(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_local_version rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.hci_ver = dev->version;
+	rsp.hci_rev = cpu_to_le16(dev->revision);
+	rsp.lmp_ver = dev->version;
+	rsp.manufacturer = cpu_to_le16(dev->manufacturer);
+	rsp.lmp_subver = cpu_to_le16(dev->revision);
+
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_VERSION, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_local_commands(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_local_commands rsp;
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.commands, dev->commands, 64);
+
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_COMMANDS, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_local_features(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_local_features rsp;
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.features, dev->features, 8);
+
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_FEATURES, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_buffer_size(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_buffer_size rsp;
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.acl_mtu = cpu_to_le16(dev->acl_mtu);
+	rsp.sco_mtu = 0;
+	rsp.acl_max_pkt = cpu_to_le16(dev->acl_max_pkt);
+	rsp.sco_max_pkt = cpu_to_le16(0);
+
+	cmd_complete(dev, BT_HCI_CMD_READ_BUFFER_SIZE, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+#define CMD_COMMON_ALL \
+	CMD(BT_HCI_CMD_SET_EVENT_MASK, cmd_set_event_mask, NULL), \
+	CMD(BT_HCI_CMD_RESET, cmd_reset, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_VERSION, cmd_read_local_version, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_COMMANDS, cmd_read_local_commands, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_FEATURES, cmd_read_local_features, NULL), \
+	CMD(BT_HCI_CMD_READ_BUFFER_SIZE, cmd_read_buffer_size, NULL)
+
 static void set_common_commands_all(struct btdev *btdev)
 {
-	btdev->commands[5]  |= 0x40;	/* Set Event Mask */
-	btdev->commands[5]  |= 0x80;	/* Reset */
-	btdev->commands[14] |= 0x08;	/* Read Local Version */
-	btdev->commands[14] |= 0x10;	/* Read Local Supported Commands */
-	btdev->commands[14] |= 0x20;	/* Read Local Supported Features */
-	btdev->commands[14] |= 0x80;	/* Read Buffer Size */
+	btdev->commands[5]  |= 0x40;	/* Set Event Mask */
+	btdev->commands[5]  |= 0x80;	/* Reset */
+	btdev->commands[14] |= 0x08;	/* Read Local Version */
+	btdev->commands[14] |= 0x10;	/* Read Local Supported Commands */
+	btdev->commands[14] |= 0x20;	/* Read Local Supported Features */
+	btdev->commands[14] |= 0x80;	/* Read Buffer Size */
+}
+
+static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
+{
+	struct bt_hci_evt_cmd_status cs;
+	struct iovec iov;
+
+	cs.status = status;
+	cs.ncmd = 0x01;
+	cs.opcode = cpu_to_le16(opcode);
+
+	iov.iov_base = &cs;
+	iov.iov_len = sizeof(cs);
+
+	send_cmd(btdev, BT_HCI_EVT_CMD_STATUS, opcode, &iov, 1);
+}
+
+static int cmd_disconnect(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_DISCONNECT);
+
+	return 0;
+}
+
+static void send_event(struct btdev *btdev, uint8_t event,
+						const void *data, uint8_t len)
+{
+	struct bt_hci_evt_hdr hdr;
+	struct iovec iov[3];
+	uint8_t pkt = BT_H4_EVT_PKT;
+
+	util_debug(btdev->debug_callback, btdev->debug_data,
+				"event 0x%02x", event);
+
+	iov[0].iov_base = &pkt;
+	iov[0].iov_len = sizeof(pkt);
+
+	hdr.evt = event;
+	hdr.plen = len;
+
+	iov[1].iov_base = &hdr;
+	iov[1].iov_len = sizeof(hdr);
+
+	if (len > 0) {
+		iov[2].iov_base = (void *) data;
+		iov[2].iov_len = len;
+	}
+
+	if (run_hooks(btdev, BTDEV_HOOK_POST_EVT, event, data, len))
+		send_packet(btdev, iov, len > 0 ? 3 : 2);
+}
+
+static int cmd_disconnect_complete(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_disconnect *cmd = data;
+	struct bt_hci_evt_disconnect_complete rsp;
+	struct btdev *remote = dev->conn;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	if (!remote) {
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		rsp.handle = cpu_to_le16(cmd->handle);
+		rsp.reason = 0x00;
+
+		send_event(dev, BT_HCI_EVT_DISCONNECT_COMPLETE, &rsp,
+						sizeof(rsp));
+		return 0;
+	}
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.handle = cpu_to_le16(cmd->handle);
+	rsp.reason = cmd->reason;
+
+	if (rsp.handle == ACL_HANDLE) {
+		dev->conn = NULL;
+		remote->conn = NULL;
+	}
+
+	send_event(dev, BT_HCI_EVT_DISCONNECT_COMPLETE, &rsp, sizeof(rsp));
+	send_event(remote, BT_HCI_EVT_DISCONNECT_COMPLETE, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_remote_version(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_READ_REMOTE_VERSION);
+
+	return 0;
+}
+
+static int cmd_remote_version_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_read_remote_version *cmd = data;
+	struct bt_hci_evt_remote_version_complete ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	if (dev->conn) {
+		ev.status = BT_HCI_ERR_SUCCESS;
+		ev.handle = cpu_to_le16(cmd->handle);
+		ev.lmp_ver = dev->conn->version;
+		ev.manufacturer = cpu_to_le16(dev->conn->manufacturer);
+		ev.lmp_subver = cpu_to_le16(dev->conn->revision);
+	} else {
+		ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		ev.handle = cpu_to_le16(cmd->handle);
+		ev.lmp_ver = 0x00;
+		ev.manufacturer = cpu_to_le16(0);
+		ev.lmp_subver = cpu_to_le16(0);
+	}
+
+	send_event(dev, BT_HCI_EVT_REMOTE_VERSION_COMPLETE, &ev, sizeof(ev));
+
+	return 0;
+}
+
+static int cmd_set_host_flowctl(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_set_host_flow_control *cmd = data;
+	uint8_t status;
+
+	if (cmd->enable > 0x03) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+	} else {
+		dev->host_flow_control = cmd->enable;
+		status = BT_HCI_ERR_SUCCESS;
+	}
+
+	cmd_complete(dev, BT_HCI_CMD_SET_HOST_FLOW_CONTROL, &status,
+							sizeof(status));
+
+	return 0;
+}
+
+static int cmd_host_buffer_size(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	cmd_complete(dev, BT_HCI_CMD_HOST_BUFFER_SIZE, &status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_bdaddr(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_bd_addr rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, dev->bdaddr, 6);
+
+	cmd_complete(dev, BT_HCI_CMD_READ_BD_ADDR, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+#define CMD_COMMON_BREDR_LE \
+	CMD(BT_HCI_CMD_DISCONNECT, cmd_disconnect, cmd_disconnect_complete), \
+	CMD(BT_HCI_CMD_READ_REMOTE_VERSION, cmd_remote_version, \
+					cmd_remote_version_complete), \
+	CMD(BT_HCI_CMD_SET_HOST_FLOW_CONTROL, cmd_set_host_flowctl, NULL), \
+	CMD(BT_HCI_CMD_HOST_BUFFER_SIZE, cmd_host_buffer_size, NULL), \
+	CMD(BT_HCI_CMD_READ_BD_ADDR, cmd_read_bdaddr, NULL)
+
+static void set_common_commands_bredrle(struct btdev *btdev)
+{
+	btdev->commands[0]  |= 0x20;	/* Disconnect */
+	btdev->commands[2]  |= 0x80;	/* Read Remote Version Information */
+	btdev->commands[10] |= 0x20;    /* Set Host Flow Control */
+	btdev->commands[10] |= 0x40;	/* Host Buffer Size */
+	btdev->commands[15] |= 0x02;	/* Read BD ADDR */
+}
+
+static int cmd_inquiry(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_INQUIRY);
+
+	return 0;
+}
+
+static bool inquiry_callback(void *user_data)
+{
+	struct inquiry_data *data = user_data;
+	struct btdev *btdev = data->btdev;
+	struct bt_hci_evt_inquiry_complete ic;
+	int sent = data->sent_count;
+	int i;
+
+	/*Report devices only once and wait for inquiry timeout*/
+	if (data->iter == MAX_BTDEV_ENTRIES)
+		return true;
+
+	for (i = data->iter; i < MAX_BTDEV_ENTRIES; i++) {
+		/*Lets sent 10 inquiry results at once */
+		if (sent + 10 == data->sent_count)
+			break;
+
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!(btdev_list[i]->scan_enable & 0x02))
+			continue;
+
+		if (btdev->inquiry_mode == 0x02 &&
+					btdev_list[i]->ext_inquiry_rsp[0]) {
+			struct bt_hci_evt_ext_inquiry_result ir;
+
+			ir.num_resp = 0x01;
+			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
+			ir.pscan_rep_mode = 0x00;
+			ir.pscan_period_mode = 0x00;
+			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+			ir.clock_offset = 0x0000;
+			ir.rssi = -60;
+			memcpy(ir.data, btdev_list[i]->ext_inquiry_rsp, 240);
+
+			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT,
+							&ir, sizeof(ir));
+			data->sent_count++;
+			continue;
+		}
+
+		if (btdev->inquiry_mode > 0x00) {
+			struct bt_hci_evt_inquiry_result_with_rssi ir;
+
+			ir.num_resp = 0x01;
+			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
+			ir.pscan_rep_mode = 0x00;
+			ir.pscan_period_mode = 0x00;
+			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+			ir.clock_offset = 0x0000;
+			ir.rssi = -60;
+
+			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT_WITH_RSSI,
+							&ir, sizeof(ir));
+			data->sent_count++;
+		} else {
+			struct bt_hci_evt_inquiry_result ir;
+
+			ir.num_resp = 0x01;
+			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
+			ir.pscan_rep_mode = 0x00;
+			ir.pscan_period_mode = 0x00;
+			ir.pscan_mode = 0x00;
+			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+			ir.clock_offset = 0x0000;
+
+			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT,
+							&ir, sizeof(ir));
+			data->sent_count++;
+		}
+	}
+	data->iter = i;
+
+	/* Check if we sent already required amount of responses*/
+	if (data->num_resp && data->sent_count == data->num_resp)
+		goto finish;
+
+	return true;
+
+finish:
+	/* Note that destroy will be called */
+	ic.status = BT_HCI_ERR_SUCCESS;
+	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+
+	return false;
+}
+
+static void inquiry_destroy(void *user_data)
+{
+	struct inquiry_data *data = user_data;
+	struct btdev *btdev = data->btdev;
+
+	if (!btdev)
+		goto finish;
+
+	btdev->inquiry_id = 0;
+
+	if (btdev->inquiry_timeout_id > 0) {
+		timeout_remove(btdev->inquiry_timeout_id);
+		btdev->inquiry_timeout_id = 0;
+	}
+
+finish:
+	free(data);
+}
+
+static bool inquiry_timeout(void *user_data)
+{
+	struct inquiry_data *data = user_data;
+	struct btdev *btdev = data->btdev;
+	struct bt_hci_evt_inquiry_complete ic;
+
+	timeout_remove(btdev->inquiry_id);
+	btdev->inquiry_timeout_id = 0;
+
+	/* Inquiry is stopped, send Inquiry complete event. */
+	ic.status = BT_HCI_ERR_SUCCESS;
+	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+
+	return false;
+}
+
+static int cmd_inquiry_complete(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_inquiry *cmd = data;
+	struct inquiry_data *idata;
+	struct bt_hci_evt_inquiry_complete ic;
+	int status = BT_HCI_ERR_HARDWARE_FAILURE;
+	unsigned int inquiry_len_ms;
+
+	if (dev->inquiry_id > 0) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto failed;
+	}
+
+	idata = malloc0(sizeof(*idata));
+	if (!idata)
+		goto failed;
+
+	idata->btdev = dev;
+	idata->num_resp = cmd->num_resp;
+
+	/* Add timeout to cancel inquiry */
+	inquiry_len_ms = 1280 * cmd->length;
+	if (inquiry_len_ms)
+		dev->inquiry_timeout_id = timeout_add(inquiry_len_ms,
+							inquiry_timeout,
+							idata, NULL);
+
+	dev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
+							inquiry_callback, idata,
+							inquiry_destroy);
+	/* Return if success */
+	if (dev->inquiry_id > 0)
+		return 0;
+
+failed:
+	ic.status = status;
+	send_event(dev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+
+	return 0;
+}
+
+static int cmd_inquiry_cancel(struct btdev *dev, const void *data, uint8_t len)
+{
+	uint8_t status;
+
+	if (!dev->inquiry_id) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+	timeout_remove(dev->inquiry_timeout_id);
+	dev->inquiry_timeout_id = 0;
+	timeout_remove(dev->inquiry_id);
+	dev->inquiry_id = 0;
+
+	status = BT_HCI_ERR_SUCCESS;
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_INQUIRY_CANCEL, &status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_create_conn(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_CREATE_CONN);
+
+	return 0;
+}
+
+static void conn_complete(struct btdev *btdev,
+					const uint8_t *bdaddr, uint8_t status)
+{
+	struct bt_hci_evt_conn_complete cc;
+
+	if (!status) {
+		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+
+		btdev->conn = remote;
+		remote->conn = btdev;
+
+		cc.status = status;
+		memcpy(cc.bdaddr, btdev->bdaddr, 6);
+		cc.encr_mode = 0x00;
+
+		cc.handle = cpu_to_le16(ACL_HANDLE);
+		cc.link_type = 0x01;
+
+		send_event(remote, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+
+		cc.handle = cpu_to_le16(ACL_HANDLE);
+		cc.link_type = 0x01;
+	} else {
+		cc.handle = cpu_to_le16(0x0000);
+		cc.link_type = 0x01;
+	}
+
+	cc.status = status;
+	memcpy(cc.bdaddr, bdaddr, 6);
+	cc.encr_mode = 0x00;
+
+	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+}
+
+static int cmd_create_conn_complete(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_create_conn *cmd = data;
+	struct btdev *remote = find_btdev_by_bdaddr(cmd->bdaddr);
+
+	if (remote && remote->scan_enable & 0x02) {
+		struct bt_hci_evt_conn_request cr;
+
+		memcpy(cr.bdaddr, dev->bdaddr, 6);
+		memcpy(cr.dev_class, dev->dev_class, 3);
+		cr.link_type = 0x01;
+
+		send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(cr));
+	} else {
+		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
+	}
+
+	return 0;
+}
+
+static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_evt_conn_complete cc;
+
+	if (!dev->conn)
+		return 0;
+
+	cc.status = BT_HCI_ERR_SUCCESS;
+	memcpy(cc.bdaddr, dev->conn->bdaddr, 6);
+	cc.handle = cpu_to_le16(SCO_HANDLE);
+	cc.link_type = 0x00;
+	cc.encr_mode = 0x00;
+
+	send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+
+	return 0;
+}
+
+static int cmd_create_conn_cancel(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_CREATE_CONN_CANCEL);
+
+	return 0;
+}
+
+static int cmd_create_conn_cancel_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_create_conn_cancel *cmd = data;
+
+	conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+
+	return 0;
+}
+
+static int cmd_accept_conn(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_ACCEPT_CONN_REQUEST);
+
+	return 0;
+}
+
+static int cmd_accept_conn_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_accept_conn_request *cmd = data;
+	struct btdev *remote = find_btdev_by_bdaddr(cmd->bdaddr);
+
+	if (!remote)
+		return 0;
+
+	if (dev->auth_enable || remote->auth_enable)
+		send_event(remote, BT_HCI_EVT_LINK_KEY_REQUEST, dev->bdaddr, 6);
+	else
+		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_SUCCESS);
+
+	return 0;
+}
+
+static int cmd_reject_conn(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_REJECT_CONN_REQUEST);
+
+	return 0;
+}
+
+static int cmd_reject_conn_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_reject_conn_request *cmd = data;
+
+	conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+
+	return 0;
+}
+
+static int cmd_link_key_reply(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_link_key_request_reply rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, data, 6);
+	cmd_complete(dev, BT_HCI_CMD_LINK_KEY_REQUEST_REPLY, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_link_key_reply_complete(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_link_key_request_reply *cmd = data;
+	struct btdev *remote = dev->conn;
+	struct bt_hci_evt_auth_complete ev;
+
+	memcpy(dev->link_key, cmd->link_key, 16);
+
+	if (!remote) {
+		remote = find_btdev_by_bdaddr(cmd->bdaddr);
+		if (!remote)
+			return 0;
+	}
+
+	if (!memcmp(remote->link_key, LINK_KEY_NONE, 16)) {
+		send_event(remote, BT_HCI_EVT_LINK_KEY_REQUEST, dev->bdaddr, 6);
+		return 0;
+	}
+
+	ev.handle = cpu_to_le16(ACL_HANDLE);
+
+	if (!memcmp(dev->link_key, remote->link_key, 16))
+		ev.status = BT_HCI_ERR_SUCCESS;
+	else
+		ev.status = BT_HCI_ERR_AUTH_FAILURE;
+
+	send_event(dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+	send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+
+	return 0;
+}
+
+static int cmd_link_key_neg_reply(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_link_key_request_neg_reply rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, data, 6);
+	cmd_complete(dev, BT_HCI_CMD_LINK_KEY_REQUEST_NEG_REPLY, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static bool use_ssp(struct btdev *btdev1, struct btdev *btdev2)
+{
+	if (btdev1->auth_enable || btdev2->auth_enable)
+		return false;
+
+	return (btdev1->simple_pairing_mode && btdev2->simple_pairing_mode);
+}
+
+static int cmd_link_key_neg_reply_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_link_key_request_neg_reply *cmd = data;
+	struct btdev *remote = dev->conn;
+
+	if (!remote) {
+		remote = find_btdev_by_bdaddr(cmd->bdaddr);
+		if (!remote)
+			return 0;
+	}
+
+	if (use_ssp(dev, remote)) {
+		struct bt_hci_evt_io_capability_request io_req;
+
+		memcpy(io_req.bdaddr, cmd->bdaddr, 6);
+		send_event(dev, BT_HCI_EVT_IO_CAPABILITY_REQUEST, &io_req,
+							sizeof(io_req));
+	} else {
+		struct bt_hci_evt_pin_code_request pin_req;
+
+		memcpy(pin_req.bdaddr, cmd->bdaddr, 6);
+		send_event(dev, BT_HCI_EVT_PIN_CODE_REQUEST, &pin_req,
+							sizeof(pin_req));
+	}
+
+	return 0;
+}
+
+static int cmd_pin_code_reply(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_pin_code_request_neg_reply rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, data, 6);
+	cmd_complete(dev, BT_HCI_CMD_PIN_CODE_REQUEST_REPLY, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static uint8_t get_link_key_type(struct btdev *btdev)
+{
+	struct btdev *remote = btdev->conn;
+	uint8_t auth, unauth;
+
+	if (!remote)
+		return 0x00;
+
+	if (!btdev->simple_pairing_mode)
+		return 0x00;
+
+	if (btdev->ssp_debug_mode || remote->ssp_debug_mode)
+		return 0x03;
+
+	if (btdev->secure_conn_support && remote->secure_conn_support) {
+		unauth = 0x07;
+		auth = 0x08;
+	} else {
+		unauth = 0x04;
+		auth = 0x05;
+	}
+
+	if (btdev->io_cap == 0x03 || remote->io_cap == 0x03)
+		return unauth;
+
+	if (!(btdev->auth_req & 0x01) && !(remote->auth_req & 0x01))
+		return unauth;
+
+	/* DisplayOnly only produces authenticated with KeyboardOnly */
+	if (btdev->io_cap == 0x00 && remote->io_cap != 0x02)
+		return unauth;
+
+	/* DisplayOnly only produces authenticated with KeyboardOnly */
+	if (remote->io_cap == 0x00 && btdev->io_cap != 0x02)
+		return unauth;
+
+	return auth;
+}
+
+static void link_key_notify(struct btdev *btdev, const uint8_t *bdaddr,
+							const uint8_t *key)
+{
+	struct bt_hci_evt_link_key_notify ev;
+
+	memcpy(btdev->link_key, key, 16);
+
+	memcpy(ev.bdaddr, bdaddr, 6);
+	memcpy(ev.link_key, key, 16);
+	ev.key_type = get_link_key_type(btdev);
+
+	send_event(btdev, BT_HCI_EVT_LINK_KEY_NOTIFY, &ev, sizeof(ev));
+}
+
+static int cmd_pin_code_reply_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_pin_code_request_reply *cmd = data;
+	struct bt_hci_evt_auth_complete ev;
+	struct btdev *remote = dev->conn;
+
+	if (!remote) {
+		remote = find_btdev_by_bdaddr(cmd->bdaddr);
+		if (!remote)
+			return 0;
+	}
+
+	memcpy(dev->pin, cmd->pin_code, cmd->pin_len);
+	dev->pin_len = cmd->pin_len;
+
+	if (!remote->pin_len) {
+		struct bt_hci_evt_pin_code_request pin_req;
+
+		memcpy(pin_req.bdaddr, dev->bdaddr, 6);
+		send_event(remote, BT_HCI_EVT_PIN_CODE_REQUEST, &pin_req,
+							sizeof(pin_req));
+		return 0;
+	}
+
+	if (dev->pin_len == remote->pin_len &&
+			!memcmp(dev->pin, remote->pin, dev->pin_len)) {
+		link_key_notify(dev, remote->bdaddr, LINK_KEY_DUMMY);
+		link_key_notify(remote, dev->bdaddr, LINK_KEY_DUMMY);
+		ev.status = BT_HCI_ERR_SUCCESS;
+	} else {
+		ev.status = BT_HCI_ERR_AUTH_FAILURE;
+	}
+
+	if (remote->conn) {
+		ev.handle = cpu_to_le16(ACL_HANDLE);
+		send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+	} else {
+		conn_complete(remote, dev->bdaddr, ev.status);
+	}
+
+	dev->pin_len = 0;
+	remote->pin_len = 0;
+
+	return 0;
+}
+
+static int cmd_pin_code_neg_reply(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_pin_code_request_neg_reply rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, data, 6);
+	cmd_complete(dev, BT_HCI_CMD_PIN_CODE_REQUEST_NEG_REPLY, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_pin_code_neg_reply_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_pin_code_request_neg_reply *cmd = data;
+	struct bt_hci_evt_auth_complete ev;
+	struct btdev *remote = dev->conn;
+
+	if (!remote) {
+		remote = find_btdev_by_bdaddr(cmd->bdaddr);
+		if (!remote)
+			return 0;
+	}
+
+	ev.status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
+	ev.handle = cpu_to_le16(ACL_HANDLE);
+
+	if (dev->conn)
+		send_event(dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+	else
+		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PIN_OR_KEY_MISSING);
+
+	if (remote->conn) {
+		if (remote->pin_len)
+			send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev,
+								sizeof(ev));
+	} else {
+		conn_complete(remote, dev->bdaddr,
+					BT_HCI_ERR_PIN_OR_KEY_MISSING);
+	}
+
+	return 0;
+}
+
+static int cmd_auth_requested(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_AUTH_REQUESTED);
+
+	return 0;
+}
+
+static int cmd_auth_requested_complete(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_auth_requested *cmd = data;
+	struct btdev *remote = dev->conn;
+
+	if (!remote) {
+		struct bt_hci_evt_auth_complete ev;
+
+		ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		ev.handle = cpu_to_le16(cmd->handle);
+
+		send_event(dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+
+		return 0;
+	}
+
+	dev->auth_init = true;
+
+	send_event(dev, BT_HCI_EVT_LINK_KEY_REQUEST, remote->bdaddr, 6);
+
+	return 0;
+}
+
+static int cmd_set_conn_encrypt(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_SET_CONN_ENCRYPT);
+
+	return 0;
+}
+
+static void encrypt_change(struct btdev *btdev, uint8_t mode, uint8_t status)
+{
+	struct bt_hci_evt_encrypt_change ev;
+
+	ev.status = status;
+	ev.handle = cpu_to_le16(ACL_HANDLE);
+	ev.encr_mode = mode;
+
+	send_event(btdev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
+}
+
+static int cmd_set_conn_encrypt_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_set_conn_encrypt *cmd = data;
+	uint8_t mode;
+
+	if (!dev->conn)
+		return 0;
+
+	if (!cmd->encr_mode)
+		mode = 0x00;
+	else if (dev->secure_conn_support && dev->conn->secure_conn_support)
+		mode = 0x02;
+	else
+		mode = 0x01;
+
+	encrypt_change(dev, mode, BT_HCI_ERR_SUCCESS);
+	encrypt_change(dev->conn, mode, BT_HCI_ERR_SUCCESS);
+
+	return 0;
+}
+
+static int cmd_remote_name(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_REMOTE_NAME_REQUEST);
+
+	return 0;
+}
+
+static void name_request_complete(struct btdev *btdev,
+					const uint8_t *bdaddr, uint8_t status)
+{
+	struct bt_hci_evt_remote_name_request_complete nc;
+
+	nc.status = status;
+	memcpy(nc.bdaddr, bdaddr, 6);
+	memset(nc.name, 0, 248);
+
+	if (!status) {
+		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+
+		if (remote)
+			memcpy(nc.name, remote->name, 248);
+		else
+			nc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	}
+
+	send_event(btdev, BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE,
+							&nc, sizeof(nc));
+}
+
+static int cmd_remote_name_complete(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_remote_name_request *cmd = data;
+
+	name_request_complete(dev, cmd->bdaddr, BT_HCI_ERR_SUCCESS);
+
+	return 0;
+}
+
+static int cmd_remote_name_cancel(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_remote_name_request_cancel *cmd = data;
+	struct bt_hci_rsp_remote_name_request_cancel rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, cmd->bdaddr, 6);
+	cmd_complete(dev, BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_remote_name_cancel_complete(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_remote_name_request_cancel *cmd = data;
+
+	name_request_complete(dev, cmd->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+
+	return 0;
+}
+
+static int cmd_read_remote_features(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_READ_REMOTE_FEATURES);
+
+	return 0;
+}
+
+static int cmd_read_remote_features_complete(struct btdev *dev,
+						const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_read_remote_features *cmd = data;
+	struct bt_hci_evt_remote_features_complete rfc;
+
+	if (dev->conn) {
+		rfc.status = BT_HCI_ERR_SUCCESS;
+		rfc.handle = cpu_to_le16(cmd->handle);
+		memcpy(rfc.features, dev->conn->features, 8);
+	} else {
+		rfc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		rfc.handle = cpu_to_le16(cmd->handle);
+		memset(rfc.features, 0, 8);
+	}
+
+	send_event(dev, BT_HCI_EVT_REMOTE_FEATURES_COMPLETE, &rfc, sizeof(rfc));
+
+	return 0;
+}
+
+static int cmd_read_remote_ext_features(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS,
+					BT_HCI_CMD_READ_REMOTE_EXT_FEATURES);
+
+	return 0;
+}
+
+static void btdev_get_host_features(struct btdev *btdev, uint8_t features[8])
+{
+	memset(features, 0, 8);
+	if (btdev->simple_pairing_mode)
+		features[0] |= 0x01;
+	if (btdev->le_supported)
+		features[0] |= 0x02;
+	if (btdev->le_simultaneous)
+		features[0] |= 0x04;
+	if (btdev->secure_conn_support)
+		features[0] |= 0x08;
+}
+
+static int cmd_read_remote_ext_features_compl(struct btdev *dev,
+						const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_read_remote_ext_features *cmd = data;
+	struct bt_hci_evt_remote_ext_features_complete ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	if (dev->conn && cmd->page < 0x02) {
+		ev.handle = cpu_to_le16(cmd->handle);
+		ev.page = cmd->page;
+		ev.max_page = 0x01;
+
+		switch (cmd->page) {
+		case 0x00:
+			ev.status = BT_HCI_ERR_SUCCESS;
+			memcpy(ev.features, dev->conn->features, 8);
+			break;
+		case 0x01:
+			ev.status = BT_HCI_ERR_SUCCESS;
+			btdev_get_host_features(dev->conn, ev.features);
+			break;
+		default:
+			ev.status = BT_HCI_ERR_INVALID_PARAMETERS;
+			memset(ev.features, 0, 8);
+			break;
+		}
+	} else {
+		ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		ev.handle = cpu_to_le16(cmd->handle);
+		ev.page = cmd->page;
+		ev.max_page = 0x01;
+		memset(ev.features, 0, 8);
+	}
+
+	send_event(dev, BT_HCI_EVT_REMOTE_EXT_FEATURES_COMPLETE, &ev,
+						sizeof(ev));
+
+	return 0;
+}
+
+static int cmd_read_clock_offset(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_READ_CLOCK_OFFSET);
+
+	return 0;
+}
+
+static int cmd_read_clock_offset_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_read_clock_offset *cmd = data;
+	struct bt_hci_evt_clock_offset_complete ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	if (dev->conn) {
+		ev.status = BT_HCI_ERR_SUCCESS;
+		ev.handle = cpu_to_le16(cmd->handle);
+		ev.clock_offset = 0;
+	} else {
+		ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		ev.handle = cpu_to_le16(cmd->handle);
+		ev.clock_offset = 0;
+	}
+
+	send_event(dev, BT_HCI_EVT_CLOCK_OFFSET_COMPLETE, &ev, sizeof(ev));
+
+	return 0;
+}
+
+static int cmd_read_link_policy(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_default_link_policy rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.policy = cpu_to_le16(dev->default_link_policy);
+	cmd_complete(dev, BT_HCI_CMD_READ_DEFAULT_LINK_POLICY, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_link_policy(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_default_link_policy *cmd = data;
+	uint8_t status;
+
+	dev->default_link_policy = le16_to_cpu(cmd->policy);
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_DEFAULT_LINK_POLICY, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_set_event_filter(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_set_event_filter *cmd = data;
+	uint8_t status;
+
+	dev->event_filter = cmd->type;
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_SET_EVENT_FILTER, &status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_link_key(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_stored_link_key rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.max_num_keys = cpu_to_le16(0);
+	rsp.num_keys = cpu_to_le16(0);
+	cmd_complete(dev, BT_HCI_CMD_READ_STORED_LINK_KEY, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_link_key(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_write_stored_link_key rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.num_keys = 0;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_STORED_LINK_KEY, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_delete_link_key(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_delete_stored_link_key rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.num_keys = cpu_to_le16(0);
+	cmd_complete(dev, BT_HCI_CMD_DELETE_STORED_LINK_KEY, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_local_name(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_local_name rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.name, dev->name, 248);
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_NAME, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_local_name(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_local_name *cmd = data;
+	uint8_t status;
+
+	memcpy(dev->name, cmd->name, 248);
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_LOCAL_NAME, &status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_accept_timeout(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_conn_accept_timeout rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.timeout = cpu_to_le16(dev->conn_accept_timeout);
+	cmd_complete(dev, BT_HCI_CMD_READ_CONN_ACCEPT_TIMEOUT, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_accept_timeout(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_conn_accept_timeout *cmd = data;
+	uint8_t status;
+
+	dev->conn_accept_timeout = le16_to_cpu(cmd->timeout);
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_CONN_ACCEPT_TIMEOUT, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_page_timeout(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_page_timeout rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.timeout = cpu_to_le16(dev->page_timeout);
+	cmd_complete(dev, BT_HCI_CMD_READ_PAGE_TIMEOUT, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_page_timeout(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_page_timeout *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->page_timeout = le16_to_cpu(cmd->timeout);
+	cmd_complete(dev, BT_HCI_CMD_WRITE_PAGE_TIMEOUT, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_scan_enable(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_scan_enable rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.enable = dev->scan_enable;
+	cmd_complete(dev, BT_HCI_CMD_READ_SCAN_ENABLE, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_scan_enable(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_scan_enable *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->scan_enable = cmd->enable;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_SCAN_ENABLE, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_page_scan(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_page_scan_activity rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.interval = cpu_to_le16(dev->page_scan_interval);
+	rsp.window = cpu_to_le16(dev->page_scan_window);
+	cmd_complete(dev, BT_HCI_CMD_READ_PAGE_SCAN_ACTIVITY, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_page_scan(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_page_scan_activity *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->page_scan_interval = le16_to_cpu(cmd->interval);
+	dev->page_scan_window = le16_to_cpu(cmd->window);
+	cmd_complete(dev, BT_HCI_CMD_WRITE_PAGE_SCAN_ACTIVITY, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_inquiry_scan(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_inquiry_scan_activity rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.interval = cpu_to_le16(dev->inquiry_scan_interval);
+	rsp.window = cpu_to_le16(dev->inquiry_scan_window);
+	cmd_complete(dev, BT_HCI_CMD_READ_INQUIRY_SCAN_ACTIVITY, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_inquiry_scan(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_inquiry_scan_activity *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->inquiry_scan_interval = le16_to_cpu(cmd->interval);
+	dev->inquiry_scan_window = le16_to_cpu(cmd->window);
+	cmd_complete(dev, BT_HCI_CMD_WRITE_INQUIRY_SCAN_ACTIVITY, &status,
+					sizeof(status));
+
+	return 0;
 }
 
-static void set_common_commands_bredrle(struct btdev *btdev)
+static int cmd_read_auth_enable(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	btdev->commands[0]  |= 0x20;	/* Disconnect */
-	btdev->commands[2]  |= 0x80;	/* Read Remote Version Information */
-	btdev->commands[10] |= 0x20;    /* Set Host Flow Control */
-	btdev->commands[10] |= 0x40;	/* Host Buffer Size */
-	btdev->commands[15] |= 0x02;	/* Read BD ADDR */
+	struct bt_hci_rsp_read_auth_enable rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.enable = dev->auth_enable;
+	cmd_complete(dev, BT_HCI_CMD_READ_AUTH_ENABLE, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_auth_enable(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_auth_enable *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->auth_enable = cmd->enable;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_AUTH_ENABLE, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_class(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_class_of_dev rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.dev_class, dev->dev_class, 3);
+	cmd_complete(dev, BT_HCI_CMD_READ_CLASS_OF_DEV, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_class(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_write_class_of_dev *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	memcpy(dev->dev_class, cmd->dev_class, 3);
+	cmd_complete(dev, BT_HCI_CMD_WRITE_CLASS_OF_DEV, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_voice(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_voice_setting rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.setting = cpu_to_le16(dev->voice_setting);
+	cmd_complete(dev, BT_HCI_CMD_READ_VOICE_SETTING, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_voice(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_write_voice_setting *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->voice_setting = le16_to_cpu(cmd->setting);
+	cmd_complete(dev, BT_HCI_CMD_WRITE_VOICE_SETTING, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_num_iac(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_num_supported_iac rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.num_iac = 0x01;
+	cmd_complete(dev, BT_HCI_CMD_READ_NUM_SUPPORTED_IAC, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_current_iac_lap(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_current_iac_lap *rsp;
+
+	rsp = alloca(sizeof(*rsp) + 3);
+	rsp->status = BT_HCI_ERR_SUCCESS;
+	rsp->num_iac = 0x01;
+	rsp->iac_lap[0] = 0x33;
+	rsp->iac_lap[1] = 0x8b;
+	rsp->iac_lap[2] = 0x9e;
+	cmd_complete(dev, BT_HCI_CMD_READ_CURRENT_IAC_LAP, rsp,
+					sizeof(*rsp) + 3);
+
+	return 0;
+}
+
+static int cmd_write_current_iac_lap(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	cmd_complete(dev, BT_HCI_CMD_WRITE_CURRENT_IAC_LAP, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_inquiry_mode(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_inquiry_mode rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.mode = dev->inquiry_mode;
+	cmd_complete(dev, BT_HCI_CMD_READ_INQUIRY_MODE, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_inquiry_mode(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_inquiry_mode *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->inquiry_mode = cmd->mode;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_INQUIRY_MODE, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_page_scan_type(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_page_scan_type rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.type = dev->page_scan_type;
+	cmd_complete(dev, BT_HCI_CMD_READ_PAGE_SCAN_TYPE, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_page_scan_type(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_page_scan_type *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->page_scan_type = cmd->type;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_PAGE_SCAN_TYPE, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_afh_mode(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_afh_assessment_mode rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.mode = dev->afh_assessment_mode;
+	cmd_complete(dev, BT_HCI_CMD_READ_AFH_ASSESSMENT_MODE, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_afh_mode(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_write_afh_assessment_mode *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->afh_assessment_mode = cmd->mode;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_AFH_ASSESSMENT_MODE, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_local_ext_features(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_local_ext_features rsp;
+	uint8_t page = ((const uint8_t *) data)[0];
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.page = page;
+	rsp.max_page = dev->max_page;
+
+	if (page > dev->max_page) {
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+
+	switch (page) {
+	case 0x00:
+		memcpy(rsp.features, dev->features, 8);
+		break;
+	case 0x01:
+		btdev_get_host_features(dev, rsp.features);
+		break;
+	case 0x02:
+		memcpy(rsp.features, dev->feat_page_2, 8);
+		break;
+	default:
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		break;
+	}
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_EXT_FEATURES, &rsp,
+					sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_country_code(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_country_code rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.code = dev->country_code;
+	cmd_complete(dev, BT_HCI_CMD_READ_COUNTRY_CODE, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
+static int cmd_enable_dut_mode(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	cmd_complete(dev, BT_HCI_CMD_ENABLE_DUT_MODE, &status,
+					sizeof(status));
+
+	return 0;
+}
+
+#define CMD_COMMON_BREDR_20 \
+	CMD(BT_HCI_CMD_INQUIRY, cmd_inquiry, cmd_inquiry_complete), \
+	CMD(BT_HCI_CMD_INQUIRY_CANCEL, cmd_inquiry_cancel, NULL), \
+	CMD(BT_HCI_CMD_CREATE_CONN, cmd_create_conn, \
+					cmd_create_conn_complete), \
+	CMD(BT_HCI_CMD_ADD_SCO_CONN, cmd_add_sco_conn, NULL), \
+	CMD(BT_HCI_CMD_CREATE_CONN_CANCEL, cmd_create_conn_cancel, \
+					cmd_create_conn_cancel_complete), \
+	CMD(BT_HCI_CMD_ACCEPT_CONN_REQUEST, cmd_accept_conn, \
+					cmd_accept_conn_complete), \
+	CMD(BT_HCI_CMD_REJECT_CONN_REQUEST, cmd_reject_conn, \
+					cmd_reject_conn_complete), \
+	CMD(BT_HCI_CMD_LINK_KEY_REQUEST_REPLY, cmd_link_key_reply, \
+					cmd_link_key_reply_complete), \
+	CMD(BT_HCI_CMD_LINK_KEY_REQUEST_NEG_REPLY, \
+					cmd_link_key_neg_reply, \
+					cmd_link_key_neg_reply_complete), \
+	CMD(BT_HCI_CMD_PIN_CODE_REQUEST_REPLY, cmd_pin_code_reply, \
+					cmd_pin_code_reply_complete), \
+	CMD(BT_HCI_CMD_PIN_CODE_REQUEST_NEG_REPLY, \
+					cmd_pin_code_neg_reply, \
+					cmd_pin_code_neg_reply_complete), \
+	CMD(BT_HCI_CMD_AUTH_REQUESTED, cmd_auth_requested, \
+					cmd_auth_requested_complete), \
+	CMD(BT_HCI_CMD_SET_CONN_ENCRYPT, cmd_set_conn_encrypt, \
+					cmd_set_conn_encrypt_complete), \
+	CMD(BT_HCI_CMD_REMOTE_NAME_REQUEST, cmd_remote_name, \
+					cmd_remote_name_complete), \
+	CMD(BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL, cmd_remote_name_cancel, \
+					cmd_remote_name_cancel_complete), \
+	CMD(BT_HCI_CMD_READ_REMOTE_FEATURES, cmd_read_remote_features, \
+					cmd_read_remote_features_complete), \
+	CMD(BT_HCI_CMD_READ_REMOTE_EXT_FEATURES, \
+					cmd_read_remote_ext_features, \
+					cmd_read_remote_ext_features_compl), \
+	CMD(BT_HCI_CMD_READ_CLOCK_OFFSET, cmd_read_clock_offset, \
+					cmd_read_clock_offset_complete), \
+	CMD(BT_HCI_CMD_READ_DEFAULT_LINK_POLICY, cmd_read_link_policy, NULL), \
+	CMD(BT_HCI_CMD_WRITE_DEFAULT_LINK_POLICY, cmd_write_link_policy, \
+					NULL), \
+	CMD(BT_HCI_CMD_SET_EVENT_FILTER, cmd_set_event_filter, NULL), \
+	CMD(BT_HCI_CMD_READ_STORED_LINK_KEY, cmd_read_link_key, NULL), \
+	CMD(BT_HCI_CMD_WRITE_STORED_LINK_KEY, cmd_write_link_key, NULL), \
+	CMD(BT_HCI_CMD_DELETE_STORED_LINK_KEY, cmd_delete_link_key, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_NAME, cmd_read_local_name, NULL), \
+	CMD(BT_HCI_CMD_WRITE_LOCAL_NAME, cmd_write_local_name, NULL), \
+	CMD(BT_HCI_CMD_READ_CONN_ACCEPT_TIMEOUT, cmd_read_accept_timeout, \
+					NULL), \
+	CMD(BT_HCI_CMD_WRITE_CONN_ACCEPT_TIMEOUT, cmd_write_accept_timeout, \
+					NULL), \
+	CMD(BT_HCI_CMD_READ_PAGE_TIMEOUT, cmd_read_page_timeout, NULL), \
+	CMD(BT_HCI_CMD_WRITE_PAGE_TIMEOUT, cmd_write_page_timeout, NULL), \
+	CMD(BT_HCI_CMD_READ_SCAN_ENABLE, cmd_read_scan_enable, NULL), \
+	CMD(BT_HCI_CMD_WRITE_SCAN_ENABLE, cmd_write_scan_enable, NULL), \
+	CMD(BT_HCI_CMD_READ_PAGE_SCAN_ACTIVITY, cmd_read_page_scan, NULL), \
+	CMD(BT_HCI_CMD_WRITE_PAGE_SCAN_ACTIVITY, cmd_write_page_scan, NULL), \
+	CMD(BT_HCI_CMD_READ_INQUIRY_SCAN_ACTIVITY, cmd_read_inquiry_scan, \
+					NULL), \
+	CMD(BT_HCI_CMD_WRITE_INQUIRY_SCAN_ACTIVITY, cmd_write_inquiry_scan, \
+					NULL), \
+	CMD(BT_HCI_CMD_READ_AUTH_ENABLE, cmd_read_auth_enable, NULL), \
+	CMD(BT_HCI_CMD_WRITE_AUTH_ENABLE, cmd_write_auth_enable, NULL), \
+	CMD(BT_HCI_CMD_READ_CLASS_OF_DEV, cmd_read_class, NULL), \
+	CMD(BT_HCI_CMD_WRITE_CLASS_OF_DEV, cmd_write_class, NULL), \
+	CMD(BT_HCI_CMD_READ_VOICE_SETTING, cmd_read_voice, NULL), \
+	CMD(BT_HCI_CMD_WRITE_VOICE_SETTING, cmd_write_voice, NULL), \
+	CMD(BT_HCI_CMD_READ_NUM_SUPPORTED_IAC, cmd_read_num_iac, NULL), \
+	CMD(BT_HCI_CMD_READ_CURRENT_IAC_LAP, cmd_read_current_iac_lap, \
+					NULL), \
+	CMD(BT_HCI_CMD_WRITE_CURRENT_IAC_LAP, cmd_write_current_iac_lap, \
+					NULL), \
+	CMD(BT_HCI_CMD_READ_INQUIRY_MODE, cmd_read_inquiry_mode, NULL), \
+	CMD(BT_HCI_CMD_WRITE_INQUIRY_MODE, cmd_write_inquiry_mode, NULL), \
+	CMD(BT_HCI_CMD_READ_PAGE_SCAN_TYPE, cmd_read_page_scan_type, NULL), \
+	CMD(BT_HCI_CMD_WRITE_PAGE_SCAN_TYPE, cmd_write_page_scan_type, NULL), \
+	CMD(BT_HCI_CMD_READ_AFH_ASSESSMENT_MODE, cmd_read_afh_mode, NULL), \
+	CMD(BT_HCI_CMD_WRITE_AFH_ASSESSMENT_MODE, cmd_write_afh_mode, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_EXT_FEATURES, cmd_read_local_ext_features, \
+					NULL), \
+	CMD(BT_HCI_CMD_READ_COUNTRY_CODE, cmd_read_country_code, NULL), \
+	CMD(BT_HCI_CMD_ENABLE_DUT_MODE, cmd_enable_dut_mode, NULL)
+
 static void set_common_commands_bredr20(struct btdev *btdev)
 {
 	btdev->commands[0]  |= 0x01;	/* Inquiry */
@@ -334,6 +2116,8 @@ static void set_common_commands_bredr20(struct btdev *btdev)
 	btdev->commands[9]  |= 0x02;	/* Write Class Of Device */
 	btdev->commands[9]  |= 0x04;	/* Read Voice Setting */
 	btdev->commands[9]  |= 0x08;	/* Write Voice Setting */
+	btdev->commands[11] |= 0x04;	/* Read Number of Supported IAC */
+	btdev->commands[11] |= 0x08;	/* Read Current IAC LAP */
 	btdev->commands[11] |= 0x10;	/* Write Current IAC LAP */
 	btdev->commands[12] |= 0x40;	/* Read Inquiry Mode */
 	btdev->commands[12] |= 0x80;	/* Write Inquiry Mode */
@@ -344,879 +2128,851 @@ static void set_common_commands_bredr20(struct btdev *btdev)
 	btdev->commands[14] |= 0x40;	/* Read Local Extended Features */
 	btdev->commands[15] |= 0x01;	/* Read Country Code */
 	btdev->commands[16] |= 0x04;	/* Enable Device Under Test Mode */
-}
-
-static void set_bredr_commands(struct btdev *btdev)
-{
-	set_common_commands_all(btdev);
-	set_common_commands_bredrle(btdev);
-	set_common_commands_bredr20(btdev);
-
-	btdev->commands[16] |= 0x08;	/* Setup Synchronous Connection */
-	btdev->commands[17] |= 0x01;	/* Read Extended Inquiry Response */
-	btdev->commands[17] |= 0x02;	/* Write Extended Inquiry Response */
-	btdev->commands[17] |= 0x20;	/* Read Simple Pairing Mode */
-	btdev->commands[17] |= 0x40;	/* Write Simple Pairing Mode */
-	btdev->commands[17] |= 0x80;	/* Read Local OOB Data */
-	btdev->commands[18] |= 0x01;	/* Read Inquiry Response TX Power */
-	btdev->commands[18] |= 0x02;	/* Write Inquiry Response TX Power */
-	btdev->commands[18] |= 0x80;	/* IO Capability Request Reply */
-	btdev->commands[20] |= 0x10;	/* Read Encryption Key Size */
-	btdev->commands[23] |= 0x04;	/* Read Data Block Size */
-	btdev->commands[29] |= 0x20;	/* Read Local Supported Codecs */
-	btdev->commands[30] |= 0x08;	/* Get MWS Transport Layer Config */
-}
-
-static void set_bredr20_commands(struct btdev *btdev)
-{
-	set_common_commands_all(btdev);
-	set_common_commands_bredrle(btdev);
-	set_common_commands_bredr20(btdev);
-}
-
-static void set_le_50_commands(struct btdev *btdev)
-{
-	btdev->commands[35] |= 0x20;	/* LE Set Default PHY */
-	btdev->commands[36] |= 0x02;	/* LE Set Adv Set Random Address */
-	btdev->commands[36] |= 0x04;	/* LE Set Ext Adv Parameters */
-	btdev->commands[36] |= 0x08;	/* LE Set Ext Adv Data */
-	btdev->commands[36] |= 0x10;	/* LE Set Ext Scan Response Data */
-	btdev->commands[36] |= 0x20;	/* LE Set Ext Adv Enable */
-	btdev->commands[36] |= 0x40;	/* LE Read Maximum Adv Data Length */
-	btdev->commands[36] |= 0x80;	/* LE Read Num of Supported Adv Sets */
-	btdev->commands[37] |= 0x01;	/* LE Remove Adv Set */
-	btdev->commands[37] |= 0x02;	/* LE Clear Adv Sets */
-	btdev->commands[37] |= 0x04;	/* LE Set Periodic Adv Parameters */
-	btdev->commands[37] |= 0x08;	/* LE Set Periodic Adv Data */
-	btdev->commands[37] |= 0x10;	/* LE Set Periodic Adv Enable */
-	btdev->commands[37] |= 0x20;	/* LE Set Ext Scan Parameters */
-	btdev->commands[37] |= 0x40;	/* LE Set Ext Scan Enable */
-	btdev->commands[37] |= 0x80;	/* LE Ext Create Connection */
-	btdev->commands[38] |= 0x01;	/* LE Periodic Adv Create Sync */
-	btdev->commands[38] |= 0x02;	/* LE Periodic Adv Create Sync Cancel */
-	btdev->commands[38] |= 0x04;	/* LE Periodic Adv Terminate Sync */
-	btdev->commands[38] |= 0x08;	/* LE Add Device To Periodic Adv List */
-	btdev->commands[38] |= 0x10;	/* LE Remove Periodic Adv List */
-	btdev->commands[38] |= 0x20;	/* LE Clear Periodic Adv List */
-	btdev->commands[38] |= 0x40;	/* LE Read Periodic Adv List Size */
-}
-
-static void set_le_52_commands(struct btdev *btdev)
-{
-	btdev->commands[41] |= 0x20;	/* LE Read Buffer Size v2 */
-	btdev->commands[41] |= 0x40;	/* LE Read ISO TX Sync */
-	btdev->commands[41] |= 0x80;	/* LE Set CIG Parameters */
-	btdev->commands[42] |= 0x01;	/* LE Set CIG Parameters Test */
-	btdev->commands[42] |= 0x02;	/* LE Create CIS */
-	btdev->commands[42] |= 0x04;	/* LE Remove CIG */
-	btdev->commands[42] |= 0x08;	/* LE Accept CIS */
-	btdev->commands[42] |= 0x10;	/* LE Reject CIS */
-	btdev->commands[42] |= 0x20;	/* LE Create BIG */
-	btdev->commands[42] |= 0x40;	/* LE Create BIG Test */
-	btdev->commands[42] |= 0x80;	/* LE Terminate BIG */
-	btdev->commands[43] |= 0x01;	/* LE BIG Create Sync */
-	btdev->commands[43] |= 0x02;	/* LE BIG Terminate Sync */
-	btdev->commands[43] |= 0x04;	/* LE Request Peer SCA */
-	btdev->commands[43] |= 0x08;	/* LE Setup ISO Path */
-	btdev->commands[43] |= 0x10;	/* LE Remove ISO Path */
-	btdev->commands[43] |= 0x20;	/* LE ISO TX Test */
-	btdev->commands[43] |= 0x40;	/* LE ISO RX Test */
-	btdev->commands[43] |= 0x80;	/* LE ISO Read Test Counter */
-	btdev->commands[44] |= 0x01;	/* LE ISO Test End */
-	btdev->commands[44] |= 0x02;	/* LE ISO Set Host Feature */
-}
-
-static void set_le_commands(struct btdev *btdev)
-{
-	set_common_commands_all(btdev);
-	set_common_commands_bredrle(btdev);
-
-	btdev->commands[24] |= 0x20;	/* Read LE Host Supported */
-	btdev->commands[24] |= 0x20;	/* Write LE Host Supported */
-	btdev->commands[25] |= 0x01;	/* LE Set Event Mask */
-	btdev->commands[25] |= 0x02;	/* LE Read Buffer Size */
-	btdev->commands[25] |= 0x04;	/* LE Read Local Features */
-	btdev->commands[25] |= 0x10;	/* LE Set Random Address */
-	btdev->commands[25] |= 0x20;	/* LE Set Adv Parameters */
-	btdev->commands[25] |= 0x40;	/* LE Read Adv TX Power */
-	btdev->commands[25] |= 0x80;	/* LE Set Adv Data */
-	btdev->commands[26] |= 0x01;	/* LE Set Scan Response Data */
-	btdev->commands[26] |= 0x02;	/* LE Set Adv Enable */
-	btdev->commands[26] |= 0x04;	/* LE Set Scan Parameters */
-	btdev->commands[26] |= 0x08;	/* LE Set Scan Enable */
-	btdev->commands[26] |= 0x10;	/* LE Create Connection */
-	btdev->commands[26] |= 0x40;	/* LE Read White List Size */
-	btdev->commands[26] |= 0x80;	/* LE Clear White List */
-	btdev->commands[27] |= 0x04;	/* LE Connection Update */
-	btdev->commands[27] |= 0x20;	/* LE Read Remote Used Features */
-	btdev->commands[27] |= 0x40;	/* LE Encrypt */
-	btdev->commands[27] |= 0x80;	/* LE Rand */
-	btdev->commands[28] |= 0x01;	/* LE Start Encryption */
-	btdev->commands[28] |= 0x02;	/* LE Long Term Key Request Reply */
-	btdev->commands[28] |= 0x04;	/* LE Long Term Key Request Neg Reply */
-	btdev->commands[28] |= 0x08;	/* LE Read Supported States */
-	btdev->commands[28] |= 0x10;	/* LE Receiver Test */
-	btdev->commands[28] |= 0x20;	/* LE Transmitter Test */
-	btdev->commands[28] |= 0x40;	/* LE Test End */
+}
 
-	/* Extra LE commands for >= 4.1 adapters */
-	btdev->commands[33] |= 0x10;	/* LE Remote Conn Param Req Reply */
-	btdev->commands[33] |= 0x20;	/* LE Remote Conn Param Req Neg Reply */
+static int cmd_setup_sync_conn(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_setup_sync_conn *cmd = data;
+	struct bt_hci_evt_sync_conn_complete cc;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	/* Extra LE commands for >= 4.2 adapters */
-	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
-	btdev->commands[34] |= 0x04;	/* LE Generate DHKey */
+	cmd_status(dev, status, BT_HCI_EVT_SYNC_CONN_COMPLETE);
 
-	/* Extra LE commands for >= 5.0 adapters */
-	if (btdev->type >= BTDEV_TYPE_BREDRLE50)
-		set_le_50_commands(btdev);
+	if (!dev->conn)
+		return 0;
 
-	/* Extra LE commands for >= 5.2 adapters */
-	if (btdev->type >= BTDEV_TYPE_BREDRLE52)
-		set_le_52_commands(btdev);
-}
+	cc.status = status;
+	memcpy(cc.bdaddr, dev->conn->bdaddr, 6);
 
-static void set_bredrle_commands(struct btdev *btdev)
-{
-	set_bredr_commands(btdev);
-	set_le_commands(btdev);
+	cc.handle = cpu_to_le16(status == BT_HCI_ERR_SUCCESS ? SCO_HANDLE : 0);
+	cc.link_type = 0x02;
+	cc.tx_interval = 0x000c;
+	cc.retrans_window = 0x06;
+	cc.rx_pkt_len = 60;
+	cc.tx_pkt_len = 60;
+	cc.air_mode = (cmd->voice_setting == 0x0060) ? 0x02 : 0x03;
 
-	/* Extra BR/EDR commands we want to only support for >= 4.0
-	 * adapters.
-	 */
-	btdev->commands[22] |= 0x04;	/* Set Event Mask Page 2 */
-	btdev->commands[31] |= 0x80;	/* Read Sync Train Parameters */
-	btdev->commands[32] |= 0x04;	/* Read Secure Connections Support */
-	btdev->commands[32] |= 0x08;	/* Write Secure Connections Support */
-	btdev->commands[32] |= 0x10;	/* Read Auth Payload Timeout */
-	btdev->commands[32] |= 0x20;	/* Write Auth Payload Timeout */
-	btdev->commands[32] |= 0x40;	/* Read Local OOB Extended Data */
+	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
+
+	return 0;
 }
 
-static void set_amp_commands(struct btdev *btdev)
+static int cmd_read_ext_inquiry(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	set_common_commands_all(btdev);
+	struct bt_hci_rsp_read_ext_inquiry_response rsp;
 
-	btdev->commands[22] |= 0x20;	/* Read Local AMP Info */
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.fec = dev->ext_inquiry_fec;
+	memcpy(rsp.data, dev->ext_inquiry_rsp, 240);
+	cmd_complete(dev, BT_HCI_CMD_READ_EXT_INQUIRY_RESPONSE, &rsp,
+					sizeof(rsp));
+
+	return 0;
 }
 
-static void set_bredrle_features(struct btdev *btdev)
+static int cmd_write_ext_inquiry(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	btdev->features[0] |= 0x04;	/* Encryption */
-	btdev->features[0] |= 0x20;	/* Role switch */
-	btdev->features[0] |= 0x80;	/* Sniff mode */
-	btdev->features[1] |= 0x08;	/* SCO link */
-	btdev->features[2] |= 0x08;	/* Transparent SCO */
-	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
-	btdev->features[3] |= 0x80;	/* Extended SCO link */
-	btdev->features[4] |= 0x08;	/* AFH capable slave */
-	btdev->features[4] |= 0x10;	/* AFH classification slave */
-	btdev->features[4] |= 0x40;	/* LE Supported */
-	btdev->features[5] |= 0x02;	/* Sniff subrating */
-	btdev->features[5] |= 0x04;	/* Pause encryption */
-	btdev->features[5] |= 0x08;	/* AFH capable master */
-	btdev->features[5] |= 0x10;	/* AFH classification master */
-	btdev->features[6] |= 0x01;	/* Extended Inquiry Response */
-	btdev->features[6] |= 0x02;	/* Simultaneous LE and BR/EDR */
-	btdev->features[6] |= 0x08;	/* Secure Simple Pairing */
-	btdev->features[6] |= 0x10;	/* Encapsulated PDU */
-	btdev->features[6] |= 0x20;	/* Erroneous Data Reporting */
-	btdev->features[6] |= 0x40;	/* Non-flushable Packet Boundary Flag */
-	btdev->features[7] |= 0x01;	/* Link Supervision Timeout Event */
-	btdev->features[7] |= 0x02;	/* Inquiry TX Power Level */
-	btdev->features[7] |= 0x80;	/* Extended features */
+	const struct bt_hci_cmd_write_ext_inquiry_response *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	if (btdev->type >= BTDEV_TYPE_BREDRLE50) {
-		/* These BREDR features are added to test new configuration
-		 * command. If this is added above it will break existing tests
-		 */
-		btdev->features[0] |= 0x01;	/* 3 slot Packets */
-		btdev->features[0] |= 0x02;	/* 5 slot Packets */
-		btdev->features[3] |= 0x02;	/* EDR ACL 2M mode */
-		btdev->features[3] |= 0x04;	/* EDR ACL 3M mode */
-		btdev->features[4] |= 0x80;	/* 3 slot EDR ACL packets */
-		btdev->features[5] |= 0x01;	/* 5 slot EDR ACL packets */
+	dev->ext_inquiry_fec = cmd->fec;
+	memcpy(dev->ext_inquiry_rsp, cmd->data, 240);
+	cmd_complete(dev, BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE, &status,
+					sizeof(status));
 
-		btdev->le_features[1] |= 0x01;	/* LE 2M PHY */
-		btdev->le_features[1] |= 0x08;	/* LE Coded PHY */
-		btdev->le_features[1] |= 0x10;  /* LE EXT ADV */
-	}
+	return 0;
+}
 
-	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
-		btdev->le_features[3] |= 0x10;  /* LE CIS Master */
-		btdev->le_features[3] |= 0x20;  /* LE CIS Slave */
-		btdev->le_features[3] |= 0x40;  /* LE ISO Broadcaster */
-		btdev->le_features[3] |= 0x80;  /* LE Synchronized Receiver */
-		btdev->le_features[4] |= 0x01;  /* LE ISO channels */
-	}
+static int cmd_read_ssp_mode(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_simple_pairing_mode rsp;
 
-	btdev->feat_page_2[0] |= 0x01;	/* CSB - Master Operation */
-	btdev->feat_page_2[0] |= 0x02;	/* CSB - Slave Operation */
-	btdev->feat_page_2[0] |= 0x04;	/* Synchronization Train */
-	btdev->feat_page_2[0] |= 0x08;	/* Synchronization Scan */
-	btdev->feat_page_2[0] |= 0x10;	/* Inquiry Response Notification */
-	btdev->feat_page_2[1] |= 0x01;	/* Secure Connections */
-	btdev->feat_page_2[1] |= 0x02;	/* Ping */
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.mode = dev->simple_pairing_mode;
+	cmd_complete(dev, BT_HCI_CMD_READ_SIMPLE_PAIRING_MODE, &rsp,
+					sizeof(rsp));
 
-	btdev->max_page = 2;
+	return 0;
 }
 
-static void set_bredr_features(struct btdev *btdev)
+static int cmd_write_ssp_mode(struct btdev *dev, const void *data, uint8_t len)
 {
-	btdev->features[0] |= 0x04;	/* Encryption */
-	btdev->features[0] |= 0x20;	/* Role switch */
-	btdev->features[0] |= 0x80;	/* Sniff mode */
-	btdev->features[1] |= 0x08;	/* SCO link */
-	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
-	btdev->features[3] |= 0x80;	/* Extended SCO link */
-	btdev->features[4] |= 0x08;	/* AFH capable slave */
-	btdev->features[4] |= 0x10;	/* AFH classification slave */
-	btdev->features[5] |= 0x02;	/* Sniff subrating */
-	btdev->features[5] |= 0x04;	/* Pause encryption */
-	btdev->features[5] |= 0x08;	/* AFH capable master */
-	btdev->features[5] |= 0x10;	/* AFH classification master */
-	btdev->features[6] |= 0x01;	/* Extended Inquiry Response */
-	btdev->features[6] |= 0x08;	/* Secure Simple Pairing */
-	btdev->features[6] |= 0x10;	/* Encapsulated PDU */
-	btdev->features[6] |= 0x20;	/* Erroneous Data Reporting */
-	btdev->features[6] |= 0x40;	/* Non-flushable Packet Boundary Flag */
-	btdev->features[7] |= 0x01;	/* Link Supervision Timeout Event */
-	btdev->features[7] |= 0x02;	/* Inquiry TX Power Level */
-	btdev->features[7] |= 0x80;	/* Extended features */
+	const struct bt_hci_cmd_write_simple_pairing_mode *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	btdev->max_page = 1;
+	dev->simple_pairing_mode = cmd->mode;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE, &status,
+					sizeof(status));
+
+	return 0;
 }
 
-static void set_bredr20_features(struct btdev *btdev)
+static int cmd_read_oob_data(struct btdev *dev, const void *data, uint8_t len)
 {
-	btdev->features[0] |= 0x04;	/* Encryption */
-	btdev->features[0] |= 0x20;	/* Role switch */
-	btdev->features[0] |= 0x80;	/* Sniff mode */
-	btdev->features[1] |= 0x08;	/* SCO link */
-	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
-	btdev->features[3] |= 0x80;	/* Extended SCO link */
-	btdev->features[4] |= 0x08;	/* AFH capable slave */
-	btdev->features[4] |= 0x10;	/* AFH classification slave */
-	btdev->features[5] |= 0x02;	/* Sniff subrating */
-	btdev->features[5] |= 0x04;	/* Pause encryption */
-	btdev->features[5] |= 0x08;	/* AFH capable master */
-	btdev->features[5] |= 0x10;	/* AFH classification master */
-	btdev->features[7] |= 0x80;	/* Extended features */
+	struct bt_hci_rsp_read_local_oob_data rsp;
 
-	btdev->max_page = 1;
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_OOB_DATA, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
-static void set_le_features(struct btdev *btdev)
+static int cmd_read_inquiry_tx_power(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	btdev->features[4] |= 0x20;	/* BR/EDR Not Supported */
-	btdev->features[4] |= 0x40;	/* LE Supported */
+	struct bt_hci_rsp_read_inquiry_resp_tx_power rsp;
 
-	btdev->max_page = 1;
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.level = 0;
+	cmd_complete(dev, BT_HCI_CMD_READ_INQUIRY_RESP_TX_POWER, &rsp,
+					sizeof(rsp));
 
-	btdev->le_features[0] |= 0x01;	/* LE Encryption */
-	btdev->le_features[0] |= 0x02;	/* Connection Parameters Request */
-	btdev->le_features[0] |= 0x08;	/* Slave-initiated Features Exchange */
+	return 0;
 }
 
-static void set_le_states(struct btdev *btdev)
+static int cmd_write_inquiry_tx_power(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	/* Set all 41 bits as per Bluetooth 5.0 specification */
-	btdev->le_states[0] = 0xff;
-	btdev->le_states[1] = 0xff;
-	btdev->le_states[2] = 0xff;
-	btdev->le_states[3] = 0xff;
-	btdev->le_states[4] = 0xff;
-	btdev->le_states[5] = 0x03;
+	return -ENOTSUP;
 }
 
-static void set_amp_features(struct btdev *btdev)
+static int cmd_io_cap_reply(struct btdev *dev, const void *data, uint8_t len)
 {
-}
+	struct btdev *remote = dev->conn;
+	const struct bt_hci_cmd_io_capability_request_reply *cmd = data;
+	struct bt_hci_evt_io_capability_response ev;
+	struct bt_hci_rsp_io_capability_request_reply rsp;
+	uint8_t status;
 
-struct btdev *btdev_create(enum btdev_type type, uint16_t id)
-{
-	struct btdev *btdev;
-	int index;
+	if (!remote) {
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
 
-	btdev = malloc(sizeof(*btdev));
-	if (!btdev)
-		return NULL;
+	status = BT_HCI_ERR_SUCCESS;
 
-	memset(btdev, 0, sizeof(*btdev));
+	dev->io_cap = cmd->capability;
+	dev->auth_req = cmd->authentication;
 
-	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE ||
-			type == BTDEV_TYPE_BREDRLE50 ||
-			type == BTDEV_TYPE_BREDRLE52) {
-		btdev->crypto = bt_crypto_new();
-		if (!btdev->crypto) {
-			free(btdev);
-			return NULL;
-		}
+	memcpy(ev.bdaddr, dev->bdaddr, 6);
+	ev.capability = cmd->capability;
+	ev.oob_data = cmd->oob_data;
+	ev.authentication = cmd->authentication;
+
+	send_event(remote, BT_HCI_EVT_IO_CAPABILITY_RESPONSE, &ev, sizeof(ev));
+
+	if (remote->io_cap) {
+		struct bt_hci_evt_user_confirm_request cfm;
+
+		memcpy(cfm.bdaddr, dev->bdaddr, 6);
+		cfm.passkey = 0;
+
+		send_event(remote, BT_HCI_EVT_USER_CONFIRM_REQUEST,
+							&cfm, sizeof(cfm));
+
+		memcpy(cfm.bdaddr, cmd->bdaddr, 6);
+		send_event(dev, BT_HCI_EVT_USER_CONFIRM_REQUEST,
+							&cfm, sizeof(cfm));
+	} else {
+		send_event(remote, BT_HCI_EVT_IO_CAPABILITY_REQUEST,
+							dev->bdaddr, 6);
 	}
 
-	btdev->type = type;
+done:
+	rsp.status = status;
+	memcpy(rsp.bdaddr, cmd->bdaddr, 6);
+	cmd_complete(dev, BT_HCI_CMD_IO_CAPABILITY_REQUEST_REPLY,
+							&rsp, sizeof(rsp));
 
-	btdev->manufacturer = 63;
-	btdev->revision = 0x0000;
+	return 0;
+}
 
-	switch (btdev->type) {
-	case BTDEV_TYPE_BREDRLE:
-	case BTDEV_TYPE_BREDRLE50:
-	case BTDEV_TYPE_BREDRLE52:
-		btdev->version = 0x09;
-		set_bredrle_features(btdev);
-		set_bredrle_commands(btdev);
-		set_le_states(btdev);
-		break;
-	case BTDEV_TYPE_BREDR:
-		btdev->version = 0x05;
-		set_bredr_features(btdev);
-		set_bredr_commands(btdev);
-		break;
-	case BTDEV_TYPE_LE:
-		btdev->version = 0x09;
-		set_le_features(btdev);
-		set_le_commands(btdev);
-		set_le_states(btdev);
-		break;
-	case BTDEV_TYPE_AMP:
-		btdev->version = 0x01;
-		set_amp_features(btdev);
-		set_amp_commands(btdev);
-		break;
-	case BTDEV_TYPE_BREDR20:
-		btdev->version = 0x03;
-		set_bredr20_features(btdev);
-		set_bredr20_commands(btdev);
-		break;
+static void ssp_complete(struct btdev *btdev, const uint8_t *bdaddr,
+						uint8_t status, bool wait)
+{
+	struct bt_hci_evt_simple_pairing_complete iev, aev;
+	struct bt_hci_evt_auth_complete auth;
+	struct btdev *remote = btdev->conn;
+	struct btdev *init, *accp;
+
+	if (!remote)
+		return;
+
+	btdev->ssp_status = status;
+	btdev->ssp_auth_complete = true;
+
+	if (!remote->ssp_auth_complete && wait)
+		return;
+
+	if (status == BT_HCI_ERR_SUCCESS &&
+				remote->ssp_status != BT_HCI_ERR_SUCCESS)
+		status = remote->ssp_status;
+
+	iev.status = status;
+	aev.status = status;
+
+	if (btdev->auth_init) {
+		init = btdev;
+		accp = remote;
+		memcpy(iev.bdaddr, bdaddr, 6);
+		memcpy(aev.bdaddr, btdev->bdaddr, 6);
+	} else {
+		init = remote;
+		accp = btdev;
+		memcpy(iev.bdaddr, btdev->bdaddr, 6);
+		memcpy(aev.bdaddr, bdaddr, 6);
 	}
 
-	btdev->page_scan_interval = 0x0800;
-	btdev->page_scan_window = 0x0012;
-	btdev->page_scan_type = 0x00;
+	send_event(init, BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE, &iev,
+								sizeof(iev));
+	send_event(accp, BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE, &aev,
+								sizeof(aev));
 
-	btdev->sync_train_interval = 0x0080;
-	btdev->sync_train_timeout = 0x0002ee00;
-	btdev->sync_train_service_data = 0x00;
+	if (status == BT_HCI_ERR_SUCCESS) {
+		link_key_notify(init, iev.bdaddr, LINK_KEY_DUMMY);
+		link_key_notify(accp, aev.bdaddr, LINK_KEY_DUMMY);
+	}
 
-	btdev->acl_mtu = 192;
-	btdev->acl_max_pkt = 1;
+	auth.status = status;
+	auth.handle = cpu_to_le16(ACL_HANDLE);
+	send_event(init, BT_HCI_EVT_AUTH_COMPLETE, &auth, sizeof(auth));
+}
 
-	btdev->iso_mtu = 251;
-	btdev->iso_max_pkt = 1;
+static int cmd_user_confirm_reply(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_user_confirm_request_reply rsp;
 
-	btdev->country_code = 0x00;
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, data, 6);
+	cmd_complete(dev, BT_HCI_CMD_USER_CONFIRM_REQUEST_REPLY, &rsp,
+					sizeof(rsp));
+	ssp_complete(dev, data, BT_HCI_ERR_SUCCESS, true);
 
-	index = add_btdev(btdev);
-	if (index < 0) {
-		bt_crypto_unref(btdev->crypto);
-		free(btdev);
-		return NULL;
-	}
+	return 0;
+}
 
-	get_bdaddr(id, index, btdev->bdaddr);
+static int cmd_user_confirm_negative_reply(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_user_confirm_request_neg_reply rsp;
 
-	return btdev;
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, data, 6);
+	cmd_complete(dev, BT_HCI_CMD_USER_CONFIRM_REQUEST_NEG_REPLY,
+					&rsp, sizeof(rsp));
+	ssp_complete(dev, data, BT_HCI_ERR_AUTH_FAILURE, true);
+
+	return 0;
 }
 
-void btdev_destroy(struct btdev *btdev)
+static int cmd_user_passkey_reply(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	if (!btdev)
-		return;
+	return -ENOTSUP;
+}
 
-	if (btdev->inquiry_id > 0)
-		timeout_remove(btdev->inquiry_id);
+static int cmd_user_passkey_negative_reply(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	return -ENOTSUP;
+}
 
-	bt_crypto_unref(btdev->crypto);
-	del_btdev(btdev);
+static int cmd_io_cap_negative_reply(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_io_capability_request_neg_reply *cmd = data;
+	struct bt_hci_rsp_io_capability_request_neg_reply rsp;
 
-	free(btdev);
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.bdaddr, cmd->bdaddr, 6);
+	cmd_complete(dev, BT_HCI_CMD_IO_CAPABILITY_REQUEST_NEG_REPLY,
+							&rsp, sizeof(rsp));
+
+	ssp_complete(dev, cmd->bdaddr, BT_HCI_ERR_AUTH_FAILURE, false);
+
+	return 0;
 }
 
-bool btdev_set_debug(struct btdev *btdev, btdev_debug_func_t callback,
-			void *user_data, btdev_destroy_func_t destroy)
+static int cmd_read_encrypt_key_size(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	if (!btdev)
-		return false;
+	const struct bt_hci_cmd_read_encrypt_key_size *cmd = data;
+	struct bt_hci_rsp_read_encrypt_key_size rsp;
 
-	if (btdev->debug_destroy)
-		btdev->debug_destroy(btdev->debug_data);
+	rsp.handle = cmd->handle;
 
-	btdev->debug_callback = callback;
-	btdev->debug_destroy = destroy;
-	btdev->debug_data = user_data;
+	if (dev->conn) {
+		rsp.status = BT_HCI_ERR_SUCCESS;
+		rsp.key_size = 16;
+	} else {
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		rsp.key_size = 0;
+	}
 
-	return true;
+	cmd_complete(dev, BT_HCI_CMD_READ_ENCRYPT_KEY_SIZE, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
-const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
+static int cmd_read_data_block_size(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	return btdev->bdaddr;
+	struct bt_hci_rsp_read_data_block_size rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.max_acl_len = cpu_to_le16(dev->acl_mtu);
+	rsp.block_len = cpu_to_le16(dev->acl_mtu);
+	rsp.num_blocks = cpu_to_le16(dev->acl_max_pkt);
+	cmd_complete(dev, BT_HCI_CMD_READ_DATA_BLOCK_SIZE, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
-uint8_t *btdev_get_features(struct btdev *btdev)
+static int cmd_read_local_codecs(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	return btdev->features;
+	struct bt_hci_rsp_read_local_codecs *rsp;
+
+	rsp = alloca(sizeof(*rsp) + 7);
+	rsp->status = BT_HCI_ERR_SUCCESS;
+	rsp->num_codecs = 0x06;
+	rsp->codec[0] = 0x00;
+	rsp->codec[1] = 0x01;
+	rsp->codec[2] = 0x02;
+	rsp->codec[3] = 0x03;
+	rsp->codec[4] = 0x04;
+	rsp->codec[5] = 0x05;
+	rsp->codec[6] = 0x00;
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_CODECS, rsp, sizeof(*rsp) + 7);
+
+	return 0;
 }
 
-uint8_t btdev_get_scan_enable(struct btdev *btdev)
+static int cmd_get_mws_transport_config(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	return btdev->scan_enable;
+	struct bt_hci_rsp_get_mws_transport_config *rsp;
+
+	rsp = alloca(sizeof(*rsp));
+	rsp->status = BT_HCI_ERR_SUCCESS;
+	rsp->num_transports = 0x00;
+	cmd_complete(dev, BT_HCI_CMD_GET_MWS_TRANSPORT_CONFIG, rsp,
+					sizeof(*rsp));
+
+	return 0;
 }
 
-uint8_t btdev_get_le_scan_enable(struct btdev *btdev)
+#define CMD_BREDR \
+	CMD(BT_HCI_CMD_SETUP_SYNC_CONN, cmd_setup_sync_conn, NULL), \
+	CMD(BT_HCI_CMD_READ_EXT_INQUIRY_RESPONSE, cmd_read_ext_inquiry, NULL), \
+	CMD(BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE, cmd_write_ext_inquiry, \
+					NULL), \
+	CMD(BT_HCI_CMD_READ_SIMPLE_PAIRING_MODE, cmd_read_ssp_mode, NULL), \
+	CMD(BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE, cmd_write_ssp_mode, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_OOB_DATA, cmd_read_oob_data, NULL), \
+	CMD(BT_HCI_CMD_READ_INQUIRY_RESP_TX_POWER, cmd_read_inquiry_tx_power, \
+					NULL), \
+	CMD(BT_HCI_CMD_WRITE_INQUIRY_TX_POWER, cmd_write_inquiry_tx_power, \
+					NULL), \
+	CMD(BT_HCI_CMD_IO_CAPABILITY_REQUEST_REPLY, cmd_io_cap_reply, NULL), \
+	CMD(BT_HCI_CMD_USER_CONFIRM_REQUEST_REPLY, cmd_user_confirm_reply, \
+					NULL), \
+	CMD(BT_HCI_CMD_USER_CONFIRM_REQUEST_NEG_REPLY, \
+					cmd_user_confirm_negative_reply, \
+					NULL), \
+	CMD(BT_HCI_CMD_USER_PASSKEY_REQUEST_NEG_REPLY, cmd_user_passkey_reply, \
+					NULL), \
+	CMD(BT_HCI_CMD_USER_PASSKEY_REQUEST_NEG_REPLY, \
+					cmd_user_passkey_negative_reply, \
+					NULL), \
+	CMD(BT_HCI_CMD_IO_CAPABILITY_REQUEST_NEG_REPLY, \
+					cmd_io_cap_negative_reply, NULL), \
+	CMD(BT_HCI_CMD_READ_ENCRYPT_KEY_SIZE, cmd_read_encrypt_key_size, \
+					NULL), \
+	CMD(BT_HCI_CMD_READ_DATA_BLOCK_SIZE, cmd_read_data_block_size, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_CODECS, cmd_read_local_codecs, NULL), \
+	CMD(BT_HCI_CMD_GET_MWS_TRANSPORT_CONFIG, cmd_get_mws_transport_config, \
+					NULL)
+
+static const struct btdev_cmd cmd_bredr[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_COMMON_BREDR_20,
+	CMD_BREDR,
+	{}
+};
+
+static void set_bredr_commands(struct btdev *btdev)
 {
-	return btdev->le_scan_enable;
+	set_common_commands_all(btdev);
+	set_common_commands_bredrle(btdev);
+	set_common_commands_bredr20(btdev);
+
+	btdev->commands[16] |= 0x08;	/* Setup Synchronous Connection */
+	btdev->commands[17] |= 0x01;	/* Read Extended Inquiry Response */
+	btdev->commands[17] |= 0x02;	/* Write Extended Inquiry Response */
+	btdev->commands[17] |= 0x20;	/* Read Simple Pairing Mode */
+	btdev->commands[17] |= 0x40;	/* Write Simple Pairing Mode */
+	btdev->commands[17] |= 0x80;	/* Read Local OOB Data */
+	btdev->commands[18] |= 0x01;	/* Read Inquiry Response TX Power */
+	btdev->commands[18] |= 0x02;	/* Write Inquiry Response TX Power */
+	btdev->commands[18] |= 0x80;	/* IO Capability Request Reply */
+	btdev->commands[19] |= 0x01;	/* User Confirmation Request Reply */
+	btdev->commands[19] |= 0x02;	/* User Confirmation Request N Reply */
+	btdev->commands[19] |= 0x04;	/* User Passkey Request Reply */
+	btdev->commands[19] |= 0x08;	/* User Passkey Request N Reply */
+	btdev->commands[20] |= 0x08;	/* IO Capability Request N Reply */
+	btdev->commands[20] |= 0x10;	/* Read Encryption Key Size */
+	btdev->commands[23] |= 0x04;	/* Read Data Block Size */
+	btdev->commands[29] |= 0x20;	/* Read Local Supported Codecs */
+	btdev->commands[30] |= 0x08;	/* Get MWS Transport Layer Config */
+	btdev->cmds = cmd_bredr;
 }
 
-void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states)
+static const struct btdev_cmd cmd_bredr_20[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_COMMON_BREDR_20,
+	{}
+};
+
+static void set_bredr20_commands(struct btdev *btdev)
 {
-	memcpy(btdev->le_states, le_states, sizeof(btdev->le_states));
+	set_common_commands_all(btdev);
+	set_common_commands_bredrle(btdev);
+	set_common_commands_bredr20(btdev);
+	btdev->cmds = cmd_bredr_20;
 }
 
-static bool use_ssp(struct btdev *btdev1, struct btdev *btdev2)
+static int cmd_read_le_host_supported(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	if (btdev1->auth_enable || btdev2->auth_enable)
-		return false;
+	struct bt_hci_rsp_read_le_host_supported rsp;
 
-	return (btdev1->simple_pairing_mode && btdev2->simple_pairing_mode);
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.supported = dev->le_supported;
+	rsp.simultaneous = dev->le_simultaneous;
+	cmd_complete(dev, BT_HCI_CMD_READ_LE_HOST_SUPPORTED, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
-void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
-							void *user_data)
+static int cmd_write_le_host_supported(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	if (!btdev)
-		return;
+	const struct bt_hci_cmd_write_le_host_supported *cmd = data;
+	uint8_t status;
 
-	btdev->command_handler = handler;
-	btdev->command_data = user_data;
+	dev->le_supported = cmd->supported;
+	dev->le_simultaneous = cmd->simultaneous;
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED, &status,
+						sizeof(status));
+
+	return 0;
 }
 
-void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
-							void *user_data)
+static int cmd_le_set_event_mask(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	if (!btdev)
-		return;
+	const struct bt_hci_cmd_le_set_event_mask *cmd = data;
+	uint8_t status;
 
-	btdev->send_handler = handler;
-	btdev->send_data = user_data;
+	memcpy(dev->le_event_mask, cmd->mask, 8);
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_EVENT_MASK, &status,
+						sizeof(status));
+
+	return 0;
 }
 
-static void send_packet(struct btdev *btdev, const struct iovec *iov,
-								int iovlen)
+static int cmd_le_read_buffer_size(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	int i;
+	struct bt_hci_rsp_le_read_buffer_size rsp;
 
-	if (!btdev->send_handler)
-		return;
+	memset(&rsp, 0, sizeof(rsp));
 
-	for (i = 0; i < iovlen; i++) {
-		if (!i)
-			util_hexdump('<', iov[i].iov_base, iov[i].iov_len,
-				btdev->debug_callback, btdev->debug_data);
-		else
-			util_hexdump(' ', iov[i].iov_base, iov[i].iov_len,
-				btdev->debug_callback, btdev->debug_data);
-	}
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.le_mtu = cpu_to_le16(dev->acl_mtu);
+	rsp.le_max_pkt = dev->acl_max_pkt;
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_BUFFER_SIZE, &rsp, sizeof(rsp));
 
-	btdev->send_handler(iov, iovlen, btdev->send_data);
+	return 0;
 }
 
-static void send_event(struct btdev *btdev, uint8_t event,
-						const void *data, uint8_t len)
+static int cmd_le_read_local_features(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct bt_hci_evt_hdr hdr;
-	struct iovec iov[3];
-	uint8_t pkt = BT_H4_EVT_PKT;
+	struct bt_hci_rsp_le_read_local_features rsp;
 
-	util_debug(btdev->debug_callback, btdev->debug_data,
-				"event 0x%02x", event);
+	memset(&rsp, 0, sizeof(rsp));
 
-	iov[0].iov_base = &pkt;
-	iov[0].iov_len = sizeof(pkt);
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.features, dev->le_features, 8);
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_LOCAL_FEATURES, &rsp, sizeof(rsp));
 
-	hdr.evt = event;
-	hdr.plen = len;
+	return 0;
+}
 
-	iov[1].iov_base = &hdr;
-	iov[1].iov_len = sizeof(hdr);
+static int cmd_set_random_address(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_random_address *cmd = data;
+	uint8_t status;
 
-	if (len > 0) {
-		iov[2].iov_base = (void *) data;
-		iov[2].iov_len = len;
-	}
+	memcpy(dev->random_addr, cmd->addr, 6);
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_RANDOM_ADDRESS, &status,
+						sizeof(status));
 
-	if (run_hooks(btdev, BTDEV_HOOK_POST_EVT, event, data, len))
-		send_packet(btdev, iov, len > 0 ? 3 : 2);
+	return 0;
 }
 
-static void send_cmd(struct btdev *btdev, uint8_t evt, uint16_t opcode,
-					const struct iovec *iov, int iovlen)
+static uint16_t ext_legacy_adv_type(uint8_t type)
 {
-	struct bt_hci_evt_hdr hdr;
-	struct iovec iov2[2 + iovlen];
-	uint8_t pkt = BT_H4_EVT_PKT;
-	int i;
+	switch (type) {
+	case 0x00:
+		/* Connectable undirected - ADV_IND" */
+		return 0x0013;
+	case 0x01:
+		/* Connectable directed - ADV_DIRECT_IND */
+		return 0x0015;
+	case 0x02:
+		/* Scannable undirected - ADV_SCAN_IND */
+		return 0x0012;
+	case 0x03:
+		/* Non connectable undirected - ADV_NONCONN_IND */
+		return 0x0010;
+	case 0x04:
+		/* Scan response - SCAN_RSP */
+		return 0x0012;
+	}
 
-	util_debug(btdev->debug_callback, btdev->debug_data,
-				"event 0x%02x opcode 0x%04x", evt, opcode);
+	return 0x0000;
+}
 
-	iov2[0].iov_base = &pkt;
-	iov2[0].iov_len = sizeof(pkt);
+static int cmd_set_adv_params(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_adv_parameters *cmd = data;
+	uint8_t status;
 
-	hdr.evt = evt;
-	hdr.plen = 0;
+	if (dev->le_adv_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
 
-	iov2[1].iov_base = &hdr;
-	iov2[1].iov_len = sizeof(hdr);
+	dev->le_adv_type = cmd->type;
+	/* Use Legacy PDU if the remote is using EXT Scan */
+	dev->le_ext_adv_type = ext_legacy_adv_type(cmd->type);
+	dev->le_adv_own_addr = cmd->own_addr_type;
+	dev->le_adv_direct_addr_type = cmd->direct_addr_type;
+	memcpy(dev->le_adv_direct_addr, cmd->direct_addr, 6);
 
-	for (i = 0; i < iovlen; i++) {
-		hdr.plen += iov[i].iov_len;
-		iov2[2 + i].iov_base = iov[i].iov_base;
-		iov2[2 + i].iov_len = iov[i].iov_len;
-	}
+	status = BT_HCI_ERR_SUCCESS;
 
-	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, iov[i -1].iov_base,
-							iov[i -1].iov_len))
-		send_packet(btdev, iov2, 2 + iovlen);
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_ADV_PARAMETERS, &status,
+		     sizeof(status));
+
+	return 0;
 }
 
-static void cmd_complete(struct btdev *btdev, uint16_t opcode,
-						const void *data, uint8_t len)
+static int cmd_read_adv_tx_power(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct bt_hci_evt_cmd_complete cc;
-	struct iovec iov[2];
-
-	cc.ncmd = 0x01;
-	cc.opcode = cpu_to_le16(opcode);
-
-	iov[0].iov_base = &cc;
-	iov[0].iov_len = sizeof(cc);
+	struct bt_hci_rsp_le_read_adv_tx_power rsp;
 
-	iov[1].iov_base = (void *) data;
-	iov[1].iov_len = len;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.level = 0;
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_ADV_TX_POWER, &rsp, sizeof(rsp));
 
-	send_cmd(btdev, BT_HCI_EVT_CMD_COMPLETE, opcode, iov, 2);
+	return 0;
 }
 
-static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
+static int cmd_set_adv_data(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct bt_hci_evt_cmd_status cs;
-	struct iovec iov;
+	const struct bt_hci_cmd_le_set_adv_data *cmd = data;
+	uint8_t status;
 
-	cs.status = status;
-	cs.ncmd = 0x01;
-	cs.opcode = cpu_to_le16(opcode);
+	dev->le_adv_data_len = cmd->len;
+	memcpy(dev->le_adv_data, cmd->data, 31);
+	status = BT_HCI_ERR_SUCCESS;
 
-	iov.iov_base = &cs;
-	iov.iov_len = sizeof(cs);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_ADV_DATA, &status, sizeof(status));
 
-	send_cmd(btdev, BT_HCI_EVT_CMD_STATUS, opcode, &iov, 1);
+	return 0;
 }
 
-static void le_meta_event(struct btdev *btdev, uint8_t event,
-						void *data, uint8_t len)
+static int cmd_set_scan_rsp_data(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	void *pkt_data;
+	const struct bt_hci_cmd_le_set_scan_rsp_data *cmd = data;
+	uint8_t status;
 
-	util_debug(btdev->debug_callback, btdev->debug_data,
-				"meta event 0x%02x", event);
+	dev->le_scan_data_len = cmd->len;
+	memcpy(dev->le_scan_data, cmd->data, 31);
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_SCAN_RSP_DATA, &status,
+						sizeof(status));
 
-	pkt_data = alloca(1 + len);
-	if (!pkt_data)
-		return;
+	return 0;
+}
 
-	((uint8_t *) pkt_data)[0] = event;
+static uint8_t get_ext_adv_type(uint8_t ext_adv_type)
+{
+	/*
+	 * If legacy bit is not set then just reset high duty cycle directed
+	 * bit.
+	 */
+	if (!(ext_adv_type & 0x10))
+		return (ext_adv_type & 0xf7);
 
-	if (len > 0)
-		memcpy(pkt_data + 1, data, len);
+	/*
+	 * Connectable low duty cycle directed advertising creates a
+	 * connectable directed advertising report type.
+	 */
+	if (ext_adv_type == 0x001d)
+		return 0x0015;
 
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, pkt_data, 1 + len);
+	return ext_adv_type;
 }
 
-static void num_completed_packets(struct btdev *btdev, uint16_t handle)
+static const uint8_t *scan_addr(const struct btdev *btdev)
 {
-	if (btdev->conn) {
-		struct bt_hci_evt_num_completed_packets ncp;
-
-		ncp.num_handles = 1;
-		ncp.handle = cpu_to_le16(handle);
-		ncp.count = cpu_to_le16(1);
+	if (btdev->le_scan_own_addr_type == 0x01)
+		return btdev->random_addr;
 
-		send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS,
-							&ncp, sizeof(ncp));
-	}
+	return btdev->bdaddr;
 }
 
-static bool inquiry_callback(void *user_data)
+static bool ext_adv_match(struct btdev *scan, struct btdev *adv)
 {
-	struct inquiry_data *data = user_data;
-	struct btdev *btdev = data->btdev;
-	struct bt_hci_evt_inquiry_complete ic;
-	int sent = data->sent_count;
-	int i;
-
-	/*Report devices only once and wait for inquiry timeout*/
-	if (data->iter == MAX_BTDEV_ENTRIES)
+	/* Match everything if this is not directed advertising */
+	if (!(adv->le_ext_adv_type & 0x04))
 		return true;
 
-	for (i = data->iter; i < MAX_BTDEV_ENTRIES; i++) {
-		/*Lets sent 10 inquiry results at once */
-		if (sent + 10 == data->sent_count)
-			break;
-
-		if (!btdev_list[i] || btdev_list[i] == btdev)
-			continue;
-
-		if (!(btdev_list[i]->scan_enable & 0x02))
-			continue;
-
-		if (btdev->inquiry_mode == 0x02 &&
-					btdev_list[i]->ext_inquiry_rsp[0]) {
-			struct bt_hci_evt_ext_inquiry_result ir;
+	if (scan->le_scan_own_addr_type != adv->le_adv_direct_addr_type)
+		return false;
 
-			ir.num_resp = 0x01;
-			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
-			ir.pscan_rep_mode = 0x00;
-			ir.pscan_period_mode = 0x00;
-			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
-			ir.clock_offset = 0x0000;
-			ir.rssi = -60;
-			memcpy(ir.data, btdev_list[i]->ext_inquiry_rsp, 240);
+	return !memcmp(scan_addr(scan), adv->le_adv_direct_addr, 6);
+}
 
-			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT,
-							&ir, sizeof(ir));
-			data->sent_count++;
-			continue;
-		}
+static const uint8_t *adv_addr(const struct btdev *btdev)
+{
+	if (btdev->le_adv_own_addr == 0x01)
+		return btdev->random_addr;
 
-		if (btdev->inquiry_mode > 0x00) {
-			struct bt_hci_evt_inquiry_result_with_rssi ir;
+	return btdev->bdaddr;
+}
 
-			ir.num_resp = 0x01;
-			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
-			ir.pscan_rep_mode = 0x00;
-			ir.pscan_period_mode = 0x00;
-			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
-			ir.clock_offset = 0x0000;
-			ir.rssi = -60;
+static void le_send_adv_report(struct btdev *btdev, const struct btdev *remote,
+								uint8_t type)
+{
+	struct __packed {
+		uint8_t subevent;
+		union {
+			struct bt_hci_evt_le_adv_report lar;
+			uint8_t raw[10 + 31 + 1];
+		};
+	} meta_event;
 
-			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT_WITH_RSSI,
-							&ir, sizeof(ir));
-			data->sent_count++;
-		} else {
-			struct bt_hci_evt_inquiry_result ir;
+	meta_event.subevent = BT_HCI_EVT_LE_ADV_REPORT;
 
-			ir.num_resp = 0x01;
-			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
-			ir.pscan_rep_mode = 0x00;
-			ir.pscan_period_mode = 0x00;
-			ir.pscan_mode = 0x00;
-			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
-			ir.clock_offset = 0x0000;
+	memset(&meta_event.lar, 0, sizeof(meta_event.lar));
+	meta_event.lar.num_reports = 1;
+	meta_event.lar.event_type = type;
+	meta_event.lar.addr_type = remote->le_adv_own_addr;
+	memcpy(meta_event.lar.addr, adv_addr(remote), 6);
 
-			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT,
-							&ir, sizeof(ir));
-			data->sent_count++;
-		}
+	/* Scan or advertising response */
+	if (type == 0x04) {
+		meta_event.lar.data_len = remote->le_scan_data_len;
+		memcpy(meta_event.lar.data, remote->le_scan_data,
+						meta_event.lar.data_len);
+	} else {
+		meta_event.lar.data_len = remote->le_adv_data_len;
+		memcpy(meta_event.lar.data, remote->le_adv_data,
+						meta_event.lar.data_len);
 	}
-	data->iter = i;
+	/* Not available */
+	meta_event.raw[10 + meta_event.lar.data_len] = 127;
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &meta_event,
+					1 + 10 + meta_event.lar.data_len + 1);
+}
 
-	/* Check if we sent already required amount of responses*/
-	if (data->num_resp && data->sent_count == data->num_resp)
-		goto finish;
+static uint8_t get_adv_report_type(uint8_t adv_type)
+{
+	/*
+	 * Connectable low duty cycle directed advertising creates a
+	 * connectable directed advertising report type.
+	 */
+	if (adv_type == 0x04)
+		return 0x01;
 
-	return true;
+	return adv_type;
+}
 
-finish:
-	/* Note that destroy will be called */
-	ic.status = BT_HCI_ERR_SUCCESS;
-	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+static bool adv_match(struct btdev *scan, struct btdev *adv)
+{
+	/* Match everything if this is not directed advertising */
+	if (adv->le_adv_type != 0x01 && adv->le_adv_type != 0x04)
+		return true;
 
-	return false;
+	if (scan->le_scan_own_addr_type != adv->le_adv_direct_addr_type)
+		return false;
+
+	return !memcmp(scan_addr(scan), adv->le_adv_direct_addr, 6);
 }
 
-static void inquiry_destroy(void *user_data)
+static void le_set_adv_enable_complete(struct btdev *btdev)
 {
-	struct inquiry_data *data = user_data;
-	struct btdev *btdev = data->btdev;
-
-	if (!btdev)
-		goto finish;
+	uint8_t report_type;
+	int i;
 
-	btdev->inquiry_id = 0;
+	report_type = get_adv_report_type(btdev->le_adv_type);
 
-	if (btdev->inquiry_timeout_id > 0) {
-		timeout_remove(btdev->inquiry_timeout_id);
-		btdev->inquiry_timeout_id = 0;
-	}
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
 
-finish:
-	free(data);
-}
+		if (!btdev_list[i]->le_scan_enable)
+			continue;
 
-static bool inquiry_timeout(void *user_data)
-{
-	struct inquiry_data *data = user_data;
-	struct btdev *btdev = data->btdev;
-	struct bt_hci_evt_inquiry_complete ic;
+		if (!adv_match(btdev_list[i], btdev))
+			continue;
 
-	timeout_remove(btdev->inquiry_id);
-	btdev->inquiry_timeout_id = 0;
+		le_send_adv_report(btdev_list[i], btdev, report_type);
 
-	/* Inquiry is stopped, send Inquiry complete event. */
-	ic.status = BT_HCI_ERR_SUCCESS;
-	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+		if (btdev_list[i]->le_scan_type != 0x01)
+			continue;
 
-	return false;
+		/* ADV_IND & ADV_SCAN_IND generate a scan response */
+		if (btdev->le_adv_type == 0x00 || btdev->le_adv_type == 0x02)
+			le_send_adv_report(btdev_list[i], btdev, 0x04);
+	}
 }
 
-static void inquiry_cmd(struct btdev *btdev, const void *cmd)
+static int cmd_set_adv_enable(struct btdev *dev, const void *data, uint8_t len)
 {
-	const struct bt_hci_cmd_inquiry *inq_cmd = cmd;
-	struct inquiry_data *data;
-	struct bt_hci_evt_inquiry_complete ic;
-	int status = BT_HCI_ERR_HARDWARE_FAILURE;
-	unsigned int inquiry_len_ms;
+	const struct bt_hci_cmd_le_set_ext_adv_enable *cmd = data;
+	uint8_t status;
 
-	if (btdev->inquiry_id > 0) {
+	if (dev->le_adv_enable == cmd->enable) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
-		goto failed;
+		goto done;
 	}
 
-	data = malloc(sizeof(*data));
-	if (!data)
-		goto failed;
-
-	memset(data, 0, sizeof(*data));
-	data->btdev = btdev;
-	data->num_resp = inq_cmd->num_resp;
-
-	/* Add timeout to cancel inquiry */
-	inquiry_len_ms = 1280 * inq_cmd->length;
-	if (inquiry_len_ms)
-		btdev->inquiry_timeout_id = timeout_add(inquiry_len_ms,
-							inquiry_timeout,
-							data, NULL);
+	dev->le_adv_enable = cmd->enable;
+	status = BT_HCI_ERR_SUCCESS;
 
-	btdev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
-							inquiry_callback, data,
-							inquiry_destroy);
-	/* Return if success */
-	if (btdev->inquiry_id > 0)
-		return;
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_ADV_ENABLE, &status,
+						sizeof(status));
 
-failed:
-	ic.status = status;
-	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+	if (!status && dev->le_adv_enable)
+		le_set_adv_enable_complete(dev);
+
+	return 0;
 }
 
-static void inquiry_cancel(struct btdev *btdev)
+static int cmd_set_scan_params(struct btdev *dev, const void *data, uint8_t len)
 {
+	const struct bt_hci_cmd_le_set_scan_parameters *cmd = data;
 	uint8_t status;
 
-	if (!btdev->inquiry_id) {
+	if (dev->le_scan_enable) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
-		cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
-							sizeof(status));
-		return;
+		goto done;
 	}
 
-	timeout_remove(btdev->inquiry_timeout_id);
-	btdev->inquiry_timeout_id = 0;
-	timeout_remove(btdev->inquiry_id);
-	btdev->inquiry_id = 0;
-
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
-							sizeof(status));
-}
-
-static void conn_complete(struct btdev *btdev,
-					const uint8_t *bdaddr, uint8_t status)
-{
-	struct bt_hci_evt_conn_complete cc;
-
-	if (!status) {
-		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
-
-		btdev->conn = remote;
-		remote->conn = btdev;
+	dev->le_scan_type = cmd->type;
+	dev->le_scan_own_addr_type = cmd->own_addr_type;
 
-		cc.status = status;
-		memcpy(cc.bdaddr, btdev->bdaddr, 6);
-		cc.encr_mode = 0x00;
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS, &status,
+						sizeof(status));
 
-		cc.handle = cpu_to_le16(ACL_HANDLE);
-		cc.link_type = 0x01;
+	return 0;
+}
 
-		send_event(remote, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+static int cmd_set_scan_enable(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_scan_enable *cmd = data;
+	uint8_t status;
 
-		cc.handle = cpu_to_le16(ACL_HANDLE);
-		cc.link_type = 0x01;
-	} else {
-		cc.handle = cpu_to_le16(0x0000);
-		cc.link_type = 0x01;
+	if (dev->le_scan_enable == cmd->enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
 	}
 
-	cc.status = status;
-	memcpy(cc.bdaddr, bdaddr, 6);
-	cc.encr_mode = 0x00;
+	dev->le_scan_enable = cmd->enable;
+	dev->le_filter_dup = cmd->filter_dup;
+	status = BT_HCI_ERR_SUCCESS;
 
-	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_SCAN_ENABLE, &status,
+						sizeof(status));
+
+	return 0;
 }
 
-static void accept_conn_request_complete(struct btdev *btdev,
-							const uint8_t *bdaddr)
+static int cmd_set_scan_enable_complete(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+	const struct bt_hci_cmd_le_set_scan_enable *cmd = data;
+	int i;
 
-	if (!remote)
-		return;
+	if (!dev->le_scan_enable || !cmd->enable)
+		return 0;
 
-	if (btdev->auth_enable || remote->auth_enable)
-		send_event(remote, BT_HCI_EVT_LINK_KEY_REQUEST,
-							btdev->bdaddr, 6);
-	else
-		conn_complete(btdev, bdaddr, BT_HCI_ERR_SUCCESS);
-}
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		uint8_t report_type;
 
-static void sync_conn_complete(struct btdev *btdev, uint16_t voice_setting,
-								uint8_t status)
-{
-	struct bt_hci_evt_sync_conn_complete cc;
+		if (!btdev_list[i] || btdev_list[i] == dev)
+			continue;
 
-	if (!btdev->conn)
-		return;
+		if (!btdev_list[i]->le_adv_enable)
+			continue;
 
-	cc.status = status;
-	memcpy(cc.bdaddr, btdev->conn->bdaddr, 6);
+		if (!adv_match(dev, btdev_list[i]))
+			continue;
 
-	cc.handle = cpu_to_le16(status == BT_HCI_ERR_SUCCESS ? 257 : 0);
-	cc.link_type = 0x02;
-	cc.tx_interval = 0x000c;
-	cc.retrans_window = 0x06;
-	cc.rx_pkt_len = 60;
-	cc.tx_pkt_len = 60;
-	cc.air_mode = (voice_setting == 0x0060) ? 0x02 : 0x03;
+		report_type = get_adv_report_type(btdev_list[i]->le_adv_type);
+		le_send_adv_report(dev, btdev_list[i], report_type);
 
-	send_event(btdev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
-}
+		if (dev->le_scan_type != 0x01)
+			continue;
 
-static void sco_conn_complete(struct btdev *btdev, uint8_t status)
-{
-	struct bt_hci_evt_conn_complete cc;
+		/* ADV_IND & ADV_SCAN_IND generate a scan response */
+		if (btdev_list[i]->le_adv_type == 0x00 ||
+					btdev_list[i]->le_adv_type == 0x02)
+			le_send_adv_report(dev, btdev_list[i], 0x04);
+	}
 
-	if (!btdev->conn)
-		return;
+	return 0;
+}
 
-	cc.status = status;
-	memcpy(cc.bdaddr, btdev->conn->bdaddr, 6);
-	cc.handle = cpu_to_le16(status == BT_HCI_ERR_SUCCESS ? 257 : 0);
-	cc.link_type = 0x00;
-	cc.encr_mode = 0x00;
+static bool adv_connectable(struct btdev *btdev)
+{
+	if (!btdev->le_adv_enable)
+		return false;
 
-	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+	return btdev->le_adv_type != 0x03;
 }
 
 static void le_conn_complete(struct btdev *btdev,
@@ -1265,232 +3021,59 @@ static void le_conn_complete(struct btdev *btdev,
 	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
 }
 
-static void le_ext_conn_complete(struct btdev *btdev,
-			const struct bt_hci_cmd_le_ext_create_conn *leecc,
-			uint8_t status)
-{
-	char buf[1 + sizeof(struct bt_hci_evt_le_enhanced_conn_complete)];
-	struct bt_hci_evt_le_enhanced_conn_complete *cc = (void *) &buf[1];
-	struct bt_hci_le_ext_create_conn *lecc = (void *)leecc->data;
-
-	memset(buf, 0, sizeof(buf));
-
-	buf[0] = BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE;
-
-	if (!status) {
-		struct btdev *remote;
-
-		remote = find_btdev_by_bdaddr_type(leecc->peer_addr,
-							leecc->peer_addr_type);
-
-		btdev->conn = remote;
-		btdev->le_adv_enable = 0;
-		remote->conn = btdev;
-		remote->le_adv_enable = 0;
-
-		cc->status = status;
-		cc->peer_addr_type = btdev->le_scan_own_addr_type;
-		if (cc->peer_addr_type == 0x01)
-			memcpy(cc->peer_addr, btdev->random_addr, 6);
-		else
-			memcpy(cc->peer_addr, btdev->bdaddr, 6);
-
-		cc->role = 0x01;
-		cc->handle = cpu_to_le16(ACL_HANDLE);
-		cc->interval = lecc->max_interval;
-		cc->latency = lecc->latency;
-		cc->supv_timeout = lecc->supv_timeout;
-
-		send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
-	}
-
-	cc->status = status;
-	cc->peer_addr_type = leecc->peer_addr_type;
-	memcpy(cc->peer_addr, leecc->peer_addr, 6);
-	cc->role = 0x00;
-
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
-}
-
-static const uint8_t *scan_addr(const struct btdev *btdev)
-{
-	if (btdev->le_scan_own_addr_type == 0x01)
-		return btdev->random_addr;
-
-	return btdev->bdaddr;
-}
-
-static const uint8_t *adv_addr(const struct btdev *btdev)
-{
-	if (btdev->le_adv_own_addr == 0x01)
-		return btdev->random_addr;
-
-	return btdev->bdaddr;
-}
-
-static bool adv_match(struct btdev *scan, struct btdev *adv)
-{
-	/* Match everything if this is not directed advertising */
-	if (adv->le_adv_type != 0x01 && adv->le_adv_type != 0x04)
-		return true;
-
-	if (scan->le_scan_own_addr_type != adv->le_adv_direct_addr_type)
-		return false;
-
-	return !memcmp(scan_addr(scan), adv->le_adv_direct_addr, 6);
-}
-
-static bool ext_adv_match(struct btdev *scan, struct btdev *adv)
-{
-	/* Match everything if this is not directed advertising */
-	if (!(adv->le_ext_adv_type & 0x04))
-		return true;
-
-	if (scan->le_scan_own_addr_type != adv->le_adv_direct_addr_type)
-		return false;
-
-	return !memcmp(scan_addr(scan), adv->le_adv_direct_addr, 6);
-}
-
-static bool adv_connectable(struct btdev *btdev)
-{
-	if (!btdev->le_adv_enable)
-		return false;
-
-	return btdev->le_adv_type != 0x03;
-}
-
-static bool ext_adv_connectable(struct btdev *btdev)
+static int cmd_le_create_conn(struct btdev *dev, const void *data, uint8_t len)
 {
-	if (!btdev->le_adv_enable)
-		return false;
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CREATE_CONN);
 
-	return btdev->le_ext_adv_type & 0x01;
+	return 0;
 }
 
-static void le_conn_request(struct btdev *btdev,
-				const struct bt_hci_cmd_le_create_conn *lecc)
+static int cmd_le_create_conn_complete(struct btdev *dev, const void *data,
+					uint8_t len)
 {
-	struct btdev *remote = find_btdev_by_bdaddr_type(lecc->peer_addr,
-							lecc->peer_addr_type);
+	const struct bt_hci_cmd_le_create_conn *cmd = data;
+	struct btdev *remote;
 
-	if (remote && adv_connectable(remote) && adv_match(btdev, remote) &&
-				remote->le_adv_own_addr == lecc->peer_addr_type)
-		le_conn_complete(btdev, lecc, 0);
-	else
-		le_conn_complete(btdev, lecc,
-					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
-}
-
-static void le_ext_conn_request(struct btdev *btdev,
-			const struct bt_hci_cmd_le_ext_create_conn *leecc)
-{
-	struct btdev *remote = find_btdev_by_bdaddr_type(leecc->peer_addr,
-							leecc->peer_addr_type);
+	dev->le_scan_own_addr_type = cmd->own_addr_type;
 
-	if (remote && ext_adv_connectable(remote) &&
-			ext_adv_match(btdev, remote) &&
-			remote->le_adv_own_addr == leecc->peer_addr_type)
-		le_ext_conn_complete(btdev, leecc, 0);
+	remote = find_btdev_by_bdaddr_type(cmd->peer_addr, cmd->peer_addr_type);
+	if (remote && adv_connectable(remote) && adv_match(dev, remote) &&
+				remote->le_adv_own_addr == cmd->peer_addr_type)
+		le_conn_complete(dev, cmd, 0);
 	else
-		le_ext_conn_complete(btdev, leecc,
-					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
-}
-
-static void le_cis_estabilished(struct btdev *dev, uint8_t status)
-{
-	struct bt_hci_evt_le_cis_established evt;
-
-	memset(&evt, 0, sizeof(evt));
-
-	evt.status = status;
+		le_conn_complete(dev, cmd, BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 
-	if (dev->conn)
-		dev = dev->conn;
-
-	if (!evt.status) {
-		evt.conn_handle = cpu_to_le16(ISO_HANDLE);
-		/* TODO: Figure out if these values makes sense */
-		memcpy(evt.cig_sync_delay, dev->le_cig.params.m_interval,
-				sizeof(dev->le_cig.params.m_interval));
-		memcpy(evt.cis_sync_delay, dev->le_cig.params.s_interval,
-				sizeof(dev->le_cig.params.s_interval));
-		memcpy(evt.m_latency, &dev->le_cig.params.m_latency,
-				sizeof(dev->le_cig.params.m_latency));
-		memcpy(evt.s_latency, &dev->le_cig.params.s_latency,
-				sizeof(dev->le_cig.params.s_latency));
-		evt.m_phy = dev->le_cig.cis.m_phy;
-		evt.s_phy = dev->le_cig.cis.s_phy;
-		evt.nse = 0x01;
-		evt.m_bn = 0x01;
-		evt.s_bn = 0x01;
-		evt.m_ft = 0x01;
-		evt.s_ft = 0x01;
-		evt.m_mtu = dev->le_cig.cis.m_sdu;
-		evt.s_mtu = dev->le_cig.cis.s_sdu;
-		evt.interval = dev->le_cig.params.m_latency;
-	}
-
-	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
-
-	if (dev->conn)
-		le_meta_event(dev->conn, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt,
-							sizeof(evt));
+	return 0;
 }
 
-static void le_cis_request(struct btdev *dev,
-				const struct bt_hci_cmd_le_create_cis *leccis)
+static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct btdev *remote = dev->conn;
+	struct bt_hci_rsp_le_read_white_list_size rsp;
 
-	if (remote) {
-		struct bt_hci_evt_le_cis_req evt;
-
-		evt.acl_handle = cpu_to_le16(ACL_HANDLE);
-		evt.cis_handle = cpu_to_le16(ISO_HANDLE);
-		evt.cig_id = 0x00;
-		evt.cis_id = 0x00;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.size = 0;
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
+						sizeof(rsp));
 
-		le_meta_event(remote, BT_HCI_EVT_LE_CIS_REQ, &evt, sizeof(evt));
-	} else {
-		le_cis_estabilished(dev, BT_HCI_ERR_UNKNOWN_CONN_ID);
-	}
+	return 0;
 }
 
-static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
+static int cmd_clear_wl(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
-
-	if (remote && remote->scan_enable & 0x02) {
-		struct bt_hci_evt_conn_request cr;
-
-		memcpy(cr.bdaddr, btdev->bdaddr, 6);
-		memcpy(cr.dev_class, btdev->dev_class, 3);
-		cr.link_type = 0x01;
-
-		send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(cr));
-	} else {
-		conn_complete(btdev, bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
-	}
-}
+	uint8_t status;
 
-static void rej_le_conn_update(struct btdev *btdev, uint16_t handle,
-								uint8_t reason)
-{
-	struct btdev *remote = btdev->conn;
-	struct __packed {
-		uint8_t subevent;
-		struct bt_hci_evt_le_conn_update_complete ev;
-	} ev;
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_WHITE_LIST, &status,
+						sizeof(status));
 
-	if (!remote)
-		return;
+	return 0;
+}
 
-	ev.subevent = BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE;
-	ev.ev.handle = cpu_to_le16(handle);
-	ev.ev.status = cpu_to_le16(reason);
+static int cmd_conn_update(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CONN_UPDATE);
 
-	send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
+	return 0;
 }
 
 static void le_conn_update(struct btdev *btdev, uint16_t handle,
@@ -1545,545 +3128,431 @@ static void le_conn_param_req(struct btdev *btdev, uint16_t handle,
 	send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
 }
 
-static void disconnect_complete(struct btdev *btdev, uint16_t handle,
-							uint8_t reason)
+static int cmd_conn_update_complete(struct btdev *dev, const void *data,
+						uint8_t len)
 {
-	struct bt_hci_evt_disconnect_complete dc;
-	struct btdev *remote = btdev->conn;
+	const struct bt_hci_cmd_le_conn_update *cmd = data;
+
+	if (dev->le_features[0] & 0x02)
+		le_conn_param_req(dev, le16_to_cpu(cmd->handle),
+					le16_to_cpu(cmd->min_interval),
+					le16_to_cpu(cmd->max_interval),
+					le16_to_cpu(cmd->latency),
+					le16_to_cpu(cmd->supv_timeout),
+					le16_to_cpu(cmd->min_length),
+					le16_to_cpu(cmd->max_length));
+	else
+		le_conn_update(dev, le16_to_cpu(cmd->handle),
+					le16_to_cpu(cmd->min_interval),
+					le16_to_cpu(cmd->max_interval),
+					le16_to_cpu(cmd->latency),
+					le16_to_cpu(cmd->supv_timeout),
+					le16_to_cpu(cmd->min_length),
+					le16_to_cpu(cmd->max_length));
+
+	return 0;
+}
 
-	if (!remote) {
-		dc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		dc.handle = cpu_to_le16(handle);
-		dc.reason = 0x00;
+static void le_meta_event(struct btdev *btdev, uint8_t event,
+						void *data, uint8_t len)
+{
+	void *pkt_data;
+
+	util_debug(btdev->debug_callback, btdev->debug_data,
+				"meta event 0x%02x", event);
 
-		send_event(btdev, BT_HCI_EVT_DISCONNECT_COMPLETE,
-							&dc, sizeof(dc));
+	pkt_data = alloca(1 + len);
+	if (!pkt_data)
 		return;
-	}
 
-	dc.status = BT_HCI_ERR_SUCCESS;
-	dc.handle = cpu_to_le16(handle);
-	dc.reason = reason;
+	((uint8_t *) pkt_data)[0] = event;
 
-	if (dc.handle == ACL_HANDLE) {
-		btdev->conn = NULL;
-		remote->conn = NULL;
-	}
+	if (len > 0)
+		memcpy(pkt_data + 1, data, len);
 
-	send_event(btdev, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
-	send_event(remote, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, pkt_data, 1 + len);
 }
 
-static void link_key_req_reply_complete(struct btdev *btdev,
-					const uint8_t *bdaddr,
-					const uint8_t *link_key)
+static int cmd_le_read_remote_features(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct btdev *remote = btdev->conn;
-	struct bt_hci_evt_auth_complete ev;
-
-	memcpy(btdev->link_key, link_key, 16);
+	struct bt_hci_evt_le_remote_features_complete ev;
+	struct btdev *remote = dev->conn;
 
 	if (!remote) {
-		remote = find_btdev_by_bdaddr(bdaddr);
-		if (!remote)
-			return;
+		cmd_status(dev, BT_HCI_ERR_UNKNOWN_CONN_ID,
+					BT_HCI_CMD_LE_READ_REMOTE_FEATURES);
+		return 0;
 	}
 
-	if (!memcmp(remote->link_key, LINK_KEY_NONE, 16)) {
-		send_event(remote, BT_HCI_EVT_LINK_KEY_REQUEST,
-							btdev->bdaddr, 6);
-		return;
-	}
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_READ_REMOTE_FEATURES);
 
+	memset(&ev, 0, sizeof(ev));
+	ev.status = BT_HCI_ERR_SUCCESS;
 	ev.handle = cpu_to_le16(ACL_HANDLE);
+	memcpy(ev.features, remote->le_features, 8);
 
-	if (!memcmp(btdev->link_key, remote->link_key, 16))
-		ev.status = BT_HCI_ERR_SUCCESS;
-	else
-		ev.status = BT_HCI_ERR_AUTH_FAILURE;
+	le_meta_event(dev, BT_HCI_EVT_LE_REMOTE_FEATURES_COMPLETE, &ev,
+						sizeof(ev));
 
-	send_event(btdev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
-	send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+	return 0;
 }
 
-static void link_key_req_neg_reply_complete(struct btdev *btdev,
-							const uint8_t *bdaddr)
+static int cmd_encrypt(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct btdev *remote = btdev->conn;
+	const struct bt_hci_cmd_le_encrypt *cmd = data;
+	struct bt_hci_rsp_le_encrypt rsp;
 
-	if (!remote) {
-		remote = find_btdev_by_bdaddr(bdaddr);
-		if (!remote)
-			return;
+	if (!bt_crypto_e(dev->crypto, cmd->key, cmd->plaintext, rsp.data)) {
+		cmd_status(dev, BT_HCI_ERR_COMMAND_DISALLOWED,
+			   BT_HCI_CMD_LE_ENCRYPT);
+		return 0;
 	}
 
-	if (use_ssp(btdev, remote)) {
-		struct bt_hci_evt_io_capability_request io_req;
-
-		memcpy(io_req.bdaddr, bdaddr, 6);
-		send_event(btdev, BT_HCI_EVT_IO_CAPABILITY_REQUEST, &io_req,
-							sizeof(io_req));
-	} else {
-		struct bt_hci_evt_pin_code_request pin_req;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_ENCRYPT, &rsp, sizeof(rsp));
 
-		memcpy(pin_req.bdaddr, bdaddr, 6);
-		send_event(btdev, BT_HCI_EVT_PIN_CODE_REQUEST, &pin_req,
-							sizeof(pin_req));
-	}
+	return 0;
 }
 
-static uint8_t get_link_key_type(struct btdev *btdev)
+static int cmd_rand(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct btdev *remote = btdev->conn;
-	uint8_t auth, unauth;
-
-	if (!remote)
-		return 0x00;
-
-	if (!btdev->simple_pairing_mode)
-		return 0x00;
-
-	if (btdev->ssp_debug_mode || remote->ssp_debug_mode)
-		return 0x03;
+	struct bt_hci_rsp_le_rand rsp;
 
-	if (btdev->secure_conn_support && remote->secure_conn_support) {
-		unauth = 0x07;
-		auth = 0x08;
-	} else {
-		unauth = 0x04;
-		auth = 0x05;
+	if (!bt_crypto_random_bytes(dev->crypto,
+				    (uint8_t *)&rsp.number, 8)) {
+		cmd_status(dev, BT_HCI_ERR_COMMAND_DISALLOWED,
+			   BT_HCI_CMD_LE_RAND);
+		return 0;
 	}
 
-	if (btdev->io_cap == 0x03 || remote->io_cap == 0x03)
-		return unauth;
-
-	if (!(btdev->auth_req & 0x01) && !(remote->auth_req & 0x01))
-		return unauth;
-
-	/* DisplayOnly only produces authenticated with KeyboardOnly */
-	if (btdev->io_cap == 0x00 && remote->io_cap != 0x02)
-		return unauth;
-
-	/* DisplayOnly only produces authenticated with KeyboardOnly */
-	if (remote->io_cap == 0x00 && btdev->io_cap != 0x02)
-		return unauth;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_RAND, &rsp, sizeof(rsp));
 
-	return auth;
+	return 0;
 }
 
-static void link_key_notify(struct btdev *btdev, const uint8_t *bdaddr,
-							const uint8_t *key)
+static int cmd_start_encrypt(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct bt_hci_evt_link_key_notify ev;
+	const struct bt_hci_cmd_le_start_encrypt *cmd = data;
+	char buf[1 + sizeof(struct bt_hci_evt_le_long_term_key_request)];
+	struct bt_hci_evt_le_long_term_key_request *ev = (void *) &buf[1];
+	struct btdev *remote = dev->conn;
 
-	memcpy(btdev->link_key, key, 16);
+	if (!remote) {
+		cmd_status(dev, BT_HCI_ERR_UNKNOWN_CONN_ID,
+						BT_HCI_CMD_LE_START_ENCRYPT);
+		return 0;
+	}
 
-	memcpy(ev.bdaddr, bdaddr, 6);
-	memcpy(ev.link_key, key, 16);
-	ev.key_type = get_link_key_type(btdev);
+	memcpy(dev->le_ltk, cmd->ltk, 16);
 
-	send_event(btdev, BT_HCI_EVT_LINK_KEY_NOTIFY, &ev, sizeof(ev));
-}
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_START_ENCRYPT);
 
-static void encrypt_change(struct btdev *btdev, uint8_t mode, uint8_t status)
-{
-	struct bt_hci_evt_encrypt_change ev;
+	memset(buf, 0, sizeof(buf));
+	buf[0] = BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST;
+	ev->handle = cpu_to_le16(ACL_HANDLE);
+	ev->ediv = cmd->ediv;
+	ev->rand = cmd->rand;
 
-	ev.status = status;
-	ev.handle = cpu_to_le16(ACL_HANDLE);
-	ev.encr_mode = mode;
+	send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
 
-	send_event(btdev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
+	return 0;
 }
 
-static void pin_code_req_reply_complete(struct btdev *btdev,
-					const uint8_t *bdaddr, uint8_t pin_len,
-					const uint8_t *pin_code)
+static int cmd_ltk_reply(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct bt_hci_evt_auth_complete ev;
-	struct btdev *remote = btdev->conn;
+	const struct bt_hci_cmd_le_ltk_req_reply *cmd = data;
+	struct bt_hci_evt_encrypt_change ev;
+	struct bt_hci_rsp_le_ltk_req_reply rp;
+	struct btdev *remote = dev->conn;
 
 	if (!remote) {
-		remote = find_btdev_by_bdaddr(bdaddr);
-		if (!remote)
-			return;
+		rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_REPLY, &rp, sizeof(rp));
+		return 0;
 	}
 
-	memcpy(btdev->pin, pin_code, pin_len);
-	btdev->pin_len = pin_len;
+	memcpy(dev->le_ltk, cmd->ltk, 16);
 
-	if (!remote->pin_len) {
-		struct bt_hci_evt_pin_code_request pin_req;
+	memset(&rp, 0, sizeof(rp));
+	rp.handle = cpu_to_le16(ACL_HANDLE);
 
-		memcpy(pin_req.bdaddr, btdev->bdaddr, 6);
-		send_event(remote, BT_HCI_EVT_PIN_CODE_REQUEST, &pin_req,
-							sizeof(pin_req));
-		return;
-	}
+	rp.status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_REPLY, &rp, sizeof(rp));
 
-	if (btdev->pin_len == remote->pin_len &&
-			!memcmp(btdev->pin, remote->pin, btdev->pin_len)) {
-		link_key_notify(btdev, remote->bdaddr, LINK_KEY_DUMMY);
-		link_key_notify(remote, btdev->bdaddr, LINK_KEY_DUMMY);
-		ev.status = BT_HCI_ERR_SUCCESS;
-	} else {
-		ev.status = BT_HCI_ERR_AUTH_FAILURE;
-	}
+	memset(&ev, 0, sizeof(ev));
 
-	if (remote->conn) {
-		ev.handle = cpu_to_le16(ACL_HANDLE);
-		send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+	if (memcmp(dev->le_ltk, remote->le_ltk, 16)) {
+		ev.status = BT_HCI_ERR_AUTH_FAILURE;
+		ev.encr_mode = 0x00;
 	} else {
-		conn_complete(remote, btdev->bdaddr, ev.status);
-	}
-
-	btdev->pin_len = 0;
-	remote->pin_len = 0;
-}
-
-static void pin_code_req_neg_reply_complete(struct btdev *btdev,
-							const uint8_t *bdaddr)
-{
-	struct bt_hci_evt_auth_complete ev;
-	struct btdev *remote = btdev->conn;
-
-	if (!remote) {
-		remote = find_btdev_by_bdaddr(bdaddr);
-		if (!remote)
-			return;
+		ev.status = BT_HCI_ERR_SUCCESS;
+		ev.encr_mode = 0x01;
 	}
 
-	ev.status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
 	ev.handle = cpu_to_le16(ACL_HANDLE);
 
-	if (btdev->conn)
-		send_event(btdev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
-	else
-		conn_complete(btdev, bdaddr, BT_HCI_ERR_PIN_OR_KEY_MISSING);
+	send_event(dev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
+	send_event(remote, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
 
-	if (remote->conn) {
-	        if (remote->pin_len)
-			send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev,
-								sizeof(ev));
-	} else {
-		conn_complete(remote, btdev->bdaddr,
-					BT_HCI_ERR_PIN_OR_KEY_MISSING);
-	}
+	return 0;
 }
 
-static void auth_request_complete(struct btdev *btdev, uint16_t handle)
+static int cmd_ltk_neg_reply(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct btdev *remote = btdev->conn;
+	struct bt_hci_rsp_le_ltk_req_neg_reply rp;
+	struct bt_hci_evt_encrypt_change ev;
+	struct btdev *remote = dev->conn;
 
 	if (!remote) {
-		struct bt_hci_evt_auth_complete ev;
-
-		ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		ev.handle = cpu_to_le16(handle);
-
-		send_event(btdev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
-
-		return;
+		rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, &rp,
+							sizeof(rp));
+		return 0;
 	}
 
-	btdev->auth_init = true;
-
-	send_event(btdev, BT_HCI_EVT_LINK_KEY_REQUEST, remote->bdaddr, 6);
-}
-
-static void name_request_complete(struct btdev *btdev,
-					const uint8_t *bdaddr, uint8_t status)
-{
-        struct bt_hci_evt_remote_name_request_complete nc;
-
-	nc.status = status;
-	memcpy(nc.bdaddr, bdaddr, 6);
-	memset(nc.name, 0, 248);
+	memset(&rp, 0, sizeof(rp));
+	rp.handle = cpu_to_le16(ACL_HANDLE);
+	rp.status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, &rp, sizeof(rp));
 
-	if (!status) {
-		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+	memset(&ev, 0, sizeof(ev));
+	ev.status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
+	ev.handle = cpu_to_le16(ACL_HANDLE);
 
-		if (remote)
-			memcpy(nc.name, remote->name, 248);
-		else
-			nc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-	}
+	send_event(remote, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
 
-	send_event(btdev, BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE,
-							&nc, sizeof(nc));
+	return 0;
 }
 
-static void remote_features_complete(struct btdev *btdev, uint16_t handle)
+static int cmd_le_read_supported_states(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct bt_hci_evt_remote_features_complete rfc;
+	struct bt_hci_rsp_le_read_supported_states rsp;
 
-	if (btdev->conn) {
-		rfc.status = BT_HCI_ERR_SUCCESS;
-		rfc.handle = cpu_to_le16(handle);
-		memcpy(rfc.features, btdev->conn->features, 8);
-	} else {
-		rfc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		rfc.handle = cpu_to_le16(handle);
-		memset(rfc.features, 0, 8);
-	}
+	memset(&rsp, 0, sizeof(0));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.states, dev->le_states, 8);
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_SUPPORTED_STATES, &rsp,
+						sizeof(rsp));
 
-	send_event(btdev, BT_HCI_EVT_REMOTE_FEATURES_COMPLETE,
-							&rfc, sizeof(rfc));
+	return 0;
 }
 
-static void btdev_get_host_features(struct btdev *btdev, uint8_t features[8])
+static int cmd_rx_test(struct btdev *dev, const void *data, uint8_t len)
 {
-	memset(features, 0, 8);
-	if (btdev->simple_pairing_mode)
-		features[0] |= 0x01;
-	if (btdev->le_supported)
-		features[0] |= 0x02;
-	if (btdev->le_simultaneous)
-		features[0] |= 0x04;
-	if (btdev->secure_conn_support)
-		features[0] |= 0x08;
+	return -ENOTSUP;
 }
 
-static void remote_ext_features_complete(struct btdev *btdev, uint16_t handle,
-								uint8_t page)
+static int cmd_tx_test(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct bt_hci_evt_remote_ext_features_complete refc;
-
-	if (btdev->conn && page < 0x02) {
-		refc.handle = cpu_to_le16(handle);
-		refc.page = page;
-		refc.max_page = 0x01;
-
-		switch (page) {
-		case 0x00:
-			refc.status = BT_HCI_ERR_SUCCESS;
-			memcpy(refc.features, btdev->conn->features, 8);
-			break;
-		case 0x01:
-			refc.status = BT_HCI_ERR_SUCCESS;
-			btdev_get_host_features(btdev->conn, refc.features);
-			break;
-		default:
-			refc.status = BT_HCI_ERR_INVALID_PARAMETERS;
-			memset(refc.features, 0, 8);
-			break;
-		}
-	} else {
-		refc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		refc.handle = cpu_to_le16(handle);
-		refc.page = page;
-		refc.max_page = 0x01;
-		memset(refc.features, 0, 8);
-	}
-
-	send_event(btdev, BT_HCI_EVT_REMOTE_EXT_FEATURES_COMPLETE,
-							&refc, sizeof(refc));
+	return -ENOTSUP;
 }
 
-static void remote_version_complete(struct btdev *btdev, uint16_t handle)
+static int cmd_test_end(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct bt_hci_evt_remote_version_complete rvc;
-
-	if (btdev->conn) {
-		rvc.status = BT_HCI_ERR_SUCCESS;
-		rvc.handle = cpu_to_le16(handle);
-		rvc.lmp_ver = btdev->conn->version;
-		rvc.manufacturer = cpu_to_le16(btdev->conn->manufacturer);
-		rvc.lmp_subver = cpu_to_le16(btdev->conn->revision);
-	} else {
-		rvc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		rvc.handle = cpu_to_le16(handle);
-		rvc.lmp_ver = 0x00;
-		rvc.manufacturer = cpu_to_le16(0);
-		rvc.lmp_subver = cpu_to_le16(0);
-	}
-
-	send_event(btdev, BT_HCI_EVT_REMOTE_VERSION_COMPLETE,
-							&rvc, sizeof(rvc));
+	return -ENOTSUP;
 }
 
-static void remote_clock_offset_complete(struct btdev *btdev, uint16_t handle)
+static int cmd_conn_param_reply(struct btdev *dev, const void *data,
+						uint8_t len)
 {
-	struct bt_hci_evt_clock_offset_complete coc;
-
-	if (btdev->conn) {
-		coc.status = BT_HCI_ERR_SUCCESS;
-		coc.handle = cpu_to_le16(handle);
-		coc.clock_offset = 0;
-	} else {
-		coc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		coc.handle = cpu_to_le16(handle);
-		coc.clock_offset = 0;
-	}
-
-	send_event(btdev, BT_HCI_EVT_CLOCK_OFFSET_COMPLETE,
-							&coc, sizeof(coc));
+	return -ENOTSUP;
 }
 
-static void read_enc_key_size_complete(struct btdev *btdev, uint16_t handle)
+static int cmd_conn_param_reply_complete(struct btdev *dev, const void *data,
+						uint8_t len)
 {
-	struct bt_hci_rsp_read_encrypt_key_size rsp;
+	const struct bt_hci_cmd_le_conn_param_req_reply *cmd = data;
 
-	rsp.handle = cpu_to_le16(handle);
+	le_conn_update(dev, le16_to_cpu(cmd->handle),
+				le16_to_cpu(cmd->min_interval),
+				le16_to_cpu(cmd->max_interval),
+				le16_to_cpu(cmd->latency),
+				le16_to_cpu(cmd->supv_timeout),
+				le16_to_cpu(cmd->min_length),
+				le16_to_cpu(cmd->max_length));
 
-	if (btdev->conn) {
-		rsp.status = BT_HCI_ERR_SUCCESS;
-		rsp.key_size = 16;
-	} else {
-		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		rsp.key_size = 0;
-	}
-
-	cmd_complete(btdev, BT_HCI_CMD_READ_ENCRYPT_KEY_SIZE,
-							&rsp, sizeof(rsp));
-}
-
-static void io_cap_req_reply_complete(struct btdev *btdev,
-					const uint8_t *bdaddr,
-					uint8_t capability, uint8_t oob_data,
-					uint8_t authentication)
-{
-	struct btdev *remote = btdev->conn;
-	struct bt_hci_evt_io_capability_response ev;
-	struct bt_hci_rsp_io_capability_request_reply rsp;
-	uint8_t status;
+	return 0;
+}
 
-	if (!remote) {
-		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		goto done;
-	}
+static int cmd_conn_param_neg_reply(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_le_conn_param_req_neg_reply *cmd = data;
+	struct bt_hci_rsp_le_conn_param_req_neg_reply rsp;
 
-	status = BT_HCI_ERR_SUCCESS;
+	memset(&rsp, 0, sizeof(rsp));
 
-	btdev->io_cap = capability;
-	btdev->auth_req = authentication;
+	rsp.handle = cmd->handle;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY, &rsp,
+						sizeof(rsp));
 
-	memcpy(ev.bdaddr, btdev->bdaddr, 6);
-	ev.capability = capability;
-	ev.oob_data = oob_data;
-	ev.authentication = authentication;
+	return 0;
+}
 
-	send_event(remote, BT_HCI_EVT_IO_CAPABILITY_RESPONSE, &ev, sizeof(ev));
+static int cmd_conn_param_neg_reply_complete(struct btdev *dev,
+						const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_conn_param_req_neg_reply *cmd = data;
+	struct btdev *remote = dev->conn;
+	struct bt_hci_evt_le_conn_update_complete ev;
 
-	if (remote->io_cap) {
-		struct bt_hci_evt_user_confirm_request cfm;
+	if (!remote)
+		return 0;
 
-		memcpy(cfm.bdaddr, btdev->bdaddr, 6);
-		cfm.passkey = 0;
+	memset(&ev, 0, sizeof(ev));
 
-		send_event(remote, BT_HCI_EVT_USER_CONFIRM_REQUEST,
-							&cfm, sizeof(cfm));
+	ev.handle = cpu_to_le16(cmd->handle);
+	ev.status = cpu_to_le16(cmd->reason);
 
-		memcpy(cfm.bdaddr, bdaddr, 6);
-		send_event(btdev, BT_HCI_EVT_USER_CONFIRM_REQUEST,
-							&cfm, sizeof(cfm));
-	} else {
-		send_event(remote, BT_HCI_EVT_IO_CAPABILITY_REQUEST,
-							btdev->bdaddr, 6);
-	}
+	le_meta_event(remote, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &ev,
+						sizeof(ev));
 
-done:
-	rsp.status = status;
-	memcpy(rsp.bdaddr, bdaddr, 6);
-	cmd_complete(btdev, BT_HCI_CMD_IO_CAPABILITY_REQUEST_REPLY,
-							&rsp, sizeof(rsp));
+	return 0;
 }
 
-static void io_cap_req_neg_reply_complete(struct btdev *btdev,
-							const uint8_t *bdaddr)
+static int cmd_read_local_pk256(struct btdev *dev, const void *data,
+						uint8_t len)
 {
-	struct bt_hci_rsp_io_capability_request_neg_reply rsp;
+	return -ENOTSUP;
+}
 
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	memcpy(rsp.bdaddr, bdaddr, 6);
-	cmd_complete(btdev, BT_HCI_CMD_IO_CAPABILITY_REQUEST_NEG_REPLY,
-							&rsp, sizeof(rsp));
+static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
+{
+	return -ENOTSUP;
 }
 
-static void ssp_complete(struct btdev *btdev, const uint8_t *bdaddr,
-						uint8_t status, bool wait)
+#define CMD_LE \
+	CMD(BT_HCI_CMD_READ_LE_HOST_SUPPORTED, cmd_read_le_host_supported, \
+					NULL), \
+	CMD(BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED, cmd_write_le_host_supported, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_SET_EVENT_MASK, cmd_le_set_event_mask, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_BUFFER_SIZE, cmd_le_read_buffer_size, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_LOCAL_FEATURES, cmd_le_read_local_features, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_SET_RANDOM_ADDRESS, cmd_set_random_address, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_ADV_PARAMETERS, cmd_set_adv_params, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_ADV_TX_POWER, cmd_read_adv_tx_power, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_ADV_DATA, cmd_set_adv_data, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_SCAN_RSP_DATA, cmd_set_scan_rsp_data, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_ADV_ENABLE, cmd_set_adv_enable, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_SCAN_PARAMETERS, cmd_set_scan_params, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_SCAN_ENABLE, cmd_set_scan_enable, \
+					cmd_set_scan_enable_complete), \
+	CMD(BT_HCI_CMD_LE_CREATE_CONN, cmd_le_create_conn, \
+					cmd_le_create_conn_complete), \
+	CMD(BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, cmd_read_wl_size, NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_WHITE_LIST, cmd_clear_wl, NULL), \
+	CMD(BT_HCI_CMD_LE_CONN_UPDATE, cmd_conn_update, \
+					cmd_conn_update_complete), \
+	CMD(BT_HCI_CMD_LE_READ_REMOTE_FEATURES, cmd_le_read_remote_features, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_ENCRYPT, cmd_encrypt, NULL), \
+	CMD(BT_HCI_CMD_LE_RAND, cmd_rand, NULL), \
+	CMD(BT_HCI_CMD_LE_START_ENCRYPT, cmd_start_encrypt, NULL), \
+	CMD(BT_HCI_CMD_LE_LTK_REQ_REPLY, cmd_ltk_reply, NULL), \
+	CMD(BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, cmd_ltk_neg_reply, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_SUPPORTED_STATES, cmd_le_read_supported_states, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_RECEIVER_TEST, cmd_rx_test, NULL), \
+	CMD(BT_HCI_CMD_LE_TRANSMITTER_TEST, cmd_tx_test, NULL), \
+	CMD(BT_HCI_CMD_LE_ISO_TEST_END, cmd_test_end, NULL), \
+	CMD(BT_HCI_CMD_LE_CONN_PARAM_REQ_REPLY, cmd_conn_param_reply, \
+					cmd_conn_param_reply_complete), \
+	CMD(BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY, cmd_conn_param_neg_reply, \
+					cmd_conn_param_neg_reply_complete), \
+	CMD(BT_HCI_CMD_LE_READ_LOCAL_PK256, cmd_read_local_pk256, NULL), \
+	CMD(BT_HCI_CMD_LE_GENERATE_DHKEY, cmd_gen_dhkey, NULL)
+
+static int cmd_set_default_phy(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct bt_hci_evt_simple_pairing_complete iev, aev;
-	struct bt_hci_evt_auth_complete auth;
-	struct btdev *remote = btdev->conn;
-	struct btdev *init, *accp;
+	const struct bt_hci_cmd_le_set_default_phy *cmd = data;
+	uint8_t status;
 
-	if (!remote)
-		return;
+	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
+			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!(cmd->all_phys & 0x02) &&
+			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+	else
+		status = BT_HCI_ERR_SUCCESS;
 
-	btdev->ssp_status = status;
-	btdev->ssp_auth_complete = true;
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_DEFAULT_PHY, &status,
+					sizeof(status));
 
-	if (!remote->ssp_auth_complete && wait)
-		return;
+	return 0;
+}
 
-	if (status == BT_HCI_ERR_SUCCESS &&
-				remote->ssp_status != BT_HCI_ERR_SUCCESS)
-		status = remote->ssp_status;
+static int cmd_set_adv_rand_addr(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_adv_set_rand_addr *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	iev.status = status;
-	aev.status = status;
+	memcpy(dev->random_addr, cmd->bdaddr, 6);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR, &status,
+						sizeof(status));
 
-	if (btdev->auth_init) {
-		init = btdev;
-		accp = remote;
-		memcpy(iev.bdaddr, bdaddr, 6);
-		memcpy(aev.bdaddr, btdev->bdaddr, 6);
-	} else {
-		init = remote;
-		accp = btdev;
-		memcpy(iev.bdaddr, btdev->bdaddr, 6);
-		memcpy(aev.bdaddr, bdaddr, 6);
-	}
+	return 0;
+}
 
-	send_event(init, BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE, &iev,
-								sizeof(iev));
-	send_event(accp, BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE, &aev,
-								sizeof(aev));
+static int cmd_set_ext_adv_params(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_ext_adv_params *cmd = data;
+	struct bt_hci_rsp_le_set_ext_adv_params rsp;
+	uint8_t status;
 
-	if (status == BT_HCI_ERR_SUCCESS) {
-		link_key_notify(init, iev.bdaddr, LINK_KEY_DUMMY);
-		link_key_notify(accp, aev.bdaddr, LINK_KEY_DUMMY);
+	if (dev->le_adv_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS, &status,
+							sizeof(status));
+		return 0;
 	}
 
-	auth.status = status;
-	auth.handle = cpu_to_le16(ACL_HANDLE);
-	send_event(init, BT_HCI_EVT_AUTH_COMPLETE, &auth, sizeof(auth));
+	dev->le_ext_adv_type = le16_to_cpu(cmd->evt_properties);
+	dev->le_adv_own_addr = cmd->own_addr_type;
+	dev->le_adv_direct_addr_type = cmd->peer_addr_type;
+	memcpy(dev->le_adv_direct_addr, cmd->peer_addr, 6);
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.tx_power = 0;
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
-static void le_send_adv_report(struct btdev *btdev, const struct btdev *remote,
-								uint8_t type)
+static int cmd_set_ext_adv_data(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct __packed {
-		uint8_t subevent;
-		union {
-			struct bt_hci_evt_le_adv_report lar;
-			uint8_t raw[10 + 31 + 1];
-		};
-	} meta_event;
+	const struct bt_hci_cmd_le_set_ext_adv_data *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	meta_event.subevent = BT_HCI_EVT_LE_ADV_REPORT;
+	dev->le_adv_data_len = cmd->data_len;
+	memcpy(dev->le_adv_data, cmd->data, 31);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_DATA, &status,
+						sizeof(status));
 
-	memset(&meta_event.lar, 0, sizeof(meta_event.lar));
-	meta_event.lar.num_reports = 1;
-	meta_event.lar.event_type = type;
-	meta_event.lar.addr_type = remote->le_adv_own_addr;
-	memcpy(meta_event.lar.addr, adv_addr(remote), 6);
+	return 0;
+}
 
-	/* Scan or advertising response */
-	if (type == 0x04) {
-		meta_event.lar.data_len = remote->le_scan_data_len;
-		memcpy(meta_event.lar.data, remote->le_scan_data,
-						meta_event.lar.data_len);
-	} else {
-		meta_event.lar.data_len = remote->le_adv_data_len;
-		memcpy(meta_event.lar.data, remote->le_adv_data,
-						meta_event.lar.data_len);
-	}
-	/* Not available */
-	meta_event.raw[10 + meta_event.lar.data_len] = 127;
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &meta_event,
-					1 + 10 + meta_event.lar.data_len + 1);
+static int cmd_set_ext_scan_rsp_data(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_ext_scan_rsp_data *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->le_scan_data_len = cmd->data_len;
+	memcpy(dev->le_scan_data, cmd->data, 31);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA, &status,
+						sizeof(status));
+
+	return 0;
 }
 
 static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
@@ -2123,2121 +3592,1298 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 					1 + 24 + meta_event.lear.data_len);
 }
 
-static uint8_t get_adv_report_type(uint8_t adv_type)
-{
-	/*
-	 * Connectable low duty cycle directed advertising creates a
-	 * connectable directed advertising report type.
-	 */
-	if (adv_type == 0x04)
-		return 0x01;
-
-	return adv_type;
-}
-
-static uint8_t get_ext_adv_type(uint8_t ext_adv_type)
-{
-	/*
-	 * If legacy bit is not set then just reset high duty cycle directed
-	 * bit.
-	 */
-	if (!(ext_adv_type & 0x10))
-		return (ext_adv_type & 0xf7);
-
-	/*
-	 * Connectable low duty cycle directed advertising creates a
-	 * connectable directed advertising report type.
-	 */
-	if (ext_adv_type == 0x001d)
-		return 0x0015;
-
-	return ext_adv_type;
-}
-
-static uint16_t ext_legacy_adv_type(uint8_t type)
-{
-	switch (type) {
-	case 0x00:
-		/* Connectable undirected - ADV_IND" */
-		return 0x0013;
-	case 0x01:
-		/* Connectable directed - ADV_DIRECT_IND */
-		return 0x0015;
-	case 0x02:
-		/* Scannable undirected - ADV_SCAN_IND */
-		return 0x0012;
-	case 0x03:
-		/* Non connectable undirected - ADV_NONCONN_IND */
-		return 0x0010;
-	case 0x04:
-		/* Scan response - SCAN_RSP */
-		return 0x0012;
-	}
-
-	return 0x0000;
-}
-
-static void le_set_adv_enable_complete(struct btdev *btdev)
-{
-	uint8_t report_type;
-	int i;
-
-	report_type = get_adv_report_type(btdev->le_adv_type);
-
-	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
-		if (!btdev_list[i] || btdev_list[i] == btdev)
-			continue;
-
-		if (!btdev_list[i]->le_scan_enable)
-			continue;
-
-		if (!adv_match(btdev_list[i], btdev))
-			continue;
-
-		le_send_adv_report(btdev_list[i], btdev, report_type);
-
-		if (btdev_list[i]->le_scan_type != 0x01)
-			continue;
-
-		/* ADV_IND & ADV_SCAN_IND generate a scan response */
-		if (btdev->le_adv_type == 0x00 || btdev->le_adv_type == 0x02)
-			le_send_adv_report(btdev_list[i], btdev, 0x04);
-	}
-}
-
 static void le_set_ext_adv_enable_complete(struct btdev *btdev)
 {
 	uint16_t report_type;
 	int i;
 
-	report_type = get_ext_adv_type(btdev->le_ext_adv_type);
-
-	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
-		if (!btdev_list[i] || btdev_list[i] == btdev)
-			continue;
-
-		if (!btdev_list[i]->le_scan_enable)
-			continue;
-
-		if (!ext_adv_match(btdev_list[i], btdev))
-			continue;
-
-		send_ext_adv(btdev_list[i], btdev, report_type,
-								false);
-
-		if (btdev_list[i]->le_scan_type != 0x01)
-			continue;
-
-		/* if scannable bit is set the send scan response */
-		if (btdev->le_ext_adv_type & 0x02) {
-			if (btdev->le_ext_adv_type == 0x13)
-				report_type = 0x1b;
-			else if (btdev->le_ext_adv_type == 0x12)
-				report_type = 0x1a;
-			else if (!(btdev->le_ext_adv_type & 0x10))
-				report_type &= 0x08;
-			else
-				continue;
-
-			send_ext_adv(btdev_list[i], btdev,
-							report_type, true);
-		}
-	}
-}
-
-static void le_set_scan_enable_complete(struct btdev *btdev)
-{
-	int i;
-
-	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
-		uint8_t report_type;
-
-		if (!btdev_list[i] || btdev_list[i] == btdev)
-			continue;
-
-		if (!btdev_list[i]->le_adv_enable)
-			continue;
-
-		if (!adv_match(btdev, btdev_list[i]))
-			continue;
-
-		report_type = get_adv_report_type(btdev_list[i]->le_adv_type);
-		le_send_adv_report(btdev, btdev_list[i], report_type);
-
-		if (btdev->le_scan_type != 0x01)
-			continue;
-
-		/* ADV_IND & ADV_SCAN_IND generate a scan response */
-		if (btdev_list[i]->le_adv_type == 0x00 ||
-					btdev_list[i]->le_adv_type == 0x02)
-			le_send_adv_report(btdev, btdev_list[i], 0x04);
-	}
-}
-
-static void le_set_ext_scan_enable_complete(struct btdev *btdev)
-{
-	int i;
+	report_type = get_ext_adv_type(btdev->le_ext_adv_type);
 
 	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
-		uint16_t report_type;
-
 		if (!btdev_list[i] || btdev_list[i] == btdev)
 			continue;
 
-		if (!btdev_list[i]->le_adv_enable)
+		if (!btdev_list[i]->le_scan_enable)
 			continue;
 
-		if (!ext_adv_match(btdev, btdev_list[i]))
+		if (!ext_adv_match(btdev_list[i], btdev))
 			continue;
 
-		report_type = get_ext_adv_type(btdev_list[i]->le_ext_adv_type);
-		send_ext_adv(btdev, btdev_list[i], report_type, false);
+		send_ext_adv(btdev_list[i], btdev, report_type, false);
 
-		if (btdev->le_scan_type != 0x01)
+		if (btdev_list[i]->le_scan_type != 0x01)
 			continue;
 
 		/* if scannable bit is set the send scan response */
-		if (btdev_list[i]->le_ext_adv_type & 0x02) {
-			if (btdev_list[i]->le_ext_adv_type == 0x13)
+		if (btdev->le_ext_adv_type & 0x02) {
+			if (btdev->le_ext_adv_type == 0x13)
 				report_type = 0x1b;
-			else if (btdev_list[i]->le_ext_adv_type == 0x12)
+			else if (btdev->le_ext_adv_type == 0x12)
 				report_type = 0x1a;
-			else if (!(btdev_list[i]->le_ext_adv_type & 0x10))
+			else if (!(btdev->le_ext_adv_type & 0x10))
 				report_type &= 0x08;
 			else
 				continue;
 
-			send_ext_adv(btdev, btdev_list[i], report_type, true);
+			send_ext_adv(btdev_list[i], btdev, report_type, true);
 		}
 	}
 }
 
-static void le_read_remote_features_complete(struct btdev *btdev)
+static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	char buf[1 + sizeof(struct bt_hci_evt_le_remote_features_complete)];
-	struct bt_hci_evt_le_remote_features_complete *ev = (void *) &buf[1];
-	struct btdev *remote = btdev->conn;
+	const struct bt_hci_cmd_le_set_ext_adv_enable *cmd = data;
+	uint8_t status;
 
-	if (!remote) {
-		cmd_status(btdev, BT_HCI_ERR_UNKNOWN_CONN_ID,
-					BT_HCI_CMD_LE_READ_REMOTE_FEATURES);
-		return;
+	if (dev->le_adv_enable == cmd->enable)
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	else {
+		dev->le_adv_enable = cmd->enable;
+		status = BT_HCI_ERR_SUCCESS;
 	}
 
-	cmd_status(btdev, BT_HCI_ERR_SUCCESS,
-				BT_HCI_CMD_LE_READ_REMOTE_FEATURES);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, &status,
+							sizeof(status));
 
-	memset(buf, 0, sizeof(buf));
-	buf[0] = BT_HCI_EVT_LE_REMOTE_FEATURES_COMPLETE;
-	ev->status = BT_HCI_ERR_SUCCESS;
-	ev->handle = cpu_to_le16(ACL_HANDLE);
-	memcpy(ev->features, remote->le_features, 8);
+	if (status == BT_HCI_ERR_SUCCESS && dev->le_adv_enable)
+		le_set_ext_adv_enable_complete(dev);
 
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	return 0;
 }
 
-static void le_start_encrypt_complete(struct btdev *btdev, uint16_t ediv,
-								uint64_t rand)
+static int cmd_read_max_adv_data_len(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	char buf[1 + sizeof(struct bt_hci_evt_le_long_term_key_request)];
-	struct bt_hci_evt_le_long_term_key_request *ev = (void *) &buf[1];
-	struct btdev *remote = btdev->conn;
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	if (!remote) {
-		cmd_status(btdev, BT_HCI_ERR_UNKNOWN_CONN_ID,
-						BT_HCI_CMD_LE_START_ENCRYPT);
-		return;
-	}
+static int cmd_read_num_adv_sets(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_le_read_num_supported_adv_sets rsp;
 
-	cmd_status(btdev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_START_ENCRYPT);
+	memset(&rsp, 0, sizeof(rsp));
 
-	memset(buf, 0, sizeof(buf));
-	buf[0] = BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST;
-	ev->handle = cpu_to_le16(ACL_HANDLE);
-	ev->ediv = ediv;
-	ev->rand = rand;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	/* Support one set as of now */
+	rsp.num_of_sets = 1;
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS, &rsp,
+							sizeof(rsp));
 
-	send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	return 0;
 }
 
-static void le_encrypt_complete(struct btdev *btdev)
+static int cmd_remove_adv_set(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct bt_hci_evt_encrypt_change ev;
-	struct bt_hci_rsp_le_ltk_req_reply rp;
-	struct btdev *remote = btdev->conn;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	memset(&rp, 0, sizeof(rp));
-	rp.handle = cpu_to_le16(ACL_HANDLE);
+	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ADV_SET, &status,
+							sizeof(status));
 
-	if (!remote) {
-		rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		cmd_complete(btdev, BT_HCI_CMD_LE_LTK_REQ_REPLY, &rp,
-							sizeof(rp));
-		return;
-	}
+	return 0;
+}
 
-	rp.status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(btdev, BT_HCI_CMD_LE_LTK_REQ_REPLY, &rp, sizeof(rp));
+static int cmd_clear_adv_sets(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	memset(&ev, 0, sizeof(ev));
+	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_ADV_SETS, &status,
+							sizeof(status));
 
-	if (memcmp(btdev->le_ltk, remote->le_ltk, 16)) {
-		ev.status = BT_HCI_ERR_AUTH_FAILURE;
-		ev.encr_mode = 0x00;
-	} else {
-		ev.status = BT_HCI_ERR_SUCCESS;
-		ev.encr_mode = 0x01;
-	}
+	return 0;
+}
 
-	ev.handle = cpu_to_le16(ACL_HANDLE);
+static int cmd_set_per_adv_params(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	send_event(btdev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
-	send_event(remote, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
+static int cmd_set_per_adv_data(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
 }
 
-static void ltk_neg_reply_complete(struct btdev *btdev)
+static int cmd_set_per_adv_enable(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct bt_hci_rsp_le_ltk_req_neg_reply rp;
-	struct bt_hci_evt_encrypt_change ev;
-	struct btdev *remote = btdev->conn;
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	memset(&rp, 0, sizeof(rp));
-	rp.handle = cpu_to_le16(ACL_HANDLE);
+static int cmd_set_ext_scan_params(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_ext_scan_params *cmd = data;
+	const struct bt_hci_le_scan_phy *scan = (void *)cmd->data;
+	uint8_t status;
 
-	if (!remote) {
-		rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		cmd_complete(btdev, BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, &rp,
-							sizeof(rp));
-		return;
+	if (dev->le_scan_enable)
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	else if (cmd->num_phys == 0)
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+	else {
+		status = BT_HCI_ERR_SUCCESS;
+		/* Currently we dont support multiple types in single
+		 * command So just take the first one will do.
+		 */
+		dev->le_scan_type = scan->type;
+		dev->le_scan_own_addr_type = cmd->own_addr_type;
 	}
 
-	rp.status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(btdev, BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, &rp, sizeof(rp));
-
-	memset(&ev, 0, sizeof(ev));
-	ev.status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
-	ev.handle = cpu_to_le16(ACL_HANDLE);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS, &status,
+							sizeof(status));
 
-	send_event(remote, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
+	return 0;
 }
 
-static void btdev_reset(struct btdev *btdev)
+static int cmd_set_ext_scan_enable(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	/* FIXME: include here clearing of all states that should be
-	 * cleared upon HCI_Reset
-	 */
+	const struct bt_hci_cmd_le_set_ext_scan_enable *cmd = data;
+	uint8_t status;
 
-	btdev->le_scan_enable		= 0x00;
-	btdev->le_adv_enable		= 0x00;
+	if (dev->le_scan_enable == cmd->enable)
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	else {
+		dev->le_scan_enable = cmd->enable;
+		dev->le_filter_dup = cmd->filter_dup;
+		status = BT_HCI_ERR_SUCCESS;
+	}
+
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE, &status,
+							sizeof(status));
+
+	return 0;
 }
 
-static void le_setup_iso_path(struct btdev *dev, uint16_t handle,
-					uint8_t dir, uint8_t path)
+static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
+							uint8_t len)
 {
-	struct bt_hci_rsp_le_setup_iso_path rsp;
+	const struct bt_hci_cmd_le_set_ext_scan_enable *cmd = data;
+	int i;
 
-	memset(&rsp, 0, sizeof(rsp));
+	if (!dev->le_scan_enable || !cmd->enable)
+		return 0;
 
-	if (handle != ISO_HANDLE) {
-		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		goto done;
-	}
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		uint16_t report_type;
 
-	/* Only support HCI or disabled paths */
-	if (path && path != 0xff) {
-		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
-		goto done;
-	}
+		if (!btdev_list[i] || btdev_list[i] == dev)
+			continue;
 
-	switch (dir) {
-	case 0x00:
-		dev->le_iso_path[0] = path;
-		rsp.handle = cpu_to_le16(ISO_HANDLE);
-		break;
-	case 0x01:
-		dev->le_iso_path[1] = path;
-		rsp.handle = cpu_to_le16(ISO_HANDLE);
-		break;
-	default:
-		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		if (!btdev_list[i]->le_adv_enable)
+			continue;
+
+		if (!ext_adv_match(dev, btdev_list[i]))
+			continue;
+
+		report_type = get_ext_adv_type(btdev_list[i]->le_ext_adv_type);
+		send_ext_adv(dev, btdev_list[i], report_type, false);
+
+		if (dev->le_scan_type != 0x01)
+			continue;
+
+		/* if scannable bit is set the send scan response */
+		if (btdev_list[i]->le_ext_adv_type & 0x02) {
+			if (btdev_list[i]->le_ext_adv_type == 0x13)
+				report_type = 0x1b;
+			else if (btdev_list[i]->le_ext_adv_type == 0x12)
+				report_type = 0x1a;
+			else if (!(btdev_list[i]->le_ext_adv_type & 0x10))
+				report_type &= 0x08;
+			else
+				continue;
+
+			send_ext_adv(dev, btdev_list[i], report_type, true);
+		}
 	}
 
-done:
-	cmd_complete(dev, BT_HCI_CMD_LE_SETUP_ISO_PATH, &rsp, sizeof(rsp));
+	return 0;
 }
 
-static void default_cmd(struct btdev *btdev, uint16_t opcode,
-						const void *data, uint8_t len)
+static int cmd_ext_create_conn(struct btdev *dev, const void *data, uint8_t len)
 {
-	const struct bt_hci_cmd_remote_name_request_cancel *rnrc;
-	const struct bt_hci_cmd_write_default_link_policy *wdlp;
-	const struct bt_hci_cmd_set_event_mask *sem;
-	const struct bt_hci_cmd_set_event_filter *sef;
-	const struct bt_hci_cmd_write_local_name *wln;
-	const struct bt_hci_cmd_write_conn_accept_timeout *wcat;
-	const struct bt_hci_cmd_write_page_timeout *wpt;
-	const struct bt_hci_cmd_write_scan_enable *wse;
-	const struct bt_hci_cmd_write_page_scan_activity *wpsa;
-	const struct bt_hci_cmd_write_inquiry_scan_activity *wisa;
-	const struct bt_hci_cmd_write_page_scan_type *wpst;
-	const struct bt_hci_cmd_write_auth_enable *wae;
-	const struct bt_hci_cmd_write_class_of_dev *wcod;
-	const struct bt_hci_cmd_write_voice_setting *wvs;
-	const struct bt_hci_cmd_set_host_flow_control *shfc;
-	const struct bt_hci_cmd_write_inquiry_mode *wim;
-	const struct bt_hci_cmd_write_afh_assessment_mode *waam;
-	const struct bt_hci_cmd_write_ext_inquiry_response *weir;
-	const struct bt_hci_cmd_write_simple_pairing_mode *wspm;
-	const struct bt_hci_cmd_io_capability_request_reply *icrr;
-	const struct bt_hci_cmd_io_capability_request_reply *icrnr;
-	const struct bt_hci_cmd_read_encrypt_key_size *reks;
-	const struct bt_hci_cmd_write_le_host_supported *wlhs;
-	const struct bt_hci_cmd_write_secure_conn_support *wscs;
-	const struct bt_hci_cmd_set_event_mask_page2 *semp2;
-	const struct bt_hci_cmd_le_set_event_mask *lsem;
-	const struct bt_hci_cmd_le_set_random_address *lsra;
-	const struct bt_hci_cmd_le_set_adv_parameters *lsap;
-	const struct bt_hci_cmd_le_set_adv_data *lsad;
-	const struct bt_hci_cmd_le_set_scan_rsp_data *lssrd;
-	const struct bt_hci_cmd_setup_sync_conn *ssc;
-	const struct bt_hci_cmd_write_ssp_debug_mode *wsdm;
-	const struct bt_hci_cmd_le_set_adv_enable *lsae;
-	const struct bt_hci_cmd_le_set_scan_parameters *lssp;
-	const struct bt_hci_cmd_le_set_scan_enable *lsse;
-	const struct bt_hci_cmd_le_start_encrypt *lse;
-	const struct bt_hci_cmd_le_ltk_req_reply *llrr;
-	const struct bt_hci_cmd_le_encrypt *lenc_cmd;
-	const struct bt_hci_cmd_le_generate_dhkey *dh;
-	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr_cmd;
-	const struct bt_hci_cmd_le_conn_param_req_neg_reply *lcprnr_cmd;
-	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
-	const struct bt_hci_cmd_read_rssi *rrssi;
-	const struct bt_hci_cmd_read_tx_power *rtxp;
-	const struct bt_hci_cmd_le_set_adv_set_rand_addr *lsasra;
-	const struct bt_hci_cmd_le_set_ext_adv_params *lseap;
-	const struct bt_hci_cmd_le_set_ext_adv_enable *lseae;
-	const struct bt_hci_cmd_le_set_ext_adv_data *lsead;
-	const struct bt_hci_cmd_le_set_ext_scan_rsp_data *lsesrd;
-	const struct bt_hci_cmd_le_set_default_phy *phys;
-	const struct bt_hci_cmd_le_set_ext_scan_params *lsesp;
-	const struct bt_hci_le_scan_phy *lsp;
-	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
-	const struct bt_hci_cmd_le_reject_cis *lrcis;
-	const struct bt_hci_cmd_le_remove_iso_path *lerip;
-	struct bt_hci_rsp_read_default_link_policy rdlp;
-	struct bt_hci_rsp_read_stored_link_key rslk;
-	struct bt_hci_rsp_write_stored_link_key wslk;
-	struct bt_hci_rsp_delete_stored_link_key dslk;
-	struct bt_hci_rsp_read_local_name rln;
-	struct bt_hci_rsp_read_conn_accept_timeout rcat;
-	struct bt_hci_rsp_read_page_timeout rpt;
-	struct bt_hci_rsp_read_scan_enable rse;
-	struct bt_hci_rsp_read_page_scan_activity rpsa;
-	struct bt_hci_rsp_read_inquiry_scan_activity risa;
-	struct bt_hci_rsp_read_page_scan_type rpst;
-	struct bt_hci_rsp_read_auth_enable rae;
-	struct bt_hci_rsp_read_class_of_dev rcod;
-	struct bt_hci_rsp_read_voice_setting rvs;
-	struct bt_hci_rsp_read_num_supported_iac rnsi;
-	struct bt_hci_rsp_read_current_iac_lap *rcil;
-	struct bt_hci_rsp_read_inquiry_mode rim;
-	struct bt_hci_rsp_read_afh_assessment_mode raam;
-	struct bt_hci_rsp_read_ext_inquiry_response reir;
-	struct bt_hci_rsp_read_simple_pairing_mode rspm;
-	struct bt_hci_rsp_read_local_oob_data rlod;
-	struct bt_hci_rsp_read_inquiry_resp_tx_power rirtp;
-	struct bt_hci_rsp_read_le_host_supported rlhs;
-	struct bt_hci_rsp_read_secure_conn_support rscs;
-	struct bt_hci_rsp_read_local_oob_ext_data rloed;
-	struct bt_hci_rsp_read_sync_train_params rstp;
-	struct bt_hci_rsp_read_local_version rlv;
-	struct bt_hci_rsp_read_local_commands rlc;
-	struct bt_hci_rsp_read_local_features rlf;
-	struct bt_hci_rsp_read_local_ext_features rlef;
-	struct bt_hci_rsp_read_buffer_size rbs;
-	struct bt_hci_rsp_read_country_code rcc;
-	struct bt_hci_rsp_read_bd_addr rba;
-	struct bt_hci_rsp_read_data_block_size rdbs;
-	struct bt_hci_rsp_read_local_codecs *rlsc;
-	struct bt_hci_rsp_read_local_amp_info rlai;
-	struct bt_hci_rsp_read_local_amp_assoc rlaa_rsp;
-	struct bt_hci_rsp_get_mws_transport_config *gmtc;
-	struct bt_hci_rsp_le_conn_param_req_reply lcprr_rsp;
-	struct bt_hci_rsp_le_conn_param_req_neg_reply lcprnr_rsp;
-	struct bt_hci_rsp_le_read_buffer_size lrbs;
-	struct bt_hci_rsp_le_read_local_features lrlf;
-	struct bt_hci_rsp_le_read_adv_tx_power lratp;
-	struct bt_hci_rsp_le_read_supported_states lrss;
-	struct bt_hci_rsp_le_read_white_list_size lrwls;
-	struct bt_hci_rsp_le_encrypt lenc;
-	struct bt_hci_rsp_le_rand lr;
-	struct bt_hci_rsp_le_test_end lte;
-	struct bt_hci_rsp_remote_name_request_cancel rnrc_rsp;
-	struct bt_hci_rsp_link_key_request_reply lkrr_rsp;
-	struct bt_hci_rsp_link_key_request_neg_reply lkrnr_rsp;
-	struct bt_hci_rsp_pin_code_request_neg_reply pcrr_rsp;
-	struct bt_hci_rsp_pin_code_request_neg_reply pcrnr_rsp;
-	struct bt_hci_rsp_user_confirm_request_reply ucrr_rsp;
-	struct bt_hci_rsp_user_confirm_request_neg_reply ucrnr_rsp;
-	struct bt_hci_rsp_read_rssi rrssi_rsp;
-	struct bt_hci_rsp_read_tx_power rtxp_rsp;
-	struct bt_hci_evt_le_read_local_pk256_complete pk_evt;
-	struct bt_hci_evt_le_generate_dhkey_complete dh_evt;
-	struct bt_hci_rsp_le_read_num_supported_adv_sets rlrnsas;
-	struct bt_hci_rsp_le_set_ext_adv_params rlseap;
-	struct bt_hci_rsp_le_read_buffer_size_v2 lrbsv2;
-	struct lescp {
-		struct bt_hci_rsp_le_set_cig_params params;
-		uint16_t handle;
-	} __attribute__ ((packed)) lscp;
-	struct bt_hci_rsp_le_remove_cig lrc;
-	struct bt_hci_cmd_le_setup_iso_path *lesip;
-	uint8_t status, page;
-
-	switch (opcode) {
-	case BT_HCI_CMD_INQUIRY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_EXT_CREATE_CONN);
 
-	case BT_HCI_CMD_INQUIRY_CANCEL:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		inquiry_cancel(btdev);
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_CREATE_CONN:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+static bool ext_adv_connectable(struct btdev *btdev)
+{
+	if (!btdev->le_adv_enable)
+		return false;
 
-	case BT_HCI_CMD_DISCONNECT:
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	return btdev->le_ext_adv_type & 0x01;
+}
 
-	case BT_HCI_CMD_CREATE_CONN_CANCEL:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+static void le_ext_conn_complete(struct btdev *btdev,
+			const struct bt_hci_cmd_le_ext_create_conn *cmd,
+			uint8_t status)
+{
+	struct bt_hci_evt_le_enhanced_conn_complete ev;
+	struct bt_hci_le_ext_create_conn *lecc = (void *)cmd->data;
 
-	case BT_HCI_CMD_ACCEPT_CONN_REQUEST:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	memset(&ev, 0, sizeof(ev));
 
-	case BT_HCI_CMD_REJECT_CONN_REQUEST:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	if (!status) {
+		struct btdev *remote;
 
-	case BT_HCI_CMD_LINK_KEY_REQUEST_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		lkrr_rsp.status = BT_HCI_ERR_SUCCESS;
-		memcpy(lkrr_rsp.bdaddr, data, 6);
-		cmd_complete(btdev, opcode, &lkrr_rsp, sizeof(lkrr_rsp));
-		break;
+		remote = find_btdev_by_bdaddr_type(cmd->peer_addr,
+							cmd->peer_addr_type);
 
-	case BT_HCI_CMD_LINK_KEY_REQUEST_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		lkrnr_rsp.status = BT_HCI_ERR_SUCCESS;
-		memcpy(lkrnr_rsp.bdaddr, data, 6);
-		cmd_complete(btdev, opcode, &lkrnr_rsp, sizeof(lkrnr_rsp));
-		break;
+		btdev->conn = remote;
+		btdev->le_adv_enable = 0;
+		remote->conn = btdev;
+		remote->le_adv_enable = 0;
 
-	case BT_HCI_CMD_PIN_CODE_REQUEST_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		pcrr_rsp.status = BT_HCI_ERR_SUCCESS;
-		memcpy(pcrr_rsp.bdaddr, data, 6);
-		cmd_complete(btdev, opcode, &pcrr_rsp, sizeof(pcrr_rsp));
-		break;
+		ev.status = status;
+		ev.peer_addr_type = btdev->le_scan_own_addr_type;
+		if (ev.peer_addr_type == 0x01)
+			memcpy(ev.peer_addr, btdev->random_addr, 6);
+		else
+			memcpy(ev.peer_addr, btdev->bdaddr, 6);
 
-	case BT_HCI_CMD_PIN_CODE_REQUEST_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		pcrnr_rsp.status = BT_HCI_ERR_SUCCESS;
-		memcpy(pcrnr_rsp.bdaddr, data, 6);
-		cmd_complete(btdev, opcode, &pcrnr_rsp, sizeof(pcrnr_rsp));
-		break;
+		ev.role = 0x01;
+		ev.handle = cpu_to_le16(ACL_HANDLE);
+		ev.interval = lecc->max_interval;
+		ev.latency = lecc->latency;
+		ev.supv_timeout = lecc->supv_timeout;
 
-	case BT_HCI_CMD_AUTH_REQUESTED:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+		le_meta_event(remote, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
+						sizeof(ev));
+	}
 
-	case BT_HCI_CMD_SET_CONN_ENCRYPT:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	ev.status = status;
+	ev.peer_addr_type = cmd->peer_addr_type;
+	memcpy(ev.peer_addr, cmd->peer_addr, 6);
+	ev.role = 0x00;
 
-	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
+}
 
-	case BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rnrc = data;
-		rnrc_rsp.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rnrc_rsp.bdaddr, rnrc->bdaddr, 6);
-		cmd_complete(btdev, opcode, &rnrc_rsp, sizeof(rnrc_rsp));
-		break;
+static int cmd_ext_create_conn_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_ext_create_conn *cmd = data;
+	struct btdev *remote;
 
-	case BT_HCI_CMD_READ_REMOTE_FEATURES:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	dev->le_scan_own_addr_type = cmd->own_addr_type;
 
-	case BT_HCI_CMD_READ_REMOTE_EXT_FEATURES:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	remote = find_btdev_by_bdaddr_type(cmd->peer_addr, cmd->peer_addr_type);
+	if (remote && ext_adv_connectable(remote) &&
+			ext_adv_match(dev, remote) &&
+			remote->le_adv_own_addr == cmd->peer_addr_type)
+		le_ext_conn_complete(dev, cmd, 0);
+	else
+		le_ext_conn_complete(dev, cmd,
+					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 
-	case BT_HCI_CMD_READ_REMOTE_VERSION:
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_READ_CLOCK_OFFSET:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+static int cmd_per_adv_create_sync(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_READ_DEFAULT_LINK_POLICY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rdlp.status = BT_HCI_ERR_SUCCESS;
-		rdlp.policy = cpu_to_le16(btdev->default_link_policy);
-		cmd_complete(btdev, opcode, &rdlp, sizeof(rdlp));
-		break;
+static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_WRITE_DEFAULT_LINK_POLICY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wdlp = data;
-		btdev->default_link_policy = le16_to_cpu(wdlp->policy);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_per_adv_term_sync(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_SET_EVENT_MASK:
-		sem = data;
-		memcpy(btdev->event_mask, sem->mask, 8);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_per_adv_add(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_RESET:
-		btdev_reset(btdev);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_per_adv_remove(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_SET_EVENT_FILTER:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		sef = data;
-		btdev->event_filter = sef->type;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_per_adv_clear(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_READ_STORED_LINK_KEY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rslk.status = BT_HCI_ERR_SUCCESS;
-		rslk.max_num_keys = cpu_to_le16(0);
-		rslk.num_keys = cpu_to_le16(0);
-		cmd_complete(btdev, opcode, &rslk, sizeof(rslk));
-		break;
+static int cmd_read_per_adv_list_size(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
+
+#define CMD_LE_50 \
+	CMD(BT_HCI_CMD_LE_SET_DEFAULT_PHY, cmd_set_default_phy,	NULL), \
+	CMD(BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR, cmd_set_adv_rand_addr, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS, cmd_set_ext_adv_params, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_EXT_ADV_DATA, cmd_set_ext_adv_data, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA, cmd_set_ext_scan_rsp_data, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, cmd_set_ext_adv_enable, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_MAX_ADV_DATA_LEN, cmd_read_max_adv_data_len, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS, cmd_read_num_adv_sets, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_ADV_SET, cmd_remove_adv_set, NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_ADV_SETS, cmd_clear_adv_sets, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PERIODIC_ADV_PARAMS, cmd_set_per_adv_params, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PERIODIC_ADV_DATA, cmd_set_per_adv_data, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE, cmd_set_per_adv_enable, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS, cmd_set_ext_scan_params, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE, cmd_set_ext_scan_enable, \
+					cmd_set_ext_scan_enable_complete), \
+	CMD(BT_HCI_CMD_LE_EXT_CREATE_CONN, cmd_ext_create_conn, \
+					cmd_ext_create_conn_complete), \
+	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC, cmd_per_adv_create_sync, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL, \
+					cmd_per_adv_create_sync_cancel, NULL), \
+	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC, cmd_per_adv_term_sync, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_ADD_DEV_PERIODIC_ADV_LIST, cmd_per_adv_add, NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_DEV_PERIODIC_ADV_LIST, cmd_per_adv_remove, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST, cmd_per_adv_clear, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_PERIODIC_ADV_LIST_SIZE, \
+					cmd_read_per_adv_list_size, NULL)
+
+static const struct btdev_cmd cmd_le_5_0[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_LE,
+	CMD_LE_50,
+	{}
+};
+
+static void set_le_50_commands(struct btdev *btdev)
+{
+	btdev->commands[35] |= 0x20;	/* LE Set Default PHY */
+	btdev->commands[36] |= 0x02;	/* LE Set Adv Set Random Address */
+	btdev->commands[36] |= 0x04;	/* LE Set Ext Adv Parameters */
+	btdev->commands[36] |= 0x08;	/* LE Set Ext Adv Data */
+	btdev->commands[36] |= 0x10;	/* LE Set Ext Scan Response Data */
+	btdev->commands[36] |= 0x20;	/* LE Set Ext Adv Enable */
+	btdev->commands[36] |= 0x40;	/* LE Read Maximum Adv Data Length */
+	btdev->commands[36] |= 0x80;	/* LE Read Num of Supported Adv Sets */
+	btdev->commands[37] |= 0x01;	/* LE Remove Adv Set */
+	btdev->commands[37] |= 0x02;	/* LE Clear Adv Sets */
+	btdev->commands[37] |= 0x04;	/* LE Set Periodic Adv Parameters */
+	btdev->commands[37] |= 0x08;	/* LE Set Periodic Adv Data */
+	btdev->commands[37] |= 0x10;	/* LE Set Periodic Adv Enable */
+	btdev->commands[37] |= 0x20;	/* LE Set Ext Scan Parameters */
+	btdev->commands[37] |= 0x40;	/* LE Set Ext Scan Enable */
+	btdev->commands[37] |= 0x80;	/* LE Ext Create Connection */
+	btdev->commands[38] |= 0x01;	/* LE Periodic Adv Create Sync */
+	btdev->commands[38] |= 0x02;	/* LE Periodic Adv Create Sync Cancel */
+	btdev->commands[38] |= 0x04;	/* LE Periodic Adv Terminate Sync */
+	btdev->commands[38] |= 0x08;	/* LE Add Device To Periodic Adv List */
+	btdev->commands[38] |= 0x10;	/* LE Remove Periodic Adv List */
+	btdev->commands[38] |= 0x20;	/* LE Clear Periodic Adv List */
+	btdev->commands[38] |= 0x40;	/* LE Read Periodic Adv List Size */
+	btdev->cmds = cmd_le_5_0;
+}
 
-	case BT_HCI_CMD_WRITE_STORED_LINK_KEY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wslk.status = BT_HCI_ERR_SUCCESS;
-		wslk.num_keys = 0;
-		cmd_complete(btdev, opcode, &wslk, sizeof(wslk));
-		break;
+static int cmd_read_size_v2(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_le_read_buffer_size_v2 rsp;
 
-	case BT_HCI_CMD_DELETE_STORED_LINK_KEY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		dslk.status = BT_HCI_ERR_SUCCESS;
-		dslk.num_keys = cpu_to_le16(0);
-		cmd_complete(btdev, opcode, &dslk, sizeof(dslk));
-		break;
+	memset(&rsp, 0, sizeof(rsp));
 
-	case BT_HCI_CMD_WRITE_LOCAL_NAME:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wln = data;
-		memcpy(btdev->name, wln->name, 248);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.acl_mtu = cpu_to_le16(dev->acl_mtu);
+	rsp.acl_max_pkt = dev->acl_max_pkt;
+	rsp.iso_mtu = cpu_to_le16(dev->iso_mtu);
+	rsp.iso_max_pkt = dev->iso_max_pkt;
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2, &rsp, sizeof(rsp));
 
-	case BT_HCI_CMD_READ_LOCAL_NAME:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rln.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rln.name, btdev->name, 248);
-		cmd_complete(btdev, opcode, &rln, sizeof(rln));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_READ_CONN_ACCEPT_TIMEOUT:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rcat.status = BT_HCI_ERR_SUCCESS;
-		rcat.timeout = cpu_to_le16(btdev->conn_accept_timeout);
-		cmd_complete(btdev, opcode, &rcat, sizeof(rcat));
-		break;
+static int cmd_read_iso_tx_sync(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_WRITE_CONN_ACCEPT_TIMEOUT:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wcat = data;
-		btdev->conn_accept_timeout = le16_to_cpu(wcat->timeout);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_set_cig_params(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct lescp {
+		struct bt_hci_rsp_le_set_cig_params params;
+		uint16_t handle;
+	} __attribute__ ((packed)) rsp;
 
-	case BT_HCI_CMD_READ_PAGE_TIMEOUT:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rpt.status = BT_HCI_ERR_SUCCESS;
-		rpt.timeout = cpu_to_le16(btdev->page_timeout);
-		cmd_complete(btdev, opcode, &rpt, sizeof(rpt));
-		break;
+	memset(&rsp, 0, sizeof(rsp));
 
-	case BT_HCI_CMD_WRITE_PAGE_TIMEOUT:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wpt = data;
-		btdev->page_timeout = le16_to_cpu(wpt->timeout);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	memcpy(&dev->le_cig, data, len);
+	rsp.params.status = BT_HCI_ERR_SUCCESS;
+	rsp.params.cig_id = 0x00;
+	rsp.params.num_handles = 1;
+	rsp.handle = cpu_to_le16(ISO_HANDLE);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_CIG_PARAMS, &rsp, sizeof(rsp));
 
-	case BT_HCI_CMD_READ_SCAN_ENABLE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rse.status = BT_HCI_ERR_SUCCESS;
-		rse.enable = btdev->scan_enable;
-		cmd_complete(btdev, opcode, &rse, sizeof(rse));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wse = data;
-		btdev->scan_enable = wse->enable;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_set_cig_params_test(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_READ_PAGE_SCAN_ACTIVITY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rpsa.status = BT_HCI_ERR_SUCCESS;
-		rpsa.interval = cpu_to_le16(btdev->page_scan_interval);
-		rpsa.window = cpu_to_le16(btdev->page_scan_window);
-		cmd_complete(btdev, opcode, &rpsa, sizeof(rpsa));
-		break;
+static int cmd_create_cis(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CREATE_CIS);
 
-	case BT_HCI_CMD_WRITE_PAGE_SCAN_ACTIVITY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wpsa = data;
-		btdev->page_scan_interval = le16_to_cpu(wpsa->interval);
-		btdev->page_scan_window = le16_to_cpu(wpsa->window);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_READ_INQUIRY_SCAN_ACTIVITY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		risa.status = BT_HCI_ERR_SUCCESS;
-		risa.interval = cpu_to_le16(btdev->inquiry_scan_interval);
-		risa.window = cpu_to_le16(btdev->inquiry_scan_window);
-		cmd_complete(btdev, opcode, &risa, sizeof(risa));
-		break;
+static void le_cis_estabilished(struct btdev *dev, uint8_t status)
+{
+	struct bt_hci_evt_le_cis_established evt;
 
-	case BT_HCI_CMD_WRITE_INQUIRY_SCAN_ACTIVITY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wisa = data;
-		btdev->inquiry_scan_interval = le16_to_cpu(wisa->interval);
-		btdev->inquiry_scan_window = le16_to_cpu(wisa->window);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	memset(&evt, 0, sizeof(evt));
 
-	case BT_HCI_CMD_READ_PAGE_SCAN_TYPE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rpst.status = BT_HCI_ERR_SUCCESS;
-		rpst.type = btdev->page_scan_type;
-		cmd_complete(btdev, opcode, &rpst, sizeof(rpst));
-		break;
+	evt.status = status;
 
-	case BT_HCI_CMD_WRITE_PAGE_SCAN_TYPE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wpst = data;
-		btdev->page_scan_type = wpst->type;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	if (dev->conn)
+		dev = dev->conn;
 
-	case BT_HCI_CMD_READ_AUTH_ENABLE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rae.status = BT_HCI_ERR_SUCCESS;
-		rae.enable = btdev->auth_enable;
-		cmd_complete(btdev, opcode, &rae, sizeof(rae));
-		break;
+	if (!evt.status) {
+		evt.conn_handle = cpu_to_le16(ISO_HANDLE);
+		/* TODO: Figure out if these values makes sense */
+		memcpy(evt.cig_sync_delay, dev->le_cig.params.m_interval,
+				sizeof(dev->le_cig.params.m_interval));
+		memcpy(evt.cis_sync_delay, dev->le_cig.params.s_interval,
+				sizeof(dev->le_cig.params.s_interval));
+		memcpy(evt.m_latency, &dev->le_cig.params.m_latency,
+				sizeof(dev->le_cig.params.m_latency));
+		memcpy(evt.s_latency, &dev->le_cig.params.s_latency,
+				sizeof(dev->le_cig.params.s_latency));
+		evt.m_phy = dev->le_cig.cis.m_phy;
+		evt.s_phy = dev->le_cig.cis.s_phy;
+		evt.nse = 0x01;
+		evt.m_bn = 0x01;
+		evt.s_bn = 0x01;
+		evt.m_ft = 0x01;
+		evt.s_ft = 0x01;
+		evt.m_mtu = dev->le_cig.cis.m_sdu;
+		evt.s_mtu = dev->le_cig.cis.s_sdu;
+		evt.interval = dev->le_cig.params.m_latency;
+	}
 
-	case BT_HCI_CMD_WRITE_AUTH_ENABLE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wae = data;
-		btdev->auth_enable = wae->enable;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
 
-	case BT_HCI_CMD_READ_CLASS_OF_DEV:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rcod.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rcod.dev_class, btdev->dev_class, 3);
-		cmd_complete(btdev, opcode, &rcod, sizeof(rcod));
-		break;
+	if (dev->conn)
+		le_meta_event(dev->conn, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt,
+							sizeof(evt));
+}
 
-	case BT_HCI_CMD_WRITE_CLASS_OF_DEV:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wcod = data;
-		memcpy(btdev->dev_class, wcod->dev_class, 3);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_create_cis_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct btdev *remote = dev->conn;
 
-	case BT_HCI_CMD_READ_VOICE_SETTING:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rvs.status = BT_HCI_ERR_SUCCESS;
-		rvs.setting = cpu_to_le16(btdev->voice_setting);
-		cmd_complete(btdev, opcode, &rvs, sizeof(rvs));
-		break;
+	if (remote) {
+		struct bt_hci_evt_le_cis_req evt;
 
-	case BT_HCI_CMD_WRITE_VOICE_SETTING:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wvs = data;
-		btdev->voice_setting = le16_to_cpu(wvs->setting);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+		evt.acl_handle = cpu_to_le16(ACL_HANDLE);
+		evt.cis_handle = cpu_to_le16(ISO_HANDLE);
+		evt.cig_id = 0x00;
+		evt.cis_id = 0x00;
 
-	case BT_HCI_CMD_SET_HOST_FLOW_CONTROL:
-		shfc = data;
-		if (shfc->enable > 0x03) {
-			status = BT_HCI_ERR_INVALID_PARAMETERS;
-		} else {
-			btdev->host_flow_control = shfc->enable;
-			status = BT_HCI_ERR_SUCCESS;
-		}
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+		le_meta_event(remote, BT_HCI_EVT_LE_CIS_REQ, &evt, sizeof(evt));
+	} else {
+		le_cis_estabilished(dev, BT_HCI_ERR_UNKNOWN_CONN_ID);
+	}
 
-	case BT_HCI_CMD_HOST_BUFFER_SIZE:
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_HOST_NUM_COMPLETED_PACKETS:
-		/* This command is special in the sense that no event is
-		 * normally generated after the command has completed.
-		 */
-		break;
+static int cmd_remove_cig(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_le_remove_cig rsp;
 
-	case BT_HCI_CMD_READ_NUM_SUPPORTED_IAC:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rnsi.status = BT_HCI_ERR_SUCCESS;
-		rnsi.num_iac = 0x01;
-		cmd_complete(btdev, opcode, &rnsi, sizeof(rnsi));
-		break;
+	memset(&dev->le_cig, 0, sizeof(dev->le_cig));
+	memset(&rsp, 0, sizeof(rsp));
 
-	case BT_HCI_CMD_READ_CURRENT_IAC_LAP:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rcil = alloca(sizeof(*rcil) + 3);
-		rcil->status = BT_HCI_ERR_SUCCESS;
-		rcil->num_iac = 0x01;
-		rcil->iac_lap[0] = 0x33;
-		rcil->iac_lap[1] = 0x8b;
-		rcil->iac_lap[2] = 0x9e;
-		cmd_complete(btdev, opcode, rcil, sizeof(*rcil) + 3);
-		break;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.cig_id = 0x00;
+	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_CIG, &rsp, sizeof(rsp));
 
-	case BT_HCI_CMD_WRITE_CURRENT_IAC_LAP:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_READ_INQUIRY_MODE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rim.status = BT_HCI_ERR_SUCCESS;
-		rim.mode = btdev->inquiry_mode;
-		cmd_complete(btdev, opcode, &rim, sizeof(rim));
-		break;
+static int cmd_accept_cis(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_ACCEPT_CIS);
+	le_cis_estabilished(dev, BT_HCI_ERR_SUCCESS);
 
-	case BT_HCI_CMD_WRITE_INQUIRY_MODE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wim = data;
-		btdev->inquiry_mode = wim->mode;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_READ_AFH_ASSESSMENT_MODE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		raam.status = BT_HCI_ERR_SUCCESS;
-		raam.mode = btdev->afh_assessment_mode;
-		cmd_complete(btdev, opcode, &raam, sizeof(raam));
-		break;
+static int cmd_reject_cis(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_reject_cis *cmd = data;
 
-	case BT_HCI_CMD_WRITE_AFH_ASSESSMENT_MODE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		waam = data;
-		btdev->afh_assessment_mode = waam->mode;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_ACCEPT_CIS);
+	le_cis_estabilished(dev, cmd->reason);
 
-	case BT_HCI_CMD_READ_EXT_INQUIRY_RESPONSE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		reir.status = BT_HCI_ERR_SUCCESS;
-		reir.fec = btdev->ext_inquiry_fec;
-		memcpy(reir.data, btdev->ext_inquiry_rsp, 240);
-		cmd_complete(btdev, opcode, &reir, sizeof(reir));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		weir = data;
-		btdev->ext_inquiry_fec = weir->fec;
-		memcpy(btdev->ext_inquiry_rsp, weir->data, 240);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_create_big(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_READ_SIMPLE_PAIRING_MODE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rspm.status = BT_HCI_ERR_SUCCESS;
-		rspm.mode = btdev->simple_pairing_mode;
-		cmd_complete(btdev, opcode, &rspm, sizeof(rspm));
-		break;
+static int cmd_create_big_test(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wspm = data;
-		btdev->simple_pairing_mode = wspm->mode;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_term_big(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_IO_CAPABILITY_REQUEST_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		icrr = data;
-		io_cap_req_reply_complete(btdev, icrr->bdaddr,
-							icrr->capability,
-							icrr->oob_data,
-							icrr->authentication);
-		break;
+static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_IO_CAPABILITY_REQUEST_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		icrnr = data;
-		io_cap_req_neg_reply_complete(btdev, icrnr->bdaddr);
-		ssp_complete(btdev, icrnr->bdaddr, BT_HCI_ERR_AUTH_FAILURE,
-									false);
-		break;
+static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_USER_CONFIRM_REQUEST_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		ucrr_rsp.status = BT_HCI_ERR_SUCCESS;
-		memcpy(ucrr_rsp.bdaddr, data, 6);
-		cmd_complete(btdev, opcode, &ucrr_rsp, sizeof(ucrr_rsp));
-		ssp_complete(btdev, data, BT_HCI_ERR_SUCCESS, true);
-		break;
+static int cmd_req_peer_sca(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_USER_CONFIRM_REQUEST_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		ucrnr_rsp.status = BT_HCI_ERR_SUCCESS;
-		memcpy(ucrnr_rsp.bdaddr, data, 6);
-		cmd_complete(btdev, opcode, &ucrnr_rsp, sizeof(ucrnr_rsp));
-		ssp_complete(btdev, data, BT_HCI_ERR_AUTH_FAILURE, true);
-		break;
+static int cmd_setup_iso_path(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_setup_iso_path *cmd = data;
+	struct bt_hci_rsp_le_setup_iso_path rsp;
 
-	case BT_HCI_CMD_READ_LOCAL_OOB_DATA:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rlod.status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &rlod, sizeof(rlod));
-		break;
+	memset(&rsp, 0, sizeof(rsp));
 
-	case BT_HCI_CMD_READ_INQUIRY_RESP_TX_POWER:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rirtp.status = BT_HCI_ERR_SUCCESS;
-		rirtp.level = 0;
-		cmd_complete(btdev, opcode, &rirtp, sizeof(rirtp));
-		break;
+	if (le16_to_cpu(cmd->handle) != ISO_HANDLE) {
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
 
-	case BT_HCI_CMD_READ_LE_HOST_SUPPORTED:
-		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		rlhs.status = BT_HCI_ERR_SUCCESS;
-		rlhs.supported = btdev->le_supported;
-		rlhs.simultaneous = btdev->le_simultaneous;
-		cmd_complete(btdev, opcode, &rlhs, sizeof(rlhs));
-		break;
+	/* Only support HCI or disabled paths */
+	if (cmd->path && cmd->path != 0xff) {
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
-	case BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED:
-		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_LE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		wlhs = data;
-		btdev->le_supported = wlhs->supported;
-		btdev->le_simultaneous = wlhs->simultaneous;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
+	switch (cmd->direction) {
+	case 0x00:
+		dev->le_iso_path[0] = cmd->path;
+		rsp.handle = cpu_to_le16(ISO_HANDLE);
 		break;
-
-	case BT_HCI_CMD_READ_SECURE_CONN_SUPPORT:
-		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		rscs.status = BT_HCI_ERR_SUCCESS;
-		rscs.support = btdev->secure_conn_support;
-		cmd_complete(btdev, opcode, &rscs, sizeof(rscs));
+	case 0x01:
+		dev->le_iso_path[1] = cmd->path;
+		rsp.handle = cpu_to_le16(ISO_HANDLE);
 		break;
+	default:
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+	}
 
-	case BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT:
-		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		wscs = data;
-		btdev->secure_conn_support = wscs->support;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SETUP_ISO_PATH, &rsp, sizeof(rsp));
 
-	case BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA:
-		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		rloed.status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &rloed, sizeof(rloed));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		rstp.status = BT_HCI_ERR_SUCCESS;
-		rstp.interval = cpu_to_le16(btdev->sync_train_interval);
-		rstp.timeout = cpu_to_le32(btdev->sync_train_timeout);
-		rstp.service_data = btdev->sync_train_service_data;
-		cmd_complete(btdev, opcode, &rstp, sizeof(rstp));
-		break;
+static int cmd_remove_iso_path(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_remove_iso_path *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	case BT_HCI_CMD_READ_LOCAL_VERSION:
-		rlv.status = BT_HCI_ERR_SUCCESS;
-		rlv.hci_ver = btdev->version;
-		rlv.hci_rev = cpu_to_le16(btdev->revision);
-		rlv.lmp_ver = btdev->version;
-		rlv.manufacturer = cpu_to_le16(btdev->manufacturer);
-		rlv.lmp_subver = cpu_to_le16(btdev->revision);
-		cmd_complete(btdev, opcode, &rlv, sizeof(rlv));
-		break;
+	if (!dev->conn || le16_to_cpu(cmd->handle) != ISO_HANDLE)
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 
-	case BT_HCI_CMD_READ_LOCAL_COMMANDS:
-		rlc.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rlc.commands, btdev->commands, 64);
-		cmd_complete(btdev, opcode, &rlc, sizeof(rlc));
+	switch (cmd->direction) {
+	case 0x00:
+		dev->le_iso_path[0] = 0x00;
 		break;
-
-	case BT_HCI_CMD_READ_LOCAL_FEATURES:
-		rlf.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rlf.features, btdev->features, 8);
-		cmd_complete(btdev, opcode, &rlf, sizeof(rlf));
+	case 0x01:
+		dev->le_iso_path[1] = 0x00;
 		break;
+	default:
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+	}
 
-	case BT_HCI_CMD_READ_LOCAL_EXT_FEATURES:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-
-		page = ((const uint8_t *) data)[0];
-
-		rlef.page = page;
-		rlef.max_page = btdev->max_page;
+	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ISO_PATH, &status,
+							sizeof(status));
 
-		if (page > btdev->max_page) {
-			rlef.status = BT_HCI_ERR_INVALID_PARAMETERS;
-			memset(rlef.features, 0, 8);
-			cmd_complete(btdev, opcode, &rlef, sizeof(rlef));
-			break;
-		}
+	return 0;
+}
 
-		switch (page) {
-		case 0x00:
-			rlef.status = BT_HCI_ERR_SUCCESS;
-			memcpy(rlef.features, btdev->features, 8);
-			break;
-		case 0x01:
-			rlef.status = BT_HCI_ERR_SUCCESS;
-			btdev_get_host_features(btdev, rlef.features);
-			break;
-		case 0x02:
-			rlef.status = BT_HCI_ERR_SUCCESS;
-			memcpy(rlef.features, btdev->feat_page_2, 8);
-			break;
-		default:
-			rlef.status = BT_HCI_ERR_INVALID_PARAMETERS;
-			memset(rlef.features, 0, 8);
-			break;
-		}
-		cmd_complete(btdev, opcode, &rlef, sizeof(rlef));
-		break;
+static int cmd_iso_tx_test(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_READ_BUFFER_SIZE:
-		rbs.status = BT_HCI_ERR_SUCCESS;
-		rbs.acl_mtu = cpu_to_le16(btdev->acl_mtu);
-		rbs.sco_mtu = 0;
-		rbs.acl_max_pkt = cpu_to_le16(btdev->acl_max_pkt);
-		rbs.sco_max_pkt = cpu_to_le16(0);
-		cmd_complete(btdev, opcode, &rbs, sizeof(rbs));
-		break;
+static int cmd_iso_rx_test(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_READ_COUNTRY_CODE:
-		rcc.status = BT_HCI_ERR_SUCCESS;
-		rcc.code = btdev->country_code;
-		cmd_complete(btdev, opcode, &rcc, sizeof(rcc));
-		break;
+static int cmd_iso_read_test_counter(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_READ_BD_ADDR:
-		rba.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rba.bdaddr, btdev->bdaddr, 6);
-		cmd_complete(btdev, opcode, &rba, sizeof(rba));
-		break;
+static int cmd_iso_test_end(struct btdev *dev, const void *data, uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_READ_DATA_BLOCK_SIZE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rdbs.status = BT_HCI_ERR_SUCCESS;
-		rdbs.max_acl_len = cpu_to_le16(btdev->acl_mtu);
-		rdbs.block_len = cpu_to_le16(btdev->acl_mtu);
-		rdbs.num_blocks = cpu_to_le16(btdev->acl_max_pkt);
-		cmd_complete(btdev, opcode, &rdbs, sizeof(rdbs));
-		break;
+static int cmd_set_host_feature(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	case BT_HCI_CMD_READ_LOCAL_CODECS:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		rlsc = alloca(sizeof(*rlsc) + 7);
-		rlsc->status = BT_HCI_ERR_SUCCESS;
-		rlsc->num_codecs = 0x06;
-		rlsc->codec[0] = 0x00;
-		rlsc->codec[1] = 0x01;
-		rlsc->codec[2] = 0x02;
-		rlsc->codec[3] = 0x03;
-		rlsc->codec[4] = 0x04;
-		rlsc->codec[5] = 0x05;
-		rlsc->codec[6] = 0x00;
-		cmd_complete(btdev, opcode, rlsc, sizeof(*rlsc) + 7);
-		break;
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_HOST_FEATURE, &status,
+							sizeof(status));
 
-	case BT_HCI_CMD_READ_RSSI:
-		rrssi = data;
+	return 0;
+}
 
-		rrssi_rsp.status = BT_HCI_ERR_SUCCESS;
-		rrssi_rsp.handle = rrssi->handle;
-		rrssi_rsp.rssi = -1; /* non-zero so we can see it in tester */
-		cmd_complete(btdev, opcode, &rrssi_rsp, sizeof(rrssi_rsp));
-		break;
+#define CMD_LE_52 \
+	CMD(BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2, cmd_read_size_v2, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_ISO_TX_SYNC, cmd_read_iso_tx_sync, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_EVENT_MASK, cmd_le_set_event_mask, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_CIG_PARAMS, cmd_set_cig_params, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST, cmd_set_cig_params_test, NULL), \
+	CMD(BT_HCI_CMD_LE_CREATE_CIS, cmd_create_cis, \
+					cmd_create_cis_complete), \
+	CMD(BT_HCI_CMD_LE_REMOVE_CIG, cmd_remove_cig, NULL), \
+	CMD(BT_HCI_CMD_LE_ACCEPT_CIS, cmd_accept_cis, NULL), \
+	CMD(BT_HCI_CMD_LE_REJECT_CIS, cmd_reject_cis, NULL), \
+	CMD(BT_HCI_CMD_LE_CREATE_BIG, cmd_create_big, NULL), \
+	CMD(BT_HCI_CMD_LE_CREATE_BIG_TEST, cmd_create_big_test, NULL), \
+	CMD(BT_HCI_CMD_LE_TERM_BIG, cmd_term_big, NULL), \
+	CMD(BT_HCI_CMD_LE_BIG_CREATE_SYNC, cmd_big_create_sync, NULL), \
+	CMD(BT_HCI_CMD_LE_BIG_TERM_SYNC, cmd_big_term_sync, NULL), \
+	CMD(BT_HCI_CMD_LE_REQ_PEER_SCA, cmd_req_peer_sca, NULL), \
+	CMD(BT_HCI_CMD_LE_SETUP_ISO_PATH, cmd_setup_iso_path, NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_ISO_PATH, cmd_remove_iso_path, NULL), \
+	CMD(BT_HCI_CMD_LE_ISO_TX_TEST, cmd_iso_tx_test, NULL), \
+	CMD(BT_HCI_CMD_LE_ISO_RX_TEST, cmd_iso_rx_test, NULL), \
+	CMD(BT_HCI_CMD_LE_ISO_READ_TEST_COUNTER, cmd_iso_read_test_counter, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_ISO_TEST_END, cmd_iso_test_end, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_HOST_FEATURE, cmd_set_host_feature, NULL)
+
+static const struct btdev_cmd cmd_le_5_2[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_LE,
+	CMD_LE_50,
+	CMD_LE_52,
+	{}
+};
 
-	case BT_HCI_CMD_READ_TX_POWER:
-		rtxp = data;
+static void set_le_52_commands(struct btdev *btdev)
+{
+	btdev->commands[41] |= 0x20;	/* LE Read Buffer Size v2 */
+	btdev->commands[41] |= 0x40;	/* LE Read ISO TX Sync */
+	btdev->commands[41] |= 0x80;	/* LE Set CIG Parameters */
+	btdev->commands[42] |= 0x01;	/* LE Set CIG Parameters Test */
+	btdev->commands[42] |= 0x02;	/* LE Create CIS */
+	btdev->commands[42] |= 0x04;	/* LE Remove CIG */
+	btdev->commands[42] |= 0x08;	/* LE Accept CIS */
+	btdev->commands[42] |= 0x10;	/* LE Reject CIS */
+	btdev->commands[42] |= 0x20;	/* LE Create BIG */
+	btdev->commands[42] |= 0x40;	/* LE Create BIG Test */
+	btdev->commands[42] |= 0x80;	/* LE Terminate BIG */
+	btdev->commands[43] |= 0x01;	/* LE BIG Create Sync */
+	btdev->commands[43] |= 0x02;	/* LE BIG Terminate Sync */
+	btdev->commands[43] |= 0x04;	/* LE Request Peer SCA */
+	btdev->commands[43] |= 0x08;	/* LE Setup ISO Path */
+	btdev->commands[43] |= 0x10;	/* LE Remove ISO Path */
+	btdev->commands[43] |= 0x20;	/* LE ISO TX Test */
+	btdev->commands[43] |= 0x40;	/* LE ISO RX Test */
+	btdev->commands[43] |= 0x80;	/* LE ISO Read Test Counter */
+	btdev->commands[44] |= 0x01;	/* LE ISO Test End */
+	btdev->commands[44] |= 0x02;	/* LE ISO Set Host Feature */
+	btdev->cmds = cmd_le_5_2;
+}
 
-		switch (rtxp->type) {
-		case 0x00:
-			rtxp_rsp.status = BT_HCI_ERR_SUCCESS;
-			rtxp_rsp.level =  -1; /* non-zero */
-			break;
+static const struct btdev_cmd cmd_le[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_LE,
+	{}
+};
 
-		case 0x01:
-			rtxp_rsp.status = BT_HCI_ERR_SUCCESS;
-			rtxp_rsp.level = 4; /* max for class 2 radio */
-			break;
+static void set_le_commands(struct btdev *btdev)
+{
+	set_common_commands_all(btdev);
+	set_common_commands_bredrle(btdev);
 
-		default:
-			rtxp_rsp.level = 0;
-			rtxp_rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
-			break;
-		}
+	btdev->commands[24] |= 0x20;	/* Read LE Host Supported */
+	btdev->commands[24] |= 0x20;	/* Write LE Host Supported */
+	btdev->commands[25] |= 0x01;	/* LE Set Event Mask */
+	btdev->commands[25] |= 0x02;	/* LE Read Buffer Size */
+	btdev->commands[25] |= 0x04;	/* LE Read Local Features */
+	btdev->commands[25] |= 0x10;	/* LE Set Random Address */
+	btdev->commands[25] |= 0x20;	/* LE Set Adv Parameters */
+	btdev->commands[25] |= 0x40;	/* LE Read Adv TX Power */
+	btdev->commands[25] |= 0x80;	/* LE Set Adv Data */
+	btdev->commands[26] |= 0x01;	/* LE Set Scan Response Data */
+	btdev->commands[26] |= 0x02;	/* LE Set Adv Enable */
+	btdev->commands[26] |= 0x04;	/* LE Set Scan Parameters */
+	btdev->commands[26] |= 0x08;	/* LE Set Scan Enable */
+	btdev->commands[26] |= 0x10;	/* LE Create Connection */
+	btdev->commands[26] |= 0x40;	/* LE Read White List Size */
+	btdev->commands[26] |= 0x80;	/* LE Clear White List */
+	btdev->commands[27] |= 0x04;	/* LE Connection Update */
+	btdev->commands[27] |= 0x20;	/* LE Read Remote Used Features */
+	btdev->commands[27] |= 0x40;	/* LE Encrypt */
+	btdev->commands[27] |= 0x80;	/* LE Rand */
+	btdev->commands[28] |= 0x01;	/* LE Start Encryption */
+	btdev->commands[28] |= 0x02;	/* LE Long Term Key Request Reply */
+	btdev->commands[28] |= 0x04;	/* LE Long Term Key Request Neg Reply */
+	btdev->commands[28] |= 0x08;	/* LE Read Supported States */
+	btdev->commands[28] |= 0x10;	/* LE Receiver Test */
+	btdev->commands[28] |= 0x20;	/* LE Transmitter Test */
+	btdev->commands[28] |= 0x40;	/* LE Test End */
 
-		rtxp_rsp.handle = rtxp->handle;
-		cmd_complete(btdev, opcode, &rtxp_rsp, sizeof(rtxp_rsp));
-		break;
+	/* Extra LE commands for >= 4.1 adapters */
+	btdev->commands[33] |= 0x10;	/* LE Remote Conn Param Req Reply */
+	btdev->commands[33] |= 0x20;	/* LE Remote Conn Param Req Neg Reply */
 
-	case BT_HCI_CMD_READ_ENCRYPT_KEY_SIZE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-					btdev->type != BTDEV_TYPE_BREDR &&
-					btdev->type != BTDEV_TYPE_BREDRLE50 &&
-					btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		reks = data;
-		read_enc_key_size_complete(btdev, le16_to_cpu(reks->handle));
-		break;
+	/* Extra LE commands for >= 4.2 adapters */
+	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
+	btdev->commands[34] |= 0x04;	/* LE Generate DHKey */
 
-	case BT_HCI_CMD_READ_LOCAL_AMP_INFO:
-		if (btdev->type != BTDEV_TYPE_AMP)
-			goto unsupported;
-		rlai.status = BT_HCI_ERR_SUCCESS;
-		rlai.amp_status = 0x01;		/* Used for Bluetooth only */
-		rlai.total_bw = cpu_to_le32(0);
-		rlai.max_bw = cpu_to_le32(0);
-		rlai.min_latency = cpu_to_le32(0);
-		rlai.max_pdu = cpu_to_le32(672);
-		rlai.amp_type = 0x01;		/* 802.11 AMP Controller */
-		rlai.pal_cap = cpu_to_le16(0x0000);
-		rlai.max_assoc_len = cpu_to_le16(672);
-		rlai.max_flush_to = cpu_to_le32(0xffffffff);
-		rlai.be_flush_to = cpu_to_le32(0xffffffff);
-		cmd_complete(btdev, opcode, &rlai, sizeof(rlai));
-		break;
+	btdev->cmds = cmd_le;
 
-	case BT_HCI_CMD_READ_LOCAL_AMP_ASSOC:
-		if (btdev->type != BTDEV_TYPE_AMP)
-			goto unsupported;
-		rlaa_cmd = data;
-		rlaa_rsp.status = BT_HCI_ERR_SUCCESS;
-		rlaa_rsp.phy_handle = rlaa_cmd->phy_handle;
-		rlaa_rsp.remain_assoc_len = cpu_to_le16(1);
-		rlaa_rsp.assoc_fragment[0] = 0x42;
-		memset(rlaa_rsp.assoc_fragment + 1, 0,
-					sizeof(rlaa_rsp.assoc_fragment) - 1);
-		cmd_complete(btdev, opcode, &rlaa_rsp, sizeof(rlaa_rsp));
-		break;
+	/* Extra LE commands for >= 5.0 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE50) {
+		set_le_50_commands(btdev);
+		btdev->cmds = cmd_le_5_0;
+	}
 
-	case BT_HCI_CMD_GET_MWS_TRANSPORT_CONFIG:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		gmtc = alloca(sizeof(*gmtc));
-		gmtc->status = BT_HCI_ERR_SUCCESS;
-		gmtc->num_transports = 0x00;
-		cmd_complete(btdev, opcode, gmtc, sizeof(*gmtc));
-		break;
+	/* Extra LE commands for >= 5.2 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
+		set_le_52_commands(btdev);
+		btdev->cmds = cmd_le_5_2;
+	}
+}
 
-	case BT_HCI_CMD_SET_EVENT_MASK_PAGE2:
-		if (btdev->type == BTDEV_TYPE_BREDR20 ||
-				btdev->type == BTDEV_TYPE_AMP)
-			goto unsupported;
-		semp2 = data;
-		memcpy(btdev->event_mask_page2, semp2->mask, 8);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_set_event_mask_2(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_set_event_mask_page2 *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	case BT_HCI_CMD_LE_SET_EVENT_MASK:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lsem = data;
-		memcpy(btdev->le_event_mask, lsem->mask, 8);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	memcpy(dev->event_mask_page2, cmd->mask, 8);
+	cmd_complete(dev, BT_HCI_CMD_SET_EVENT_MASK_PAGE2, &status,
+						sizeof(status));
 
-	case BT_HCI_CMD_LE_READ_BUFFER_SIZE:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lrbs.status = BT_HCI_ERR_SUCCESS;
-		lrbs.le_mtu = cpu_to_le16(btdev->acl_mtu);
-		lrbs.le_max_pkt = btdev->acl_max_pkt;
-		cmd_complete(btdev, opcode, &lrbs, sizeof(lrbs));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_LE_READ_LOCAL_FEATURES:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lrlf.status = BT_HCI_ERR_SUCCESS;
-		memcpy(lrlf.features, btdev->le_features, 8);
-		cmd_complete(btdev, opcode, &lrlf, sizeof(lrlf));
-		break;
+static int cmd_read_sync_train_params(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_sync_train_params rsp;
 
-	case BT_HCI_CMD_LE_SET_RANDOM_ADDRESS:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lsra = data;
-		memcpy(btdev->random_addr, lsra->addr, 6);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	memset(&rsp, 0, sizeof(rsp));
 
-	case BT_HCI_CMD_LE_SET_ADV_PARAMETERS:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.interval = cpu_to_le16(dev->sync_train_interval);
+	rsp.timeout = cpu_to_le32(dev->sync_train_timeout);
+	rsp.service_data = dev->sync_train_service_data;
+	cmd_complete(dev, BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS, &rsp, sizeof(rsp));
 
-		if (btdev->le_adv_enable) {
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-			cmd_complete(btdev, opcode, &status, sizeof(status));
-			break;
-		}
+	return 0;
+}
 
-		lsap = data;
-		btdev->le_adv_type = lsap->type;
-		/* Use Legacy PDU if the remote is using EXT Scan */
-		btdev->le_ext_adv_type = ext_legacy_adv_type(lsap->type);
-		btdev->le_adv_own_addr = lsap->own_addr_type;
-		btdev->le_adv_direct_addr_type = lsap->direct_addr_type;
-		memcpy(btdev->le_adv_direct_addr, lsap->direct_addr, 6);
+static int cmd_read_sc_support(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_secure_conn_support rsp;
 
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	memset(&rsp, 0, sizeof(rsp));
 
-	case BT_HCI_CMD_LE_READ_ADV_TX_POWER:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lratp.status = BT_HCI_ERR_SUCCESS;
-		lratp.level = 0;
-		cmd_complete(btdev, opcode, &lratp, sizeof(lratp));
-		break;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.support = dev->secure_conn_support;
+	cmd_complete(dev, BT_HCI_CMD_READ_SECURE_CONN_SUPPORT, &rsp,
+							sizeof(rsp));
 
-	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lsae = data;
-		if (btdev->le_adv_enable == lsae->enable)
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-		else {
-			btdev->le_adv_enable = lsae->enable;
-			status = BT_HCI_ERR_SUCCESS;
-		}
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		if (status == BT_HCI_ERR_SUCCESS && btdev->le_adv_enable)
-			le_set_adv_enable_complete(btdev);
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_LE_SET_SCAN_PARAMETERS:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
+static int cmd_write_sc_support(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_secure_conn_support *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-		lssp = data;
+	dev->secure_conn_support = cmd->support;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT, &status,
+							sizeof(status));
 
-		if (btdev->le_scan_enable)
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-		else {
-			status = BT_HCI_ERR_SUCCESS;
-			btdev->le_scan_type = lssp->type;
-			btdev->le_scan_own_addr_type = lssp->own_addr_type;
-		}
+	return 0;
+}
 
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_read_auth_payload_timeout(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_LE_SET_SCAN_ENABLE:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lsse = data;
-		if (btdev->le_scan_enable == lsse->enable)
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-		else {
-			btdev->le_scan_enable = lsse->enable;
-			btdev->le_filter_dup = lsse->filter_dup;
-			status = BT_HCI_ERR_SUCCESS;
-		}
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static int cmd_write_auth_payload_timeout(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
 
-	case BT_HCI_CMD_LE_CREATE_CONN:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+static int cmd_read_local_oob_ext_data(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_local_oob_ext_data rsp;
 
-	case BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lrwls.status = BT_HCI_ERR_SUCCESS;
-		lrwls.size = 0;
-		cmd_complete(btdev, opcode, &lrwls, sizeof(lrwls));
-		break;
+	memset(&rsp, 0, sizeof(rsp));
 
-	case BT_HCI_CMD_LE_CONN_UPDATE:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA, &rsp,
+							sizeof(rsp));
 
-	case BT_HCI_CMD_LE_CLEAR_WHITE_LIST:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	return 0;
+}
 
-	case BT_HCI_CMD_LE_ENCRYPT:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lenc_cmd = data;
-		if (!bt_crypto_e(btdev->crypto, lenc_cmd->key,
-				 lenc_cmd->plaintext, lenc.data)) {
-			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
-				   opcode);
-			break;
-		}
-		lenc.status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &lenc, sizeof(lenc));
-		break;
+#define BT_BREDR_LE \
+	CMD(BT_HCI_CMD_SET_EVENT_MASK_PAGE2, cmd_set_event_mask_2, NULL), \
+	CMD(BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS, cmd_read_sync_train_params, \
+					NULL), \
+	CMD(BT_HCI_CMD_READ_SECURE_CONN_SUPPORT, cmd_read_sc_support, NULL), \
+	CMD(BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT, cmd_write_sc_support, NULL), \
+	CMD(BT_HCI_CMD_READ_AUTH_PAYLOAD_TIMEOUT, \
+					cmd_read_auth_payload_timeout, NULL), \
+	CMD(BT_HCI_CMD_WRITE_AUTH_PAYLOAD_TIMEOUT, \
+					cmd_write_auth_payload_timeout, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA, \
+					cmd_read_local_oob_ext_data, NULL)
+
+static const struct btdev_cmd cmd_bredr_le[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_COMMON_BREDR_20,
+	CMD_BREDR,
+	CMD_LE,
+	CMD_LE_50,
+	CMD_LE_52,
+	BT_BREDR_LE,
+	{}
+};
 
-	case BT_HCI_CMD_LE_RAND:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		if (!bt_crypto_random_bytes(btdev->crypto,
-					    (uint8_t *)&lr.number, 8)) {
-			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
-				   opcode);
-			break;
-		}
-		lr.status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &lr, sizeof(lr));
-		break;
+static void set_bredrle_commands(struct btdev *btdev)
+{
+	set_bredr_commands(btdev);
+	set_le_commands(btdev);
 
-	case BT_HCI_CMD_LE_READ_LOCAL_PK256:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		if (!ecc_make_key(pk_evt.local_pk256, btdev->le_local_sk256)) {
-			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
-									opcode);
-			break;
-		}
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS,
-						BT_HCI_CMD_LE_READ_LOCAL_PK256);
-		pk_evt.status = BT_HCI_ERR_SUCCESS;
-		le_meta_event(btdev, BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE,
-						&pk_evt, sizeof(pk_evt));
-		break;
+	/* Extra BR/EDR commands we want to only support for >= 4.0
+	 * adapters.
+	 */
+	btdev->commands[22] |= 0x04;	/* Set Event Mask Page 2 */
+	btdev->commands[31] |= 0x80;	/* Read Sync Train Parameters */
+	btdev->commands[32] |= 0x04;	/* Read Secure Connections Support */
+	btdev->commands[32] |= 0x08;	/* Write Secure Connections Support */
+	btdev->commands[32] |= 0x10;	/* Read Auth Payload Timeout */
+	btdev->commands[32] |= 0x20;	/* Write Auth Payload Timeout */
+	btdev->commands[32] |= 0x40;	/* Read Local OOB Extended Data */
+	btdev->cmds = cmd_bredr_le;
+}
 
-	case BT_HCI_CMD_LE_GENERATE_DHKEY:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		dh = data;
-		if (!ecdh_shared_secret(dh->remote_pk256, btdev->le_local_sk256,
-								dh_evt.dhkey)) {
-			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
-									opcode);
-			break;
-		}
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS,
-						BT_HCI_CMD_LE_GENERATE_DHKEY);
-		dh_evt.status = BT_HCI_ERR_SUCCESS;
-		le_meta_event(btdev, BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE,
-						&dh_evt, sizeof(dh_evt));
-		break;
+static void set_amp_commands(struct btdev *btdev)
+{
+	set_common_commands_all(btdev);
 
-	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lrss.status = BT_HCI_ERR_SUCCESS;
-		memcpy(lrss.states, btdev->le_states, 8);
-		cmd_complete(btdev, opcode, &lrss, sizeof(lrss));
-		break;
+	btdev->commands[22] |= 0x20;	/* Read Local AMP Info */
+}
 
-	case BT_HCI_CMD_LE_SET_ADV_DATA:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lsad = data;
-		btdev->le_adv_data_len = lsad->len;
-		memcpy(btdev->le_adv_data, lsad->data, 31);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static void set_bredrle_features(struct btdev *btdev)
+{
+	btdev->features[0] |= 0x04;	/* Encryption */
+	btdev->features[0] |= 0x20;	/* Role switch */
+	btdev->features[0] |= 0x80;	/* Sniff mode */
+	btdev->features[1] |= 0x08;	/* SCO link */
+	btdev->features[2] |= 0x08;	/* Transparent SCO */
+	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
+	btdev->features[3] |= 0x80;	/* Extended SCO link */
+	btdev->features[4] |= 0x08;	/* AFH capable slave */
+	btdev->features[4] |= 0x10;	/* AFH classification slave */
+	btdev->features[4] |= 0x40;	/* LE Supported */
+	btdev->features[5] |= 0x02;	/* Sniff subrating */
+	btdev->features[5] |= 0x04;	/* Pause encryption */
+	btdev->features[5] |= 0x08;	/* AFH capable master */
+	btdev->features[5] |= 0x10;	/* AFH classification master */
+	btdev->features[6] |= 0x01;	/* Extended Inquiry Response */
+	btdev->features[6] |= 0x02;	/* Simultaneous LE and BR/EDR */
+	btdev->features[6] |= 0x08;	/* Secure Simple Pairing */
+	btdev->features[6] |= 0x10;	/* Encapsulated PDU */
+	btdev->features[6] |= 0x20;	/* Erroneous Data Reporting */
+	btdev->features[6] |= 0x40;	/* Non-flushable Packet Boundary Flag */
+	btdev->features[7] |= 0x01;	/* Link Supervision Timeout Event */
+	btdev->features[7] |= 0x02;	/* Inquiry TX Power Level */
+	btdev->features[7] |= 0x80;	/* Extended features */
 
-	case BT_HCI_CMD_LE_SET_SCAN_RSP_DATA:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lssrd = data;
-		btdev->le_scan_data_len = lssrd->len;
-		memcpy(btdev->le_scan_data, lssrd->data, 31);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	if (btdev->type >= BTDEV_TYPE_BREDRLE50) {
+		/* These BREDR features are added to test new configuration
+		 * command. If this is added above it will break existing tests
+		 */
+		btdev->features[0] |= 0x01;	/* 3 slot Packets */
+		btdev->features[0] |= 0x02;	/* 5 slot Packets */
+		btdev->features[3] |= 0x02;	/* EDR ACL 2M mode */
+		btdev->features[3] |= 0x04;	/* EDR ACL 3M mode */
+		btdev->features[4] |= 0x80;	/* 3 slot EDR ACL packets */
+		btdev->features[5] |= 0x01;	/* 5 slot EDR ACL packets */
 
-	case BT_HCI_CMD_LE_READ_REMOTE_FEATURES:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		le_read_remote_features_complete(btdev);
-		break;
+		btdev->le_features[1] |= 0x01;	/* LE 2M PHY */
+		btdev->le_features[1] |= 0x08;	/* LE Coded PHY */
+		btdev->le_features[1] |= 0x10;  /* LE EXT ADV */
+	}
 
-	case BT_HCI_CMD_LE_START_ENCRYPT:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lse = data;
-		memcpy(btdev->le_ltk, lse->ltk, 16);
-		le_start_encrypt_complete(btdev, lse->ediv, lse->rand);
-		break;
+	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
+		btdev->le_features[3] |= 0x10;  /* LE CIS Master */
+		btdev->le_features[3] |= 0x20;  /* LE CIS Slave */
+		btdev->le_features[3] |= 0x40;  /* LE ISO Broadcaster */
+		btdev->le_features[3] |= 0x80;  /* LE Synchronized Receiver */
+		btdev->le_features[4] |= 0x01;  /* LE ISO channels */
+	}
 
-	case BT_HCI_CMD_LE_LTK_REQ_REPLY:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		llrr = data;
-		memcpy(btdev->le_ltk, llrr->ltk, 16);
-		le_encrypt_complete(btdev);
-		break;
+	btdev->feat_page_2[0] |= 0x01;	/* CSB - Master Operation */
+	btdev->feat_page_2[0] |= 0x02;	/* CSB - Slave Operation */
+	btdev->feat_page_2[0] |= 0x04;	/* Synchronization Train */
+	btdev->feat_page_2[0] |= 0x08;	/* Synchronization Scan */
+	btdev->feat_page_2[0] |= 0x10;	/* Inquiry Response Notification */
+	btdev->feat_page_2[1] |= 0x01;	/* Secure Connections */
+	btdev->feat_page_2[1] |= 0x02;	/* Ping */
 
-	case BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		ltk_neg_reply_complete(btdev);
-		break;
+	btdev->max_page = 2;
+}
 
-	case BT_HCI_CMD_SETUP_SYNC_CONN:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		ssc = data;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		sync_conn_complete(btdev, ssc->voice_setting,
-							BT_HCI_ERR_SUCCESS);
-		break;
+static void set_bredr_features(struct btdev *btdev)
+{
+	btdev->features[0] |= 0x04;	/* Encryption */
+	btdev->features[0] |= 0x20;	/* Role switch */
+	btdev->features[0] |= 0x80;	/* Sniff mode */
+	btdev->features[1] |= 0x08;	/* SCO link */
+	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
+	btdev->features[3] |= 0x80;	/* Extended SCO link */
+	btdev->features[4] |= 0x08;	/* AFH capable slave */
+	btdev->features[4] |= 0x10;	/* AFH classification slave */
+	btdev->features[5] |= 0x02;	/* Sniff subrating */
+	btdev->features[5] |= 0x04;	/* Pause encryption */
+	btdev->features[5] |= 0x08;	/* AFH capable master */
+	btdev->features[5] |= 0x10;	/* AFH classification master */
+	btdev->features[6] |= 0x01;	/* Extended Inquiry Response */
+	btdev->features[6] |= 0x08;	/* Secure Simple Pairing */
+	btdev->features[6] |= 0x10;	/* Encapsulated PDU */
+	btdev->features[6] |= 0x20;	/* Erroneous Data Reporting */
+	btdev->features[6] |= 0x40;	/* Non-flushable Packet Boundary Flag */
+	btdev->features[7] |= 0x01;	/* Link Supervision Timeout Event */
+	btdev->features[7] |= 0x02;	/* Inquiry TX Power Level */
+	btdev->features[7] |= 0x80;	/* Extended features */
 
-	case BT_HCI_CMD_ADD_SCO_CONN:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		sco_conn_complete(btdev, BT_HCI_ERR_SUCCESS);
-		break;
+	btdev->max_page = 1;
+}
 
-	case BT_HCI_CMD_ENABLE_DUT_MODE:
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static void set_bredr20_features(struct btdev *btdev)
+{
+	btdev->features[0] |= 0x04;	/* Encryption */
+	btdev->features[0] |= 0x20;	/* Role switch */
+	btdev->features[0] |= 0x80;	/* Sniff mode */
+	btdev->features[1] |= 0x08;	/* SCO link */
+	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
+	btdev->features[3] |= 0x80;	/* Extended SCO link */
+	btdev->features[4] |= 0x08;	/* AFH capable slave */
+	btdev->features[4] |= 0x10;	/* AFH classification slave */
+	btdev->features[5] |= 0x02;	/* Sniff subrating */
+	btdev->features[5] |= 0x04;	/* Pause encryption */
+	btdev->features[5] |= 0x08;	/* AFH capable master */
+	btdev->features[5] |= 0x10;	/* AFH classification master */
+	btdev->features[7] |= 0x80;	/* Extended features */
 
-	case BT_HCI_CMD_WRITE_SSP_DEBUG_MODE:
-		if (btdev->type == BTDEV_TYPE_LE)
-			goto unsupported;
-		wsdm = data;
-		btdev->ssp_debug_mode = wsdm->mode;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	btdev->max_page = 1;
+}
 
-	case BT_HCI_CMD_LE_RECEIVER_TEST:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+static void set_le_features(struct btdev *btdev)
+{
+	btdev->features[4] |= 0x20;	/* BR/EDR Not Supported */
+	btdev->features[4] |= 0x40;	/* LE Supported */
 
-	case BT_HCI_CMD_LE_TRANSMITTER_TEST:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	btdev->max_page = 1;
 
-	case BT_HCI_CMD_LE_TEST_END:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lte.status = BT_HCI_ERR_SUCCESS;
-		lte.num_packets = 0;
-		cmd_complete(btdev, opcode, &lte, sizeof(lte));
-		break;
+	btdev->le_features[0] |= 0x01;	/* LE Encryption */
+	btdev->le_features[0] |= 0x02;	/* Connection Parameters Request */
+	btdev->le_features[0] |= 0x08;	/* Slave-initiated Features Exchange */
+}
 
-	case BT_HCI_CMD_LE_CONN_PARAM_REQ_REPLY:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lcprr_cmd = data;
-		lcprr_rsp.handle = lcprr_cmd->handle;
-		lcprr_rsp.status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &lcprr_rsp, sizeof(lcprr_rsp));
-		break;
-	case BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lcprnr_cmd = data;
-		lcprnr_rsp.handle = lcprnr_cmd->handle;
-		lcprnr_rsp.status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &lcprnr_rsp, sizeof(lcprnr_rsp));
-		break;
-	case BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		rlrnsas.status = BT_HCI_ERR_SUCCESS;
-		/* Support one set as of now */
-		rlrnsas.num_of_sets = 1;
-		cmd_complete(btdev, opcode, &rlrnsas, sizeof(rlrnsas));
-		break;
-	case BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
+static void set_le_states(struct btdev *btdev)
+{
+	/* Set all 41 bits as per Bluetooth 5.0 specification */
+	btdev->le_states[0] = 0xff;
+	btdev->le_states[1] = 0xff;
+	btdev->le_states[2] = 0xff;
+	btdev->le_states[3] = 0xff;
+	btdev->le_states[4] = 0xff;
+	btdev->le_states[5] = 0x03;
+}
 
-		lsasra = data;
-		memcpy(btdev->random_addr, lsasra->bdaddr, 6);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-	case BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		if (btdev->le_adv_enable) {
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-			cmd_complete(btdev, opcode, &status, sizeof(status));
-			break;
-		}
+static void set_amp_features(struct btdev *btdev)
+{
+}
 
-		lseap = data;
-		btdev->le_ext_adv_type = le16_to_cpu(lseap->evt_properties);
-		btdev->le_adv_own_addr = lseap->own_addr_type;
-		btdev->le_adv_direct_addr_type = lseap->peer_addr_type;
-		memcpy(btdev->le_adv_direct_addr, lseap->peer_addr, 6);
+struct btdev *btdev_create(enum btdev_type type, uint16_t id)
+{
+	struct btdev *btdev;
+	int index;
 
-		rlseap.status = BT_HCI_ERR_SUCCESS;
-		rlseap.tx_power = 0;
-		cmd_complete(btdev, opcode, &rlseap, sizeof(rlseap));
-		break;
-	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		lseae = data;
-		if (btdev->le_adv_enable == lseae->enable)
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-		else {
-			const struct bt_hci_cmd_ext_adv_set *eas;
-
-			if (lseae->num_of_sets) {
-				eas = data + sizeof(*lseae);
-				if (eas->duration || lseae->num_of_sets > 1)
-					status = BT_HCI_ERR_INVALID_PARAMETERS;
-				else
-					status = BT_HCI_ERR_SUCCESS;
-			} else
-				status = BT_HCI_ERR_SUCCESS;
-
-			if (status == BT_HCI_ERR_SUCCESS)
-				btdev->le_adv_enable = lseae->enable;
-		}
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		if (status == BT_HCI_ERR_SUCCESS && btdev->le_adv_enable)
-			le_set_ext_adv_enable_complete(btdev);
-		break;
-	case BT_HCI_CMD_LE_SET_EXT_ADV_DATA:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		lsead = data;
-		btdev->le_adv_data_len = lsead->data_len;
-		memcpy(btdev->le_adv_data, lsead->data, 31);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-	case BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		lsesrd = data;
-		btdev->le_scan_data_len = lsesrd->data_len;
-		memcpy(btdev->le_scan_data, lsesrd->data, 31);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-	case BT_HCI_CMD_LE_REMOVE_ADV_SET:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
+	btdev = malloc(sizeof(*btdev));
+	if (!btdev)
+		return NULL;
 
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-	case BT_HCI_CMD_LE_CLEAR_ADV_SETS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
+	memset(btdev, 0, sizeof(*btdev));
 
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-	case BT_HCI_CMD_LE_SET_DEFAULT_PHY:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		phys = data;
-		if (phys->all_phys > 0x03 ||
-			(!(phys->all_phys & 0x01) &&
-				(!phys->tx_phys || phys->tx_phys > 0x07)) ||
-			(!(phys->all_phys & 0x02) &&
-				(!phys->rx_phys || phys->rx_phys > 0x07)))
-			status = BT_HCI_ERR_INVALID_PARAMETERS;
-		else
-			status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-	case BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		lsesp = data;
-		lsp = (void *)lsesp->data;
-
-		if (btdev->le_scan_enable)
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-		else if (lsesp->num_phys == 0)
-			status = BT_HCI_ERR_INVALID_PARAMETERS;
-		else {
-			status = BT_HCI_ERR_SUCCESS;
-			/* Currently we dont support multiple types in single
-			 * command So just take the first one will do.
-			 */
-			btdev->le_scan_type = lsp->type;
-			btdev->le_scan_own_addr_type = lsesp->own_addr_type;
+	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE ||
+			type == BTDEV_TYPE_BREDRLE50 ||
+			type == BTDEV_TYPE_BREDRLE52) {
+		btdev->crypto = bt_crypto_new();
+		if (!btdev->crypto) {
+			free(btdev);
+			return NULL;
 		}
+	}
 
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		lsese = data;
-		if (btdev->le_scan_enable == lsese->enable)
-			status = BT_HCI_ERR_COMMAND_DISALLOWED;
-		else {
-			btdev->le_scan_enable = lsese->enable;
-			btdev->le_filter_dup = lsese->filter_dup;
-			status = BT_HCI_ERR_SUCCESS;
-		}
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
+	btdev->type = type;
 
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		break;
+	btdev->manufacturer = 63;
+	btdev->revision = 0x0000;
 
-	case BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		lrbsv2.status = BT_HCI_ERR_SUCCESS;
-		lrbsv2.acl_mtu = cpu_to_le16(btdev->acl_mtu);
-		lrbsv2.acl_max_pkt = btdev->acl_max_pkt;
-		lrbsv2.iso_mtu = cpu_to_le16(btdev->iso_mtu);
-		lrbsv2.iso_max_pkt = btdev->iso_max_pkt;
-		cmd_complete(btdev, opcode, &lrbsv2, sizeof(lrbsv2));
+	switch (btdev->type) {
+	case BTDEV_TYPE_BREDRLE:
+	case BTDEV_TYPE_BREDRLE50:
+	case BTDEV_TYPE_BREDRLE52:
+		btdev->version = 0x09;
+		set_bredrle_features(btdev);
+		set_bredrle_commands(btdev);
+		set_le_states(btdev);
 		break;
-
-	case BT_HCI_CMD_LE_SET_CIG_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		memcpy(&btdev->le_cig, data, len);
-		lscp.params.status = BT_HCI_ERR_SUCCESS;
-		lscp.params.cig_id = 0x00;
-		lscp.params.num_handles = 1;
-		lscp.handle = cpu_to_le16(ISO_HANDLE);
-		cmd_complete(btdev, opcode, &lscp, sizeof(lscp));
+	case BTDEV_TYPE_BREDR:
+		btdev->version = 0x05;
+		set_bredr_features(btdev);
+		set_bredr_commands(btdev);
 		break;
-
-	case BT_HCI_CMD_LE_CREATE_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-
+	case BTDEV_TYPE_LE:
+		btdev->version = 0x09;
+		set_le_features(btdev);
+		set_le_commands(btdev);
+		set_le_states(btdev);
 		break;
-
-	case BT_HCI_CMD_LE_REMOVE_CIG:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-		memset(&btdev->le_cig, 0, sizeof(btdev->le_cig));
-		lrc.status = BT_HCI_ERR_SUCCESS;
-		lrc.cig_id = 0x00;
-		cmd_complete(btdev, opcode, &lrc, sizeof(lrc));
+	case BTDEV_TYPE_AMP:
+		btdev->version = 0x01;
+		set_amp_features(btdev);
+		set_amp_commands(btdev);
 		break;
-
-	case BT_HCI_CMD_LE_ACCEPT_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		le_cis_estabilished(btdev, BT_HCI_ERR_SUCCESS);
-
+	case BTDEV_TYPE_BREDR20:
+		btdev->version = 0x03;
+		set_bredr20_features(btdev);
+		set_bredr20_commands(btdev);
 		break;
+	}
 
-	case BT_HCI_CMD_LE_REJECT_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
-
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-
-		lrcis = data;
-		le_cis_estabilished(btdev, lrcis->reason);
-
-		break;
+	btdev->page_scan_interval = 0x0800;
+	btdev->page_scan_window = 0x0012;
+	btdev->page_scan_type = 0x00;
 
-	case BT_HCI_CMD_LE_SETUP_ISO_PATH:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
+	btdev->sync_train_interval = 0x0080;
+	btdev->sync_train_timeout = 0x0002ee00;
+	btdev->sync_train_service_data = 0x00;
 
-		lesip = (void *)data;
+	btdev->acl_mtu = 192;
+	btdev->acl_max_pkt = 1;
 
-		le_setup_iso_path(btdev, le16_to_cpu(lesip->handle),
-					lesip->direction, lesip->path);
+	btdev->iso_mtu = 251;
+	btdev->iso_max_pkt = 1;
 
-		break;
+	btdev->country_code = 0x00;
 
-	case BT_HCI_CMD_LE_REMOVE_ISO_PATH:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
+	index = add_btdev(btdev);
+	if (index < 0) {
+		bt_crypto_unref(btdev->crypto);
+		free(btdev);
+		return NULL;
+	}
 
-		lerip = data;
-		status = BT_HCI_ERR_SUCCESS;
+	get_bdaddr(id, index, btdev->bdaddr);
 
-		if (!btdev->conn || le16_to_cpu(lerip->handle) != ISO_HANDLE)
-			status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	return btdev;
+}
 
-		switch (lerip->direction) {
-		case 0x00:
-			btdev->le_iso_path[0] = 0x00;
-			break;
-		case 0x01:
-			btdev->le_iso_path[1] = 0x00;
-			break;
-		default:
-			status = BT_HCI_ERR_INVALID_PARAMETERS;
-		}
+void btdev_destroy(struct btdev *btdev)
+{
+	if (!btdev)
+		return;
 
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
+	if (btdev->inquiry_id > 0)
+		timeout_remove(btdev->inquiry_id);
 
-	case BT_HCI_CMD_LE_SET_HOST_FEATURE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE52)
-			goto unsupported;
+	bt_crypto_unref(btdev->crypto);
+	del_btdev(btdev);
 
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
+	free(btdev);
+}
 
-		break;
+bool btdev_set_debug(struct btdev *btdev, btdev_debug_func_t callback,
+			void *user_data, btdev_destroy_func_t destroy)
+{
+	if (!btdev)
+		return false;
 
-	default:
-		goto unsupported;
-	}
+	if (btdev->debug_destroy)
+		btdev->debug_destroy(btdev->debug_data);
 
-	return;
+	btdev->debug_callback = callback;
+	btdev->debug_destroy = destroy;
+	btdev->debug_data = user_data;
 
-unsupported:
-	util_debug(btdev->debug_callback, btdev->debug_data,
-			"Unsupported command 0x%4.4x\n", opcode);
-	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
+	return true;
 }
 
-static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
-						const void *data, uint8_t len)
+const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
 {
-	const struct bt_hci_cmd_create_conn *cc;
-	const struct bt_hci_cmd_disconnect *dc;
-	const struct bt_hci_cmd_create_conn_cancel *ccc;
-	const struct bt_hci_cmd_accept_conn_request *acr;
-	const struct bt_hci_cmd_reject_conn_request *rcr;
-	const struct bt_hci_cmd_auth_requested *ar;
-	const struct bt_hci_cmd_set_conn_encrypt *sce;
-	const struct bt_hci_cmd_link_key_request_reply *lkrr;
-	const struct bt_hci_cmd_link_key_request_neg_reply *lkrnr;
-	const struct bt_hci_cmd_pin_code_request_neg_reply *pcrnr;
-	const struct bt_hci_cmd_pin_code_request_reply *pcrr;
-	const struct bt_hci_cmd_remote_name_request *rnr;
-	const struct bt_hci_cmd_remote_name_request_cancel *rnrc;
-	const struct bt_hci_cmd_read_remote_features *rrf;
-	const struct bt_hci_cmd_read_remote_ext_features *rref;
-	const struct bt_hci_cmd_read_remote_version *rrv;
-	const struct bt_hci_cmd_read_clock_offset *rco;
-	const struct bt_hci_cmd_le_create_conn *lecc;
-	const struct bt_hci_cmd_le_conn_update *lecu;
-	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr;
-	const struct bt_hci_cmd_le_conn_param_req_neg_reply *lcprnr;
-	const struct bt_hci_cmd_le_set_scan_enable *lsse;
-	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
-	const struct bt_hci_cmd_le_ext_create_conn *leecc;
-	const struct bt_hci_cmd_le_create_cis *leccis;
-
-	switch (opcode) {
-	case BT_HCI_CMD_INQUIRY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		inquiry_cmd(btdev, data);
-		break;
-
-	case BT_HCI_CMD_CREATE_CONN:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		cc = data;
-		conn_request(btdev, cc->bdaddr);
-		break;
+	return btdev->bdaddr;
+}
 
-	case BT_HCI_CMD_DISCONNECT:
-		dc = data;
-		disconnect_complete(btdev, le16_to_cpu(dc->handle), dc->reason);
-		break;
+uint8_t *btdev_get_features(struct btdev *btdev)
+{
+	return btdev->features;
+}
 
-	case BT_HCI_CMD_CREATE_CONN_CANCEL:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		ccc = data;
-		conn_complete(btdev, ccc->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
-		break;
+uint8_t btdev_get_scan_enable(struct btdev *btdev)
+{
+	return btdev->scan_enable;
+}
 
-	case BT_HCI_CMD_ACCEPT_CONN_REQUEST:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		acr = data;
-		accept_conn_request_complete(btdev, acr->bdaddr);
-		break;
+uint8_t btdev_get_le_scan_enable(struct btdev *btdev)
+{
+	return btdev->le_scan_enable;
+}
 
-	case BT_HCI_CMD_REJECT_CONN_REQUEST:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		rcr = data;
-		conn_complete(btdev, rcr->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
-		break;
+void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states)
+{
+	memcpy(btdev->le_states, le_states, sizeof(btdev->le_states));
+}
 
-	case BT_HCI_CMD_LINK_KEY_REQUEST_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		lkrr = data;
-		link_key_req_reply_complete(btdev, lkrr->bdaddr, lkrr->link_key);
-		break;
 
-	case BT_HCI_CMD_LINK_KEY_REQUEST_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		lkrnr = data;
-		link_key_req_neg_reply_complete(btdev, lkrnr->bdaddr);
-		break;
+void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
+							void *user_data)
+{
+	if (!btdev)
+		return;
 
-	case BT_HCI_CMD_PIN_CODE_REQUEST_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		pcrr = data;
-		pin_code_req_reply_complete(btdev, pcrr->bdaddr, pcrr->pin_len,
-							pcrr->pin_code);
-		break;
+	btdev->command_handler = handler;
+	btdev->command_data = user_data;
+}
 
-	case BT_HCI_CMD_PIN_CODE_REQUEST_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		pcrnr = data;
-		pin_code_req_neg_reply_complete(btdev, pcrnr->bdaddr);
-		break;
+void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
+							void *user_data)
+{
+	if (!btdev)
+		return;
 
-	case BT_HCI_CMD_AUTH_REQUESTED:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		ar = data;
-		auth_request_complete(btdev, le16_to_cpu(ar->handle));
-		break;
+	btdev->send_handler = handler;
+	btdev->send_data = user_data;
+}
 
-	case BT_HCI_CMD_SET_CONN_ENCRYPT:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		sce = data;
-		if (btdev->conn) {
-			uint8_t mode;
-
-			if (!sce->encr_mode)
-				mode = 0x00;
-			else if (btdev->secure_conn_support &&
-					btdev->conn->secure_conn_support)
-				mode = 0x02;
-			else
-				mode = 0x01;
+static void num_completed_packets(struct btdev *btdev, uint16_t handle)
+{
+	if (btdev->conn) {
+		struct bt_hci_evt_num_completed_packets ncp;
 
-			encrypt_change(btdev, mode, BT_HCI_ERR_SUCCESS);
-			encrypt_change(btdev->conn, mode, BT_HCI_ERR_SUCCESS);
-		}
-		break;
+		ncp.num_handles = 1;
+		ncp.handle = cpu_to_le16(handle);
+		ncp.count = cpu_to_le16(1);
 
-	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		rnr = data;
-		name_request_complete(btdev, rnr->bdaddr, BT_HCI_ERR_SUCCESS);
-		break;
+		send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS,
+							&ncp, sizeof(ncp));
+	}
+}
 
-	case BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		rnrc = data;
-		name_request_complete(btdev, rnrc->bdaddr,
-						BT_HCI_ERR_UNKNOWN_CONN_ID);
-		break;
+static const struct btdev_cmd *default_cmd(struct btdev *btdev, uint16_t opcode,
+						const void *data, uint8_t len)
+{
+	const struct btdev_cmd *cmd;
+	uint8_t status = BT_HCI_ERR_UNKNOWN_COMMAND;
 
-	case BT_HCI_CMD_READ_REMOTE_FEATURES:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		rrf = data;
-		remote_features_complete(btdev, le16_to_cpu(rrf->handle));
-		break;
+	for (cmd = btdev->cmds; cmd->func; cmd++) {
+		if (cmd->opcode != opcode)
+			continue;
 
-	case BT_HCI_CMD_READ_REMOTE_EXT_FEATURES:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		rref = data;
-		remote_ext_features_complete(btdev, le16_to_cpu(rref->handle),
-								rref->page);
-		break;
+		status = cmd->func(btdev, data, len);
 
-	case BT_HCI_CMD_READ_REMOTE_VERSION:
-		rrv = data;
-		remote_version_complete(btdev, le16_to_cpu(rrv->handle));
 		break;
+	}
 
-	case BT_HCI_CMD_READ_CLOCK_OFFSET:
-		if (btdev->type == BTDEV_TYPE_LE)
-			return;
-		rco = data;
-		remote_clock_offset_complete(btdev, le16_to_cpu(rco->handle));
-		break;
+	if (!status)
+		return cmd;
 
-	case BT_HCI_CMD_LE_CREATE_CONN:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			return;
-		lecc = data;
-		btdev->le_scan_own_addr_type = lecc->own_addr_type;
-		le_conn_request(btdev, lecc);
-		break;
+	util_debug(btdev->debug_callback, btdev->debug_data,
+			"Unsupported command 0x%4.4x\n", opcode);
+	cmd_status(btdev, status, opcode);
 
-	case BT_HCI_CMD_LE_CONN_UPDATE:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			return;
-		lecu = data;
-		if (btdev->le_features[0] & 0x02)
-			le_conn_param_req(btdev, le16_to_cpu(lecu->handle),
-					le16_to_cpu(lecu->min_interval),
-					le16_to_cpu(lecu->max_interval),
-					le16_to_cpu(lecu->latency),
-					le16_to_cpu(lecu->supv_timeout),
-					le16_to_cpu(lecu->min_length),
-					le16_to_cpu(lecu->max_length));
-		else
-			le_conn_update(btdev, le16_to_cpu(lecu->handle),
-					le16_to_cpu(lecu->min_interval),
-					le16_to_cpu(lecu->max_interval),
-					le16_to_cpu(lecu->latency),
-					le16_to_cpu(lecu->supv_timeout),
-					le16_to_cpu(lecu->min_length),
-					le16_to_cpu(lecu->max_length));
-		break;
-	case BT_HCI_CMD_LE_CONN_PARAM_REQ_REPLY:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			return;
-		lcprr = data;
-		le_conn_update(btdev, le16_to_cpu(lcprr->handle),
-				le16_to_cpu(lcprr->min_interval),
-				le16_to_cpu(lcprr->max_interval),
-				le16_to_cpu(lcprr->latency),
-				le16_to_cpu(lcprr->supv_timeout),
-				le16_to_cpu(lcprr->min_length),
-				le16_to_cpu(lcprr->max_length));
-		break;
-	case BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			return;
-		lcprnr = data;
-		rej_le_conn_update(btdev, le16_to_cpu(lcprnr->handle),
-					le16_to_cpu(lcprnr->reason));
-		break;
-		break;
-	case BT_HCI_CMD_LE_SET_SCAN_ENABLE:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			return;
-		lsse = data;
-		if (btdev->le_scan_enable && lsse->enable)
-			le_set_scan_enable_complete(btdev);
-		break;
-	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			return;
-		lsese = data;
-		if (btdev->le_scan_enable && lsese->enable)
-			le_set_ext_scan_enable_complete(btdev);
-		break;
-	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			return;
-		leecc = data;
-		btdev->le_scan_own_addr_type = leecc->own_addr_type;
-		le_ext_conn_request(btdev, leecc);
-		break;
-	case BT_HCI_CMD_LE_CREATE_CIS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
-				btdev->type != BTDEV_TYPE_BREDRLE52)
-			return;
-		leccis = data;
-		le_cis_request(btdev, leccis);
-		break;
-	}
+	return NULL;
 }
 
 struct btdev_callback {
@@ -4259,20 +4905,26 @@ static void handler_callback(btdev_callback callback, uint8_t response,
 				uint8_t status, const void *data, uint8_t len)
 {
 	struct btdev *btdev = callback->user_data;
+	const struct btdev_cmd *cmd;
 
 	switch (response) {
 	case BTDEV_RESPONSE_DEFAULT:
 		if (!run_hooks(btdev, BTDEV_HOOK_PRE_CMD, callback->opcode,
 						callback->data, callback->len))
 			return;
-		default_cmd(btdev, callback->opcode,
+
+		cmd = default_cmd(btdev, callback->opcode,
 					callback->data, callback->len);
+		if (!cmd)
+			return;
 
 		if (!run_hooks(btdev, BTDEV_HOOK_PRE_EVT, callback->opcode,
 						callback->data, callback->len))
 			return;
-		default_cmd_completion(btdev, callback->opcode,
-					callback->data, callback->len);
+
+		if (cmd->complete)
+			cmd->complete(btdev, callback->data, callback->len);
+
 		break;
 	case BTDEV_RESPONSE_COMMAND_STATUS:
 		cmd_status(btdev, status, callback->opcode);
@@ -4291,6 +4943,7 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
 {
 	struct btdev_callback callback;
 	const struct bt_hci_cmd_hdr *hdr = data;
+	const struct btdev_cmd *cmd;
 
 	if (len < sizeof(*hdr))
 		return;
@@ -4312,14 +4965,18 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
 		if (!run_hooks(btdev, BTDEV_HOOK_PRE_CMD, callback.opcode,
 						callback.data, callback.len))
 			return;
-		default_cmd(btdev, callback.opcode,
+
+		cmd = default_cmd(btdev, callback.opcode,
 					callback.data, callback.len);
+		if (!cmd)
+			return;
 
 		if (!run_hooks(btdev, BTDEV_HOOK_PRE_EVT, callback.opcode,
 						callback.data, callback.len))
 			return;
-		default_cmd_completion(btdev, callback.opcode,
-					callback.data, callback.len);
+
+		if (cmd->complete)
+			cmd->complete(btdev, callback.data, callback.len);
 	}
 }
 
-- 
2.26.2

