Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2FF1EA84
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Nov 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203926; cv=none; b=N2M4uYOWaZsszrqphC/fsyFE+++IdCNnI+sNsHCbCMcjjFQqdZgWAS/dldBf6iSLRJgs+/zYBGi+RQ1YJTuhjoG6vv9Fn/Vxz0oE3uWAlNJm8S29IXBcqp84aOVBKxj4TuJMveJIdb3BSeWMCyoioU96p/ke7kp0nEMpnb4f2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203926; c=relaxed/simple;
	bh=GmK4P3AY0EUX7QHtYMuQ7VxtLXj/uArQ83T9B8H6g18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9DSB1i8wp7Y20uc2EtG2wOYDakRUILlHD6Ebm657qY4ynttOB3lVPVByYHgTIk4N8ui88Vkkqk2h1/nL7wpvmLFqErlQMF6lRYE1reGvDUwxhNyTs2Q0SlzaKvGuQMRUB0lG6+ZnnqsbdAGwdw8qOxAGejuE61DwRrpNrpS1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBKDkW3v; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBKDkW3v"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso1270053137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Nov 2025 13:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762203923; x=1762808723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFiERuPXanVZmCb3vAyMM1y7xXFkOA0Iqi7u2IcmBBA=;
        b=CBKDkW3v3dPL9Fpr6AuQKSWQwP8bk35kLH0mwHgneb97apIa6Fi+7Cl9nnYk0dH9jy
         +GpWMbIU+dNVsfQoOtj9mIJONG72qP5soo3A56vCSUOjZGTZobHLqEwno3QhtPbz8rBs
         Qi1UQ6eiP+8HfAo7uNIancORV0AiKyQwFSkMS8Dy0ghEpcQTqxJnuCHbBgYDFOhXldei
         1M+RY7hobISUKsK2ovTbgBHKHFqEQ6C1EKy2dtvJnr8Uw6w7+E8Uswd2jPX5oLstsww2
         7811/h5cWm8Gxf9/o+nIvfo2tZSKfmciLzVpNER51oJIPKUBmkcU+La01SabTY5bxt5b
         2j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203923; x=1762808723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFiERuPXanVZmCb3vAyMM1y7xXFkOA0Iqi7u2IcmBBA=;
        b=EPjNKzcTCFyvWsoxKY9lSK/3JUlFsFr02onAw1fFM7HUhs9+0/XPyoxSPk3PlMdOCC
         EWDwfvQJc8wMuRtBIsH9u39CSSud5TabFTZObPDwTMzlj8pHqrn9AobrhR7i2YkQLCPz
         DiY2EtRYj1Sl6O2HP2LdGmmt5+DmyXi5CVJLhikIz0jrmL57jE5nNh2tNQUZlCcIhS9+
         B2Th5CGmBv/tF5x9LtkekR1LjyQ8Hc4Cpf/iTnMBLpmMsvUb4nIIDwW/nr6J/hNRs3Fp
         UqtC7tOS0Vs2btl8CBmDROEezXZH4cPWe2c7ZHOpLLTM5arfZF5EuHNkO/t+kpg/cya2
         Rtow==
X-Gm-Message-State: AOJu0Yyg0AUQGOI2papruEdnD3Og/ctMfIbjpod79YKRpFBMmv7gusGn
	yYwfICa3nyraxg/IiiuVIXYxbU42YdBbr6UG4MjFgyzp8AUfUAm+GJnfRcSGwEZE
X-Gm-Gg: ASbGncuh1CzfGna8nM34EtmSRzEG2SEurvbDdd7b6It+Td/nQlBRGhsGTQmRQXGUjGV
	APY3o/rGffcD84NgEkk8fsnVjuItXFDkaPUqf8ir/2UwPUlH3wcg72jtgh5G8PUTTJuSXWreRG3
	DS854sma1d25cl4yacyCbMgfCpGAMs+xgs8okSrS077HeJ8M0m9zc6TiE/AaC/Fi5SAcC44gbbN
	RuBowGwIRF7lxQ2cLQuJMcTLSbUdWllP70eB2ThrBnMQjtCeiYPjMus8PtviHQXWula2y/ACcxo
	lYsCxaFfvoGTEaImAZXL885NzJaQEflhlTtyF7RuTJSHGiCN3snu+/gJXJ4v01UnaLy3y1A9iOq
	ZAjQncTsYM2trAae27+Zor3Sz2navjHpl7PoelzztrqeBPRH7RIE4qMJFwHZWOp3iN7XndrMzud
	a1fkk=
X-Google-Smtp-Source: AGHT+IHB9Mm12MBaC4Y9lpL+yzlgybB51d+9ZIO9/2JkYzlW3uH8c1QZHj4t0FWNSIU5UXlFSdwG7A==
X-Received: by 2002:a05:6102:c06:b0:5d5:f786:1eb4 with SMTP id ada2fe7eead31-5dbb123af46mr4169052137.13.1762203923117;
        Mon, 03 Nov 2025 13:05:23 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973bf63dbsm453983e0c.9.2025.11.03.13.05.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 13:05:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] emulator: Add support for LL Extended Feature Set
Date: Mon,  3 Nov 2025 16:05:08 -0500
Message-ID: <20251103210509.1270568-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103210509.1270568-1-luiz.dentz@gmail.com>
References: <20251103210509.1270568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for emulating LL Extended Feature Set introduced in 6.0
that adds the following:

Commands:

 - HCI_LE_Read_All_Local_Supported_­Features(0x2087)(Feature:47,1)
 - HCI_LE_Read_All_Remote_Features(0x2088)(Feature:47,2)

Events:

 - HCI_LE_Read_All_Remote_Features_Complete(0x2b)(Mask bit:42)
---
 emulator/btdev.c | 101 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c53db7040d39..839b4941ca05 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -178,7 +178,7 @@ struct btdev {
 	uint8_t  country_code;
 	uint8_t  bdaddr[6];
 	uint8_t  random_addr[6];
-	uint8_t  le_features[8];
+	uint8_t  le_features[248];
 	uint8_t  le_states[8];
 	const struct btdev_cmd *cmds;
 	uint16_t msft_opcode;
@@ -7362,6 +7362,75 @@ static const struct btdev_cmd cmd_le[] = {
 	{}
 };
 
+static int cmd_le_read_all_local_features(struct btdev *dev, const void *data,
+					uint8_t len)
+{
+	struct bt_hci_rsp_le_read_all_local_features rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	memcpy(rsp.features, dev->le_features, 248);
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES, &rsp,
+				sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_le_read_all_remote_features(struct btdev *dev, const void *data,
+					uint8_t len)
+{
+	const struct bt_hci_cmd_le_read_all_remote_features *cmd = data;
+	struct bt_hci_evt_le_read_all_remote_features_complete ev;
+	struct btdev_conn *conn;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn)
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+
+	cmd_status(dev, status, BT_HCI_CMD_LE_READ_ALL_REMOTE_FEATURES);
+
+	if (status)
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = BT_HCI_ERR_SUCCESS;
+	ev.handle = cpu_to_le16(conn->handle);
+	ev.max_pages = 1;
+	ev.valid_pages = 1;
+	memcpy(ev.features, conn->link->dev->le_features, 248);
+
+	le_meta_event(dev, BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE, &ev,
+						sizeof(ev));
+
+	return 0;
+}
+
+#define CMD_LE_60 \
+	CMD(BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES, \
+			cmd_le_read_all_local_features, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_ALL_REMOTE_FEATURES, \
+			cmd_le_read_all_remote_features, NULL)
+
+static const struct btdev_cmd cmd_le_6_0[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_LE,
+	CMD_LE_50,
+	CMD_LE_52,
+	CMD_LE_60,
+	{}
+};
+
+static void set_le_60_commands(struct btdev *btdev)
+{
+	btdev->commands[47] |= BIT(2);	/* LE Read All Local Features */
+	btdev->commands[47] |= BIT(3);	/* LE Read All Remote Features */
+	btdev->cmds = cmd_le_6_0;
+}
+
 static void set_le_commands(struct btdev *btdev)
 {
 	set_common_commands_all(btdev);
@@ -7427,6 +7496,12 @@ static void set_le_commands(struct btdev *btdev)
 		set_le_52_commands(btdev);
 		btdev->cmds = cmd_le_5_2;
 	}
+
+	/* Extra LE commands for >= 6.0 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
+		set_le_60_commands(btdev);
+		btdev->cmds = cmd_le_6_0;
+	}
 }
 
 static int cmd_set_event_mask_2(struct btdev *dev, const void *data,
@@ -7607,6 +7682,7 @@ static void set_bredrle_features(struct btdev *btdev)
 	}
 
 	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
+		btdev->version = 0x0b;
 		btdev->le_features[1] |= 0x20;  /* LE PER ADV */
 		btdev->le_features[3] |= BIT(0);  /* LE PAST Sender */
 		btdev->le_features[3] |= BIT(1);  /* LE PAST Receiver */
@@ -7617,6 +7693,11 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->le_features[4] |= 0x01;  /* LE ISO channels */
 	}
 
+	if (btdev->type >= BTDEV_TYPE_BREDRLE60) {
+		btdev->version = 0x0e;
+		btdev->le_features[7] |= BIT(7); /* LL Extended Features */
+	}
+
 	btdev->feat_page_2[0] |= 0x01;	/* CPB - Central Operation */
 	btdev->feat_page_2[0] |= 0x02;	/* CPB - Peripheral Operation */
 	btdev->feat_page_2[0] |= 0x04;	/* Synchronization Train */
@@ -7717,14 +7798,23 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	memset(btdev, 0, sizeof(*btdev));
 
-	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE ||
-			type == BTDEV_TYPE_BREDRLE50 ||
-			type == BTDEV_TYPE_BREDRLE52) {
+	switch (type) {
+	case BTDEV_TYPE_BREDRLE:
+	case BTDEV_TYPE_LE:
+	case BTDEV_TYPE_BREDRLE50:
+	case BTDEV_TYPE_BREDRLE52:
+	case BTDEV_TYPE_BREDRLE60:
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
 			return NULL;
 		}
+		break;
+	case BTDEV_TYPE_BREDR:
+	case BTDEV_TYPE_BREDR20:
+	case BTDEV_TYPE_AMP:
+	default:
+		break;
 	}
 
 	btdev->type = type;
@@ -7736,6 +7826,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	case BTDEV_TYPE_BREDRLE:
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
+	case BTDEV_TYPE_BREDRLE60:
 		btdev->version = 0x09;
 		set_bredrle_features(btdev);
 		set_bredrle_commands(btdev);
@@ -8448,6 +8539,7 @@ int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode)
 	case BTDEV_TYPE_BREDRLE:
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
+	case BTDEV_TYPE_BREDRLE60:
 		btdev->msft_opcode = opcode;
 		btdev->msft_cmds = cmd_msft;
 		return 0;
@@ -8505,6 +8597,7 @@ int btdev_set_emu_opcode(struct btdev *btdev, uint16_t opcode)
 	case BTDEV_TYPE_BREDRLE:
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
+	case BTDEV_TYPE_BREDRLE60:
 		btdev->emu_opcode = opcode;
 		btdev->emu_cmds = cmd_emu;
 		return 0;
-- 
2.51.0

