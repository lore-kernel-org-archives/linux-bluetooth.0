Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328511;
	b=mS+aZirX4Mf3tlpT6+wlnYTzyOIJfVaSXgU9sYkZRqSA5LlevEIA795ysW6DJELatCMm
	 +c3IqduOC8OloG60vtMK0iS8cFmJKbpuVMnVvxQy6AW56OOB9iVWwzw5HVXTslnq3+81a
	 /pCGBJok8jgvlSjOCu+bVII1aYN3zAx5yVLT9/DT8OfBuhfwaSY+36E8uMSH7Mio/5RlK
	 52tZ2PbqUgo2bkUyYaXWRHYjkyYn6ZAUtd0BN8YWKzrsObHGsPNVCagWk+9nACa5B7v45
	 Q+cYItHgdEolb2cPYVcm1O4nKs7Eb8wuyc3fFrmAj5gS8Ql+00ZtJgQQjUFZRcOAXrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
	b=b9KdfOlQwyKf/3MpvxeCU7XerdHTg06pip0Cay9hFLNIhOrGu/lUe55pY+fLScbf/C6Z
	 9LhYlO7iU0XWbJDcuE5o/QlRXUtK9ng5uayOOW2H9jqFmNHOO56keSI1Ht+SPtCH54v7p
	 QI+Mr36yoHYkmCHHxJibBxqsduGNsR2oRs8gIcmMs3lgtnUjB5GHXbrbTqDNzxBEmDXeU
	 LDNwcR/r2yznsqm2OB3sAY8BMLhfALZutVLmnb/46sbReVox7H4HSfSCxb1fmRBKEW5eS
	 cA392IB0mcVgiSrYxXkyqDxSc71bki+JlYr6ajNSlVk7F3WfWEwpJSlM80FUshjJweA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfoXIq1q;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59F606A8B9
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF59F606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfoXIq1q
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-745497ac8fcso800160137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328510; x=1794933310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=OfoXIq1qoGpwKaLPH6La8UIXFoqI17GtstIICdbRzx2Oq8X+KmNk8J5cxbpUdDQEgQ
         RFYaaz6tk4uBDgdC2c2wk0rKMUlVIidHuAQ9I4cTbx80+J62HcpPtIqjBeW1ILZQMXr+
         Ppwq94pGjvXIWu0ibeWKJYWOwpcQIaeTn72feNPRyFdTuNpLqHc0CilGXijIHk+nQVJU
         mMJtu8K9170YGlU4wbW1j/L8WqbgeT+9NHfack405oUlBqRlC9SqEztdaJSGlzyJcFoZ
         PufkFbqu3/35qIcalQG1xdAx85Qp1bldZ4B4yEFTjJjy28EAzknZ8VT2BTUwhh0g8srI
         4EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328510; x=1794933310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=xCGuULQehB+2DfWZDT2+N49KXn8skh3mlAR+Xnh+nOYpxhG+fFmoSO/4K0ha3BMH94
         bvLaDGXEyHIFFP5lQrszgSABbTSVxQVU/NaSvGAHOZ4/UPTn8wPvB/a6QeOa+X8ivuGJ
         l/oo2Hy3LFjGzpUrFSxoDxfCOg6EWyTKUDsEkNI2pPvcyArnIyymdmjalDtNSwfMug9W
         UBRFYemVRqd1UnzHXCqtE1LS8dIzFd7bB9Eh+n9QLCcoXgXcJT9aVPvYc7yki6V3Upq8
         xeKtA4DgvaoY7xWCk7vgZhbLBlibnfoAC/y8COSfyHHHV4cqQPxcSxuVC1ot1ZsPkEr4
         derw==
X-Gm-Message-State: APuU4Z9foX7CGCEHUfKyO5Qt8rcJ3nblUbE5mbPd988WFsKtmpAhcf5d
	HvC1tB4IcEo382c2ng/5aRWwQUFBbXRZTWz9sdaPcxpepBzotTdyvODnMNOEnw==
X-Gm-Gg: AYBFou1Ep4xyvVc2h2g8hQFSsr8MymiSU+z/wDmJqTJezvCyayGy3vAeVtLe08cULN4
	KJNsnQHhlmXMvgTGBzmMphGLlXjeFYNA7ZQs9m71+R0eAjgrke4YmYucy4HlMNXeM9f0DVtHCTO
	h6snt146IoqKxtReaxqqZIK412Adb4XRpQ4L2ewxuhvIEEWwHWGgwJH/smD3j16bwTl3v0vivNx
	Cl8WimtZtaFLignf255wjmUwxIvLQJrSa8pcj5Oi4tbQjBObcDSC3VU8BgdMc7lMZlS/7S05Ai0
	nMda/sCTxhOtup58K6atYbOy/pcX1o1Tvn8GkSFu8bCQZ85OxmEWrQtIuRhxQgoVbY8p1Ck3sf9
	54JTD0+MCiXaqczs9DXUs5COmOSdsjWLwTJ8JjyhNeFCyYrEVy0qa75Wdi5vT/3iQyntsKT+Muv
	L6pVav7ucUgcrzDMmiuBqH6ohDt0i9E2cQLZaAPtuK8wvo4/98ak5CsXvonJmSPMArgLB6Kx/hW
	WKGAxBwws/lwC0nh6iE3gONetfT1SoWylzPqG0q+5V7JYTbFheipZ3NTMaoNCticqNwf42bUEjB
	ZcpnEjwng/3RPd3yY/SdUee/Sbxwuk3xjr5MFNcWP++gx8OzuQ2Q4PrWSl8xhH3Zy/7TlbyrmXC
	uZ8nnjNTX1aR+Sxl9lnN/uyJCu7cvmg/sECqfdzqRzxqDNu0fgHjfDR/kBLXN3GvcqU5Rh8H2zX
	+jDco=
X-Received: by 2002:a05:6102:c4a:b0:7cc:2152:4f95 with SMTP id ada2fe7eead31-7d301addaf8mr1047869137.3.1794328509592;
        Tue, 10 Nov 2026 08:35:09 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023543casm1989315137.5.2026.11.10.08.35.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:35:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 07/11] emulator: Add HDT support to bthost
Date: Tue, 10 Nov 2026 11:34:47 -0500
Message-ID: <20261110163452.2649366-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110163452.2649366-1-luiz.dentz@gmail.com>
References: <20261110163452.2649366-1-luiz.dentz@gmail.com>
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

