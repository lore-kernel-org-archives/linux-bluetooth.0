Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126525;
	b=NuMIfCgJUFrdJHU3Ls/xoZ03d4ThRXL/PJDJozp8bPuUtDpjzPpAwUTlMF+t7tu5TBf2
	 4Z9ahMfamvW8WgFQmhep4fARas3PsZuMLM9miAWvwtlVKpNvfyl688g+0JJn+/OMfJIXw
	 +IXlDdCyFVbJogLKQ8TDdZjS38pkef+baWY1iigUtjWXVOqQ91DiRoVfOUftcGy5j1z1c
	 W0aOxYfG9brMFjrxq7RojP1noZDBYCAbJjWdYU0K0MAoweg8x00A2gDpK4E3JRU4HqwEc
	 iyAlTiH4QMJdeL9NaKap/GLBi1nqZy3ebetnDSLVqaQvKBQz9vahdZ8PHPkfLiJVhMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uEd00lr1fzf+ocKY2NfY7cPQDO7a+Iv+4uO5pg6dNtA=;
	b=gs6o2S27oWVRHMoq5qSdl9cs5Vvl4KbPlg85d+PHvzPRQsoVKdopyMDkc1HXz6doYcX2
	 GBlsWDgLmy3Aa1hUtHjGd6gmi4r0IVqClvu3dEymgFDraWXtN8YdytyNbsxfBnDyHkajA
	 hMv/jfS2wgXjbUcENKBfGcfFOYjQyYTEspx7GuMuju5GSU/XAkNykQhjDdTfAFKeUCjmf
	 43Gzgm9Vk0pXifm4JBknT6pxdovwzfWk8s04HtkUrHzXsv51TsuUSkEX6+Enw4JpQFaOJ
	 AKAk6/+AWfMk353LMBLfYlX5cIF7vNYkWeH/Iajj983DDPQIUQhqXFJNen1IH2Ge0hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRa0WDnE;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C51606A325
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34C51606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRa0WDnE
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so106440137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795126524; x=1795731324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uEd00lr1fzf+ocKY2NfY7cPQDO7a+Iv+4uO5pg6dNtA=;
        b=yRa0WDnE6Nnl3GIPhdyyrDjn1l5qkRQc11C9qfpvWlU0HRMBih5AxGgpLXXov1Z7ZO
         80rolMeBTiYDH1TVWFQq3wWxVha5+jl0oXzWnrFpLsLUNfjMV4ZKzf6Z6tFkNc3dWzkL
         EnR0fuuEWv7E6n1nJYohxdRukLuWU4R00E0Amqyn9SNAyfqVbVRP0eBIERn/7HsNMPaM
         dJcuhqq0QEGglsWrbIW07I/HK6xfpUHBZjatcBzXbaUHfUGBtvje1dWzyMB0iTAsotms
         JhXUyDrPL5AFipmTvNXsSP1qvxBS3JluE4dpDYwovj7LFrDUEwn7d7g+rVvUKLHlZ2uW
         DMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126524; x=1795731324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uEd00lr1fzf+ocKY2NfY7cPQDO7a+Iv+4uO5pg6dNtA=;
        b=xAtXrQyltXo66PjWpXPnlQwS8UNL52q0ewJcn8oUb5had6y6MAyeoM0bvYCOt0RB/h
         /2OEIUVT0HbWLy4j+SrqaFpxqstERQg9HD3Z2WDgQa2OI/Oii+eXjURpsbV4Wo8SYosX
         GZ4xM3dF8fkw8rtCX+t30qBg/OJe+yzcRCShJNaDlX3gPZ784FVz7IVvC3DZEb2zn61m
         XaP9g2W4DrsMaxULzav91aFSQ5LWot03D49zJB9b4eJWVqvjN6AM9+LK1QvCLBY2yO9Z
         Vk0xNyWTB86H3KR1al/Xf7r7ZIeiADlhL0uLKk4G9a6J862aI2L2qa1+l3JxiRRRZqPE
         ouGA==
X-Gm-Message-State: APuU4Z8r81wvVui+sOTPzpv10XSy+99NFFIINsZopZRk2pbuy01sRPla
	CpA6f8XHJnMtr1oIT44wvy0SvVS/xwm+6t/25iK795zx5/FzQB3FJ41PeariujDg
X-Gm-Gg: AYBFou0Fl9rGD2SUKz034nAJJGVOi79Q3oVzoXZPNhJCaX0xTBspUB17twHN4bgvW1d
	LfHmDbLlf0ssEn/q+mWqf2w4Ufj+6ORDsZ/CClNh94QHjteeHHq6orDHHHBNrtZYC417cSYFHaI
	FmgqBapwX303vBLMaEF609LG2AtvjglgjzpIpGyr7UdvgDQ97FFUPAgoyRLkjUfM0By/48nw5H+
	wdepBHA0LLdAY6/fOCueVKsDBSEELxE7oHTydSKuv4/CBgVyAMmX/U5Mf0sWqYbf9czpoSD91qE
	6x/27VJoY9SJBeQb16FgTpabWnF9G5Qlj5Y9nahsJj4X+6GbotkCVvU/TeLCwMJUk6M29F84u0M
	FC87uTN8F5lklxQ/xrKnwg1mwG0SyXz62TMXsej8HdQ3G58hu+FVagMcZED6G3BSvVjqeU8eZQu
	UJnc/r/JI2s/Z+7KiTdlxKbnXcaohLW4Ep2LEIOaELn+wi1ylf+HwmBXtq0IyF3JgZauDxoiYqi
	j4qX/wqSKQkG+Qmu1L9t7UCzQQY7ryvdn4EL3F/yCbc6DYr4ZK0oQDKxt6MSxchcrPCHmSSz9S0
	pEpZKv0Zu5eGXWUcppQ7rOOFKEq5dFzmqzldTYTmk3LqVkAkbR7tgXOj/n3kLquPKUUXSKKXTrA
	KFP1nQ94jgTIs5PMTjUi3edUNHGjwE47J29HU77pUnWpF8K4s1azm1PKqyoNQVFFIy6uhtgqIMp
	pWrT8=
X-Received: by 2002:a67:e115:0:b0:7cc:21cd:9b46 with SMTP id ada2fe7eead31-7d739625daamr323105137.33.1795126523913;
        Thu, 19 Nov 2026 14:15:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec7cb5sm1268404241.2.2026.11.19.14.15.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:15:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] emulator/bthost: Add helpers to test security of deferred setup
Date: Thu, 19 Nov 2026 17:15:18 -0500
Message-ID: <20261119221520.1311381-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119221520.1311381-1-luiz.dentz@gmail.com>
References: <20261119221520.1311381-1-luiz.dentz@gmail.com>
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
 emulator/bthost.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  6 ++++
 2 files changed, 81 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index e65d29faa989..e5526aebf2ec 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -273,6 +273,11 @@ struct bthost {
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
@@ -1543,6 +1548,13 @@ static void evt_pin_code_request(struct bthost *bthost, const void *data,
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
 
@@ -1667,6 +1679,13 @@ static void evt_io_cap_request(struct bthost *bthost, const void *data,
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
@@ -2437,6 +2456,19 @@ static void handle_pending_l2reqs(struct bthost *bthost, struct btconn *conn,
 			continue;
 		}
 
+		/* Keep the request while the response is only pending */
+		if (bthost->l2cap_rsp_pending &&
+				code == BT_L2CAP_PDU_CONN_RSP &&
+				len >= sizeof(struct bt_l2cap_pdu_conn_rsp)) {
+			const struct bt_l2cap_pdu_conn_rsp *rsp = data;
+
+			if (le16_to_cpu(rsp->result) == 0x0001) {
+				req->cb(code, data, len, req->user_data);
+				curr = &req->next;
+				continue;
+			}
+		}
+
 		*curr = req->next;
 		req->cb(code, data, len, req->user_data);
 		free(req);
@@ -4276,6 +4308,49 @@ uint8_t bthost_get_auth_req(struct bthost *bthost)
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

