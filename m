Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240969;
	b=1Fz36ulumNfRkMPpv0JxckYqZCJIpjFWzw7iuBVcRoCYM2YE84PiajDso3OF8XU2uVhx
	 h1O5Udy3ou2VRHE67ij1XTwRvrBlI+bJZhedjT5MoWZIT+nl/W2pFCIu6vNzAZWdy8JAx
	 HChQMwU0d1G61GUVjF3HE0r18MDxZ3rxpE0Mb0IyEFJiosZKW2G5IP6uzf6OUybOGq+Sh
	 HkAsmbX1pOUQSwkdFw2G8mRt/V3/6bJ1LZUqAzjWqJHxYj8MnuH7/wb2OhJc95zZbK2Kr
	 0ICgP/kn94/LXBLGldwfkpeu74O1xF9PLY60py/fKl7IFKlsLkLna+DXbcNtz4m7q5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ysPC2DBRiBT77MNnTqvDdyMCuAVUuSjIHd+wtxBJ/W8=;
	b=r4rwpgMNYz3OjdxlB3gJFy/nlWtCTKUVUwCn9ULC+1kf+thrRWtPcWTwidD9IN9fHMzV
	 7xpbQQUjrxP7EKFvcxQcM6tv66btomOQMMD4s13gWdrnrF/bxlqMYNl9zpejmMy/MbvKP
	 Y/MPLuf4+Hq2ZLCsaG2IsrugknvO9/emjP7fEC4KwN+tOM4Fb8F6vHOmKPZhdJabsonSd
	 cUYf6TG15ekVNCsbwhgr0LuVWB4PycBDdIQjWoGw8mIFb1OXqYbsd/SWd3h19CSVUuuik
	 Vhf0Zejrb4oqB2SE5GC127EO4c0Ea6iimZtCVwI/ZXvZnI62+dVucO7SbdGWm4lEYGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DjJ2nZsc;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E06606A33A
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01E06606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DjJ2nZsc
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so844403e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240967; x=1794845767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ysPC2DBRiBT77MNnTqvDdyMCuAVUuSjIHd+wtxBJ/W8=;
        b=DjJ2nZscSLJ1wvntlDjdXSJpN0EfJiqQrPdY0EH+MLdDeVypeKCbUujOYz1+7zvTWE
         LNd5U5pAADEevjKO0SZATD5WuyBA0+fth2DTwaE9nSrc+QaULEj0Q7TZOJXB5XY+pgx4
         9DFpSsT3WRUbR/KI8azazqVVnmPwHjhGIICPpDCkBMt9liOMfA2mtoySVT58SzlVVOXh
         9u4L4sJ1mRne+FAMlEVdH+SZrDs0ec92GXqioKfGIC5E8X66FSpli0esHIN48TlPB3hx
         217hEl7zoR+tgpWoJeTeHJKjXT2ud6lUTHELHOUSZwDPKzFyoSuaTq2ikmMa0lDZGeRO
         Mm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240967; x=1794845767;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysPC2DBRiBT77MNnTqvDdyMCuAVUuSjIHd+wtxBJ/W8=;
        b=BCDPx7/Q/FmSX4nMGTRbOEYD5EzXLxLvfqwZ3xDN11f/IDhFtrVB5i3H1iwQloFTWc
         oHhunZff+P+hyurfAM/Afdc+99C9JvAP167O4tHR8agNEJSb0OQWw4GM2+hD/CScDy1O
         tGuGwBVS4zTCCz8QWiA8DvrmXj26eFLHYpXpdYBA3YXeQlyQduTNwmWdNHOVg9K+RLML
         Tr2AeAWAjL83gcI/bCkuUyyOQOxeZ9VNC+0xyfGyjCJKx0iwIyB2JgedrhP5OYdiiUhM
         uh6k+VJnVF7NAIvOA0H9AFhIVKEm0KQE8iksdA14Mei1DbBW15dmrT6xL62qbu1vLTpy
         r4Mg==
X-Gm-Message-State: APuU4Z+hFH4XYy66XO1pnu9j/1I6y9QaJg41dPh0X/ZfUCWvnh64Hu5Q
	bWGrdPe17xJHUUmR8tUJpmXSnWOYDDJcUQ+XVWgxMWAuSBqlnW2I7IQ6NryVzg==
X-Gm-Gg: AYBFou31jgrBo5isN0YmJJUuhI/KRZduQ7qPTkMoMw3ZiUCQGDtVt/SlsjYyGLkYp6G
	Ul7QyolFUJT6wGJN04bN96eO/f8O9r+e73pgbAO8UZIQ0mgUx0yBI7i7gl0ifk7sZnsuVOloyVs
	srPdubgVTgdNdyaXDUcKRtq1G/w6Peu5bMnrLUsDHnWMVH0UAxKy4S/FpMR8zChpe/Fe3DhMQkJ
	OCO9piaH28D8b5e6lufPsmwwHeuyz09c46hT8J3jWWbhlbq9jvjaPwswjuBLasHswiNKCLyGy9H
	3ybenkN60NTyzb/uqfz5vWZ2VCb666NKGDJv3vQGfwwfJyOVg1K8YSMA/vD0n94bXiEWoo3KHOk
	OqxvHDAL9YQNLRPGuAJe67xMXbxXwHCMYt7Aba586jK8FYFx/GQNpZLMYQ42v95zFSXldMy0fRG
	DrfRjE1ooKlpsjiJmtKxeOqiPSOjCgEi3xWx0StGzNgMGPqiaOxID5CgTCl2Ky7ERgpHsK6DuvY
	NWskWiKI9PxP5i62YML5FgUEuE6ep4NHOz4HNbZyJ4RAMYzuhiZ3F6g5j6ya5/7KyRVtXKFzxCZ
	cLt8NrxQUODyeE8GUvsXPIm9yftVy5M/KF+sYKnmYr/4vaibg7ryg/UniddVehllM/JrPRVEIEU
	0FONHdu+FD1Poyy8K8uud1cDvzek7Qi12uYocTzENwbbcN6WZDMqo8qtL0jLBMeKUVoFV0hvJKv
	vYFeg=
X-Received: by 2002:a05:6122:6d1c:b0:5ee:b3:a43d with SMTP id 71dfb90a1353d-5ee00b3b20fmr610341e0c.21.1794240965934;
        Mon, 09 Nov 2026 08:16:05 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece66b77a7sm4562733e0c.17.2026.11.09.08.16.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:16:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 06/11] emulator: Add HDT support to btdev
Date: Mon,  9 Nov 2026 11:15:46 -0500
Message-ID: <20261109161553.1506041-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109161553.1506041-1-luiz.dentz@gmail.com>
References: <20261109161553.1506041-1-luiz.dentz@gmail.com>
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
 emulator/btdev.c  | 1035 ++++++++++++++++++++++++++++++++++++++++++---
 emulator/btdev.h  |    1 +
 emulator/hciemu.c |    3 +
 emulator/hciemu.h |    1 +
 emulator/main.c   |    5 +-
 5 files changed, 976 insertions(+), 69 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 2fe593ac4959..27a0b83f7731 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -84,10 +84,15 @@ struct hook {
 struct btdev_conn {
 	uint16_t handle;
 	uint8_t  type;
+	uint8_t  tx_phy;
+	uint8_t  rx_phy;
+	uint8_t  mic_len;
 	uint8_t  past_mode;
+	bool     encrypted;
 	struct btdev *dev;
 	struct btdev_conn *link;
 	struct queue *links;
+	size_t data_len;
 	void *data;
 };
 
@@ -143,7 +148,11 @@ struct le_big {
 
 struct le_cig {
 	struct bt_hci_cmd_le_set_cig_params params;
-	struct bt_hci_cis_params cis[CIS_SIZE];
+	union {
+		struct bt_hci_cis_params cis_v1[CIS_SIZE];
+		struct bt_hci_cis_params_v2 cis_v2[CIS_SIZE];
+	};
+	uint8_t version;
 	bool activated;
 } __packed;
 
@@ -258,8 +267,13 @@ struct btdev {
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
 
@@ -1263,7 +1277,7 @@ static struct btdev_conn *conn_add_cis(struct btdev_conn *acl, uint16_t handle)
 }
 
 static struct btdev_conn *conn_add_bis(struct btdev *dev, uint16_t handle,
-						const struct bt_hci_bis *bis)
+						const void *bis, size_t len)
 {
 	struct btdev_conn *conn;
 
@@ -1271,7 +1285,8 @@ static struct btdev_conn *conn_add_bis(struct btdev *dev, uint16_t handle,
 	if (!conn)
 		return conn;
 
-	conn->data = util_memdup(bis, sizeof(*bis));
+	conn->data_len = len;
+	conn->data = util_memdup(bis, len);
 
 	return conn;
 }
@@ -1309,7 +1324,7 @@ static struct btdev_conn *conn_link_bis(struct btdev *dev, struct btdev *remote,
 	if (!bis)
 		return NULL;
 
-	conn = conn_add_bis(dev, BIS_HANDLE, bis->data);
+	conn = conn_add_bis(dev, BIS_HANDLE, bis->data, bis->data_len);
 	if (!conn)
 		return NULL;
 
@@ -2057,14 +2072,116 @@ static int cmd_set_conn_encrypt(struct btdev *dev, const void *data,
 	return 0;
 }
 
+/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part B,
+ * Section 5.1.3.1.2:
+ *
+ * If the connection is on a GFSK PHY, then it shall use a 32-bit MIC after
+ * encryption is started. If the connection is on the LE HDT PHY and both the
+ * Flags_P and Flags_C are set to allow a 64-bit MIC, then the connection shall
+ * use a 64-bit MIC. Otherwise, the connection shall use a 128-bit MIC.
+ *
+ * So the MIC length negotiated only applies on the LE HDT PHY, which is the
+ * PHY of both directions or of none (Vol 6, Part B, Section 2.4.2.23).
+ */
+static uint8_t conn_mic_len(struct btdev_conn *conn)
+{
+	if (conn->tx_phy != 0x05 || conn->rx_phy != 0x05)
+		return 0x00;
+
+	return conn->mic_len;
+}
+
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
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.7.8:
+	 *
+	 * Encryption_Key_Size: Encryption key size in octets. This
+	 * parameter shall be ignored for LE connections and shall be
+	 * ignored when Link Level Encryption is OFF. Range: 0x07 to 0x10
+	 * Key_Schedule_Enabled: 0x00 Encryption Key Schedule based
+	 * encryption is not used for LE. 0x01 Encryption Key Schedule based
+	 * encryption is used with AES-CCM for LE. 0x02 Encryption Key
+	 * Schedule based opportunistic encryption is used with AES-CCM for
+	 * LE.
+	 *
+	 * So the key size isn't meaningful for LE, and 0 is what an
+	 * opportunistic encryption, which has no key from pairing, reports.
+	 */
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
+	ev.eks_mode = eks_mode;
+	ev.mic_len = conn_mic_len(conn);
+
+	send_event(conn->dev, BT_HCI_EVT_ENCRYPT_CHANGE_V3, &ev, sizeof(ev));
+}
+
+static void key_refresh_complete(struct btdev_conn *conn, uint8_t status)
+{
+	struct bt_hci_evt_encrypt_key_refresh_complete_v2 ev;
+
+	if (!conn)
+		return;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.status = status;
+	ev.handle = cpu_to_le16(conn->handle);
+
+	/* Check if BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2 has been enabled
+	 * in the event mask page 2.
+	 */
+	if (!(conn->dev->event_mask_page2[3] & BIT(3))) {
+		send_event(conn->dev, BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE,
+				&ev, sizeof(struct
+				bt_hci_evt_encrypt_key_refresh_complete));
+		return;
+	}
+
+	ev.mic_len = conn_mic_len(conn);
+	ev.eks_mode = 0x01;
+
+	send_event(conn->dev, BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2, &ev,
+							sizeof(ev));
+}
+
 static void encrypt_change(struct btdev_conn *conn, uint8_t mode,
-					uint8_t status)
+				uint8_t eks_mode, uint8_t status)
 {
 	struct bt_hci_evt_encrypt_change ev;
 
 	if (!conn)
 		return;
 
+	if (!status)
+		conn->encrypted = !!mode;
+
+	/* Check if BT_HCI_EVT_ENCRYPT_CHANGE_V3 has been enabled in the event
+	 * mask page 2.
+	 */
+	if (conn->dev->event_mask_page2[3] & BIT(2))
+		return encrypt_change_v3(conn, mode, eks_mode, status);
+
 	memset(&ev, 0, sizeof(ev));
 
 	ev.status = status;
@@ -2094,8 +2211,8 @@ static int cmd_set_conn_encrypt_complete(struct btdev *dev, const void *data,
 	else
 		mode = 0x01;
 
-	encrypt_change(conn, mode, BT_HCI_ERR_SUCCESS);
-	encrypt_change(conn->link, mode, BT_HCI_ERR_SUCCESS);
+	encrypt_change(conn, mode, 0x00, BT_HCI_ERR_SUCCESS);
+	encrypt_change(conn->link, mode, 0x00, BT_HCI_ERR_SUCCESS);
 
 	return 0;
 }
@@ -4874,8 +4991,27 @@ static int cmd_ltk_reply(struct btdev *dev, const void *data, uint8_t len)
 		mode = 0x01;
 	}
 
-	encrypt_change(conn, mode, status);
-	encrypt_change(conn->link, mode, status);
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.7.39:
+	 *
+	 * This event is used to indicate to the Host that the encryption
+	 * key was refreshed on the given Connection_Handle any time
+	 * encryption is paused and then resumed.
+	 *
+	 * So encrypting a link that is already encrypted, such as one with
+	 * opportunistic encryption, refreshes its key.
+	 */
+	if (!status && conn->encrypted) {
+		key_refresh_complete(conn, status);
+		key_refresh_complete(conn->link, status);
+		return 0;
+	}
+
+	/* Pass eks_mode as 0x01 for EKS enabled since only in case of V3 being
+	 * enabled it will get used.
+	 */
+	encrypt_change(conn, mode, 0x01, status);
+	encrypt_change(conn->link, mode, 0x01, status);
 
 	return 0;
 }
@@ -4900,7 +5036,7 @@ static int cmd_ltk_neg_reply(struct btdev *dev, const void *data, uint8_t len)
 	rp.status = BT_HCI_ERR_SUCCESS;
 	cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, &rp, sizeof(rp));
 
-	encrypt_change(conn->link, 0x00, BT_HCI_ERR_PIN_OR_KEY_MISSING);
+	encrypt_change(conn->link, 0x00, 0x00, BT_HCI_ERR_PIN_OR_KEY_MISSING);
 
 	return 0;
 }
@@ -5000,6 +5136,34 @@ static int cmd_conn_param_neg_reply_complete(struct btdev *dev,
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
@@ -5011,6 +5175,24 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
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
@@ -5055,6 +5237,10 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
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
@@ -5065,7 +5251,9 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 	CMD(BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR, cmd_read_local_rl_addr, \
 					NULL), \
 	CMD(BT_HCI_CMD_LE_SET_RESOLV_ENABLE, cmd_set_rl_enable, NULL), \
-	CMD(BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT, cmd_set_rl_timeout, NULL)
+	CMD(BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT, cmd_set_rl_timeout, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_MAX_DATA_LENGTH, cmd_le_read_max_data_len, \
+					NULL) \
 
 static const struct btdev_cmd cmd_bredr_le[] = {
 	CMD_COMMON_ALL,
@@ -5096,16 +5284,20 @@ static int cmd_set_default_phy(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_le_set_default_phy *cmd = data;
-	uint8_t status;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
 	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
-			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!cmd->tx_phys || (cmd->tx_phys & ~0x17))) ||
 			(!(cmd->all_phys & 0x02) &&
-			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+			(!cmd->rx_phys || (cmd->rx_phys & ~0x17)))) {
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
 
@@ -5127,9 +5319,9 @@ static int cmd_le_set_phy(struct btdev *dev, const void *data,
 	}
 
 	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
-			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!cmd->tx_phys || (cmd->tx_phys & ~0x17))) ||
 			(!(cmd->all_phys & 0x02) &&
-			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+			(!cmd->rx_phys || (cmd->rx_phys & ~0x17))))
 		status = BT_HCI_ERR_INVALID_PARAMETERS;
 	else
 		status = BT_HCI_ERR_SUCCESS;
@@ -5153,9 +5345,9 @@ static int cmd_le_set_phy_complete(struct btdev *dev, const void *data,
 		return 0;
 
 	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
-			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!cmd->tx_phys || (cmd->tx_phys & ~0x17))) ||
 			(!(cmd->all_phys & 0x02) &&
-			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+			(!cmd->rx_phys || (cmd->rx_phys & ~0x17))))
 		return 0;
 
 	memset(&ev, 0, sizeof(ev));
@@ -5169,19 +5361,49 @@ static int cmd_le_set_phy_complete(struct btdev *dev, const void *data,
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
+
+	if (ev.tx_phy)
+		conn->tx_phy = ev.tx_phy;
+	if (ev.rx_phy)
+		conn->rx_phy = ev.rx_phy;
 
 	le_meta_event(dev, BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE, &ev, sizeof(ev));
 
+	/* The peer receives on the PHY this side transmits on and the other
+	 * way around.
+	 */
+	if (conn->link) {
+		uint8_t tx_phy = ev.tx_phy;
+
+		if (ev.rx_phy)
+			conn->link->tx_phy = ev.rx_phy;
+		if (tx_phy)
+			conn->link->rx_phy = tx_phy;
+
+		ev.handle = cpu_to_le16(conn->link->handle);
+		ev.tx_phy = ev.rx_phy;
+		ev.rx_phy = tx_phy;
+		le_meta_event(conn->link->dev,
+				BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE, &ev,
+				sizeof(ev));
+	}
+
 	return 0;
 }
 
@@ -5814,7 +6036,9 @@ static uint8_t bits_to_phy(uint8_t bits)
 {
 	uint8_t phy = 0x00;
 
-	/* Convert PHY bits to PHY values on a ascending order. */
+	/* Convert PHY bits to PHY values on a ascending order so if HDT bit is
+	 * set it takes precedence over LE 2M and LE 1M.
+	 */
 	if (bits & BIT(0))
 		phy = 0x01; /* LE 1M */
 
@@ -5824,6 +6048,9 @@ static uint8_t bits_to_phy(uint8_t bits)
 	if (bits & BIT(2))
 		phy = 0x03; /* LE Coded */
 
+	if (bits & BIT(4))
+		phy = 0x05; /* HDT */
+
 	return phy;
 }
 
@@ -6155,6 +6382,71 @@ static void ext_adv_term(void *data, void *user_data)
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
+	conn->tx_phy = tx_phy;
+	conn->rx_phy = rx_phy;
+	conn->link->tx_phy = rx_phy;
+	conn->link->rx_phy = tx_phy;
+
+	le_meta_event(conn->dev, BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE,
+					&ev, sizeof(ev));
+
+	/* The peer receives on the PHY this side transmits on and the other
+	 * way around.
+	 */
+	ev.handle = cpu_to_le16(conn->link->handle);
+	ev.tx_phy = rx_phy;
+	ev.rx_phy = tx_phy;
+	le_meta_event(conn->link->dev, BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE,
+					&ev, sizeof(ev));
+}
+
+/* Highest PHY both sides prefer: HDT, then LE 2M, then LE 1M */
+static uint8_t le_phy_select(uint8_t local, uint8_t remote)
+{
+	uint8_t phys = local & remote;
+
+	if (phys & BIT(4))
+		return 0x05; /* HDT */
+
+	if (phys & BIT(1))
+		return 0x02; /* LE 2M */
+
+	/* LE 1M, unless LE Coded is the only one both sides prefer */
+	if (!(phys & BIT(0)) && (phys & BIT(2)))
+		return 0x03; /* LE Coded */
+
+	return 0x01; /* LE 1M */
+}
+
+static void le_phy_update(struct btdev_conn *conn)
+{
+	uint8_t tx_phy, rx_phy;
+
+	/* Each direction is transmitted by one side and received by the
+	 * other.
+	 */
+	tx_phy = le_phy_select(conn->dev->le_def_tx_phys,
+					conn->link->dev->le_def_rx_phys);
+	rx_phy = le_phy_select(conn->dev->le_def_rx_phys,
+					conn->link->dev->le_def_tx_phys);
+
+	le_phy_update_event(conn, tx_phy, rx_phy);
+}
+
 static void le_ext_conn_complete(struct btdev *btdev,
 			const struct bt_hci_cmd_le_ext_create_conn *cmd,
 			struct le_ext_adv *ext_adv,
@@ -6220,9 +6512,11 @@ static void le_ext_conn_complete(struct btdev *btdev,
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
@@ -6861,7 +7155,7 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 
 	rsp.params.cig_id = cmd->cig_id;
 
-	if (cmd->num_cis > ARRAY_SIZE(dev->le_cig[0].cis)) {
+	if (cmd->num_cis > ARRAY_SIZE(dev->le_cig[0].cis_v1)) {
 		rsp.params.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 		goto done;
 	}
@@ -6938,6 +7232,7 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 	}
 
 	memcpy(&dev->le_cig[cig_idx], data, len);
+	dev->le_cig[cig_idx].version = 1;
 
 done:
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_CIG_PARAMS, &rsp,
@@ -7010,10 +7305,100 @@ static uint32_t le_cis_latecy(uint8_t ft, uint8_t iso_interval,
 	return latency >= interval ? latency : interval;
 }
 
+/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E, Section 4.8.2:
+ *
+ * If an event has more than one version and the event is generated, then
+ * the Controller shall use the latest version that is both supported and
+ * enabled ("unmasked") in the relevant event mask.
+ *
+ * LE CIS Established v1 is a prefix of v3, and v3 is LE event mask bit 57.
+ */
+static void le_cis_estabilished_send(struct btdev *btdev,
+				struct bt_hci_evt_le_cis_established_v3 *evt)
+{
+	if (btdev->le_event_mask[7] & BIT(1))
+		le_meta_event(btdev, BT_HCI_EVT_LE_CIS_ESTABLISHED_V3, evt,
+							sizeof(*evt));
+	else
+		le_meta_event(btdev, BT_HCI_EVT_LE_CIS_ESTABLISHED, evt,
+				sizeof(struct bt_hci_evt_le_cis_established));
+}
+
+static void le_cis_estabilished_fill(
+				struct bt_hci_evt_le_cis_established_v3 *evt,
+				struct le_cig *le_cig, int cis_idx)
+{
+	uint8_t c_phys, p_phys;
+
+	if (le_cig->version == 2) {
+		struct bt_hci_cis_params_v2 *cis = &le_cig->cis_v2[cis_idx];
+
+		c_phys = cis->c_phy;
+		p_phys = cis->p_phy;
+		evt->c_mtu = cis->c_sdu;
+		evt->p_mtu = cis->p_sdu;
+		evt->mic_len = cis->mic_len;
+		evt->c_phy = bits_to_phy(c_phys);
+		evt->p_phy = bits_to_phy(p_phys);
+
+		switch (evt->c_phy) {
+		case 0x03:
+			evt->c_rates = cpu_to_le16(cis->c_coded_rates);
+			break;
+		case 0x05:
+			evt->c_rates = cis->c_hdt_rates;
+			break;
+		}
+
+		switch (evt->p_phy) {
+		case 0x03:
+			evt->p_rates = cpu_to_le16(cis->p_coded_rates);
+			break;
+		case 0x05:
+			evt->p_rates = cis->p_hdt_rates;
+			break;
+		}
+	} else {
+		struct bt_hci_cis_params *cis = &le_cig->cis_v1[cis_idx];
+
+		evt->c_phy = bits_to_phy(cis->c_phys);
+		evt->p_phy = bits_to_phy(cis->p_phys);
+		evt->c_mtu = cis->c_sdu;
+		evt->p_mtu = cis->p_sdu;
+	}
+
+	evt->nse = 0x01;
+	evt->c_bn = 0x01;
+	evt->p_bn = 0x01;
+	evt->c_ft = 0x02;
+	evt->p_ft = 0x02;
+	evt->interval = le_cis_interval(le_cig->params.c_interval);
+	evt->c_sdu = evt->c_mtu;
+	evt->p_sdu = evt->p_mtu;
+	memcpy(evt->c_sdu_interval, le_cig->params.c_interval,
+					sizeof(evt->c_sdu_interval));
+	memcpy(evt->p_sdu_interval, le_cig->params.p_interval,
+					sizeof(evt->p_sdu_interval));
+	evt->framing = le_cig->params.framing;
+
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
+	 * page 3050:
+	 *
+	 * Transport_Latency_C_To_P = CIG_Sync_Delay + FT_C_To_P ×
+	 * ISO_Interval - SDU_Interval_C_To_P
+	 * Transport_Latency_P_To_C = CIG_Sync_Delay + FT_P_To_C ×
+	 * ISO_Interval - SDU_Interval_P_To_C
+	 */
+	put_le24(le_cis_latecy(evt->c_ft, evt->interval,
+				le_cig->params.c_interval), evt->c_latency);
+	put_le24(le_cis_latecy(evt->p_ft, evt->interval,
+				le_cig->params.p_interval), evt->p_latency);
+}
+
 static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 						uint8_t status)
 {
-	struct bt_hci_evt_le_cis_established evt;
+	struct bt_hci_evt_le_cis_established_v3 evt;
 	int cig_idx, cis_idx = -1;
 
 	memset(&evt, 0, sizeof(evt));
@@ -7025,44 +7410,19 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 	if (cig_idx < 0 && !evt.status)
 		evt.status = BT_HCI_ERR_UNSPECIFIED_ERROR;
 
-	if (!evt.status) {
-		struct btdev *remote = conn->link->dev;
-		struct le_cig *le_cig = &remote->le_cig[cig_idx];
+	if (!evt.status)
+		le_cis_estabilished_fill(&evt,
+					&conn->link->dev->le_cig[cig_idx],
+					cis_idx);
 
-		memset(evt.cig_sync_delay, 0, sizeof(evt.cig_sync_delay));
-		memset(evt.cis_sync_delay, 0, sizeof(evt.cis_sync_delay));
-
-		evt.c_phy = bits_to_phy(le_cig->cis[cis_idx].c_phys);
-		evt.p_phy = bits_to_phy(le_cig->cis[cis_idx].p_phys);
-		evt.nse = 0x01;
-		evt.c_bn = 0x01;
-		evt.p_bn = 0x01;
-		evt.c_ft = 0x02;
-		evt.p_ft = 0x02;
-		evt.c_mtu = le_cig->cis[cis_idx].c_sdu;
-		evt.p_mtu = le_cig->cis[cis_idx].p_sdu;
-		evt.interval = le_cis_interval(le_cig->params.c_interval);
-
-		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
-		 * page 3050:
-		 *
-		 * Transport_Latency_C_To_P = CIG_Sync_Delay + FT_C_To_P ×
-		 * ISO_Interval - SDU_Interval_C_To_P
-		 * Transport_Latency_P_To_C = CIG_Sync_Delay + FT_P_To_C ×
-		 * ISO_Interval - SDU_Interval_P_To_C
-		 */
-		put_le24(le_cis_latecy(evt.c_ft, evt.interval,
-				le_cig->params.c_interval), evt.c_latency);
-		put_le24(le_cis_latecy(evt.p_ft, evt.interval,
-				le_cig->params.p_interval), evt.p_latency);
-	}
-
-	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
+	le_cis_estabilished_send(dev, &evt);
 
+	/* Each device assigns its own handles, so the event of the
+	 * receiving side carries its handle.
+	 */
 	if (conn) {
 		evt.conn_handle = cpu_to_le16(conn->link->handle);
-		le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CIS_ESTABLISHED,
-						&evt, sizeof(evt));
+		le_cis_estabilished_send(conn->link->dev, &evt);
 	}
 }
 
@@ -7108,13 +7468,22 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
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
 
@@ -7284,7 +7653,7 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 	for (i = 0; i < cmd->num_bis; i++) {
 		struct btdev_conn *conn;
 
-		conn = conn_add_bis(dev, BIS_HANDLE + i, bis);
+		conn = conn_add_bis(dev, BIS_HANDLE + i, bis, sizeof(*bis));
 		if (!conn) {
 			queue_remove(dev->le_big, big);
 			le_big_free(big);
@@ -7898,8 +8267,8 @@ static int cmd_le_read_all_remote_features(struct btdev *dev, const void *data,
 	memset(&ev, 0, sizeof(ev));
 	ev.status = BT_HCI_ERR_SUCCESS;
 	ev.handle = cpu_to_le16(conn->handle);
-	ev.max_pages = 1;
-	ev.valid_pages = 1;
+	ev.max_pages = 10;
+	ev.valid_pages = 10;
 	memcpy(ev.features, conn->link->dev->le_features, 248);
 
 	le_meta_event(dev, BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE, &ev,
@@ -8082,6 +8451,501 @@ static void set_le_62_commands(struct btdev *btdev)
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
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_DATA_LEN_V2, &rsp, sizeof(rsp));
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
+	} __packed rsp;
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
+	/* Num_BIS ranges from 0x01 to 0x1F */
+	if (!cmd->num_bis || cmd->num_bis > 0x1f) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
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
+	/* Only complete the command if it was accepted */
+	return status ? -EALREADY : 0;
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
+	size_t pdu_len;
+
+	memset(&evt, 0, sizeof(evt));
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
+	/* The same stream send_biginfo() reports */
+	evt.nse = 0x01;
+	evt.bn = 0x01;
+	evt.irc = 0x01;
+	evt.phy = bits_to_phy(bis->phy);
+	evt.max_pdu = bis->sdu;
+	memcpy(evt.sync_delay, bis->sdu_interval, 3);
+	memcpy(evt.latency, bis->sdu_interval, 3);
+	/* ISO_Interval is in units of 1.25 ms and Max_Transport_Latency
+	 * in ms.
+	 */
+	evt.interval = cpu_to_le16(le16_to_cpu(bis->latency) * 4 / 5);
+
+	switch (evt.phy) {
+	case 0x03:
+		evt.rates = cpu_to_le16(bis->coded_rates);
+		break;
+	case 0x05:
+		evt.rates = bis->hdt_rates;
+		break;
+	}
+
+	evt.encryption = bis->encryption;
+	evt.mic_len = bis->mic_len;
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
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.159:
+	 *
+	 * Preferred_MIC_Length: 0x01 Preferred MIC length is 64 bits.
+	 * 0x02 MIC length is 128 bits (default). All other values Reserved
+	 * for future use.
+	 * Preferred_Packet_Format: 0x00, 0x01 and 0x02. All other values
+	 * Reserved for future use.
+	 * Preferred_ACL_Rates: bits 0 to 4. All other bits Reserved for
+	 * future use.
+	 */
+	if (cmd->mic_len < 0x01 || cmd->mic_len > 0x02) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->format > 0x02) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (le16_to_cpu(cmd->rates) & ~valid_rates) {
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
+	CMD(BT_HCI_CMD_LE_SET_DATA_LEN_V2, cmd_set_data_len_v2, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_MAX_DATA_LEN_V2, cmd_read_max_data_len_v2, \
+			NULL), \
+	CMD(BT_HCI_CMD_LE_SET_CIG_PARAMS_V2, cmd_set_cig_params_v2, NULL), \
+	CMD(BT_HCI_CMD_LE_CREATE_BIG_V2, cmd_create_big_v2, \
+			cmd_create_big_v2_complete), \
+	CMD(BT_HCI_CMD_LE_SET_HDT_DEFAULT_PARAMS, cmd_set_hdt_default_params, \
+					NULL)
+
+/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part B,
+ * Section 5.1.3.1.2:
+ *
+ * If the connection is on the LE HDT PHY and both the Flags_P and Flags_C
+ * are set to allow a 64-bit MIC, then the connection shall use a 64-bit MIC.
+ * Otherwise, the connection shall use a 128-bit MIC.
+ *
+ * The peer's preference is its LE Set HDT Default Parameters.
+ */
+static uint8_t le_mic_len(struct btdev_conn *conn, uint8_t mic_len)
+{
+	if (mic_len == 0x01 && conn->link &&
+				conn->link->dev->hdt_def_mic_len != 0x01)
+		return 0x02;
+
+	return mic_len;
+}
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
+				BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2);
+		return 0;
+	}
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.24:
+	 *
+	 * When the Encryption_Type parameter is set to 0x01 (use opportunistic
+	 * encryption with Encryption Key Schedule), the command shall be only
+	 * used for unencrypted connections and the Long_Term_Key parameter
+	 * shall be ignored by the Controller.
+	 *
+	 * So refuse it for an encrypted connection, and otherwise skip the LTK
+	 * request and proceed directly.
+	 */
+	if (cmd->encryption == 0x01 && conn->encrypted) {
+		cmd_status(dev, BT_HCI_ERR_COMMAND_DISALLOWED,
+				BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2);
+		return 0;
+	}
+
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2);
+
+	if (cmd->encryption == 0x01) {
+		conn->mic_len = le_mic_len(conn, cmd->mic_len);
+		if (conn->link)
+			conn->link->mic_len = conn->mic_len;
+		encrypt_change(conn, 0x01, 0x02, BT_HCI_ERR_SUCCESS);
+		encrypt_change(conn->link, 0x01, 0x02, BT_HCI_ERR_SUCCESS);
+		return 0;
+	}
+
+	memcpy(dev->le_ltk, cmd->ltk, 16);
+
+	conn->mic_len = le_mic_len(conn, cmd->mic_len);
+	if (conn->link)
+		conn->link->mic_len = conn->mic_len;
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
@@ -8123,6 +8987,8 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[33] |= 0x20;	/* LE Remote Conn Param Req Neg Reply */
 
 	/* Extra LE commands for >= 4.2 adapters */
+	btdev->commands[33] |= BIT(7);	/* LE Read Default Data Length */
+	btdev->commands[34] |= BIT(0);	/* LE Write Default Data Length */
 	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
 	btdev->commands[34] |= 0x04;	/* LE Generate DHKey */
 	btdev->commands[34] |= 0x08;	/* LE Add Device To Resolving List */
@@ -8133,6 +8999,7 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[35] |= 0x01;	/* LE Read Local Resolvable Address */
 	btdev->commands[35] |= 0x02;	/* LE Set Address Resolution Enable */
 	btdev->commands[35] |= 0x04;	/* LE Set RPA Timeout */
+	btdev->commands[35] |= BIT(3);	/* LE Read Maximum Data Length */
 
 	btdev->cmds = cmd_le;
 
@@ -8162,6 +9029,12 @@ static void set_le_commands(struct btdev *btdev)
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
@@ -8244,6 +9117,25 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->le_features[9] |= BIT(1);
 	}
 
+	if (btdev->type >= BTDEV_TYPE_BREDRLE70) {
+		uint8_t *page_1 = &btdev->le_features[8];
+
+		btdev->version = 0x10;
+
+		/* The data length commands of 7.0 are the ones emulated */
+		btdev->le_features[0] |= BIT(5); /* LE Data Length Extension */
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
@@ -8350,6 +9242,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
 	case BTDEV_TYPE_BREDRLE62:
+	case BTDEV_TYPE_BREDRLE70:
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
@@ -8369,6 +9262,12 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
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
@@ -9094,6 +9993,7 @@ int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode)
 	case BTDEV_TYPE_BREDRLE52:
 	case BTDEV_TYPE_BREDRLE60:
 	case BTDEV_TYPE_BREDRLE62:
+	case BTDEV_TYPE_BREDRLE70:
 		btdev->msft_opcode = opcode;
 		btdev->msft_cmds = cmd_msft;
 		return 0;
@@ -9153,6 +10053,7 @@ int btdev_set_emu_opcode(struct btdev *btdev, uint16_t opcode)
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

