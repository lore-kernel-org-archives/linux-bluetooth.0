Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641124;
	b=j7yGZF3IuVEHIp9r3E/HLtDWfwdva6fBhlct7vwzUp8mET0jFAEh/+bYI0cZBt9qEGrO
	 FyUnPXTKUtc+H6plLi2RBwI59R5fJNvJFxJI4YBOkQIMAitCzZLKIxYtB5HuSe5IvZZsB
	 X9rdsmTLEh3ge9SJTgxcasVQC9mHz3stAC3LmyWvdvHNBs5idfQ7c+LGSOosw9QKpYgf6
	 g2EQU2fPazKXDM5Xr5duZQz3HCgFvKNRUPRjSg/wZpg5VCfI9hMaaKOVMspd1eeV3NgE3
	 c/FmH50MmStDoToWYpyU5fX5I+LeXHLTHeahbCFCLtBx4TSbEm/3+pabF/zZ5hix6iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yo1zfWREoru19VrkHrLf1MY2Z9cc9mLloe+2lhraxVA=;
	b=e2PnNs3579S/EVI/0U7JYUwa7rKy8+OVV1UvZ5L7XA6xuT23vM0SOPDNJmTC+21CZl/6
	 llmB3i0NVIyveVrn3FsGZu6pyl+ype41QNuJjUVQDRic72Ng9eWBS7HPn8bPc1cZI5jA9
	 /eBorW6/U85D7ihf0ug7bRzLb8LuFWJaj2cJGSSn4JBy0XYsrTQG/18f7oHCWe57rNmXR
	 bZyqbApK+syqrfAGLfG48sNtgdc1k3shkmCYZEkHlPhnUd3mXxgPhVIEnAbRDguORFQrT
	 WhWDyU2krHnTOfAJfW2yVCQb/1bSj3Y3Ry4+uP0/aNtpss2F6qwihB9ToNXrdZNLmkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0y6yvmH;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695C606A323
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7695C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0y6yvmH
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9906034086cso1738095241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641123; x=1796245923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yo1zfWREoru19VrkHrLf1MY2Z9cc9mLloe+2lhraxVA=;
        b=W0y6yvmHruzRCSjZ9AuiVMk6OMV0w5JCHOdUGCKzPb0IaayB42XbsDYw8Xx6+C4JVa
         U6LV/vGy7JqUX/H9vWcEWTu9Gn3gKvPrFwlQOL1KpRJM5gZR+g8M5d0wFmtJu7wWVFq1
         GwhjpsvaYpRwSHVYImd0dxwAKTKs5mcoYu9Psoktdfysx3KvZodwsTweAWT2CPO9sWkS
         z88ST9PwDIrajyKylJduVYqlym2t5ZyXPtLPGf9pUUih6t09uqjF3dNptfkRBGIe7rDN
         Tt1aMRrSGCAlu8gUXH+ZT8H6HiQrCYpofR2mCEMWlBP0TsvXOCuyK/azcJBdqxV5hDBN
         RJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641123; x=1796245923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Yo1zfWREoru19VrkHrLf1MY2Z9cc9mLloe+2lhraxVA=;
        b=2HSDK7gVMOdsBqK4wr++x6ELjuRlNhluEKCC0YPksNQryfh1YOCsMiQWhqk/h6eHOp
         wfQPu275fYiKqXQm4hmxa8c8uPFhzquUgCPUosrBQncDcpmuDuxPrwVK+MOmeRlfbCAi
         FYMPgo+XIqz1gi3c4VyJfeY44WVoVaB1iH+rUXGChUPQnBF8UUZm/S15EJN1fK4W6J+E
         E+lnyUnaKLIgofQDn6rMV01gjVqGFV9AZPVS/3X4XH5skvVbNxeQoE2NIWcv14KiVCHw
         1npEJYXXYKBDT+QTLKSl3X54oLMIrBktL2svJ+mGJ6ahLb1CMFfe9ETK3DptiztSVhXh
         Wd9A==
X-Gm-Message-State: APuU4Z8y+mJ7e9DwNWSe1Hx6hxJK/Gq7qaAkHNmQNcNt9/WapcWiCFY7
	NAzgZJ9ZcQoi3miHCfQroJ7Ryq7ngPJLlj+PoQh5fIgqtOIiyCK77OZeEdTqYA==
X-Gm-Gg: AZFdTZc/rQ+qS+hahML/FiNgL9489fNojwB+gOS2lAsxlwTGnTRqJk7UuagQ/IUXN+k
	ygCY2gDlHHwoPvUq3Q49foMC4fRh/7EDTzdBk47MrfbOz6ZPGj8ek2D7nHpm+60qbiu6ke3tzry
	Glpc/WoVAy040LogQ49ZvV2Q+z5OJzfv/jCzBXbXZTWHfRmuOc00/RIPliJmHPXQB8W4pBsbdTl
	Y7eKl9EHkPgHmLBotDb0HpeTkeDSNX7iBQHD8a/Fb9qHDn+koTCEQSwKKudUOeTowHEc6zk2DUa
	qqepLjz3xXaAsvp0qaDx+CWYFnkS0sfZsFi3igRXmDbo2xCrlIX6OOKRjK1Daqp6dcS6dgLjNGW
	OzySAF7TDDVXEWGZvECxPMfqHCSCpaXDQvYPqsSrID6vM3vPThvYBqffXr6bX4mrhzG2ySGE19g
	lyrOgDnEQTLhBLdhrchR1eDcM/4yPLNHT87lc/LO8JLR3x2NAxv894JxJCl9TwCDAYs7JAX/vvc
	nHTxmLD3Zp/QCIixQkYwuSoUotYIJMtrU6BTKmwtRDdiMj0kEL3tKCmh6UfKd096oqIzjJK+jnU
	/PFEKXlvOd0BpBvQ+JdaY/zP8nLe7bDdGvb26rJUkvlKUgTqMvrIKXtTQlu6N4ImyQOvDCKIfDS
	wh3DoR1y446zTRXnHihqun/hZuF4XgzhoaukSVVgJ+Irgsxn6KPOgO8Ty+ZQOBcZV0chXjhSsDC
	5nJ40=
X-Received: by 2002:a05:6102:f0a:b0:7d2:cdd6:6c8 with SMTP id ada2fe7eead31-7d73976426bmr9711226137.21.1795641123347;
        Wed, 25 Nov 2026 13:12:03 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e0686b1sm20199653241.10.2026.11.25.13.12.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/6] emulator/bthost: Add helpers to test security of deferred setup
Date: Wed, 25 Nov 2026 16:11:55 -0500
Message-ID: <20261125211200.1955466-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211200.1955466-1-luiz.dentz@gmail.com>
References: <20261125211200.1955466-1-luiz.dentz@gmail.com>
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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
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

