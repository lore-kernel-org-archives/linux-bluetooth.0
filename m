Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624110;
	b=mgrsc1j4BZXOYa5ptVOBkxckbCCts6M8JYdYkW0QzaGNe2LxTh3hBvAqvXa8/O2x6EtO
	 CXXP4zY5xabmI4Yh4dy/goEMlpUNnwpEeW2X883t0P3vUrZ98tPCmHtm9Rd4PX142pUM5
	 hFWz0Lc3jtqL0K31/XL1svPVnvbea9WNUMAvKiJDe5NM/yHGkIRIwndCersvovu0gnVdb
	 mjuLp4WnulMOho1Nqia/vhhza+jyL0uAqNYY9yUCBDF1Gx4gkrMfYS/ypwoSMnB0B2Ov0
	 ALY4canGozzHkNaCwNVVD2l5JK/LWYgwyaE6xGEjrwGy2SQVTV+Et989EvEbBGiR2kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
	b=G3kM+P4AVsmq+99NJhhP/THYa3xwcxICZCwiP1udADz4iXaGCRhb7vrWduLz1nj0AMVR
	 2ONczQN5PZtXd0nZfh4pUDBec+ptGxvNOsQOllR4mpvM5YXKHcymDEVjidAPW8a2r6+mW
	 fqfRcKjjEb7cUtlIU6+udnvjKDVCDHk7SeC1Xlj7kitQZGHpnJbWhLk8Pu2187ATzfp5O
	 KdepO3Vh/64f0evgZZ6E2IdnvuyfQfsRTd3z8G89kFKW/Gd2vhFlqjHH/GghxrwHNfYzS
	 REA4TMtoqvx6reG5MFP559BWBok81GJ1B5ZUDDFaSx10a4Ihj2cECWH5Cp7vYu1x7tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OVKSSDjr;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10426606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10426606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OVKSSDjr
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99e0d9b3438so1449284241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624109; x=1796228909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
        b=OVKSSDjrwJgBv/GqEdPfU4O+7B/V7PAd0uEuot86kH0aqRkPsRXcVrt+o3dlQa4hz9
         t5bS6WeDdYB6xucopTc35p8iqeRhs7haDEx3Ce8+YSU3/tcd1wqX8N57LuTesJGMz42J
         gJHMSXlkCXmjAh3AMyhm0C/ROgDh5ECx6LDqzY5KjCjURjnKqw1O3oZwAXhv+rPEdeFM
         LbeZdv3li5Dk4S9h1wzHqpc2PTtPr87beogTSmvhBzfuWRGkK7749XavBjoUFnOje5Fs
         BE+vtJ4YLzDdvE0i3KtCttoFBWpfu/rolLJzHvDREkfX3Ce4DNRuFJq0WsXtHL9O35PH
         dtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624109; x=1796228909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
        b=jwkC35UPwdZSARg/JIKF6ylgDT1KyaNWGS2K4WOCEcaxDdUy6drX58U3BZe+1h4Aon
         Z6rs8uR8m8YjAVo1CEedZoFReiWJBpGXYtGZ4F0Rg0BbCcdbLcMsYJkwBin2FsyayEqo
         orkHKJKSwDU21hMH/RY9s3rgd4NkYHHiI2K40B6b07srP4/eL3JF49UWCLkFdoHU3Qoh
         qNU6CoEzgJeZwosyv/BQVbkHUJHRCUFTkC/qYkiKf9HlgJgqofPuisX0jgdXfYA7h+7+
         ZQIqMCu52UmFUbhu+zgnsB+W/wZc55gqxM3Ql0F+BM85O/8cxIa/l8NgeCjf5Rm3fx6x
         vykA==
X-Gm-Message-State: APuU4Z/twKvH9MdSV+sT5oz65BuMxefi91YsVWujGKNtcVvpUe66v6Vl
	T2icTxhw28djdRWjSHmc6iN7rE9igcsPuQEt1ZFONHap1b+7KI0q/VuS3QN4Qg==
X-Gm-Gg: AZFdTZd0mb4lxO+vMtDKkEs6QtS4qTm6uCCOtq4fgmepE2epSCXPG/Pw2BLHOmJn+wh
	UrQx7oZcdsi6qugCurOaT7lYMya6Aueudjnb42esYW4AJc9KWiLvLEh0UHW7GL50f1FPrzSMdwC
	6zCQFvcilDEGbUlcHoBM1ONUKP+ETV6xLAR/P/hwADmh73RLOZHH904/m8UrDBsPWW/VLkPxgDU
	EYePFVtAFYSDOSSYBlzcTxQIJENjZ78a/c6M9qodlcRsMTka/5wisOZ1KRmrAMs/t7YG0cuh0Qo
	tzd3QMPKAltOVf06G1TfbzNiUP+ROS9nxF/F+hiHVlQ6iZOcnrg+bpvhs7HMEeAmFwS4gWfKk0M
	F41rjumlBtqS2rqgPIRC4RynIUuwo3wMJDE9iTgZc/xi1IXORbNWWUTK/hGQh8pf7ojnWJjztUp
	TTIvD2rkbMS+ARvhos3S/+ykyBdfgunNZooKu1kYVDtSSfCKvAR29h5OmgHrUgPSny+VxzRn5K7
	RgJsWRl/ZwROR+gSksTBPYJjlsq4JqhBl6i9re++j19tsC/v70Jt4+3sDTtgOE8DC4lx2P87Q43
	1vZv1xjSwhUnNe7GcBwZQtwh6rsFOxnSs3P/xsN1y8GZNOWe5nZWIyYVyt47kyHQdAu58S6khJT
	kCqSbxJESeyxu5KT41JW5MnNxBIsVv/TL4PKsk1hrvSyi6mH9G7DQQIblM0ZmAWGAJHQo5J7UkC
	YqpJ4=
X-Received: by 2002:a05:6122:9003:b0:5ee:b4a:681f with SMTP id 71dfb90a1353d-5ee8af6c710mr9894381e0c.20.1795624108676;
        Wed, 25 Nov 2026 08:28:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5cd7c8sm17985305e0c.11.2026.11.25.08.28.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/5] emulator/bthost: Add helpers to test security of deferred setup
Date: Wed, 25 Nov 2026 11:28:21 -0500
Message-ID: <20261125162825.1409753-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125162825.1409753-1-luiz.dentz@gmail.com>
References: <20261125162825.1409753-1-luiz.dentz@gmail.com>
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

