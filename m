Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349523;
	b=N+juhcxu/ddChzwl0PDkY9XkpJkU+tlK9uWKteoBqtuTB/LY8q24QeliizPPpSUsIrdf
	 zmY19NqDFLVYfekV0i91Tyvq2iK3ovcp3io3D2uy+oRvPgEWIAOgsxbOw3sfnEFHM2FyQ
	 eiONASacX2nDEYTErgBIje83jinxclrK9/J2ArpRheGOaxA9yzoeCU9GLMgboWyYPn503
	 lXHAIeVlDtKTkkogj63aj630n+QqEMIIhu/jSgkMcGBnK9VWS4h43qlFOsPKiFoT2hz8W
	 IKT5iiTOZd84jkSUGt7y5RNROCSFb6rY5U16/4QgxXHpM5U632GEk7FZE1/DtjTJunw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
	b=NXcxUAgrZmZVT+/OfPjGFLENjo1y0rF898MrHF8f4I2BuUxbIjpOpyRAOZA8yb9J6m+0
	 ib6OY+6eAuc5UpfUjWBPDMBgn8v/nd6nCbve0ySS4DKqSMITB7+hoRkAZpTMUGOmzXN3H
	 EJDUCYdnIPP7u1m5gibz2ztYsqtddjwJ4Gr9k2PNaRIMiZxvBCtb1pRO4nDERazvTev/D
	 JNUYJhTUyEfzSrB8pIB1zr5lzuZvIig4PypUbevFMK4/hQPSfui3L0nH52+4JF2rhHx2z
	 s8LCFe2E8sWIn54FVPuELkQ+x9yCwAuRNSTDSdLHbO0uLrxsIMntogHvf5nxMc7Yh7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9PdsTPj;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F969606A330
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F969606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9PdsTPj
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9905d61449cso748321241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349522; x=1794954322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=k9PdsTPj8i/kbVEnJzGQAaHfG1+PLMBKvcpXN/iZCOgsI1IkY5opGj6NIOfY/61RgB
         5EFw4mWCOTsdoFK53m2c+B3vrTi/fnJuRXsuC/VkYw0b23ouzIkr4BcElL4O/rrRmGbN
         GEbG3EGlqr2vEJ/qZJe0A1HVr0xSDnnEuk1B+zHzB4JsRUKJYgqDVeECDHN8qi+H7Veh
         CJRRWMgAahL9wLS5ir8LIW8+SeC0vYHKBxfIEsWgK8YzXNXJsBH2Z4ZwYMxUXeUn3MnC
         S09DNhetWwZQHheMtZX+wNmGHn6ki3TjTbihxlwOXA5PKIw323rJ6LKFk+jeY7RSnhdY
         2cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349522; x=1794954322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=IL0E0tCrsJnfVMKhvFbD38oeEax6NzLJFNOi0HoHzr4X1d9JqP1lRRRlWrhroh1zkj
         FdmM+7K9FvSQp+9Pjz5IYgmMDFk/+56E/SuS4B7C0atj4H9GcdIj+6fMMEbEspPkeXYA
         lTsAj5y3JLzSC6b1kZQrHzEZueDxGtFzXCxLPX7GVYRDVIJUd5N8be0jNo/WErb2DcJj
         +NGf5vw6UCkN1mQDlrzCucogxZCRzHW2fxrIMGpGt4jsudbW9AYieGzUXIlaDkEfy574
         8djaKCHo3svDUDA9XcEfd1flKLbyf2GfRAJjKgTW7qaB/G6x6DGAkFBYr6qxVAhIObgv
         gWDg==
X-Gm-Message-State: APuU4Z+k3cU6nSZh1W5oabyOCW3UTRsRMyRCVbStE8Zwx9xO8zeMz/VS
	KIrNRD5fwjtPDCwj3w7MVXXbbkuPcxvBw8BfnhIDUada+aJ9UztnIHQ1zNNqdg==
X-Gm-Gg: AYBFou10XuAn6neCi+j15fY6iGbXpIqkKJotWuM2f0esS3ogrR8oBEne8VeyXLYsZkC
	NyzQ+8xEZYtp1z/hYYJZ6TdRH/E80p7CbrfLYWwGstsHrk0+9Bwqcl0QHHA1cLZa32ev783Tolu
	BCk0CQevwsFPtc6JGyLx2LdmeCrxjlKSbsYH4iPMWklaRe67MhSSrUDLlI4Q104U+EE38U8VBKo
	6shRTnFOd7dWjmkm4GwCs7UR6N0CD17r+GvvyLuqt9rjuPIiN8kAAOCYMeWCSRrugoyB6e9qpYb
	H/XB6SicinxfWzA6D2aKHYZkk3lJTF4TqdWIfNRrMn6ao28gKwUYWoFHVGoKdKBLFNBykJZIyvF
	wdPCn9zCxUaQHb/lnyPr6S54HEO3jviSABds3fjtqAavYlwFS+DbfY23BOsk+Dtjrrg9TGkOSU1
	Nt56ZUXHlpoNJ2LQK1OPmLm6oWSY7nfBT9k4iMBmO80KBAg8skTrb3s2wljBeVJZxxDrnw5Zv6e
	+SF851bsaR8JQxY4aQi5A4pMEme4tJIjD563aoFO7zJZOUeMCFVejmSSOhafPftHHV3yn/7HZW6
	XwLohNzsP1OsGVTsGcmTw4mUk+1+IB88pNh4RXEx/vnhm+cgqY0WBov8+k9E1l6chIUAtivNJKl
	kSQeOJyuL85FHVCbm/ne2z4S0y8sWEh9fsgfs/IEyUuUlRvSHoYdxwXHSXz6vAxhGKQRhp6SJh2
	6Cbyc=
X-Received: by 2002:a05:6102:418c:b0:7b5:4700:3a58 with SMTP id ada2fe7eead31-7d506119adcmr156356137.31.1794349521818;
        Tue, 10 Nov 2026 14:25:21 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30223977dsm2609190137.1.2026.11.10.14.25.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:25:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 07/11] emulator: Add HDT support to bthost
Date: Tue, 10 Nov 2026 17:25:06 -0500
Message-ID: <20261110222511.3011494-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110222511.3011494-1-luiz.dentz@gmail.com>
References: <20261110222511.3011494-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add helpers to set the PHY of a connection, including the HDT rates,
and to start encryption with a given MIC length through LE Enable
Encryption v2, so testers can exercise HDT and MIC length checks from
the remote side.
---
 emulator/bthost.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  14 +++++
 2 files changed, 145 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 0c669f92efc4..58f820aa80e1 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -277,6 +277,10 @@ struct bthost {
 	bool conn_init;
 	bool le;
 	bool sc;
+	uint8_t mic_len;
+
+	bthost_encrypt_cb encrypt_cb;
+	void *encrypt_cb_data;
 
 	struct queue *le_ext_adv;
 
@@ -1605,6 +1609,34 @@ static void evt_encrypt_change(struct bthost *bthost, const void *data,
 
 	if (conn->smp_data)
 		smp_conn_encrypted(conn->smp_data, conn->encr_mode);
+
+	if (ev->encr_mode && bthost->encrypt_cb)
+		bthost->encrypt_cb(handle, bthost->encrypt_cb_data);
+}
+
+/* A key refresh, such as pairing over a link that is already encrypted,
+ * completes encryption with the new key as Encryption Change does.
+ */
+static void evt_key_refresh_complete(struct bthost *bthost, const void *data,
+								uint8_t len)
+{
+	const struct bt_hci_evt_encrypt_key_refresh_complete *ev = data;
+	struct btconn *conn;
+	uint16_t handle;
+
+	if (len < sizeof(*ev))
+		return;
+
+	handle = acl_handle(le16_to_cpu(ev->handle));
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn || ev->status)
+		return;
+
+	if (conn->smp_data)
+		smp_conn_encrypted(conn->smp_data, conn->encr_mode);
+
+	if (conn->encr_mode && bthost->encrypt_cb)
+		bthost->encrypt_cb(handle, bthost->encrypt_cb_data);
 }
 
 static void evt_io_cap_response(struct bthost *bthost, const void *data,
@@ -1946,6 +1978,18 @@ static void evt_le_big_info_adv_report(struct bthost *bthost,
 	send_command(bthost, BT_HCI_CMD_LE_BIG_CREATE_SYNC, &cmd, sizeof(cmd));
 }
 
+static void evt_le_cis_established_v3(struct bthost *bthost, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_evt_le_cis_established_v3 *ev = data;
+
+	if (ev->status)
+		return;
+
+	init_iso(bthost, le16_to_cpu(ev->conn_handle), BDADDR_ANY->b,
+							BDADDR_LE_PUBLIC);
+}
+
 static void evt_le_meta_event(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1994,6 +2038,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_CONN_RATE_CHANGE:
 		evt_le_conn_rate_change(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_CIS_ESTABLISHED_V3:
+		evt_le_cis_established_v3(bthost, evt_data, len - 1);
+		break;
 	default:
 		bthost_debug(bthost, "Unsupported LE Meta event 0x%2.2x",
 								*event);
@@ -2065,6 +2112,12 @@ static void process_evt(struct bthost *bthost, const void *data, uint16_t len)
 		evt_encrypt_change(bthost, param, hdr->plen);
 		break;
 
+	/* Both versions start with the fields used */
+	case BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE:
+	case BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2:
+		evt_key_refresh_complete(bthost, param, hdr->plen);
+		break;
+
 	case BT_HCI_EVT_IO_CAPABILITY_RESPONSE:
 		evt_io_cap_response(bthost, param, hdr->plen);
 		break;
@@ -4030,6 +4083,12 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 {
 	struct bt_hci_cmd_le_start_encrypt cmd;
 
+	if (bthost->mic_len) {
+		bthost_le_start_encrypt_v2(bthost, handle, ltk,
+							bthost->mic_len);
+		return;
+	}
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = htobs(handle);
 	memcpy(cmd.ltk, ltk, 16);
@@ -4055,6 +4114,36 @@ void bthost_le_conn_rate(struct bthost *bthost, uint16_t handle,
 	send_command(bthost, BT_HCI_CMD_LE_CONN_RATE, &cmd, sizeof(cmd));
 }
 
+void bthost_le_start_encrypt_v2(struct bthost *bthost, uint16_t handle,
+					const uint8_t ltk[16], uint8_t mic_len)
+{
+	struct bt_hci_cmd_le_enable_encrypt_v2 cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = htobs(handle);
+	memcpy(cmd.ltk, ltk, 16);
+	cmd.mic_len = mic_len;
+
+	send_command(bthost, BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2, &cmd,
+							sizeof(cmd));
+}
+
+void bthost_le_reencrypt(struct bthost *bthost, uint16_t handle,
+							uint8_t mic_len)
+{
+	struct btconn *conn;
+	uint8_t ltk[16];
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn || !conn->smp_data)
+		return;
+
+	if (smp_get_ltk(conn->smp_data, 0, 0, ltk) < 0)
+		return;
+
+	bthost_le_start_encrypt_v2(bthost, handle, ltk, mic_len);
+}
+
 uint64_t bthost_conn_get_fixed_chan(struct bthost *bthost, uint16_t handle)
 {
 	struct btconn *conn;
@@ -4113,6 +4202,48 @@ void bthost_set_sc_support(struct bthost *bthost, bool enable)
 							&cmd, sizeof(cmd));
 }
 
+void bthost_set_mic_len(struct bthost *bthost, uint8_t mic_len)
+{
+	bthost->mic_len = mic_len;
+}
+
+uint8_t bthost_get_mic_len(struct bthost *bthost)
+{
+	return bthost->mic_len;
+}
+
+void bthost_set_default_phy(struct bthost *bthost, uint8_t tx_phys,
+							uint8_t rx_phys)
+{
+	struct bt_hci_cmd_le_set_default_phy cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.tx_phys = tx_phys;
+	cmd.rx_phys = rx_phys;
+
+	send_command(bthost, BT_HCI_CMD_LE_SET_DEFAULT_PHY, &cmd, sizeof(cmd));
+}
+
+void bthost_le_set_phy(struct bthost *bthost, uint16_t handle,
+					uint8_t tx_phys, uint8_t rx_phys)
+{
+	struct bt_hci_cmd_le_set_phy cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = htobs(handle);
+	cmd.tx_phys = tx_phys;
+	cmd.rx_phys = rx_phys;
+
+	send_command(bthost, BT_HCI_CMD_LE_SET_PHY, &cmd, sizeof(cmd));
+}
+
+void bthost_set_encrypt_cb(struct bthost *bthost, bthost_encrypt_cb cb,
+							void *user_data)
+{
+	bthost->encrypt_cb = cb;
+	bthost->encrypt_cb_data = user_data;
+}
+
 void bthost_set_pin_code(struct bthost *bthost, const uint8_t *pin,
 							uint8_t pin_len)
 {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index ed924eb99630..b3e18114638a 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -169,6 +169,10 @@ void bthost_request_auth(struct bthost *bthost, uint16_t handle);
 
 void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 							const uint8_t ltk[16]);
+void bthost_le_start_encrypt_v2(struct bthost *bthost, uint16_t handle,
+					const uint8_t ltk[16], uint8_t mic_len);
+void bthost_le_reencrypt(struct bthost *bthost, uint16_t handle,
+							uint8_t mic_len);
 typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
 							void *user_data);
 typedef void (*bthost_l2cap_disconnect_cb) (uint16_t handle, uint16_t cid,
@@ -185,6 +189,16 @@ void bthost_add_l2cap_server_custom(struct bthost *bthost, uint16_t psm,
 				void *user_data);
 
 void bthost_set_sc_support(struct bthost *bthost, bool enable);
+void bthost_set_mic_len(struct bthost *bthost, uint8_t mic_len);
+uint8_t bthost_get_mic_len(struct bthost *bthost);
+void bthost_set_default_phy(struct bthost *bthost, uint8_t tx_phys,
+							uint8_t rx_phys);
+void bthost_le_set_phy(struct bthost *bthost, uint16_t handle,
+					uint8_t tx_phys, uint8_t rx_phys);
+
+typedef void (*bthost_encrypt_cb)(uint16_t handle, void *user_data);
+void bthost_set_encrypt_cb(struct bthost *bthost, bthost_encrypt_cb cb,
+							void *user_data);
 
 void bthost_set_pin_code(struct bthost *bthost, const uint8_t *pin,
 							uint8_t pin_len);
-- 
2.56.0

