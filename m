Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087984;
	b=WzNwXEBVUpDpZz+ZZ3zpiICbPlwpVdoCKjxdH6ZPI3Pihyb1Q2ZMpMsB4lFsh5SVYAtH
	 A0qdZPJRCUroQi9Bc0/MJy3EuZHaBwDEn6JxuBn6sr+sKkR6k6jBpzehPtRXWUU+JmFuj
	 xhCJitLqzMr9Y3Lup77lSb74Z9ETLr15uyDO2whdMhufECoiW08p+S+Z/Kg4K3V+YoVdi
	 CgpRFtTfjrsNhUDhUn1xd6/mJ1a9t0NGHgHrkITcJlhZDHxhl0fyx7CsUqtVypk78co2Z
	 QIEDMeql99VvUUFI2OBuqW5y3zorRSmMIPYApZFXMFO/Z24qkCgOsnGpb11wvg1yomg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
	b=3HgliRGBq43uDQBKZFzVvQRnbC1PjH/dpWbxScjkvP1EcxF0XRMCQsPm/eGH4LFVnk5R
	 JLD+ZLMSpdbzmpZBbAhNIiLgYTsuhJLWZdNqCdLmpyIzHMiP1iBKWiVOIxZHfCenu08nF
	 V9xOApT9xgK7NDibEpxsMPRere/MDhEkWPZIbHQStf7CyhnKnmdDuNaqWh754y5mSeF8p
	 XEzklVW+0GHRTAxmX/m5CM/3b7+H2MUvdSJ8gYPuIzBEuZqqHi1nyC/+cCPNQq+aXi7cg
	 Squ2zRipxuaHygfikfgsriMAWiWuGpmsdVpqikVnJwH4wXzgwH5/4xAurASPTVHvfhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxAF3rkk;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62601606A32D
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 21:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62601606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxAF3rkk
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso14734e0c.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 13:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794087983; x=1794692783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=RxAF3rkkeD8JaKasTO3GStKC0YzYTD629lvBcebQhatl6PDKHJSNhqDXkCF4n4DjhX
         jRprtJQqhKFPvewrndUwl6E2Mq+9OYLSKW4yCgJVaitkYAXWd457g0V2wtqld5K7YvW+
         OEO5xg1GrQiVHkTkFOBEilI7SDpwf2ENRn7SOC+mNW47KAIoIi5BYGL9GDHRmJka2ICa
         w6wz8LxJ3GxZxLxuoQdBrp6l1WtU44krmPtcXM6q/aVe7IJrr8YvTR2tWYowh7GlOD02
         Zw1EkkKF9lCt5NgXeZhffcvVZ5yJWqYiyvndKOchl7FSxpRLHxbTmVQF5ppK/OQMf6Qh
         eY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794087983; x=1794692783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=Q1X03Pc7GPBhl0LDX3c70iYBVCsDNRIvxU2U/FR0CVkRA8DkSsdNjAZcOpVvakSMGd
         b0uZ+eDedmCIeK9Qi9t7MrlsEfcnCYd9W1/x9HXRztomnbFpKXr10lqb4KsdqsTe2i2b
         OIqnMwmM+PSZqOAa9JTNHj26Gw38Rs8kDfBsl9Crl1xHX+ESxPIV+WdscuUKX7w2iY9v
         1bVx5lOoFZDon3PDnwhEcwVDx5e2Y9ztyNGFnAnr1U4NxLtuMeNh7sBsDJ2NDbl3PStc
         qWdQ1DPVVmx4Px+APqAF7YSCesuep6kvysk/AImmTPIKenTUv14hOYxA26abwWw3tc/u
         v1Lg==
X-Gm-Message-State: APuU4Z/0jCdeRflfsaiHgbQjXfiUiV+5rY5ny5KWrRoaKRJ9Yn7QURqr
	iiUgofvd5I1Hi4dg3YgXjD0QzMQ55fAJcUwEW7i4VZD7gvyb+7xZPsUNkw4wjg==
X-Gm-Gg: AYBFou2VnZm875EzaK4xULG6Gz6qi5Ou2PyZaKggWL00dIzfqwgQFxN7xt8nCb7wfLA
	6NqBip1Wnnagtq+T6r63FRVhL6E5c7mbIz4YFQHZT9bz0mxu0+4mGaXbSs4mtDWupF2Mn1rBmyB
	wAxCoLmte87Fbwykx3n0Kd9M2vSUPQPJfTP0w/3JzxM4/0qv5HfsMSwdryw+W2oNvv3gfZ1WY6k
	7+kOcVp+9cGSU4BlCRPc32Uz2S2MST0AV8JZ11WkATOyvVfKaWyltu06fbdynWmE/0lVTRVw7k3
	zDK4eiW28v/c4m/TynDnC/yZTn0yFTWlcJda8CrBfJ6NKtAgyhv9u5zebwd1G0V8znKH+hXsMsp
	Pl0nuBBcFpl6bhvwF7bi4AWvakXPdqu4CzwQYGdF5nlu+y8HPzBs6yHtA4nvPaJFLttNVrRYcwz
	ECcoeYHawRu58XNSx2QNq7sMMG3dlZq8gWjwT5+oTG9v+YsEjvQBitV+3YIwG3SMK7mJqzo76Ig
	R8BMGEvGPIX+MoI8X4hbt44Ym+yNol8+Am4oSTgmb5dv2I2z0TbHKHSZDKpzkghF9jwLAEKYYJu
	vPpytYZaObt6erEdtgXLvLEM1hjVzjPBqwQ8eC7eO/VLtqMSav2m+467uQCkfPMXbqmOKhDR3Du
	JB80/RcNIoessKeUKjs57j/1mW3J5scum59JfS/LvyMiE/0F6PgOSqtVjBQb5bZBeeYdy8p4+Bz
	d9A4I=
X-Received: by 2002:a05:6123:12f:b0:5ea:9218:eac1 with SMTP id 71dfb90a1353d-5ece735dc6emr46079e0c.20.1794087983275;
        Sat, 07 Nov 2026 13:46:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece6418de3sm382617e0c.13.2026.11.07.13.46.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 13:46:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 07/11] emulator: Add HDT support to bthost
Date: Sat,  7 Nov 2026 16:46:06 -0500
Message-ID: <20261107214611.388705-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107214611.388705-1-luiz.dentz@gmail.com>
References: <20261107214611.388705-1-luiz.dentz@gmail.com>
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

