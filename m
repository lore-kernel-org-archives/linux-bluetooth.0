Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B214884C
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199145; cv=none; b=mNZBqH5+buX7d8H3MfVUDh8dBj/PQpem65OiFaQOsrWYQKcs7RVWRThaXPk/MzWAvlJ79+C/k8YeqHp6IqLCWxaMH316Vw2mxk+FgbosIHLhv6uwvxGX7shOpABqF2MyEJEtDEBDt87xEO2I3GZuKB+4bgBr6ThWXGX+yqdOR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199145; c=relaxed/simple;
	bh=WrBSd/dQGHMoCAP9xKeWX2jrL94Qod44N0cYjPVoWhs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SRIgtHa+/0uYqapsfRRcx6V5hDAeXUkSE2yvHvSwpIe56XlI9np6ICSE1vrLcb3dbJJelwWBucMW7qLSsoE8PdC523jupllTj9B1KlJPzujzTUXOoZCl6sCIMowt3xTc1ggjIO70WMO21uocSwewDv+80MH+LTWLATWBKY2DJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EADVC6Ig; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EADVC6Ig"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5239ed6f3b3so1527510e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 10:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741199142; x=1741803942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rn4gv0n9omlMw6xnNQNX3Dsf91iiZCY+xhSLDZ3Xma8=;
        b=EADVC6Ig7s1CO0J7sqKDh0KdG24l0UdnN1WzTWxH7WQIVzaW6i8EgbTuI04LjfEQOi
         D1KGskt3IXc/QLtENIe9v13CphBW0PAaiDUfbMsOu97LiZq3EhMH52MwSNP9PU7wBaG3
         JcTDRUrU/mqEbaTUp112+A7zNEusUv5fdSNXgmfTDC6KpOWmHiHBshqw7wkQhMgAhcg0
         XMVOsmUPYFMfMgW0kHxy94HbWKwCNyf49GIoQW/YGIuOMHIZ4uoag/vhBWW8U65FuN8s
         VlTsQmveic0lI3+koeZr8rRJDp7NuL8FC9tOxhucWBGA6KM9SfzsKMvTxajvSrsizU2o
         aznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199142; x=1741803942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rn4gv0n9omlMw6xnNQNX3Dsf91iiZCY+xhSLDZ3Xma8=;
        b=lP5AIyTQPI+Rv3CowkX8LjkC8vW1MfoSz+/aLWQrVQvLT59fTU13gPTbAM2SH9jXUg
         4xhxYE9NIifPzmUWfnKwPjeIlq3tZc16AfwEg3dvobsItgxi2F/RVcatknp2HlbT8dvJ
         7yZ+LBJTthKFcYZfAPRfggnnK1pJ2QHyQyBTN+UKD2dlhiaM6LAYZA7rtBLCDzJCbY3d
         Mp8A3n1lZgdeKaJLC6GSUlDcoV2C0Vetq3G/Q5sMy/ZOj/tl0S8B9NuG/zGzFMSifafK
         0TKTYfzuEInoTK3tdAWYPVaWiDD7F796YZLPI5H0dZVEepnAwE/bjoeCJpzONy6/vOrZ
         w+vQ==
X-Gm-Message-State: AOJu0Yz709+h5cWFFNEJXlVqUv2nOlL14EuZa60hkT7ayRzK9HB0irF+
	7g/thrQehINAFYNLb90uWrhXvigpbcpApidsR4cXERxhcOZ0TofNq9dY2Q==
X-Gm-Gg: ASbGncveIb6msASYaNuiQRI5xE6Gejy2rXU19wpO8X+6fcmVjqR6APnfBGynm/+yvCe
	pHWs9Tzsmaf9Kge3HWr2/bktY7alAzdkgIoh35U9Keo6LcwvHC9EYZuLxwFmx2EPj5OvhAPnuWB
	NBRENi5wDXY9BCq00pxUEY9nC7HH1O6ENbqJclekLGVhyRgMAVqJPHKmEAM0F8VjBjMWK7+6VqX
	B21AnvfLSEI2WvflSOoE2nrbauLP3GLHWP95DxbMnOuIIr/AqgqiKzNY324MybjHt9DkC8Uznhx
	JicIfyeKhpGfgPRzz1DUs2A6Tay5xhRxpByCBojyY9abrRmUPAPVE3Sgcj7RTA7AGXuFIcT9+C1
	on8qrxEszxNZm2Q==
X-Google-Smtp-Source: AGHT+IHJM156RJxEioRJvy7SH+WGWogAaXkdmsQsbvUNquTPmFOgcExq0qsIiFtFG3aWgI94lbRTAw==
X-Received: by 2002:a05:6122:308e:b0:520:4996:7d2a with SMTP id 71dfb90a1353d-523c62ceafcmr2314915e0c.10.1741199142375;
        Wed, 05 Mar 2025 10:25:42 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5238a75e141sm1276595e0c.4.2025.03.05.10.25.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:25:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] btdev: Add support for Sync Flow Control
Date: Wed,  5 Mar 2025 13:25:38 -0500
Message-ID: <20250305182538.409019-1-luiz.dentz@gmail.com>
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
index ec52c5242df0..51cb60a41dec 100644
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

