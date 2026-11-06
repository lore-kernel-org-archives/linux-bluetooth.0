Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989101;
	b=nWc4u136QNZvbSA58Jni7MQ/NmHATQHGk9IFNPxW4ZQfttzpcbEYJq22hOPhjpPQeZ6Z
	 d80gM5kqbK9sy/Vg8SEXkxYzLA0yyPUyiz7QcprowYdF9wBgH8blN+OYf6AlGBk+FfqMM
	 5xyvO+a36on+JObF8Qebk9kytNIqIri07gI+EVWbtXUdAQOHwuhW1fXpoQAtcLIo7cL0t
	 q85U3L4TGYKapaImPTCORiTZ1+8gd0xNpHeCvOgKNdcocpe2DWyBW6pBjpK9BN9Av0hXr
	 Ppwjevsz+GntEP7zkouRp0dncJ2rDNx3rG5yvShV5bKn2g0HEcf/4svu30WzPNYlUZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
	b=xyjuKcGxB/kdPozqFBycqu2R2N85c1zx7Wa1AU2Ddw0jlPeq+xSIdOxN26MqYv7U3wTX
	 rGxfNu6OuNzh5vVzYZ50ya7nXWMnHATZ2JXZ+3kgLm/+qw7B3f/gOLhpzRotDT77iLrMp
	 +McFavHXzrNCVPDo7mQE9YmtTiSM4nwxbJ16fD//gnQtIUEe9WP0PxIAXfwV0cvlxzbPw
	 SZUaNDsria5uiatTvNtf3tNKseGh46lR17vJYOG7I3vJdioE76SgHyeOAmjsVOLvonklk
	 EAJD1MMf3sidjAnD/l8SZCJBMFOSQjk4iRd7fvrWLC9wVr5fA928YaUJM2VHuUO29Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXp75oP1;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2777606A32E
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2777606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXp75oP1
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eafa528803so323846e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989100; x=1794593900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=fXp75oP1CJcSl+d+1wA4QcTB+PxAE/xSQahuuUK/vP1APXQP0+7lh7h8phRc/zGpxl
         F5S0SD/b2hFiRi95jllar19CLxr9XUDJ7b83XYbXNs1zZpA8AkvNgOIxrxb7thRfOn/S
         05ZVT0CAazX5eK7EwLvo/8fMwniiDdBJ5vr46i4bP85TXnChTNhxYkz8Zy2Rb2L84BQV
         MUuT+ddtiZICl5gL7DOUqUvuDkzunCQYqaREXFMfRoJ9032cpx/aEKvKCXm/8tJEV66J
         hR9wbFeJfqJyYOSoQXRVoNLf6jHXpKi06F3mPTA8KY6zF6lsgL3P+u0wDDV4GSrYab/j
         Jg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989100; x=1794593900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=ul8DrTEflC/YBUbFDkWpc83eni3j8EcufjsZSlWVnrdkTa01sPuMPsZunu77LbUAtl
         txFWaEQ5uXx1kKJWFvs7g2UbKoADADO/yv9DB7VLdQXrZj4HVZ/oiypCMAV9ZfhYAEmT
         wGdDRn0fiP901+8no8aEkPZG8whqykwg6HCBu0ejVhtTicBju5nOm+JFB260t6rhIsRw
         dETpkgapd4IPzOPQJb5Jl9rg/3OkXGMl5YKxKmVNVNmHW+MKeq9mZ1CFO3UWY2/OcEn9
         wkPuf8r6vn3gmyTZnw2OFcRGy5SX301mALtD3YTSAfnaCwk3fo83GywmqCLdK0h/Rir+
         hhfw==
X-Gm-Message-State: APuU4Z/FWpf38OUiI8vUuoOxK9TvQQY0t2Qf+VXmKGb9MGOLDZM2N2Do
	yqGoPys4nK8oOrhAUkkPAJgJHAn7gkU1vlzwtQUHBmc/qTUM7ZzeqiOShiqXRA==
X-Gm-Gg: AYBFou1xfSQDgwPO/3Axfa/hPmGNUSv8XQ7TbrqjolpKgu6M+RIvM42F8MiKZ51F5Nq
	9zxJkj7mpfD7dL5ZZ/elGO+0K3UsJNGopkp3o3pLcT4FOd1m0o4EZ5ZSJmHUnQLKm407L5xmB9w
	gdFEBspRsBmtGWZ6MHHNhC72Jk1H0M9MGQcbWEAn9w26a66clwsksKVYiuI+wzRZnHCTtXNR/dS
	TqUTd3E419/XDq2zdQNG3xt5MeAhGojmqG/ACBl4ELtnO7Yy6eNtVs1pEj73reJZ69wXhaDzZQw
	rejAlKVveZx4ZoP/6zIBmO1sM+vqlYkkF38LwOrGHGOgkICQoVDaZY1/99sKm6XSyLJSLbZhh4y
	MFqCN5uK9UNP7Ybn0/76fsAQG2RXtX5VMtY1xO9axOzrlSIH6THi23QmDaMkqQax5jkw8F04o1H
	5LB+g1VeNQTw0xLOXp+vULxyZAYHm16tjOBUFZ73eCFhTMviSPuFQ0c5r5HvTfKexZjE0Pl4QOg
	7GhHb/L/0joTYs+P+vHBoGXN6jhKrmamnxa78lUggHKygKl2KKSBTUPaHvbI1Op+XpW24V1ow2g
	FLfh6wzFjPTGUalUmx9neTLGYGeq7eNQdRuXbWX2OLy/SrPGcAR/Ui49TOi/5ijAbfOZQRw9Hff
	R8BVKmwJa2dtfPyDGONodvYNA/lfIZgGN9r+2z4HuURc7jWAKB4i0vvvE00GDVfPUYtINLNmORu
	IjmYU=
X-Received: by 2002:a05:6122:2886:b0:5e5:29f7:489 with SMTP id 71dfb90a1353d-5ecc4474540mr1596798e0c.22.1793989099678;
        Fri, 06 Nov 2026 10:18:19 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc6517dc0sm1922904e0c.17.2026.11.06.10.18.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:18:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 07/11] emulator: Add HDT support to bthost
Date: Fri,  6 Nov 2026 13:18:04 -0500
Message-ID: <20261106181809.3134862-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106181809.3134862-1-luiz.dentz@gmail.com>
References: <20261106181809.3134862-1-luiz.dentz@gmail.com>
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

