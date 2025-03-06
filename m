Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6B26E655
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289021; cv=pass; b=j5QOYSEB7dmTaGGRvrQiZvahp8HusANvuCuUKQoysSACSLDzEYyEOyXmbwFYCoRK7qNFaJILvPGXupRU7agriDlQEOlGmk07p/ZlUOlDSvjFhfmsSzDVMqmC1xa9kL3bi21RjfPnhrcLYWNtXS1fDCEsrNNPG4OHdAipqSOBiAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289021; c=relaxed/simple;
	bh=PljnouekeveuTof1Nrr2RxdvLW2WUW73t7pglHwvP4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJkCfZD/IJlgwqQ/IG5tmQD0nooLdfwcYE/2MGTYfu/6fb3tca5AWflGlXxGlWjX3Vx/5QnvOSVnLD7vpc9NrdH3nVJwFSnMUjQxJ73pWRdz1RWd9PEz8cCWbMnbPMcLAXruRy/14xYB9yzYwemRPxkJS/fLbRZ1RKXvMz8rk+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=RgFwBghE; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="RgFwBghE"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z7zqC53jGz49Q3S;
	Thu,  6 Mar 2025 21:23:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741289015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5F8lP7qMDyK1Fdy9BgP50276riXEwGataBoK2OMynf8=;
	b=RgFwBghEzducNDRmjp7QBx9stHvRaJ5bmbSRifZk9PPzrqv8ig2hMpvFoAdUZCmNjzaCij
	VDozQjYsa6kioxjcgm65+qFUjeBdmbuR5RiL5wXKexFNn3QWkx7Rma2+aQwGb8TNg2a2Ao
	UoKIaNTQZwTHLTyYbkYULxan6j2opdLajeg3BAQfTPVzXIt7q3sN22nKXzXe+CA65STsxr
	VysYkr7RCydxLnRbgWYucTHu8afNPl4gZVOWsVeZJrHYdIRuukEylna47QRK0GR25bP4ba
	W4XKWjfnok5NyFuB5VBG+Srh9W3NGn8Q6YTHr00t6aMTWUEtFoPCwnCFqtPTLw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741289015; a=rsa-sha256;
	cv=none;
	b=lnKrAswoCQ5VVzKoEYX8Av1DzmmEGl9TtB3zebPi23Z+p48okoWKNEEdYt+IBlTnhr3E8t
	n9Sdjjg0wP4FCm5NFWyP+SAuCAYLlGeWqWLMSD4y8JpmQMLfkhQ9j5cYXOumS4uNzuMhWl
	DgMIjFisIvdRUFYiIBzrtwe5TDSYoED1ry2s0bCyjuKhKAiXNTG2+qnSy7yEifkdOsWmkQ
	HcVBEaeJmTkbY5dQJ1f5GrcMPAZPo/3cEb+SjoDf3GZqRVF/5x3UfpkwJkvS69Ka8dbGwG
	TmjVHsOG4lPst2wP4+iiEhSkoTvAUxQy1QvmBSmBfwnti7X6y01jQz6kV75B4w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741289015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5F8lP7qMDyK1Fdy9BgP50276riXEwGataBoK2OMynf8=;
	b=qd+XcIdRAAXHpXifICvZXkBMYeAI+9x33yTmUfpznqECJU5tR8d2twSP5cBkpl6RTrR9QA
	sfVDdPODKwUb4/l/encwYM+tyjUrsqaDyC2IAYJiEb2Nb6c/BNhVosiKep/7wEMyNOfLwG
	kZ6hXBjbTQGE5oAR1iYdtdgNi4MVUQTA8B0V+Oni7YNJXysXMADgi9sijS2HdAZbZYSbCY
	mfOo9bYl+wwgvlHHoS66U0AGryRk+y89awlr5E2Qq0W007V/LRPYDLNSzues8oRBoSRVut
	/hRqz6iTsNsc9HfCwOz/CEq0PqILlFsMoSXjmVzzoeINu6B8jFmBwd595sDbwQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/6] btdev: Add support for Sync Flow Control
Date: Thu,  6 Mar 2025 21:23:13 +0200
Message-ID: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
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
index ec52c5242..51cb60a41 100644
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

