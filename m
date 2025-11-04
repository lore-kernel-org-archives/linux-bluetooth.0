Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139F32B9A9
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266320; cv=none; b=mUJNqVkbOCQ52aCDF5xTSE1hA4la5KdbG4BRBDL90bIyxSy9mIaFrViNqDFnHVj1AFs4fq2lhkcCsNNEIbbdVV8LUNAlusl4eIiSfsrvMd2KULcDzyEcwkqiDvDMG7Nw9ydoFy5dDntSGAA7HY5zyVSlPwpTWmO1mJ9/ww+acZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266320; c=relaxed/simple;
	bh=v8srSNOcxIhy3QU2oUOqMwx8rLuwu6QSul/oJmMLXqM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ+I7vOmydhes1VhL5DJ4zhR5GJA5O4oi5vj+yVzyF+SuNEdFE4JvqS5Zq18GUW+LI7zrzg+N1dWSBPNiGVLVY9dR3mrHv+4bFPJA23GNf9St92EyoIpQTTqC8QfT1sMGfx1jumW+AvRvet98+eKmRhUvGwUv5aJIRjb4xjlhnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGCbM95T; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGCbM95T"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d61f261ebfso2204184137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 06:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762266316; x=1762871116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T3Fmc3daToTLb7xqnRBxlgmuZ+5MqhKAz5ltA3ZzsY=;
        b=EGCbM95TCJuHUTuBENLktDQtFEuoXVc9cYva44EzTBfb18/wLxa4ODTn3YtbfyqKNw
         SE1ltkDyVsaHO8P9LSPllxSHNBQwDztnVwKBFV5T1hoeVDqBmZHclMpKOfldUY1Q7uUQ
         StbJjgdbP51cutl3pFMfXMP58Wf3Z3skCPWuA9Eod5KAkOiYLChpX/KT03nq3bTHV84f
         GOjsu8yNZjXKso6Bxt/WxvbltAv1JPZSk5yLUgfd67InGnc+TIsd1XbboXEWCKXadmEi
         vMB2m2WUlti/zonXl6MiGLJJYV0Lmc/7F9g3AR2ph+lfq3EoDjgoDJ1yeWnoAaYc63CX
         TkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266316; x=1762871116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T3Fmc3daToTLb7xqnRBxlgmuZ+5MqhKAz5ltA3ZzsY=;
        b=NWaxAZru119OZdkQ39VAyeyTti8zrangoxCdoMyryyP3nN8ZeDWJCRzwfNeo6PJb8O
         KSpBNrwvaAfXoz5kWanmQd/GNlcZyrRY3WN97ri7amZQILt4joOy776W2VNXP1KnlG62
         JVeJRQXnkrkJFhXr/ilWzbiawwRMdXIgYSfl1O9XWoMfTlOn0BsQEEO/sqCNZY//YYj0
         92lvAb4Sc4ijimfOe2iu+reNqUORCQqVndj9BVZYmgHRT4colNudg4PgalybQmGB7fy1
         IT89iM/guZk5MW2vU4SGo/X4zzDGmcYs9Tqf8gCMMeNXMPfpfPNX+wbpJBBTb6Ar5gJt
         mm2A==
X-Gm-Message-State: AOJu0YymVQEYi8gBO1vi9bHL7sc37aCpKhoOskZi543jwF1z5sVwp3C0
	b6lS2ylGBw7VHZMa17gr4dTKp7242tHlxrE7eWQlMHKZ2ceGrzLlErMpZRXKLIkLDW8=
X-Gm-Gg: ASbGncsoGDjDYrIztaZPyKJZpuEjVCqjXVTrUcbhOxQ6xgFSWGvRbDDmFfbkDFWRphG
	9WIeNEaZwYF3wD5RZnvxJWSjGAf5FQaaN3d2rXB/UvWJ4JmrTw2cVEzcpYlCbIZpKDoNnJrGN3t
	M7Ora/RoMPZjwJW895TvTIc5aBcwUd62zktrAonUxiCT/kMRZsJcyPn17QVN1JJnq5P6qvUTcQT
	BK33IsNW+asOWg5yXlVZWU3u70MG43QslYc1UeNHWVPVAwxzkdSUeqVEL8RSmWRGF1xPIgmA5vi
	gUidmwXiJPzqS2yNgVbyeBlcVO0tCrMjPIcovtQ1PugVqIOdRru1AGQj75oL4XlsO80SFbyG+oA
	A8Dm09CzEDYoP9ZIgnJXjt/stWKu2MmfUK0Qwn1Py9hdnMq4uBMpmVC41PsuzW/9ou9UsRogavO
	Zz9/U=
X-Google-Smtp-Source: AGHT+IELjXpEwXcM2gho4B+zys/DZQdOb0M/mVf2blWMuzWSqqmwY3Wk5MABfEszwIIdPudrKREf5w==
X-Received: by 2002:a05:6102:38ca:b0:522:86ea:42c with SMTP id ada2fe7eead31-5dbb120701cmr5094522137.11.1762266316169;
        Tue, 04 Nov 2025 06:25:16 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbf31267easm1074306137.8.2025.11.04.06.25.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:25:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] emulator: Add support for LL Extended Feature Set
Date: Tue,  4 Nov 2025 09:25:05 -0500
Message-ID: <20251104142506.12356-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104142506.12356-1-luiz.dentz@gmail.com>
References: <20251104142506.12356-1-luiz.dentz@gmail.com>
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
 emulator/btdev.c  | 101 ++++++++++++++++++++++++++++++++++++++++++++--
 emulator/btdev.h  |   1 +
 emulator/hciemu.c |   3 ++
 emulator/hciemu.h |   1 +
 emulator/main.c   |   2 +-
 5 files changed, 103 insertions(+), 5 deletions(-)

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
diff --git a/emulator/btdev.h b/emulator/btdev.h
index c7b3b468ac4c..d473bd4b3414 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -52,6 +52,7 @@ enum btdev_type {
 	BTDEV_TYPE_BREDR20,
 	BTDEV_TYPE_BREDRLE50,
 	BTDEV_TYPE_BREDRLE52,
+	BTDEV_TYPE_BREDRLE60,
 };
 
 enum btdev_hook_type {
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 3521e99948d7..8c73a07eede0 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -382,6 +382,9 @@ struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num)
 	case HCIEMU_TYPE_BREDRLE52:
 		hciemu->btdev_type = BTDEV_TYPE_BREDRLE52;
 		break;
+	case HCIEMU_TYPE_BREDRLE60:
+		hciemu->btdev_type = BTDEV_TYPE_BREDRLE60;
+		break;
 	default:
 		return NULL;
 	}
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 9fbe34316f61..1164be6510a3 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -21,6 +21,7 @@ enum hciemu_type {
 	HCIEMU_TYPE_LEGACY,
 	HCIEMU_TYPE_BREDRLE50,
 	HCIEMU_TYPE_BREDRLE52,
+	HCIEMU_TYPE_BREDRLE60,
 };
 
 enum hciemu_hook_type {
diff --git a/emulator/main.c b/emulator/main.c
index bdc2f0deb738..456fcd98eed0 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -92,7 +92,7 @@ int main(int argc, char *argv[])
 	bool serial_enabled = false;
 	int letest_count = 0;
 	int vhci_count = 0;
-	enum btdev_type type = BTDEV_TYPE_BREDRLE52;
+	enum btdev_type type = BTDEV_TYPE_BREDRLE60;
 	int i;
 
 	mainloop_init();
-- 
2.51.0

