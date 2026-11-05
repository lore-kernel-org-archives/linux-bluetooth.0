Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898762;
	b=M4oJ2lmud9D+Vsqgi+mBbF3qBN0OVnjQUcbEvPSAlyCibcD789jY0rpTlu+UG0gTD8Z/
	 J5BnDRVMPE9kuUckVGbbRhF1FjLdN4p7xFoCC8U6qN/0ciwJfevT/fTvfNPMn/s3WGzRE
	 AirS5E7DqCrgCOlxrWL6gSMYWcNhKZnsOX31KlPTQg7wWzW2MaSdA7DeuHePF615ItSiG
	 U7qM41tDoPK+jQ0TcHIbtYnuc+hdAalLkOdiXueEW13AKM6WajLfMkMZooVV2PvpSybN7
	 MOK8JPv19+dVxeRkfM4nvqzb6Sj3b/YCFe5bfuf8yFqwKhMTv2S3tl0NQ/sVCuztEQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
	b=zHjeSTNA5VeawkNS+c6eR6cWGDmrNc0EytcBMNCIVEJOwF0YdSQZbiXl4SIfZG7dZU9E
	 2eIsqmb1N2ohHtrkuGjjJ4oAkFV9MMwGDxEZTqO9VYIwqP69+9GbDQihEuilZix4JLYMC
	 8aJeea6D10m2dhDNjebTy7KNF8xtIh9pPYNkpA378kKqgzBCgCK9Pk7S37zL7e5qNWVhn
	 fIx3ECoKJMQh7/3jv15OAGew23BPuDIhqG7hPGCK7ZU/piH6BTKtAdp7D/QOnyBBIcEMD
	 VjFZkUf9x2WvRHjUMpszIQFhmE/PEKhgwF54vbPDtC++xjIgY7UgH9HJ8gNBtImbB5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qt1OGoV2;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A0606D809
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827A0606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qt1OGoV2
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9912c47367cso635121241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898761; x=1794503561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=Qt1OGoV2iwjZ5WJ6jkgbvCXPaSI0Omusf66kAYVoDQXuRcruKYPKciZHVCrDJGBOHj
         6lIVU3X27OSE0PeF+NXUFbc2VkwU8lunUYuC+11fTSVp+2dnV1T8skvPLTVaq1VjseP4
         WwkveGlqDaocZzA3+1wfS9Y/Zrc6vpRezteV2UJ2fwhWv7qSYu5svnEmw1ZnjaGW9Hhk
         6RZjf2Pn688Ye0CgTm4pb0f6YQTNr3nQ0Rbbxn5bHr0p2Qk044rrVzgbaY9oh0PghZaM
         yCDJXs30WUXbahv51DO6TduHa77llJjwM3Vr/3UiiUlE4qqAVg5sPDn75F/Iy1FywvCw
         sQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898761; x=1794503561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DmTem4XXNW7KoCwmaH98aOX+dBkWC7aChEUbVcYzw8k=;
        b=BUOUO2WQ5ZrN8NIfqPQFOS/U4CqQKgEJTZFwHQ8jCB1iz7umUuIr6db9cTNOaS/nqg
         hS3uZBhikiPiXDKp03KNcEQyYOv8eov1j6aW6PW/R6sXOnoQg/3T2GI/BhIJGXh9+P78
         8ETQMZKGA7vi/vUTpzYXamkjBkT+GQmise4SP5+kueLiF8gWDGIZpx/jPjUGAvfezaS9
         jxY9M1z8FfPEbEJqL+aW5sxxdPdrBxJfPMyJcbgdMPq75vEaFaJNDFZDvQoPSSezM8qS
         A2nmT6VAObAeeQhMNLNtjI2toCyMs2L7zAwWKPcHt1KZQG/PJuQ4E0EoCg+AM14UizHh
         uJjw==
X-Gm-Message-State: APuU4Z8ZxWEMPMk+jHZAIsrjHAVUK0b7U/y1lNQHYKGc5zyvFSzADYEw
	rBQ7k9lrwp6k8RexjrF2C+qVoQTGI3JAIsWifzOu/zNxayUJOMqVYVXRB3hXkA==
X-Gm-Gg: AYBFou3oL2a6kYNlRUCN6rxmYGuv3usUMkOw7sAGVCZ9yV2mLpJY/RZr84HgUIF3WIs
	C2WFZ+g002GF3cBpmQsEfq4miQtAHWarv8tJZBBwjLB19pMbzRT9qsdbTezEfD+SZe5zE2aHTtM
	bCr8a6YQZz5MtD+TPGDkJL88AkLqWluAMx/KQirHK2GymrgeNq7Y8zdqKSY9Ev16Hm0+lEeiDHe
	Mz9HYhZ15Fy6XyScZnsvng99VggZ1Ge89th0jW6zR4VfkicXZAdKOi9JZ29+r/6UIXYQ8gYxS3y
	T9OLL2BwEa1ttvbKZWU3AS0/Yz877PXWix+qtwR67ZfL4RFR4kp0XhU03NJ/MdzX95dyk4jRKa7
	RJWb8/nSVsbMMJNINyb4EF9gOI757x5x55WpL2h90UjsgXDVjFdrWv784u+7ytm6jHinVWT2Yzz
	SDn/7ABwEvRxCLjthyxVhjcBB7X1wkkwOkoZ+upHnf3I+sfjs1xUgUEXtmxYVghMsebXkV+hwQT
	DAlOY8B39+AUrd+RFXcJvz4bmgez3EJO9+olIT7WxWfDfEOtcz9DpEGCqXPFHlAyvFt8/MrtMbh
	LXqfzK7cGG4ZczoX6qG1fsvNxVVboKkygAvkBHCHuiIXkw/q7rFyRetLwjrv6qM3rdw3v6Mgeo7
	Svm7lnmNiHOzg+Wn9mOEEPHKbu3ZYVIEDSaBqKOlnki3YzVTN5zbjUqIJWv4ZxM6dN/X22hZH4g
	Kdiik=
X-Received: by 2002:a05:6102:549e:b0:7cb:bb7b:77e4 with SMTP id ada2fe7eead31-7d2a14afab2mr117174137.3.1793898761370;
        Thu, 05 Nov 2026 09:12:41 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm4050798137.10.2026.11.05.09.12.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:12:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 07/11] emulator: Add HDT support to bthost
Date: Thu,  5 Nov 2026 12:12:19 -0500
Message-ID: <20261105171229.2053802-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105171229.2053802-1-luiz.dentz@gmail.com>
References: <20261105171229.2053802-1-luiz.dentz@gmail.com>
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

