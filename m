Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE81607A4
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370527; cv=pass; b=uc7+ia4hnsyVTLIbcy44hBxtwlFuKrhV9zIP3ZVLNcaVsleNwKpHYikMjCM3fHUfBytGc56VGOKpCtmTp852yqOdJqiz5d/tVOP1bo+9Pz7dvt7AwmpajyJ1ULBpvRx4EXMOqhDHlsczRXV5yUuAzxpa6m3ywCl0n4CC91jEjI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370527; c=relaxed/simple;
	bh=P4m1MKQuQvSe+2Vs/2C4cApBw6TtxxPt4pwfvA8KHHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zd31UhPrTTTK+cVHINyDIiWK9SBrLb+kYCvsNnvTnYtDaGRX50nLchuomZ+SNWsDXOAs7pe8UhU6Q5Y/cRW+mKzhXqDF6LQOuolJ4Mo9GRYYBaMTna00JoYpUIokWnbAM26Vau9EF/WUkqmCyw/1p0L93LoHzipksPmMFO4z8FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VTYCLhOo; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VTYCLhOo"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Z8YyT1w9xzyRf;
	Fri,  7 Mar 2025 20:01:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1741370514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RSpVstkCNR6LOSw/Xo8iV2GsAxCL5LN5m23JRTo8o1E=;
	b=VTYCLhOoIqr4CeAAPHWJ5UUSV/Abf/orxAONNZN2YpwaPv2y8V3l53iW+mlTqTKBSsR8UY
	nPzV3mGEtzgcEJujWGRbWsrVg/KliMcB7+tHumj0yIIbrILviuM+0RkKMFApgFFxBZaGrH
	EmTsRqwvSQgooL9kzUyLtgHKBXhDZZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1741370514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RSpVstkCNR6LOSw/Xo8iV2GsAxCL5LN5m23JRTo8o1E=;
	b=wW/HNSTm/Yvadn+SWy7sBdraOHHQtZuF3mEItIvLoVV+LgTAMQN8jpAtWyVmdj1+OLcIJC
	bjw6Tl91bxYV/3l0mXen2BfJdLJdOGCXgQGpZGbibOWsivUPA8GlPMekDmNidJQeMzfaTb
	1je3VHaK6bPkLhpSedGIoLVdvMvgGvA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1741370514; a=rsa-sha256; cv=none;
	b=dVgpbem0C417e7KglFGtVv3mdfjESkaLDlG7P+c2MLk14pZiUcxgR1oPNAnrqMxAJY8vke
	3zMmptnuv+J8u8mcVK40jIqeJ0h85/OWeE7Wm5FZfAI9hH4G0ZzWiVoBm99e8nR9GQ/0+r
	BlXcJhhjeANg/Kn5nIgjcMnf6xStKh0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 1/6] btdev: Add support for Sync Flow Control
Date: Fri,  7 Mar 2025 20:00:54 +0200
Message-ID: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Sync Flow Control by supporting command
Write Sync Flow Control Enable:

< HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
        Flow control: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4
        Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
        Status: Success (0x00)

To act according to the spec this enabled SCO data packets to be
properly processed and generate Number of Completed Packets event:

sco-tester[40]: < SCO Data TX:.. flags 0x00 dlen 9
> HCI Event: Number of Completed P.. (0x13) plen 5
	Num handles: 1
        Handle: 42 Address: 00:AA:01:01:00:00 (Intel Corporation)
---
 emulator/btdev.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 77d44ad84..713ec7acb 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -203,6 +203,7 @@ struct btdev {
 	uint8_t  ssp_debug_mode;
 	uint8_t  secure_conn_support;
 	uint8_t  host_flow_control;
+	uint8_t  sco_flowctl;
 	uint8_t  le_supported;
 	uint8_t  le_simultaneous;
 	uint8_t  le_event_mask[8];
@@ -2398,6 +2399,20 @@ static int cmd_read_tx_power_level(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static int cmd_write_sync_flowctl(struct btdev *dev, const void *data,
+				   uint8_t len)
+{
+	const struct bt_hci_cmd_write_sync_flow_control *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->sco_flowctl = cmd->enable;
+
+	cmd_complete(dev, BT_HCI_CMD_WRITE_SYNC_FLOW_CONTROL, &status,
+							sizeof(status));
+
+	return 0;
+}
+
 static int cmd_read_num_iac(struct btdev *dev, const void *data, uint8_t len)
 {
 	struct bt_hci_rsp_read_num_supported_iac rsp;
@@ -2676,6 +2691,7 @@ static int cmd_enable_dut_mode(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_READ_VOICE_SETTING, cmd_read_voice, NULL), \
 	CMD(BT_HCI_CMD_WRITE_VOICE_SETTING, cmd_write_voice, NULL), \
 	CMD(BT_HCI_CMD_READ_TX_POWER, cmd_read_tx_power_level, NULL), \
+	CMD(BT_HCI_CMD_WRITE_SYNC_FLOW_CONTROL, cmd_write_sync_flowctl, NULL), \
 	CMD(BT_HCI_CMD_READ_NUM_SUPPORTED_IAC, cmd_read_num_iac, NULL), \
 	CMD(BT_HCI_CMD_READ_CURRENT_IAC_LAP, cmd_read_current_iac_lap, \
 					NULL), \
@@ -2739,6 +2755,7 @@ static void set_common_commands_bredr20(struct btdev *btdev)
 	btdev->commands[9]  |= 0x04;	/* Read Voice Setting */
 	btdev->commands[9]  |= 0x08;	/* Write Voice Setting */
 	btdev->commands[10] |= 0x04;	/* Read TX Power Level */
+	btdev->commands[10] |= BIT(4);	/* Write Sync Flow Control */
 	btdev->commands[11] |= 0x04;	/* Read Number of Supported IAC */
 	btdev->commands[11] |= 0x08;	/* Read Current IAC LAP */
 	btdev->commands[11] |= 0x10;	/* Write Current IAC LAP */
@@ -7655,6 +7672,31 @@ static void send_acl(struct btdev *dev, const void *data, uint16_t len)
 	send_packet(conn->link->dev, iov, 3);
 }
 
+static void send_sco(struct btdev *dev, const void *data, uint16_t len)
+{
+	struct bt_hci_acl_hdr *hdr;
+	struct iovec iov[2];
+	struct btdev_conn *conn;
+	uint8_t pkt_type = BT_H4_SCO_PKT;
+
+	/* Packet type */
+	iov[0].iov_base = &pkt_type;
+	iov[0].iov_len = sizeof(pkt_type);
+
+	iov[1].iov_base = hdr = (void *) (data);
+	iov[1].iov_len = len;
+
+	conn = queue_find(dev->conns, match_handle,
+					UINT_TO_PTR(acl_handle(hdr->handle)));
+	if (!conn)
+		return;
+
+	if (dev->sco_flowctl)
+		num_completed_packets(dev, conn->handle);
+
+	send_packet(conn->link->dev, iov, 2);
+}
+
 static void send_iso(struct btdev *dev, const void *data, uint16_t len)
 {
 	struct bt_hci_acl_hdr *hdr;
@@ -7702,6 +7744,9 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 	case BT_H4_ACL_PKT:
 		send_acl(btdev, data + 1, len - 1);
 		break;
+	case BT_H4_SCO_PKT:
+		send_sco(btdev, data + 1, len - 1);
+		break;
 	case BT_H4_ISO_PKT:
 		send_iso(btdev, data + 1, len - 1);
 		break;
-- 
2.48.1

