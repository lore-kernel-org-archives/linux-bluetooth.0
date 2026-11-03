Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744397;
	b=AFjjWRBkQ1Fuv0W5QDJXQ3VdePA5ekcWY1XUQKv33k3BggsOvu8D4RqFGemkPNAS1A6+
	 n5BlM6WdkHaYsp+2Vb7pXCBJ1+Cuxdo1lyC5hj0YpzupgnGSeGhUw62YFCMh92Fd1VWDy
	 QVI9iy0DrzopkxpjXswdudsqa4HgP4NunN3Syvyo6EMtn0B9SDIS0nth+kMj1QOWxwziT
	 1B+AjWGk62MLxUw8JWDfPu2cDP5eoQYaKsBOXLokluCYCup9IlZG1n4mKwasLOjP+BQgK
	 sGsJYVdr8s/q54pJlreYs+paDUM/EqrOYJoxhZPEP7NPtSMV8zV+/HXfKk30vR67OkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
	b=2JWrMzbEz+DsJJ28Hg683/pkYL0ocQVOgJOQMw+PCaIkEJkZKn+ex3F0VdsWSZvEPULo
	 7yx+6qfafTQyK9ULPKKaP5aIFpAN+tOOb7/alOgewjk4qTFujLMK3wJp+R2xKSB0WYSGm
	 yt44Q0D11W/o/+7fG5+BQC3HSgQ6IafcgOpQbxnuP0li9b4RZC+8ynhVXA+FQ1rHErVdm
	 hf3OcX0s2u4RYYz16w+lrAY6bNKTQ8mYQvWwbyAEQYl9Qyvi930qATZSmcsgOHlp9Un86
	 XhclpVVgXRvIobQZQY+qjOxbknIoP/Ihkm93eiR8MLWqMKMxXGcyQoTqpzYuhODIttg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcYVHqtv;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D87606A32E
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D87606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcYVHqtv
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eadef147ffso13350e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744396; x=1794349196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
        b=xcYVHqtvg3mh0LAGdhKi2ORhh+l5ygHNAQoEtPcz9HDOj23/zM7HdhKE+mXEP+6/49
         J9mcDftDF5xhaPpojd2IWjRW3JAqioTDgWW9G0ueh5fjn3+LeYLUpfjpreWOuXfPqVe2
         eWYh95BzczP7037TJNizabea6CEqBxyp5Z88RbAWk+c0/CCk9yYhTIAPw7tmiwZOzmdc
         ZrVV/sz29Ej8L4Kc1VOjSuo0uFX0MUeOcprcmKgzuCOC5eRnrmD7ZlxKCcSb8nYnY/b9
         Ss3TuVdXcXp2js3VOA2YNJ1jsehDsWSM6Bcm6I016OBDvl4AgFBNuJQC8KNFjBw7+kZr
         Dyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744396; x=1794349196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
        b=LOinLYKjQlmCfjuNR9kU9xO1g9bnUMyCNYA/3UHYxckraHSQ41wOVnUU1nKOiUTH7n
         rgZ9m0FMXXbTl1XQlUDdfCW7wN1gv1n89LxGvFcCA1ScnrFubpfIKhyzryAroDTPfCgU
         jJXHw0FNyIKu8pmh8ArYPVEs+08bQZjNBwzXxuWm5qcj+R6su0tdBoZKR4kiIQDH0jhc
         Itz7IWhdU9uGIZDSTscq+6kNxJ1znJYQR5BuDPGm8lb+K3r2sC+gM7rp+Q8+YWgSlR+4
         ynhPJ3bzWuyIYCm/IbhsUwjzfnidAE3hpcx6kADqdwNc+bgmp50jh7MscK8QUAtIl4cm
         QxvQ==
X-Gm-Message-State: APuU4Z8v1td0Fhwi/iP6rc6SxCCcuMxrGgqpVWrlNSQjPb5GIai7ppnF
	2UygUlutd/+2hgZwwhS7j35yLNBsWBB/u3wF+QTL1EC4nok9oM7MCV4Ueq7DuQ==
X-Gm-Gg: AYBFou0s99luVT+KoLLy1mxKvodG7CPsjUSauKiII10WVll1NCRzzxZxa0h2I6iPCC+
	ws4KnWEoCpOvdN1HtjKX6eW3ybsHb8c5GlJeQxI0hne6+tXvAktsKe9DfIdGcgsUYgwMVpJXocE
	K47WCxnKgPmAFdnWAn9apI1IovG4CKnFvt1EVqPE0bMS5BFpJPSAuIN9B130F0V070jc8m50blr
	1FEoMYEkD5BFGuH5mz/iPpaY2N7nLFEfKi5fEq1dHmQSQNrQXjZ81Js91DXS+Hf06iWohQ3EQAx
	X+ljZL/Nzk3dLTq6Xd7xRmU+njJD/mbFdyIM45YqD3SQw0nJ8ay4hgO6yndXCvpjo9yjTkjoBP5
	6ZwRd6qV6HfbYQj/ZNP2IfzqwXDSU9wdnCq81OngqShZrEJSb3bMJQnhmRM2omV5xOrM4CuK/ok
	mbC/oRgSkE0t0Y/V2vbzF1uZ48V+QKzFL8UGziNv/z8P5tVO7sQIQidr844q7NqiVS9gyonQaZf
	/DFY1IVuyZk9fMxVJvrIM1RcOS8t8qkRx4HSkfbyxfKZaPdXqtcR3oxQeOzjlSybwAXXdqRQoEg
	yK1XGJwKl0YRPLO/VMgQHVzqHFqE284N1iraL4NqBzW0PmJgxrZUuzB6t33a2pt8fTl5GufsSvG
	rn/Og2B++1eksAggt7P7/pmgTKzQxNFdLPlFw88LByaVsyopamj25ePaQ5j8RoOsVPRMdZpNGLY
	7s/CM=
X-Received: by 2002:a05:6102:441a:b0:7c3:881f:b775 with SMTP id ada2fe7eead31-7d072cac30amr6244319137.24.1793744395801;
        Tue, 03 Nov 2026 14:19:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.19.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/9] emulator: Add HDT support to bthost
Date: Tue,  3 Nov 2026 17:19:39 -0500
Message-ID: <20261103221944.4072041-6-luiz.dentz@gmail.com>
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

