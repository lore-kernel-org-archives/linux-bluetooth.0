Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744396;
	b=XRf+fhZTsSVFeDzZmdbgKz8XE1BSgLmnGBV9YrDsu+zKNNXxlJWMvJzpyeTeZ32kfjVt
	 x5pChTAF5uff7jEGYHmNE2HDn5RpmxG6rc0q/FvDpffJ5FVJ6ZdaPwiQYVbOt/2WwrE9q
	 H9/5SbD/gwk50/LlYgJr4OCKrArHK8kTa/qRvGgF63EtiaYk+jYIyllvDsiricJTfZqHp
	 KfaU1bwcGjJG0VXuwQs7a8QKzosQB+rK9QtJpxhsFlml4ZFrBLAzqdL9NL6lFIEPaKMWh
	 36qnfeV9+3RE7GEYMpVTHgXMXFFIUy2O25uS1j+/Ix3zC1g62Hp/TQhVPpRDEy3Cnhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f2bKMXw7lzasZpXTJE66frbk0MRxaifn0ht2WTx5MPE=;
	b=S0r94BGMgwsQoMZrHLoa2H81yB9SMyDK7NXNc2rbtfgMc/9Z3ZAxLK79JjxMexGG7JA4
	 XAE++zWCJOW6nZ2LVMmYTBgj5qLI//NWjOcbhcrMH630JyzkYz30vtiidX6MAdB37l0rA
	 EbPWy7MTnGempPvhJXHz5pmi0Ft3KLv5YXJbr8yJIFdUl3RnYWUiJQoncFxMjclgJr56l
	 9FCwCi7eXo8ZhylHrm6gV8GC1k7lNAceCwzavsVhCl0iBX8TsqTn+rqFsfLlD470kDFwv
	 OxilhGO07FX89cVcKKKNHXcDQ8MlJ7jdkrxaZ4peUwqbZX1ZHFHcPCGuZgKJH4ORGwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJBBgQST;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68325606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68325606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJBBgQST
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so10718137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744394; x=1794349194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2bKMXw7lzasZpXTJE66frbk0MRxaifn0ht2WTx5MPE=;
        b=UJBBgQSTuVfLb9j6JEggWz+uC5nODOOHMLzIxUhQWdZPCG3X5sYoviflLp93TrLR+U
         kZ670CQrh/xAixvotbFdpdJHbq2trlo40+zsGrO6IXxbTKQNQOG9zBq+4uAltFfb3GP3
         MUTP/JrzWTt89wmPp9ln7WImlrEVuOwvOSps39XDiLPEwhtcDl3qhgrpTkxMs1atLEjk
         QvBOTkTop+nG9oimBo8DagzFNBJuiQAOR77xQpBFKK9O8v7gfyG+WaAMxYk/VW1XKsaq
         NR4GEYsH3nVaSIgf4wRgcTN1mMRTv1bisI3FuwSUWrkV8MoKcuDTmoc9fPAI/R93h0qq
         dhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744394; x=1794349194;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2bKMXw7lzasZpXTJE66frbk0MRxaifn0ht2WTx5MPE=;
        b=JWH62EBvLyolwOcxkLBPpA5j9jD3BhSTpeFIwzzXOgPzMFufyRaIYKShGf/E0ivng5
         6tSc7kTwFEleLz0GUnsNrTlIVZvX3ZHHkvnsxoGYKFtUa2xYosuENkm7xV2ByJLo7ln3
         ZU1Rfqha5k4VUgMlYufI5o+D4Fv17ZIUM9X030Dh4v0oA77Ia7orVORR5oAtHX0mjosx
         DbwQz8M+AkpUD1JlunfOxbAkpL8+sMSPyCf9zZc/NvABuFoJlBgXamC71x2wyGE46cfI
         duveK6IDkv1WGN9DlA2XmKSjQKnDzPC1I6mgmy12JNdikSbDaQBUma6RkM5x12/9wPcV
         MfKw==
X-Gm-Message-State: APuU4Z/jp933eb8XmajuX6uVX1FjaNuytQo8pIEqLu88n0SkQ+FS0Xuj
	WrJihBpPY2M/FhuWFFz+1/TOfoh3DssYnEoX4/VOSGNzznmZhtqIJuXGT8sXqA==
X-Gm-Gg: AYBFou2A3KQxkkyFsSME3SjCZwh5VBm+MfIF2V3c5jw3xm7G7yILf1l2VX/PRuht6dV
	2/FLevBL8H52ebw6hIA7HbkhDjPhbd+NdY37uwNsBVeT2kw1DTBlq9ulkB3ihEz89nkZVE/096l
	2cWvuqtGT4/AypMBUrTH28tepV/WOsqWj/RuBWQ5BmOH/ExRHtSx8SmN29VM7DUBMNnofLG2ftD
	Vg3LMIHORFotwO8mKH3Cg25JAc0OZ1Ov6NxtV4DLPH0YPqkzzhCZAQxCspcetXEItBLeCa7EFV/
	dO8u2FtFL8Gz70AfmGROpIci9N1pcOJK4Gd+E12ftlLrXpzCs8zlQaEiN9c6I3f31tpoRl4I6sw
	84WAkryAEp3PnY/KprvxqNBhKzpUHbEAAIr5tmLE1W58RonyQ1thsVgpOK9LnML5WJFGIV8unzC
	703Sqo1q/Auc63UIcZxjDbAVdSV0cxPjKRaGnmlD3EpdveBC2VVbVCBXNeMd5RKYruofWAg0Xze
	WgIkR2uVyOTpXje19nvHdrSL3jP8FuiEqy5krbbyMF4c+siOa7GUyGL4GLUAmLpItAWf4z4HCsU
	X2G4xaE157pg0J+j1YUTkjJrr7uasQuDGjKf926dZSrt6RXE9iFsXzTSra37bhsdATseoAT2e2w
	wO9H3TdlsieBTy/VM6MpO56oDGwPO0er4KFdjnBtMoczsh3J9lWu3tTRFhNGTWuvN98ZL/he9lH
	R7jYg=
X-Received: by 2002:a05:6102:8616:20b0:7d2:7266:2c8f with SMTP id ada2fe7eead31-7d272662f33mr15945137.23.1793744393960;
        Tue, 03 Nov 2026 14:19:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.19.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/9] emulator: Add HDT support to btdev
Date: Tue,  3 Nov 2026 17:19:38 -0500
Message-ID: <20261103221944.4072041-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221944.4072041-1-luiz.dentz@gmail.com>
References: <20261103221944.4072041-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add a Bluetooth 7.0 controller type, BTDEV_TYPE_BREDRLE70, which
advertises the HDT and EKS feature bits and supported commands and
implements the HDT commands and events: LE Enable Encryption v2 with
MIC length negotiation, Read/Write Suggested Default Data Length v2,
Read Maximum Data Length v2, Set Data Length v2, Set CIG Parameters v2,
Create BIG v2, Set HDT Default Parameters, CIS Established v3, Create BIG
Complete v2 and the EKS Opportunistic Encryption host feature. Make it
the default for btvirt.

Assisted-by: OpenCode:claude-opus-5
---
 emulator/btdev.c  | 816 ++++++++++++++++++++++++++++++++++++++++++++--
 emulator/btdev.h  |   1 +
 emulator/hciemu.c |   3 +
 emulator/hciemu.h |   1 +
 emulator/main.c   |   5 +-
 5 files changed, 788 insertions(+), 38 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7a8d8a4645f6..741c650b7ddb 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -84,10 +84,14 @@ struct hook {
 struct btdev_conn {
 	uint16_t handle;
 	uint8_t  type;
+	uint8_t  tx_phy;
+	uint8_t  rx_phy;
+	uint8_t  mic_len;
 	uint8_t  past_mode;
 	struct btdev *dev;
 	struct btdev_conn *link;
 	struct queue *links;
+	size_t data_len;
 	void *data;
 };
 
@@ -143,7 +147,11 @@ struct le_big {
 
 struct le_cig {
 	struct bt_hci_cmd_le_set_cig_params params;
-	struct bt_hci_cis_params cis[CIS_SIZE];
+	union {
+		struct bt_hci_cis_params cis_v1[CIS_SIZE];
+		struct bt_hci_cis_params_v2 cis_v2[CIS_SIZE];
+	};
+	uint8_t version;
 	bool activated;
 } __attribute__ ((packed));
 
@@ -258,8 +266,13 @@ struct btdev {
 	uint8_t  le_pa_data_len;
 	uint8_t  le_pa_data[MAX_PA_DATA_LEN];
 	uint8_t  le_ltk[16];
+	uint8_t  hdt_def_mic_len;
+	uint8_t  hdt_def_format;
+	uint16_t hdt_def_rates;
 	struct le_cig le_cig[CIG_SIZE];
 	uint8_t  le_iso_path[2];
+	uint8_t  le_def_tx_phys;
+	uint8_t  le_def_rx_phys;
 
 	uint8_t  le_rl_enable;
 
@@ -1263,7 +1276,7 @@ static struct btdev_conn *conn_add_cis(struct btdev_conn *acl, uint16_t handle)
 }
 
 static struct btdev_conn *conn_add_bis(struct btdev *dev, uint16_t handle,
-						const struct bt_hci_bis *bis)
+						const void *bis, size_t len)
 {
 	struct btdev_conn *conn;
 
@@ -1271,7 +1284,8 @@ static struct btdev_conn *conn_add_bis(struct btdev *dev, uint16_t handle,
 	if (!conn)
 		return conn;
 
-	conn->data = util_memdup(bis, sizeof(*bis));
+	conn->data_len = len;
+	conn->data = util_memdup(bis, len);
 
 	return conn;
 }
@@ -1309,7 +1323,7 @@ static struct btdev_conn *conn_link_bis(struct btdev *dev, struct btdev *remote,
 	if (!bis)
 		return NULL;
 
-	conn = conn_add_bis(dev, BIS_HANDLE, bis->data);
+	conn = conn_add_bis(dev, BIS_HANDLE, bis->data, bis->data_len);
 	if (!conn)
 		return NULL;
 
@@ -2057,14 +2071,50 @@ static int cmd_set_conn_encrypt(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static void encrypt_change_v3(struct btdev_conn *conn, uint8_t mode,
+				uint8_t eks_mode, uint8_t status)
+{
+	struct bt_hci_evt_encrypt_change_v3 ev;
+
+	if (!conn)
+		return;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.status = status;
+	ev.handle = cpu_to_le16(conn->handle);
+	ev.mode = mode;
+
+	switch (eks_mode) {
+	case 0x00: /* EKS disabled */
+	case 0x01: /* EKS enabled */
+		ev.key_size = 16;
+		break;
+	case 0x02: /* EKS opportunistic */
+		ev.key_size = 0;
+		break;
+	}
+
+	ev.key_size = 16;
+	ev.mic_len = conn->mic_len;
+
+	send_event(conn->dev, BT_HCI_EVT_ENCRYPT_CHANGE_V3, &ev, sizeof(ev));
+}
+
 static void encrypt_change(struct btdev_conn *conn, uint8_t mode,
-					uint8_t status)
+				uint8_t eks_mode, uint8_t status)
 {
 	struct bt_hci_evt_encrypt_change ev;
 
 	if (!conn)
 		return;
 
+	/* Check if BT_HCI_EVT_ENCRYPT_CHANGE_V3 has been enabled in the event
+	 * mask page 2.
+	 */
+	if (conn->dev->event_mask_page2[3] & BIT(2))
+		return encrypt_change_v3(conn, mode, eks_mode, status);
+
 	memset(&ev, 0, sizeof(ev));
 
 	ev.status = status;
@@ -2094,8 +2144,8 @@ static int cmd_set_conn_encrypt_complete(struct btdev *dev, const void *data,
 	else
 		mode = 0x01;
 
-	encrypt_change(conn, mode, BT_HCI_ERR_SUCCESS);
-	encrypt_change(conn->link, mode, BT_HCI_ERR_SUCCESS);
+	encrypt_change(conn, mode, 0x00, BT_HCI_ERR_SUCCESS);
+	encrypt_change(conn->link, mode, 0x00, BT_HCI_ERR_SUCCESS);
 
 	return 0;
 }
@@ -4874,8 +4924,11 @@ static int cmd_ltk_reply(struct btdev *dev, const void *data, uint8_t len)
 		mode = 0x01;
 	}
 
-	encrypt_change(conn, mode, status);
-	encrypt_change(conn->link, mode, status);
+	/* Pass eks_mode as 0x01 for EKS enabled since only in case of V3 being
+	 * enabled it will get used.
+	 */
+	encrypt_change(conn, mode, 0x01, status);
+	encrypt_change(conn->link, mode, 0x01, status);
 
 	return 0;
 }
@@ -4900,7 +4953,7 @@ static int cmd_ltk_neg_reply(struct btdev *dev, const void *data, uint8_t len)
 	rp.status = BT_HCI_ERR_SUCCESS;
 	cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, &rp, sizeof(rp));
 
-	encrypt_change(conn->link, 0x00, BT_HCI_ERR_PIN_OR_KEY_MISSING);
+	encrypt_change(conn->link, 0x00, 0x00, BT_HCI_ERR_PIN_OR_KEY_MISSING);
 
 	return 0;
 }
@@ -5000,6 +5053,34 @@ static int cmd_conn_param_neg_reply_complete(struct btdev *dev,
 	return 0;
 }
 
+static int cmd_le_read_def_data_len(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	struct bt_hci_rsp_le_read_default_data_length rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.tx_len = cpu_to_le16(0x001b);
+	rsp.tx_time = cpu_to_le16(0x0148);
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_DEFAULT_DATA_LENGTH, &rsp,
+						sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_le_write_def_data_len(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_WRITE_DEFAULT_DATA_LENGTH, &status,
+						sizeof(status));
+
+	return 0;
+}
+
 static int cmd_read_local_pk256(struct btdev *dev, const void *data,
 						uint8_t len)
 {
@@ -5011,6 +5092,24 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 	return -ENOTSUP;
 }
 
+static int cmd_le_read_max_data_len(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	struct bt_hci_rsp_le_read_max_data_length rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.max_tx_len = cpu_to_le16(0x00fb);
+	rsp.max_tx_time = cpu_to_le16(0x4290);
+	rsp.max_rx_len = cpu_to_le16(0x00fb);
+	rsp.max_rx_time = cpu_to_le16(0x4290);
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_MAX_DATA_LENGTH, &rsp,
+						sizeof(rsp));
+
+	return 0;
+}
+
 #define CMD_LE \
 	CMD(BT_HCI_CMD_READ_LE_HOST_SUPPORTED, cmd_read_le_host_supported, \
 					NULL), \
@@ -5055,6 +5154,10 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 					cmd_conn_param_reply_complete), \
 	CMD(BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY, cmd_conn_param_neg_reply, \
 					cmd_conn_param_neg_reply_complete), \
+	CMD(BT_HCI_CMD_LE_READ_DEFAULT_DATA_LENGTH, cmd_le_read_def_data_len, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_WRITE_DEFAULT_DATA_LENGTH, \
+					cmd_le_write_def_data_len, NULL), \
 	CMD(BT_HCI_CMD_LE_READ_LOCAL_PK256, cmd_read_local_pk256, NULL), \
 	CMD(BT_HCI_CMD_LE_GENERATE_DHKEY, cmd_gen_dhkey, NULL), \
 	CMD(BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST, cmd_add_rl,  NULL), \
@@ -5065,7 +5168,9 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 	CMD(BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR, cmd_read_local_rl_addr, \
 					NULL), \
 	CMD(BT_HCI_CMD_LE_SET_RESOLV_ENABLE, cmd_set_rl_enable, NULL), \
-	CMD(BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT, cmd_set_rl_timeout, NULL)
+	CMD(BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT, cmd_set_rl_timeout, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_MAX_DATA_LENGTH, cmd_le_read_max_data_len, \
+					NULL) \
 
 static const struct btdev_cmd cmd_bredr_le[] = {
 	CMD_COMMON_ALL,
@@ -5096,16 +5201,20 @@ static int cmd_set_default_phy(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_le_set_default_phy *cmd = data;
-	uint8_t status;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
 	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
-			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!cmd->tx_phys || cmd->tx_phys > 0x17)) ||
 			(!(cmd->all_phys & 0x02) &&
-			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+			(!cmd->rx_phys || cmd->rx_phys > 0x17))) {
 		status = BT_HCI_ERR_INVALID_PARAMETERS;
-	else
-		status = BT_HCI_ERR_SUCCESS;
+		goto done;
+	}
 
+	dev->le_def_tx_phys = cmd->tx_phys;
+	dev->le_def_rx_phys = cmd->rx_phys;
+
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_DEFAULT_PHY, &status,
 					sizeof(status));
 
@@ -5127,9 +5236,9 @@ static int cmd_le_set_phy(struct btdev *dev, const void *data,
 	}
 
 	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
-			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!cmd->tx_phys || cmd->tx_phys > 0x17)) ||
 			(!(cmd->all_phys & 0x02) &&
-			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+			(!cmd->rx_phys || cmd->rx_phys > 0x17)))
 		status = BT_HCI_ERR_INVALID_PARAMETERS;
 	else
 		status = BT_HCI_ERR_SUCCESS;
@@ -5153,9 +5262,9 @@ static int cmd_le_set_phy_complete(struct btdev *dev, const void *data,
 		return 0;
 
 	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
-			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!cmd->tx_phys || cmd->tx_phys > 0x17)) ||
 			(!(cmd->all_phys & 0x02) &&
-			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+			(!cmd->rx_phys || cmd->rx_phys > 0x17)))
 		return 0;
 
 	memset(&ev, 0, sizeof(ev));
@@ -5169,19 +5278,32 @@ static int cmd_le_set_phy_complete(struct btdev *dev, const void *data,
 		ev.rx_phy = 0x01; /* LE 1M PHY */
 
 	if (cmd->tx_phys & BIT(1))
-		ev.tx_phy |= 0x02; /* LE 2M PHY */
+		ev.tx_phy = 0x02; /* LE 2M PHY */
 
 	if (cmd->rx_phys & BIT(1))
-		ev.rx_phy |= 0x02; /* LE 2M PHY */
+		ev.rx_phy = 0x02; /* LE 2M PHY */
 
 	if (cmd->tx_phys & BIT(2))
-		ev.tx_phy |= 0x03; /* LE CODED PHY */
+		ev.tx_phy = 0x03; /* LE CODED PHY */
 
 	if (cmd->rx_phys & BIT(2))
-		ev.rx_phy |= 0x03; /* LE CODED PHY */
+		ev.rx_phy = 0x03; /* LE CODED PHY */
+
+	if (cmd->tx_phys & BIT(4))
+		ev.tx_phy = 0x05; /* HDT PHY */
+
+	if (cmd->rx_phys & BIT(4))
+		ev.rx_phy = 0x05; /* HDT PHY */
 
 	le_meta_event(dev, BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE, &ev, sizeof(ev));
 
+	if (conn->link) {
+		ev.handle = cpu_to_le16(conn->link->handle);
+		le_meta_event(conn->link->dev,
+				BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE, &ev,
+				sizeof(ev));
+	}
+
 	return 0;
 }
 
@@ -5814,7 +5936,9 @@ static uint8_t bits_to_phy(uint8_t bits)
 {
 	uint8_t phy = 0x00;
 
-	/* Convert PHY bits to PHY values on a ascending order. */
+	/* Convert PHY bits to PHY values on a ascending order so if HDT bit is
+	 * set it takes precedence over LE 2M and LE 1M.
+	 */
 	if (bits & BIT(0))
 		phy = 0x01; /* LE 1M */
 
@@ -5824,6 +5948,9 @@ static uint8_t bits_to_phy(uint8_t bits)
 	if (bits & BIT(2))
 		phy = 0x03; /* LE Coded */
 
+	if (bits & BIT(4))
+		phy = 0x05; /* HDT */
+
 	return phy;
 }
 
@@ -6155,6 +6282,50 @@ static void ext_adv_term(void *data, void *user_data)
 	}
 }
 
+static void le_phy_update_event(struct btdev_conn *conn, uint8_t tx_phy,
+							uint8_t rx_phy)
+{
+	struct bt_hci_evt_le_phy_update_complete ev;
+
+	if (!conn || !tx_phy || !rx_phy)
+		return;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.handle = cpu_to_le16(conn->handle);
+	ev.tx_phy = tx_phy;
+	ev.rx_phy = rx_phy;
+
+	le_meta_event(conn->dev, BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE,
+					&ev, sizeof(ev));
+
+	ev.handle = cpu_to_le16(conn->link->handle);
+	le_meta_event(conn->link->dev, BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE,
+					&ev, sizeof(ev));
+}
+
+static void le_phy_update(struct btdev_conn *conn)
+{
+	uint8_t tx_phy = 0x01, rx_phy = 0x01;
+
+	/* Use HDT PHY if both sides support it */
+	if (conn->dev->le_def_tx_phys & BIT(4) &&
+			conn->link->dev->le_def_tx_phys & BIT(4))
+		tx_phy = 0x05; /* HDT */
+	else if (conn->dev->le_def_tx_phys & BIT(2) &&
+			conn->link->dev->le_def_tx_phys & BIT(2))
+		tx_phy = 0x02; /* LE 2M */
+
+	if (conn->dev->le_def_rx_phys & BIT(4) &&
+			conn->link->dev->le_def_rx_phys & BIT(4))
+		rx_phy = 0x05; /* HDT */
+	else if (conn->dev->le_def_tx_phys & BIT(2) &&
+			conn->link->dev->le_def_tx_phys & BIT(2))
+		tx_phy = 0x02; /* LE 2M */
+
+	le_phy_update_event(conn, tx_phy, rx_phy);
+}
+
 static void le_ext_conn_complete(struct btdev *btdev,
 			const struct bt_hci_cmd_le_ext_create_conn *cmd,
 			struct le_ext_adv *ext_adv,
@@ -6220,9 +6391,11 @@ static void le_ext_conn_complete(struct btdev *btdev,
 	le_meta_event(btdev, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 						sizeof(ev));
 
-	/* Disable EXT ADV */
-	if (conn)
+	/* Disable EXT ADV and update PHY */
+	if (conn) {
 		queue_foreach(btdev->le_ext_adv, ext_adv_term, conn);
+		le_phy_update(conn);
+	}
 }
 
 static int cmd_ext_create_conn_complete(struct btdev *dev, const void *data,
@@ -6861,7 +7034,7 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 
 	rsp.params.cig_id = cmd->cig_id;
 
-	if (cmd->num_cis > ARRAY_SIZE(dev->le_cig[0].cis)) {
+	if (cmd->num_cis > ARRAY_SIZE(dev->le_cig[0].cis_v1)) {
 		rsp.params.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 		goto done;
 	}
@@ -6938,6 +7111,7 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 	}
 
 	memcpy(&dev->le_cig[cig_idx], data, len);
+	dev->le_cig[cig_idx].version = 1;
 
 done:
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_CIG_PARAMS, &rsp,
@@ -7010,6 +7184,84 @@ static uint32_t le_cis_latecy(uint8_t ft, uint8_t iso_interval,
 	return latency >= interval ? latency : interval;
 }
 
+static void le_cis_estabilished_v4(struct btdev *dev, struct btdev_conn *conn,
+					uint8_t status, struct le_cig *le_cig,
+					uint8_t cis_idx)
+{
+	struct btdev *remote = conn->link->dev;
+	struct bt_hci_cis_params_v2 *cis = &le_cig->cis_v2[cis_idx];
+	struct bt_hci_evt_le_cis_established_v3 evt;
+
+	memset(&evt, 0, sizeof(evt));
+
+	evt.status = status;
+	evt.conn_handle = conn ? cpu_to_le16(conn->handle) : 0x0000;
+
+	memset(evt.cig_sync_delay, 0, sizeof(evt.cig_sync_delay));
+	memset(evt.cis_sync_delay, 0, sizeof(evt.cis_sync_delay));
+
+	evt.c_phy = bits_to_phy(cis->c_phy);
+	evt.p_phy = bits_to_phy(cis->p_phy);
+	evt.nse = 0x01;
+	evt.c_bn = 0x01;
+	evt.p_bn = 0x01;
+	evt.c_ft = 0x02;
+	evt.p_ft = 0x02;
+	evt.c_mtu = cis->c_sdu;
+	evt.p_mtu = cis->p_sdu;
+	evt.interval = le_cis_interval(le_cig->params.c_interval);
+	evt.p_sdu = cis->p_sdu;
+	evt.c_sdu = cis->c_sdu;
+	memcpy(evt.c_sdu_interval, le_cig->params.c_interval,
+					sizeof(evt.c_sdu_interval));
+	memcpy(evt.p_sdu_interval, le_cig->params.p_interval,
+					sizeof(evt.p_sdu_interval));
+	evt.framing = le_cig->params.framing;
+
+	switch (evt.c_phy) {
+	case 0x03:
+		evt.c_rates = cis->c_coded_rates;
+		break;
+	case 0x05:
+		evt.c_rates = cis->c_hdt_rates;
+		break;
+	}
+
+	switch (evt.p_phy) {
+	case 0x03:
+		evt.p_rates = cis->p_coded_rates;
+		break;
+	case 0x05:
+		evt.p_rates = cis->p_hdt_rates;
+		break;
+	}
+
+	evt.mic_len = cis->mic_len;
+
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
+	 * page 3050:
+	 *
+	 * Transport_Latency_C_To_P = CIG_Sync_Delay + FT_C_To_P ×
+	 * ISO_Interval - SDU_Interval_C_To_P
+	 * Transport_Latency_P_To_C = CIG_Sync_Delay + FT_P_To_C ×
+	 * ISO_Interval - SDU_Interval_P_To_C
+	 */
+	put_le24(le_cis_latecy(evt.c_ft, evt.interval,
+				le_cig->params.c_interval), evt.c_latency);
+	put_le24(le_cis_latecy(evt.p_ft, evt.interval,
+				le_cig->params.p_interval), evt.p_latency);
+
+	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED_V3, &evt, sizeof(evt));
+
+	/* Each device assigns its own handles, so the event of the
+	 * receiving side carries its handle.
+	 */
+	if (conn)
+		evt.conn_handle = cpu_to_le16(conn->link->handle);
+	le_meta_event(remote, BT_HCI_EVT_LE_CIS_ESTABLISHED_V3, &evt,
+							sizeof(evt));
+}
+
 static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 						uint8_t status)
 {
@@ -7029,18 +7281,22 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		struct btdev *remote = conn->link->dev;
 		struct le_cig *le_cig = &remote->le_cig[cig_idx];
 
+		if (le_cig->version == 2)
+			return le_cis_estabilished_v4(dev, conn, status,
+							le_cig, cis_idx);
+
 		memset(evt.cig_sync_delay, 0, sizeof(evt.cig_sync_delay));
 		memset(evt.cis_sync_delay, 0, sizeof(evt.cis_sync_delay));
 
-		evt.c_phy = bits_to_phy(le_cig->cis[cis_idx].c_phys);
-		evt.p_phy = bits_to_phy(le_cig->cis[cis_idx].p_phys);
+		evt.c_phy = bits_to_phy(le_cig->cis_v1[cis_idx].c_phys);
+		evt.p_phy = bits_to_phy(le_cig->cis_v1[cis_idx].p_phys);
 		evt.nse = 0x01;
 		evt.c_bn = 0x01;
 		evt.p_bn = 0x01;
 		evt.c_ft = 0x02;
 		evt.p_ft = 0x02;
-		evt.c_mtu = le_cig->cis[cis_idx].c_sdu;
-		evt.p_mtu = le_cig->cis[cis_idx].p_sdu;
+		evt.c_mtu = le_cig->cis_v1[cis_idx].c_sdu;
+		evt.p_mtu = le_cig->cis_v1[cis_idx].p_sdu;
 		evt.interval = le_cis_interval(le_cig->params.c_interval);
 
 		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
@@ -7108,13 +7364,22 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 			}
 		}
 
+		memset(&evt, 0, sizeof(evt));
 		/* Each device assigns its own handles, so the event of
 		 * the receiving side carries its handles.
 		 */
 		evt.acl_handle = cpu_to_le16(acl->link->handle);
 		evt.cis_handle = cpu_to_le16(iso->link->handle);
 		evt.cig_id = le_cig->params.cig_id;
-		evt.cis_id = le_cig->cis[cis_idx].cis_id;
+
+		switch (le_cig->version) {
+		case 0x01:
+			evt.cis_id = le_cig->cis_v1[cis_idx].cis_id;
+			break;
+		case 0x02:
+			evt.cis_id = le_cig->cis_v2[cis_idx].cis_id;
+			break;
+		}
 
 		le_cig->activated = true;
 
@@ -7284,7 +7549,7 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 	for (i = 0; i < cmd->num_bis; i++) {
 		struct btdev_conn *conn;
 
-		conn = conn_add_bis(dev, BIS_HANDLE + i, bis);
+		conn = conn_add_bis(dev, BIS_HANDLE + i, bis, sizeof(*bis));
 		if (!conn) {
 			queue_remove(dev->le_big, big);
 			le_big_free(big);
@@ -7898,8 +8163,8 @@ static int cmd_le_read_all_remote_features(struct btdev *dev, const void *data,
 	memset(&ev, 0, sizeof(ev));
 	ev.status = BT_HCI_ERR_SUCCESS;
 	ev.handle = cpu_to_le16(conn->handle);
-	ev.max_pages = 1;
-	ev.valid_pages = 1;
+	ev.max_pages = 10;
+	ev.valid_pages = 10;
 	memcpy(ev.features, conn->link->dev->le_features, 248);
 
 	le_meta_event(dev, BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE, &ev,
@@ -8082,6 +8347,449 @@ static void set_le_62_commands(struct btdev *btdev)
 	btdev->cmds = cmd_le_6_2;
 }
 
+static int cmd_set_data_len_v2(struct btdev *dev, const void *data,
+					uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_data_len_v2 *cmd = data;
+	struct bt_hci_rsp_le_set_data_len_v2 rsp;
+	struct btdev_conn *conn;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn)
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	else
+		rsp.handle = cpu_to_le16(conn->handle);
+
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_MAX_DATA_LEN_V2, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_max_data_len_v2(struct btdev *dev, const void *data,
+					uint8_t len)
+{
+	const struct bt_hci_cmd_le_read_data_len_v2 *cmd = data;
+	struct bt_hci_rsp_le_read_data_len_v2 rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	switch (cmd->phy) {
+	case 0x00: /* No PHY */
+	case 0x01: /* LE 1M */
+	case 0x02: /* LE 2M */
+	case 0x03: /* LE Coded */
+		rsp.max_tx_len = cpu_to_le16(0x00fb);
+		rsp.max_tx_time = cpu_to_le16(0x0148);
+		rsp.max_rx_len = cpu_to_le16(0x00fb);
+		rsp.max_rx_time = cpu_to_le16(0x0148);
+		rsp.max_tx_win = 0x01;
+		rsp.max_rx_win = 0x01;
+		rsp.max_rx_packet = cpu_to_le16(0x00fb);
+		break;
+	case 0x05: /* LE HDT */
+		rsp.max_tx_len = cpu_to_le16(0x1fef);
+		rsp.max_tx_time = cpu_to_le16(0x148);
+		rsp.max_rx_len = cpu_to_le16(0x1fef);
+		rsp.max_rx_time = cpu_to_le16(0x148);
+		rsp.max_tx_win = 0x04;
+		rsp.max_rx_win = 0x04;
+		rsp.max_rx_packet = cpu_to_le16(0x1fef);
+		break;
+	default:
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		break;
+	}
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_MAX_DATA_LEN_V2, &rsp,
+				sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_set_cig_params_v2(struct btdev *dev, const void *data,
+					uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_cig_params_v2 *cmd = data;
+	struct lescp {
+		struct bt_hci_rsp_le_set_cig_params_v2 params;
+		uint16_t handle[CIS_SIZE];
+	} __attribute__ ((packed)) rsp;
+	int i = 0;
+	int cig_idx;
+	uint32_t interval;
+	uint16_t latency;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.params.cig_id = cmd->cig_id;
+
+	if (cmd->num_cis > ARRAY_SIZE(dev->le_cig[0].cis_v2)) {
+		rsp.params.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
+
+	if (cmd->cig_id > 0xef) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	interval = get_le24(cmd->c_interval);
+	if (interval < 0x0000ff || interval > 0x0fffff) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	interval = get_le24(cmd->p_interval);
+	if (interval < 0x0000ff || interval > 0x0fffff) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->sca > 0x07) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->packing > 0x01) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->framing > 0x01) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	latency = cpu_to_le16(cmd->c_latency);
+	if (latency < 0x0005 || latency > 0x0fa0) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	latency = cpu_to_le16(cmd->p_latency);
+	if (latency < 0x0005 || latency > 0x0fa0) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	cig_idx = find_cig(dev, cmd->cig_id);
+	if (cig_idx < 0)
+		cig_idx = find_cig(dev, 0xff);
+	if (cig_idx < 0) {
+		rsp.params.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
+
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2553
+	 *
+	 * If the Host issues this command when the CIG is not in the
+	 * configurable state, the Controller shall return the error
+	 * code Command Disallowed (0x0C).
+	 */
+	if (dev->le_cig[cig_idx].activated) {
+		rsp.params.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+	rsp.params.status = BT_HCI_ERR_SUCCESS;
+
+	for (i = 0; i < cmd->num_cis; i++) {
+		rsp.params.num_handles++;
+		rsp.handle[i] = cpu_to_le16(make_cis_handle(cig_idx, i));
+	}
+
+	memcpy(&dev->le_cig[cig_idx], data, len);
+	dev->le_cig[cig_idx].version = 2;
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_CIG_PARAMS_V2, &rsp,
+				sizeof(rsp.params) + (i * sizeof(uint16_t)));
+
+	return 0;
+}
+
+static int cmd_create_big_v2(struct btdev *dev, const void *data,
+					uint8_t len)
+{
+	const struct bt_hci_cmd_le_create_big_v2 *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	/* If the Advertising_Handle does not identify a periodic advertising
+	 * train,, the Controller shall return the error code Unknown
+	 * Advertising Identifier (0x42).
+	 */
+	if (!dev->le_pa_enable) {
+		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	/* If the Host sends this command with a BIG_Handle that is already
+	 * allocated, the Controller shall return the error code Command
+	 * Disallowed (0x0C).
+	 */
+	if (queue_find(dev->le_big, match_big_handle,
+				UINT_TO_PTR(cmd->handle))) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+done:
+	cmd_status(dev, status, BT_HCI_CMD_LE_CREATE_BIG_V2);
+
+	return 0;
+}
+
+static int cmd_create_big_v2_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_create_big_v2 *cmd = data;
+	const struct bt_hci_bis_v2 *bis = &cmd->bis;
+	struct le_big *big;
+	int i;
+	struct bt_hci_evt_le_big_complete_v2 evt;
+	uint16_t *bis_handle;
+	uint8_t *pdu;
+	uint8_t pdu_len;
+
+	pdu_len = sizeof(evt) + cmd->num_bis * sizeof(*bis_handle);
+
+	pdu = malloc(pdu_len);
+	if (!pdu)
+		return -ENOMEM;
+
+	/* If the Controller cannot create all BISes of the BIG or if Num_BIS
+	 * exceeds the maximum value supported by the Controller, then it shall
+	 * return the error code Rejected due to Limited Resources (0x0D).
+	 */
+	big = le_big_new(dev, cmd->handle);
+	if (!big) {
+		evt.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
+
+	bis_handle = (uint16_t *)(pdu + sizeof(evt));
+
+	memset(&evt, 0, sizeof(evt));
+
+	for (i = 0; i < cmd->num_bis; i++) {
+		struct btdev_conn *conn;
+
+		conn = conn_add_bis(dev, BIS_HANDLE + i, bis, sizeof(*bis));
+		if (!conn) {
+			queue_remove(dev->le_big, big);
+			le_big_free(big);
+			evt.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+			goto done;
+		}
+
+		queue_push_tail(big->bis, conn);
+		*bis_handle = cpu_to_le16(conn->handle);
+		bis_handle++;
+	}
+
+	evt.handle = cmd->handle;
+	evt.phy = bits_to_phy(bis->phy);
+	evt.max_pdu = bis->sdu;
+	memcpy(evt.sync_delay, bis->sdu_interval, 3);
+	memcpy(evt.latency, bis->sdu_interval, 3);
+	evt.interval = bis->latency / 1.25;
+
+	switch (bis->phy) {
+	case 0x03:
+		evt.rates = bis->coded_rates;
+		break;
+	case 0x05:
+		evt.rates = bis->hdt_rates;
+		break;
+	}
+
+	evt.encryption = bis->encryption;
+	evt.num_bis = cmd->num_bis;
+
+done:
+	memcpy(pdu, &evt, sizeof(evt));
+
+	le_meta_event(dev, BT_HCI_EVT_LE_BIG_COMPLETE_V2, pdu, pdu_len);
+
+	free(pdu);
+
+	return 0;
+}
+
+static int cmd_set_hdt_default_params(struct btdev *dev, const void *data,
+					uint8_t len)
+{
+	const struct bt_hci_cmd_le_hdt_set_default_params *cmd = data;
+	uint16_t valid_rates = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4);
+	uint8_t status;
+
+	if (cmd->mic_len > 0x02) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->format > 0x02) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->rates & ~valid_rates) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	dev->hdt_def_mic_len = cmd->mic_len;
+	dev->hdt_def_format = cmd->format;
+	dev->hdt_def_rates = le16_to_cpu(cmd->rates);
+	status = BT_HCI_ERR_SUCCESS;
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_HDT_DEFAULT_PARAMS, &status,
+					sizeof(status));
+	return 0;
+}
+
+static int cmd_le_write_def_data_len_v2(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_WRITE_DEF_DATA_LEN_V2, &status,
+						sizeof(status));
+
+	return 0;
+}
+
+static int cmd_le_read_def_data_len_v2(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_le_read_def_data_len_v2 *cmd = data;
+	struct bt_hci_rsp_le_read_default_data_length rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	switch (cmd->phys) {
+	case 0x00: /* All GFSK PHYs  */
+		rsp.status = BT_HCI_ERR_SUCCESS;
+		rsp.tx_len = cpu_to_le16(0x001b);
+		rsp.tx_time = cpu_to_le16(0x0148);
+		break;
+	case 0x01: /* HDT PHY */
+		rsp.status = BT_HCI_ERR_SUCCESS;
+		rsp.tx_len = cpu_to_le16(0x001b);
+		rsp.tx_time = cpu_to_le16(0x0148);
+		break;
+	default:
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+	}
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_DEF_DATA_LEN_V2, &rsp,
+						sizeof(rsp));
+
+	return 0;
+}
+
+#define CMD_HDT \
+	CMD(BT_HCI_CMD_LE_WRITE_DEF_DATA_LEN_V2, \
+					cmd_le_write_def_data_len_v2, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_DEF_DATA_LEN_V2, cmd_le_read_def_data_len_v2, \
+					NULL), \
+	CMD(BT_HCI_CMD_LE_SET_MAX_DATA_LEN_V2, cmd_set_data_len_v2, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_MAX_DATA_LEN_V2, cmd_read_max_data_len_v2, \
+			NULL), \
+	CMD(BT_HCI_CMD_LE_SET_CIG_PARAMS_V2, cmd_set_cig_params_v2, NULL), \
+	CMD(BT_HCI_CMD_LE_CREATE_BIG_V2, cmd_create_big_v2, \
+			cmd_create_big_v2_complete), \
+	CMD(BT_HCI_CMD_LE_SET_HDT_DEFAULT_PARAMS, cmd_set_hdt_default_params, \
+					NULL)
+
+static int cmd_le_enable_encrypt_v2(struct btdev *dev, const void *data,
+						uint8_t len)
+{
+	const struct bt_hci_cmd_le_enable_encrypt_v2 *cmd = data;
+	struct bt_hci_evt_le_long_term_key_request ev;
+	struct btdev_conn *conn;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn) {
+		cmd_status(dev, BT_HCI_ERR_UNKNOWN_CONN_ID,
+				BT_HCI_CMD_LE_START_ENCRYPT);
+		return 0;
+	}
+
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2);
+
+	/* Opportunistic encryption: skip LTK request, proceed directly */
+	if (cmd->encryption == 0x01) {
+		conn->mic_len = cmd->mic_len;
+		if (conn->link)
+			conn->link->mic_len = cmd->mic_len;
+		encrypt_change(conn, 0x01, 0x02, BT_HCI_ERR_SUCCESS);
+		encrypt_change(conn->link, 0x01, 0x02, BT_HCI_ERR_SUCCESS);
+		return 0;
+	}
+
+	memcpy(dev->le_ltk, cmd->ltk, 16);
+
+	/* Reject re-encryption with a shorter MIC length (downgrade) */
+	if (conn->mic_len && cmd->mic_len < conn->mic_len) {
+		encrypt_change(conn, 0x00, 0x00, BT_HCI_ERR_MIC_LEN_TOO_SHORT);
+		encrypt_change(conn->link, 0x00, 0x00,
+				BT_HCI_ERR_MIC_LEN_TOO_SHORT);
+		return 0;
+	}
+
+	conn->mic_len = cmd->mic_len;
+	if (conn->link)
+		conn->link->mic_len = cmd->mic_len;
+
+	ev.handle = cpu_to_le16(conn->link->handle);
+	ev.ediv = cmd->ediv;
+	ev.rand = cmd->rand;
+
+	le_meta_event(conn->link->dev, BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST, &ev,
+					sizeof(ev));
+
+	return 0;
+}
+
+#define CMD_EKS \
+	CMD(BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2, cmd_le_enable_encrypt_v2, NULL)
+
+static const struct btdev_cmd cmd_hdt[] = {
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
+	CMD_HDT,
+	CMD_EKS,
+	{}
+};
+
+static void set_hdt_commands(struct btdev *btdev)
+{
+	btdev->commands[50] |= BIT(6);	/* LE Read Default Data Length V2 */
+	btdev->commands[50] |= BIT(7);	/* LE Write Default Data Length V2 */
+	btdev->commands[50] |= BIT(4);	/* LE Enable Encryption v2 */
+	btdev->commands[50] |= BIT(5);	/* LE Read Maximum Data Length v2 */
+	btdev->commands[52] |= BIT(3);	/* LE Set Data Length v2 */
+	btdev->commands[51] |= BIT(0);	/* LE Set CIG Parameters v2 */
+	btdev->commands[51] |= BIT(3);	/* LE Create BIG v2 */
+	btdev->commands[52] |= BIT(1);	/* LE Set HDT Default Parameters */
+	btdev->cmds = cmd_hdt;
+}
+
 static void set_le_commands(struct btdev *btdev)
 {
 	set_common_commands_all(btdev);
@@ -8123,6 +8831,8 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[33] |= 0x20;	/* LE Remote Conn Param Req Neg Reply */
 
 	/* Extra LE commands for >= 4.2 adapters */
+	btdev->commands[33] |= BIT(7);	/* LE Read Default Data Length */
+	btdev->commands[34] |= BIT(0);	/* LE Write Default Data Length */
 	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
 	btdev->commands[34] |= 0x04;	/* LE Generate DHKey */
 	btdev->commands[34] |= 0x08;	/* LE Add Device To Resolving List */
@@ -8133,6 +8843,7 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[35] |= 0x01;	/* LE Read Local Resolvable Address */
 	btdev->commands[35] |= 0x02;	/* LE Set Address Resolution Enable */
 	btdev->commands[35] |= 0x04;	/* LE Set RPA Timeout */
+	btdev->commands[35] |= BIT(3);	/* LE Read Maximum Data Length */
 
 	btdev->cmds = cmd_le;
 
@@ -8162,6 +8873,12 @@ static void set_le_commands(struct btdev *btdev)
 		set_le_62_commands(btdev);
 		btdev->cmds = cmd_le_6_2;
 	}
+
+	/* Extra HDT commands for >= 7.0 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE70) {
+		set_hdt_commands(btdev);
+		btdev->cmds = cmd_hdt;
+	}
 }
 
 static void set_bredrle_commands(struct btdev *btdev)
@@ -8214,6 +8931,7 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->features[4] |= 0x80;	/* 3 slot EDR ACL packets */
 		btdev->features[5] |= 0x01;	/* 5 slot EDR ACL packets */
 
+		btdev->le_features[0] |= BIT(5); /* LE Data Length Extension */
 		btdev->le_features[0] |= 0x40;	/* LE PRIVACY */
 		btdev->le_features[1] |= 0x01;	/* LE 2M PHY */
 		btdev->le_features[1] |= 0x08;	/* LE Coded PHY */
@@ -8244,6 +8962,23 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->le_features[9] |= BIT(1);
 	}
 
+	if (btdev->type >= BTDEV_TYPE_BREDRLE70) {
+		uint8_t *page_1 = &btdev->le_features[8];
+
+		btdev->version = 0x10;
+		btdev->le_features[7] |= BIT(3); /* HDT Intel */
+
+		page_1[1] |= BIT(4); /* Encryption Key Schedule */
+		page_1[1] |= BIT(5); /* High Data Throughput */
+		page_1[1] |= BIT(6); /* Receive HDT6 Rate */
+		page_1[1] |= BIT(7); /* Transmit HDT6 Rate */
+		page_1[2] |= BIT(0); /* Receive HDT7.5 Rate */
+		page_1[2] |= BIT(1); /* Transmit HDT7.5 Rate */
+		page_1[2] |= BIT(2); /* HDT Packet Format 1 */
+		page_1[2] |= BIT(3); /* Link Quality Feedback */
+		page_1[3] |= BIT(2); /* Opportunistic Encryption (Host) */
+	}
+
 	btdev->feat_page_2[0] |= 0x01;	/* CPB - Central Operation */
 	btdev->feat_page_2[0] |= 0x02;	/* CPB - Peripheral Operation */
 	btdev->feat_page_2[0] |= 0x04;	/* Synchronization Train */
@@ -8350,6 +9085,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
 	case BTDEV_TYPE_BREDRLE62:
+	case BTDEV_TYPE_BREDRLE70:
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
@@ -8369,6 +9105,12 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->revision = 0x0000;
 
 	switch (btdev->type) {
+	case BTDEV_TYPE_BREDRLE70:
+		btdev->version = 0x0e;
+		set_bredrle_features(btdev);
+		set_bredrle_commands(btdev);
+		set_le_states(btdev);
+		break;
 	case BTDEV_TYPE_BREDRLE:
 	case BTDEV_TYPE_BREDRLE50:
 	case BTDEV_TYPE_BREDRLE52:
@@ -9094,6 +9836,7 @@ int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode)
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
 	case BTDEV_TYPE_BREDRLE62:
+	case BTDEV_TYPE_BREDRLE70:
 		btdev->msft_opcode = opcode;
 		btdev->msft_cmds = cmd_msft;
 		return 0;
@@ -9153,6 +9896,7 @@ int btdev_set_emu_opcode(struct btdev *btdev, uint16_t opcode)
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
 	case BTDEV_TYPE_BREDRLE62:
+	case BTDEV_TYPE_BREDRLE70:
 		btdev->emu_opcode = opcode;
 		btdev->emu_cmds = cmd_emu;
 		return 0;
diff --git a/emulator/btdev.h b/emulator/btdev.h
index aa04ca611ab5..0e7ed8639568 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -54,6 +54,7 @@ enum btdev_type {
 	BTDEV_TYPE_BREDRLE52,
 	BTDEV_TYPE_BREDRLE60,
 	BTDEV_TYPE_BREDRLE62,
+	BTDEV_TYPE_BREDRLE70,
 };
 
 enum btdev_hook_type {
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 2f544f319bf2..897402fa58dc 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -409,6 +409,9 @@ struct hciemu *hciemu_new_num_debug(enum hciemu_type type, uint8_t num,
 	case HCIEMU_TYPE_BREDRLE62:
 		hciemu->btdev_type = BTDEV_TYPE_BREDRLE62;
 		break;
+	case HCIEMU_TYPE_BREDRLE70:
+		hciemu->btdev_type = BTDEV_TYPE_BREDRLE70;
+		break;
 	default:
 		return NULL;
 	}
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index cdf1ebe16752..34ab3af44ab7 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -23,6 +23,7 @@ enum hciemu_type {
 	HCIEMU_TYPE_BREDRLE52,
 	HCIEMU_TYPE_BREDRLE60,
 	HCIEMU_TYPE_BREDRLE62,
+	HCIEMU_TYPE_BREDRLE70,
 };
 
 enum hciemu_hook_type {
diff --git a/emulator/main.c b/emulator/main.c
index 794d381764b5..7be303716ca4 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -73,7 +73,7 @@ static void usage(void)
 		"\t-C, --core=<version>  Core Specification version of the\n"
 		"\t                      BR/EDR/LE controllers created with\n"
 		"\t                      -l, -s, -t and -V:\n"
-		"\t                      5.0, 5.2, 6.0 or 6.2 (default)\n"
+		"\t                      5.0, 5.2, 6.0, 6.2 or 7.0 (default)\n"
 		"\t-h, --help            Show help options\n");
 }
 
@@ -106,6 +106,7 @@ static const struct {
 	{ "5.2", BTDEV_TYPE_BREDRLE52 },
 	{ "6.0", BTDEV_TYPE_BREDRLE60 },
 	{ "6.2", BTDEV_TYPE_BREDRLE62 },
+	{ "7.0", BTDEV_TYPE_BREDRLE70 },
 };
 
 static bool parse_core_version(const char *version, enum btdev_type *type)
@@ -157,7 +158,7 @@ int main(int argc, char *argv[])
 	int letest_count = 0;
 	int vhci_count = 0;
 	/* Default to the latest version supported by the emulator */
-	enum btdev_type bredrle_type = BTDEV_TYPE_BREDRLE62;
+	enum btdev_type bredrle_type = BTDEV_TYPE_BREDRLE70;
 	enum btdev_type type;
 	bool type_set = false;
 	int i;
-- 
2.56.0

