Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2379388E59
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920360; cv=none; b=kp5H8YwoSg5XDGrFJTcpv4tEwPLAIU/tnLdp7OIgVS7byEx6SFmAVkrMm/18MVtcb/UC/c5f2c3zK0P6Ix+rDasc+synFlRJzPYPhFqFKWia7iUdSVlSQaEg4CkBfbHsD00bw0bs7OktgVF7gjqr1CV3ZaPJ0R/x0E2t9ih6k/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920360; c=relaxed/simple;
	bh=9W70C79eQgUmQawhfh9tZ/xhkW3ovlnxqOvrdoOK8QY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptYXqrfCQRaok+JtNNyXGreE3qCwPE+tdSKy04R0xf918peM6Ebh01gqbk1VF3uv2hHlH2gCur9pUMdL/ul3Isvpu8QflO+z+/6g0dYJJL3hI7flYx+Vi5eY8m83CEa7LzUB5Rc7cWDGVJMp6uUe0NE9QxIYqezz4jyvOOBJyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llKoEE7N; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llKoEE7N"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso266010e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920358; x=1785525158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I2ikbyb54MQEaV5LoevLhX526SnfUQVrgPxPPfdb7no=;
        b=llKoEE7NIp5TRfH5gN4D+8MLnrY7/w3ZaD30cq4Zj4PI/zc++rchRVQzYKR6TkjaYh
         eqYO9s3lJJknGy7injQ+QEs3kLA6C4M0WhvLGm/CWkFC3TIP7FNzigAJiEtNOBgCK1Xm
         Y4+LCARdgZNvWJ5mPWvK0HxKa+0bS5gWHCADHueXpt5kN/ZFm9BZ1CPysEGj5dyKCJlt
         /g3ppf7TEn9NrKeen1MWi+goMCQ9Am6r7EG8NKZkBMM/BmwC/GM65tyYX7zURKJrwX2h
         s2/CRGLVqFBKHDLEKju/rchgQ/1b+p8eWKNwL2w+A3CTTX42r8RnKFM0NZNL20+ykj95
         6A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920358; x=1785525158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I2ikbyb54MQEaV5LoevLhX526SnfUQVrgPxPPfdb7no=;
        b=KxmJw3xtnZtqW4dFgb2OOnd/E2dFYIPspEKtXXHsQfpXmv//wL2wXa2M4P3Z/ZBX67
         IWMEJSw3eRK8yK/VnOcoIlOVAySaAz6VWN1IpJfw7VowdTZ8xGygufHAMHnsnObFDHS9
         bdyDrIpfwLiPcoxi5WccTe3qFFprigjDlcMzQ+qp8WZ4pleXhUjkTMCDKQD06t+qWFK3
         hP1dXcCsx6UDsbdHg6BzKjHkah0zmOmfSDosEpopcLwZ90/3Mmq1m20Q4dk9EdE7ijMk
         yU6dK+GbtKbTNaRQcSLa6oGyCMPNCF2PSk9bULLVKQZAqN1kC8PZmeWzkcmmZAZIg2rx
         +6zQ==
X-Gm-Message-State: AOJu0YxojaT1ZlZeZqIcEjee4ArXla5spURbJsC1aKGzblxN9hIDzoCB
	+0mtQShBClSht5HZhHKLzZP7cgNjBUO8EbfKVg4S2qIsLk4vj/03qCyJY/qir2pS
X-Gm-Gg: AR+sD125gaDE04z9J3smKoETlgRafpSiYeRFeVBVbtuDo6u5YseBY7FT19kjNnPtjTs
	5n53y1Rg9gXqZFWsVylJW4bE+kkUVNdS+IqUAdp+i+Z4Qbv1XKEyEJ9W73H/XSqZrHxoaxwO/0s
	aWLFLgyCpN33UcpZGFE96FDy8TLWHdmjNPezhz4/P6q663xNr21MIVa4JfnqCcdbJ/6g6EXKd/m
	YjN2xM5F1lOUvaVfV+VkFXP5dRCg5YApaf9RbjiKCitsWKdqpudwI722uuU1a7/0YiOFwYzKTAC
	/FB7ojz5iEoddmt3Q+57rR/D0tgyoS7vn35Q932WMZiAzz/+3URm6hNWvzhmNNZxa5onQkkHA4y
	zbLB30T3AKoomT70x4d7ZviQ9tZ0A+JfHMqPXHflgY6rDSAUfSCGr7/gXKJtINsQmAGiG4xXsC5
	u0Cx95wIPIW4CzLg139IDmVAqwICIzuKfOKGVbI3OLbKaw2R8UZ+LQll1CwDRbAlKAjqs/aJv/
X-Received: by 2002:a05:6122:1352:b0:5bd:b27c:bade with SMTP id 71dfb90a1353d-5c2da06aaeamr4320560e0c.5.1784920357669;
        Fri, 24 Jul 2026 12:12:37 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 02/12] emulator/btdev: Add emulation support for HIDS 1.1 SCI commands
Date: Fri, 24 Jul 2026 15:12:15 -0400
Message-ID: <20260724191225.1815634-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add BTDEV_TYPE_BREDRLE62 device type with support for Shorter
Connection Interval (SCI) feature from Bluetooth 6.2 spec:

 - LE Connection Rate Request (0x20a1)
 - LE Set Default Rate Parameters (0x20a2)
 - LE Read Minimum Supported Connection Interval (0x20a3)
 - LE Connection Rate Change event (0x37)
 - Shorter Connection Intervals feature bits
---
 emulator/btdev.c  | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 emulator/btdev.h  |   1 +
 emulator/hciemu.c |   3 ++
 emulator/hciemu.h |   1 +
 4 files changed, 112 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3206caf5be86..68ec9698c6bc 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7963,6 +7963,96 @@ static void set_le_60_commands(struct btdev *btdev)
 	btdev->cmds = cmd_le_6_0;
 }
 
+static int cmd_le_conn_rate(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_conn_rate *cmd = data;
+	struct bt_hci_evt_le_conn_rate_change ev;
+	struct btdev_conn *conn;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn)
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+
+	cmd_status(dev, status, BT_HCI_CMD_LE_CONN_RATE);
+
+	if (status)
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = BT_HCI_ERR_SUCCESS;
+	ev.handle = cmd->handle;
+	ev.interval = cmd->interval_min;
+	ev.subrate = cmd->subrate_min;
+	ev.latency = cpu_to_le16(0);
+	ev.cont_number = cmd->cont_num;
+	ev.supv_timeout = cmd->supv_timeout;
+
+	le_meta_event(dev, BT_HCI_EVT_LE_CONN_RATE_CHANGE, &ev, sizeof(ev));
+	if (conn->link)
+		le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CONN_RATE_CHANGE,
+				&ev, sizeof(ev));
+
+	return 0;
+}
+
+static int cmd_le_set_def_rate(struct btdev *dev, const void *data, uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_DEF_RATE, &status, sizeof(status));
+
+	return 0;
+}
+
+static int cmd_le_read_conn_interval(struct btdev *dev, const void *data,
+					uint8_t len)
+{
+	struct {
+		struct bt_hci_rsp_le_read_conn_interval rsp;
+		struct bt_hci_le_conn_interval_group grp;
+	} __attribute__ ((packed)) pdu;
+
+	memset(&pdu, 0, sizeof(pdu));
+	pdu.rsp.status = BT_HCI_ERR_SUCCESS;
+	pdu.rsp.num_grps = 1;
+	pdu.grp.min = cpu_to_le16(0x0008);	/* 1.000 ms */
+	pdu.grp.max = cpu_to_le16(0x0c80);	/* 400.000 ms */
+	pdu.grp.stride = cpu_to_le16(0x0001);	/* 0.125 ms */
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_CONN_INTERVAL, &pdu, sizeof(pdu));
+
+	return 0;
+}
+
+#define CMD_LE_62 \
+	CMD(BT_HCI_CMD_LE_CONN_RATE, cmd_le_conn_rate, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_DEF_RATE, cmd_le_set_def_rate, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_CONN_INTERVAL, cmd_le_read_conn_interval, NULL)
+
+static const struct btdev_cmd cmd_le_6_2[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_COMMON_BREDR_20,
+	CMD_COMMON_BREDR_LE_40,
+	CMD_BREDR,
+	CMD_LE,
+	CMD_LE_50,
+	CMD_LE_52,
+	CMD_LE_60,
+	CMD_LE_62,
+	{}
+};
+
+static void set_le_62_commands(struct btdev *btdev)
+{
+	btdev->commands[48] |= BIT(5);	/* LE Connection Rate Request */
+	btdev->commands[48] |= BIT(6);	/* LE Set Default Rate Parameters */
+	btdev->commands[48] |= BIT(7);	/* LE Read Min Supported Conn Interval */
+	btdev->cmds = cmd_le_6_2;
+}
+
 static void set_le_commands(struct btdev *btdev)
 {
 	set_common_commands_all(btdev);
@@ -8037,6 +8127,12 @@ static void set_le_commands(struct btdev *btdev)
 		set_le_60_commands(btdev);
 		btdev->cmds = cmd_le_6_0;
 	}
+
+	/* Extra LE commands for >= 6.2 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE62) {
+		set_le_62_commands(btdev);
+		btdev->cmds = cmd_le_6_2;
+	}
 }
 
 static void set_bredrle_commands(struct btdev *btdev)
@@ -8112,6 +8208,13 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->le_features[7] |= BIT(7); /* LL Extended Features */
 	}
 
+	if (btdev->type >= BTDEV_TYPE_BREDRLE62) {
+		/* Shorter Connection Intervals */
+		btdev->le_features[9] |= BIT(0);
+		/* Shorter Connection Intervals (Host Support) */
+		btdev->le_features[9] |= BIT(1);
+	}
+
 	btdev->feat_page_2[0] |= 0x01;	/* CPB - Central Operation */
 	btdev->feat_page_2[0] |= 0x02;	/* CPB - Peripheral Operation */
 	btdev->feat_page_2[0] |= 0x04;	/* Synchronization Train */
@@ -8217,6 +8320,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
+	case BTDEV_TYPE_BREDRLE62:
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
@@ -8240,6 +8344,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
+	case BTDEV_TYPE_BREDRLE62:
 		btdev->version = 0x09;
 		set_bredrle_features(btdev);
 		set_bredrle_commands(btdev);
@@ -8933,6 +9038,7 @@ int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode)
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
+	case BTDEV_TYPE_BREDRLE62:
 		btdev->msft_opcode = opcode;
 		btdev->msft_cmds = cmd_msft;
 		return 0;
@@ -8991,6 +9097,7 @@ int btdev_set_emu_opcode(struct btdev *btdev, uint16_t opcode)
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
+	case BTDEV_TYPE_BREDRLE62:
 		btdev->emu_opcode = opcode;
 		btdev->emu_cmds = cmd_emu;
 		return 0;
diff --git a/emulator/btdev.h b/emulator/btdev.h
index d473bd4b3414..145f7edaa262 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -53,6 +53,7 @@ enum btdev_type {
 	BTDEV_TYPE_BREDRLE50,
 	BTDEV_TYPE_BREDRLE52,
 	BTDEV_TYPE_BREDRLE60,
+	BTDEV_TYPE_BREDRLE62,
 };
 
 enum btdev_hook_type {
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 15d806a62aa6..48ed63b413f4 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -437,6 +437,9 @@ struct hciemu *hciemu_new_num_debug(enum hciemu_type type, uint8_t num,
 	case HCIEMU_TYPE_BREDRLE60:
 		hciemu->btdev_type = BTDEV_TYPE_BREDRLE60;
 		break;
+	case HCIEMU_TYPE_BREDRLE62:
+		hciemu->btdev_type = BTDEV_TYPE_BREDRLE62;
+		break;
 	default:
 		return NULL;
 	}
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index e832d6350bb3..cdf1ebe16752 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -22,6 +22,7 @@ enum hciemu_type {
 	HCIEMU_TYPE_BREDRLE50,
 	HCIEMU_TYPE_BREDRLE52,
 	HCIEMU_TYPE_BREDRLE60,
+	HCIEMU_TYPE_BREDRLE62,
 };
 
 enum hciemu_hook_type {
-- 
2.54.0

