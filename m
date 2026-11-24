Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553469;
	b=5sHmmF6iMxtNAu6QYL9yc8g6OEMpyRDw/0ffle+6zNYkKd1KDk8h7ZNP2JMio5jQUwSd
	 iuShN+qiL562cmI+4m1ArRv2cNqVKc0RrAX2tPcGp6/kAJ/Z8N50GdzdV5fRfru8wSUrc
	 rLaD6jYLeFw81LyiWTKJCJRmTjzOUKkaHkz4RkGTHU+JzdjSTIJpFK2QfS1rih8T62ToY
	 ISM0t5lhKEn56YOEsi42uT8Ve0kxSiaA8Wcg1wrBW/MUu4cWICp7Vbuv4En0Xx9gugxbc
	 rVzd9S7Aw9NWXjjU5Nnyf2d1QZo0lo8u1H/L3C7IcUBwYXCzixpFOBZA8RzpMoKjxWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
	b=YYfpMPxTwLn9TJeloktmSv72I/WPbSFgnWgiI/MAxezwIx7dVqCwZgljRl65ExNgYreH
	 P/QMX54B66zH6j8eDi/Ako9lKNh/WKCVtUatkvR91NR4CJytN2pB1oGxlnqv0TbvJdQqy
	 mUKuDAcl1Lgl7mAiWdz33Hsdn8K3jk/TsfK41WbExeoR46ON1umb9TtSIHWuMY+eZWImw
	 OHNBTlVuRm2KQ69nUMUW2xb0ZjnNsXnQil7mFtryCY/65m0dIoPtFANHN5NDi9ccsvgi6
	 UZ2wMxBBOrxxiE38s+6HJlEz0UD95bteLon4PIxvDshg2IzSI0neABOouxXNBGXRmfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YplXn++L;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64E606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC64E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YplXn++L
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ed2f163a2fso1641877e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553468; x=1796158268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
        b=YplXn++LzwuTdscu7b1Ekf5inn+AndB7dbE+UIH3bczHYxZ1NdngFAjb+M+X1GPcL6
         Y6RbDGLAC4oKjrknxhvSGCzGxkz3jT/Yf+RV9L6sT1AloUF6rXoWF1w+GKDQyYDwyHjh
         9NKFfll1XFeIEMP/wXvk1hzv1MX/+8XJkahcTAsQ/iqlfWulIg5S/pKkswZbJWS2WNSv
         7rAKwpXQjIe6dUT2rBPu1s507ND3l/ZLNraWtGJM9q9taumYEj9U7yr96zbITga69649
         Jydd+SZsE4vY2oN8bcZ8KacASGoeKUXoYnBmvs7ysOOTryXwQayoA0srtuaWnZu5qywC
         rVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553468; x=1796158268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
        b=qTXvW11kAMPWFJDVNzpwIMBn86XBUpC9wPdAQR6lzwKP17UZVbB5V9lsjvpRTEoaxN
         tYMhkQwLjEsW81F5RT7I3Jumxkynp+eOpmqyfy1j7XwytRW6++eRs3hCfC0whE8McG5E
         vaUyMxE4JLFvtOharVuQP2AtsZxppxfzjXd+ZS0WAD3wwvhogotY2E5jiVzWBXzZu5Oy
         QRiVXS1ekRpYdXqDb9NxOqTzzTKDZTs0ap99uF0au6FfBJ/Qc6RjUwuLwCKzS/QwL2tw
         PgP4fvNROAMj9OvuNAEcVgj6s/VPaMtYSXCDrlWeUaryq/kQ59I8GVDPQVQlxM3fsnr7
         h94w==
X-Gm-Message-State: APuU4Z8KB4EydBei3jgn+bRh9xhbIvIerAQfHVU8n8HH9QSEq1/8GAYw
	WBQ+7xJsgUyU0Pw9m0nwyjXeq89hN2oSQaEM0EWzvyKiF5wDucL8+e95G3l//w==
X-Gm-Gg: AZFdTZcjbbKpiktufRZ3y3szGsCRgYAbdIG+IUcF9NJsSkEBbHt7Kf9ij6xhEvtd3Pb
	cbm1t7Om4r24spForabnrcRbEPAEk3tb63u9w2ufixeuV1gQHUNKyBLkwS74uGAJl/kYiTX3CGC
	QMu/ufgjuHNmbq/YXwANWm30msTAgfunfZ8iiMJdHL8a9uhVQISlLeyDPALFWprH38eG9zdvGWR
	y6QChNQqqSgvM6X0Jt2P6//g8E25s0CACbIWECIMgSQ8ogCPI63McO2TAmrjw8m7Fd1jPDSg2le
	FRkLG8up9dBKIVNxFD1aDBD5u81F3LxC8UU8WXvnOolBKg5LHquMTHnU6g1899Ceu9gh1/Fs/MH
	a5539aaAyWzY4ImbAUJ8w2r6G0s1dT5cWfaGo4bU3SoM9hneWzYpVUIg0aBrPILVKVNEIb3k37n
	1IFw4D9orzud+KtIom6Ks37SEirQStQ1Min2Vt0KX3AJzIsYlbCWByQAmjNzgzNUmXV4Y5jR122
	wgraybamfjQrFnbxNfQ9Mhmv7ETlFnm7/GpR+YMxjbuJOQD2Nftof+Rrbz7AjAOt7RjodSb7iHf
	RcUOe2LGJiOgaRKITMjKrWpPjAJRLmy0eWrk0bwgqNoXeR0YLZzQGEgWZ6jY/9waROnBNfVtXQs
	g5yGY+S+lfbe6RYMxcSoXpfQaWodlRzR8RLbgvpoPXuO5bVUN4PbNOQrq8a17aJwOR70WEinBLD
	TWVESm
X-Received: by 2002:a05:6122:62b1:b0:5ea:b04a:cefd with SMTP id 71dfb90a1353d-5ee8aea71dcmr8258404e0c.7.1795553467692;
        Tue, 24 Nov 2026 12:51:07 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee91a4e0cfsm13929876e0c.13.2026.11.24.12.51.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:51:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] emulator/bthost: Add helpers to test security of deferred setup
Date: Tue, 24 Nov 2026 15:50:58 -0500
Message-ID: <20261124205102.737384-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124205102.737384-1-luiz.dentz@gmail.com>
References: <20261124205102.737384-1-luiz.dentz@gmail.com>
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

Add helpers so testers can control the remote side while a connection
is pending:

 - bthost_hold_auth_request()/bthost_release_auth_request() hold the
   reply to a PIN Code or IO Capability Request, keeping pairing in
   progress until it is released.
 - bthost_set_l2cap_rsp_pending() keeps a request while its Connection
   Response is pending, so its callback is called with the final
   response as well.
 - bthost_set_conn_encrypt() enables/disables the encryption of a
   BR/EDR connection.

Assisted-by: OpenCode:claude-fable-5.2
---
 emulator/bthost.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  6 ++++
 2 files changed, 92 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index e65d29faa989..afc83891778e 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -207,6 +207,7 @@ struct l2cap_pending_req {
 	bthost_l2cap_rsp_cb cb;
 	void *user_data;
 	struct l2cap_pending_req *next;
+	bool pending;
 };
 
 struct l2cap_conn_cb_data {
@@ -273,6 +274,11 @@ struct bthost {
 	uint8_t io_capability;
 	uint8_t auth_req;
 	bool reject_user_confirm;
+	bool hold_auth_request;
+	bool auth_request_held;
+	bool auth_request_pin;
+	bool l2cap_rsp_pending;
+	uint8_t auth_request_bdaddr[6];
 	void *smp_data;
 	bool conn_init;
 	bool le;
@@ -1543,6 +1549,13 @@ static void evt_pin_code_request(struct bthost *bthost, const void *data,
 	if (len < sizeof(*ev))
 		return;
 
+	if (bthost->hold_auth_request) {
+		memcpy(bthost->auth_request_bdaddr, ev->bdaddr, 6);
+		bthost->auth_request_held = true;
+		bthost->auth_request_pin = true;
+		return;
+	}
+
 	if (bthost->pin_len > 0) {
 		struct bt_hci_cmd_pin_code_request_reply cp;
 
@@ -1667,6 +1680,13 @@ static void evt_io_cap_request(struct bthost *bthost, const void *data,
 	if (!conn)
 		return;
 
+	if (bthost->hold_auth_request) {
+		memcpy(bthost->auth_request_bdaddr, ev->bdaddr, 6);
+		bthost->auth_request_held = true;
+		bthost->auth_request_pin = false;
+		return;
+	}
+
 	memcpy(cp.bdaddr, ev->bdaddr, 6);
 	cp.capability = bthost->io_capability;
 	cp.oob_data = 0x00;
@@ -2437,6 +2457,29 @@ static void handle_pending_l2reqs(struct bthost *bthost, struct btconn *conn,
 			continue;
 		}
 
+		/* A request kept while its response was pending only expects
+		 * another Connection Response, other requests may be using
+		 * the same identifier.
+		 */
+		if (req->pending && code != BT_L2CAP_PDU_CONN_RSP) {
+			curr = &req->next;
+			continue;
+		}
+
+		/* Keep the request while the response is only pending */
+		if (bthost->l2cap_rsp_pending &&
+				code == BT_L2CAP_PDU_CONN_RSP &&
+				len >= sizeof(struct bt_l2cap_pdu_conn_rsp)) {
+			const struct bt_l2cap_pdu_conn_rsp *rsp = data;
+
+			if (le16_to_cpu(rsp->result) == 0x0001) {
+				req->pending = true;
+				req->cb(code, data, len, req->user_data);
+				curr = &req->next;
+				continue;
+			}
+		}
+
 		*curr = req->next;
 		req->cb(code, data, len, req->user_data);
 		free(req);
@@ -4276,6 +4319,49 @@ uint8_t bthost_get_auth_req(struct bthost *bthost)
 	return auth_req;
 }
 
+void bthost_hold_auth_request(struct bthost *bthost, bool hold)
+{
+	bthost->hold_auth_request = hold;
+}
+
+void bthost_release_auth_request(struct bthost *bthost)
+{
+	bthost->hold_auth_request = false;
+
+	if (!bthost->auth_request_held)
+		return;
+
+	bthost->auth_request_held = false;
+
+	if (bthost->auth_request_pin) {
+		struct bt_hci_evt_pin_code_request ev;
+
+		memcpy(ev.bdaddr, bthost->auth_request_bdaddr, 6);
+		evt_pin_code_request(bthost, &ev, sizeof(ev));
+	} else {
+		struct bt_hci_evt_io_capability_request ev;
+
+		memcpy(ev.bdaddr, bthost->auth_request_bdaddr, 6);
+		evt_io_cap_request(bthost, &ev, sizeof(ev));
+	}
+}
+
+void bthost_set_l2cap_rsp_pending(struct bthost *bthost, bool enable)
+{
+	bthost->l2cap_rsp_pending = enable;
+}
+
+void bthost_set_conn_encrypt(struct bthost *bthost, uint16_t handle,
+							uint8_t encr_mode)
+{
+	struct bt_hci_cmd_set_conn_encrypt cp;
+
+	cp.handle = cpu_to_le16(handle);
+	cp.encr_mode = encr_mode;
+
+	send_command(bthost, BT_HCI_CMD_SET_CONN_ENCRYPT, &cp, sizeof(cp));
+}
+
 void bthost_set_reject_user_confirm(struct bthost *bthost, bool reject)
 {
 	bthost->reject_user_confirm = reject;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index b3e18114638a..92aaf42305da 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -206,6 +206,12 @@ void bthost_set_io_capability(struct bthost *bthost, uint8_t io_capability);
 uint8_t bthost_get_io_capability(struct bthost *bthost);
 void bthost_set_auth_req(struct bthost *bthost, uint8_t auth_req);
 uint8_t bthost_get_auth_req(struct bthost *bthost);
+void bthost_hold_auth_request(struct bthost *bthost, bool hold);
+void bthost_release_auth_request(struct bthost *bthost);
+void bthost_set_l2cap_rsp_pending(struct bthost *bthost, bool enable);
+void bthost_set_conn_encrypt(struct bthost *bthost, uint16_t handle,
+							uint8_t encr_mode);
+
 void bthost_set_reject_user_confirm(struct bthost *bthost, bool reject);
 bool bthost_get_reject_user_confirm(struct bthost *bthost);
 
-- 
2.56.0

