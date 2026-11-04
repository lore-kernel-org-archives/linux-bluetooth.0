Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817415;
	b=djWm4X7gsx0BAjLpRdyXmuw5e3KGsyLam3h7P2LB2r8gzL2VLwKa17rPCH/f9fUZ/ywM
	 9kq7XECcLeyy3EZUh9HEt445v9b6qhLPZ/0lGEQQE/1XMkK2LUjiQhaQlNeXC319+IP3V
	 Jylx92Rhm1CGdn4Uzbs4yU7UjnFJ6rPyIlgEzkvDLiB4ueQY7hpoEKeZH+5JhJCdi7z6E
	 L8lOen/MnCUjUxwd5pSxAYp4WwKzr94lhZDNokgPpjbDwmejEA5hco3povpZ2Jj9VALyv
	 j8ZCs35Q+Nu+VJeZWPJ2RoKWMeqaTAE4vTxMv2gdrpGEXm/Ai17pGnESsdIy+2PzheA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
	b=u0bCkYt52q6QB6S7w/DyWv4AicBH0VY9byoq7JMiayot45U1zNrNZpicEdiZVGK0vHk7
	 kFFp0GleQFOrD+Aot2o/JObJTEu1tUhJvSOJjDyYNDkQ9BG/fCMCExPmKHmA3BiS5+Nf+
	 h549ccckPkNRq4koEIbnc70O4u/Q8BTEt1rlBpuY2wv7YsOTeB6cs3pK1/7PZqb1VfCVt
	 OEjq73QAVuFq/+CNFKSSVJwdr4n17SUaTDQn+Le99iRQ2g/oDaN02N7qQEAve+FK8AIh8
	 cCxPVWRA/CpUFptCQaGbYUzdoYsXTz1EP7dOAnGMwMF3tjLrPQIl8jZ6c8hG3OqBDvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sXzlL3dE;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2900606A32D
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2900606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sXzlL3dE
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cccb2c96d0so338388137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817414; x=1794422214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
        b=sXzlL3dES40NGtELkGp4GHAwOS5cUi8dsQI80epQ08xzQqMrrk3MTAcjTKUNfwvytG
         uUt0P22za0ZVsk7hwz1IiQzwwZTnH0jRkCVcVwOz6NM89vaWD3KSadhkM/PojPlfILWD
         OGm/sC1YTWvrkZzFNmV0RkjDMr+gSuxKSr8ho9xLQlJOo/OvpQZ0tmZ6Wp4ERjKs1nWS
         LIQAkPM3e/RBzcbh0YLS9I5ENKioGHfykCgPIV4Y/+7wrgUZOGDK2JP87W7NdKiWVZe8
         Hn66bD/76zeHuQisqmJmxJm6k+nkZ4U2ySxzmVtDFON2J2TwbuqouFrkFqb33aynd8Ai
         PdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817414; x=1794422214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
        b=xUSLskc7qh+8o9ONYQlaqTHGXmLlW479NizUR2I1dESQwKKYw/x1hIMgfxmsU+FL1j
         9oFAnEG01H09ZOc1xRUWSqsIMfBEWwZ39nFfZA8eOJSJWgHnwAx+feaPb4uak6if/rBW
         7q1F7jvN79Y49Fsm5xUs1AN9w2QRr/+FCV8g4qOIiHOiIdCzOjfglfAiHooouz+/2IYg
         S6yDCfzUwD4b6n0NbPWrQUWLw8ewF+edNO/41Kdf6CvPcWkgtPpY+nuJVHD03EUElyLL
         2Wpu9HnvWQMDwFZwp1SSbN85EwFu+Le/oNJA8X0r1FGnxcNLt8MLyqObrIGih/SFpOxU
         v5xQ==
X-Gm-Message-State: APuU4Z+LT+RP2DdOjfIGMZdgJn5GhZXKLrjWnbOsObuSZR1DJMW5ydoP
	MHHMj8uLUNlo+JMF0Hi2E69DxlqvhAZk8MEc24ds2bsmlCbLRh4fL3hwhH42/w==
X-Gm-Gg: AYBFou2lOYnxnIl//BIfP+r+GgsvMFkC2XZ93K9xTKbrUwSVthQuoL8bTJ/VPk4i+Oz
	/VRmEXbS+hOgeW4IiB9jwi9IKs+PLhhPFKIhEBNLGvdegeNHKpcy/rB5TiuIRf+upQ8DifEL6IP
	lVhblD/gNax4C/Y5z820xjQLg5GcypnbzxxRqxyOaop0N25fdivCfqVcwRiemspX0oBPV9qEP8j
	tmOHutACEv64thR/FBbNd80+X2Cqk/qZqk5gXSxZfuCe6xheq+FcLnMe8OZNuontQcrj6nRqL1E
	hWAyaEiM3gDjh1mA6Q5eqCdJyE0XVEVDHgjgU7t4ndMac61rpvXC5RoPN/mND0W5ZVMTkUHkLU/
	UbnWieNEANGIhlZ2RmphD+mXoV3rACDo2lnzcz1wsQln5MUlUtzrSuU8Te1uZoeFNfYR5mg536B
	+rDiGBNmIH4aZFwZSlS2wZDn6Ip21i/iiK4Vox5Yvk09rHeokHFpNhP9CJ0zy9myLjyWqBcvhsS
	2Xe9yxxFFFI30cAu1MqdacvqeGKlZqmt6igvwrVzFhrmg7JkP35l/7M8TLHaZ2oN3keETQaucto
	VP1Ytppdx0GWXPxBBbh5vAXQwYZubZwmyGrOXYcfbCPjbNwC3S/xGFOmlGCRFSKtSCMaIdDGETU
	0NU58nS+sSUZw9frPU/6Ab4U7gv3OD6ST8l9rSIDuAAS2fyaRZhlohgiQN2zTfI9wzEcnb4OXEx
	mhWoo=
X-Received: by 2002:a05:6102:3f8b:b0:7b5:4700:3a6a with SMTP id ada2fe7eead31-7d07267f972mr6518203137.26.1793817413769;
        Wed, 04 Nov 2026 10:36:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm696605241.9.2026.11.04.10.36.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/9] emulator: Add HDT support to bthost
Date: Wed,  4 Nov 2026 13:36:40 -0500
Message-ID: <20261104183647.839090-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183647.839090-1-luiz.dentz@gmail.com>
References: <20261104183647.839090-1-luiz.dentz@gmail.com>
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
 emulator/bthost.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h | 14 +++++++
 2 files changed, 113 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 2f05573786f8..afcf453be789 100644
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
 
@@ -1605,6 +1609,9 @@ static void evt_encrypt_change(struct bthost *bthost, const void *data,
 
 	if (conn->smp_data)
 		smp_conn_encrypted(conn->smp_data, conn->encr_mode);
+
+	if (ev->encr_mode && bthost->encrypt_cb)
+		bthost->encrypt_cb(handle, bthost->encrypt_cb_data);
 }
 
 static void evt_io_cap_response(struct bthost *bthost, const void *data,
@@ -1946,6 +1953,17 @@ static void evt_le_big_info_adv_report(struct bthost *bthost,
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
+	init_iso(bthost, ev->conn_handle, BDADDR_ANY->b, BDADDR_LE_PUBLIC);
+}
+
 static void evt_le_meta_event(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1994,6 +2012,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_CONN_RATE_CHANGE:
 		evt_le_conn_rate_change(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_CIS_ESTABLISHED_V3:
+		evt_le_cis_established_v3(bthost, evt_data, len - 1);
+		break;
 	default:
 		bthost_debug(bthost, "Unsupported LE Meta event 0x%2.2x",
 								*event);
@@ -4030,6 +4051,12 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
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
@@ -4055,6 +4082,36 @@ void bthost_le_conn_rate(struct bthost *bthost, uint16_t handle,
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
@@ -4113,6 +4170,48 @@ void bthost_set_sc_support(struct bthost *bthost, bool enable)
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

